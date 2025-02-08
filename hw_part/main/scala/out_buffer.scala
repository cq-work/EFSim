package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class out_buffer extends Module with dma_config with cim_config {
  val io = IO(new Bundle{
    val output_data_valid = Input(Bool())
    val output_to_dma = Vec(DMA_CH_WIDTH, new dmaWData_io(DMA_DATA_WIDTH))
    val sum_out = Input(Vec(tile_num*tile2pe_num*pe2array_num*unit_num,UInt(O_width.W)))
    val ofm_buffer_done = Output(Bool())
    val ofm_buffer_valid = Output(Vec(DMA_CH_WIDTH, UInt(1.W)))
  })
  val counter_width = tile_num * tile2pe_num * pe2array_num * unit_num *  O_width / (DMA_CH_WIDTH * DMA_DATA_WIDTH)
  val counter_ch = Reg(Vec(DMA_CH_WIDTH, UInt((log2Ceil(counter_width) + 1).W)))
  val ofm_buffer_done = Reg(Bool())
  val buffer_ready = Reg(Bool())

  when(counter_ch.forall(_ === counter_width.U)) {
    ofm_buffer_done := true.B
    buffer_ready := false.B
    for (num <- 0 until DMA_CH_WIDTH) {
      counter_ch(num) := 0.U
    }
  }.otherwise {
    when(ofm_buffer_done === true.B) {
      ofm_buffer_done := false.B
      for (num <- 0 until DMA_CH_WIDTH) {
        counter_ch(num) := 0.U
      }
    }.elsewhen(!io.output_to_dma(0).valid && !io.output_to_dma(1).valid){
      buffer_ready := true.B
    }.otherwise{
      ofm_buffer_done := false.B
      for (num <- 0 until DMA_CH_WIDTH) {
        when(buffer_ready && io.output_to_dma(num).valid && (counter_ch(num) < counter_width.U)) {
          counter_ch(num) := counter_ch(num) + 1.U
        }.otherwise {
          counter_ch(num) := counter_ch(num)
        }
      }
    }
  }
  io.ofm_buffer_done := ofm_buffer_done

  val ofm_spram_wrap = (Seq.fill(DMA_CH_WIDTH)(VecInit(Seq.fill(tile_num * tile2pe_num * pe2array_num * unit_num / DMA_CH_WIDTH)(Module(new SPRAM(O_width, 1, "block")).io))))
  val output_data = Wire(Vec(DMA_CH_WIDTH, Vec(tile_num * tile2pe_num * pe2array_num * unit_num * O_width / (DMA_CH_WIDTH*DMA_DATA_WIDTH), UInt(DMA_DATA_WIDTH.W))))
  val counter_fix = Reg(Vec(DMA_CH_WIDTH, UInt((log2Ceil(counter_width) + 1).W)))

  for (num0 <- 0 until DMA_CH_WIDTH) {
    io.ofm_buffer_valid(num0) := Mux((counter_ch(num0) > 0.U) && !(counter_fix(num0) === counter_ch(num0)), 1.U, 0.U)
//    io.ofm_buffer_valid(num0) := 0.U
    for (num <- 0 until tile_num * tile2pe_num * pe2array_num * unit_num / DMA_CH_WIDTH) {
      ofm_spram_wrap(num0)(num).CLK := clock
      ofm_spram_wrap(num0)(num).CEN := 0.U
      ofm_spram_wrap(num0)(num).WEN := ~io.output_data_valid
      ofm_spram_wrap(num0)(num).A := 0.U
      ofm_spram_wrap(num0)(num).D := io.sum_out(num + num0 * tile_num * tile2pe_num * pe2array_num * unit_num / DMA_CH_WIDTH)
    }
    for (num <- 0 until tile_num * tile2pe_num * pe2array_num * unit_num * O_width / (DMA_CH_WIDTH * DMA_DATA_WIDTH)) {
      output_data(num0)(num) := Cat(Seq.tabulate(DMA_DATA_WIDTH / O_width)(i => ofm_spram_wrap(num0)(DMA_DATA_WIDTH / O_width - 1 - i + num * DMA_DATA_WIDTH / O_width).Q))
    }
    counter_fix(num0) := counter_ch(num0)
    io.output_to_dma(num0).data := output_data(num0)(counter_fix(num0))
  }
}


object out_buffer_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/out_buffer"), Seq(ChiselGeneratorAnnotation(() => new out_buffer)))
}