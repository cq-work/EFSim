package cim
import chisel3._
import chisel3.util.log2Up


trait dma_config {
  val SIM_MODE         = false
  val DMA_ADDR_WIDTH   = 64
  val DMA_SIZE_WIDTH   = 32
  val DMA_DATA_WIDTH   = 128
  val DMA_CH_WIDTH     = 2
  val RID              = Map("alu" -> 1, "gemm" -> 2, "pool" -> 3, "opfusion" -> 4)
  val DMA_R_CH0_EN_CFG = Map("alu" -> true, "gemm" -> true, "pool" -> true, "opfusion" -> false)
  val DMA_R_CH1_EN_CFG = Map("alu" -> true, "gemm" -> true, "pool" -> true, "opfusion" -> true)
  val WID              = Map("dmaSendBuf" -> 1)
  val DMA_W_CH0_EN_CFG = Map("dmaSendBuf" -> true)
  val DMA_W_CH1_EN_CFG = Map("dmaSendBuf" -> true)
  val AXI_ID           = 0
  val ACCEL_AXI_LITE_DATA_WIDTH = 32
  val ACCEL_AXI_LITE_ADDR_WIDTH = 9
}

trait axi_config extends dma_config with cim_config {
  val AXI_ADDR_WIDTH   = 64
  val AXI_SIZE_WIDTH   = 32
  val AXI_DATA_WIDTH   = 128
  val AXI_R_CH0_EN_CFG = Map("alu" -> true, "gemm_ifm" -> true, "gemm_wgt" -> true, "pool" -> true, "opfusion" -> false)
  val AXI_R_CH1_EN_CFG = Map("alu" -> true, "gemm_ifm" -> true, "gemm_wgt" -> true, "pool" -> true, "opfusion" -> true)
  val AXI_SEND_ID      = Map("alu" -> 1, "gemm_ofm" -> 2, "pool" -> 3)
  val AXI_W_OUTSTANDING = 16
  val AXI_R_OUTSTANDING = 16
  val AXI_SEND_BUFFER_DEPTH    = tile_num*tile2pe_num*pe2array_num*unit_num*O_width/(DMA_CH_WIDTH*DMA_DATA_WIDTH)
//  val AXI_SEND_BUFFER_DEPTH    = 8
  val ALU_SRC_DEPTH            = 0
//  val AXI_SEND_BUFFER_DEPTH    = 1024
//  val ALU_SRC_DEPTH            = 128
}

trait buffer_config {
  val ifm_buffer_size =  65536   //2MB
  val ifm_buffer_width = 256     //64Bytes
  val wgt_buffer_width = 8*32
  val wgt_buffer_size = 16*1024 //512KB*2
  val ofm_buffer_size = 1024      //128KB
  val bias_buffer_size = 256
  val oscale_buffer_size = 256
  val tpram_size = 2
  val dparam_size = 2
}

trait hw_config extends dma_config with buffer_config with mesh_config{
  val ACCEL_AXI_DATA_WIDTH = 32
  val ACCEL_AXI_ADDR_WIDTH = 7
  val MATH_AXI_DATA_WIDTH = 32
  val MATH_AXI_ADDR_WIDTH = 4
  val alu_mathfunc_en = true
  val alu_mat_en = true
  val pool_en = true
  val gemm_en = true   //when simulation gemm_en, im2col_sim = wgtbuf_sim = ifmbuf_sim = accmem_sim = opfusion_sim = ofmbuf_sim = 0

  val im2col_sim = false   //when only simulation im2col or wgtbuf, if im2col_sim ^ wgtbuf_sim = 1
  val wgtbuf_sim = false
  val ifmbuf_sim = false   //when simulation ifmbuf, if im2col_sim = wgtbuf_sim = 1
  val accmem_sim = false   //when simulation accmem, if im2col_sim = wgtbuf_sim =  ifmbuf_sim = 1
  val opfusion_sim = false   //when simulation opfusion, if im2col_sim = wgtbuf_sim =  ifmbuf_sim =  accmem_sim = 1
  val ofmbuf_sim = false      //when simulation ofmbuf, if im2col_sim = wgtbuf_sim =  ifmbuf_sim =  accmem_sim = opfusion_sim = 0

  val gemm_acc = false
  val gemm_ifm = false

  if(gemm_en) assert(!(im2col_sim | wgtbuf_sim | ifmbuf_sim | accmem_sim | opfusion_sim | ofmbuf_sim))
  if(!ifmbuf_sim & !accmem_sim & (im2col_sim | wgtbuf_sim))  assert(im2col_sim ^ wgtbuf_sim)
  if(ifmbuf_sim) assert(im2col_sim & wgtbuf_sim)
  if(accmem_sim) assert(im2col_sim & wgtbuf_sim & ifmbuf_sim)
  if(opfusion_sim) assert(!(im2col_sim & wgtbuf_sim & ifmbuf_sim & accmem_sim))
  if(ofmbuf_sim) assert(!(im2col_sim | wgtbuf_sim | ifmbuf_sim | accmem_sim ))

  val dma_en = alu_mat_en || pool_en || gemm_en
}

trait alu_mat_config extends dma_config{
  val alu_mul_id = 0.U
  val alu_add_id = 1.U
  val alu_abs_id = 2.U
  val ALU_DATA_WIDTH = DMA_DATA_WIDTH
  val ALU_BURST_LEN = 256
  val alu_format_int32 = 1.U
  val alu_format_float32 = 2.U
  val alu_add_en = true
  val alu_mul_en = true
  val alu_abs_en = false
}

trait alu_mathfunc_config{
  val alu_sin_id = 0.U
  val alu_cos_id = 1.U
  val alu_atan_id = 2.U
  val alu_sqrt_id = 3.U
  val alu_iexp_id = 4.U
  val alu_log_id = 5.U
  val alu_sin_cos_en = true
  val alu_atan_en = true
  val alu_sqrt_en = true
  val alu_iexp_en = true
  val alu_log_en = true
}



trait cal_cell_params{
  val fp32_add_cycles = 2
  val fp32_mul_cycles = 2
  val fp32_addmul_cycles = 3
  val int32_add_cycles = 1
  val int32_mul_cycles = 1
  val in32_addmul_cycles = 1
  val sint_to_fp32_cycles = 1
  val fp32_to_sint_cycles = 2
  val relu_cycles = 0
  val leakyrelu_cycles = fp32_mul_cycles
}

trait activation_config{
  val None = 0.U
  val ReLU = 1.U
  val LeakyReLU = 2.U
}

trait gemm_config{
  val Mat32_FP32 = 0.U
  val Mat32_INT32 = 1.U
  val IFM_FP32 = 2.U
  val IFM_INT8 = 3.U
}

trait pe_config {
  //float int8 int32
  //int8 int32
  //  val data_type = 2.U
  val pe_data_w = 32
  val wgt_data_w = 8
}

trait mesh_config extends pe_config {
  val mesh_size = 32
  val mesh_rows = mesh_size
  val mesh_columns = mesh_size
  val ofm_buffer_addr_w = log2Up(mesh_rows)
}


trait cim_config extends dma_config {
  val tile_num     = 1
  val tile2pe_num  = 2
  val pe2array_num = 2
  val array_row    = 128
  val array_col    = 128
  val unit_col     = 8
  val unit_num     = array_col/unit_col
  val O_width      = 32
  val DATA_WIDTH   = 8
  val pipeline     = false
//  val pipeline     = (tile_num*tile2pe_num*array_row*DATA_WIDTH+tile_num*tile2pe_num*pe2array_num*unit_num*O_width)/(DMA_CH_WIDTH*DMA_DATA_WIDTH)<=14
}

trait adder_tree_config extends cim_config {

//  val RESULT_WIDTH = 15
  val RESULT_WIDTH = log2Up(array_row + 1) + DATA_WIDTH - 1
  val ARRAY_RESULT_WIDTH = RESULT_WIDTH + unit_col
  val numStates = RESULT_WIDTH + 3
}