package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class CIM_before extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val clk       = Input(Clock())
    val rst_n      = Input(Bool())
    val cos_op_en = Input(Bool())
    val sin_op_en = Input(Bool())
    val cos_rb = Input(UInt(32.W))
    val sin_rb = Input(UInt(32.W))
    val Sign_out = Output(Bool())
    val cs = Output(Bool())
    val f34_zero_flag = Output(Bool())
    val F1 = Output(Bool())
    val index_out = Output(UInt(13.W))
    val data_in = Output(UInt(23.W))
    val OF_flag = Output(Bool())
    val U_flag = Output(Bool())
    val num_zero = Output(UInt(6.W))
    val SR1 = Output(UInt(8.W))
    val SR2 = Output(UInt(8.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/CIM_before.sv")
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_count_zero.sv")
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_LUTC3_exp.v")
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_LUTS3_exp.v")

}

class CIM_before_BB extends Module {
  val io = IO(new Bundle() {
    val cos_op_en = Input(Bool())
    val sin_op_en = Input(Bool())
    val cos_rb = Input(UInt(32.W))
    val sin_rb = Input(UInt(32.W))
    val Sign_out = Output(Bool())
    val cs = Output(Bool())
    val f34_zero_flag = Output(Bool())
    val F1 = Output(Bool())
    val index_out = Output(UInt(13.W))
    val data_in = Output(UInt(23.W))
    val OF_flag = Output(Bool())
    val U_flag = Output(Bool())
    val num_zero = Output(UInt(6.W))
    val SR1 = Output(UInt(8.W))
    val SR2 = Output(UInt(8.W))
  })

  val U_CIM_before = Module(new CIM_before)
  U_CIM_before.io.clk   := clock
  U_CIM_before.io.rst_n := reset
  U_CIM_before.io.sin_rb := io.sin_rb
  U_CIM_before.io.sin_op_en := io.sin_op_en
  U_CIM_before.io.cos_rb := io.cos_rb
  U_CIM_before.io.cos_op_en := io.cos_op_en
  io.Sign_out := U_CIM_before.io.Sign_out
  io.cs := U_CIM_before.io.cs
  io.f34_zero_flag := U_CIM_before.io.f34_zero_flag
  io.F1 := U_CIM_before.io.F1
  io.index_out := U_CIM_before.io.index_out
  io.data_in := U_CIM_before.io.data_in
  io.OF_flag := U_CIM_before.io.OF_flag
  io.U_flag := U_CIM_before.io.U_flag
  io.num_zero := U_CIM_before.io.num_zero
  io.SR1 := U_CIM_before.io.SR1
  io.SR2 := U_CIM_before.io.SR2
}

object CIM_before_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/CIM_before_BB"), Seq(ChiselGeneratorAnnotation(() => new CIM_before_BB)))
}