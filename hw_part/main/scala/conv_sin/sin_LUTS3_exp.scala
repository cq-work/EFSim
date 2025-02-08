package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._
class sin_LUTS3_exp extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val index = Input(UInt(13.W))
    val s_exp = Output(UInt(8.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_LUTS3_exp.v")

}

class sin_LUTS3_exp_BB extends Module {
  val io = IO(new Bundle() {
    val index = Input(UInt(13.W))
    val s_exp = Output(UInt(8.W))
  })

  val U_sin_LUTS3_exp = Module(new sin_LUTS3_exp)
  U_sin_LUTS3_exp.io.index := io.index
  io.s_exp := U_sin_LUTS3_exp.io.s_exp

}

object sin_LUTS3_exp_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_LUTS3_exp_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_LUTS3_exp_BB)))
}