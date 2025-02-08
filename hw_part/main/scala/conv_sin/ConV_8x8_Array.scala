package conv_sin

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_8x8_Array.scala: Add&Shifter the data from Arrays. The output for ConV algorithm
class ConV_8x8_Array extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val d_in          = Input(Vec(unit_num,UInt(RESULT_WIDTH.W)))
    val Current_state = Input(UInt(5.W))

    val sum = Output(Vec(unit_num,UInt(32.W)))
  })

  val U_ConV_8x8 = VecInit(Seq.fill(unit_num) (Module (new ConV_8x8).io))

  for (num <- 0 until unit_num){
    U_ConV_8x8(num).d_in := io.d_in(num)
    U_ConV_8x8(num).Current_state := io.Current_state
    io.sum(num) := U_ConV_8x8(num).OUT
  }
}
object ConV_8x8_Array_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/conv_sin/ConV_8x8_Array"),Seq(ChiselGeneratorAnnotation(()=>new ConV_8x8_Array)))
}
