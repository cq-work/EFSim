package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//Generate the specified number of Array.
class PE extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val WL = Input(UInt(array_row.W))
    val IN = Input(Vec(pe2array_num,UInt(array_row.W)))
    val BL = Input(Vec(pe2array_num,UInt(array_col.W)))

    val MAC = Output(Vec(pe2array_num*unit_num,UInt(RESULT_WIDTH.W)))
  })

  val m = VecInit(Seq.fill(pe2array_num) (Module (new Array).io))


  for (num <- 0 until pe2array_num) {
    m(num).WL := io.WL
    m(num).IN := io.IN(num)
    m(num).BL := io.BL(num)

    for (num1 <- 0 until  unit_num) {
      io.MAC(num*unit_num + num1) := m(num).MAC(num1)
    }
    //print("node0\n")
  }
  //print("finish!!!\n")
}

object PE_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/PE"), Seq(ChiselGeneratorAnnotation(() => new PE)))
}
