package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class wgt_buffer extends Module with dma_config with cim_config with adder_tree_config {
  val io = IO(new Bundle() {
    val wgt_data_valid = Input(Bool())
    val dma_to_wgtbuffer = Vec(DMA_CH_WIDTH, new dmaRData_io(DMA_DATA_WIDTH))
    val buffer_to_BL = Output(Vec(tile_num*tile2pe_num*pe2array_num,UInt(array_col.W)))
    val buffer_to_WL = Output(UInt(array_row.W))
    val wgt_buffer_done = Output(Bool())
    val test3 = Output(Bool())
    val test6 = Output(Bool())
    val test9 = Output(Bool())
    val test12 = Output(Bool())
    val test15 = Output(Bool())
  })

  val dma_to_wgtbuffer = RegInit(VecInit(Seq.fill(DMA_CH_WIDTH)(false.B)))
  val dma_width = tile_num * tile2pe_num * pe2array_num * array_col / (DMA_CH_WIDTH * DMA_DATA_WIDTH)
  val dma_cnt = RegInit(VecInit(Seq.fill(DMA_CH_WIDTH) (0.U((log2Ceil(dma_width)+1).W))))
  val dma_cnt_fix = RegInit(VecInit(Seq.fill(DMA_CH_WIDTH) (0.U((log2Ceil(dma_width)+1).W))))
  val WL_cnt = RegInit(0.U((log2Ceil(array_row)+1).W))
  val buffer_to_WL = Reg(UInt(array_row.W))
  val BL = VecInit(Seq.fill(DMA_CH_WIDTH*2) (Reg(Vec(tile_num*tile2pe_num*pe2array_num/DMA_CH_WIDTH,UInt(array_col.W)))))     // *2 is pipeline

  for (num0 <- 0 until DMA_CH_WIDTH) {
    dma_cnt_fix(num0) := dma_cnt(num0)
    dma_to_wgtbuffer(num0) := io.dma_to_wgtbuffer(num0).valid
    for (num <- 0 until tile_num * tile2pe_num * pe2array_num / DMA_CH_WIDTH) {
      io.buffer_to_BL(num + num0 * tile_num * tile2pe_num * pe2array_num / DMA_CH_WIDTH) := Mux(dma_cnt_fix(num0)(log2Ceil(dma_width)), BL(num0)(num), BL(num0+DMA_CH_WIDTH)(num))
    }
  }

  when(io.wgt_data_valid) {
    for (num <- 0 until DMA_CH_WIDTH) {
      dma_cnt(num) := Mux(dma_to_wgtbuffer(num), dma_cnt(num) + 1.U, dma_cnt(num))
    }
    when(dma_cnt.forall((x: UInt) => x === dma_width.U) && (dma_cnt(0) =/= dma_cnt_fix(0))) {
      WL_cnt := WL_cnt + 1.U
      buffer_to_WL := 1.U << WL_cnt
    }.elsewhen(dma_cnt.forall((x: UInt) => x === 0.U) && (WL_cnt =/= 0.U) && (dma_cnt(0) =/= dma_cnt_fix(0))) {
      WL_cnt := WL_cnt + 1.U
      buffer_to_WL := 1.U << WL_cnt
    }.otherwise {
      buffer_to_WL := 0.U
    }
  }.otherwise {
    when(WL_cnt(log2Ceil(array_row))) {
      WL_cnt := 0.U
      buffer_to_WL := 0.U
    }.otherwise {
      buffer_to_WL := 0.U
    }
  }

  val test1 = Mux(WL_cnt === 56.U, 1.U, 0.U)
  val test2 = RegNext(test1)
  io.test3 := (test1 & test2)

  val test4 = Mux(WL_cnt === 57.U, 1.U, 0.U)
  val test5 = RegNext(test4)
  io.test6 := (test4 & test5)

  val test7 = Mux(WL_cnt === 58.U, 1.U, 0.U)
  val test8 = RegNext(test7)
  io.test9 := (test7 & test8)

  val test10 = Mux(WL_cnt === 59.U, 1.U, 0.U)
  val test11 = RegNext(test10)
  io.test12 := (test10 & test11)

  val test13 = Mux(WL_cnt === 60.U, 1.U, 0.U)
  val test14 = RegNext(test13)
  io.test15 := (test13 & test14)

  io.wgt_buffer_done := Mux(io.wgt_data_valid && WL_cnt(log2Ceil(array_row)), true.B, false.B)
  io.buffer_to_WL := buffer_to_WL

  val wgt_spram_wrap = (Seq.fill(DMA_CH_WIDTH*2) (VecInit(Seq.fill(tile_num*tile2pe_num*pe2array_num/DMA_CH_WIDTH)(Module(new SPRAM(array_col, 1, "block")).io))))

  for (num0 <- 0 until DMA_CH_WIDTH*2) {
    for (num <- 0 until tile_num*tile2pe_num*pe2array_num/DMA_CH_WIDTH) {
      wgt_spram_wrap(num0)(num).CLK := clock
      wgt_spram_wrap(num0)(num).CEN := 0.U
      wgt_spram_wrap(num0)(num).WEN := (!dma_to_wgtbuffer(num0%DMA_CH_WIDTH)) || (!((num/(DMA_DATA_WIDTH/array_col)+num0/DMA_CH_WIDTH*dma_width).U === dma_cnt(num0%DMA_CH_WIDTH)))
      wgt_spram_wrap(num0)(num).A := 0.U
      wgt_spram_wrap(num0)(num).D := io.dma_to_wgtbuffer(num0%DMA_CH_WIDTH).data(num%(DMA_DATA_WIDTH/array_col)*array_col+array_col-1, num%(DMA_DATA_WIDTH/array_col)*array_col)
      BL(num0)(num) := wgt_spram_wrap(num0)(num).Q
    }
  }
}

object wgt_buffer_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/wgt_buffer"), Seq(ChiselGeneratorAnnotation(() => new wgt_buffer)))
}