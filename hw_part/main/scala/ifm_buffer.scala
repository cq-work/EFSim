package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class ifm_buffer extends Module with dma_config with cim_config with adder_tree_config {
  val io = IO(new Bundle() {
    val input_data_valid = Input(Bool())
    val dma_to_buffer = Vec(DMA_CH_WIDTH, new dmaRData_io(DMA_DATA_WIDTH))
    val din_valid_ConV = Input(Bool())
    val dout_valid_ConV = Input(Bool())
    val buffer_to_input = Output(Vec(tile_num * tile2pe_num, UInt(array_row.W)))
    val ifm_buffer_ready = Output(Bool())
  })

  val dma_to_buffer = RegInit(VecInit(Seq.fill(DMA_CH_WIDTH)(false.B)))
  val counter_width = tile_num * tile2pe_num * array_row * DATA_WIDTH / (DMA_CH_WIDTH * DMA_DATA_WIDTH)
  val counter_ch = RegInit(VecInit(Seq.fill(DMA_CH_WIDTH)(0.U((log2Ceil(counter_width) + 1).W))))
  val input_state_ready = if (pipeline) RegInit(false.B) else RegInit(true.B)

  for (num <- 0 until DMA_CH_WIDTH) {
    dma_to_buffer(num) := io.dma_to_buffer(num).valid
    counter_ch(num) := Mux(dma_to_buffer(num) && (counter_ch(num) < counter_width.U) && io.input_data_valid, counter_ch(num) + 1.U, counter_ch(num))
  }

  when(io.dout_valid_ConV) {
    input_state_ready := io.dout_valid_ConV
  }

  val counter_out = RegInit((math.pow(2, log2Ceil(DATA_WIDTH) + 1) - 1).toInt.U((log2Ceil(DATA_WIDTH) + 1).W))
  val counter_out_fix = RegInit((math.pow(2, log2Ceil(DATA_WIDTH) + 1) - 1).toInt.U((log2Ceil(DATA_WIDTH) + 1).W))
  val self_buffer_to_input_valid = RegInit(false.B)

  self_buffer_to_input_valid := Mux(counter_ch.forall(_ === counter_width.U), 1.B, 0.B)
  io.ifm_buffer_ready := self_buffer_to_input_valid

  when(self_buffer_to_input_valid && input_state_ready && io.din_valid_ConV) {
    when(counter_out =/= DATA_WIDTH.U) {
      counter_out := counter_out + 1.U
    }.otherwise {
      counter_out := (math.pow(2, log2Ceil(DATA_WIDTH) + 1) - 1).toInt.U
      counter_ch.foreach(ele => ele := 0.U)
      input_state_ready := 0.U
    }
  }
  counter_out_fix := counter_out

  val cen_ch = VecInit(Seq.fill(DMA_CH_WIDTH)(WireInit(false.B)))
  for (num <- 0 until DMA_CH_WIDTH) {
    cen_ch(num) := Mux(counter_ch(num) >= (counter_width - 1).U, false.B, ~dma_to_buffer(num))
  }

  val spram_wrap = (Seq.fill(DMA_CH_WIDTH)(VecInit(Seq.fill(tile_num * tile2pe_num * DATA_WIDTH / DMA_CH_WIDTH)(Module(new SPRAM(array_row, 1, "block")).io))))

  for (num0 <- 0 until DMA_CH_WIDTH) {
    for (num <- 0 until tile_num * tile2pe_num * DATA_WIDTH / DMA_CH_WIDTH) {
      spram_wrap(num0)(num).CLK := clock
      spram_wrap(num0)(num).CEN := cen_ch(num0)
      spram_wrap(num0)(num).WEN := self_buffer_to_input_valid || (!((num / (DMA_DATA_WIDTH / array_row)).U === counter_ch(num0)))
      spram_wrap(num0)(num).A := 0.U
      spram_wrap(num0)(num).D := io.dma_to_buffer(num0).data(num % (DMA_DATA_WIDTH / array_row) * array_row + array_row - 1, num % (DMA_DATA_WIDTH / array_row) * array_row)
    }
  }



  val counter_out_cnt = Wire(UInt(log2Ceil(DATA_WIDTH).W))
  counter_out_cnt := counter_out_fix(log2Ceil(DATA_WIDTH) - 1, 0)

  for (num <- 0 until tile_num * tile2pe_num) {
    io.buffer_to_input(num) := spram_wrap(num / (tile_num * tile2pe_num / DMA_CH_WIDTH))((num % (tile_num * tile2pe_num / DMA_CH_WIDTH)).U + counter_out_cnt * ((tile_num * tile2pe_num / DMA_CH_WIDTH)).U).Q
  }
}

object ifm_buffer_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/ifm_buffer"), Seq(ChiselGeneratorAnnotation(() => new ifm_buffer)))
}