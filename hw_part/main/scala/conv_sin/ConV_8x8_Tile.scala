package conv_sin

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_8x8_Tile: Add&Shifter the data from Tiles. The output for ConV algorithm
class ConV_8x8_Tile extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val d_in = Input(Vec(unit_num * pe2array_num * tile2pe_num, UInt(RESULT_WIDTH.W)))
    val Current_state = Input(UInt(5.W))

    val sum = Output(Vec(unit_num * pe2array_num * tile2pe_num, UInt(32.W)))
  })

  val U_ConV_8x8_PE = VecInit(Seq.fill(tile2pe_num)(Module(new ConV_8x8_PE).io))

  for (num <- 0 until tile2pe_num) {
    U_ConV_8x8_PE(num).Current_state := io.Current_state
    for (num1 <- 0 until  unit_num * pe2array_num) {
      U_ConV_8x8_PE(num).d_in(num1) := io.d_in(num1 + num * unit_num * pe2array_num)
      io.sum(num1 + num * unit_num * pe2array_num) := U_ConV_8x8_PE(num).sum(num1)
    }
  }
}

object ConV_8x8_Tile_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/ConV_8x8_Tile"), Seq(ChiselGeneratorAnnotation(() => new ConV_8x8_Tile)))
}

