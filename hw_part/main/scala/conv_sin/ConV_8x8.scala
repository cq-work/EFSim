package conv_sin

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_8x8.scala: Add&Shifter the data from unit. The output for ConV algorithm(This unit can only be 8 columns to a unit.)
class ConV_8x8 extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val d_in          = Input(UInt(RESULT_WIDTH.W))
    val Current_state = Input(UInt(5.W))

    val OUT = Output(UInt(O_width.W))   //O_width = 32
  })

  val d_out = Wire(UInt(22.W))
  when(io.Current_state === 8.U){
    d_out := Cat(0.U(7.W),io.d_in)
  }.elsewhen(io.Current_state === 9.U){
    d_out := Cat(0.U(6.W),io.d_in,0.U(1.W))
  }.elsewhen(io.Current_state === 10.U) {
    d_out := Cat(0.U(5.W), io.d_in, 0.U(2.W))
  }.elsewhen(io.Current_state === 11.U) {
    d_out := Cat(0.U(4.W), io.d_in, 0.U(3.W))
  }.elsewhen(io.Current_state === 12.U) {
    d_out := Cat(0.U(3.W), io.d_in, 0.U(4.W))
  }.elsewhen(io.Current_state === 13.U) {
    d_out := Cat(0.U(2.W), io.d_in, 0.U(5.W))
  }.elsewhen(io.Current_state === 14.U) {
    d_out := Cat(0.U(1.W), io.d_in, 0.U(6.W))
  }.elsewhen(io.Current_state === 15.U) {
    d_out := Cat(io.d_in, 0.U(7.W))
  }.otherwise{
    d_out := 0.U(21.W)
  }

  val OUT = Reg(UInt(O_width.W))

  when(io.Current_state === 16.U){
    OUT := OUT + d_out
  }.elsewhen(io.Current_state >= 8.U) {
    OUT := OUT + d_out
  }.elsewhen(io.Current_state === 0.U) {
    OUT := 0.U(O_width.W)
  }.otherwise {
    OUT := OUT
  }
  io.OUT := OUT

}



object ConV_8x8_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/conv_sin/ConV_8x8"),Seq(ChiselGeneratorAnnotation(()=>new ConV_8x8)))
}
