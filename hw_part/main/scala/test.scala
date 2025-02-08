import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
class MyCircuit extends Module {
  val io = IO(new Bundle {
    // Define your input and output ports here
    val in  = Input(UInt(4.W))
    val out = Output(UInt(4.W))
  })

  // Your circuit logic here, without reset
  val reg = RegInit(0.U(4.W))
  reg := io.in
  io.out := reg
}

object MyCircuitMain extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test"), Seq(ChiselGeneratorAnnotation(() => new MyCircuit)))
}
