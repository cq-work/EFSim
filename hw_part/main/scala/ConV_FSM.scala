package cim
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._

//ConV_FSM: Scheduling of the hardware implementation of the ConV algorithm
class ConV_FSM extends Module with adder_tree_config {
  val io = IO(new Bundle {
    val din_valid_ConV = Input(Bool())
    val ifm_buffer_ready = if (!SIM_MODE) Some(Input(Bool())) else None
    val Current_state = Output(UInt(5.W))
    val dout_valid_ConV = Output(Bool())
    val buffer_busy = if (!SIM_MODE) Some(Output(Bool())) else None
  })

  val state = RegInit(0.U(5.W))
//  val buffer_busy = if (!SIM_MODE) Some(RegInit(false.B)) else None
  val buffer_busy = RegInit(false.B)
  io.dout_valid_ConV := false.B
  if (!SIM_MODE){
    io.buffer_busy.get := buffer_busy
  }


  when(state === 0.U) {
    when(io.din_valid_ConV && io.ifm_buffer_ready.get) {
      state := 1.U

      buffer_busy := true.B
    }
  }.elsewhen(state === DATA_WIDTH.U){
    state := state + 1.U
    buffer_busy := false.B
  }.elsewhen(state < (numStates - 1).U) {
    state := state + 1.U
  }.otherwise {
    state := 0.U
    io.dout_valid_ConV := true.B
  }

  io.Current_state := state
}


//class ConV_FSM extends Module {
//  val io = IO(new Bundle {
//    val din_valid_ConV = Input(Bool())
//
//    val Current_state   = Output(UInt(5.W))
//    val dout_valid_ConV = Output(Bool())
//  })
//
//  private val idle :: s0 :: s1 :: s2 :: s3 :: s4 :: s5 :: s6 :: s7 :: s8 :: s9 :: s10 :: s11 :: s12 :: s13 :: s14 :: s15 :: outflag :: Nil = Enum(18)
//  val state = RegInit(idle)
//
//  io.dout_valid_ConV := false.B
//  switch (state) {
//    is (idle) {
//      when(io.din_valid_ConV){
//        state := s0
//      }
//    }
//    is (s0) {
//      state := s1
//    }
//    is(s1) {
//      state := s2
//    }
//    is(s2) {
//      state := s3
//    }
//    is(s3) {
//      state := s4
//    }
//    is(s4) {
//      state := s5
//    }
//    is(s5) {
//      state := s6
//    }
//    is(s6) {
//      state := s7
//    }
//    is(s7) {
//      state := s8
//    }
//    is(s8) {
//      state := s9
//    }
//    is (s9) {
//      state := s10
//    }
//    is (s10) {
//      state := s11
//    }
//    is (s11) {
//      state := s12
//    }
//    is(s12) {
//      state := s13
//    }
//    is(s13) {
//      state := s14
//    }
//    is(s14) {
//      state := s15
//    }
//    is(s15) {
//      state := outflag
//    }
//    is(outflag) {
//      state := idle
//      io.dout_valid_ConV := true.B
//    }
//  }
//  io.Current_state := state
//}

object ConV_FSM_gen extends App{
  new (chisel3.stage.ChiselStage).execute(Array("--target-dir","./cq/verilog/test/ConV_FSM"),Seq(ChiselGeneratorAnnotation(()=>new ConV_FSM)))
}