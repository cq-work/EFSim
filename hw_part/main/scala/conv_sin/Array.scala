package conv_sin

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//Generate 128x128 SRAM arrays + configure the corresponding number of adder trees
class Array extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val WL = Input(UInt(array_row.W))
    val IN = Input(UInt(array_row.W))
    val BL = Input(UInt(array_col.W))    //Needs to be a multiple of 8

    val MAC = Output(Vec(unit_num, UInt(RESULT_WIDTH.W)))
  })
  /*
  for(i <- 0 until unit_num){
    io.MAC(i) := 0.U(15.W)
  }

   */


  val m = VecInit(Seq.fill(unit_num) (Module (new Array_8x128).io))


  for (num <- 0 until unit_num) {
    m(num).WL := io.WL
    m(num).IN := io.IN
    m(num).BL := io.BL(array_col-1-8*num,array_col-8-8*num)

    io.MAC(num) := m(num).MAC
    //print("node0\n")
  }
  //print("finish!!!\n")

}



object Array_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/Array"), Seq(ChiselGeneratorAnnotation(() => new Array)))
}
