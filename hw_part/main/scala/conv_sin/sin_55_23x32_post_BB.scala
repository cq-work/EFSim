package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class sin_55_23x32_post extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val clk       = Input(Clock())
    val d1_in = Input(UInt(32.W))
    val d2_in = Input(UInt(32.W))
    val Current_state = Input(UInt(5.W))
    val dout_valid = Output(Bool())
    val sum1 = Output(UInt(55.W))
    val sum2 = Output(UInt(55.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_55_23x32_post.v")

}

class sin_55_23x32_post_BB extends Module {
  val io = IO(new Bundle() {
    val d1_in = Input(UInt(32.W))
    val d2_in = Input(UInt(32.W))
    val Current_state = Input(UInt(5.W))
    val dout_valid = Output(Bool())
    val sum1 = Output(UInt(55.W))
    val sum2 = Output(UInt(55.W))
  })

  val U_sin_55_23x32_post = Module(new sin_55_23x32_post)
  U_sin_55_23x32_post.io.clk := clock
  U_sin_55_23x32_post.io.d1_in := io.d1_in
  U_sin_55_23x32_post.io.d2_in := io.d2_in
  U_sin_55_23x32_post.io.Current_state := io.Current_state
  io.dout_valid := U_sin_55_23x32_post.io.dout_valid
  io.sum1 := U_sin_55_23x32_post.io.sum1
  io.sum2 := U_sin_55_23x32_post.io.sum2

}

object sin_55_23x32_post_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_55_23x32_post_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_55_23x32_post_BB)))
}
