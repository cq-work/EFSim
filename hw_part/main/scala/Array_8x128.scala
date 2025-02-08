package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

// Generate 8x128 SRAM array + configured adder tree
class Array_8x128 extends Module with cim_config with adder_tree_config {
  val io = IO(new Bundle {
    val WL = Input(UInt(array_row.W))
    val IN = Input(UInt(array_row.W))
    val BL = Input(UInt(unit_col.W))

    val MAC = Output(UInt(RESULT_WIDTH.W))
  })

  val Vout = Wire(Vec(unit_col*array_row,UInt(1.W)))
  val u_line_cell = VecInit(Seq.fill(unit_col)(Module (new line_cell).io))
  for (i <- 0 until unit_col){
    u_line_cell(i).WL := io.WL
    u_line_cell(i).IN := io.IN
    u_line_cell(i).BL := io.BL(i)
    for (j <- 0 until array_row) {
      Vout(i*array_row+j) := u_line_cell(i).Vout(j)
    }
  }

//  Parameterisation is not complete and only supports 8 columns of data as a unit.
  val U_AdderTree = Module(new AdderTree)
  for (i <- 0 until array_row) {      //the reason for this is unit_col = 8
    U_AdderTree.io.d_in(i) := Cat(Vout(7 * array_row + i), Vout(6 * array_row + i), Vout(5 * array_row + i), Vout(4 * array_row + i), Vout(3 * array_row + i), Vout(2 * array_row + i), Vout(1 * array_row + i), Vout(i))
//    U_AdderTree.io.d_in(i) := Cat(Vout(8 * i + 7), Vout(8 * i + 6), Vout(8 * i + 5), Vout(8 * i + 4), Vout(8 * i + 3), Vout(8 * i + 2), Vout(8 * i + 1), Vout(8 * i))
//    U_AdderTree.io.d_in(i) := Vout(8, 0)
//    U_AdderTree.io.d_in(i) := Vout(8*i+unit_col-1, 8*i)
  }
  io.MAC := U_AdderTree.io.sum

//  io.MAC := 0.U(15.W)

  /*
  val Vout = Wire(Vec(unit_col*array_row,UInt(1.W)))

  //the 0st column
  val m0 = VecInit(Seq.fill(128)(Module (new SRAM_cell).io))
  for (i <- 0 until 128) {
    m0(i).WL    := io.WL(i)
    m0(i).BL    := io.BL(0)
    m0(i).IN    := io.IN(i)
    Vout(i*8)   := m0(i).OUT
  }

  //the 1st column
  val m1 = VecInit(Seq.fill(128)(Module (new SRAM_cell).io))
  for (i <- 0 until 128) {
    m1(i).WL        := io.WL(i)
    m1(i).BL        := io.BL(1)
    m1(i).IN        := io.IN(i)
    Vout(i * 8 + 1) := m1(i).OUT
  }

  //the 2st column
  val m2 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m2(i).WL := io.WL(i)
    m2(i).BL := io.BL(2)
    m2(i).IN := io.IN(i)
    Vout(i * 8 + 2) := m2(i).OUT
  }

  //the 3st column
  val m3 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m3(i).WL := io.WL(i)
    m3(i).BL := io.BL(3)
    m3(i).IN := io.IN(i)
    Vout(i * 8 + 3) := m3(i).OUT
  }

  //the 4st column
  val m4 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m4(i).WL := io.WL(i)
    m4(i).BL := io.BL(4)
    m4(i).IN := io.IN(i)
    Vout(i * 8 + 4) := m4(i).OUT
  }

  //the 5st column
  val m5 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m5(i).WL := io.WL(i)
    m5(i).BL := io.BL(5)
    m5(i).IN := io.IN(i)
    Vout(i * 8 + 5) := m5(i).OUT
  }

  //the 6st column
  val m6 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m6(i).WL := io.WL(i)
    m6(i).BL := io.BL(6)
    m6(i).IN := io.IN(i)
    Vout(i * 8 + 6) := m6(i).OUT
  }

  //the 7st column
  val m7 = VecInit(Seq.fill(128)(Module(new SRAM_cell).io))
  for (i <- 0 until 128) {
    m7(i).WL := io.WL(i)
    m7(i).BL := io.BL(7)
    m7(i).IN := io.IN(i)
    Vout(i * 8 + 7) := m7(i).OUT
  }
  val U_AdderTree = Module(new AdderTree)
  for (i <- 0 until 128) {
    U_AdderTree.io.d_in(i) := Cat(Vout(8*i+7),Vout(8*i+6),Vout(8*i+5),Vout(8*i+4),Vout(8*i+3),Vout(8*i+2),Vout(8*i+1),Vout(8*i))
  }
  io.MAC := U_AdderTree.io.sum

   */
}

object Array_8x128_gen extends App {
  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/test/Array_8x128"), Seq(ChiselGeneratorAnnotation(() => new Array_8x128)))
}