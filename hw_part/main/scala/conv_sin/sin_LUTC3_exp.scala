package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._
class sin_LUTC3_exp extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val index = Input(UInt(13.W))
    val c_exp = Output(UInt(8.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_LUTC3_exp.v")

}

class sin_LUTC3_exp_BB extends Module {
  val io = IO(new Bundle() {
    val index = Input(UInt(13.W))
    val c_exp = Output(UInt(8.W))
  })

  val U_sin_LUTC3_exp = Module(new sin_LUTC3_exp)
  U_sin_LUTC3_exp.io.index := io.index
  io.c_exp := U_sin_LUTC3_exp.io.c_exp

}

object sin_LUTC3_exp_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_LUTC3_exp_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_LUTC3_exp_BB)))
}