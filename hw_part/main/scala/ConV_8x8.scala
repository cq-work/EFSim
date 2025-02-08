package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_8x8.scala: Add&Shifter the data from unit. The output for ConV algorithm(This unit can only be 8 columns to a unit.)
//class ConV_8x8 extends Module with cim_config with adder_tree_config {
//  val io = IO(new Bundle {
//    val d_in          = Input(UInt(RESULT_WIDTH.W))
//    val Current_state = Input(UInt(5.W))
//
//    val OUT = Output(UInt(O_width.W))   //O_width = 32
//  })
//
//  val d_out = Wire(UInt(ARRAY_RESULT_WIDTH.W))
//  val d_out_sign = Reg(UInt(ARRAY_RESULT_WIDTH.W))
//  val d_out_sign_fix = Reg(UInt(ARRAY_RESULT_WIDTH.W))
//  val sum_out = Reg(UInt(ARRAY_RESULT_WIDTH.W))
//
//  val cat_index = io.Current_state - 1.U - log2Up(array_row + 1).U
//  val cat0 = 0.U(cat_index)
//  val cat_index_1 = ((1 << DATA_WIDTH)-1).U(DATA_WIDTH.W)
//
//  when(io.d_in(RESULT_WIDTH-1) === 0.U){
//    when(io.Current_state === log2Up(array_row + 1).U) {
//      d_out := Cat(0.U(1.W), io.d_in, 0.U((DATA_WIDTH-1).W))
//      d_out_sign := Cat(0.U(1.W), io.d_in, 0.U((DATA_WIDTH-1).W))
//    }.elsewhen((io.Current_state > log2Up(array_row + 1).U) && (io.Current_state < (DATA_WIDTH + log2Up(array_row + 1)).U)) {
//      d_out := Cat(0.U((DATA_WIDTH.U-cat_index)), io.d_in, cat0)
//    }.otherwise {
//      d_out := 0.U(ARRAY_RESULT_WIDTH.W)
//    }
//  }.otherwise {
//    when(io.Current_state === log2Up(array_row + 1).U) {
//      d_out := Cat(1.U(1.W), io.d_in, 0.U((DATA_WIDTH - 1).W))
//      d_out_sign := Cat(1.U(1.W), io.d_in, 0.U((DATA_WIDTH - 1).W))
//    }.elsewhen((io.Current_state > log2Up(array_row + 1).U) && (io.Current_state < (DATA_WIDTH + log2Up(array_row + 1)).U)) {
//      d_out := Cat(255.U((DATA_WIDTH.U-cat_index)), io.d_in, cat0)
//    }.otherwise {
//      d_out := 0.U(ARRAY_RESULT_WIDTH.W)
//    }
//  }
//
//  when(io.Current_state === (numStates-2).U) {
//    sum_out := sum_out + d_out_sign_fix
//  }.elsewhen(io.Current_state === (log2Up(array_row + 1)+1).U) {
//    sum_out := sum_out + d_out
//    d_out_sign_fix := (d_out_sign << (RESULT_WIDTH+1)) - d_out_sign
//  }.elsewhen(io.Current_state > (log2Up(array_row + 1)+1).U) {
//    sum_out := sum_out + d_out
//  }.elsewhen(io.Current_state === 0.U) {
//    sum_out := 0.U
//  }.otherwise {
//    sum_out := sum_out
//  }
//
//  io.OUT := Mux(sum_out(ARRAY_RESULT_WIDTH-1) === 1.U, Cat(((1 << (32-ARRAY_RESULT_WIDTH))-1).U, sum_out), Cat(0.U, sum_out))
//}

class ConV_8x8 extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val d_in          = Input(UInt(RESULT_WIDTH.W))
    val Current_state = Input(UInt(5.W))

    val OUT = Output(UInt(O_width.W))   //O_width = 32
  })

  val d_out = Wire(UInt(ARRAY_RESULT_WIDTH.W))
  val d_out_sign = Reg(UInt(ARRAY_RESULT_WIDTH.W))
  val d_out_sign_fix = Reg(UInt(ARRAY_RESULT_WIDTH.W))
  val sum_out = Reg(UInt(ARRAY_RESULT_WIDTH.W))
  when(io.d_in(RESULT_WIDTH-1) === 0.U){
    when(io.Current_state === log2Up(array_row + 1).U) {
      d_out := Cat(0.U(1.W), io.d_in, 0.U(7.W))
      d_out_sign := Cat(0.U(1.W), io.d_in, 0.U(7.W))
    }.elsewhen(io.Current_state === (1 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(8.W), io.d_in)
    }.elsewhen(io.Current_state === (2 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(7.W), io.d_in, 0.U(1.W))
    }.elsewhen(io.Current_state === (3 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(6.W), io.d_in, 0.U(2.W))
    }.elsewhen(io.Current_state === (4 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(5.W), io.d_in, 0.U(3.W))
    }.elsewhen(io.Current_state === (5 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(4.W), io.d_in, 0.U(4.W))
    }.elsewhen(io.Current_state === (6 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(3.W), io.d_in, 0.U(5.W))
    }.elsewhen(io.Current_state === (7 + log2Up(array_row + 1)).U) {
      d_out := Cat(0.U(2.W), io.d_in, 0.U(6.W))
    }.otherwise {
      d_out := 0.U(ARRAY_RESULT_WIDTH.W)
    }
  }.otherwise {
    when(io.Current_state === log2Up(array_row + 1).U) {
      d_out := Cat(1.U(1.W), io.d_in, 0.U(7.W))
      d_out_sign := Cat(1.U(1.W), io.d_in, 0.U(7.W))
    }.elsewhen(io.Current_state === (1 + log2Up(array_row + 1)).U) {
      d_out := Cat(255.U(8.W), io.d_in)
    }.elsewhen(io.Current_state === (2 + log2Up(array_row + 1)).U) {
      d_out := Cat(127.U(7.W), io.d_in, 0.U(1.W))
    }.elsewhen(io.Current_state === (3 + log2Up(array_row + 1)).U) {
      d_out := Cat(63.U(6.W), io.d_in, 0.U(2.W))
    }.elsewhen(io.Current_state === (4 + log2Up(array_row + 1)).U) {
      d_out := Cat(31.U(5.W), io.d_in, 0.U(3.W))
    }.elsewhen(io.Current_state === (5 + log2Up(array_row + 1)).U) {
      d_out := Cat(15.U(4.W), io.d_in, 0.U(4.W))
    }.elsewhen(io.Current_state === (6 + log2Up(array_row + 1)).U) {
      d_out := Cat(7.U(3.W), io.d_in, 0.U(5.W))
    }.elsewhen(io.Current_state === (7 + log2Up(array_row + 1)).U) {
      d_out := Cat(3.U(2.W), io.d_in, 0.U(6.W))
    }.otherwise {
      d_out := 0.U(ARRAY_RESULT_WIDTH.W)
    }
  }

  when(io.Current_state === (numStates-2).U) {
    sum_out := sum_out + d_out_sign_fix
  }.elsewhen(io.Current_state === (log2Up(array_row + 1)+1).U) {
    sum_out := sum_out + d_out
    d_out_sign_fix := (d_out_sign << (RESULT_WIDTH+1)) - d_out_sign
  }.elsewhen(io.Current_state > (log2Up(array_row + 1)+1).U) {
    sum_out := sum_out + d_out
  }.elsewhen(io.Current_state === 0.U) {
    sum_out := 0.U
  }.otherwise {
    sum_out := sum_out
  }

//  when(io.Current_state === 16.U) {
//    sum_out := sum_out + d_out_sign_fix
//  }.elsewhen(io.Current_state === 9.U) {
//    sum_out := sum_out + d_out
//    d_out_sign_fix := (d_out_sign << 16) - d_out_sign
//  }.elsewhen(io.Current_state === 10.U) {
//    sum_out := sum_out + d_out
//  }.elsewhen(io.Current_state === 11.U) {
//    sum_out := sum_out + d_out
//  }.elsewhen(io.Current_state === 12.U) {
//    sum_out := sum_out + d_out
//  }.elsewhen(io.Current_state >= 13.U) {
//    sum_out := sum_out + d_out
//  }.elsewhen(io.Current_state === 0.U) {
//    sum_out := 0.U
//  }.otherwise {
//    sum_out := sum_out
//  }

//  io.OUT := Mux(sum_out(22) === 1.U, Cat(511.U, sum_out), Cat(0.U, sum_out))
  io.OUT := Mux(sum_out(ARRAY_RESULT_WIDTH-1) === 1.U, Cat(((1 << (32-ARRAY_RESULT_WIDTH))-1).U, sum_out), sum_out)
}



object ConV_8x8_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/test/ConV_8x8"),Seq(ChiselGeneratorAnnotation(()=>new ConV_8x8)))
}
