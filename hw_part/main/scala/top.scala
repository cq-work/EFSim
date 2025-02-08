package cim
import chisel3.{Input, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.{Decoupled, ShiftRegister, Valid}
import chisel3.util.experimental.forceName

class top_cim extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle() {
    val BL  = Input(Vec(tile_num*tile2pe_num*pe2array_num,UInt(array_col.W)))
    val WL    = Input(UInt(array_row.W))
    val IN    = Input(Vec(tile_num*tile2pe_num,UInt(array_row.W)))
    val ifm_buffer_ready = if (!SIM_MODE) Some(Input(Bool())) else None
    val din_valid_ConV  = Input(Bool())
    val dout_valid_ConV = Output(Bool())
    val buffer_busy = if (!SIM_MODE) Some(Output(Bool())) else None
    val sum_out  = Output(Vec(tile_num*tile2pe_num*pe2array_num*unit_num,UInt(32.W)))
  })


  //ConV_FSM: Scheduling of the hardware implementation of the ConV algorithm
  val Current_state = Wire(UInt(5.W))
  val U_ConV_FSM = Module(new ConV_FSM)
  U_ConV_FSM.io.din_valid_ConV := io.din_valid_ConV
  if (!SIM_MODE){
    U_ConV_FSM.io.ifm_buffer_ready.get := io.ifm_buffer_ready.get
    io.buffer_busy.get := U_ConV_FSM.io.buffer_busy.get
  }


  Current_state := U_ConV_FSM.io.Current_state
  io.dout_valid_ConV := U_ConV_FSM.io.dout_valid_ConV



  //Mux_datainarray: Sending data to the Tile1 and Tile2 (According to 'function_mode', sending different input data)
  val IN_array = Wire(Vec(tile_num*tile2pe_num*pe2array_num, UInt(array_row.W)))
  val U_Mux_datainarray = Module(new Mux_datainarray)
  U_Mux_datainarray.io.IN := io.IN
  IN_array := U_Mux_datainarray.io.IN_Array


  //Tile
  val MAC    = Wire(Vec(tile_num*tile2pe_num*pe2array_num*unit_num,UInt(RESULT_WIDTH.W)))
  val U_Tile = VecInit(Seq.fill(tile_num)(Module (new Tile).io))

  for (i <- 0 until tile_num) {
    U_Tile(i).WL := io.WL
    for (j <- 0 until (tile2pe_num*pe2array_num)) {
      U_Tile(i).BL(j) := io.BL(tile2pe_num*pe2array_num - 1 - j + i*tile2pe_num*pe2array_num)
      U_Tile(i).IN(j) := IN_array(j + i*tile2pe_num*pe2array_num)
    }
    for (k <- 0 until  (tile2pe_num * pe2array_num * unit_num)) {
      MAC(k + i*tile2pe_num * pe2array_num * unit_num) := U_Tile(i).MAC(k)
    }
  }
//  while (num <= (tile_num-1)) {
//    U_Tile(num).WL := io.WL
//    num1 = 0
//    while (num1 <= (tile2pe_num*pe2array_num-1)) {
//      U_Tile(num).BL(num1) := io.BL(num1 + num*tile2pe_num*pe2array_num)
//      U_Tile(num).IN(num1) := IN_array(num1 + num*tile2pe_num*pe2array_num)
//      num1 = num1 + 1
//    }
//    num2 = 0
//    while (num2 <= (tile2pe_num * pe2array_num * unit_num - 1)) {
//      MAC(num2 + num*tile2pe_num * pe2array_num * unit_num) := U_Tile(num).MAC(num2)
//      num2 = num2 + 1
//    }
//  }



  //ConV_8x8_Tile: Add&Shifter the data from Tiles. The output for ConV algorithm
  val U_ConV_8x8_Tile = VecInit(Seq.fill(tile_num)(Module (new ConV_8x8_Tile).io))
  for (num <- 0 until tile_num) {
    U_ConV_8x8_Tile(num).Current_state := Current_state

    for (num1 <- 0 until (unit_num * pe2array_num * tile2pe_num)) {
      U_ConV_8x8_Tile(num).d_in(num1) := MAC(num1 + num * pe2array_num * tile2pe_num*unit_num )
      io.sum_out(num1 + (tile_num - 1 - num) * pe2array_num * tile2pe_num*unit_num) := U_ConV_8x8_Tile(num).sum(num1)
    }
  }

}

object top_cim_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test"), Seq(ChiselGeneratorAnnotation(() => new top_cim)))
}

