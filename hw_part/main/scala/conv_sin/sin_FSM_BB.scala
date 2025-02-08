package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class sin_FSM extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val clk       = Input(Clock())
    val rst_n      = Input(Bool())
    val cos_op_en = Input(Bool())
    val sin_op_en = Input(Bool())
    val index_inarray = Input(UInt(7.W))
    val data_in = Input(UInt(23.W))
    val Current_state = Output(UInt(5.W))
    val array1_in = Output(UInt(128.W))
    val array2_in = Output(UInt(128.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/sin_FSM.v")

}

class sin_FSM_BB extends Module {
  val io = IO(new Bundle() {
    val cos_op_en = Input(Bool())
    val sin_op_en = Input(Bool())
    val index_inarray = Input(UInt(7.W))
    val data_in = Input(UInt(23.W))
    val Current_state = Output(UInt(5.W))
    val array1_in = Output(UInt(128.W))
    val array2_in = Output(UInt(128.W))
  })

  val U_sin_FSM = Module(new sin_FSM)
  U_sin_FSM.io.clk := clock
  U_sin_FSM.io.rst_n := reset
  U_sin_FSM.io.cos_op_en := io.cos_op_en
  U_sin_FSM.io.sin_op_en := io.sin_op_en
  U_sin_FSM.io.index_inarray := io.index_inarray
  U_sin_FSM.io.data_in := io.data_in
  io.Current_state := U_sin_FSM.io.Current_state
  io.array1_in := U_sin_FSM.io.array1_in
  io.array2_in := U_sin_FSM.io.array2_in

}

object sin_FSM_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/sin_FSM_BB"), Seq(ChiselGeneratorAnnotation(() => new sin_FSM_BB)))
}
