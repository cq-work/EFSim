package conv_sin
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//Generate the specified number of PEs
class Tile extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val WL = Input(UInt(array_row.W))
    val IN = Input(Vec(tile2pe_num*pe2array_num, UInt(array_row.W)))
    val BL = Input(Vec(tile2pe_num*pe2array_num, UInt(array_col.W)))

    val MAC = Output(Vec(tile2pe_num * pe2array_num * unit_num, UInt(RESULT_WIDTH.W)))
  })

  val m = VecInit(Seq.fill(tile2pe_num) (Module (new PE).io))

  for (num <- 0 until tile2pe_num) {
    m(num).WL := io.WL
    for (num1 <- 0 until pe2array_num) {
      m(num).IN(num1) := io.IN(num*tile2pe_num+num1)
      m(num).BL(num1) := io.BL(num*tile2pe_num+num1)
      for (num2 <- 0 until unit_num){
        io.MAC(num * unit_num * pe2array_num + num1 * unit_num + num2) := m(num).MAC(num1 * unit_num + num2)
      }
    }
    print("node 0\n")
  }
  print("finish!!!\n")
}

object Tile_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/Tile"), Seq(ChiselGeneratorAnnotation(() => new Tile)))
}


