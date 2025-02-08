package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._
class sin_count_zero extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val f34      = Input(UInt(36.W))
    val num_zero = Output(UInt(6.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_count_zero.sv")

}

class sin_count_zero_BB extends Module {
  val io = IO(new Bundle() {
    val f34 = Input(UInt(36.W))
    val num_zero = Output(UInt(6.W))
  })

  val U_sin_count_zero = Module(new sin_count_zero)
  U_sin_count_zero.io.f34 := io.f34
  io.num_zero := U_sin_count_zero.io.num_zero

}

object sin_count_zero_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_count_zero_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_count_zero_BB)))
}
