package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class SPRAM(data_width: Int, depth: Int, ram_style: String)
  extends BlackBox(Map("DATA_WIDTH" -> data_width, "DEPTH" -> depth, "RAM_STYLE_VAL" -> ram_style)) with HasBlackBoxPath {
  val io = IO(new Bundle {
    val CLK = Input(Clock())
    val CEN = Input(Bool())
    val WEN = Input(Bool()) //0:W 1:R
    val A   = Input(UInt(log2Ceil(depth).W))
    val D   = Input(UInt(data_width.W))
    val Q   = Output(UInt(data_width.W))
  })

  addPath("./src/main/hdl/SPRAM.v")
}
object SPRAM {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new SPRAM(data_width, depth, ram_style)).io
}

//class SPRAM(data_width: Int, depth: Int, ram_style: String) extends Module {
//  val io = IO(new Bundle {
////    val clock = Input(Clock())
//    val CEN    = Input(Bool())
//    val WEN    = Input(Bool()) //0:W 1:R
//    val A  = Input(UInt(log2Ceil(depth).W))
//    val D = Input(UInt(data_width.W))
//    val Q = Output(UInt(data_width.W))
//  })
//  val spram = Module(new SPRAM_blackbox(data_width, depth, ram_style))
//  spram.io.CLK := clock
//  spram.io.CEN <> io.CEN
//  spram.io.WEN <> io.WEN
//  spram.io.A   <> io.A
//  spram.io.D   <> io.D
//  spram.io.Q   <> io.Q
//}
//object SPRAM_gen extends App {
//  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/SPRAM"), Seq(ChiselGeneratorAnnotation(() => Module(new SPRAM(32,4,"block")))))
//}