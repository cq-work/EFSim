package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._


class ConV_FSM extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val clk       = Input(Clock())
    val rst_n      = Input(Bool())
    val din_valid = Input(Bool())
    val Current_state = Output(UInt(5.W))
    val dout_valid_ConV = Output(Bool())
  })

  addPath("./src/main/hdl/conv_sin/ConV/ConV_FSM.v")

}


class ConV_FSM_BB extends Module {
  val io = IO(new Bundle() {
    val din_valid = Input(Bool())
    val Current_state = Output(UInt(5.W))
    val dout_valid_ConV = Output(Bool())
  })

  val U_ConV_FSM = Module(new ConV_FSM)
  U_ConV_FSM.io.clk := clock
  U_ConV_FSM.io.rst_n := reset
  U_ConV_FSM.io.din_valid := io.din_valid
  io.Current_state := U_ConV_FSM.io.Current_state
  io.dout_valid_ConV := U_ConV_FSM.io.dout_valid_ConV
}

object ConV_FSM_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/ConV_FSM_BB"), Seq(ChiselGeneratorAnnotation(() => new ConV_FSM_BB)))
}
