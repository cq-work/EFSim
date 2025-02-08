package conv_sin
import chisel3.{Input, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.{Decoupled, ShiftRegister, Valid}
import chisel3.util.experimental.forceName
class top_DC extends Module with cim_config {
  val io = IO(new Bundle() {
    val function_mode = Input(Bool()) //function: 1 -> ConV    0 -> Sin/Cos

    //input or output for sin&cos
    val cos_op_en = Input(Bool())
    val sin_op_en = Input(Bool())
    val cos_rb = Input(UInt(32.W))
    val sin_rb = Input(UInt(32.W))
    val dout_valid_sin = Output(Bool())
    val cos_ra = Output(UInt(32.W))
    val sin_ra = Output(UInt(32.W))

    //input for writing data in array
    val BL = Input(UInt(array_col.W))
    val WL = Input(UInt(array_row.W))

    //input or output for ConV
    val IN = Input(UInt(array_row.W))
    val din_valid_ConV = Input(Bool())
    val dout_valid_ConV = Output(Bool())
    val sum_out = Output(Vec(tile_num,UInt((tile2pe_num*pe2array_num*unit_num*32).W)))
  })
  val m0 = Module(new top)
  m0.io.function_mode := io.function_mode
  m0.io.cos_op_en := io.cos_op_en
  m0.io.sin_op_en := io.sin_op_en
  m0.io.cos_rb := io.cos_rb
  m0.io.sin_rb := io.sin_rb
  io.dout_valid_sin := m0.io.dout_valid_sin
  io.cos_ra := m0.io.cos_ra
  io.sin_ra := m0.io.sin_ra

  for (i <- 0 until tile_num*tile2pe_num*pe2array_num){
    m0.io.BL(i) := io.BL
  }
  m0.io.WL := io.WL
  for (j <- 0 until tile_num*tile2pe_num){
    m0.io.IN(j) := io.IN
  }
  m0.io.din_valid_ConV := io.din_valid_ConV
  io.dout_valid_ConV := m0.io.dout_valid_ConV

  class Split extends Bundle {
//    val m0 = UInt(32.W)
//    val m1 = UInt(32.W)
//    val m2 = UInt(32.W)
//    val m3 = UInt(32.W)
//    val m4 = UInt(32.W)
//    val m5 = UInt(32.W)
//    val m6 = UInt(32.W)
//    val m7 = UInt(32.W)
//    val m8 = UInt(32.W)
//    val m9 = UInt(32.W)
//    val m10 = UInt(32.W)
//    val m11 = UInt(32.W)
//    val m12 = UInt(32.W)
//    val m13 = UInt(32.W)
//    val m14 = UInt(32.W)
//    val m15 = UInt(32.W)
//    val m16 = UInt(32.W)
//    val m17 = UInt(32.W)
//    val m18 = UInt(32.W)
//    val m19 = UInt(32.W)
//    val m20 = UInt(32.W)
//    val m21 = UInt(32.W)
//    val m22 = UInt(32.W)
//    val m23 = UInt(32.W)
//    val m24 = UInt(32.W)
//    val m25 = UInt(32.W)
//    val m26 = UInt(32.W)
//    val m27 = UInt(32.W)
//    val m28 = UInt(32.W)
//    val m29 = UInt(32.W)
//    val m30 = UInt(32.W)
//    val m31 = UInt(32.W)
//    val m32 = UInt(32.W)
//    val m33 = UInt(32.W)
//    val m34 = UInt(32.W)
//    val m35 = UInt(32.W)
//    val m36 = UInt(32.W)
//    val m37 = UInt(32.W)
//    val m38 = UInt(32.W)
//    val m39 = UInt(32.W)
//    val m40 = UInt(32.W)
//    val m41 = UInt(32.W)
//    val m42 = UInt(32.W)
//    val m43 = UInt(32.W)
//    val m44 = UInt(32.W)
//    val m45 = UInt(32.W)
//    val m46 = UInt(32.W)
//    val m47 = UInt(32.W)
//    val m48 = UInt(32.W)
//    val m49 = UInt(32.W)
//    val m50 = UInt(32.W)
//    val m51 = UInt(32.W)
//    val m52 = UInt(32.W)
//    val m53 = UInt(32.W)
//    val m54 = UInt(32.W)
//    val m55 = UInt(32.W)
//    val m56 = UInt(32.W)
//    val m57 = UInt(32.W)
//    val m58 = UInt(32.W)
//    val m59 = UInt(32.W)
//    val m60 = UInt(32.W)
//    val m61 = UInt(32.W)
//    val m62 = UInt(32.W)
//    val m63 = UInt(32.W)
//    val m64 = UInt(32.W)
//    val m65 = UInt(32.W)
//    val m66 = UInt(32.W)
//    val m67 = UInt(32.W)
//    val m68 = UInt(32.W)
//    val m69 = UInt(32.W)
    val result = Vec(tile2pe_num * pe2array_num * unit_num,UInt(32.W))
  }
  val split0 = Wire(new Split())
  for (i <- 0 until tile2pe_num * pe2array_num * unit_num){
    split0.result(i) := m0.io.sum_out(i)
  }
  io.sum_out(0) := split0.asUInt

  val split1 = Wire(new Split())
  for (i <- 0 until tile2pe_num * pe2array_num * unit_num) {
    split1.result(i) := m0.io.sum_out(i + tile2pe_num * pe2array_num * unit_num)
  }
  io.sum_out(1) := split1.asUInt
//  for (i <- 0 until tile_num){
//    for (k <- 0 until  tile2pe_num * pe2array_num * unit_num) {
//      io.sum_out(i)(k*32+31,k*32) := m0.io.sum_out(i*tile2pe_num*pe2array_num*unit_num+k)
//    }
//  }

}

object top_DC_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/top_DC"), Seq(ChiselGeneratorAnnotation(() => new top_DC)))
}