package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//this module:Sending data_in to the specified Array
//Mux_datainarray: Sending data to the Tile1 and Tile2 (According to 'function_mode', sending different input data)
class Mux_datainarray extends Module with cim_config {
  val io = IO(new Bundle {
    val array_in = Input(Vec(tile_num, UInt(array_row.W)))
    val IN = Input(Vec(tile_num*tile2pe_num, UInt(array_row.W)))
    val function_mode = Input(Bool())
    val index_array = Input(UInt(4.W))

    val IN_Array = Output(Vec(tile_num*tile2pe_num*pe2array_num, UInt(array_row.W)))
  })

  when(io.function_mode) {
    var num = 0
    var num1 = 0
    var num2 = 0
    while (num <= (tile_num - 1)) {
      num1 = 0
      while (num1 <= (tile2pe_num - 1)) {
        num2 = 0
        while (num2 <= (pe2array_num - 1)) {
          //var num3 = num * tile2pe_num
          io.IN_Array(num * tile2pe_num * pe2array_num + num1 * pe2array_num + num2) := io.IN(tile_num * tile2pe_num - 1 - num * tile2pe_num - num1)
          //io.IN_Array(num * tile2pe_num * pe2array_num + num1 * pe2array_num + num2) := io.IN(tile_num * tile2pe_num - num * tile2pe_num)
          num2 = num2 + 1
        }
        num1 = num1 + 1
      }
      num = num + 1
    }
  }.otherwise {
    val x = for(i <- 0 until 16) yield io.index_array === i.U
    val y_0 = Seq(Seq(io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0), 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(0)))
    val y_1 = Seq(Seq(io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U, 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1), 0.U),
      Seq(0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, 0.U, io.array_in(1)))
    for (i <- 0 until tile2pe_num){
      for (j <- 0 until  pe2array_num) {
        io.IN_Array(i*pe2array_num+j) := MuxCase(0.U(128.W),x zip y_0(i*pe2array_num+j))
//        io.IN_Array(i*tile2pe_num*j) := MuxCase(0.U(128.W),x zip y_0(i*tile2pe_num*j))
        io.IN_Array(i*pe2array_num+j+tile2pe_num*pe2array_num) := MuxCase(0.U(128.W),x zip y_1(i*pe2array_num+j))
//        io.IN_Array(i*tile2pe_num*j+tile2pe_num*pe2array_num) := MuxCase(0.U(128.W),x zip y_1(i*tile2pe_num*j))
      }
    }
  }
}

object Mux_datainarray_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/Mux_datainarray"), Seq(ChiselGeneratorAnnotation(() => new Mux_datainarray)))
}