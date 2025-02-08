package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._


//this module:Sending data_in to the specified Array
//Mux_datainarray: Sending data to the Tile1 and Tile2 (According to 'function_mode', sending different input data)
class Mux_datainarray extends Module with cim_config {
  val io = IO(new Bundle {
    val IN = Input(Vec(tile_num*tile2pe_num, UInt(array_row.W)))

    val IN_Array = Output(Vec(tile_num*tile2pe_num*pe2array_num, UInt(array_row.W)))
  })

  var num  = 0
  var num1 = 0
  var num2 = 0
  while (num <= (tile_num - 1)) {
    num1 = 0
    while (num1 <= (tile2pe_num - 1)) {
      num2 = 0
      while(num2 <= (pe2array_num - 1)) {
        //var num3 = num * tile2pe_num
        io.IN_Array(num * tile2pe_num * pe2array_num + num1 * pe2array_num + num2) := io.IN((num+1) * tile2pe_num - 1 - num1)
        //io.IN_Array(num * tile2pe_num * pe2array_num + num1 * pe2array_num + num2) := io.IN(tile_num * tile2pe_num - num * tile2pe_num)
        num2 = num2 + 1
      }
      num1 = num1 + 1
    }
    num = num + 1
  }

}

object Mux_datainarray_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/Mux_datainarray"), Seq(ChiselGeneratorAnnotation(() => new Mux_datainarray)))
}