package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_8x8_PE.scala: Add&Shifter the data from PEs. The output for ConV algorithm
class ConV_8x8_PE extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val d_in = Input(Vec(unit_num * pe2array_num, UInt(RESULT_WIDTH.W)))
    val Current_state = Input(UInt(5.W))

    val sum = Output(Vec(unit_num * pe2array_num, UInt(32.W)))
  })

  val U_ConV_8x8_Array = VecInit(Seq.fill(pe2array_num)(Module(new ConV_8x8_Array).io))

  for (num <- 0 until pe2array_num) {
    U_ConV_8x8_Array(num).Current_state := io.Current_state
    for (num1 <- 0 until unit_num) {
      U_ConV_8x8_Array(num).d_in(num1) := io.d_in(num1 + num*unit_num)
      io.sum(num1 + num*unit_num) := U_ConV_8x8_Array(num).sum(num1)
    }
  }
}
object ConV_8x8_PE_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/ConV_8x8_PE"), Seq(ChiselGeneratorAnnotation(() => new ConV_8x8_PE)))
}