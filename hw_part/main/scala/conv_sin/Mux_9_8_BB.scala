package conv_sin

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._


class Mux_9_8 extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle() {
    val index_outarray = Input(UInt(2.W))
    val out1_0 = Input(UInt(8.W))
    val out1_1 = Input(UInt(8.W))
    val out1_2 = Input(UInt(8.W))
    val out1_3 = Input(UInt(8.W))
    val out1_4 = Input(UInt(8.W))
    val out1_5 = Input(UInt(8.W))
    val out1_6 = Input(UInt(8.W))
    val out1_7 = Input(UInt(8.W))
    val out1_8 = Input(UInt(8.W))
    val out1_9 = Input(UInt(8.W))
    val out1_10 = Input(UInt(8.W))
    val out1_11 = Input(UInt(8.W))
    val out1_12 = Input(UInt(8.W))
    val out1_13 = Input(UInt(8.W))
    val out1_14 = Input(UInt(8.W))
    val out1_15 = Input(UInt(8.W))
    val out2_0 = Input(UInt(8.W))
    val out2_1 = Input(UInt(8.W))
    val out2_2 = Input(UInt(8.W))
    val out2_3 = Input(UInt(8.W))
    val out2_4 = Input(UInt(8.W))
    val out2_5 = Input(UInt(8.W))
    val out2_6 = Input(UInt(8.W))
    val out2_7 = Input(UInt(8.W))
    val out2_8 = Input(UInt(8.W))
    val out2_9 = Input(UInt(8.W))
    val out2_10 = Input(UInt(8.W))
    val out2_11 = Input(UInt(8.W))
    val out2_12 = Input(UInt(8.W))
    val out2_13 = Input(UInt(8.W))
    val out2_14 = Input(UInt(8.W))
    val out2_15 = Input(UInt(8.W))
    val Mul1 = Output(UInt(32.W))
    val Mul2 = Output(UInt(32.W))
  })
  addPath("./src/main/hdl/conv_sin/sin_cos_all/Mux_9_8.v")

}


class Mux_9_8_BB extends Module {
  val io = IO(new Bundle() {
    val index_outarray = Input(UInt(2.W))
    val out = Input(Vec(32,UInt(8.W)))
    val Mul1 = Output(UInt(32.W))
    val Mul2 = Output(UInt(32.W))
  })

  val U_Mux_9_8 = Module(new Mux_9_8)
  U_Mux_9_8.io.index_outarray := io.index_outarray
  U_Mux_9_8.io.out1_0  := io.out(0)
  U_Mux_9_8.io.out1_1  := io.out(1 )
  U_Mux_9_8.io.out1_2  := io.out(2 )
  U_Mux_9_8.io.out1_3  := io.out(3 )
  U_Mux_9_8.io.out1_4  := io.out(4 )
  U_Mux_9_8.io.out1_5  := io.out(5 )
  U_Mux_9_8.io.out1_6  := io.out(6 )
  U_Mux_9_8.io.out1_7  := io.out(7 )
  U_Mux_9_8.io.out1_8  := io.out(8 )
  U_Mux_9_8.io.out1_9  := io.out(9 )
  U_Mux_9_8.io.out1_10 := io.out(10)
  U_Mux_9_8.io.out1_11 := io.out(11)
  U_Mux_9_8.io.out1_12 := io.out(12)
  U_Mux_9_8.io.out1_13 := io.out(13)
  U_Mux_9_8.io.out1_14 := io.out(14)
  U_Mux_9_8.io.out1_15 := io.out(15)
  U_Mux_9_8.io.out2_0  := io.out(16)
  U_Mux_9_8.io.out2_1  := io.out(17)
  U_Mux_9_8.io.out2_2  := io.out(18)
  U_Mux_9_8.io.out2_3  := io.out(19)
  U_Mux_9_8.io.out2_4  := io.out(20)
  U_Mux_9_8.io.out2_5  := io.out(21)
  U_Mux_9_8.io.out2_6  := io.out(22)
  U_Mux_9_8.io.out2_7  := io.out(23)
  U_Mux_9_8.io.out2_8  := io.out(24)
  U_Mux_9_8.io.out2_9  := io.out(25)
  U_Mux_9_8.io.out2_10 := io.out(26)
  U_Mux_9_8.io.out2_11 := io.out(27)
  U_Mux_9_8.io.out2_12 := io.out(28)
  U_Mux_9_8.io.out2_13 := io.out(29)
  U_Mux_9_8.io.out2_14 := io.out(30)
  U_Mux_9_8.io.out2_15 := io.out(31)
  io.Mul1 := U_Mux_9_8.io.Mul1
  io.Mul2 := U_Mux_9_8.io.Mul2

}

object Mux_9_8_BB_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/Mux_9_8_BB"), Seq(ChiselGeneratorAnnotation(() => new Mux_9_8_BB)))
}
