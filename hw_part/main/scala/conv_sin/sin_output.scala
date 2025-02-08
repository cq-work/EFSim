package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class sin_output extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
//    val clk   = Input(Clock())
    val rst_n = Input(Bool())
    val SR1 = Input(UInt(8.W))
    val SR2 = Input(UInt(8.W))
    val sum1 = Input(UInt(55.W))
    val sum2 = Input(UInt(55.W))
    val num_zero = Input(UInt(6.W))
    val reg_F1_3 = Input(Bool())
    val dout_valid = Input(Bool())
    val Sign_out = Input(Bool())
    val reg_czero_flag3 = Input(Bool())
    val cs = Input(Bool())
    val OF_flag = Input(Bool())
    val U_flag = Input(Bool())
    val cos_ra = Output(UInt(32.W))
    val sin_ra = Output(UInt(32.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_output.sv")

}

class sin_output_BB extends Module {
  val io = IO(new Bundle() {
    val SR1 = Input(UInt(8.W))
    val SR2 = Input(UInt(8.W))
    val sum1 = Input(UInt(55.W))
    val sum2 = Input(UInt(55.W))
    val num_zero = Input(UInt(6.W))
    val reg_F1_3 = Input(Bool())
    val dout_valid = Input(Bool())
    val Sign_out = Input(Bool())
    val reg_czero_flag3 = Input(Bool())
    val cs = Input(Bool())
    val OF_flag = Input(Bool())
    val U_flag = Input(Bool())
    val cos_ra = Output(UInt(32.W))
    val sin_ra = Output(UInt(32.W))
  })

  val U_sin_output = Module(new sin_output)
//  U_sin_output.io.clk := clock
  U_sin_output.io.rst_n := reset
  U_sin_output.io.SR1 := io.SR1
  U_sin_output.io.SR2 := io.SR2
  U_sin_output.io.sum1 := io.sum1
  U_sin_output.io.sum2 := io.sum2
  U_sin_output.io.num_zero := io.num_zero
  U_sin_output.io.reg_F1_3 := io.reg_F1_3
  U_sin_output.io.dout_valid := io.dout_valid
  U_sin_output.io.Sign_out := io.Sign_out
  U_sin_output.io.reg_czero_flag3 := io.reg_czero_flag3
  U_sin_output.io.cs := io.cs
  U_sin_output.io.OF_flag := io.OF_flag
  U_sin_output.io.U_flag := io.U_flag
  io.cos_ra := U_sin_output.io.cos_ra
  io.sin_ra := U_sin_output.io.sin_ra

}

object sin_output_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_output_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_output_BB)))
}