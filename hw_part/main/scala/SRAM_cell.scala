package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._
class SRAM_cell extends Module {
  val io = IO(new Bundle {
    val WL = Input(Bool())
    val BL = Input(Bool())
    val IN = Input(Bool())

    val OUT = Output(Bool())
  })
  val data = Reg(Bool())
  val data_out = Reg(Bool())
  when(io.WL) {
    data := io.BL
    data_out := false.B
  }.otherwise{
    data := data
    data_out := data
  }
//  io.OUT := io.IN & data
  io.OUT := io.IN & data_out
}

object SRAM_cell_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/test"),Seq(ChiselGeneratorAnnotation(()=>new SRAM_cell)))
}
