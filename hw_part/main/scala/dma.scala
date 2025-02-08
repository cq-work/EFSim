package cim
import chisel3.{Wire, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

class dma_r extends Bundle with dma_config {
  val id = Input(UInt(log2Ceil(RID.values.toList.max + 1).W))
  val busy = Input(Bool())
  val areq = new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH)
  val data = new dmaRData_io(DMA_DATA_WIDTH)
}

class dma_w extends Bundle with dma_config {
  val id = Input(UInt(log2Ceil(WID.values.toList.max + 1).W))
  val busy = Input(Bool())
  val areq = new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH)
  val data = new dmaWData_io(DMA_DATA_WIDTH)
}

//dma read port
class dmaR_io(DMA_ADDR_WIDTH:Int,DMA_DATA_WIDTH:Int) extends Bundle{
  val addr = Output(UInt(DMA_ADDR_WIDTH.W))
  val areq = Output(Bool())
  val size = Output(UInt(32.W))
  val busy = Input(Bool())
  val outstanding_almost_full = Input(Bool())
  val outstanding_empty = Input(Bool())
  val data = Input(UInt(DMA_DATA_WIDTH.W))
  val valid = Input(Bool())
  val ready = Output(Bool())
  val last  = Input(Bool())
}

//dma write port
class dmaW_io(DMA_ADDR_WIDTH:Int,DMA_DATA_WIDTH:Int) extends Bundle{
  val addr = Output(UInt(DMA_ADDR_WIDTH.W))
  val areq = Output(Bool())
  val size = Output(UInt(32.W))
  val busy = Input(Bool())
  val data = Output(UInt(DMA_DATA_WIDTH.W))
  val valid = Input(Bool())
  val ready = Output(Bool())
}

class dmaCtrl_io(DMA_SIZE_WIDTH:Int,DMA_ADDR_WIDTH:Int) extends Bundle{
  val dmaEn = Output(Bool())
  val dmaAreq = Output(Bool())
  val dmaSize = Output(UInt(DMA_SIZE_WIDTH.W))
  val dmaAddr = Output(UInt(DMA_ADDR_WIDTH.W))
}

class dmaRData_io(DMA_DATA_WIDTH:Int) extends Bundle{
  val valid = Input(Bool())
  val data = Input(UInt(DMA_DATA_WIDTH.W))
}

class dmaWData_io(DMA_DATA_WIDTH:Int) extends Bundle{
  val valid = Input(Bool())
  val data = Output(UInt(DMA_DATA_WIDTH.W))
}

class dmaRAreqAbrit extends Module with dma_config {
  val io = IO(new Bundle() {
    val gemmAreq = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))
    //...
    val sel          = Output(UInt(log2Ceil(RID.values.toList.max+1).W))
    val toDma        = new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH)
  })

  val sChose :: sKeep :: sFinish :: Nil = Enum(3)
  val state = RegInit(sChose)

  val sel = RegInit(0.U)
  val addr = RegInit(0.U)
  val size = RegInit(0.U)
  val en = RegInit(0.U)
  val areq = RegInit(0.U)

  //dmaEn must be high during select
  switch(state){
    is(sChose){
      sel := 0.U
      state := sChose
      when(io.gemmAreq.dmaEn){
        sel := RID("gemm").U
        state := sKeep
      }
      //...
    }
    is(sKeep)   {state := Mux(fallEdge(io.toDma.dmaEn),sFinish,sKeep)}
    is(sFinish) {state := sChose}
  }

  //allocate data based on sel
  switch(sel){
    is(0.U){  //no effect
      en := false.B
    }
    is(RID("gemm").U) { //dma_gemm
      en := io.gemmAreq.dmaEn
      addr := io.gemmAreq.dmaAddr
      size := io.gemmAreq.dmaSize
      areq := io.gemmAreq.dmaAreq
    }
    //...
  }
  io.sel := sel;
  io.toDma.dmaAddr := addr
  io.toDma.dmaSize := size
  io.toDma.dmaEn := en
  io.toDma.dmaAreq := areq
}

class dmaWAreqAbrit extends Module with dma_config {
  val io = IO(new Bundle() {
    val sendBufferAreq = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))
    //...
    val sel          = Output(UInt(log2Ceil(WID.values.toList.max+1).W))
    val toDma        = new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH)
  })

  val sChose :: sKeep :: sFinish :: Nil = Enum(3)
  val state = RegInit(sChose)

  val sel = RegInit(0.U)
  val addr = RegInit(0.U)
  val size = RegInit(0.U)
  val en = RegInit(0.U)
  val areq = RegInit(0.U)

  //dmaEn must be high during select
  switch(state){
    is(sChose){
      sel := 0.U
      state := sChose
      when(io.sendBufferAreq.dmaEn){
        sel := WID("dmaSendBuf").U
        state := sKeep
      }
      //...
    }
    is(sKeep)   {state := Mux(fallEdge(io.toDma.dmaEn),sFinish,sKeep)}
    is(sFinish) {state := sChose}
  }

  //allocate data based on sel
  switch(sel){
    is(0.U){  //no effect
      en := false.B
    }
    is(WID("dmaSendBuf").U){
      en := io.sendBufferAreq.dmaEn
      addr := io.sendBufferAreq.dmaAddr
      size := io.sendBufferAreq.dmaSize
      areq := io.sendBufferAreq.dmaAreq
    }
    //...
  }
  io.sel := sel;
  io.toDma.dmaAddr := addr
  io.toDma.dmaSize := size
  io.toDma.dmaEn := en
  io.toDma.dmaAreq := areq
}

//----------------------read channel----------------------//
class dmaRBufSel extends Module with dma_config{
  val io = IO(new Bundle() {
    val sel = Input(UInt(log2Ceil(RID.values.toList.max+1).W))
    val dataIn = new dmaRData_io(DMA_DATA_WIDTH)
    val gemmData = Flipped(new dmaRData_io(DMA_DATA_WIDTH))
    //...
  })
  io.gemmData.data := Mux(io.sel === RID("gemm").U, io.dataIn.data, 0.U)
  io.gemmData.valid := Mux(io.sel === RID("gemm").U, io.dataIn.valid, 0.U)
  //...
}

class dmaR extends Module with dma_config{
  val io = IO(new Bundle() {
    val dma_r = new dmaR_io(DMA_ADDR_WIDTH,DMA_DATA_WIDTH)
    val dataOut = Flipped(new dmaRData_io(DMA_DATA_WIDTH))
    val dmaCtrl = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))  //ctrl input
    val dmaRbusy = Output(Bool())
  })
  io.dma_r.ready := io.dmaCtrl.dmaEn
  io.dma_r.areq := io.dmaCtrl.dmaAreq
  io.dma_r.addr := io.dmaCtrl.dmaAddr
  io.dma_r.size := io.dmaCtrl.dmaSize
  io.dataOut.valid := RegNext(io.dma_r.valid)
  io.dataOut.data := RegNext(io.dma_r.data)
  io.dmaRbusy := RegNext(io.dma_r.busy)
//  io.dataOut.valid := io.dma_r.valid
//  io.dataOut.data := io.dma_r.data
//  io.dmaRbusy := io.dma_r.busy
}

//----------------------write channel----------------------//
class dmaWBufSel extends Module with dma_config{
  val io = IO(new Bundle() {
    val sel = Input(UInt(log2Ceil(WID.values.toList.max+1).W))
    val dataOut = new dmaWData_io(DMA_DATA_WIDTH)
    val sendBufferData = Flipped(new dmaWData_io(DMA_DATA_WIDTH))
    //...
  })

  io.dataOut.data := 0.U
  io.sendBufferData.valid := 0.U
  when(io.sel === WID("dmaSendBuf").U) {
    io.dataOut.data := io.sendBufferData.data
    io.sendBufferData.valid := io.dataOut.valid
  }
  //...
}

class dmaW extends Module with dma_config{
  val io = IO(new Bundle() {
    val dma_w = new dmaW_io(DMA_ADDR_WIDTH,DMA_DATA_WIDTH)
    val dataIn = Flipped(new dmaWData_io(DMA_DATA_WIDTH))
    val dmaCtrl = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))  //ctrl input
    val dmaWbusy = Output(Bool())
  })
  io.dma_w.ready := 1.U
  io.dma_w.areq := io.dmaCtrl.dmaAreq
  io.dma_w.addr := io.dmaCtrl.dmaAddr
  io.dma_w.size := io.dmaCtrl.dmaSize
  io.dma_w.data := io.dataIn.data
  io.dataIn.valid := io.dma_w.valid
  io.dmaWbusy := io.dma_w.busy
}

//-------------------------axi_full--------------------------//

//class axi_full_io(id_width:Int, axi_addr_width:Int = 32, axi_data_width:Int = 128) extends Bundle{
//  val axi_awid = Output(UInt(id_width.W))
//  val axi_awaddr = Output(UInt(axi_addr_width.W))
//  val axi_awlen = Output(UInt(8.W))
//  val axi_awsize = Output(UInt(3.W))
//  val axi_awburst = Output(UInt(2.W))
//  val axi_awlock = Output(Bool())
//  val axi_awcache = Output(UInt(4.W))
//  val axi_awprot = Output(UInt(3.W))
//  val axi_awqos = Output(UInt(4.W))
//  val axi_awvalid = Output(Bool())
//  val axi_awready = Input(Bool())
//  val axi_wid = Output(UInt(id_width.W))
//  val axi_wdata = Output(UInt(axi_data_width.W))
//  val axi_wstrb = Output(UInt((axi_data_width / 8).W))
//  val axi_wlast = Output(Bool())
//  val axi_wvalid = Output(Bool())
//  val axi_wready = Input(Bool())
//  val axi_bid = Input(UInt(id_width.W))
//  val axi_bresp = Input(UInt(2.W))
//  val axi_bvalid = Input(Bool())
//  val axi_bready = Output(Bool())
//  val axi_arid = Output(UInt(id_width.W))
//
//  val axi_araddr = Output(UInt(axi_addr_width.W))
//  val axi_arlen = Output(UInt(8.W))
//  val axi_arsize = Output(UInt(3.W))
//  val axi_arburst = Output(UInt(2.W))
//  val axi_arlock = Output(Bool())
//  val axi_arcache = Output(UInt(4.W))
//  val axi_arprot = Output(UInt(3.W))
//  val axi_arqos = Output(UInt(4.W))
//  val axi_arvalid = Output(Bool())
//  val axi_arready = Input(Bool())
//  val axi_rid = Input(UInt(id_width.W))
//  val axi_rdata = Input(UInt(axi_data_width.W))
//  val axi_rresp = Input(UInt(2.W))
//  val axi_rlast = Input(Bool())
//  val axi_rvalid = Input(Bool())
//  val axi_rready = Output(Bool())
//}
//
//class axi_dma(id:Int, id_width:Int, axi_addr_width:Int = 32, axi_data_width:Int = 128) extends BlackBox(
//  Map("M_AXI_ID"->id, "M_AXI_ID_WIDTH"->id_width, "M_AXI_ADDR_WIDTH"->axi_addr_width, "M_AXI_DATA_WIDTH"->axi_data_width)) with HasBlackBoxPath{
//  val io = IO(new Bundle{
//    val m_axi_aclk = Input(Clock())
//    val m_axi_aresetn = Input(Bool())
//    val fdma_w = Flipped(new dmaW_io(axi_addr_width,axi_data_width))
//    val fdma_r = Flipped(new dmaR_io(axi_addr_width,axi_data_width))
//    val m = new axi_full_io(id_width, axi_addr_width, axi_data_width)
//  })
//  addPath("./src/main/hdl/axi_dma.v")
//}


class dma_ch() extends  Module with hw_config{
  val io = IO(new  Bundle() {
    val dmaR = new dmaR_io(DMA_ADDR_WIDTH, DMA_DATA_WIDTH)
    val dmaW = new dmaW_io(DMA_ADDR_WIDTH,DMA_DATA_WIDTH)
    //----------------------read channel----------------------//
    val dmar_gemm = Some(Flipped(new dma_r))

    //----------------------write channel----------------------//
    val dmaw_sendbuf = Some(Flipped(new dma_w))
    //...
  })

  //----------------------read channel----------------------//
  val dmaR = Module(new dmaR)
  val dmaRBufSel = Module(new dmaRBufSel)
  val dmaRAreqAbrit = Module(new dmaRAreqAbrit)
  dmaR.io.dma_r <> io.dmaR
  dmaR.io.dmaCtrl <> dmaRAreqAbrit.io.toDma
  dmaRBufSel.io.sel := dmaRAreqAbrit.io.sel
  dmaRBufSel.io.dataIn <> dmaR.io.dataOut

  io.dmar_gemm.get.data <> dmaRBufSel.io.gemmData
  dmaRAreqAbrit.io.gemmAreq <> io.dmar_gemm.get.areq
  io.dmar_gemm.get.id := dmaRAreqAbrit.io.sel
  io.dmar_gemm.get.busy := dmaR.io.dmaRbusy
  //...

  //----------------------write channel----------------------//
  val dmaW = Module(new dmaW)
  val dmaWBufSel = Module(new dmaWBufSel)
  val dmaWAreqAbrit = Module(new dmaWAreqAbrit)
  dmaW.io.dma_w <> io.dmaW
  dmaW.io.dmaCtrl <> dmaWAreqAbrit.io.toDma
  dmaWBufSel.io.sel := dmaWAreqAbrit.io.sel
  dmaWBufSel.io.dataOut <> dmaW.io.dataIn

  io.dmaw_sendbuf.get.data <> dmaWBufSel.io.sendBufferData
  dmaWAreqAbrit.io.sendBufferAreq <> io.dmaw_sendbuf.get.areq
  io.dmaw_sendbuf.get.id := dmaWAreqAbrit.io.sel
  io.dmaw_sendbuf.get.busy := dmaW.io.dmaWbusy
  //...
}

object dma_ch_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/test/dma"),Seq(ChiselGeneratorAnnotation(()=>new dma_ch)))
}