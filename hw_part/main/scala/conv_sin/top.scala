package conv_sin
import chisel3.{Input, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.{Decoupled, ShiftRegister, Valid}
import chisel3.util.experimental.forceName
class top extends Module with cim_config {
  val io = IO(new Bundle() {
    val function_mode  = Input(Bool())   //function: 1 -> ConV    0 -> Sin/Cos

    //input or output for sin&cos
    val cos_op_en      = Input(Bool())
    val sin_op_en      = Input(Bool())
    val cos_rb         = Input(UInt(32.W))
    val sin_rb         = Input(UInt(32.W))
    val dout_valid_sin = Output(Bool())
    val cos_ra         = Output(UInt(32.W))
    val sin_ra         = Output(UInt(32.W))

    //input for writing data in array
    val BL = Input(Vec(tile_num * tile2pe_num * pe2array_num, UInt(array_col.W)))
    val WL = Input(UInt(array_row.W))

    //input or output for ConV
    val IN = Input(Vec(tile_num * tile2pe_num, UInt(array_row.W)))
    val din_valid_ConV = Input(Bool())
    val dout_valid_ConV = Output(Bool())
    val sum_out = Output(Vec(tile_num * tile2pe_num * pe2array_num * unit_num, UInt(32.W)))
  })


  val Sign_out = Wire(Bool())
  val cs = Wire(Bool())
  val f34_zero_flag = Wire(Bool())
  val F1 = Wire(Bool())
  val index_out = Wire(UInt(13.W));
  val data_in = Wire(UInt(23.W))
  val SR1 = Wire(UInt(8.W))
  val SR2 = Wire(UInt(8.W))
  //maybe don't need
  val OF_flag = Wire(Bool())
  val U_flag = Wire(Bool())
  val num_zero = Wire(UInt(6.W))

  val U_CIM_before_BB = Module(new CIM_before_BB)
  U_CIM_before_BB.io.sin_rb := io.sin_rb
  U_CIM_before_BB.io.sin_op_en := io.sin_op_en
  U_CIM_before_BB.io.cos_rb := io.cos_rb
  U_CIM_before_BB.io.cos_op_en := io.cos_op_en
  Sign_out := U_CIM_before_BB.io.Sign_out
  cs := U_CIM_before_BB.io.cs
  f34_zero_flag := U_CIM_before_BB.io.f34_zero_flag
  F1 := U_CIM_before_BB.io.F1
  index_out := U_CIM_before_BB.io.index_out
  data_in := U_CIM_before_BB.io.data_in
  OF_flag := U_CIM_before_BB.io.OF_flag
  U_flag := U_CIM_before_BB.io.U_flag
  num_zero := U_CIM_before_BB.io.num_zero
  SR1 := U_CIM_before_BB.io.SR1
  SR2 := U_CIM_before_BB.io.SR2


  //sin_FSM: Scheduling of the hardware implementation of the sin&cos algorithm
  val index_inarray = WireInit(UInt(7.W),0.U)
  val Current_state = Wire(UInt(5.W))
  val array1_in = Wire(UInt(128.W))
  val array2_in = Wire(UInt(128.W))

  val U_sin_FSM_BB = Module(new sin_FSM_BB)
  U_sin_FSM_BB.io.cos_op_en := io.cos_op_en
  U_sin_FSM_BB.io.sin_op_en := io.sin_op_en
  U_sin_FSM_BB.io.index_inarray := index_out(6,0)
  U_sin_FSM_BB.io.data_in := data_in
  Current_state := U_sin_FSM_BB.io.Current_state
  array1_in := U_sin_FSM_BB.io.array1_in
  array2_in := U_sin_FSM_BB.io.array2_in


  //ConV_FSM: Scheduling of the hardware implementation of the ConV algorithm
  val Current_state_ConV = Wire(UInt(5.W))

  val U_ConV_FSM_BB = Module(new ConV_FSM_BB)
  U_ConV_FSM_BB.io.din_valid := io.din_valid_ConV
  Current_state_ConV := U_ConV_FSM_BB.io.Current_state
  io.dout_valid_ConV := U_ConV_FSM_BB.io.dout_valid_ConV

  //Mux_datainarray: Sending data to the Tile1 and Tile2 (According to 'function_mode', sending different input data)
  val IN_Array = Wire(Vec(tile_num*tile2pe_num*pe2array_num, UInt(array_row.W)))
  val U_Mux_datainarray = Module(new Mux_datainarray)
  U_Mux_datainarray.io.array_in(0) := array1_in
  U_Mux_datainarray.io.array_in(1) := array2_in
  U_Mux_datainarray.io.IN := io.IN
  U_Mux_datainarray.io.function_mode := io.function_mode
  U_Mux_datainarray.io.index_array   := index_out(12,9)
  IN_Array := U_Mux_datainarray.io.IN_Array

  //Tile
  val MAC = Wire(Vec(tile_num * tile2pe_num * pe2array_num * unit_num, UInt(15.W)))
  val U_Tile = VecInit(Seq.fill(tile_num)(Module(new Tile).io))

  for (i <- 0 until tile_num) {
    U_Tile(i).WL := io.WL
    for (j <- 0 until (tile2pe_num * pe2array_num)) {
      U_Tile(i).BL(j) := io.BL(j + i * tile2pe_num * pe2array_num)
      U_Tile(i).IN(j) := IN_Array(j + i * tile2pe_num * pe2array_num)
    }
    for (k <- 0 until (tile2pe_num * pe2array_num * unit_num)) {
      MAC(k + i * tile2pe_num * pe2array_num * unit_num) := U_Tile(i).MAC(k)
    }
  }

  //ConV_8x8_Tile: Add&Shifter the data from Tiles. The output for ConV algorithm
  val U_ConV_8x8_Tile = VecInit(Seq.fill(tile_num)(Module(new ConV_8x8_Tile).io))
  for (num <- 0 until tile_num) {
    U_ConV_8x8_Tile(num).Current_state := Current_state_ConV

    for (num1 <- 0 until (unit_num * pe2array_num * tile2pe_num)) {
      U_ConV_8x8_Tile(num).d_in(num1) := MAC(num1 + num * pe2array_num * tile2pe_num * unit_num)
      io.sum_out(num1 + num * pe2array_num * tile2pe_num * unit_num) := U_ConV_8x8_Tile(num).sum(num1)
    }
  }

  //Mux_Arrayout: Choose the right data for Tile1 or Tile2, the data is used for sin&cos algorithm's post procesing
  val out = Wire(Vec(32,UInt(8.W)))
  val U_Mux_Arrayout_BB = Module(new Mux_Arrayout_BB)
  U_Mux_Arrayout_BB.io.index_array := index_out(12,9)
  U_Mux_Arrayout_BB.io.MAC := MAC
  out := U_Mux_Arrayout_BB.io.out

  //Mux_9_8: named by index[8:7], using the index[8:7] to select the right data in the specific array
  val Mul1 = Wire(UInt(32.W))
  val Mul2 = Wire(UInt(32.W))

  val U_Mux_9_8_BB = Module(new Mux_9_8_BB)
  U_Mux_9_8_BB.io.index_outarray := index_out(8,7)
  U_Mux_9_8_BB.io.out := out
  Mul1 := U_Mux_9_8_BB.io.Mul1
  Mul2 := U_Mux_9_8_BB.io.Mul2

  //sin_55_23x32_post: adder&shifter the data to get the Taylor 1-order algorithm's two parts
  val sum1 = Wire(UInt(55.W))
  val sum2 = Wire(UInt(55.W))

  val U_sin_55_23x32_post_BB = Module(new sin_55_23x32_post_BB)
  U_sin_55_23x32_post_BB.io.d1_in := Mul1
  U_sin_55_23x32_post_BB.io.d2_in := Mul2
  U_sin_55_23x32_post_BB.io.Current_state := Current_state
  io.dout_valid_sin := U_sin_55_23x32_post_BB.io.dout_valid
  sum1 := U_sin_55_23x32_post_BB.io.sum1
  sum2 := U_sin_55_23x32_post_BB.io.sum2

  //sin_output: the final result for sin&cos function
  val U_sin_output_BB = Module(new sin_output_BB)
  U_sin_output_BB.io.SR1 := SR1
  U_sin_output_BB.io.SR2 := SR2
  U_sin_output_BB.io.sum1 := sum1
  U_sin_output_BB.io.sum2 := sum2
  U_sin_output_BB.io.num_zero := num_zero
  U_sin_output_BB.io.reg_F1_3 := F1
  U_sin_output_BB.io.dout_valid := io.dout_valid_sin
  U_sin_output_BB.io.Sign_out := Sign_out
  U_sin_output_BB.io.reg_czero_flag3 := f34_zero_flag
  U_sin_output_BB.io.cs := cs
  U_sin_output_BB.io.OF_flag := OF_flag
  U_sin_output_BB.io.U_flag := U_flag
  io.cos_ra := U_sin_output_BB.io.cos_ra
  io.sin_ra := U_sin_output_BB.io.sin_ra

}
object top_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/top"), Seq(ChiselGeneratorAnnotation(() => new top)))
}
