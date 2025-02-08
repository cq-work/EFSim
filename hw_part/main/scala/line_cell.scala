package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//Generates a single-column cells with a configurable array_row.
class line_cell extends Module with cim_config {
  val io = IO(new Bundle {
    val WL = Input(UInt(array_row.W))
    val IN = Input(UInt(array_row.W))
    val BL = Input(UInt(1.W))

    val Vout = Output(Vec(array_row,UInt(1.W)))
  })

  //val data = Reg(Vec(array_row,Bool()))
  val data = Reg(Vec(array_row,Bool()))
//  val data = Seq.fill(array_row)(RegInit(false.B))
  val data_out = Reg(Vec(array_row,Bool()))

  for (i <- 0 until array_row){
    when(io.WL(i)) {
      data(i) := io.BL
      data_out(i) := false.B
    }.otherwise {
      data(i) := data(i)
      data_out(i) := data(i)
    }
    io.Vout(i) := io.IN(i) & data_out(i)

  }



}

object line_cell_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/line_cell"), Seq(ChiselGeneratorAnnotation(() => new line_cell)))
}