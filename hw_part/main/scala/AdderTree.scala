package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class NBitsAdder(n: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(n.W))
    val b = Input(UInt(n.W))
    val s = Output(UInt((n+1).W))
  })
  val sum = Reg(SInt((n+1).W))
  sum := io.a.asSInt +& io.b.asSInt
//  io.s := io.a +& io.b
  io.s := sum.asUInt
}
class AdderTree extends Module with adder_tree_config with cim_config {
  val inputNum = array_row
  val outputWidth = RESULT_WIDTH
//  val outputWidth = log2Up(array_row + 1) + DATA_WIDTH - 1
  val io = IO(new Bundle {
    val d_in = Input(Vec(inputNum, UInt(DATA_WIDTH.W)))

    val sum = Output(UInt(outputWidth.W))
  })
  var stage = 0
  var stageNum = inputNum/2
  val mutableMap = scala.collection.mutable.Map[Int,IndexedSeq[NBitsAdder]]()
  while (stage < outputWidth - DATA_WIDTH){
    mutableMap += (stage -> (for (i <- 1 to stageNum) yield Module(new NBitsAdder(stage + DATA_WIDTH))))
    stage = stage + 1
    stageNum = stageNum/2
  }
  var num = 0
  for (adder <- mutableMap(0)){
    adder.io.a := io.d_in(num)
    adder.io.b := io.d_in(num + 1)

    num = num + 2

  }

  num = 1
  var num1 = 0
  while (mutableMap.getOrElse(num,-1) != -1){
    for (adder <- mutableMap(num)){
      adder.io.a := mutableMap(num-1)(num1).io.s
      adder.io.b := mutableMap(num-1)(num1+1).io.s

      num1 = num1 + 2
    }
    num = num + 1
    num1 = 0
  }
  io.sum := mutableMap(num-1)(0).io.s
}

object AdderTree_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/test/AdderTree"),Seq(ChiselGeneratorAnnotation(()=>new AdderTree)))
}