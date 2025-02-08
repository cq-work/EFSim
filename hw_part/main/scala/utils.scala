package cim
import chisel3._
import chisel3.util._

//----------------------Get Rise Edge----------------------//
class riseEdge extends Module {
  val io = IO(new Bundle() {
    val in   = Input(Bool())
    val edge = Output(Bool())
  })
  io.edge := !RegNext(io.in) && io.in
}

object riseEdge {
  def apply(in: Bool): Bool = {
    val inst = Module(new riseEdge)
    inst.io.in := in
    inst.io.edge
  }
}

//----------------------Get Fall Edge----------------------//
class fallEdge extends Module {
  val io = IO(new Bundle() {
    val in   = Input(Bool())
    val edge = Output(Bool())
  })
  io.edge := RegNext(io.in) && !io.in
}

object fallEdge {
  def apply(in: Bool): Bool = {
    val inst = Module(new fallEdge)
    inst.io.in := in
    inst.io.edge
  }
}

//----------------------Get Dual Edge----------------------//
class dualEdge extends Module {
  val io = IO(new Bundle() {
    val in   = Input(Bool())
    val edge = Output(Bool())
  })
  io.edge := RegNext(io.in) ^ io.in
}

object dualEdge {
  def apply(in: Bool): Bool = {
    val inst = Module(new dualEdge)
    inst.io.in := in
    inst.io.edge
  }
}

class align(width: Int, n: Int) extends Module {
  val io = IO(new Bundle() {
    val in  = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })
  io.out := (io.in + (n - 1).U) & -n.S(width.W).asUInt
}

object align {
  def apply(x: UInt, n: Int): UInt = {
    val inst = Module(new align(x.getWidth, n))
    inst.io.in := x
    inst.io.out
  }

  def apply(x: UInt, wdith: Int, n: Int): UInt = {
    val inst = Module(new align(wdith, n))
    inst.io.in := x
    inst.io.out
  }
}

object util_function {
  //----------------------Get Rise Edge----------------------//
  def riseEdge(in: Bool): Bool = {
    !RegNext(in, 0.B) && in
  }

  def riseEdge(in: Bool, en: Bool): Bool = {
    !RegEnable(in, 0.B, en) && in
  }

  //----------------------Get Fall Edge----------------------//
  def fallEdge(in: Bool): Bool = {
    RegNext(in, 0.B) && !in
  }

  def fallEdge(in: Bool, en: Bool): Bool = {
    RegEnable(in, 0.B, en) && !in
  }

  //----------------------Get Dual Edge----------------------//
  def dualEdge(in: Bool): Bool = {
    RegNext(in, 0.B) ^ in
  }

  def dualEdge(in: Bool, en: Bool): Bool = {
    RegEnable(in, 0.B, en) ^ in
  }

  def align(in: UInt, width: Int, n: Int): UInt = {
    ((in + (n - 1).U) & -n.S(width.W).asUInt)(width - 1, 0)
  }

  def align(in: UInt, n: Int): UInt = {
    ((in + (n - 1).U) & -n.S(in.getWidth.W).asUInt)(in.getWidth - 1, 0)
  }
}

package ram_blackbox {
  //----------------------Single Port Ram----------------------//
  //ram_style: distributed / block / ultra
  class SPRAM(data_width: Int, depth: Int, ram_style: String)
      extends BlackBox(Map("DATA_WIDTH" -> data_width, "DEPTH" -> depth, "RAM_STYLE_VAL" -> ram_style))
      with HasBlackBoxPath {
    val io = IO(new Bundle {
      val CLK = Input(Clock())
      val CEN = Input(Bool())
      val WEN = Input(Bool()) //0:W 1:R
      val A   = Input(UInt(log2Ceil(depth).W))
      val D   = Input(UInt(data_width.W))
      val Q   = Output(UInt(data_width.W))
    })
    addPath("./src/main/hdl/SPRAM.v")
  }

  object SPRAM {
    def apply(data_width: Int, depth: Int, ram_style: String) = Module(new SPRAM(data_width, depth, ram_style)).io
  }

  //----------------------Pseudo Dual Port Ram----------------------//
  //ram_style: distributed / block / ultra
  class TPRAM(data_width: Int, depth: Int, ram_style: String)
      extends BlackBox(Map("DATA_WIDTH" -> data_width, "DEPTH" -> depth, "RAM_STYLE_VAL" -> ram_style))
      with HasBlackBoxPath {
    val io = IO(new Bundle {
      val CLKA = Input(Clock())
      val CLKB = Input(Clock())
      val CENB = Input(Bool())
      val CENA = Input(Bool())
      val AB   = Input(UInt(log2Ceil(depth).W))
      val AA   = Input(UInt(log2Ceil(depth).W))
      val DB   = Input(UInt(data_width.W))
      val QA   = Output(UInt(data_width.W))
    })
    addPath("./src/main/hdl/TPRAM.v")
  }

  object TPRAM {
    def apply(data_width: Int, depth: Int, ram_style: String) = Module(new TPRAM(data_width, depth, ram_style)).io
  }

  //----------------------True Dual Port Ram----------------------//
  //ram_style: distributed / block / ultra
  class DPRAM(data_width: Int, depth: Int, ram_style: String)
      extends BlackBox(Map("DATA_WIDTH" -> data_width, "DEPTH" -> depth, "RAM_STYLE_VAL" -> ram_style))
      with HasBlackBoxPath {
    val io = IO(new Bundle() {
      val CLKA = Input(Clock())
      val CLKB = Input(Clock())
      val WENA = Input(Bool())
      val WENB = Input(Bool())
      val CENA = Input(Bool())
      val CENB = Input(Bool())
      val AA   = Input(UInt(log2Ceil(depth).W))
      val AB   = Input(UInt(log2Ceil(depth).W))
      val DA   = Input(UInt(data_width.W))
      val DB   = Input(UInt(data_width.W))
      val QA   = Output(UInt(data_width.W))
      val QB   = Output(UInt(data_width.W))
    })
    addPath("./src/main/hdl/DPRAM.v")
  }

  object DPRAM {
    def apply(data_width: Int, depth: Int, ram_style: String) = Module(new DPRAM(data_width, depth, ram_style)).io
  }
}

import ram_blackbox._

//class SPRAM_WRAP(data_width: Int, depth: Int, ram_style: String) extends Module {
//  val io = IO(new Bundle {
//    val clock = Input(Clock())
//    val en    = Input(Bool())
//    val wr    = Input(Bool()) //0:W 1:R
//    val addr  = Input(UInt(log2Ceil(depth).W))
//    val wdata = Input(UInt(data_width.W))
//    val rdata = Output(UInt(data_width.W))
//  })
//  val spram = Module(new SPRAM(data_width, depth, ram_style))
//  spram.io.clock <> clock
//  spram.io.CEN <> !io.en
//  spram.io.WEN <> io.wr
//  spram.io.A   <> io.addr
//  spram.io.D   <> io.wdata
//  spram.io.Q   <> io.rdata
//}

//object SPRAM_WRAP {
//  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new SPRAM_WRAP(data_width, depth, ram_style)).io
//}

class TPRAM_WRAP(data_width: Int, depth: Int, ram_style: String) extends Module {
  val io = IO(new Bundle {
    val clock = Input(Clock())
    val wen   = Input(Bool())
    val ren   = Input(Bool())
    val waddr = Input(UInt(log2Ceil(depth).W))
    val raddr = Input(UInt(log2Ceil(depth).W))
    val wdata = Input(UInt(data_width.W))
    val rdata = Output(UInt(data_width.W))
  })
  // A channel read, B channel write
  val tpram = Module(new TPRAM(data_width, depth, ram_style))
  tpram.io.CLKA <> clock
  tpram.io.CLKB <> clock
  tpram.io.CENB <> !io.wen
  tpram.io.CENA <> !io.ren
  tpram.io.AB   <> io.waddr
  tpram.io.AA   <> io.raddr
  tpram.io.DB   <> io.wdata
  tpram.io.QA   <> io.rdata
}

object TPRAM_WRAP {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new TPRAM_WRAP(data_width, depth, ram_style)).io
}

class DPRAM_WRAP(data_width: Int, depth: Int, ram_style: String) extends Module {
  val io = IO(new Bundle() {
    val clock   = Input(Clock())
    val wr_a    = Input(Bool())
    val wr_b    = Input(Bool())
    val en_a    = Input(Bool())
    val en_b    = Input(Bool())
    val addr_a  = Input(UInt(log2Ceil(depth).W))
    val addr_b  = Input(UInt(log2Ceil(depth).W))
    val wdata_a = Input(UInt(data_width.W))
    val wdata_b = Input(UInt(data_width.W))
    val rdata_a = Output(UInt(data_width.W))
    val rdata_b = Output(UInt(data_width.W))
  })
  val dpram = Module(new DPRAM(data_width, depth, ram_style))
  dpram.io.CLKA <> clock
  dpram.io.CLKB <> clock
  dpram.io.WENA <> io.wr_a
  dpram.io.WENB <> io.wr_b
  dpram.io.CENA <> !io.en_a
  dpram.io.CENB <> !io.en_b
  dpram.io.AA   <> io.addr_a
  dpram.io.AB   <> io.addr_b
  dpram.io.DA   <> io.wdata_a
  dpram.io.DB   <> io.wdata_b
  dpram.io.QA   <> io.rdata_a
  dpram.io.QB   <> io.rdata_b
}

object DPRAM_WRAP {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new DPRAM_WRAP(data_width, depth, ram_style)).io
}

//----------------------WGT Dual Port Ram----------------------//
//class TPRAM_256K(data_width:Int,depth:Int,ram_style:String) extends BlackBox(
//  Map("DATA_WIDTH"->data_width,"DEPTH"->depth,"RAM_STYLE_VAL"->ram_style)) with HasBlackBoxPath{
//  val io = IO(new Bundle() {
//    val clock = Input(Clock())
//    val wen = Input(Bool())
//    val ren = Input(Bool())
//    val waddr = Input(UInt(log2Ceil(depth).W))
//    val raddr = Input(UInt(log2Ceil(depth).W))
//    val wdata = Input(UInt(data_width.W))
//    val rdata = Output(UInt(data_width.W))
//  })
//  addPath("./src/main/hdl/TPRAM.v")
//}

object TPRAM_256K {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new TPRAM_WRAP(data_width, depth, ram_style)).io
}

class TPRAM_512K(data_width: Int, depth: Int, ram_style: String) extends Module with buffer_config {
  val io = IO(new Bundle() {
    val wen   = Input(Bool())
    val ren   = Input(Bool())
    val waddr = Input(UInt(log2Ceil(depth).W))
    val raddr = Input(UInt(log2Ceil(depth).W))
    val wdata = Input(UInt(data_width.W))
    val rdata = Output(UInt(data_width.W))
  })
  val tpram_256k = Seq.fill(2)(TPRAM_256K(data_width / 2, 2, ram_style))
  io.rdata            := 0.U
  tpram_256k(0).wdata <> io.wdata(data_width / 2 - 1, 0)
  tpram_256k(1).wdata <> io.wdata(data_width - 1, data_width / 2)
  io.rdata            := Cat(tpram_256k(1).rdata, tpram_256k(0).rdata)
  //  tpram_256k(0).rdata <> io.rdata(data_width / 2 - 1, 0)
  //  tpram_256k(1).rdata <> io.rdata(data_width-1,data_width/2)
  for (i <- 0 until 2) {
    tpram_256k(i).raddr <> io.raddr
    tpram_256k(i).waddr <> io.waddr
    tpram_256k(i).wen   <> io.wen
    tpram_256k(i).ren   <> io.ren
    tpram_256k(i).clock <> clock
  }

}

object TPRAM_512K {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new TPRAM_512K(data_width, depth, ram_style)).io
}

class TPRAM_WGT(data_width: Int, depth: Int, ram_style: String) extends Module with buffer_config {
  val io = IO(new Bundle() {
    //    val clock = Input(Clock())
    val wen   = Input(Bool())
    val ren   = Input(Bool())
    val waddr = Input(UInt(log2Ceil(depth).W))
    val raddr = Input(UInt(log2Ceil(depth).W))
    val wdata = Input(UInt(data_width.W))
    val rdata = Output(UInt(data_width.W))
  })
  val dpram_512k      = Seq.fill((math.ceil(depth / tpram_size)).toInt)(TPRAM_512K(data_width, tpram_size, ram_style))
  val waddr           = Wire(UInt(log2Ceil(tpram_size).W))
  val raddr           = Wire(UInt(log2Ceil(tpram_size).W))
  val sel_rd_ram_512k = Wire(UInt((log2Ceil(depth) - log2Ceil(tpram_size)).W))
  val sel_wr_ram_512k = Wire(UInt((log2Ceil(depth) - log2Ceil(tpram_size)).W))
  waddr           := io.waddr((log2Ceil(tpram_size) - 1), 0)
  raddr           := io.raddr((log2Ceil(tpram_size) - 1), 0)
  sel_rd_ram_512k := io.raddr(log2Ceil(depth) - 1, log2Ceil(tpram_size))
  sel_wr_ram_512k := io.waddr(log2Ceil(depth) - 1, log2Ceil(tpram_size))
  val sel_rd_ram_512k_r = RegNext(sel_rd_ram_512k)
  io.rdata := 0.U
  for (i <- 0 until (math.ceil(depth / tpram_size)).toInt) {
    dpram_512k(i).raddr := 0.U
    dpram_512k(i).ren   := 0.U
    dpram_512k(i).wdata := 0.U
    dpram_512k(i).waddr := 0.U
    dpram_512k(i).wen   := 0.U
  }
  for (i <- 0 until (math.ceil(depth / tpram_size)).toInt) {
    when(sel_rd_ram_512k === i.U) {
      dpram_512k(i).raddr <> raddr
      dpram_512k(i).ren   <> io.ren
    }
  }
  for (i <- 0 until (math.ceil(depth / tpram_size)).toInt) {
    when(sel_rd_ram_512k_r === i.U) {
      dpram_512k(i).rdata <> io.rdata
    }
  }
  for (i <- 0 until (math.ceil(depth / tpram_size)).toInt) {
    when(sel_wr_ram_512k === i.U) {
      dpram_512k(i).wdata <> io.wdata
      dpram_512k(i).waddr <> waddr
      dpram_512k(i).wen   <> io.wen
    }
  }
}

object TPRAM_WGT {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new TPRAM_WGT(data_width, depth, ram_style)).io
}

class DPRAM_FIRST(data_width: Int, depth: Int, ram_style: String) extends Module with buffer_config {
  val io = IO(new Bundle() {
    val wr_a    = Input(Bool())
    val wr_b    = Input(Bool())
    val en_a    = Input(Bool())
    val en_b    = Input(Bool())
    val addr_a  = Input(UInt(log2Ceil(depth).W))
    val addr_b  = Input(UInt(log2Ceil(depth).W))
    val wdata_a = Input(UInt(data_width.W))
    val wdata_b = Input(UInt(data_width.W))
    val rdata_a = Output(UInt(data_width.W))
    val rdata_b = Output(UInt(data_width.W))
  })
  val dpram_second = Seq.fill(2)(DPRAM_WRAP(data_width / 2, dparam_size, ram_style))
  io.rdata_a := 0.U
  io.rdata_b := 0.U
  //  dpram_256k(0).rdata_a <> io.rdata_a(data_width / 2 - 1, 0)
  io.rdata_a            := Cat(dpram_second(1).rdata_a, dpram_second(0).rdata_a)
  io.rdata_b            := Cat(dpram_second(1).rdata_b, dpram_second(0).rdata_b)
  dpram_second(0).wdata_a <> io.wdata_a(data_width / 2 - 1, 0)
  dpram_second(1).wdata_a <> io.wdata_a(data_width - 1, data_width / 2)
  dpram_second(0).wdata_b <> io.wdata_b(data_width / 2 - 1, 0)
  dpram_second(1).wdata_b <> io.wdata_b(data_width - 1, data_width / 2)

  //  dpram_256k(1).rdata_b <> io.rdata_b(data_width - 1, data_width / 2)
  for (i <- 0 until 2) {
    dpram_second(i).addr_a <> io.addr_a
    dpram_second(i).wr_a   <> io.wr_a
    dpram_second(i).en_a   <> io.en_a
    dpram_second(i).addr_b <> io.addr_b
    dpram_second(i).wr_b   <> io.wr_b
    dpram_second(i).en_b   <> io.en_b
    dpram_second(i).clock  <> clock
  }

}

object DPRAM_FIRST {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new DPRAM_FIRST(data_width, depth, ram_style)).io
}

class DPRAM_IFM(data_width: Int, depth: Int, ram_style: String) extends Module with buffer_config {
  val io = IO(new Bundle() {
    val wr_a    = Input(Bool())
    val wr_b    = Input(Bool())
    val en_a    = Input(Bool())
    val en_b    = Input(Bool())
    val addr_a  = Input(UInt(log2Ceil(depth).W))
    val addr_b  = Input(UInt(log2Ceil(depth).W))
    val wdata_a = Input(UInt(data_width.W))
    val wdata_b = Input(UInt(data_width.W))
    val rdata_a = Output(UInt(data_width.W))
    val rdata_b = Output(UInt(data_width.W))
  })
  val dpram_first      = Seq.fill((math.ceil(depth / dparam_size)).toInt)(DPRAM_FIRST(data_width, dparam_size, ram_style))
  val addr_a_ram_first = Wire(UInt(log2Ceil(dparam_size).W))
  val addr_b_ram_first = Wire(UInt(log2Ceil(dparam_size).W))
  val sel_a_ram_first  = Wire(UInt((log2Ceil(depth) - log2Ceil(dparam_size)).W))
  val sel_b_ram_first  = Wire(UInt((log2Ceil(depth) - log2Ceil(dparam_size)).W))
  addr_a_ram_first := io.addr_a((log2Ceil(dparam_size) - 1), 0)
  addr_b_ram_first := io.addr_b((log2Ceil(dparam_size) - 1), 0)
  sel_a_ram_first  := io.addr_a(log2Ceil(depth) - 1, log2Ceil(dparam_size))
  sel_b_ram_first  := io.addr_b(log2Ceil(depth) - 1, log2Ceil(dparam_size))
  val sel_a_ram_512k_r = RegNext(sel_a_ram_first)
  val sel_b_ram_512k_r = RegNext(sel_b_ram_first)
  io.rdata_a := 0.U
  io.rdata_b := 0.U
  for (i <- 0 until (math.ceil(depth / dparam_size)).toInt) {
    dpram_first(i).addr_a  := 0.U
    dpram_first(i).wr_a    := 0.U
    dpram_first(i).en_a    := 0.U
    dpram_first(i).wdata_a := 0.U
    dpram_first(i).addr_b  := 0.U
    dpram_first(i).wr_b    := 0.U
    dpram_first(i).en_b    := 0.U
    dpram_first(i).wdata_b := 0.U
  }
  for (i <- 0 until (math.ceil(depth / dparam_size)).toInt) {
    when(sel_a_ram_first === i.U) {
      dpram_first(i).addr_a  <> addr_a_ram_first
      dpram_first(i).wr_a    <> io.wr_a
      dpram_first(i).en_a    <> io.en_a
      dpram_first(i).wdata_a <> io.wdata_a
    }
    when(sel_a_ram_512k_r === i.U) {
      dpram_first(i).rdata_a <> io.rdata_a
    }
  }

  for (i <- 0 until (math.ceil(depth / dparam_size)).toInt) {
    when(sel_b_ram_first === i.U) {
      dpram_first(i).addr_b  <> addr_b_ram_first
      dpram_first(i).wr_b    <> io.wr_b
      dpram_first(i).en_b    <> io.en_b
      dpram_first(i).wdata_b <> io.wdata_b
    }
    when(sel_b_ram_512k_r === i.U) {
      dpram_first(i).rdata_b <> io.rdata_b
    }
  }
}

object DPRAM_IFM {
  def apply(data_width: Int, depth: Int, ram_style: String) = Module(new DPRAM_IFM(data_width, depth, ram_style)).io
}

//----------------------Synchronous Standard FIFO----------------------//
//ram_style: distributed / block / ultra
class standard_fifo_tpram(WIDTH: Int, DEPTH: Int, RAM_STYLE: String) extends Module {
  val io = IO(new Bundle {
    val enq   = Flipped(Decoupled(UInt(WIDTH.W)))
    val deq   = Decoupled(UInt(WIDTH.W))
    val count = Output(UInt(log2Ceil(DEPTH + 1).W))
  })

  val waddr = RegInit(0.U(log2Ceil(DEPTH).W))
  val raddr = RegInit(0.U(log2Ceil(DEPTH).W))

  val ram_ren = io.deq.ready & io.deq.valid // empty = !io.deq.valid
  val ram_wen = io.enq.valid & io.enq.ready // full = !io.enq.ready

  waddr := Mux(ram_wen, waddr + 1.U, waddr)
  raddr := Mux(ram_ren, raddr + 1.U, raddr)

  val count = RegInit(0.U(log2Ceil(DEPTH + 1).W))
  when(ram_wen & ram_ren) {
    count := count
  }.elsewhen(ram_ren) {
    count := count - 1.U
  }.elsewhen(ram_wen) {
    count := count + 1.U
  }

  val ram = TPRAM_WRAP(WIDTH, DEPTH, RAM_STYLE)
  ram.clock := clock
  ram.ren   := ram_ren
  ram.raddr := raddr
  ram.wen   := ram_wen
  ram.waddr := waddr

  io.enq.ready <> (count =/= DEPTH.U)
  io.enq.bits  <> ram.wdata
  io.deq.valid <> (count =/= 0.U)
  io.deq.bits  <> ram.rdata
  io.count     := count
}

class standard_fifo(WIDTH: Int, DEPTH: Int, RAM_STYLE: String) extends Module {
  val io = IO(new Bundle {
    val enq   = Flipped(Decoupled(UInt(WIDTH.W)))
    val deq   = Decoupled(UInt(WIDTH.W))
    val count = Output(UInt(log2Ceil(DEPTH + 1).W))
  })

  val waddr = RegInit(0.U(log2Ceil(DEPTH).W))
  val raddr = RegInit(0.U(log2Ceil(DEPTH).W))
  val raddr_fix = RegInit(0.U(log2Ceil(DEPTH).W))

  val ram_ren = io.deq.ready & io.deq.valid // empty = !io.deq.valid
  val ram_wen = io.enq.valid & io.enq.ready // full = !io.enq.ready

  waddr := Mux(ram_wen, waddr + 1.U, waddr)
  raddr := Mux(ram_ren, raddr + 1.U, raddr)
  raddr_fix := raddr

  val count = RegInit(0.U(log2Ceil(DEPTH + 1).W))
  when(ram_wen & ram_ren) {
    count := count
  }.elsewhen(ram_ren) {
    count := count - 1.U
  }.elsewhen(ram_wen) {
    count := count + 1.U
  }

  val ram_odd = SPRAM(WIDTH, DEPTH/2, RAM_STYLE)
  val ram_even = SPRAM(WIDTH, DEPTH/2, RAM_STYLE)

  val reg_write_data = RegInit(0.U(WIDTH.W))
  val reg_write_en = RegInit(true.B)
  val reg_write_addr = RegInit(0.U(log2Ceil(DEPTH).W))

  when(ram_ren && ram_wen && (raddr(0) === waddr(0))){
    reg_write_data := io.enq.bits
    reg_write_en := false.B
    reg_write_addr := waddr(log2Ceil(DEPTH)-1, 1)
  }.otherwise{
    reg_write_en := true.B
  }

  val odd_deq = !(ram_ren && raddr(0))
  val odd_enq = !(ram_wen && waddr(0))

  ram_odd.CLK := clock
  ram_odd.CEN := odd_deq && odd_enq && reg_write_en
  ram_odd.WEN := !odd_deq || (odd_enq && reg_write_en)
  ram_odd.A := Mux(!odd_deq, raddr(log2Ceil(DEPTH)-1, 1), Mux(odd_enq, reg_write_addr, waddr(log2Ceil(DEPTH)-1, 1)))
  ram_odd.D := Mux(odd_enq, reg_write_data, io.enq.bits)

  val even_deq = !ram_ren || raddr(0)
  val even_enq = !ram_wen || waddr(0)

  ram_even.CLK := clock
  ram_even.CEN := even_deq && even_enq && reg_write_en
  ram_even.WEN := !even_deq || (even_enq && reg_write_en)
  ram_even.A := Mux(!even_deq, raddr(log2Ceil(DEPTH)-1, 1), Mux(even_enq, reg_write_addr, waddr(log2Ceil(DEPTH)-1, 1)))
  ram_even.D := Mux(even_enq, reg_write_data, io.enq.bits)

  io.enq.ready <> (count =/= DEPTH.U)
  io.deq.valid <> (count =/= 0.U)
  io.deq.bits  <> Mux(!raddr(0), ram_odd.Q, ram_even.Q)
  io.count     := count
}

//----------------------Synchronous Standard FIFO DELAY ONE CLCYE----------------------//
//ram_style: distributed / block / ultra
class standard_fifo_delay(WIDTH: Int, DEPTH: Int, RAM_STYLE: String) extends Module {
  val io = IO(new Bundle {
    val enq   = Flipped(Decoupled(UInt(WIDTH.W)))
    val deq   = Decoupled(UInt(WIDTH.W))
    val count = Output(UInt(log2Ceil(DEPTH + 1).W))
  })

  val fifo         = Module(new standard_fifo(WIDTH, DEPTH, RAM_STYLE))
  val fifo_o_valid = RegInit(false.B) //!empty
  fifo.io.enq  <> io.enq
  io.deq.bits  := RegEnable(fifo.io.deq.bits, 0.U, io.deq.ready)
  io.deq.valid <> fifo_o_valid
  when(fifo.io.deq.ready) {
    fifo_o_valid := true.B
  }.elsewhen(io.deq.ready && !fifo.io.deq.valid) {
    fifo_o_valid := false.B
  }
  fifo.io.deq.ready := (!fifo_o_valid || io.deq.ready) && fifo.io.deq.valid

  val count = RegInit(0.U(log2Ceil(DEPTH + 1).W))
  switch(Cat(io.deq.ready & io.deq.valid, io.enq.valid & io.enq.ready)) {
    is(0.U) {
      count := count
    }
    is(1.U) {
      count := count + 1.U
    }
    is(2.U) {
      count := count - 1.U
    }
    is(3.U) {
      count := count
    }
  }
  io.count := count
}

//----------------------Synchronous FWFT FIFO----------------------//
//ram_style: distributed / block / ultra
//First Word Fall Through
//DELAY_EN: output delay one cycle
class fwft_fifo(WIDTH: Int, DEPTH: Int, RAM_STYLE: String, DELAY_EN: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val enq   = Flipped(Decoupled(UInt(WIDTH.W)))
    val deq   = Decoupled(UInt(WIDTH.W))
    val count = Output(UInt(log2Ceil(DEPTH + 1).W))
  })

  val fifo         = (if (DELAY_EN) Module(new standard_fifo_delay(WIDTH, DEPTH, RAM_STYLE)).io else Module(new standard_fifo(WIDTH, DEPTH, RAM_STYLE)).io)
  val fifo_o_valid = RegInit(false.B) //!empty
  fifo.enq     <> io.enq
  io.deq.bits  <> fifo.deq.bits
  io.deq.valid <> fifo_o_valid
  when(fifo.deq.ready) {
    fifo_o_valid := true.B
  }.elsewhen(io.deq.ready && !fifo.deq.valid) {
    fifo_o_valid := false.B
  }
  fifo.deq.ready := (!fifo_o_valid || io.deq.ready) && fifo.deq.valid

  val count = RegInit(0.U(log2Ceil(DEPTH + 1).W))
  switch(Cat(io.deq.ready & io.deq.valid, io.enq.valid & io.enq.ready)) {
    is(0.U) {
      count := count
    }
    is(1.U) {
      count := count + 1.U
    }
    is(2.U) {
      count := count - 1.U
    }
    is(3.U) {
      count := count
    }
  }
  io.count := count
}

class standard_fifo_two_channel(WIDTH: Int, DEPTH: Int, RAM_STYLE: String) extends Module with dma_config{
  val io = IO(new Bundle {
    val enq = Vec(DMA_CH_WIDTH, (new dmaRData_io(WIDTH)))
    val deq = Vec(DMA_CH_WIDTH, Flipped(new dmaRData_io(WIDTH)))
  })

  val fifo0 = Module(new standard_fifo(WIDTH, DEPTH, RAM_STYLE))
  val fifo1 = if (DMA_CH_WIDTH >= 2) Some(Module(new standard_fifo(WIDTH, DEPTH, RAM_STYLE))) else None
  val count = Vec(DMA_CH_WIDTH, UInt(log2Ceil(DEPTH + 1).W))

  fifo0.io.count <> Wire(count(0))
  fifo0.io.enq.bits := io.enq(0).data
  fifo0.io.enq.valid := io.enq(0).valid
  io.deq(0).data := fifo0.io.deq.bits
  fifo0.io.deq.ready := io.deq(0).valid

  if (DMA_CH_WIDTH >= 2) {
    fifo1.get.io.count <> Wire(count(1))
    fifo1.get.io.enq.bits := io.enq(1).data
    fifo1.get.io.enq.valid := io.enq(1).valid
    io.deq(1).data := fifo1.get.io.deq.bits
    fifo1.get.io.deq.ready := io.deq(1).valid
    io.deq(0).valid := fifo0.io.deq.valid && fifo1.get.io.deq.valid
    io.deq(1).valid := fifo0.io.deq.valid && fifo1.get.io.deq.valid
  } else {
    io.deq(0).valid := fifo0.io.deq.valid
  }
}
