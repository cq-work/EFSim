//package conv_sin_except
//import chisel3._
//import chisel3.stage.ChiselGeneratorAnnotation
//import chisel3.util._
//class CIM_before extends Module{
//  val io = IO(new Bundle() {
//    val cos_op_en       = Input(Bool())
//    val sin_op_en       = Input(Bool())
//    val cos_rb          = Input(UInt(32.W))
//    val sin_rb          = Input(UInt(32.W))
//    val Sign_out        = Output(Bool())
//    val cs              = Output(Bool())
//    val f34_zero_flag   = Output(Bool())
//    val F1              = Output(Bool())
//    val index_out       = Output(UInt(13.W))
//    val data_in         = Output(UInt(23.W))
//    val OF_flag         = Output(Bool())
//    val U_flag          = Output(Bool())
//    val num_zero        = Output(UInt(6.W))
//    val SR1          = Output(UInt(8.W))
//    val SR2          = Output(UInt(8.W))
//  })
//
//  val PI = Wire(UInt(24.W))
//  PI := "b110010010000111111011011".U
//
//  //sincos
//  val enabled_sin_rb = Wire(UInt(32.W))
//  val enabled_cos_rb = Wire(UInt(32.W))
//
//  //logic cs;                     //cos1    sin0
//  val b = Wire(UInt(32.W)) //
//  enabled_sin_rb := Mux(io.sin_op_en, io.sin_rb, "h0000_0000".U) //   sincos
//  enabled_cos_rb := Mux(io.cos_op_en, io.cos_rb, "h0000_0000".U) //   sincos
//  io.cs := !io.sin_op_en && io.cos_op_en //cs= 1   cos    cs= 0 sin
//  b := Mux(io.cs, enabled_cos_rb, enabled_sin_rb) //cs = 1  bcos_rb(32)   cs = 0  bsin_rb(32)
//
//  //logic OF_flag;
//  //logic U_flag;
//  io.OF_flag := (b(30,23)>= 149.U) || (b(30,23) <= 94.U)   //127
//
//  io.U_flag  := (b(30,23)>= 95.U) || (b(30,23) <= 111.U)
//
//
//  //
//  val temp_shift_bit = Wire(UInt(8.W))
//  val shift_bit      = Wire(UInt(6.W))   //This bitlen can be decreased to save area.
//  val extend_b       = Wire(UInt(39.W)) //This bitlen may need increase to ensure correct.
//  val b39            = Wire(UInt(39.W))
//  temp_shift_bit := b(30,23) - 112.U     //   -112=-127+15
//  shift_bit      := temp_shift_bit(5,0)  //
//  extend_b       := Cat(0.U(15.W), 1.U(1.W), b(22,0)) //3939+15
//  b39            := extend_b << shift_bit; //
//
//  val f1 = Wire(Bool())
//  val f2 = Wire(Bool())
//  val f3 = Wire(UInt(13.W))
//  val f4 = Wire(UInt(23.W))
//  //logic f34_zero_flag;		//f3 == 0 and f4 == 0 flag, this is an exception
//  f1 := b39(37)    //f1 0.5
//  f2 := b39(36)    //f2 0.25
//  f3 := b39(35,23) //13
//  f4 := b39(22, 0) //23
//  io.f34_zero_flag := (f3 === false.B) && (f4 === false.B) //
//
//
//  //logic F1;					//completement flag
//  val F2 = Wire(Bool()) //signal flag
//  val fn = Wire(UInt(36.W)) //fn = ~(f3, f4) + 1
//  val f3n = Wire(UInt(13.W));
//  val f4n = Wire(UInt(23.W))
//  val f3_mux = Wire(UInt(13.W))
//  val f4_mux = Wire(UInt(23.W))
//  io.F1 := f2 ^ io.cs; //cs[0,pi/2]sincos   F1
//  F2    := f1 ^ (io.cs && f2) ^ (!io.cs && b(31)) //
//  fn    := ~Cat(f3,f4) + 1.U//
//  f3n   := fn(35,23) //
//  f4n   := fn(22,0)
//  f3_mux:= Mux(io.F1,f3n, f3) //13
//  f4_mux:= Mux(io.F1,f4n, f4) //23
//
//  io.Sign_out  := F2
//  io.index_out := f3_mux
//  io.data_in   := f4_mux
//
//  val reg_S3_exp = Wire(UInt(8.W))
//  val reg_C3_exp = Wire(UInt(8.W))
//  val u_sin_LUTS3_exp = Module(new sin_LUTS3_exp_BB)//sin
//  u_sin_LUTS3_exp.io.index := f3_mux
//  reg_S3_exp := u_sin_LUTS3_exp.io.s_exp
//
//  val u_sin_LUTC3_exp = Module(new sin_LUTC3_exp_BB) //sin
//  u_sin_LUTC3_exp.io.index := f3_mux
//  reg_C3_exp := u_sin_LUTC3_exp.io.c_exp
//
//  //Taylor
//  //logic [7:0]  SR1;
//  //logic [7:0]  SR2;
//  io.SR1 := reg_S3_exp - 16.U(8.W) + 48.U(8.W) //sin
//  io.SR2 := reg_C3_exp - 16.U(8.W) + 10.U(8.W); //cos
//
//  //Taylor
//  val H = Wire(UInt(48.W))
//  val H_tail = Wire(UInt(24.W))
//  val H_exp = Wire(UInt(8.W))
//  val reg_H = Wire(UInt(32.W))
//  H      := Cat(1.U(1.W), b(22, 0)) * PI //b24*24
//  H_tail := Mux(H(47) , H(47, 24), H(46, 23)) //24
//  H_exp  := Mux(H(47) , (b(30, 23)+3.U(2.W)), (b(30, 23)+2.U(2.W)) )//8
//  reg_H  := Cat(b(31) , H_exp, H_tail(22, 0)) //reg_HTaylor32
//
//  //
//  val f34 = Wire(UInt(36.W))
//
//  f34 := Cat(f3_mux, f4_mux)
//
//  val u_count_zero = Module(new sin_count_zero)
//  u_count_zero.io.f34 := f34
//  io.num_zero := u_count_zero.io.num_zero
//}
//
//object CIM_before_gen extends App {
//  new(chisel3.stage.ChiselStage).execute(Array("--target-dir", "./cq/verilog/conv_sin/CIM_before"), Seq(ChiselGeneratorAnnotation(() => new CIM_before)))
//}