package cim
import axi_fun.{connect_axi_r, connect_axi_w, w_ch_zero}
import chisel3.{Input, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.{Decoupled, ShiftRegister, Valid, is, switch}
import chisel3.util._
import chisel3.util.experimental.forceName


class dma_cim(DMA_SIZE_WIDTH:Int,DMA_ADDR_WIDTH:Int,DMA_DATA_WIDTH:Int) extends Bundle{
  val dma_ch_r = new dmaR_io(DMA_ADDR_WIDTH, DMA_DATA_WIDTH)
  val dma_ch_r_areq = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))
  val dma_ch_w = new dmaW_io(DMA_ADDR_WIDTH, DMA_DATA_WIDTH)
  val dma_ch_w_areq = Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))
}
class top extends Module with hw_config {
  val io = IO(new Bundle() {

    /** ******************************************* simulation ***********************************************
     */
    //cim
    val din_valid_ConV = if (!SIM_MODE) Some(Input(Bool())) else None //need to accel_axi_lite
    val input_data_valid = if (!SIM_MODE) Some(Input(Bool())) else None //need to accel_axi_lite
    val wgt_data_valid = if (!SIM_MODE) Some(Input(Bool())) else None
    val wgt_buffer_done = Output(Bool())
    val ofm_buffer_done = Output(Bool())
    val dout_valid_ConV = Output(Bool())
    val buffer_busy = if (!SIM_MODE) Some(Output(Bool())) else None // for pipeline, no use in hardware mode

    val axi_ch1 = new axiIO
    val axi_ch2 = new axiIO
    val test3 = Output(Bool())
    val test6 = Output(Bool())
    val test9 = Output(Bool())
    val test12 = Output(Bool())
    val test15 = Output(Bool())

    val dma_ch0_r = if (!SIM_MODE) Some(Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))) else None
    val dma_ch1_r = if (!SIM_MODE) Some(Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))) else None
    val dma_ch0_w = if (!SIM_MODE) Some(Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))) else None
    val dma_ch1_w = if (!SIM_MODE) Some(Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))) else None

    //    val dma_ch_0 = if (SIM_MODE) Some(new dma_cim(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH, DMA_DATA_WIDTH)) else None
    //    val dma_ch_1 = if (SIM_MODE) Some(new dma_cim(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH, DMA_DATA_WIDTH)) else None

    val sim_alu_reg = if (!SIM_MODE) Some(Input(new reg_alu_io)) else None
    val sim_pool_reg = if (!SIM_MODE) Some(Input(new reg_pool_io)) else None
    val sim_gemm_reg = if (!SIM_MODE) Some(Input(new reg_gemm_io)) else None
    val sim_reset_reg = if (!SIM_MODE) Some(Input(new reg_reset_io)) else None
    val sim_areq_reg = if (!SIM_MODE) Some(Flipped(new dmaCtrl_io(DMA_SIZE_WIDTH, DMA_ADDR_WIDTH))) else None
  })

  /** ******************************************* dma ***********************************************
   */
  print("start exec......\n")
  if (!SIM_MODE) {

    val dma_ch_cim = VecInit(Seq.fill(2)(Module(new dma_ch).io))
    val regMap = Module(new regMap)

    regMap.io.reg_alu.get <> io.sim_alu_reg.get
    regMap.io.reg_pool.get <> io.sim_pool_reg.get
    regMap.io.reg_gemm.get <> io.sim_gemm_reg.get
    regMap.io.reg_reset.get <> io.sim_reset_reg.get
    regMap.io.reg_areq_i.get <> io.sim_areq_reg.get
    dma_ch_cim(0).dmar_gemm.get.areq <> io.dma_ch0_r.get
    dma_ch_cim(0).dmaw_sendbuf.get.areq <> io.dma_ch0_w.get
    dma_ch_cim(1).dmar_gemm.get.areq <> io.dma_ch1_r.get
    dma_ch_cim(1).dmaw_sendbuf.get.areq <> io.dma_ch1_w.get


    val axi_ch0_ctrl = Module(new axi_r_ctrl)
    val axi_ch1_ctrl = Module(new axi_r_ctrl)

    lazy val axi_send = Module(new axiSendBuffer)

    axi_ch0_ctrl.io.dma <> dma_ch_cim(0).dmaR
    axi_ch1_ctrl.io.dma <> dma_ch_cim(1).dmaR
    connect_axi_r(axi_ch0_ctrl.io.axi, io.axi_ch1)
    connect_axi_r(axi_ch1_ctrl.io.axi, io.axi_ch2)

    axi_send.io.opfusion_send_ch0.data <> dma_ch_cim(0).dmaW.data
    axi_send.io.opfusion_send_ch0.size <> dma_ch_cim(0).dmaW.size
    axi_send.io.opfusion_send_ch0.addr <> dma_ch_cim(0).dmaW.addr
    //  axi_send.io.opfusion_send_ch0.data_valid <> dma_ch_cim(0).dmaW.areq
    axi_send.io.opfusion_send_ch0.size_valid <> dma_ch_cim(0).dmaW.areq
    axi_send.io.opfusion_send_ch0.addr_valid <> dma_ch_cim(0).dmaW.areq
    axi_send.io.opfusion_send_ch1.data <> dma_ch_cim(1).dmaW.data
    axi_send.io.opfusion_send_ch1.size <> dma_ch_cim(1).dmaW.size
    axi_send.io.opfusion_send_ch1.addr <> dma_ch_cim(1).dmaW.addr
    //  axi_send.io.opfusion_send_ch1.data_valid <> dma_ch_cim(1).dmaW.areq
    axi_send.io.opfusion_send_ch1.size_valid <> dma_ch_cim(1).dmaW.areq
    axi_send.io.opfusion_send_ch1.addr_valid <> dma_ch_cim(1).dmaW.areq
    dma_ch_cim(0).dmaW.valid := dma_ch_cim(0).dmaW.areq
    dma_ch_cim(1).dmaW.valid := dma_ch_cim(1).dmaW.areq
    dma_ch_cim(0).dmaW.busy := false.B
    dma_ch_cim(1).dmaW.busy := false.B

    connect_axi_w(axi_send.io.axi_ch0, io.axi_ch1)
    connect_axi_w(axi_send.io.axi_ch1, io.axi_ch2)

    val fifo = Module(new standard_fifo_two_channel(WIDTH = DMA_DATA_WIDTH, DEPTH = 32, RAM_STYLE = "block"))

    /** ******************************************* IfmBuffer ***********************************************
     */
    val ifmbuffer = Module(new ifm_buffer())

    ifmbuffer.io.din_valid_ConV := io.din_valid_ConV.get
    ifmbuffer.io.input_data_valid := io.input_data_valid.get

    for (num <- 0 until DMA_CH_WIDTH) {
      fifo.io.enq(num) <> dma_ch_cim(num).dmar_gemm.get.data
      ifmbuffer.io.dma_to_buffer(num) <> fifo.io.deq(num)
      //    ifmbuffer.io.dma_to_buffer(num) <> dma_ch_cim(num).dmar_gemm.get.data   //if no fifo use this
    }
    ifmbuffer.io.dout_valid_ConV := io.dout_valid_ConV


    /** ******************************************* weight_buffer ***********************************************
     */

    val wgt_rst = reset

    val wgtbuffer = withReset(wgt_rst) {
      Module(new wgt_buffer())
    }

    wgtbuffer.io.wgt_data_valid <> io.wgt_data_valid.get

    wgtbuffer.io.test3 <> io.test3
    wgtbuffer.io.test6 <> io.test6
    wgtbuffer.io.test9 <> io.test9
    wgtbuffer.io.test12 <> io.test12
    wgtbuffer.io.test15 <> io.test15
    wgtbuffer.io.wgt_buffer_done <> io.wgt_buffer_done
    for (num <- 0 until DMA_CH_WIDTH) {
      fifo.io.enq(num) <> dma_ch_cim(num).dmar_gemm.get.data
      wgtbuffer.io.dma_to_wgtbuffer(num) <> fifo.io.deq(num)
      //    wgtbuffer.io.dma_to_wgtbuffer(num) <> dma_ch_cim(num).dmar_gemm.get.data
    }

    /** ******************************************* ofm buffer ***********************************************
     */

    //  val fifo_out = Module(new standard_fifo_two_channel(WIDTH = DMA_DATA_WIDTH, DEPTH = 8, RAM_STYLE = "block"))
    val outbuffer = Module(new out_buffer())

    outbuffer.io.output_data_valid := io.dout_valid_ConV
    //  io.ofm_buffer_done := outbuffer.io.ofm_buffer_done

    val ofm_buffer_done = RegInit(false.B)
    io.ofm_buffer_done := ofm_buffer_done

    val s0 :: s1 :: s2 :: Nil = Enum(3)
    val state_out = RegInit(s0)

    switch(state_out) {
      is(s0) {
        when(io.axi_ch1.m_wlast && io.axi_ch2.m_wlast) {
          state_out := s0
          ofm_buffer_done := 1.U
        }.elsewhen(io.axi_ch1.m_wlast) {
          state_out := s1
          ofm_buffer_done := 0.U
        }.elsewhen(io.axi_ch2.m_wlast) {
          state_out := s2
          ofm_buffer_done := 0.U
        }.otherwise {
          state_out := s0
          ofm_buffer_done := 0.U
        }
      }
      is(s1) {
        when(io.axi_ch2.m_wlast) {
          state_out := s0
          ofm_buffer_done := 1.U
        }.otherwise {
          state_out := s1
          ofm_buffer_done := 0.U
        }
      }
      is(s2) {
        when(io.axi_ch1.m_wlast) {
          state_out := s0
          ofm_buffer_done := 1.U
        }.otherwise {
          state_out := s2
          ofm_buffer_done := 0.U
        }
      }
    }

    for (num <- 0 until DMA_CH_WIDTH) {
      outbuffer.io.output_to_dma(num) <> dma_ch_cim(num).dmaw_sendbuf.get.data
      //    fifo_out.io.deq(num) <> dma_ch_cim(num).dmaw_sendbuf.get.data
      //    outbuffer.io.output_to_dma(num) <> fifo_out.io.enq(num)
    }
    axi_send.io.opfusion_send_ch0.data_valid := outbuffer.io.ofm_buffer_valid(0)
    axi_send.io.opfusion_send_ch1.data_valid := outbuffer.io.ofm_buffer_valid(1)
    for (num <- 0 until 2 - DMA_CH_WIDTH) {
      dma_ch_cim(1 - num).dmaw_sendbuf.get.data.data := 0.U
    }

    /** ******************************************* cim ***********************************************
     */
      val cim_macro = Module(new top_cim())


    cim_macro.io.din_valid_ConV <> io.din_valid_ConV.get


    cim_macro.io.dout_valid_ConV <> io.dout_valid_ConV
    cim_macro.io.buffer_busy.get <> io.buffer_busy.get
    cim_macro.io.BL <> wgtbuffer.io.buffer_to_BL
    cim_macro.io.WL <> wgtbuffer.io.buffer_to_WL
    cim_macro.io.IN <> ifmbuffer.io.buffer_to_input
    cim_macro.io.ifm_buffer_ready.get <> ifmbuffer.io.ifm_buffer_ready
    cim_macro.io.sum_out <> outbuffer.io.sum_out
  } else{

  }
}



object top_gen extends App with hw_config {
  if (SIM_MODE){
    new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "/home/cqi/hw_part/hw_ncnnAccel/simulator/vsrc"), Seq(ChiselGeneratorAnnotation(() => new top)))
  }
  else{
    new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "/home/cqi/hw_part/hw_ncnnAccel/simulator/vsrc_sys"), Seq(ChiselGeneratorAnnotation(() => new top)))
  }
//  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "/home/ws/ws/simulation_hw_state/vsrc_sim"), Seq(ChiselGeneratorAnnotation(() => new top)))
}
