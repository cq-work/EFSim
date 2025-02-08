package conv_sin
import chisel3._
import chisel3.util.log2Up
trait cim_config {
  val tile_num     = 2
  val tile2pe_num  = 4
  val pe2array_num = 4
  val array_row    = 128
  val array_col    = 128
  val unit_col     = 8
  val unit_num     = 16
  val O_width      = 32
}

trait adder_tree_config extends cim_config {
  val DATA_WIDTH   = 8
  //  val RESULT_WIDTH = 15
  val RESULT_WIDTH = log2Up(array_row + 1) + DATA_WIDTH - 1
}
