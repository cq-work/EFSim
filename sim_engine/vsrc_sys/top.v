module dmaR(
  input          clock,
  output [63:0]  io_dma_r_addr,
  output         io_dma_r_areq,
  output [31:0]  io_dma_r_size,
  input  [127:0] io_dma_r_data,
  input          io_dma_r_valid,
  output         io_dma_r_ready,
  output         io_dataOut_valid,
  output [127:0] io_dataOut_data,
  input          io_dmaCtrl_dmaEn,
  input          io_dmaCtrl_dmaAreq,
  input  [31:0]  io_dmaCtrl_dmaSize,
  input  [63:0]  io_dmaCtrl_dmaAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [127:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  io_dataOut_valid_REG; // @[dma.scala 190:30]
  reg [127:0] io_dataOut_data_REG; // @[dma.scala 191:29]
  assign io_dma_r_addr = io_dmaCtrl_dmaAddr; // @[dma.scala 188:17]
  assign io_dma_r_areq = io_dmaCtrl_dmaAreq; // @[dma.scala 187:17]
  assign io_dma_r_size = io_dmaCtrl_dmaSize; // @[dma.scala 189:17]
  assign io_dma_r_ready = io_dmaCtrl_dmaEn; // @[dma.scala 186:18]
  assign io_dataOut_valid = io_dataOut_valid_REG; // @[dma.scala 190:20]
  assign io_dataOut_data = io_dataOut_data_REG; // @[dma.scala 191:19]
  always @(posedge clock) begin
    io_dataOut_valid_REG <= io_dma_r_valid; // @[dma.scala 190:30]
    io_dataOut_data_REG <= io_dma_r_data; // @[dma.scala 191:29]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_dataOut_valid_REG = _RAND_0[0:0];
  _RAND_1 = {4{`RANDOM}};
  io_dataOut_data_REG = _RAND_1[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dmaRBufSel(
  input  [2:0]   io_sel,
  input          io_dataIn_valid,
  input  [127:0] io_dataIn_data,
  output         io_gemmData_valid,
  output [127:0] io_gemmData_data
);
  wire  _io_gemmData_data_T = io_sel == 3'h2; // @[dma.scala 174:34]
  assign io_gemmData_valid = _io_gemmData_data_T & io_dataIn_valid; // @[dma.scala 175:27]
  assign io_gemmData_data = io_sel == 3'h2 ? io_dataIn_data : 128'h0; // @[dma.scala 174:26]
endmodule
module fallEdge(
  input   clock,
  input   io_in,
  output  io_edge
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  io_edge_REG; // @[utils.scala 28:21]
  assign io_edge = io_edge_REG & ~io_in; // @[utils.scala 28:29]
  always @(posedge clock) begin
    io_edge_REG <= io_in; // @[utils.scala 28:21]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_edge_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dmaRAreqAbrit(
  input         clock,
  input         reset,
  input         io_gemmAreq_dmaEn,
  input         io_gemmAreq_dmaAreq,
  input  [31:0] io_gemmAreq_dmaSize,
  input  [63:0] io_gemmAreq_dmaAddr,
  output [2:0]  io_sel,
  output        io_toDma_dmaEn,
  output        io_toDma_dmaAreq,
  output [31:0] io_toDma_dmaSize,
  output [63:0] io_toDma_dmaAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  state_inst_clock; // @[utils.scala 33:22]
  wire  state_inst_io_in; // @[utils.scala 33:22]
  wire  state_inst_io_edge; // @[utils.scala 33:22]
  reg [1:0] state; // @[dma.scala 71:22]
  reg [1:0] sel; // @[dma.scala 73:20]
  reg [63:0] addr; // @[dma.scala 74:21]
  reg [31:0] size; // @[dma.scala 75:21]
  reg  en; // @[dma.scala 76:19]
  reg  areq; // @[dma.scala 77:21]
  fallEdge state_inst ( // @[utils.scala 33:22]
    .clock(state_inst_clock),
    .io_in(state_inst_io_in),
    .io_edge(state_inst_io_edge)
  );
  assign io_sel = {{1'd0}, sel}; // @[dma.scala 107:10]
  assign io_toDma_dmaEn = en; // @[dma.scala 110:18]
  assign io_toDma_dmaAreq = areq; // @[dma.scala 111:20]
  assign io_toDma_dmaSize = size; // @[dma.scala 109:20]
  assign io_toDma_dmaAddr = addr; // @[dma.scala 108:20]
  assign state_inst_clock = clock;
  assign state_inst_io_in = io_toDma_dmaEn; // @[utils.scala 34:16]
  always @(posedge clock) begin
    if (reset) begin // @[dma.scala 71:22]
      state <= 2'h0; // @[dma.scala 71:22]
    end else if (2'h0 == state) begin // @[dma.scala 80:16]
      if (io_gemmAreq_dmaEn) begin // @[dma.scala 84:30]
        state <= 2'h1; // @[dma.scala 86:15]
      end else begin
        state <= 2'h0; // @[dma.scala 83:13]
      end
    end else if (2'h1 == state) begin // @[dma.scala 80:16]
      if (state_inst_io_edge) begin // @[dma.scala 90:30]
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (2'h2 == state) begin // @[dma.scala 80:16]
      state <= 2'h0; // @[dma.scala 91:24]
    end
    if (reset) begin // @[dma.scala 73:20]
      sel <= 2'h0; // @[dma.scala 73:20]
    end else if (2'h0 == state) begin // @[dma.scala 80:16]
      if (io_gemmAreq_dmaEn) begin // @[dma.scala 84:30]
        sel <= 2'h2; // @[dma.scala 85:13]
      end else begin
        sel <= 2'h0; // @[dma.scala 82:11]
      end
    end
    if (reset) begin // @[dma.scala 74:21]
      addr <= 64'h0; // @[dma.scala 74:21]
    end else if (!(2'h0 == sel)) begin // @[dma.scala 95:14]
      if (2'h2 == sel) begin // @[dma.scala 95:14]
        addr <= io_gemmAreq_dmaAddr; // @[dma.scala 101:12]
      end
    end
    if (reset) begin // @[dma.scala 75:21]
      size <= 32'h0; // @[dma.scala 75:21]
    end else if (!(2'h0 == sel)) begin // @[dma.scala 95:14]
      if (2'h2 == sel) begin // @[dma.scala 95:14]
        size <= io_gemmAreq_dmaSize; // @[dma.scala 102:12]
      end
    end
    if (reset) begin // @[dma.scala 76:19]
      en <= 1'h0; // @[dma.scala 76:19]
    end else if (2'h0 == sel) begin // @[dma.scala 95:14]
      en <= 1'h0; // @[dma.scala 97:10]
    end else if (2'h2 == sel) begin // @[dma.scala 95:14]
      en <= io_gemmAreq_dmaEn; // @[dma.scala 100:10]
    end
    if (reset) begin // @[dma.scala 77:21]
      areq <= 1'h0; // @[dma.scala 77:21]
    end else if (!(2'h0 == sel)) begin // @[dma.scala 95:14]
      if (2'h2 == sel) begin // @[dma.scala 95:14]
        areq <= io_gemmAreq_dmaAreq; // @[dma.scala 103:12]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  sel = _RAND_1[1:0];
  _RAND_2 = {2{`RANDOM}};
  addr = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  size = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  areq = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dmaW(
  output [63:0]  io_dma_w_addr,
  output         io_dma_w_areq,
  output [31:0]  io_dma_w_size,
  output [127:0] io_dma_w_data,
  input          io_dma_w_valid,
  output         io_dataIn_valid,
  input  [127:0] io_dataIn_data,
  input          io_dmaCtrl_dmaAreq,
  input  [31:0]  io_dmaCtrl_dmaSize,
  input  [63:0]  io_dmaCtrl_dmaAddr
);
  assign io_dma_w_addr = io_dmaCtrl_dmaAddr; // @[dma.scala 225:17]
  assign io_dma_w_areq = io_dmaCtrl_dmaAreq; // @[dma.scala 224:17]
  assign io_dma_w_size = io_dmaCtrl_dmaSize; // @[dma.scala 226:17]
  assign io_dma_w_data = io_dataIn_data; // @[dma.scala 227:17]
  assign io_dataIn_valid = io_dma_w_valid; // @[dma.scala 228:19]
endmodule
module dmaWBufSel(
  input          io_sel,
  input          io_dataOut_valid,
  output [127:0] io_dataOut_data,
  output         io_sendBufferData_valid,
  input  [127:0] io_sendBufferData_data
);
  assign io_dataOut_data = io_sel ? io_sendBufferData_data : 128'h0; // @[dma.scala 207:19 209:40 210:21]
  assign io_sendBufferData_valid = io_sel & io_dataOut_valid; // @[dma.scala 208:27 209:40 211:29]
endmodule
module dmaWAreqAbrit(
  input         clock,
  input         reset,
  input         io_sendBufferAreq_dmaEn,
  input         io_sendBufferAreq_dmaAreq,
  input  [31:0] io_sendBufferAreq_dmaSize,
  input  [63:0] io_sendBufferAreq_dmaAddr,
  output        io_sel,
  output        io_toDma_dmaEn,
  output        io_toDma_dmaAreq,
  output [31:0] io_toDma_dmaSize,
  output [63:0] io_toDma_dmaAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  state_inst_clock; // @[utils.scala 33:22]
  wire  state_inst_io_in; // @[utils.scala 33:22]
  wire  state_inst_io_edge; // @[utils.scala 33:22]
  reg [1:0] state; // @[dma.scala 123:22]
  reg  sel; // @[dma.scala 125:20]
  reg [63:0] addr; // @[dma.scala 126:21]
  reg [31:0] size; // @[dma.scala 127:21]
  reg  en; // @[dma.scala 128:19]
  reg  areq; // @[dma.scala 129:21]
  fallEdge state_inst ( // @[utils.scala 33:22]
    .clock(state_inst_clock),
    .io_in(state_inst_io_in),
    .io_edge(state_inst_io_edge)
  );
  assign io_sel = sel; // @[dma.scala 159:10]
  assign io_toDma_dmaEn = en; // @[dma.scala 162:18]
  assign io_toDma_dmaAreq = areq; // @[dma.scala 163:20]
  assign io_toDma_dmaSize = size; // @[dma.scala 161:20]
  assign io_toDma_dmaAddr = addr; // @[dma.scala 160:20]
  assign state_inst_clock = clock;
  assign state_inst_io_in = io_toDma_dmaEn; // @[utils.scala 34:16]
  always @(posedge clock) begin
    if (reset) begin // @[dma.scala 123:22]
      state <= 2'h0; // @[dma.scala 123:22]
    end else if (2'h0 == state) begin // @[dma.scala 132:16]
      if (io_sendBufferAreq_dmaEn) begin // @[dma.scala 136:36]
        state <= 2'h1; // @[dma.scala 138:15]
      end else begin
        state <= 2'h0; // @[dma.scala 135:13]
      end
    end else if (2'h1 == state) begin // @[dma.scala 132:16]
      if (state_inst_io_edge) begin // @[dma.scala 142:30]
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (2'h2 == state) begin // @[dma.scala 132:16]
      state <= 2'h0; // @[dma.scala 143:24]
    end
    if (reset) begin // @[dma.scala 125:20]
      sel <= 1'h0; // @[dma.scala 125:20]
    end else if (2'h0 == state) begin // @[dma.scala 132:16]
      sel <= io_sendBufferAreq_dmaEn;
    end
    if (reset) begin // @[dma.scala 126:21]
      addr <= 64'h0; // @[dma.scala 126:21]
    end else if (!(~sel)) begin // @[dma.scala 147:14]
      if (sel) begin // @[dma.scala 147:14]
        addr <= io_sendBufferAreq_dmaAddr; // @[dma.scala 153:12]
      end
    end
    if (reset) begin // @[dma.scala 127:21]
      size <= 32'h0; // @[dma.scala 127:21]
    end else if (!(~sel)) begin // @[dma.scala 147:14]
      if (sel) begin // @[dma.scala 147:14]
        size <= io_sendBufferAreq_dmaSize; // @[dma.scala 154:12]
      end
    end
    if (reset) begin // @[dma.scala 128:19]
      en <= 1'h0; // @[dma.scala 128:19]
    end else if (~sel) begin // @[dma.scala 147:14]
      en <= 1'h0; // @[dma.scala 149:10]
    end else if (sel) begin // @[dma.scala 147:14]
      en <= io_sendBufferAreq_dmaEn; // @[dma.scala 152:10]
    end
    if (reset) begin // @[dma.scala 129:21]
      areq <= 1'h0; // @[dma.scala 129:21]
    end else if (!(~sel)) begin // @[dma.scala 147:14]
      if (sel) begin // @[dma.scala 147:14]
        areq <= io_sendBufferAreq_dmaAreq; // @[dma.scala 155:12]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  sel = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  addr = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  size = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  areq = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dma_ch(
  input          clock,
  input          reset,
  output [63:0]  io_dmaR_addr,
  output         io_dmaR_areq,
  output [31:0]  io_dmaR_size,
  input  [127:0] io_dmaR_data,
  input          io_dmaR_valid,
  output         io_dmaR_ready,
  output [63:0]  io_dmaW_addr,
  output         io_dmaW_areq,
  output [31:0]  io_dmaW_size,
  output [127:0] io_dmaW_data,
  input          io_dmaW_valid,
  input          io_dmar_gemm_areq_dmaEn,
  input          io_dmar_gemm_areq_dmaAreq,
  input  [31:0]  io_dmar_gemm_areq_dmaSize,
  input  [63:0]  io_dmar_gemm_areq_dmaAddr,
  output         io_dmar_gemm_data_valid,
  output [127:0] io_dmar_gemm_data_data,
  input          io_dmaw_sendbuf_areq_dmaEn,
  input          io_dmaw_sendbuf_areq_dmaAreq,
  input  [31:0]  io_dmaw_sendbuf_areq_dmaSize,
  input  [63:0]  io_dmaw_sendbuf_areq_dmaAddr,
  output         io_dmaw_sendbuf_data_valid,
  input  [127:0] io_dmaw_sendbuf_data_data
);
  wire  dmaR_clock; // @[dma.scala 302:20]
  wire [63:0] dmaR_io_dma_r_addr; // @[dma.scala 302:20]
  wire  dmaR_io_dma_r_areq; // @[dma.scala 302:20]
  wire [31:0] dmaR_io_dma_r_size; // @[dma.scala 302:20]
  wire [127:0] dmaR_io_dma_r_data; // @[dma.scala 302:20]
  wire  dmaR_io_dma_r_valid; // @[dma.scala 302:20]
  wire  dmaR_io_dma_r_ready; // @[dma.scala 302:20]
  wire  dmaR_io_dataOut_valid; // @[dma.scala 302:20]
  wire [127:0] dmaR_io_dataOut_data; // @[dma.scala 302:20]
  wire  dmaR_io_dmaCtrl_dmaEn; // @[dma.scala 302:20]
  wire  dmaR_io_dmaCtrl_dmaAreq; // @[dma.scala 302:20]
  wire [31:0] dmaR_io_dmaCtrl_dmaSize; // @[dma.scala 302:20]
  wire [63:0] dmaR_io_dmaCtrl_dmaAddr; // @[dma.scala 302:20]
  wire [2:0] dmaRBufSel_io_sel; // @[dma.scala 303:26]
  wire  dmaRBufSel_io_dataIn_valid; // @[dma.scala 303:26]
  wire [127:0] dmaRBufSel_io_dataIn_data; // @[dma.scala 303:26]
  wire  dmaRBufSel_io_gemmData_valid; // @[dma.scala 303:26]
  wire [127:0] dmaRBufSel_io_gemmData_data; // @[dma.scala 303:26]
  wire  dmaRAreqAbrit_clock; // @[dma.scala 304:29]
  wire  dmaRAreqAbrit_reset; // @[dma.scala 304:29]
  wire  dmaRAreqAbrit_io_gemmAreq_dmaEn; // @[dma.scala 304:29]
  wire  dmaRAreqAbrit_io_gemmAreq_dmaAreq; // @[dma.scala 304:29]
  wire [31:0] dmaRAreqAbrit_io_gemmAreq_dmaSize; // @[dma.scala 304:29]
  wire [63:0] dmaRAreqAbrit_io_gemmAreq_dmaAddr; // @[dma.scala 304:29]
  wire [2:0] dmaRAreqAbrit_io_sel; // @[dma.scala 304:29]
  wire  dmaRAreqAbrit_io_toDma_dmaEn; // @[dma.scala 304:29]
  wire  dmaRAreqAbrit_io_toDma_dmaAreq; // @[dma.scala 304:29]
  wire [31:0] dmaRAreqAbrit_io_toDma_dmaSize; // @[dma.scala 304:29]
  wire [63:0] dmaRAreqAbrit_io_toDma_dmaAddr; // @[dma.scala 304:29]
  wire [63:0] dmaW_io_dma_w_addr; // @[dma.scala 317:20]
  wire  dmaW_io_dma_w_areq; // @[dma.scala 317:20]
  wire [31:0] dmaW_io_dma_w_size; // @[dma.scala 317:20]
  wire [127:0] dmaW_io_dma_w_data; // @[dma.scala 317:20]
  wire  dmaW_io_dma_w_valid; // @[dma.scala 317:20]
  wire  dmaW_io_dataIn_valid; // @[dma.scala 317:20]
  wire [127:0] dmaW_io_dataIn_data; // @[dma.scala 317:20]
  wire  dmaW_io_dmaCtrl_dmaAreq; // @[dma.scala 317:20]
  wire [31:0] dmaW_io_dmaCtrl_dmaSize; // @[dma.scala 317:20]
  wire [63:0] dmaW_io_dmaCtrl_dmaAddr; // @[dma.scala 317:20]
  wire  dmaWBufSel_io_sel; // @[dma.scala 318:26]
  wire  dmaWBufSel_io_dataOut_valid; // @[dma.scala 318:26]
  wire [127:0] dmaWBufSel_io_dataOut_data; // @[dma.scala 318:26]
  wire  dmaWBufSel_io_sendBufferData_valid; // @[dma.scala 318:26]
  wire [127:0] dmaWBufSel_io_sendBufferData_data; // @[dma.scala 318:26]
  wire  dmaWAreqAbrit_clock; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_reset; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_io_sendBufferAreq_dmaEn; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_io_sendBufferAreq_dmaAreq; // @[dma.scala 319:29]
  wire [31:0] dmaWAreqAbrit_io_sendBufferAreq_dmaSize; // @[dma.scala 319:29]
  wire [63:0] dmaWAreqAbrit_io_sendBufferAreq_dmaAddr; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_io_sel; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_io_toDma_dmaEn; // @[dma.scala 319:29]
  wire  dmaWAreqAbrit_io_toDma_dmaAreq; // @[dma.scala 319:29]
  wire [31:0] dmaWAreqAbrit_io_toDma_dmaSize; // @[dma.scala 319:29]
  wire [63:0] dmaWAreqAbrit_io_toDma_dmaAddr; // @[dma.scala 319:29]
  dmaR dmaR ( // @[dma.scala 302:20]
    .clock(dmaR_clock),
    .io_dma_r_addr(dmaR_io_dma_r_addr),
    .io_dma_r_areq(dmaR_io_dma_r_areq),
    .io_dma_r_size(dmaR_io_dma_r_size),
    .io_dma_r_data(dmaR_io_dma_r_data),
    .io_dma_r_valid(dmaR_io_dma_r_valid),
    .io_dma_r_ready(dmaR_io_dma_r_ready),
    .io_dataOut_valid(dmaR_io_dataOut_valid),
    .io_dataOut_data(dmaR_io_dataOut_data),
    .io_dmaCtrl_dmaEn(dmaR_io_dmaCtrl_dmaEn),
    .io_dmaCtrl_dmaAreq(dmaR_io_dmaCtrl_dmaAreq),
    .io_dmaCtrl_dmaSize(dmaR_io_dmaCtrl_dmaSize),
    .io_dmaCtrl_dmaAddr(dmaR_io_dmaCtrl_dmaAddr)
  );
  dmaRBufSel dmaRBufSel ( // @[dma.scala 303:26]
    .io_sel(dmaRBufSel_io_sel),
    .io_dataIn_valid(dmaRBufSel_io_dataIn_valid),
    .io_dataIn_data(dmaRBufSel_io_dataIn_data),
    .io_gemmData_valid(dmaRBufSel_io_gemmData_valid),
    .io_gemmData_data(dmaRBufSel_io_gemmData_data)
  );
  dmaRAreqAbrit dmaRAreqAbrit ( // @[dma.scala 304:29]
    .clock(dmaRAreqAbrit_clock),
    .reset(dmaRAreqAbrit_reset),
    .io_gemmAreq_dmaEn(dmaRAreqAbrit_io_gemmAreq_dmaEn),
    .io_gemmAreq_dmaAreq(dmaRAreqAbrit_io_gemmAreq_dmaAreq),
    .io_gemmAreq_dmaSize(dmaRAreqAbrit_io_gemmAreq_dmaSize),
    .io_gemmAreq_dmaAddr(dmaRAreqAbrit_io_gemmAreq_dmaAddr),
    .io_sel(dmaRAreqAbrit_io_sel),
    .io_toDma_dmaEn(dmaRAreqAbrit_io_toDma_dmaEn),
    .io_toDma_dmaAreq(dmaRAreqAbrit_io_toDma_dmaAreq),
    .io_toDma_dmaSize(dmaRAreqAbrit_io_toDma_dmaSize),
    .io_toDma_dmaAddr(dmaRAreqAbrit_io_toDma_dmaAddr)
  );
  dmaW dmaW ( // @[dma.scala 317:20]
    .io_dma_w_addr(dmaW_io_dma_w_addr),
    .io_dma_w_areq(dmaW_io_dma_w_areq),
    .io_dma_w_size(dmaW_io_dma_w_size),
    .io_dma_w_data(dmaW_io_dma_w_data),
    .io_dma_w_valid(dmaW_io_dma_w_valid),
    .io_dataIn_valid(dmaW_io_dataIn_valid),
    .io_dataIn_data(dmaW_io_dataIn_data),
    .io_dmaCtrl_dmaAreq(dmaW_io_dmaCtrl_dmaAreq),
    .io_dmaCtrl_dmaSize(dmaW_io_dmaCtrl_dmaSize),
    .io_dmaCtrl_dmaAddr(dmaW_io_dmaCtrl_dmaAddr)
  );
  dmaWBufSel dmaWBufSel ( // @[dma.scala 318:26]
    .io_sel(dmaWBufSel_io_sel),
    .io_dataOut_valid(dmaWBufSel_io_dataOut_valid),
    .io_dataOut_data(dmaWBufSel_io_dataOut_data),
    .io_sendBufferData_valid(dmaWBufSel_io_sendBufferData_valid),
    .io_sendBufferData_data(dmaWBufSel_io_sendBufferData_data)
  );
  dmaWAreqAbrit dmaWAreqAbrit ( // @[dma.scala 319:29]
    .clock(dmaWAreqAbrit_clock),
    .reset(dmaWAreqAbrit_reset),
    .io_sendBufferAreq_dmaEn(dmaWAreqAbrit_io_sendBufferAreq_dmaEn),
    .io_sendBufferAreq_dmaAreq(dmaWAreqAbrit_io_sendBufferAreq_dmaAreq),
    .io_sendBufferAreq_dmaSize(dmaWAreqAbrit_io_sendBufferAreq_dmaSize),
    .io_sendBufferAreq_dmaAddr(dmaWAreqAbrit_io_sendBufferAreq_dmaAddr),
    .io_sel(dmaWAreqAbrit_io_sel),
    .io_toDma_dmaEn(dmaWAreqAbrit_io_toDma_dmaEn),
    .io_toDma_dmaAreq(dmaWAreqAbrit_io_toDma_dmaAreq),
    .io_toDma_dmaSize(dmaWAreqAbrit_io_toDma_dmaSize),
    .io_toDma_dmaAddr(dmaWAreqAbrit_io_toDma_dmaAddr)
  );
  assign io_dmaR_addr = dmaR_io_dma_r_addr; // @[dma.scala 305:17]
  assign io_dmaR_areq = dmaR_io_dma_r_areq; // @[dma.scala 305:17]
  assign io_dmaR_size = dmaR_io_dma_r_size; // @[dma.scala 305:17]
  assign io_dmaR_ready = dmaR_io_dma_r_ready; // @[dma.scala 305:17]
  assign io_dmaW_addr = dmaW_io_dma_w_addr; // @[dma.scala 320:17]
  assign io_dmaW_areq = dmaW_io_dma_w_areq; // @[dma.scala 320:17]
  assign io_dmaW_size = dmaW_io_dma_w_size; // @[dma.scala 320:17]
  assign io_dmaW_data = dmaW_io_dma_w_data; // @[dma.scala 320:17]
  assign io_dmar_gemm_data_valid = dmaRBufSel_io_gemmData_valid; // @[dma.scala 310:25]
  assign io_dmar_gemm_data_data = dmaRBufSel_io_gemmData_data; // @[dma.scala 310:25]
  assign io_dmaw_sendbuf_data_valid = dmaWBufSel_io_sendBufferData_valid; // @[dma.scala 325:28]
  assign dmaR_clock = clock;
  assign dmaR_io_dma_r_data = io_dmaR_data; // @[dma.scala 305:17]
  assign dmaR_io_dma_r_valid = io_dmaR_valid; // @[dma.scala 305:17]
  assign dmaR_io_dmaCtrl_dmaEn = dmaRAreqAbrit_io_toDma_dmaEn; // @[dma.scala 306:19]
  assign dmaR_io_dmaCtrl_dmaAreq = dmaRAreqAbrit_io_toDma_dmaAreq; // @[dma.scala 306:19]
  assign dmaR_io_dmaCtrl_dmaSize = dmaRAreqAbrit_io_toDma_dmaSize; // @[dma.scala 306:19]
  assign dmaR_io_dmaCtrl_dmaAddr = dmaRAreqAbrit_io_toDma_dmaAddr; // @[dma.scala 306:19]
  assign dmaRBufSel_io_sel = dmaRAreqAbrit_io_sel; // @[dma.scala 307:21]
  assign dmaRBufSel_io_dataIn_valid = dmaR_io_dataOut_valid; // @[dma.scala 308:24]
  assign dmaRBufSel_io_dataIn_data = dmaR_io_dataOut_data; // @[dma.scala 308:24]
  assign dmaRAreqAbrit_clock = clock;
  assign dmaRAreqAbrit_reset = reset;
  assign dmaRAreqAbrit_io_gemmAreq_dmaEn = io_dmar_gemm_areq_dmaEn; // @[dma.scala 311:29]
  assign dmaRAreqAbrit_io_gemmAreq_dmaAreq = io_dmar_gemm_areq_dmaAreq; // @[dma.scala 311:29]
  assign dmaRAreqAbrit_io_gemmAreq_dmaSize = io_dmar_gemm_areq_dmaSize; // @[dma.scala 311:29]
  assign dmaRAreqAbrit_io_gemmAreq_dmaAddr = io_dmar_gemm_areq_dmaAddr; // @[dma.scala 311:29]
  assign dmaW_io_dma_w_valid = io_dmaW_valid; // @[dma.scala 320:17]
  assign dmaW_io_dataIn_data = dmaWBufSel_io_dataOut_data; // @[dma.scala 323:25]
  assign dmaW_io_dmaCtrl_dmaAreq = dmaWAreqAbrit_io_toDma_dmaAreq; // @[dma.scala 321:19]
  assign dmaW_io_dmaCtrl_dmaSize = dmaWAreqAbrit_io_toDma_dmaSize; // @[dma.scala 321:19]
  assign dmaW_io_dmaCtrl_dmaAddr = dmaWAreqAbrit_io_toDma_dmaAddr; // @[dma.scala 321:19]
  assign dmaWBufSel_io_sel = dmaWAreqAbrit_io_sel; // @[dma.scala 322:21]
  assign dmaWBufSel_io_dataOut_valid = dmaW_io_dataIn_valid; // @[dma.scala 323:25]
  assign dmaWBufSel_io_sendBufferData_data = io_dmaw_sendbuf_data_data; // @[dma.scala 325:28]
  assign dmaWAreqAbrit_clock = clock;
  assign dmaWAreqAbrit_reset = reset;
  assign dmaWAreqAbrit_io_sendBufferAreq_dmaEn = io_dmaw_sendbuf_areq_dmaEn; // @[dma.scala 326:35]
  assign dmaWAreqAbrit_io_sendBufferAreq_dmaAreq = io_dmaw_sendbuf_areq_dmaAreq; // @[dma.scala 326:35]
  assign dmaWAreqAbrit_io_sendBufferAreq_dmaSize = io_dmaw_sendbuf_areq_dmaSize; // @[dma.scala 326:35]
  assign dmaWAreqAbrit_io_sendBufferAreq_dmaAddr = io_dmaw_sendbuf_areq_dmaAddr; // @[dma.scala 326:35]
endmodule
module standard_fifo(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [3:0] waddr; // @[utils.scala 523:22]
  reg [3:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [3:0] _waddr_T_1 = waddr + 4'h1; // @[utils.scala 530:31]
  wire [3:0] _raddr_T_1 = raddr + 4'h1; // @[utils.scala 531:31]
  reg [4:0] count; // @[utils.scala 534:22]
  wire [4:0] _count_T_1 = count - 5'h1; // @[utils.scala 538:20]
  wire [4:0] _count_T_3 = count + 5'h1; // @[utils.scala 540:20]
  reg [63:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [3:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [3:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 564:62]
  wire [3:0] _T_15 = _T_8 ? {{1'd0}, raddr[3:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [3:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 573:64]
  wire [3:0] _T_26 = _T_19 ? {{1'd0}, raddr[3:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(64), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(64), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 5'h10; // @[utils.scala 576:26]
  assign io_deq_valid = count != 5'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[2:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[2:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 4'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 4'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 5'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 64'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 4'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[3:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[4:0];
  _RAND_3 = {2{`RANDOM}};
  reg_write_data = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [63:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [63:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [63:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_enq_ready = fifo_io_enq_ready; // @[utils.scala 593:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  io_deq_bits_r = _RAND_1[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [63:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [63:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  standard_fifo_delay standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_ready(standard_fifo_delay_io_enq_ready),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_enq_ready = standard_fifo_delay_io_enq_ready; // @[utils.scala 634:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 636:16]
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [32:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [32:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [32:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [32:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [32:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [32:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [3:0] waddr; // @[utils.scala 523:22]
  reg [3:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [3:0] _waddr_T_1 = waddr + 4'h1; // @[utils.scala 530:31]
  wire [3:0] _raddr_T_1 = raddr + 4'h1; // @[utils.scala 531:31]
  reg [4:0] count; // @[utils.scala 534:22]
  wire [4:0] _count_T_1 = count - 5'h1; // @[utils.scala 538:20]
  wire [4:0] _count_T_3 = count + 5'h1; // @[utils.scala 540:20]
  reg [32:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [3:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [3:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 564:62]
  wire [3:0] _T_15 = _T_8 ? {{1'd0}, raddr[3:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [3:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 573:64]
  wire [3:0] _T_26 = _T_19 ? {{1'd0}, raddr[3:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(33), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(33), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 5'h10; // @[utils.scala 576:26]
  assign io_deq_valid = count != 5'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[2:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[2:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 4'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 4'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 5'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 33'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 4'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[3:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[4:0];
  _RAND_3 = {2{`RANDOM}};
  reg_write_data = _RAND_3[32:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [32:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [32:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [32:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [32:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [32:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo_1 fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_enq_ready = fifo_io_enq_ready; // @[utils.scala 593:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 33'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  io_deq_bits_r = _RAND_1[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [32:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [32:0] io_deq_bits,
  output [4:0]  io_count
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [32:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [32:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  reg [4:0] count; // @[utils.scala 644:22]
  wire  _T_5 = io_deq_ready & io_deq_valid; // @[utils.scala 645:27]
  wire  _T_6 = io_enq_valid & io_enq_ready; // @[utils.scala 645:56]
  wire [1:0] _T_7 = {_T_5,_T_6}; // @[Cat.scala 33:92]
  wire [4:0] _count_T_1 = count + 5'h1; // @[utils.scala 650:22]
  wire [4:0] _count_T_3 = count - 5'h1; // @[utils.scala 653:22]
  standard_fifo_delay_1 standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_ready(standard_fifo_delay_io_enq_ready),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_enq_ready = standard_fifo_delay_io_enq_ready; // @[utils.scala 634:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 636:16]
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign io_count = count; // @[utils.scala 659:12]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
    if (reset) begin // @[utils.scala 644:22]
      count <= 5'h0; // @[utils.scala 644:22]
    end else if (!(2'h0 == _T_7)) begin // @[utils.scala 645:73]
      if (2'h1 == _T_7) begin // @[utils.scala 645:73]
        count <= _count_T_1; // @[utils.scala 650:13]
      end else if (2'h2 == _T_7) begin // @[utils.scala 645:73]
        count <= _count_T_3; // @[utils.scala 653:13]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  count = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_3(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [3:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [3:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [2:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [3:0] waddr; // @[utils.scala 523:22]
  reg [3:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [3:0] _waddr_T_1 = waddr + 4'h1; // @[utils.scala 530:31]
  wire [3:0] _raddr_T_1 = raddr + 4'h1; // @[utils.scala 531:31]
  reg [4:0] count; // @[utils.scala 534:22]
  wire [4:0] _count_T_1 = count - 5'h1; // @[utils.scala 538:20]
  wire [4:0] _count_T_3 = count + 5'h1; // @[utils.scala 540:20]
  reg [3:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [3:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [3:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 564:62]
  wire [3:0] _T_15 = _T_8 ? {{1'd0}, raddr[3:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [3:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[3:1]}; // @[utils.scala 573:64]
  wire [3:0] _T_26 = _T_19 ? {{1'd0}, raddr[3:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(4), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(4), .DEPTH(8), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 5'h10; // @[utils.scala 576:26]
  assign io_deq_valid = count != 5'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[2:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[2:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 4'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 4'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 5'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 4'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 4'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[3:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  reg_write_data = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay_3(
  input        clock,
  input        reset,
  input        io_enq_valid,
  input  [3:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [3:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [3:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [3:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [3:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo_3 fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 4'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_deq_bits_r = _RAND_1[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo_3(
  input        clock,
  input        reset,
  input        io_enq_valid,
  input  [3:0] io_enq_bits,
  input        io_deq_ready,
  output [3:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [3:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [3:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  standard_fifo_delay_3 standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axi_r_ctrl(
  input          clock,
  input          reset,
  output [63:0]  io_axi_m_araddr,
  output [7:0]   io_axi_m_arlen,
  output         io_axi_m_arvalid,
  input          io_axi_m_arready,
  input  [127:0] io_axi_m_rdata,
  input          io_axi_m_rlast,
  input          io_axi_m_rvalid,
  output         io_axi_m_rready,
  input          io_dma_areq,
  input  [63:0]  io_dma_addr,
  input  [31:0]  io_dma_size,
  output [127:0] io_dma_data,
  output         io_dma_valid,
  input          io_dma_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [127:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [127:0] _RAND_21;
`endif // RANDOMIZE_REG_INIT
  wire  addr_fifo_clock; // @[axiRecvArbit.scala 274:25]
  wire  addr_fifo_reset; // @[axiRecvArbit.scala 274:25]
  wire  addr_fifo_io_enq_ready; // @[axiRecvArbit.scala 274:25]
  wire  addr_fifo_io_enq_valid; // @[axiRecvArbit.scala 274:25]
  wire [63:0] addr_fifo_io_enq_bits; // @[axiRecvArbit.scala 274:25]
  wire  addr_fifo_io_deq_ready; // @[axiRecvArbit.scala 274:25]
  wire  addr_fifo_io_deq_valid; // @[axiRecvArbit.scala 274:25]
  wire [63:0] addr_fifo_io_deq_bits; // @[axiRecvArbit.scala 274:25]
  wire  size_fifo_clock; // @[axiRecvArbit.scala 275:25]
  wire  size_fifo_reset; // @[axiRecvArbit.scala 275:25]
  wire  size_fifo_io_enq_ready; // @[axiRecvArbit.scala 275:25]
  wire  size_fifo_io_enq_valid; // @[axiRecvArbit.scala 275:25]
  wire [32:0] size_fifo_io_enq_bits; // @[axiRecvArbit.scala 275:25]
  wire  size_fifo_io_deq_ready; // @[axiRecvArbit.scala 275:25]
  wire  size_fifo_io_deq_valid; // @[axiRecvArbit.scala 275:25]
  wire [32:0] size_fifo_io_deq_bits; // @[axiRecvArbit.scala 275:25]
  wire [4:0] size_fifo_io_count; // @[axiRecvArbit.scala 275:25]
  wire  size_send_fifo_clock; // @[axiRecvArbit.scala 276:30]
  wire  size_send_fifo_reset; // @[axiRecvArbit.scala 276:30]
  wire  size_send_fifo_io_enq_ready; // @[axiRecvArbit.scala 276:30]
  wire  size_send_fifo_io_enq_valid; // @[axiRecvArbit.scala 276:30]
  wire [32:0] size_send_fifo_io_enq_bits; // @[axiRecvArbit.scala 276:30]
  wire  size_send_fifo_io_deq_ready; // @[axiRecvArbit.scala 276:30]
  wire  size_send_fifo_io_deq_valid; // @[axiRecvArbit.scala 276:30]
  wire [32:0] size_send_fifo_io_deq_bits; // @[axiRecvArbit.scala 276:30]
  wire [4:0] size_send_fifo_io_count; // @[axiRecvArbit.scala 276:30]
  wire  strb_send_fifo_clock; // @[axiRecvArbit.scala 277:30]
  wire  strb_send_fifo_reset; // @[axiRecvArbit.scala 277:30]
  wire  strb_send_fifo_io_enq_valid; // @[axiRecvArbit.scala 277:30]
  wire [3:0] strb_send_fifo_io_enq_bits; // @[axiRecvArbit.scala 277:30]
  wire  strb_send_fifo_io_deq_ready; // @[axiRecvArbit.scala 277:30]
  wire [3:0] strb_send_fifo_io_deq_bits; // @[axiRecvArbit.scala 277:30]
  reg  areq_pr; // @[axiRecvArbit.scala 282:24]
  reg [63:0] addr_pr; // @[axiRecvArbit.scala 316:24]
  wire  areq2 = ~areq_pr & io_dma_areq | io_dma_areq & io_dma_addr != addr_pr; // @[axiRecvArbit.scala 318:41]
  wire  fifo_enq_areq = areq2 & addr_fifo_io_enq_ready; // @[axiRecvArbit.scala 320:29]
  wire  addr_align_flag = io_dma_addr[3:0] == 4'h0; // @[axiRecvArbit.scala 321:43]
  reg [63:0] addr_fifo_enq_bits; // @[axiRecvArbit.scala 322:35]
  reg [31:0] size_fifo_enq_bits; // @[axiRecvArbit.scala 323:35]
  reg [32:0] size_send_fifo_enq_bits; // @[axiRecvArbit.scala 324:40]
  reg [3:0] strb_send_fifo_enq_bits; // @[axiRecvArbit.scala 325:40]
  reg  addr_fifo_io_enq_valid_REG; // @[axiRecvArbit.scala 326:36]
  wire [63:0] _addr_fifo_enq_bits_T_1 = {io_dma_addr[63:4],4'h0}; // @[Cat.scala 33:92]
  wire [31:0] _size_fifo_enq_bits_T_1 = io_dma_size + 32'h1; // @[axiRecvArbit.scala 336:87]
  wire [32:0] _size_fifo_enq_bits_T_2 = {1'h1,_size_fifo_enq_bits_T_1}; // @[Cat.scala 33:92]
  wire [32:0] _size_fifo_enq_bits_T_3 = addr_align_flag ? {{1'd0}, io_dma_size} : _size_fifo_enq_bits_T_2; // @[axiRecvArbit.scala 336:30]
  wire [31:0] _size_send_fifo_enq_bits_T_1 = io_dma_size - 32'h1; // @[axiRecvArbit.scala 337:64]
  wire [32:0] _size_send_fifo_enq_bits_T_2 = {1'h1,io_dma_size}; // @[Cat.scala 33:92]
  wire [32:0] _GEN_1 = fifo_enq_areq ? _size_fifo_enq_bits_T_3 : {{1'd0}, size_fifo_enq_bits}; // @[axiRecvArbit.scala 334:23 336:24 323:35]
  reg [4:0] outstanding_cnt; // @[axiRecvArbit.scala 341:32]
  wire  _T = io_axi_m_arvalid & io_axi_m_arready; // @[axiRecvArbit.scala 342:30]
  wire  _T_2 = io_axi_m_rlast & io_axi_m_rvalid & io_axi_m_rready; // @[axiRecvArbit.scala 342:81]
  wire [1:0] _T_3 = {_T,_T_2}; // @[Cat.scala 33:92]
  wire [4:0] _outstanding_cnt_T_1 = outstanding_cnt - 5'h1; // @[axiRecvArbit.scala 347:42]
  wire [4:0] _outstanding_cnt_T_3 = outstanding_cnt + 5'h1; // @[axiRecvArbit.scala 350:42]
  reg [1:0] state; // @[axiRecvArbit.scala 376:22]
  reg [31:0] fifo_size_left; // @[axiRecvArbit.scala 377:31]
  reg [63:0] fifo_addr_left; // @[axiRecvArbit.scala 378:31]
  wire  size_gt_256 = fifo_size_left >= 32'h100; // @[axiRecvArbit.scala 379:36]
  wire [8:0] size_limit = size_gt_256 ? 9'h100 : fifo_size_left[8:0]; // @[axiRecvArbit.scala 380:23]
  wire [12:0] _addr_end_T = {size_limit,4'h0}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_88 = {{51'd0}, _addr_end_T}; // @[axiRecvArbit.scala 381:33]
  wire [63:0] addr_end = fifo_addr_left + _GEN_88; // @[axiRecvArbit.scala 381:33]
  wire [63:0] addr_4K = {addr_end[63:12],12'h0}; // @[Cat.scala 33:92]
  wire  cross_4K = addr_end[63:12] > fifo_addr_left[63:12] & addr_end[11:0] != 12'h0; // @[axiRecvArbit.scala 383:88]
  wire [63:0] _cross_4K_size_T_1 = addr_4K - fifo_addr_left; // @[axiRecvArbit.scala 385:29]
  reg [63:0] send_addr; // @[axiRecvArbit.scala 386:26]
  reg [8:0] send_size; // @[axiRecvArbit.scala 387:26]
  wire [32:0] size_send_fifo_odata = size_send_fifo_io_count == 5'h0 ? 33'h0 : size_send_fifo_io_deq_bits; // @[axiRecvArbit.scala 390:33]
  reg  arvalid; // @[axiRecvArbit.scala 391:24]
  wire  _T_9 = fifo_size_left == 32'h0; // @[axiRecvArbit.scala 395:53]
  wire  _T_11 = outstanding_cnt < 5'hf; // @[axiRecvArbit.scala 395:80]
  wire  _T_12 = addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf; // @[axiRecvArbit.scala 395:61]
  wire [32:0] _GEN_9 = addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf ? size_fifo_io_deq_bits
     : 33'h0; // @[axiRecvArbit.scala 395:109 398:24 402:24]
  wire [1:0] _T_14 = {cross_4K,size_gt_256}; // @[Cat.scala 33:92]
  wire [63:0] _fifo_addr_left_T_1 = fifo_addr_left + 64'h1000; // @[axiRecvArbit.scala 418:44]
  wire [31:0] _fifo_size_left_T_1 = fifo_size_left - 32'h100; // @[axiRecvArbit.scala 419:44]
  wire [8:0] cross_4K_size = _cross_4K_size_T_1[12:4]; // @[axiRecvArbit.scala 384:27 385:17]
  wire [31:0] _GEN_89 = {{23'd0}, cross_4K_size}; // @[axiRecvArbit.scala 425:44]
  wire [31:0] _fifo_size_left_T_3 = fifo_size_left - _GEN_89; // @[axiRecvArbit.scala 425:44]
  wire [63:0] _GEN_12 = 2'h3 == _T_14 ? fifo_addr_left : send_addr; // @[axiRecvArbit.scala 409:40 428:21 386:26]
  wire [8:0] _GEN_13 = 2'h3 == _T_14 ? cross_4K_size : send_size; // @[axiRecvArbit.scala 409:40 429:21 387:26]
  wire [63:0] _GEN_14 = 2'h3 == _T_14 ? addr_4K : fifo_addr_left; // @[axiRecvArbit.scala 409:40 430:26 378:31]
  wire [31:0] _GEN_15 = 2'h3 == _T_14 ? _fifo_size_left_T_3 : fifo_size_left; // @[axiRecvArbit.scala 409:40 431:26 377:31]
  wire [63:0] _GEN_16 = 2'h2 == _T_14 ? fifo_addr_left : _GEN_12; // @[axiRecvArbit.scala 409:40 422:21]
  wire [8:0] _GEN_17 = 2'h2 == _T_14 ? cross_4K_size : _GEN_13; // @[axiRecvArbit.scala 409:40 423:21]
  wire [63:0] _GEN_18 = 2'h2 == _T_14 ? addr_4K : _GEN_14; // @[axiRecvArbit.scala 409:40 424:26]
  wire [31:0] _GEN_19 = 2'h2 == _T_14 ? _fifo_size_left_T_3 : _GEN_15; // @[axiRecvArbit.scala 409:40 425:26]
  wire [63:0] _GEN_20 = 2'h1 == _T_14 ? fifo_addr_left : _GEN_16; // @[axiRecvArbit.scala 409:40 416:21]
  wire [8:0] _GEN_21 = 2'h1 == _T_14 ? 9'h100 : _GEN_17; // @[axiRecvArbit.scala 409:40 417:21]
  wire [63:0] _GEN_22 = 2'h1 == _T_14 ? _fifo_addr_left_T_1 : _GEN_18; // @[axiRecvArbit.scala 409:40 418:26]
  wire [31:0] _GEN_23 = 2'h1 == _T_14 ? _fifo_size_left_T_1 : _GEN_19; // @[axiRecvArbit.scala 409:40 419:26]
  wire [31:0] _GEN_25 = 2'h0 == _T_14 ? fifo_size_left : {{23'd0}, _GEN_21}; // @[axiRecvArbit.scala 409:40 412:21]
  wire [31:0] _GEN_26 = 2'h0 == _T_14 ? 32'h0 : _GEN_23; // @[axiRecvArbit.scala 409:40 413:26]
  wire  _T_23 = addr_fifo_io_deq_valid & _T_11; // @[axiRecvArbit.scala 441:39]
  wire [32:0] _GEN_29 = addr_fifo_io_deq_valid & _T_11 ? size_fifo_io_deq_bits : {{1'd0}, fifo_size_left}; // @[axiRecvArbit.scala 441:87 444:28 377:31]
  wire [63:0] _GEN_30 = addr_fifo_io_deq_valid & _T_11 ? addr_fifo_io_deq_bits : fifo_addr_left; // @[axiRecvArbit.scala 441:87 445:28 378:31]
  wire [1:0] _GEN_31 = addr_fifo_io_deq_valid & _T_11 ? 2'h1 : 2'h0; // @[axiRecvArbit.scala 441:87 446:19 448:19]
  wire  _GEN_32 = _T_9 & _T_23; // @[axiRecvArbit.scala 388:26 440:37]
  wire [32:0] _GEN_33 = _T_9 ? _GEN_29 : {{1'd0}, fifo_size_left}; // @[axiRecvArbit.scala 377:31 440:37]
  wire [63:0] _GEN_34 = _T_9 ? _GEN_30 : fifo_addr_left; // @[axiRecvArbit.scala 378:31 440:37]
  wire [1:0] _GEN_35 = _T_9 ? _GEN_31 : 2'h1; // @[axiRecvArbit.scala 440:37 451:17]
  wire  _GEN_36 = _T ? 1'h0 : arvalid; // @[axiRecvArbit.scala 438:49 439:17 391:24]
  wire  _GEN_37 = _T & _GEN_32; // @[axiRecvArbit.scala 388:26 438:49]
  wire [32:0] _GEN_38 = _T ? _GEN_33 : {{1'd0}, fifo_size_left}; // @[axiRecvArbit.scala 377:31 438:49]
  wire [63:0] _GEN_39 = _T ? _GEN_34 : fifo_addr_left; // @[axiRecvArbit.scala 378:31 438:49]
  wire [1:0] _GEN_40 = _T ? _GEN_35 : 2'h2; // @[axiRecvArbit.scala 438:49 454:15]
  wire  _GEN_41 = 2'h2 == state ? _GEN_36 : arvalid; // @[axiRecvArbit.scala 393:16 391:24]
  wire  _GEN_42 = 2'h2 == state & _GEN_37; // @[axiRecvArbit.scala 393:16 388:26]
  wire [32:0] _GEN_43 = 2'h2 == state ? _GEN_38 : {{1'd0}, fifo_size_left}; // @[axiRecvArbit.scala 393:16 377:31]
  wire  _GEN_46 = 2'h1 == state ? 1'h0 : _GEN_42; // @[axiRecvArbit.scala 393:16 407:30]
  wire [31:0] _GEN_48 = 2'h1 == state ? _GEN_25 : {{23'd0}, send_size}; // @[axiRecvArbit.scala 393:16 387:26]
  wire [32:0] _GEN_49 = 2'h1 == state ? {{1'd0}, _GEN_26} : _GEN_43; // @[axiRecvArbit.scala 393:16]
  wire  _GEN_52 = 2'h1 == state | _GEN_41; // @[axiRecvArbit.scala 393:16 435:15]
  wire [32:0] _GEN_54 = 2'h0 == state ? _GEN_9 : _GEN_49; // @[axiRecvArbit.scala 393:16]
  wire [31:0] _GEN_58 = 2'h0 == state ? {{23'd0}, send_size} : _GEN_48; // @[axiRecvArbit.scala 393:16 387:26]
  reg [31:0] last_cnt; // @[axiRecvArbit.scala 459:25]
  reg [31:0] send_len; // @[axiRecvArbit.scala 460:25]
  reg [3:0] strb; // @[axiRecvArbit.scala 461:21]
  reg  valid_mask_en; // @[axiRecvArbit.scala 462:30]
  wire  _T_24 = io_axi_m_rvalid & io_axi_m_rready; // @[axiRecvArbit.scala 463:24]
  wire  _T_25 = last_cnt == send_len; // @[axiRecvArbit.scala 464:19]
  wire [31:0] _last_cnt_T_1 = last_cnt + 32'h1; // @[axiRecvArbit.scala 467:28]
  reg [1:0] rlast_state; // @[axiRecvArbit.scala 473:28]
  wire  _GEN_63 = size_send_fifo_io_deq_valid; // @[axiRecvArbit.scala 480:41 481:37 490:37]
  wire  _GEN_64 = size_send_fifo_io_deq_valid ? size_send_fifo_odata[32] : valid_mask_en; // @[axiRecvArbit.scala 480:41 482:23 462:30]
  wire [31:0] _GEN_65 = size_send_fifo_io_deq_valid ? {{1'd0}, size_send_fifo_odata[30:0]} : send_len; // @[axiRecvArbit.scala 480:41 483:18 460:25]
  wire [1:0] _GEN_68 = size_send_fifo_io_deq_valid ? 2'h2 : 2'h0; // @[axiRecvArbit.scala 497:42 500:23 503:23]
  wire  _GEN_70 = _T_25 & _GEN_63; // @[axiRecvArbit.scala 496:34 495:35]
  reg [127:0] axi_data_t; // @[Reg.scala 35:20]
  wire  rvalid_mask = valid_mask_en & last_cnt == 32'h0; // @[axiRecvArbit.scala 516:35]
  wire [127:0] _dma_data_T_2 = {io_axi_m_rdata[31:0],axi_data_t[127:32]}; // @[Cat.scala 33:92]
  wire [127:0] _dma_data_T_5 = {io_axi_m_rdata[63:0],axi_data_t[127:64]}; // @[Cat.scala 33:92]
  wire [127:0] _dma_data_T_8 = {io_axi_m_rdata[95:0],axi_data_t[127:96]}; // @[Cat.scala 33:92]
  wire [127:0] _GEN_85 = 4'hc == strb ? _dma_data_T_8 : io_axi_m_rdata; // @[axiRecvArbit.scala 523:13 524:16 532:16]
  wire [127:0] _GEN_86 = 4'h8 == strb ? _dma_data_T_5 : _GEN_85; // @[axiRecvArbit.scala 524:16 529:16]
  reg  io_dma_valid_REG; // @[axiRecvArbit.scala 536:26]
  reg [127:0] io_dma_data_REG; // @[axiRecvArbit.scala 537:25]
  wire [8:0] _io_axi_m_arlen_T_1 = send_size - 9'h1; // @[axiRecvArbit.scala 543:31]
  wire [127:0] dma_data = 4'h4 == strb ? _dma_data_T_2 : _GEN_86; // @[axiRecvArbit.scala 524:16 526:16]
  wire [32:0] _GEN_91 = reset ? 33'h0 : _GEN_1; // @[axiRecvArbit.scala 323:{35,35}]
  wire [32:0] _GEN_92 = reset ? 33'h0 : _GEN_54; // @[axiRecvArbit.scala 377:{31,31}]
  wire [31:0] _GEN_93 = reset ? 32'h0 : _GEN_58; // @[axiRecvArbit.scala 387:{26,26}]
  fwft_fifo addr_fifo ( // @[axiRecvArbit.scala 274:25]
    .clock(addr_fifo_clock),
    .reset(addr_fifo_reset),
    .io_enq_ready(addr_fifo_io_enq_ready),
    .io_enq_valid(addr_fifo_io_enq_valid),
    .io_enq_bits(addr_fifo_io_enq_bits),
    .io_deq_ready(addr_fifo_io_deq_ready),
    .io_deq_valid(addr_fifo_io_deq_valid),
    .io_deq_bits(addr_fifo_io_deq_bits)
  );
  fwft_fifo_1 size_fifo ( // @[axiRecvArbit.scala 275:25]
    .clock(size_fifo_clock),
    .reset(size_fifo_reset),
    .io_enq_ready(size_fifo_io_enq_ready),
    .io_enq_valid(size_fifo_io_enq_valid),
    .io_enq_bits(size_fifo_io_enq_bits),
    .io_deq_ready(size_fifo_io_deq_ready),
    .io_deq_valid(size_fifo_io_deq_valid),
    .io_deq_bits(size_fifo_io_deq_bits),
    .io_count(size_fifo_io_count)
  );
  fwft_fifo_1 size_send_fifo ( // @[axiRecvArbit.scala 276:30]
    .clock(size_send_fifo_clock),
    .reset(size_send_fifo_reset),
    .io_enq_ready(size_send_fifo_io_enq_ready),
    .io_enq_valid(size_send_fifo_io_enq_valid),
    .io_enq_bits(size_send_fifo_io_enq_bits),
    .io_deq_ready(size_send_fifo_io_deq_ready),
    .io_deq_valid(size_send_fifo_io_deq_valid),
    .io_deq_bits(size_send_fifo_io_deq_bits),
    .io_count(size_send_fifo_io_count)
  );
  fwft_fifo_3 strb_send_fifo ( // @[axiRecvArbit.scala 277:30]
    .clock(strb_send_fifo_clock),
    .reset(strb_send_fifo_reset),
    .io_enq_valid(strb_send_fifo_io_enq_valid),
    .io_enq_bits(strb_send_fifo_io_enq_bits),
    .io_deq_ready(strb_send_fifo_io_deq_ready),
    .io_deq_bits(strb_send_fifo_io_deq_bits)
  );
  assign io_axi_m_araddr = send_addr; // @[axiRecvArbit.scala 542:19]
  assign io_axi_m_arlen = _io_axi_m_arlen_T_1[7:0]; // @[axiRecvArbit.scala 543:18]
  assign io_axi_m_arvalid = arvalid; // @[axiRecvArbit.scala 550:20]
  assign io_axi_m_rready = io_dma_ready; // @[axiRecvArbit.scala 551:19]
  assign io_dma_data = io_dma_data_REG; // @[axiRecvArbit.scala 537:15]
  assign io_dma_valid = io_dma_valid_REG; // @[axiRecvArbit.scala 536:16]
  assign addr_fifo_clock = clock;
  assign addr_fifo_reset = reset;
  assign addr_fifo_io_enq_valid = addr_fifo_io_enq_valid_REG; // @[axiRecvArbit.scala 326:26]
  assign addr_fifo_io_enq_bits = addr_fifo_enq_bits; // @[axiRecvArbit.scala 328:25]
  assign addr_fifo_io_deq_ready = 2'h0 == state ? _T_12 : _GEN_46; // @[axiRecvArbit.scala 393:16]
  assign size_fifo_clock = clock;
  assign size_fifo_reset = reset;
  assign size_fifo_io_enq_valid = addr_fifo_io_enq_valid; // @[axiRecvArbit.scala 327:26]
  assign size_fifo_io_enq_bits = {{1'd0}, size_fifo_enq_bits}; // @[axiRecvArbit.scala 329:25]
  assign size_fifo_io_deq_ready = 2'h0 == state ? _T_12 : _GEN_46; // @[axiRecvArbit.scala 393:16]
  assign size_send_fifo_clock = clock;
  assign size_send_fifo_reset = reset;
  assign size_send_fifo_io_enq_valid = size_fifo_io_enq_valid; // @[axiRecvArbit.scala 330:31]
  assign size_send_fifo_io_enq_bits = size_send_fifo_enq_bits; // @[axiRecvArbit.scala 331:30]
  assign size_send_fifo_io_deq_ready = 2'h0 == rlast_state ? _GEN_63 : 2'h1 == rlast_state & _GEN_70; // @[axiRecvArbit.scala 478:22]
  assign strb_send_fifo_clock = clock;
  assign strb_send_fifo_reset = reset;
  assign strb_send_fifo_io_enq_valid = addr_fifo_io_enq_valid; // @[axiRecvArbit.scala 332:31]
  assign strb_send_fifo_io_enq_bits = strb_send_fifo_enq_bits; // @[axiRecvArbit.scala 333:30]
  assign strb_send_fifo_io_deq_ready = size_send_fifo_io_deq_ready; // @[axiRecvArbit.scala 475:31]
  always @(posedge clock) begin
    areq_pr <= io_dma_areq; // @[axiRecvArbit.scala 282:24]
    addr_pr <= io_dma_addr; // @[axiRecvArbit.scala 316:24]
    if (reset) begin // @[axiRecvArbit.scala 322:35]
      addr_fifo_enq_bits <= 64'h0; // @[axiRecvArbit.scala 322:35]
    end else if (fifo_enq_areq) begin // @[axiRecvArbit.scala 334:23]
      if (addr_align_flag) begin // @[axiRecvArbit.scala 335:30]
        addr_fifo_enq_bits <= io_dma_addr;
      end else begin
        addr_fifo_enq_bits <= _addr_fifo_enq_bits_T_1;
      end
    end
    size_fifo_enq_bits <= _GEN_91[31:0]; // @[axiRecvArbit.scala 323:{35,35}]
    if (reset) begin // @[axiRecvArbit.scala 324:40]
      size_send_fifo_enq_bits <= 33'h0; // @[axiRecvArbit.scala 324:40]
    end else if (fifo_enq_areq) begin // @[axiRecvArbit.scala 334:23]
      if (addr_align_flag) begin // @[axiRecvArbit.scala 337:35]
        size_send_fifo_enq_bits <= {{1'd0}, _size_send_fifo_enq_bits_T_1};
      end else begin
        size_send_fifo_enq_bits <= _size_send_fifo_enq_bits_T_2;
      end
    end
    if (reset) begin // @[axiRecvArbit.scala 325:40]
      strb_send_fifo_enq_bits <= 4'h0; // @[axiRecvArbit.scala 325:40]
    end else if (fifo_enq_areq) begin // @[axiRecvArbit.scala 334:23]
      strb_send_fifo_enq_bits <= io_dma_addr[3:0]; // @[axiRecvArbit.scala 338:29]
    end
    addr_fifo_io_enq_valid_REG <= areq2 & addr_fifo_io_enq_ready; // @[axiRecvArbit.scala 320:29]
    if (reset) begin // @[axiRecvArbit.scala 341:32]
      outstanding_cnt <= 5'h0; // @[axiRecvArbit.scala 341:32]
    end else if (!(2'h0 == _T_3)) begin // @[axiRecvArbit.scala 342:100]
      if (2'h1 == _T_3) begin // @[axiRecvArbit.scala 342:100]
        outstanding_cnt <= _outstanding_cnt_T_1; // @[axiRecvArbit.scala 347:23]
      end else if (2'h2 == _T_3) begin // @[axiRecvArbit.scala 342:100]
        outstanding_cnt <= _outstanding_cnt_T_3; // @[axiRecvArbit.scala 350:23]
      end
    end
    if (reset) begin // @[axiRecvArbit.scala 376:22]
      state <= 2'h0; // @[axiRecvArbit.scala 376:22]
    end else if (2'h0 == state) begin // @[axiRecvArbit.scala 393:16]
      if (addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf) begin // @[axiRecvArbit.scala 395:109]
        state <= 2'h1; // @[axiRecvArbit.scala 400:15]
      end else begin
        state <= 2'h0; // @[axiRecvArbit.scala 403:15]
      end
    end else if (2'h1 == state) begin // @[axiRecvArbit.scala 393:16]
      state <= 2'h2; // @[axiRecvArbit.scala 434:13]
    end else if (2'h2 == state) begin // @[axiRecvArbit.scala 393:16]
      state <= _GEN_40;
    end
    fifo_size_left <= _GEN_92[31:0]; // @[axiRecvArbit.scala 377:{31,31}]
    if (reset) begin // @[axiRecvArbit.scala 378:31]
      fifo_addr_left <= 64'h0; // @[axiRecvArbit.scala 378:31]
    end else if (2'h0 == state) begin // @[axiRecvArbit.scala 393:16]
      if (addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf) begin // @[axiRecvArbit.scala 395:109]
        fifo_addr_left <= addr_fifo_io_deq_bits; // @[axiRecvArbit.scala 399:24]
      end
    end else if (2'h1 == state) begin // @[axiRecvArbit.scala 393:16]
      if (!(2'h0 == _T_14)) begin // @[axiRecvArbit.scala 409:40]
        fifo_addr_left <= _GEN_22;
      end
    end else if (2'h2 == state) begin // @[axiRecvArbit.scala 393:16]
      fifo_addr_left <= _GEN_39;
    end
    if (reset) begin // @[axiRecvArbit.scala 386:26]
      send_addr <= 64'h0; // @[axiRecvArbit.scala 386:26]
    end else if (!(2'h0 == state)) begin // @[axiRecvArbit.scala 393:16]
      if (2'h1 == state) begin // @[axiRecvArbit.scala 393:16]
        if (2'h0 == _T_14) begin // @[axiRecvArbit.scala 409:40]
          send_addr <= fifo_addr_left; // @[axiRecvArbit.scala 411:21]
        end else begin
          send_addr <= _GEN_20;
        end
      end
    end
    send_size <= _GEN_93[8:0]; // @[axiRecvArbit.scala 387:{26,26}]
    if (reset) begin // @[axiRecvArbit.scala 391:24]
      arvalid <= 1'h0; // @[axiRecvArbit.scala 391:24]
    end else if (!(2'h0 == state)) begin // @[axiRecvArbit.scala 393:16]
      arvalid <= _GEN_52;
    end
    if (reset) begin // @[axiRecvArbit.scala 459:25]
      last_cnt <= 32'h0; // @[axiRecvArbit.scala 459:25]
    end else if (io_axi_m_rvalid & io_axi_m_rready) begin // @[axiRecvArbit.scala 463:43]
      if (last_cnt == send_len) begin // @[axiRecvArbit.scala 464:32]
        last_cnt <= 32'h0; // @[axiRecvArbit.scala 465:16]
      end else begin
        last_cnt <= _last_cnt_T_1; // @[axiRecvArbit.scala 467:16]
      end
    end
    if (reset) begin // @[axiRecvArbit.scala 460:25]
      send_len <= 32'h0; // @[axiRecvArbit.scala 460:25]
    end else if (2'h0 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      send_len <= _GEN_65;
    end else if (2'h1 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      if (_T_25) begin // @[axiRecvArbit.scala 496:34]
        send_len <= _GEN_65;
      end
    end
    if (reset) begin // @[axiRecvArbit.scala 461:21]
      strb <= 4'h0; // @[axiRecvArbit.scala 461:21]
    end else begin
      strb <= strb_send_fifo_io_deq_bits; // @[axiRecvArbit.scala 476:8]
    end
    if (reset) begin // @[axiRecvArbit.scala 462:30]
      valid_mask_en <= 1'h0; // @[axiRecvArbit.scala 462:30]
    end else if (2'h0 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      valid_mask_en <= _GEN_64;
    end else if (2'h1 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      if (_T_25) begin // @[axiRecvArbit.scala 496:34]
        valid_mask_en <= _GEN_64;
      end
    end
    if (reset) begin // @[axiRecvArbit.scala 473:28]
      rlast_state <= 2'h0; // @[axiRecvArbit.scala 473:28]
    end else if (2'h0 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      if (size_send_fifo_io_deq_valid) begin // @[axiRecvArbit.scala 480:41]
        if (size_send_fifo_odata[32]) begin // @[axiRecvArbit.scala 484:52]
          rlast_state <= 2'h1; // @[axiRecvArbit.scala 485:23]
        end else begin
          rlast_state <= 2'h0; // @[axiRecvArbit.scala 487:23]
        end
      end else begin
        rlast_state <= 2'h0; // @[axiRecvArbit.scala 491:21]
      end
    end else if (2'h1 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      if (_T_25) begin // @[axiRecvArbit.scala 496:34]
        rlast_state <= _GEN_68;
      end else begin
        rlast_state <= 2'h1; // @[axiRecvArbit.scala 506:21]
      end
    end else if (2'h2 == rlast_state) begin // @[axiRecvArbit.scala 478:22]
      rlast_state <= 2'h0; // @[axiRecvArbit.scala 510:19]
    end
    if (reset) begin // @[Reg.scala 35:20]
      axi_data_t <= 128'h0; // @[Reg.scala 35:20]
    end else if (_T_24) begin // @[Reg.scala 36:18]
      axi_data_t <= io_axi_m_rdata; // @[Reg.scala 36:22]
    end
    io_dma_valid_REG <= ~rvalid_mask & io_axi_m_rvalid & io_axi_m_rready; // @[axiRecvArbit.scala 517:51]
    io_dma_data_REG <= dma_data; // @[axiRecvArbit.scala 537:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  areq_pr = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  addr_pr = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  addr_fifo_enq_bits = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  size_fifo_enq_bits = _RAND_3[31:0];
  _RAND_4 = {2{`RANDOM}};
  size_send_fifo_enq_bits = _RAND_4[32:0];
  _RAND_5 = {1{`RANDOM}};
  strb_send_fifo_enq_bits = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  addr_fifo_io_enq_valid_REG = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  outstanding_cnt = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  state = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  fifo_size_left = _RAND_9[31:0];
  _RAND_10 = {2{`RANDOM}};
  fifo_addr_left = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  send_addr = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  send_size = _RAND_12[8:0];
  _RAND_13 = {1{`RANDOM}};
  arvalid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  last_cnt = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  send_len = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  strb = _RAND_16[3:0];
  _RAND_17 = {1{`RANDOM}};
  valid_mask_en = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  rlast_state = _RAND_18[1:0];
  _RAND_19 = {4{`RANDOM}};
  axi_data_t = _RAND_19[127:0];
  _RAND_20 = {1{`RANDOM}};
  io_dma_valid_REG = _RAND_20[0:0];
  _RAND_21 = {4{`RANDOM}};
  io_dma_data_REG = _RAND_21[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_8(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [127:0] io_enq_bits,
  input          io_deq_ready,
  output         io_deq_valid,
  output [127:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [127:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [2:0] waddr; // @[utils.scala 523:22]
  reg [2:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [2:0] _waddr_T_1 = waddr + 3'h1; // @[utils.scala 530:31]
  wire [2:0] _raddr_T_1 = raddr + 3'h1; // @[utils.scala 531:31]
  reg [3:0] count; // @[utils.scala 534:22]
  wire [3:0] _count_T_1 = count - 4'h1; // @[utils.scala 538:20]
  wire [3:0] _count_T_3 = count + 4'h1; // @[utils.scala 540:20]
  reg [127:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [2:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [2:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 564:62]
  wire [2:0] _T_15 = _T_8 ? {{1'd0}, raddr[2:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [2:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 573:64]
  wire [2:0] _T_26 = _T_19 ? {{1'd0}, raddr[2:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(128), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 4'h8; // @[utils.scala 576:26]
  assign io_deq_valid = count != 4'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[1:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[1:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 3'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 3'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 4'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 128'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 3'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[2:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[3:0];
  _RAND_3 = {4{`RANDOM}};
  reg_write_data = _RAND_3[127:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay_8(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [127:0] io_enq_bits,
  input          io_deq_ready,
  output         io_deq_valid,
  output [127:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [127:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [127:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [127:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [127:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo_8 fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_enq_ready = fifo_io_enq_ready; // @[utils.scala 593:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 128'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {4{`RANDOM}};
  io_deq_bits_r = _RAND_1[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo_8(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [127:0] io_enq_bits,
  input          io_deq_ready,
  output         io_deq_valid,
  output [127:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [127:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [127:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  standard_fifo_delay_8 standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_ready(standard_fifo_delay_io_enq_ready),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_enq_ready = standard_fifo_delay_io_enq_ready; // @[utils.scala 634:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 636:16]
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_9(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [63:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [2:0] waddr; // @[utils.scala 523:22]
  reg [2:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [2:0] _waddr_T_1 = waddr + 3'h1; // @[utils.scala 530:31]
  wire [2:0] _raddr_T_1 = raddr + 3'h1; // @[utils.scala 531:31]
  reg [3:0] count; // @[utils.scala 534:22]
  wire [3:0] _count_T_1 = count - 4'h1; // @[utils.scala 538:20]
  wire [3:0] _count_T_3 = count + 4'h1; // @[utils.scala 540:20]
  reg [63:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [2:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [2:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 564:62]
  wire [2:0] _T_15 = _T_8 ? {{1'd0}, raddr[2:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [2:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 573:64]
  wire [2:0] _T_26 = _T_19 ? {{1'd0}, raddr[2:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(64), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(64), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 4'h8; // @[utils.scala 576:26]
  assign io_deq_valid = count != 4'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[1:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[1:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 3'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 3'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 4'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 64'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 3'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[2:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[3:0];
  _RAND_3 = {2{`RANDOM}};
  reg_write_data = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay_9(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [63:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [63:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [63:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo_9 fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_enq_ready = fifo_io_enq_ready; // @[utils.scala 593:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 64'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  io_deq_bits_r = _RAND_1[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo_9(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [63:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [63:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  standard_fifo_delay_9 standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_ready(standard_fifo_delay_io_enq_ready),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_enq_ready = standard_fifo_delay_io_enq_ready; // @[utils.scala 634:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 636:16]
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_10(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [31:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [31:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [1:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [31:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [31:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [2:0] waddr; // @[utils.scala 523:22]
  reg [2:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [2:0] _waddr_T_1 = waddr + 3'h1; // @[utils.scala 530:31]
  wire [2:0] _raddr_T_1 = raddr + 3'h1; // @[utils.scala 531:31]
  reg [3:0] count; // @[utils.scala 534:22]
  wire [3:0] _count_T_1 = count - 4'h1; // @[utils.scala 538:20]
  wire [3:0] _count_T_3 = count + 4'h1; // @[utils.scala 540:20]
  reg [31:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [2:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [2:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 564:62]
  wire [2:0] _T_15 = _T_8 ? {{1'd0}, raddr[2:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [2:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[2:1]}; // @[utils.scala 573:64]
  wire [2:0] _T_26 = _T_19 ? {{1'd0}, raddr[2:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(32), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(4), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 4'h8; // @[utils.scala 576:26]
  assign io_deq_valid = count != 4'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[1:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[1:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 3'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 3'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 4'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 32'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 3'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[2:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  reg_write_data = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_delay_10(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  fifo_clock; // @[utils.scala 591:28]
  wire  fifo_reset; // @[utils.scala 591:28]
  wire  fifo_io_enq_ready; // @[utils.scala 591:28]
  wire  fifo_io_enq_valid; // @[utils.scala 591:28]
  wire [31:0] fifo_io_enq_bits; // @[utils.scala 591:28]
  wire  fifo_io_deq_ready; // @[utils.scala 591:28]
  wire  fifo_io_deq_valid; // @[utils.scala 591:28]
  wire [31:0] fifo_io_deq_bits; // @[utils.scala 591:28]
  reg  fifo_o_valid; // @[utils.scala 592:29]
  reg [31:0] io_deq_bits_r; // @[Reg.scala 35:20]
  wire  _GEN_1 = io_deq_ready & ~fifo_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 598:50 599:18 592:29]
  wire  _GEN_2 = fifo_io_deq_ready | _GEN_1; // @[utils.scala 596:27 597:18]
  standard_fifo_10 fifo ( // @[utils.scala 591:28]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_enq_ready = fifo_io_enq_ready; // @[utils.scala 593:16]
  assign io_deq_valid = fifo_o_valid; // @[utils.scala 595:16]
  assign io_deq_bits = io_deq_bits_r; // @[utils.scala 594:16]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_enq_valid; // @[utils.scala 593:16]
  assign fifo_io_enq_bits = io_enq_bits; // @[utils.scala 593:16]
  assign fifo_io_deq_ready = (~fifo_o_valid | io_deq_ready) & fifo_io_deq_valid; // @[utils.scala 601:56]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 592:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 592:29]
    end else begin
      fifo_o_valid <= _GEN_2;
    end
    if (reset) begin // @[Reg.scala 35:20]
      io_deq_bits_r <= 32'h0; // @[Reg.scala 35:20]
    end else if (io_deq_ready) begin // @[Reg.scala 36:18]
      io_deq_bits_r <= fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_deq_bits_r = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fwft_fifo_10(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output [31:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  standard_fifo_delay_clock; // @[utils.scala 632:43]
  wire  standard_fifo_delay_reset; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_enq_valid; // @[utils.scala 632:43]
  wire [31:0] standard_fifo_delay_io_enq_bits; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_ready; // @[utils.scala 632:43]
  wire  standard_fifo_delay_io_deq_valid; // @[utils.scala 632:43]
  wire [31:0] standard_fifo_delay_io_deq_bits; // @[utils.scala 632:43]
  reg  fifo_o_valid; // @[utils.scala 633:29]
  wire  _GEN_0 = io_deq_ready & ~standard_fifo_delay_io_deq_valid ? 1'h0 : fifo_o_valid; // @[utils.scala 639:47 640:18 633:29]
  wire  _GEN_1 = standard_fifo_delay_io_deq_ready | _GEN_0; // @[utils.scala 637:24 638:18]
  standard_fifo_delay_10 standard_fifo_delay ( // @[utils.scala 632:43]
    .clock(standard_fifo_delay_clock),
    .reset(standard_fifo_delay_reset),
    .io_enq_ready(standard_fifo_delay_io_enq_ready),
    .io_enq_valid(standard_fifo_delay_io_enq_valid),
    .io_enq_bits(standard_fifo_delay_io_enq_bits),
    .io_deq_ready(standard_fifo_delay_io_deq_ready),
    .io_deq_valid(standard_fifo_delay_io_deq_valid),
    .io_deq_bits(standard_fifo_delay_io_deq_bits)
  );
  assign io_enq_ready = standard_fifo_delay_io_enq_ready; // @[utils.scala 634:16]
  assign io_deq_bits = standard_fifo_delay_io_deq_bits; // @[utils.scala 635:16]
  assign standard_fifo_delay_clock = clock;
  assign standard_fifo_delay_reset = reset;
  assign standard_fifo_delay_io_enq_valid = io_enq_valid; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_enq_bits = io_enq_bits; // @[utils.scala 634:16]
  assign standard_fifo_delay_io_deq_ready = (~fifo_o_valid | io_deq_ready) & standard_fifo_delay_io_deq_valid; // @[utils.scala 642:53]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 633:29]
      fifo_o_valid <= 1'h0; // @[utils.scala 633:29]
    end else begin
      fifo_o_valid <= _GEN_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fifo_o_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [4:0] io_count
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[Decoupled.scala 275:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 275:95]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 275:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 275:95]
  wire [7:0] ram_MPORT_data; // @[Decoupled.scala 275:95]
  wire [3:0] ram_MPORT_addr; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 275:95]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 278:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 279:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 280:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 281:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 52:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[Decoupled.scala 328:32]
  wire [4:0] _io_count_T_1 = maybe_full & ptr_match ? 5'h10 : 5'h0; // @[Decoupled.scala 331:20]
  wire [4:0] _GEN_11 = {{1'd0}, ptr_diff}; // @[Decoupled.scala 331:62]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 275:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 305:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 304:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 312:17]
  assign io_count = _io_count_T_1 | _GEN_11; // @[Decoupled.scala 331:62]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 275:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 288:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 292:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 278:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 278:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 295:27]
      maybe_full <= do_enq; // @[Decoupled.scala 296:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axiSendBufferCell(
  input          clock,
  input          reset,
  input  [127:0] io_opfusion_send_data,
  input  [31:0]  io_opfusion_send_size,
  input  [63:0]  io_opfusion_send_addr,
  input          io_opfusion_send_data_valid,
  input          io_opfusion_send_addr_valid,
  output [63:0]  io_axi_m_awaddr,
  output [7:0]   io_axi_m_awlen,
  output         io_axi_m_awvalid,
  input          io_axi_m_awready,
  output [127:0] io_axi_m_wdata,
  output         io_axi_m_wlast,
  output         io_axi_m_wvalid,
  input          io_axi_m_wready
);
`ifdef RANDOMIZE_REG_INIT
  reg [127:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [127:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire  data_fifo_clock; // @[axiSendBuffer.scala 28:25]
  wire  data_fifo_reset; // @[axiSendBuffer.scala 28:25]
  wire  data_fifo_io_enq_ready; // @[axiSendBuffer.scala 28:25]
  wire  data_fifo_io_enq_valid; // @[axiSendBuffer.scala 28:25]
  wire [127:0] data_fifo_io_enq_bits; // @[axiSendBuffer.scala 28:25]
  wire  data_fifo_io_deq_ready; // @[axiSendBuffer.scala 28:25]
  wire  data_fifo_io_deq_valid; // @[axiSendBuffer.scala 28:25]
  wire [127:0] data_fifo_io_deq_bits; // @[axiSendBuffer.scala 28:25]
  wire  addr_fifo_clock; // @[axiSendBuffer.scala 29:25]
  wire  addr_fifo_reset; // @[axiSendBuffer.scala 29:25]
  wire  addr_fifo_io_enq_ready; // @[axiSendBuffer.scala 29:25]
  wire  addr_fifo_io_enq_valid; // @[axiSendBuffer.scala 29:25]
  wire [63:0] addr_fifo_io_enq_bits; // @[axiSendBuffer.scala 29:25]
  wire  addr_fifo_io_deq_ready; // @[axiSendBuffer.scala 29:25]
  wire  addr_fifo_io_deq_valid; // @[axiSendBuffer.scala 29:25]
  wire [63:0] addr_fifo_io_deq_bits; // @[axiSendBuffer.scala 29:25]
  wire  size_fifo_clock; // @[axiSendBuffer.scala 30:25]
  wire  size_fifo_reset; // @[axiSendBuffer.scala 30:25]
  wire  size_fifo_io_enq_ready; // @[axiSendBuffer.scala 30:25]
  wire  size_fifo_io_enq_valid; // @[axiSendBuffer.scala 30:25]
  wire [31:0] size_fifo_io_enq_bits; // @[axiSendBuffer.scala 30:25]
  wire  size_fifo_io_deq_ready; // @[axiSendBuffer.scala 30:25]
  wire [31:0] size_fifo_io_deq_bits; // @[axiSendBuffer.scala 30:25]
  wire  size_send_fifo_clock; // @[axiSendBuffer.scala 103:30]
  wire  size_send_fifo_reset; // @[axiSendBuffer.scala 103:30]
  wire  size_send_fifo_io_enq_ready; // @[axiSendBuffer.scala 103:30]
  wire  size_send_fifo_io_enq_valid; // @[axiSendBuffer.scala 103:30]
  wire [7:0] size_send_fifo_io_enq_bits; // @[axiSendBuffer.scala 103:30]
  wire  size_send_fifo_io_deq_ready; // @[axiSendBuffer.scala 103:30]
  wire  size_send_fifo_io_deq_valid; // @[axiSendBuffer.scala 103:30]
  wire [7:0] size_send_fifo_io_deq_bits; // @[axiSendBuffer.scala 103:30]
  wire [4:0] size_send_fifo_io_count; // @[axiSendBuffer.scala 103:30]
  reg [127:0] data_fifo_bits; // @[axiSendBuffer.scala 40:32]
  reg [63:0] addr_fifo_bits; // @[axiSendBuffer.scala 41:32]
  reg [31:0] size_fifo_bits; // @[axiSendBuffer.scala 42:32]
  wire  addr_align_flag = io_opfusion_send_addr[3:0] == 4'h0; // @[axiSendBuffer.scala 45:53]
  reg  areq_pr; // @[axiSendBuffer.scala 47:24]
  wire  areq2 = ~areq_pr & io_opfusion_send_addr_valid; // @[axiSendBuffer.scala 49:25]
  reg  data_fifo_valid; // @[axiSendBuffer.scala 51:32]
  reg  addr_fifo_valid; // @[axiSendBuffer.scala 52:32]
  reg  size_fifo_valid; // @[axiSendBuffer.scala 53:32]
  wire [63:0] _addr_fifo_bits_T_1 = {io_opfusion_send_addr[63:4],4'h0}; // @[Cat.scala 33:92]
  wire [31:0] _size_fifo_bits_T_1 = io_opfusion_send_size + 32'h1; // @[axiSendBuffer.scala 61:102]
  wire [32:0] _size_fifo_bits_T_2 = {1'h1,_size_fifo_bits_T_1}; // @[Cat.scala 33:92]
  wire [32:0] _size_fifo_bits_T_3 = addr_align_flag ? {{1'd0}, io_opfusion_send_size} : _size_fifo_bits_T_2; // @[axiSendBuffer.scala 61:25]
  reg [4:0] outstanding_cnt; // @[axiSendBuffer.scala 70:32]
  wire  _T = io_axi_m_awvalid & io_axi_m_awready; // @[axiSendBuffer.scala 71:30]
  wire  _T_2 = io_axi_m_wlast & io_axi_m_wvalid & io_axi_m_wready; // @[axiSendBuffer.scala 71:81]
  wire [1:0] _T_3 = {_T,_T_2}; // @[Cat.scala 33:92]
  wire [4:0] _outstanding_cnt_T_1 = outstanding_cnt - 5'h1; // @[axiSendBuffer.scala 76:42]
  wire [4:0] _outstanding_cnt_T_3 = outstanding_cnt + 5'h1; // @[axiSendBuffer.scala 79:42]
  reg [1:0] state; // @[axiSendBuffer.scala 88:22]
  reg [31:0] fifo_size_left; // @[axiSendBuffer.scala 89:31]
  reg [63:0] fifo_addr_left; // @[axiSendBuffer.scala 90:31]
  wire  size_gt_256 = fifo_size_left >= 32'h100; // @[axiSendBuffer.scala 91:36]
  wire [8:0] size_limit = size_gt_256 ? 9'h100 : fifo_size_left[8:0]; // @[axiSendBuffer.scala 92:23]
  wire [12:0] _addr_end_T = {size_limit,4'h0}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_91 = {{51'd0}, _addr_end_T}; // @[axiSendBuffer.scala 93:33]
  wire [63:0] addr_end = fifo_addr_left + _GEN_91; // @[axiSendBuffer.scala 93:33]
  wire [63:0] addr_4K = {addr_end[63:12],12'h0}; // @[Cat.scala 33:92]
  wire  cross_4K = addr_end[63:12] > fifo_addr_left[63:12] & addr_end[11:0] != 12'h0; // @[axiSendBuffer.scala 95:88]
  wire [63:0] _cross_4K_size_T_1 = addr_4K - fifo_addr_left; // @[axiSendBuffer.scala 97:29]
  reg [63:0] send_addr; // @[axiSendBuffer.scala 98:26]
  reg [8:0] send_size; // @[axiSendBuffer.scala 99:26]
  wire [7:0] size_send_fifo_odata = size_send_fifo_io_count == 5'h0 ? 8'h0 : size_send_fifo_io_deq_bits; // @[axiSendBuffer.scala 108:33]
  reg  awvalid; // @[axiSendBuffer.scala 110:24]
  wire  _T_9 = fifo_size_left == 32'h0; // @[axiSendBuffer.scala 114:53]
  wire  _T_11 = outstanding_cnt < 5'hf; // @[axiSendBuffer.scala 114:80]
  wire  _T_12 = addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf; // @[axiSendBuffer.scala 114:61]
  wire [1:0] _T_14 = {cross_4K,size_gt_256}; // @[Cat.scala 33:92]
  wire [31:0] _size_send_fifo_io_enq_bits_T_1 = fifo_size_left - 32'h1; // @[axiSendBuffer.scala 135:58]
  wire [63:0] _fifo_addr_left_T_1 = fifo_addr_left + 64'h1000; // @[axiSendBuffer.scala 140:46]
  wire [31:0] _fifo_size_left_T_1 = fifo_size_left - 32'h100; // @[axiSendBuffer.scala 141:46]
  wire [8:0] cross_4K_size = _cross_4K_size_T_1[12:4]; // @[axiSendBuffer.scala 96:27 97:17]
  wire [31:0] _GEN_92 = {{23'd0}, cross_4K_size}; // @[axiSendBuffer.scala 148:46]
  wire [31:0] _fifo_size_left_T_3 = fifo_size_left - _GEN_92; // @[axiSendBuffer.scala 148:46]
  wire [8:0] _size_send_fifo_io_enq_bits_T_3 = cross_4K_size - 9'h1; // @[axiSendBuffer.scala 149:57]
  wire [63:0] _GEN_8 = 2'h3 == _T_14 ? fifo_addr_left : send_addr; // @[axiSendBuffer.scala 130:42 152:23 98:26]
  wire [8:0] _GEN_9 = 2'h3 == _T_14 ? cross_4K_size : send_size; // @[axiSendBuffer.scala 130:42 153:23 99:26]
  wire [63:0] _GEN_10 = 2'h3 == _T_14 ? addr_4K : fifo_addr_left; // @[axiSendBuffer.scala 130:42 154:28 90:31]
  wire [31:0] _GEN_11 = 2'h3 == _T_14 ? _fifo_size_left_T_3 : fifo_size_left; // @[axiSendBuffer.scala 130:42 155:28 89:31]
  wire [8:0] _GEN_12 = 2'h3 == _T_14 ? _size_send_fifo_io_enq_bits_T_3 : 9'h0; // @[axiSendBuffer.scala 107:30 130:42 156:40]
  wire [63:0] _GEN_13 = 2'h2 == _T_14 ? fifo_addr_left : _GEN_8; // @[axiSendBuffer.scala 130:42 145:23]
  wire [8:0] _GEN_14 = 2'h2 == _T_14 ? cross_4K_size : _GEN_9; // @[axiSendBuffer.scala 130:42 146:23]
  wire [63:0] _GEN_15 = 2'h2 == _T_14 ? addr_4K : _GEN_10; // @[axiSendBuffer.scala 130:42 147:28]
  wire [31:0] _GEN_16 = 2'h2 == _T_14 ? _fifo_size_left_T_3 : _GEN_11; // @[axiSendBuffer.scala 130:42 148:28]
  wire [8:0] _GEN_17 = 2'h2 == _T_14 ? _size_send_fifo_io_enq_bits_T_3 : _GEN_12; // @[axiSendBuffer.scala 130:42 149:40]
  wire [63:0] _GEN_18 = 2'h1 == _T_14 ? fifo_addr_left : _GEN_13; // @[axiSendBuffer.scala 130:42 138:23]
  wire [8:0] _GEN_19 = 2'h1 == _T_14 ? 9'h100 : _GEN_14; // @[axiSendBuffer.scala 130:42 139:23]
  wire [63:0] _GEN_20 = 2'h1 == _T_14 ? _fifo_addr_left_T_1 : _GEN_15; // @[axiSendBuffer.scala 130:42 140:28]
  wire [31:0] _GEN_21 = 2'h1 == _T_14 ? _fifo_size_left_T_1 : _GEN_16; // @[axiSendBuffer.scala 130:42 141:28]
  wire [8:0] _GEN_22 = 2'h1 == _T_14 ? 9'hff : _GEN_17; // @[axiSendBuffer.scala 130:42 142:40]
  wire [63:0] _GEN_23 = 2'h0 == _T_14 ? fifo_addr_left : _GEN_18; // @[axiSendBuffer.scala 130:42 132:23]
  wire [31:0] _GEN_24 = 2'h0 == _T_14 ? fifo_size_left : {{23'd0}, _GEN_19}; // @[axiSendBuffer.scala 130:42 133:23]
  wire [31:0] _GEN_25 = 2'h0 == _T_14 ? 32'h0 : _GEN_21; // @[axiSendBuffer.scala 130:42 134:28]
  wire [31:0] _GEN_26 = 2'h0 == _T_14 ? _size_send_fifo_io_enq_bits_T_1 : {{23'd0}, _GEN_22}; // @[axiSendBuffer.scala 130:42 135:40]
  wire [63:0] _GEN_27 = 2'h0 == _T_14 ? fifo_addr_left : _GEN_20; // @[axiSendBuffer.scala 130:42 90:31]
  wire  _GEN_28 = size_send_fifo_io_enq_ready; // @[axiSendBuffer.scala 106:31 128:40 129:37]
  wire [31:0] _GEN_30 = size_send_fifo_io_enq_ready ? _GEN_24 : {{23'd0}, send_size}; // @[axiSendBuffer.scala 128:40 99:26]
  wire [31:0] _GEN_32 = size_send_fifo_io_enq_ready ? _GEN_26 : 32'h0; // @[axiSendBuffer.scala 107:30 128:40]
  wire  _GEN_35 = size_send_fifo_io_enq_ready | awvalid; // @[axiSendBuffer.scala 128:40 160:17 110:24]
  wire  _T_23 = addr_fifo_io_deq_valid & _T_11; // @[axiSendBuffer.scala 169:39]
  wire [31:0] _GEN_37 = addr_fifo_io_deq_valid & _T_11 ? size_fifo_io_deq_bits : fifo_size_left; // @[axiSendBuffer.scala 169:87 172:28 89:31]
  wire [63:0] _GEN_38 = addr_fifo_io_deq_valid & _T_11 ? addr_fifo_io_deq_bits : fifo_addr_left; // @[axiSendBuffer.scala 169:87 173:28 90:31]
  wire [1:0] _GEN_39 = addr_fifo_io_deq_valid & _T_11 ? 2'h1 : 2'h0; // @[axiSendBuffer.scala 169:87 174:19 176:19]
  wire  _GEN_40 = _T_9 & _T_23; // @[axiSendBuffer.scala 100:26 168:37]
  wire [31:0] _GEN_41 = _T_9 ? _GEN_37 : fifo_size_left; // @[axiSendBuffer.scala 168:37 89:31]
  wire [63:0] _GEN_42 = _T_9 ? _GEN_38 : fifo_addr_left; // @[axiSendBuffer.scala 168:37 90:31]
  wire [1:0] _GEN_43 = _T_9 ? _GEN_39 : 2'h1; // @[axiSendBuffer.scala 168:37 179:17]
  wire  _GEN_44 = _T ? 1'h0 : awvalid; // @[axiSendBuffer.scala 166:49 167:17 110:24]
  wire  _GEN_45 = _T & _GEN_40; // @[axiSendBuffer.scala 100:26 166:49]
  wire [31:0] _GEN_46 = _T ? _GEN_41 : fifo_size_left; // @[axiSendBuffer.scala 166:49 89:31]
  wire [63:0] _GEN_47 = _T ? _GEN_42 : fifo_addr_left; // @[axiSendBuffer.scala 166:49 90:31]
  wire [1:0] _GEN_48 = _T ? _GEN_43 : 2'h2; // @[axiSendBuffer.scala 166:49 182:15]
  wire  _GEN_50 = 2'h2 == state & _GEN_45; // @[axiSendBuffer.scala 112:16 100:26]
  wire  _GEN_54 = 2'h1 == state ? 1'h0 : _GEN_50; // @[axiSendBuffer.scala 112:16 126:30]
  wire [31:0] _GEN_57 = 2'h1 == state ? _GEN_30 : {{23'd0}, send_size}; // @[axiSendBuffer.scala 112:16 99:26]
  wire [31:0] _GEN_59 = 2'h1 == state ? _GEN_32 : 32'h0; // @[axiSendBuffer.scala 112:16 107:30]
  wire [31:0] _GEN_69 = 2'h0 == state ? {{23'd0}, send_size} : _GEN_57; // @[axiSendBuffer.scala 112:16 99:26]
  wire [31:0] _GEN_70 = 2'h0 == state ? 32'h0 : _GEN_59; // @[axiSendBuffer.scala 112:16 107:30]
  reg [7:0] last_cnt; // @[axiSendBuffer.scala 187:25]
  reg [7:0] send_len; // @[axiSendBuffer.scala 188:25]
  wire  _T_24 = io_axi_m_wvalid & io_axi_m_wready; // @[axiSendBuffer.scala 196:30]
  wire [7:0] _last_cnt_T_1 = last_cnt + 8'h1; // @[axiSendBuffer.scala 197:26]
  reg  wlast_state; // @[axiSendBuffer.scala 202:28]
  wire  _GEN_74 = size_send_fifo_io_deq_valid; // @[axiSendBuffer.scala 207:40 208:37 211:37]
  reg  io_axi_m_wvalid_REG; // @[axiSendBuffer.scala 217:33]
  wire [7:0] _GEN_75 = size_send_fifo_io_deq_valid ? size_send_fifo_odata : send_len; // @[axiSendBuffer.scala 220:42 221:20 188:25]
  wire  _GEN_77 = io_axi_m_wlast & _GEN_74; // @[axiSendBuffer.scala 219:27 228:37]
  wire  _GEN_79 = wlast_state & io_axi_m_wvalid_REG; // @[axiSendBuffer.scala 192:19 205:22 217:23]
  wire  _GEN_80 = wlast_state & _GEN_77; // @[axiSendBuffer.scala 205:22 203:31]
  reg [3:0] strb; // @[axiSendBuffer.scala 236:21]
  reg [127:0] axi_data_t; // @[Reg.scala 35:20]
  wire [127:0] _dma_data_T_2 = {data_fifo_io_deq_bits[31:0],axi_data_t[127:32]}; // @[Cat.scala 33:92]
  wire [127:0] _dma_data_T_5 = {data_fifo_io_deq_bits[63:0],axi_data_t[127:64]}; // @[Cat.scala 33:92]
  wire [127:0] _dma_data_T_8 = {data_fifo_io_deq_bits[95:0],axi_data_t[127:96]}; // @[Cat.scala 33:92]
  wire [127:0] _GEN_88 = 4'hc == strb ? _dma_data_T_8 : data_fifo_io_deq_bits; // @[axiSendBuffer.scala 241:13 243:16 251:16]
  wire [127:0] _GEN_89 = 4'h8 == strb ? _dma_data_T_5 : _GEN_88; // @[axiSendBuffer.scala 243:16 248:16]
  wire [8:0] _io_axi_m_awlen_T_2 = send_size - 9'h1; // @[axiSendBuffer.scala 257:52]
  wire [8:0] _io_axi_m_awlen_T_3 = send_size > 9'h0 ? _io_axi_m_awlen_T_2 : 9'h0; // @[axiSendBuffer.scala 257:24]
  wire [32:0] _GEN_94 = reset ? 33'h0 : _size_fifo_bits_T_3; // @[axiSendBuffer.scala 42:{32,32} 61:19]
  wire [31:0] _GEN_95 = reset ? 32'h0 : _GEN_69; // @[axiSendBuffer.scala 99:{26,26}]
  fwft_fifo_8 data_fifo ( // @[axiSendBuffer.scala 28:25]
    .clock(data_fifo_clock),
    .reset(data_fifo_reset),
    .io_enq_ready(data_fifo_io_enq_ready),
    .io_enq_valid(data_fifo_io_enq_valid),
    .io_enq_bits(data_fifo_io_enq_bits),
    .io_deq_ready(data_fifo_io_deq_ready),
    .io_deq_valid(data_fifo_io_deq_valid),
    .io_deq_bits(data_fifo_io_deq_bits)
  );
  fwft_fifo_9 addr_fifo ( // @[axiSendBuffer.scala 29:25]
    .clock(addr_fifo_clock),
    .reset(addr_fifo_reset),
    .io_enq_ready(addr_fifo_io_enq_ready),
    .io_enq_valid(addr_fifo_io_enq_valid),
    .io_enq_bits(addr_fifo_io_enq_bits),
    .io_deq_ready(addr_fifo_io_deq_ready),
    .io_deq_valid(addr_fifo_io_deq_valid),
    .io_deq_bits(addr_fifo_io_deq_bits)
  );
  fwft_fifo_10 size_fifo ( // @[axiSendBuffer.scala 30:25]
    .clock(size_fifo_clock),
    .reset(size_fifo_reset),
    .io_enq_ready(size_fifo_io_enq_ready),
    .io_enq_valid(size_fifo_io_enq_valid),
    .io_enq_bits(size_fifo_io_enq_bits),
    .io_deq_ready(size_fifo_io_deq_ready),
    .io_deq_bits(size_fifo_io_deq_bits)
  );
  Queue size_send_fifo ( // @[axiSendBuffer.scala 103:30]
    .clock(size_send_fifo_clock),
    .reset(size_send_fifo_reset),
    .io_enq_ready(size_send_fifo_io_enq_ready),
    .io_enq_valid(size_send_fifo_io_enq_valid),
    .io_enq_bits(size_send_fifo_io_enq_bits),
    .io_deq_ready(size_send_fifo_io_deq_ready),
    .io_deq_valid(size_send_fifo_io_deq_valid),
    .io_deq_bits(size_send_fifo_io_deq_bits),
    .io_count(size_send_fifo_io_count)
  );
  assign io_axi_m_awaddr = send_addr; // @[axiSendBuffer.scala 256:19]
  assign io_axi_m_awlen = _io_axi_m_awlen_T_3[7:0]; // @[axiSendBuffer.scala 257:18]
  assign io_axi_m_awvalid = awvalid; // @[axiSendBuffer.scala 264:20]
  assign io_axi_m_wdata = 4'h4 == strb ? _dma_data_T_2 : _GEN_89; // @[axiSendBuffer.scala 243:16 245:16]
  assign io_axi_m_wlast = last_cnt == send_len & io_axi_m_wvalid & io_axi_m_wready; // @[axiSendBuffer.scala 269:62]
  assign io_axi_m_wvalid = ~wlast_state ? 1'h0 : _GEN_79; // @[axiSendBuffer.scala 192:19 205:22]
  assign data_fifo_clock = clock;
  assign data_fifo_reset = reset;
  assign data_fifo_io_enq_valid = data_fifo_valid; // @[axiSendBuffer.scala 64:26]
  assign data_fifo_io_enq_bits = data_fifo_bits; // @[axiSendBuffer.scala 63:26]
  assign data_fifo_io_deq_ready = io_axi_m_wvalid & io_axi_m_wready; // @[axiSendBuffer.scala 270:45]
  assign addr_fifo_clock = clock;
  assign addr_fifo_reset = reset;
  assign addr_fifo_io_enq_valid = addr_fifo_valid; // @[axiSendBuffer.scala 66:26]
  assign addr_fifo_io_enq_bits = addr_fifo_bits; // @[axiSendBuffer.scala 65:26]
  assign addr_fifo_io_deq_ready = 2'h0 == state ? _T_12 : _GEN_54; // @[axiSendBuffer.scala 112:16]
  assign size_fifo_clock = clock;
  assign size_fifo_reset = reset;
  assign size_fifo_io_enq_valid = size_fifo_valid; // @[axiSendBuffer.scala 68:26]
  assign size_fifo_io_enq_bits = size_fifo_bits; // @[axiSendBuffer.scala 67:26]
  assign size_fifo_io_deq_ready = 2'h0 == state ? _T_12 : _GEN_54; // @[axiSendBuffer.scala 112:16]
  assign size_send_fifo_clock = clock;
  assign size_send_fifo_reset = reset;
  assign size_send_fifo_io_enq_valid = 2'h0 == state ? 1'h0 : 2'h1 == state & _GEN_28; // @[axiSendBuffer.scala 112:16 106:31]
  assign size_send_fifo_io_enq_bits = _GEN_70[7:0];
  assign size_send_fifo_io_deq_ready = ~wlast_state ? _GEN_74 : _GEN_80; // @[axiSendBuffer.scala 205:22]
  always @(posedge clock) begin
    if (reset) begin // @[axiSendBuffer.scala 40:32]
      data_fifo_bits <= 128'h0; // @[axiSendBuffer.scala 40:32]
    end else begin
      data_fifo_bits <= io_opfusion_send_data; // @[axiSendBuffer.scala 59:19]
    end
    if (reset) begin // @[axiSendBuffer.scala 41:32]
      addr_fifo_bits <= 64'h0; // @[axiSendBuffer.scala 41:32]
    end else if (addr_align_flag) begin // @[axiSendBuffer.scala 60:25]
      addr_fifo_bits <= io_opfusion_send_addr;
    end else begin
      addr_fifo_bits <= _addr_fifo_bits_T_1;
    end
    size_fifo_bits <= _GEN_94[31:0]; // @[axiSendBuffer.scala 42:{32,32} 61:19]
    areq_pr <= io_opfusion_send_addr_valid; // @[axiSendBuffer.scala 47:24]
    if (reset) begin // @[axiSendBuffer.scala 51:32]
      data_fifo_valid <= 1'h0; // @[axiSendBuffer.scala 51:32]
    end else begin
      data_fifo_valid <= io_opfusion_send_data_valid & data_fifo_io_enq_ready; // @[axiSendBuffer.scala 55:19]
    end
    if (reset) begin // @[axiSendBuffer.scala 52:32]
      addr_fifo_valid <= 1'h0; // @[axiSendBuffer.scala 52:32]
    end else begin
      addr_fifo_valid <= areq2 & addr_fifo_io_enq_ready; // @[axiSendBuffer.scala 56:19]
    end
    if (reset) begin // @[axiSendBuffer.scala 53:32]
      size_fifo_valid <= 1'h0; // @[axiSendBuffer.scala 53:32]
    end else begin
      size_fifo_valid <= areq2 & size_fifo_io_enq_ready; // @[axiSendBuffer.scala 57:19]
    end
    if (reset) begin // @[axiSendBuffer.scala 70:32]
      outstanding_cnt <= 5'h0; // @[axiSendBuffer.scala 70:32]
    end else if (!(2'h0 == _T_3)) begin // @[axiSendBuffer.scala 71:100]
      if (2'h1 == _T_3) begin // @[axiSendBuffer.scala 71:100]
        outstanding_cnt <= _outstanding_cnt_T_1; // @[axiSendBuffer.scala 76:23]
      end else if (2'h2 == _T_3) begin // @[axiSendBuffer.scala 71:100]
        outstanding_cnt <= _outstanding_cnt_T_3; // @[axiSendBuffer.scala 79:23]
      end
    end
    if (reset) begin // @[axiSendBuffer.scala 88:22]
      state <= 2'h0; // @[axiSendBuffer.scala 88:22]
    end else if (2'h0 == state) begin // @[axiSendBuffer.scala 112:16]
      if (addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf) begin // @[axiSendBuffer.scala 114:109]
        state <= 2'h1; // @[axiSendBuffer.scala 119:15]
      end else begin
        state <= 2'h0; // @[axiSendBuffer.scala 122:15]
      end
    end else if (2'h1 == state) begin // @[axiSendBuffer.scala 112:16]
      if (size_send_fifo_io_enq_ready) begin // @[axiSendBuffer.scala 128:40]
        state <= 2'h2; // @[axiSendBuffer.scala 159:15]
      end else begin
        state <= 2'h1; // @[axiSendBuffer.scala 162:15]
      end
    end else if (2'h2 == state) begin // @[axiSendBuffer.scala 112:16]
      state <= _GEN_48;
    end
    if (reset) begin // @[axiSendBuffer.scala 89:31]
      fifo_size_left <= 32'h0; // @[axiSendBuffer.scala 89:31]
    end else if (2'h0 == state) begin // @[axiSendBuffer.scala 112:16]
      if (addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf) begin // @[axiSendBuffer.scala 114:109]
        fifo_size_left <= size_fifo_io_deq_bits; // @[axiSendBuffer.scala 117:24]
      end else begin
        fifo_size_left <= 32'h0; // @[axiSendBuffer.scala 121:24]
      end
    end else if (2'h1 == state) begin // @[axiSendBuffer.scala 112:16]
      if (size_send_fifo_io_enq_ready) begin // @[axiSendBuffer.scala 128:40]
        fifo_size_left <= _GEN_25;
      end
    end else if (2'h2 == state) begin // @[axiSendBuffer.scala 112:16]
      fifo_size_left <= _GEN_46;
    end
    if (reset) begin // @[axiSendBuffer.scala 90:31]
      fifo_addr_left <= 64'h0; // @[axiSendBuffer.scala 90:31]
    end else if (2'h0 == state) begin // @[axiSendBuffer.scala 112:16]
      if (addr_fifo_io_deq_valid & fifo_size_left == 32'h0 & outstanding_cnt < 5'hf) begin // @[axiSendBuffer.scala 114:109]
        fifo_addr_left <= addr_fifo_io_deq_bits; // @[axiSendBuffer.scala 118:24]
      end
    end else if (2'h1 == state) begin // @[axiSendBuffer.scala 112:16]
      if (size_send_fifo_io_enq_ready) begin // @[axiSendBuffer.scala 128:40]
        fifo_addr_left <= _GEN_27;
      end
    end else if (2'h2 == state) begin // @[axiSendBuffer.scala 112:16]
      fifo_addr_left <= _GEN_47;
    end
    if (reset) begin // @[axiSendBuffer.scala 98:26]
      send_addr <= 64'h0; // @[axiSendBuffer.scala 98:26]
    end else if (!(2'h0 == state)) begin // @[axiSendBuffer.scala 112:16]
      if (2'h1 == state) begin // @[axiSendBuffer.scala 112:16]
        if (size_send_fifo_io_enq_ready) begin // @[axiSendBuffer.scala 128:40]
          send_addr <= _GEN_23;
        end
      end
    end
    send_size <= _GEN_95[8:0]; // @[axiSendBuffer.scala 99:{26,26}]
    if (reset) begin // @[axiSendBuffer.scala 110:24]
      awvalid <= 1'h0; // @[axiSendBuffer.scala 110:24]
    end else if (!(2'h0 == state)) begin // @[axiSendBuffer.scala 112:16]
      if (2'h1 == state) begin // @[axiSendBuffer.scala 112:16]
        awvalid <= _GEN_35;
      end else if (2'h2 == state) begin // @[axiSendBuffer.scala 112:16]
        awvalid <= _GEN_44;
      end
    end
    if (reset) begin // @[axiSendBuffer.scala 187:25]
      last_cnt <= 8'h0; // @[axiSendBuffer.scala 187:25]
    end else if (io_axi_m_wlast) begin // @[axiSendBuffer.scala 194:23]
      last_cnt <= 8'h0; // @[axiSendBuffer.scala 195:14]
    end else if (io_axi_m_wvalid & io_axi_m_wready) begin // @[axiSendBuffer.scala 196:49]
      last_cnt <= _last_cnt_T_1; // @[axiSendBuffer.scala 197:14]
    end
    if (reset) begin // @[axiSendBuffer.scala 188:25]
      send_len <= 8'h0; // @[axiSendBuffer.scala 188:25]
    end else if (~wlast_state) begin // @[axiSendBuffer.scala 205:22]
      if (size_send_fifo_io_count == 5'h0) begin // @[axiSendBuffer.scala 108:33]
        send_len <= 8'h0;
      end else begin
        send_len <= size_send_fifo_io_deq_bits;
      end
    end else if (wlast_state) begin // @[axiSendBuffer.scala 205:22]
      if (io_axi_m_wlast) begin // @[axiSendBuffer.scala 219:27]
        send_len <= _GEN_75;
      end
    end
    if (reset) begin // @[axiSendBuffer.scala 202:28]
      wlast_state <= 1'h0; // @[axiSendBuffer.scala 202:28]
    end else if (~wlast_state) begin // @[axiSendBuffer.scala 205:22]
      wlast_state <= _GEN_74;
    end else if (wlast_state) begin // @[axiSendBuffer.scala 205:22]
      if (io_axi_m_wlast) begin // @[axiSendBuffer.scala 219:27]
        wlast_state <= _GEN_74;
      end else begin
        wlast_state <= 1'h1; // @[axiSendBuffer.scala 229:21]
      end
    end
    io_axi_m_wvalid_REG <= data_fifo_io_deq_valid; // @[axiSendBuffer.scala 217:33]
    if (reset) begin // @[axiSendBuffer.scala 236:21]
      strb <= 4'h0; // @[axiSendBuffer.scala 236:21]
    end else begin
      strb <= io_opfusion_send_addr[3:0]; // @[axiSendBuffer.scala 237:8]
    end
    if (reset) begin // @[Reg.scala 35:20]
      axi_data_t <= 128'h0; // @[Reg.scala 35:20]
    end else if (_T_24) begin // @[Reg.scala 36:18]
      axi_data_t <= data_fifo_io_deq_bits; // @[Reg.scala 36:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {4{`RANDOM}};
  data_fifo_bits = _RAND_0[127:0];
  _RAND_1 = {2{`RANDOM}};
  addr_fifo_bits = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  size_fifo_bits = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  areq_pr = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  data_fifo_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  addr_fifo_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  size_fifo_valid = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  outstanding_cnt = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  state = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  fifo_size_left = _RAND_9[31:0];
  _RAND_10 = {2{`RANDOM}};
  fifo_addr_left = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  send_addr = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  send_size = _RAND_12[8:0];
  _RAND_13 = {1{`RANDOM}};
  awvalid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  last_cnt = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  send_len = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  wlast_state = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_axi_m_wvalid_REG = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  strb = _RAND_18[3:0];
  _RAND_19 = {4{`RANDOM}};
  axi_data_t = _RAND_19[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axiSendBuffer(
  input          clock,
  input          reset,
  input  [127:0] io_opfusion_send_ch0_data,
  input  [31:0]  io_opfusion_send_ch0_size,
  input  [63:0]  io_opfusion_send_ch0_addr,
  input          io_opfusion_send_ch0_data_valid,
  input          io_opfusion_send_ch0_addr_valid,
  input  [127:0] io_opfusion_send_ch1_data,
  input  [31:0]  io_opfusion_send_ch1_size,
  input  [63:0]  io_opfusion_send_ch1_addr,
  input          io_opfusion_send_ch1_data_valid,
  input          io_opfusion_send_ch1_addr_valid,
  output [63:0]  io_axi_ch0_m_awaddr,
  output [7:0]   io_axi_ch0_m_awlen,
  output         io_axi_ch0_m_awvalid,
  input          io_axi_ch0_m_awready,
  output [127:0] io_axi_ch0_m_wdata,
  output         io_axi_ch0_m_wlast,
  output         io_axi_ch0_m_wvalid,
  input          io_axi_ch0_m_wready,
  output [63:0]  io_axi_ch1_m_awaddr,
  output [7:0]   io_axi_ch1_m_awlen,
  output         io_axi_ch1_m_awvalid,
  input          io_axi_ch1_m_awready,
  output [127:0] io_axi_ch1_m_wdata,
  output         io_axi_ch1_m_wlast,
  output         io_axi_ch1_m_wvalid,
  input          io_axi_ch1_m_wready
);
  wire  axi_send_cell0_clock; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_reset; // @[axiSendBuffer.scala 289:30]
  wire [127:0] axi_send_cell0_io_opfusion_send_data; // @[axiSendBuffer.scala 289:30]
  wire [31:0] axi_send_cell0_io_opfusion_send_size; // @[axiSendBuffer.scala 289:30]
  wire [63:0] axi_send_cell0_io_opfusion_send_addr; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_opfusion_send_data_valid; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_opfusion_send_addr_valid; // @[axiSendBuffer.scala 289:30]
  wire [63:0] axi_send_cell0_io_axi_m_awaddr; // @[axiSendBuffer.scala 289:30]
  wire [7:0] axi_send_cell0_io_axi_m_awlen; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_axi_m_awvalid; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_axi_m_awready; // @[axiSendBuffer.scala 289:30]
  wire [127:0] axi_send_cell0_io_axi_m_wdata; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_axi_m_wlast; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_axi_m_wvalid; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell0_io_axi_m_wready; // @[axiSendBuffer.scala 289:30]
  wire  axi_send_cell1_clock; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_reset; // @[axiSendBuffer.scala 290:30]
  wire [127:0] axi_send_cell1_io_opfusion_send_data; // @[axiSendBuffer.scala 290:30]
  wire [31:0] axi_send_cell1_io_opfusion_send_size; // @[axiSendBuffer.scala 290:30]
  wire [63:0] axi_send_cell1_io_opfusion_send_addr; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_opfusion_send_data_valid; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_opfusion_send_addr_valid; // @[axiSendBuffer.scala 290:30]
  wire [63:0] axi_send_cell1_io_axi_m_awaddr; // @[axiSendBuffer.scala 290:30]
  wire [7:0] axi_send_cell1_io_axi_m_awlen; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_axi_m_awvalid; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_axi_m_awready; // @[axiSendBuffer.scala 290:30]
  wire [127:0] axi_send_cell1_io_axi_m_wdata; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_axi_m_wlast; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_axi_m_wvalid; // @[axiSendBuffer.scala 290:30]
  wire  axi_send_cell1_io_axi_m_wready; // @[axiSendBuffer.scala 290:30]
  axiSendBufferCell axi_send_cell0 ( // @[axiSendBuffer.scala 289:30]
    .clock(axi_send_cell0_clock),
    .reset(axi_send_cell0_reset),
    .io_opfusion_send_data(axi_send_cell0_io_opfusion_send_data),
    .io_opfusion_send_size(axi_send_cell0_io_opfusion_send_size),
    .io_opfusion_send_addr(axi_send_cell0_io_opfusion_send_addr),
    .io_opfusion_send_data_valid(axi_send_cell0_io_opfusion_send_data_valid),
    .io_opfusion_send_addr_valid(axi_send_cell0_io_opfusion_send_addr_valid),
    .io_axi_m_awaddr(axi_send_cell0_io_axi_m_awaddr),
    .io_axi_m_awlen(axi_send_cell0_io_axi_m_awlen),
    .io_axi_m_awvalid(axi_send_cell0_io_axi_m_awvalid),
    .io_axi_m_awready(axi_send_cell0_io_axi_m_awready),
    .io_axi_m_wdata(axi_send_cell0_io_axi_m_wdata),
    .io_axi_m_wlast(axi_send_cell0_io_axi_m_wlast),
    .io_axi_m_wvalid(axi_send_cell0_io_axi_m_wvalid),
    .io_axi_m_wready(axi_send_cell0_io_axi_m_wready)
  );
  axiSendBufferCell axi_send_cell1 ( // @[axiSendBuffer.scala 290:30]
    .clock(axi_send_cell1_clock),
    .reset(axi_send_cell1_reset),
    .io_opfusion_send_data(axi_send_cell1_io_opfusion_send_data),
    .io_opfusion_send_size(axi_send_cell1_io_opfusion_send_size),
    .io_opfusion_send_addr(axi_send_cell1_io_opfusion_send_addr),
    .io_opfusion_send_data_valid(axi_send_cell1_io_opfusion_send_data_valid),
    .io_opfusion_send_addr_valid(axi_send_cell1_io_opfusion_send_addr_valid),
    .io_axi_m_awaddr(axi_send_cell1_io_axi_m_awaddr),
    .io_axi_m_awlen(axi_send_cell1_io_axi_m_awlen),
    .io_axi_m_awvalid(axi_send_cell1_io_axi_m_awvalid),
    .io_axi_m_awready(axi_send_cell1_io_axi_m_awready),
    .io_axi_m_wdata(axi_send_cell1_io_axi_m_wdata),
    .io_axi_m_wlast(axi_send_cell1_io_axi_m_wlast),
    .io_axi_m_wvalid(axi_send_cell1_io_axi_m_wvalid),
    .io_axi_m_wready(axi_send_cell1_io_axi_m_wready)
  );
  assign io_axi_ch0_m_awaddr = axi_send_cell0_io_axi_m_awaddr; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch0_m_awlen = axi_send_cell0_io_axi_m_awlen; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch0_m_awvalid = axi_send_cell0_io_axi_m_awvalid; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch0_m_wdata = axi_send_cell0_io_axi_m_wdata; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch0_m_wlast = axi_send_cell0_io_axi_m_wlast; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch0_m_wvalid = axi_send_cell0_io_axi_m_wvalid; // @[axiSendBuffer.scala 292:35]
  assign io_axi_ch1_m_awaddr = axi_send_cell1_io_axi_m_awaddr; // @[axiSendBuffer.scala 296:35]
  assign io_axi_ch1_m_awlen = axi_send_cell1_io_axi_m_awlen; // @[axiSendBuffer.scala 296:35]
  assign io_axi_ch1_m_awvalid = axi_send_cell1_io_axi_m_awvalid; // @[axiSendBuffer.scala 296:35]
  assign io_axi_ch1_m_wdata = axi_send_cell1_io_axi_m_wdata; // @[axiSendBuffer.scala 296:35]
  assign io_axi_ch1_m_wlast = axi_send_cell1_io_axi_m_wlast; // @[axiSendBuffer.scala 296:35]
  assign io_axi_ch1_m_wvalid = axi_send_cell1_io_axi_m_wvalid; // @[axiSendBuffer.scala 296:35]
  assign axi_send_cell0_clock = clock;
  assign axi_send_cell0_reset = reset;
  assign axi_send_cell0_io_opfusion_send_data = io_opfusion_send_ch0_data; // @[axiSendBuffer.scala 293:35]
  assign axi_send_cell0_io_opfusion_send_size = io_opfusion_send_ch0_size; // @[axiSendBuffer.scala 293:35]
  assign axi_send_cell0_io_opfusion_send_addr = io_opfusion_send_ch0_addr; // @[axiSendBuffer.scala 293:35]
  assign axi_send_cell0_io_opfusion_send_data_valid = io_opfusion_send_ch0_data_valid; // @[axiSendBuffer.scala 293:35]
  assign axi_send_cell0_io_opfusion_send_addr_valid = io_opfusion_send_ch0_addr_valid; // @[axiSendBuffer.scala 293:35]
  assign axi_send_cell0_io_axi_m_awready = io_axi_ch0_m_awready; // @[axiSendBuffer.scala 292:35]
  assign axi_send_cell0_io_axi_m_wready = io_axi_ch0_m_wready; // @[axiSendBuffer.scala 292:35]
  assign axi_send_cell1_clock = clock;
  assign axi_send_cell1_reset = reset;
  assign axi_send_cell1_io_opfusion_send_data = io_opfusion_send_ch1_data; // @[axiSendBuffer.scala 297:35]
  assign axi_send_cell1_io_opfusion_send_size = io_opfusion_send_ch1_size; // @[axiSendBuffer.scala 297:35]
  assign axi_send_cell1_io_opfusion_send_addr = io_opfusion_send_ch1_addr; // @[axiSendBuffer.scala 297:35]
  assign axi_send_cell1_io_opfusion_send_data_valid = io_opfusion_send_ch1_data_valid; // @[axiSendBuffer.scala 297:35]
  assign axi_send_cell1_io_opfusion_send_addr_valid = io_opfusion_send_ch1_addr_valid; // @[axiSendBuffer.scala 297:35]
  assign axi_send_cell1_io_axi_m_awready = io_axi_ch1_m_awready; // @[axiSendBuffer.scala 296:35]
  assign axi_send_cell1_io_axi_m_wready = io_axi_ch1_m_wready; // @[axiSendBuffer.scala 296:35]
endmodule
module standard_fifo_14(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [127:0] io_enq_bits,
  input          io_deq_ready,
  output         io_deq_valid,
  output [127:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [127:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_WEN; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_A; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_D; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_Q; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CLK; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_CEN; // @[SPRAM.scala 20:69]
  wire  SPRAM_1_WEN; // @[SPRAM.scala 20:69]
  wire [3:0] SPRAM_1_A; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_1_D; // @[SPRAM.scala 20:69]
  wire [127:0] SPRAM_1_Q; // @[SPRAM.scala 20:69]
  reg [4:0] waddr; // @[utils.scala 523:22]
  reg [4:0] raddr; // @[utils.scala 524:22]
  wire  ram_ren = io_deq_ready & io_deq_valid; // @[utils.scala 527:30]
  wire  ram_wen = io_enq_valid & io_enq_ready; // @[utils.scala 528:30]
  wire [4:0] _waddr_T_1 = waddr + 5'h1; // @[utils.scala 530:31]
  wire [4:0] _raddr_T_1 = raddr + 5'h1; // @[utils.scala 531:31]
  reg [5:0] count; // @[utils.scala 534:22]
  wire [5:0] _count_T_1 = count - 6'h1; // @[utils.scala 538:20]
  wire [5:0] _count_T_3 = count + 6'h1; // @[utils.scala 540:20]
  reg [127:0] reg_write_data; // @[utils.scala 546:31]
  reg  reg_write_en; // @[utils.scala 547:29]
  reg [4:0] reg_write_addr; // @[utils.scala 548:31]
  wire  _GEN_4 = ram_ren & ram_wen & raddr[0] == waddr[0] ? 1'h0 : 1'h1; // @[utils.scala 550:54 552:18 555:18]
  wire  odd_deq = ~(ram_ren & raddr[0]); // @[utils.scala 558:17]
  wire  odd_enq = ~(ram_wen & waddr[0]); // @[utils.scala 559:17]
  wire  _T_8 = ~odd_deq; // @[utils.scala 563:18]
  wire [4:0] _T_14 = odd_enq ? reg_write_addr : {{1'd0}, waddr[4:1]}; // @[utils.scala 564:62]
  wire [4:0] _T_15 = _T_8 ? {{1'd0}, raddr[4:1]} : _T_14; // @[utils.scala 564:19]
  wire  even_deq = ~ram_ren | raddr[0]; // @[utils.scala 567:27]
  wire  even_enq = ~ram_wen | waddr[0]; // @[utils.scala 568:27]
  wire  _T_19 = ~even_deq; // @[utils.scala 572:19]
  wire [4:0] _T_25 = even_enq ? reg_write_addr : {{1'd0}, waddr[4:1]}; // @[utils.scala 573:64]
  wire [4:0] _T_26 = _T_19 ? {{1'd0}, raddr[4:1]} : _T_25; // @[utils.scala 573:20]
  SPRAM #(.DATA_WIDTH(128), .DEPTH(16), .RAM_STYLE_VAL("block")) SPRAM ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .A(SPRAM_A),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(16), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[SPRAM.scala 20:69]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .A(SPRAM_1_A),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  assign io_enq_ready = count != 6'h20; // @[utils.scala 576:26]
  assign io_deq_valid = count != 6'h0; // @[utils.scala 577:26]
  assign io_deq_bits = ~raddr[0] ? SPRAM_Q : SPRAM_1_Q; // @[utils.scala 578:22]
  assign SPRAM_CLK = clock; // @[utils.scala 561:15]
  assign SPRAM_CEN = odd_deq & odd_enq & reg_write_en; // @[utils.scala 562:37]
  assign SPRAM_WEN = ~odd_deq | odd_enq & reg_write_en; // @[utils.scala 563:27]
  assign SPRAM_A = _T_15[3:0]; // @[utils.scala 564:13]
  assign SPRAM_D = odd_enq ? reg_write_data : io_enq_bits; // @[utils.scala 565:19]
  assign SPRAM_1_CLK = clock; // @[utils.scala 570:16]
  assign SPRAM_1_CEN = even_deq & even_enq & reg_write_en; // @[utils.scala 571:40]
  assign SPRAM_1_WEN = ~even_deq | even_enq & reg_write_en; // @[utils.scala 572:29]
  assign SPRAM_1_A = _T_26[3:0]; // @[utils.scala 573:14]
  assign SPRAM_1_D = even_enq ? reg_write_data : io_enq_bits; // @[utils.scala 574:20]
  always @(posedge clock) begin
    if (reset) begin // @[utils.scala 523:22]
      waddr <= 5'h0; // @[utils.scala 523:22]
    end else if (ram_wen) begin // @[utils.scala 530:15]
      waddr <= _waddr_T_1;
    end
    if (reset) begin // @[utils.scala 524:22]
      raddr <= 5'h0; // @[utils.scala 524:22]
    end else if (ram_ren) begin // @[utils.scala 531:15]
      raddr <= _raddr_T_1;
    end
    if (reset) begin // @[utils.scala 534:22]
      count <= 6'h0; // @[utils.scala 534:22]
    end else if (!(ram_wen & ram_ren)) begin // @[utils.scala 535:27]
      if (ram_ren) begin // @[utils.scala 537:23]
        count <= _count_T_1; // @[utils.scala 538:11]
      end else if (ram_wen) begin // @[utils.scala 539:23]
        count <= _count_T_3; // @[utils.scala 540:11]
      end
    end
    if (reset) begin // @[utils.scala 546:31]
      reg_write_data <= 128'h0; // @[utils.scala 546:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_data <= io_enq_bits; // @[utils.scala 551:20]
    end
    reg_write_en <= reset | _GEN_4; // @[utils.scala 547:{29,29}]
    if (reset) begin // @[utils.scala 548:31]
      reg_write_addr <= 5'h0; // @[utils.scala 548:31]
    end else if (ram_ren & ram_wen & raddr[0] == waddr[0]) begin // @[utils.scala 550:54]
      reg_write_addr <= {{1'd0}, waddr[4:1]}; // @[utils.scala 553:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  raddr = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[5:0];
  _RAND_3 = {4{`RANDOM}};
  reg_write_data = _RAND_3[127:0];
  _RAND_4 = {1{`RANDOM}};
  reg_write_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_write_addr = _RAND_5[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module standard_fifo_two_channel(
  input          clock,
  input          reset,
  input          io_enq_0_valid,
  input  [127:0] io_enq_0_data,
  input          io_enq_1_valid,
  input  [127:0] io_enq_1_data,
  output         io_deq_0_valid,
  output [127:0] io_deq_0_data,
  output         io_deq_1_valid,
  output [127:0] io_deq_1_data
);
  wire  fifo0_clock; // @[utils.scala 668:21]
  wire  fifo0_reset; // @[utils.scala 668:21]
  wire  fifo0_io_enq_ready; // @[utils.scala 668:21]
  wire  fifo0_io_enq_valid; // @[utils.scala 668:21]
  wire [127:0] fifo0_io_enq_bits; // @[utils.scala 668:21]
  wire  fifo0_io_deq_ready; // @[utils.scala 668:21]
  wire  fifo0_io_deq_valid; // @[utils.scala 668:21]
  wire [127:0] fifo0_io_deq_bits; // @[utils.scala 668:21]
  wire  fifo1_clock; // @[utils.scala 669:49]
  wire  fifo1_reset; // @[utils.scala 669:49]
  wire  fifo1_io_enq_ready; // @[utils.scala 669:49]
  wire  fifo1_io_enq_valid; // @[utils.scala 669:49]
  wire [127:0] fifo1_io_enq_bits; // @[utils.scala 669:49]
  wire  fifo1_io_deq_ready; // @[utils.scala 669:49]
  wire  fifo1_io_deq_valid; // @[utils.scala 669:49]
  wire [127:0] fifo1_io_deq_bits; // @[utils.scala 669:49]
  standard_fifo_14 fifo0 ( // @[utils.scala 668:21]
    .clock(fifo0_clock),
    .reset(fifo0_reset),
    .io_enq_ready(fifo0_io_enq_ready),
    .io_enq_valid(fifo0_io_enq_valid),
    .io_enq_bits(fifo0_io_enq_bits),
    .io_deq_ready(fifo0_io_deq_ready),
    .io_deq_valid(fifo0_io_deq_valid),
    .io_deq_bits(fifo0_io_deq_bits)
  );
  standard_fifo_14 fifo1 ( // @[utils.scala 669:49]
    .clock(fifo1_clock),
    .reset(fifo1_reset),
    .io_enq_ready(fifo1_io_enq_ready),
    .io_enq_valid(fifo1_io_enq_valid),
    .io_enq_bits(fifo1_io_enq_bits),
    .io_deq_ready(fifo1_io_deq_ready),
    .io_deq_valid(fifo1_io_deq_valid),
    .io_deq_bits(fifo1_io_deq_bits)
  );
  assign io_deq_0_valid = fifo0_io_deq_valid & fifo1_io_deq_valid; // @[utils.scala 684:43]
  assign io_deq_0_data = fifo0_io_deq_bits; // @[utils.scala 675:18]
  assign io_deq_1_valid = fifo0_io_deq_valid & fifo1_io_deq_valid; // @[utils.scala 685:43]
  assign io_deq_1_data = fifo1_io_deq_bits; // @[utils.scala 682:20]
  assign fifo0_clock = clock;
  assign fifo0_reset = reset;
  assign fifo0_io_enq_valid = io_enq_0_valid; // @[utils.scala 674:22]
  assign fifo0_io_enq_bits = io_enq_0_data; // @[utils.scala 673:21]
  assign fifo0_io_deq_ready = io_deq_0_valid; // @[utils.scala 676:22]
  assign fifo1_clock = clock;
  assign fifo1_reset = reset;
  assign fifo1_io_enq_valid = io_enq_1_valid; // @[utils.scala 681:28]
  assign fifo1_io_enq_bits = io_enq_1_data; // @[utils.scala 680:27]
  assign fifo1_io_deq_ready = io_deq_1_valid; // @[utils.scala 683:28]
endmodule
module ifm_buffer(
  input          clock,
  input          reset,
  input          io_input_data_valid,
  input          io_dma_to_buffer_0_valid,
  input  [127:0] io_dma_to_buffer_0_data,
  input          io_dma_to_buffer_1_valid,
  input  [127:0] io_dma_to_buffer_1_data,
  input          io_din_valid_ConV,
  input          io_dout_valid_ConV,
  output [127:0] io_buffer_to_input_0,
  output [127:0] io_buffer_to_input_1,
  output         io_ifm_buffer_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_1_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_1_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_1_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_1_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_1_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_2_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_2_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_2_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_2_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_2_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_3_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_3_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_3_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_3_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_3_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_4_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_4_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_4_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_4_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_4_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_5_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_5_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_5_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_5_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_5_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_6_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_6_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_6_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_6_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_6_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_7_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_7_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_7_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_7_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_7_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_8_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_8_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_8_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_8_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_8_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_9_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_9_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_9_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_9_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_9_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_10_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_10_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_10_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_10_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_10_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_11_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_11_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_11_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_11_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_11_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_12_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_12_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_12_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_12_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_12_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_13_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_13_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_13_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_13_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_13_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_14_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_14_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_14_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_14_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_14_Q; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_15_CLK; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_15_CEN; // @[ifm_buffer.scala 53:119]
  wire  SPRAM_15_WEN; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_15_D; // @[ifm_buffer.scala 53:119]
  wire [127:0] SPRAM_15_Q; // @[ifm_buffer.scala 53:119]
  reg  dma_to_buffer_0; // @[ifm_buffer.scala 16:30]
  reg  dma_to_buffer_1; // @[ifm_buffer.scala 16:30]
  reg [3:0] counter_ch_0; // @[ifm_buffer.scala 18:27]
  reg [3:0] counter_ch_1; // @[ifm_buffer.scala 18:27]
  reg  input_state_ready; // @[ifm_buffer.scala 19:70]
  wire [3:0] _counter_ch_0_T_4 = counter_ch_0 + 4'h1; // @[ifm_buffer.scala 23:126]
  wire [3:0] _counter_ch_0_T_5 = dma_to_buffer_0 & counter_ch_0 < 4'h8 & io_input_data_valid ? _counter_ch_0_T_4 :
    counter_ch_0; // @[ifm_buffer.scala 23:27]
  wire [3:0] _counter_ch_1_T_4 = counter_ch_1 + 4'h1; // @[ifm_buffer.scala 23:126]
  wire [3:0] _counter_ch_1_T_5 = dma_to_buffer_1 & counter_ch_1 < 4'h8 & io_input_data_valid ? _counter_ch_1_T_4 :
    counter_ch_1; // @[ifm_buffer.scala 23:27]
  wire  _GEN_0 = io_dout_valid_ConV ? io_dout_valid_ConV : input_state_ready; // @[ifm_buffer.scala 26:28 27:23 19:70]
  reg [3:0] counter_out; // @[ifm_buffer.scala 30:28]
  reg [3:0] counter_out_fix; // @[ifm_buffer.scala 31:32]
  reg  self_buffer_to_input_valid; // @[ifm_buffer.scala 32:43]
  wire [3:0] _counter_out_T_1 = counter_out + 4'h1; // @[ifm_buffer.scala 39:34]
  wire  _GEN_4 = counter_out != 4'h8 & _GEN_0; // @[ifm_buffer.scala 38:40 43:25]
  wire  _GEN_8 = self_buffer_to_input_valid & input_state_ready & io_din_valid_ConV ? _GEN_4 : _GEN_0; // @[ifm_buffer.scala 37:78]
  wire [2:0] counter_out_cnt = counter_out_fix[2:0]; // @[ifm_buffer.scala 68:37]
  wire [3:0] _io_buffer_to_input_0_T = counter_out_cnt * 1'h1; // @[ifm_buffer.scala 71:158]
  wire [4:0] _io_buffer_to_input_0_T_1 = {{1'd0}, _io_buffer_to_input_0_T}; // @[ifm_buffer.scala 71:140]
  wire [127:0] spram_wrap_0_0_Q = SPRAM_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] spram_wrap_0_1_Q = SPRAM_1_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_10 = 3'h1 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_1_Q : spram_wrap_0_0_Q; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_2_Q = SPRAM_2_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_11 = 3'h2 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_2_Q : _GEN_10; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_3_Q = SPRAM_3_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_12 = 3'h3 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_3_Q : _GEN_11; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_4_Q = SPRAM_4_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_13 = 3'h4 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_4_Q : _GEN_12; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_5_Q = SPRAM_5_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_14 = 3'h5 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_5_Q : _GEN_13; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_6_Q = SPRAM_6_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_15 = 3'h6 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_6_Q : _GEN_14; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_0_7_Q = SPRAM_7_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] spram_wrap_1_0_Q = SPRAM_8_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] spram_wrap_1_1_Q = SPRAM_9_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_18 = 3'h1 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_1_Q : spram_wrap_1_0_Q; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_2_Q = SPRAM_10_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_19 = 3'h2 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_2_Q : _GEN_18; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_3_Q = SPRAM_11_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_20 = 3'h3 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_3_Q : _GEN_19; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_4_Q = SPRAM_12_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_21 = 3'h4 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_4_Q : _GEN_20; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_5_Q = SPRAM_13_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_22 = 3'h5 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_5_Q : _GEN_21; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_6_Q = SPRAM_14_Q; // @[ifm_buffer.scala 53:{51,51}]
  wire [127:0] _GEN_23 = 3'h6 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_6_Q : _GEN_22; // @[ifm_buffer.scala 71:{29,29}]
  wire [127:0] spram_wrap_1_7_Q = SPRAM_15_Q; // @[ifm_buffer.scala 53:{51,51}]
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_2 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_2_CLK),
    .CEN(SPRAM_2_CEN),
    .WEN(SPRAM_2_WEN),
    .D(SPRAM_2_D),
    .Q(SPRAM_2_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_3 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_3_CLK),
    .CEN(SPRAM_3_CEN),
    .WEN(SPRAM_3_WEN),
    .D(SPRAM_3_D),
    .Q(SPRAM_3_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_4 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_4_CLK),
    .CEN(SPRAM_4_CEN),
    .WEN(SPRAM_4_WEN),
    .D(SPRAM_4_D),
    .Q(SPRAM_4_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_5 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_5_CLK),
    .CEN(SPRAM_5_CEN),
    .WEN(SPRAM_5_WEN),
    .D(SPRAM_5_D),
    .Q(SPRAM_5_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_6 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_6_CLK),
    .CEN(SPRAM_6_CEN),
    .WEN(SPRAM_6_WEN),
    .D(SPRAM_6_D),
    .Q(SPRAM_6_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_7 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_7_CLK),
    .CEN(SPRAM_7_CEN),
    .WEN(SPRAM_7_WEN),
    .D(SPRAM_7_D),
    .Q(SPRAM_7_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_8 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_8_CLK),
    .CEN(SPRAM_8_CEN),
    .WEN(SPRAM_8_WEN),
    .D(SPRAM_8_D),
    .Q(SPRAM_8_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_9 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_9_CLK),
    .CEN(SPRAM_9_CEN),
    .WEN(SPRAM_9_WEN),
    .D(SPRAM_9_D),
    .Q(SPRAM_9_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_10 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_10_CLK),
    .CEN(SPRAM_10_CEN),
    .WEN(SPRAM_10_WEN),
    .D(SPRAM_10_D),
    .Q(SPRAM_10_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_11 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_11_CLK),
    .CEN(SPRAM_11_CEN),
    .WEN(SPRAM_11_WEN),
    .D(SPRAM_11_D),
    .Q(SPRAM_11_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_12 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_12_CLK),
    .CEN(SPRAM_12_CEN),
    .WEN(SPRAM_12_WEN),
    .D(SPRAM_12_D),
    .Q(SPRAM_12_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_13 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_13_CLK),
    .CEN(SPRAM_13_CEN),
    .WEN(SPRAM_13_WEN),
    .D(SPRAM_13_D),
    .Q(SPRAM_13_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_14 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_14_CLK),
    .CEN(SPRAM_14_CEN),
    .WEN(SPRAM_14_WEN),
    .D(SPRAM_14_D),
    .Q(SPRAM_14_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_15 ( // @[ifm_buffer.scala 53:119]
    .CLK(SPRAM_15_CLK),
    .CEN(SPRAM_15_CEN),
    .WEN(SPRAM_15_WEN),
    .D(SPRAM_15_D),
    .Q(SPRAM_15_Q)
  );
  assign io_buffer_to_input_0 = 3'h7 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_0_7_Q : _GEN_15; // @[ifm_buffer.scala 71:{29,29}]
  assign io_buffer_to_input_1 = 3'h7 == _io_buffer_to_input_0_T_1[2:0] ? spram_wrap_1_7_Q : _GEN_23; // @[ifm_buffer.scala 71:{29,29}]
  assign io_ifm_buffer_ready = self_buffer_to_input_valid; // @[ifm_buffer.scala 35:23]
  assign SPRAM_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_WEN = self_buffer_to_input_valid | ~(4'h0 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_1_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_1_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_1_WEN = self_buffer_to_input_valid | ~(4'h1 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_1_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_2_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_2_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_2_WEN = self_buffer_to_input_valid | ~(4'h2 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_2_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_3_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_3_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_3_WEN = self_buffer_to_input_valid | ~(4'h3 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_3_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_4_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_4_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_4_WEN = self_buffer_to_input_valid | ~(4'h4 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_4_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_5_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_5_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_5_WEN = self_buffer_to_input_valid | ~(4'h5 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_5_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_6_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_6_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_6_WEN = self_buffer_to_input_valid | ~(4'h6 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_6_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_7_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_7_CEN = counter_ch_0 >= 4'h7 ? 1'h0 : ~dma_to_buffer_0; // @[ifm_buffer.scala 50:23]
  assign SPRAM_7_WEN = self_buffer_to_input_valid | ~(4'h7 == counter_ch_0); // @[ifm_buffer.scala 59:63]
  assign SPRAM_7_D = io_dma_to_buffer_0_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_8_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_8_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_8_WEN = self_buffer_to_input_valid | ~(4'h0 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_8_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_9_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_9_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_9_WEN = self_buffer_to_input_valid | ~(4'h1 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_9_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_10_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_10_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_10_WEN = self_buffer_to_input_valid | ~(4'h2 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_10_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_11_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_11_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_11_WEN = self_buffer_to_input_valid | ~(4'h3 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_11_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_12_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_12_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_12_WEN = self_buffer_to_input_valid | ~(4'h4 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_12_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_13_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_13_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_13_WEN = self_buffer_to_input_valid | ~(4'h5 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_13_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_14_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_14_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_14_WEN = self_buffer_to_input_valid | ~(4'h6 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_14_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  assign SPRAM_15_CLK = clock; // @[ifm_buffer.scala 53:51 57:33]
  assign SPRAM_15_CEN = counter_ch_1 >= 4'h7 ? 1'h0 : ~dma_to_buffer_1; // @[ifm_buffer.scala 50:23]
  assign SPRAM_15_WEN = self_buffer_to_input_valid | ~(4'h7 == counter_ch_1); // @[ifm_buffer.scala 59:63]
  assign SPRAM_15_D = io_dma_to_buffer_1_data; // @[ifm_buffer.scala 61:61]
  always @(posedge clock) begin
    if (reset) begin // @[ifm_buffer.scala 16:30]
      dma_to_buffer_0 <= 1'h0; // @[ifm_buffer.scala 16:30]
    end else begin
      dma_to_buffer_0 <= io_dma_to_buffer_0_valid; // @[ifm_buffer.scala 22:24]
    end
    if (reset) begin // @[ifm_buffer.scala 16:30]
      dma_to_buffer_1 <= 1'h0; // @[ifm_buffer.scala 16:30]
    end else begin
      dma_to_buffer_1 <= io_dma_to_buffer_1_valid; // @[ifm_buffer.scala 22:24]
    end
    if (reset) begin // @[ifm_buffer.scala 18:27]
      counter_ch_0 <= 4'h0; // @[ifm_buffer.scala 18:27]
    end else if (self_buffer_to_input_valid & input_state_ready & io_din_valid_ConV) begin // @[ifm_buffer.scala 37:78]
      if (counter_out != 4'h8) begin // @[ifm_buffer.scala 38:40]
        counter_ch_0 <= _counter_ch_0_T_5; // @[ifm_buffer.scala 23:21]
      end else begin
        counter_ch_0 <= 4'h0; // @[ifm_buffer.scala 42:37]
      end
    end else begin
      counter_ch_0 <= _counter_ch_0_T_5; // @[ifm_buffer.scala 23:21]
    end
    if (reset) begin // @[ifm_buffer.scala 18:27]
      counter_ch_1 <= 4'h0; // @[ifm_buffer.scala 18:27]
    end else if (self_buffer_to_input_valid & input_state_ready & io_din_valid_ConV) begin // @[ifm_buffer.scala 37:78]
      if (counter_out != 4'h8) begin // @[ifm_buffer.scala 38:40]
        counter_ch_1 <= _counter_ch_1_T_5; // @[ifm_buffer.scala 23:21]
      end else begin
        counter_ch_1 <= 4'h0; // @[ifm_buffer.scala 42:37]
      end
    end else begin
      counter_ch_1 <= _counter_ch_1_T_5; // @[ifm_buffer.scala 23:21]
    end
    input_state_ready <= reset | _GEN_8; // @[ifm_buffer.scala 19:{70,70}]
    if (reset) begin // @[ifm_buffer.scala 30:28]
      counter_out <= 4'hf; // @[ifm_buffer.scala 30:28]
    end else if (self_buffer_to_input_valid & input_state_ready & io_din_valid_ConV) begin // @[ifm_buffer.scala 37:78]
      if (counter_out != 4'h8) begin // @[ifm_buffer.scala 38:40]
        counter_out <= _counter_out_T_1; // @[ifm_buffer.scala 39:19]
      end else begin
        counter_out <= 4'hf; // @[ifm_buffer.scala 41:19]
      end
    end
    if (reset) begin // @[ifm_buffer.scala 31:32]
      counter_out_fix <= 4'hf; // @[ifm_buffer.scala 31:32]
    end else begin
      counter_out_fix <= counter_out; // @[ifm_buffer.scala 46:19]
    end
    if (reset) begin // @[ifm_buffer.scala 32:43]
      self_buffer_to_input_valid <= 1'h0; // @[ifm_buffer.scala 32:43]
    end else begin
      self_buffer_to_input_valid <= counter_ch_0 == 4'h8 & counter_ch_1 == 4'h8; // @[ifm_buffer.scala 34:30]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dma_to_buffer_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dma_to_buffer_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  counter_ch_0 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  counter_ch_1 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  input_state_ready = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  counter_out = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  counter_out_fix = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  self_buffer_to_input_valid = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module wgt_buffer(
  input          clock,
  input          reset,
  input          io_wgt_data_valid,
  input          io_dma_to_wgtbuffer_0_valid,
  input  [127:0] io_dma_to_wgtbuffer_0_data,
  input          io_dma_to_wgtbuffer_1_valid,
  input  [127:0] io_dma_to_wgtbuffer_1_data,
  output [127:0] io_buffer_to_BL_0,
  output [127:0] io_buffer_to_BL_1,
  output [127:0] io_buffer_to_BL_2,
  output [127:0] io_buffer_to_BL_3,
  output [127:0] io_buffer_to_WL,
  output         io_wgt_buffer_done,
  output         io_test3,
  output         io_test6,
  output         io_test9,
  output         io_test12,
  output         io_test15
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [127:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_1_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_1_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_1_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_1_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_1_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_2_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_2_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_2_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_2_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_2_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_3_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_3_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_3_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_3_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_3_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_4_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_4_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_4_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_4_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_4_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_5_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_5_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_5_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_5_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_5_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_6_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_6_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_6_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_6_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_6_Q; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_7_CLK; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_7_CEN; // @[wgt_buffer.scala 81:122]
  wire  SPRAM_7_WEN; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_7_D; // @[wgt_buffer.scala 81:122]
  wire [127:0] SPRAM_7_Q; // @[wgt_buffer.scala 81:122]
  reg  dma_to_wgtbuffer_0; // @[wgt_buffer.scala 20:33]
  reg  dma_to_wgtbuffer_1; // @[wgt_buffer.scala 20:33]
  reg [1:0] dma_cnt_0; // @[wgt_buffer.scala 22:24]
  reg [1:0] dma_cnt_1; // @[wgt_buffer.scala 22:24]
  reg [1:0] dma_cnt_fix_0; // @[wgt_buffer.scala 23:28]
  reg [1:0] dma_cnt_fix_1; // @[wgt_buffer.scala 23:28]
  reg [7:0] WL_cnt; // @[wgt_buffer.scala 24:23]
  reg [127:0] buffer_to_WL; // @[wgt_buffer.scala 25:25]
  wire [127:0] wgt_spram_wrap_0_0_Q = SPRAM_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_2_0_Q = SPRAM_4_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_0_1_Q = SPRAM_1_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_2_1_Q = SPRAM_5_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_1_0_Q = SPRAM_2_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_3_0_Q = SPRAM_6_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_1_1_Q = SPRAM_3_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [127:0] wgt_spram_wrap_3_1_Q = SPRAM_7_Q; // @[wgt_buffer.scala 81:{58,58}]
  wire [1:0] _dma_cnt_0_T_1 = dma_cnt_0 + 2'h1; // @[wgt_buffer.scala 38:63]
  wire [1:0] _dma_cnt_1_T_1 = dma_cnt_1 + 2'h1; // @[wgt_buffer.scala 38:63]
  wire  _T_4 = dma_cnt_0 != dma_cnt_fix_0; // @[wgt_buffer.scala 40:72]
  wire [7:0] _WL_cnt_T_1 = WL_cnt + 8'h1; // @[wgt_buffer.scala 41:24]
  wire [255:0] _buffer_to_WL_T = 256'h1 << WL_cnt; // @[wgt_buffer.scala 42:27]
  wire [255:0] _GEN_1 = dma_cnt_0 == 2'h0 & dma_cnt_1 == 2'h0 & WL_cnt != 8'h0 & _T_4 ? _buffer_to_WL_T : 256'h0; // @[wgt_buffer.scala 43:111 45:20 47:20]
  wire [255:0] _GEN_3 = dma_cnt_0 == 2'h2 & dma_cnt_1 == 2'h2 & dma_cnt_0 != dma_cnt_fix_0 ? _buffer_to_WL_T : _GEN_1; // @[wgt_buffer.scala 40:93 42:20]
  wire [255:0] _GEN_9 = io_wgt_data_valid ? _GEN_3 : 256'h0; // @[wgt_buffer.scala 36:27]
  wire  test1 = WL_cnt == 8'h38; // @[wgt_buffer.scala 58:26]
  reg  test2; // @[wgt_buffer.scala 59:22]
  wire  test4 = WL_cnt == 8'h39; // @[wgt_buffer.scala 62:26]
  reg  test5; // @[wgt_buffer.scala 63:22]
  wire  test7 = WL_cnt == 8'h3a; // @[wgt_buffer.scala 66:26]
  reg  test8; // @[wgt_buffer.scala 67:22]
  wire  test10 = WL_cnt == 8'h3b; // @[wgt_buffer.scala 70:27]
  reg  test11; // @[wgt_buffer.scala 71:23]
  wire  test13 = WL_cnt == 8'h3c; // @[wgt_buffer.scala 74:27]
  reg  test14; // @[wgt_buffer.scala 75:23]
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_2 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_2_CLK),
    .CEN(SPRAM_2_CEN),
    .WEN(SPRAM_2_WEN),
    .D(SPRAM_2_D),
    .Q(SPRAM_2_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_3 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_3_CLK),
    .CEN(SPRAM_3_CEN),
    .WEN(SPRAM_3_WEN),
    .D(SPRAM_3_D),
    .Q(SPRAM_3_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_4 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_4_CLK),
    .CEN(SPRAM_4_CEN),
    .WEN(SPRAM_4_WEN),
    .D(SPRAM_4_D),
    .Q(SPRAM_4_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_5 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_5_CLK),
    .CEN(SPRAM_5_CEN),
    .WEN(SPRAM_5_WEN),
    .D(SPRAM_5_D),
    .Q(SPRAM_5_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_6 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_6_CLK),
    .CEN(SPRAM_6_CEN),
    .WEN(SPRAM_6_WEN),
    .D(SPRAM_6_D),
    .Q(SPRAM_6_Q)
  );
  SPRAM #(.DATA_WIDTH(128), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_7 ( // @[wgt_buffer.scala 81:122]
    .CLK(SPRAM_7_CLK),
    .CEN(SPRAM_7_CEN),
    .WEN(SPRAM_7_WEN),
    .D(SPRAM_7_D),
    .Q(SPRAM_7_Q)
  );
  assign io_buffer_to_BL_0 = dma_cnt_fix_0[1] ? wgt_spram_wrap_0_0_Q : wgt_spram_wrap_2_0_Q; // @[wgt_buffer.scala 32:96]
  assign io_buffer_to_BL_1 = dma_cnt_fix_0[1] ? wgt_spram_wrap_0_1_Q : wgt_spram_wrap_2_1_Q; // @[wgt_buffer.scala 32:96]
  assign io_buffer_to_BL_2 = dma_cnt_fix_1[1] ? wgt_spram_wrap_1_0_Q : wgt_spram_wrap_3_0_Q; // @[wgt_buffer.scala 32:96]
  assign io_buffer_to_BL_3 = dma_cnt_fix_1[1] ? wgt_spram_wrap_1_1_Q : wgt_spram_wrap_3_1_Q; // @[wgt_buffer.scala 32:96]
  assign io_buffer_to_WL = buffer_to_WL; // @[wgt_buffer.scala 79:19]
  assign io_wgt_buffer_done = io_wgt_data_valid & WL_cnt[7]; // @[wgt_buffer.scala 78:47]
  assign io_test3 = test1 & test2; // @[wgt_buffer.scala 60:22]
  assign io_test6 = test4 & test5; // @[wgt_buffer.scala 64:22]
  assign io_test9 = test7 & test8; // @[wgt_buffer.scala 68:22]
  assign io_test12 = test10 & test11; // @[wgt_buffer.scala 72:24]
  assign io_test15 = test13 & test14; // @[wgt_buffer.scala 76:24]
  assign SPRAM_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_WEN = ~dma_to_wgtbuffer_0 | ~(2'h0 == dma_cnt_0); // @[wgt_buffer.scala 87:79]
  assign SPRAM_D = io_dma_to_wgtbuffer_0_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_1_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_1_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_1_WEN = ~dma_to_wgtbuffer_0 | ~(2'h1 == dma_cnt_0); // @[wgt_buffer.scala 87:79]
  assign SPRAM_1_D = io_dma_to_wgtbuffer_0_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_2_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_2_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_2_WEN = ~dma_to_wgtbuffer_1 | ~(2'h0 == dma_cnt_1); // @[wgt_buffer.scala 87:79]
  assign SPRAM_2_D = io_dma_to_wgtbuffer_1_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_3_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_3_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_3_WEN = ~dma_to_wgtbuffer_1 | ~(2'h1 == dma_cnt_1); // @[wgt_buffer.scala 87:79]
  assign SPRAM_3_D = io_dma_to_wgtbuffer_1_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_4_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_4_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_4_WEN = ~dma_to_wgtbuffer_0 | ~(2'h2 == dma_cnt_0); // @[wgt_buffer.scala 87:79]
  assign SPRAM_4_D = io_dma_to_wgtbuffer_0_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_5_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_5_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_5_WEN = ~dma_to_wgtbuffer_0 | ~(2'h3 == dma_cnt_0); // @[wgt_buffer.scala 87:79]
  assign SPRAM_5_D = io_dma_to_wgtbuffer_0_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_6_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_6_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_6_WEN = ~dma_to_wgtbuffer_1 | ~(2'h2 == dma_cnt_1); // @[wgt_buffer.scala 87:79]
  assign SPRAM_6_D = io_dma_to_wgtbuffer_1_data; // @[wgt_buffer.scala 89:81]
  assign SPRAM_7_CLK = clock; // @[wgt_buffer.scala 81:58 85:37]
  assign SPRAM_7_CEN = 1'h0; // @[wgt_buffer.scala 81:58 86:37]
  assign SPRAM_7_WEN = ~dma_to_wgtbuffer_1 | ~(2'h3 == dma_cnt_1); // @[wgt_buffer.scala 87:79]
  assign SPRAM_7_D = io_dma_to_wgtbuffer_1_data; // @[wgt_buffer.scala 89:81]
  always @(posedge clock) begin
    if (reset) begin // @[wgt_buffer.scala 20:33]
      dma_to_wgtbuffer_0 <= 1'h0; // @[wgt_buffer.scala 20:33]
    end else begin
      dma_to_wgtbuffer_0 <= io_dma_to_wgtbuffer_0_valid; // @[wgt_buffer.scala 30:28]
    end
    if (reset) begin // @[wgt_buffer.scala 20:33]
      dma_to_wgtbuffer_1 <= 1'h0; // @[wgt_buffer.scala 20:33]
    end else begin
      dma_to_wgtbuffer_1 <= io_dma_to_wgtbuffer_1_valid; // @[wgt_buffer.scala 30:28]
    end
    if (reset) begin // @[wgt_buffer.scala 22:24]
      dma_cnt_0 <= 2'h0; // @[wgt_buffer.scala 22:24]
    end else if (io_wgt_data_valid) begin // @[wgt_buffer.scala 36:27]
      if (dma_to_wgtbuffer_0) begin // @[wgt_buffer.scala 38:26]
        dma_cnt_0 <= _dma_cnt_0_T_1;
      end
    end
    if (reset) begin // @[wgt_buffer.scala 22:24]
      dma_cnt_1 <= 2'h0; // @[wgt_buffer.scala 22:24]
    end else if (io_wgt_data_valid) begin // @[wgt_buffer.scala 36:27]
      if (dma_to_wgtbuffer_1) begin // @[wgt_buffer.scala 38:26]
        dma_cnt_1 <= _dma_cnt_1_T_1;
      end
    end
    if (reset) begin // @[wgt_buffer.scala 23:28]
      dma_cnt_fix_0 <= 2'h0; // @[wgt_buffer.scala 23:28]
    end else begin
      dma_cnt_fix_0 <= dma_cnt_0; // @[wgt_buffer.scala 29:23]
    end
    if (reset) begin // @[wgt_buffer.scala 23:28]
      dma_cnt_fix_1 <= 2'h0; // @[wgt_buffer.scala 23:28]
    end else begin
      dma_cnt_fix_1 <= dma_cnt_1; // @[wgt_buffer.scala 29:23]
    end
    if (reset) begin // @[wgt_buffer.scala 24:23]
      WL_cnt <= 8'h0; // @[wgt_buffer.scala 24:23]
    end else if (io_wgt_data_valid) begin // @[wgt_buffer.scala 36:27]
      if (dma_cnt_0 == 2'h2 & dma_cnt_1 == 2'h2 & dma_cnt_0 != dma_cnt_fix_0) begin // @[wgt_buffer.scala 40:93]
        WL_cnt <= _WL_cnt_T_1; // @[wgt_buffer.scala 41:14]
      end else if (dma_cnt_0 == 2'h0 & dma_cnt_1 == 2'h0 & WL_cnt != 8'h0 & _T_4) begin // @[wgt_buffer.scala 43:111]
        WL_cnt <= _WL_cnt_T_1; // @[wgt_buffer.scala 44:14]
      end
    end else if (WL_cnt[7]) begin // @[wgt_buffer.scala 50:39]
      WL_cnt <= 8'h0; // @[wgt_buffer.scala 51:14]
    end
    buffer_to_WL <= _GEN_9[127:0];
    test2 <= WL_cnt == 8'h38; // @[wgt_buffer.scala 58:26]
    test5 <= WL_cnt == 8'h39; // @[wgt_buffer.scala 62:26]
    test8 <= WL_cnt == 8'h3a; // @[wgt_buffer.scala 66:26]
    test11 <= WL_cnt == 8'h3b; // @[wgt_buffer.scala 70:27]
    test14 <= WL_cnt == 8'h3c; // @[wgt_buffer.scala 74:27]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dma_to_wgtbuffer_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dma_to_wgtbuffer_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dma_cnt_0 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  dma_cnt_1 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  dma_cnt_fix_0 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  dma_cnt_fix_1 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  WL_cnt = _RAND_6[7:0];
  _RAND_7 = {4{`RANDOM}};
  buffer_to_WL = _RAND_7[127:0];
  _RAND_8 = {1{`RANDOM}};
  test2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  test5 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  test8 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  test11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  test14 = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module out_buffer(
  input          clock,
  input          io_output_data_valid,
  input          io_output_to_dma_0_valid,
  output [127:0] io_output_to_dma_0_data,
  input          io_output_to_dma_1_valid,
  output [127:0] io_output_to_dma_1_data,
  input  [31:0]  io_sum_out_0,
  input  [31:0]  io_sum_out_1,
  input  [31:0]  io_sum_out_2,
  input  [31:0]  io_sum_out_3,
  input  [31:0]  io_sum_out_4,
  input  [31:0]  io_sum_out_5,
  input  [31:0]  io_sum_out_6,
  input  [31:0]  io_sum_out_7,
  input  [31:0]  io_sum_out_8,
  input  [31:0]  io_sum_out_9,
  input  [31:0]  io_sum_out_10,
  input  [31:0]  io_sum_out_11,
  input  [31:0]  io_sum_out_12,
  input  [31:0]  io_sum_out_13,
  input  [31:0]  io_sum_out_14,
  input  [31:0]  io_sum_out_15,
  input  [31:0]  io_sum_out_16,
  input  [31:0]  io_sum_out_17,
  input  [31:0]  io_sum_out_18,
  input  [31:0]  io_sum_out_19,
  input  [31:0]  io_sum_out_20,
  input  [31:0]  io_sum_out_21,
  input  [31:0]  io_sum_out_22,
  input  [31:0]  io_sum_out_23,
  input  [31:0]  io_sum_out_24,
  input  [31:0]  io_sum_out_25,
  input  [31:0]  io_sum_out_26,
  input  [31:0]  io_sum_out_27,
  input  [31:0]  io_sum_out_28,
  input  [31:0]  io_sum_out_29,
  input  [31:0]  io_sum_out_30,
  input  [31:0]  io_sum_out_31,
  input  [31:0]  io_sum_out_32,
  input  [31:0]  io_sum_out_33,
  input  [31:0]  io_sum_out_34,
  input  [31:0]  io_sum_out_35,
  input  [31:0]  io_sum_out_36,
  input  [31:0]  io_sum_out_37,
  input  [31:0]  io_sum_out_38,
  input  [31:0]  io_sum_out_39,
  input  [31:0]  io_sum_out_40,
  input  [31:0]  io_sum_out_41,
  input  [31:0]  io_sum_out_42,
  input  [31:0]  io_sum_out_43,
  input  [31:0]  io_sum_out_44,
  input  [31:0]  io_sum_out_45,
  input  [31:0]  io_sum_out_46,
  input  [31:0]  io_sum_out_47,
  input  [31:0]  io_sum_out_48,
  input  [31:0]  io_sum_out_49,
  input  [31:0]  io_sum_out_50,
  input  [31:0]  io_sum_out_51,
  input  [31:0]  io_sum_out_52,
  input  [31:0]  io_sum_out_53,
  input  [31:0]  io_sum_out_54,
  input  [31:0]  io_sum_out_55,
  input  [31:0]  io_sum_out_56,
  input  [31:0]  io_sum_out_57,
  input  [31:0]  io_sum_out_58,
  input  [31:0]  io_sum_out_59,
  input  [31:0]  io_sum_out_60,
  input  [31:0]  io_sum_out_61,
  input  [31:0]  io_sum_out_62,
  input  [31:0]  io_sum_out_63,
  output         io_ofm_buffer_valid_0,
  output         io_ofm_buffer_valid_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SPRAM_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_1_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_1_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_1_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_1_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_1_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_2_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_2_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_2_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_2_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_2_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_3_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_3_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_3_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_3_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_3_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_4_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_4_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_4_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_4_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_4_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_5_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_5_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_5_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_5_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_5_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_6_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_6_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_6_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_6_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_6_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_7_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_7_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_7_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_7_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_7_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_8_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_8_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_8_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_8_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_8_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_9_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_9_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_9_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_9_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_9_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_10_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_10_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_10_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_10_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_10_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_11_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_11_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_11_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_11_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_11_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_12_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_12_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_12_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_12_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_12_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_13_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_13_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_13_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_13_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_13_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_14_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_14_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_14_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_14_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_14_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_15_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_15_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_15_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_15_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_15_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_16_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_16_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_16_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_16_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_16_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_17_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_17_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_17_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_17_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_17_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_18_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_18_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_18_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_18_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_18_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_19_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_19_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_19_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_19_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_19_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_20_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_20_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_20_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_20_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_20_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_21_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_21_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_21_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_21_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_21_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_22_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_22_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_22_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_22_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_22_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_23_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_23_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_23_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_23_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_23_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_24_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_24_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_24_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_24_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_24_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_25_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_25_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_25_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_25_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_25_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_26_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_26_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_26_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_26_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_26_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_27_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_27_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_27_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_27_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_27_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_28_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_28_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_28_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_28_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_28_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_29_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_29_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_29_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_29_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_29_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_30_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_30_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_30_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_30_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_30_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_31_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_31_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_31_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_31_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_31_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_32_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_32_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_32_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_32_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_32_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_33_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_33_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_33_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_33_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_33_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_34_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_34_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_34_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_34_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_34_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_35_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_35_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_35_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_35_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_35_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_36_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_36_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_36_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_36_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_36_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_37_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_37_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_37_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_37_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_37_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_38_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_38_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_38_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_38_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_38_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_39_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_39_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_39_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_39_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_39_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_40_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_40_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_40_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_40_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_40_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_41_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_41_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_41_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_41_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_41_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_42_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_42_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_42_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_42_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_42_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_43_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_43_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_43_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_43_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_43_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_44_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_44_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_44_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_44_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_44_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_45_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_45_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_45_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_45_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_45_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_46_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_46_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_46_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_46_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_46_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_47_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_47_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_47_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_47_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_47_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_48_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_48_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_48_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_48_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_48_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_49_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_49_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_49_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_49_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_49_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_50_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_50_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_50_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_50_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_50_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_51_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_51_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_51_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_51_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_51_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_52_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_52_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_52_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_52_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_52_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_53_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_53_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_53_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_53_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_53_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_54_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_54_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_54_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_54_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_54_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_55_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_55_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_55_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_55_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_55_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_56_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_56_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_56_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_56_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_56_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_57_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_57_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_57_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_57_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_57_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_58_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_58_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_58_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_58_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_58_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_59_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_59_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_59_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_59_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_59_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_60_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_60_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_60_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_60_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_60_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_61_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_61_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_61_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_61_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_61_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_62_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_62_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_62_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_62_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_62_Q; // @[out_buffer.scala 46:136]
  wire  SPRAM_63_CLK; // @[out_buffer.scala 46:136]
  wire  SPRAM_63_CEN; // @[out_buffer.scala 46:136]
  wire  SPRAM_63_WEN; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_63_D; // @[out_buffer.scala 46:136]
  wire [31:0] SPRAM_63_Q; // @[out_buffer.scala 46:136]
  reg [3:0] counter_ch_0; // @[out_buffer.scala 15:23]
  reg [3:0] counter_ch_1; // @[out_buffer.scala 15:23]
  reg  ofm_buffer_done; // @[out_buffer.scala 16:28]
  reg  buffer_ready; // @[out_buffer.scala 17:25]
  wire [3:0] _counter_ch_0_T_1 = counter_ch_0 + 4'h1; // @[out_buffer.scala 37:46]
  wire [3:0] _counter_ch_1_T_1 = counter_ch_1 + 4'h1; // @[out_buffer.scala 37:46]
  wire  _GEN_2 = ~io_output_to_dma_0_valid & ~io_output_to_dma_1_valid | buffer_ready; // @[out_buffer.scala 31:73 32:20 17:25]
  wire  _GEN_3 = ~io_output_to_dma_0_valid & ~io_output_to_dma_1_valid & ofm_buffer_done; // @[out_buffer.scala 16:28 31:73 34:23]
  wire  _GEN_6 = ofm_buffer_done ? 1'h0 : _GEN_3; // @[out_buffer.scala 26:38 27:23]
  reg [3:0] counter_fix_0; // @[out_buffer.scala 48:24]
  reg [3:0] counter_fix_1; // @[out_buffer.scala 48:24]
  wire [31:0] ofm_spram_wrap_0_1_Q = SPRAM_1_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_0_Q = SPRAM_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_3_Q = SPRAM_3_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_2_Q = SPRAM_2_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_0 = {ofm_spram_wrap_0_3_Q,ofm_spram_wrap_0_2_Q,ofm_spram_wrap_0_1_Q,ofm_spram_wrap_0_0_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_5_Q = SPRAM_5_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_4_Q = SPRAM_4_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_7_Q = SPRAM_7_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_6_Q = SPRAM_6_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_1 = {ofm_spram_wrap_0_7_Q,ofm_spram_wrap_0_6_Q,ofm_spram_wrap_0_5_Q,ofm_spram_wrap_0_4_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_9_Q = SPRAM_9_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_8_Q = SPRAM_8_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_11_Q = SPRAM_11_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_10_Q = SPRAM_10_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_2 = {ofm_spram_wrap_0_11_Q,ofm_spram_wrap_0_10_Q,ofm_spram_wrap_0_9_Q,ofm_spram_wrap_0_8_Q}
    ; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_13_Q = SPRAM_13_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_12_Q = SPRAM_12_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_15_Q = SPRAM_15_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_14_Q = SPRAM_14_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_3 = {ofm_spram_wrap_0_15_Q,ofm_spram_wrap_0_14_Q,ofm_spram_wrap_0_13_Q,
    ofm_spram_wrap_0_12_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_17_Q = SPRAM_17_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_16_Q = SPRAM_16_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_19_Q = SPRAM_19_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_18_Q = SPRAM_18_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_4 = {ofm_spram_wrap_0_19_Q,ofm_spram_wrap_0_18_Q,ofm_spram_wrap_0_17_Q,
    ofm_spram_wrap_0_16_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_21_Q = SPRAM_21_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_20_Q = SPRAM_20_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_23_Q = SPRAM_23_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_22_Q = SPRAM_22_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_5 = {ofm_spram_wrap_0_23_Q,ofm_spram_wrap_0_22_Q,ofm_spram_wrap_0_21_Q,
    ofm_spram_wrap_0_20_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_25_Q = SPRAM_25_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_24_Q = SPRAM_24_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_27_Q = SPRAM_27_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_26_Q = SPRAM_26_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_6 = {ofm_spram_wrap_0_27_Q,ofm_spram_wrap_0_26_Q,ofm_spram_wrap_0_25_Q,
    ofm_spram_wrap_0_24_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_0_29_Q = SPRAM_29_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_28_Q = SPRAM_28_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_31_Q = SPRAM_31_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_0_30_Q = SPRAM_30_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_0_7 = {ofm_spram_wrap_0_31_Q,ofm_spram_wrap_0_30_Q,ofm_spram_wrap_0_29_Q,
    ofm_spram_wrap_0_28_Q}; // @[Cat.scala 33:92]
  wire [127:0] _GEN_15 = 3'h1 == counter_fix_0[2:0] ? output_data_0_1 : output_data_0_0; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_16 = 3'h2 == counter_fix_0[2:0] ? output_data_0_2 : _GEN_15; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_17 = 3'h3 == counter_fix_0[2:0] ? output_data_0_3 : _GEN_16; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_18 = 3'h4 == counter_fix_0[2:0] ? output_data_0_4 : _GEN_17; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_19 = 3'h5 == counter_fix_0[2:0] ? output_data_0_5 : _GEN_18; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_20 = 3'h6 == counter_fix_0[2:0] ? output_data_0_6 : _GEN_19; // @[out_buffer.scala 64:{33,33}]
  wire [31:0] ofm_spram_wrap_1_1_Q = SPRAM_33_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_0_Q = SPRAM_32_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_3_Q = SPRAM_35_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_2_Q = SPRAM_34_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_0 = {ofm_spram_wrap_1_3_Q,ofm_spram_wrap_1_2_Q,ofm_spram_wrap_1_1_Q,ofm_spram_wrap_1_0_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_5_Q = SPRAM_37_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_4_Q = SPRAM_36_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_7_Q = SPRAM_39_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_6_Q = SPRAM_38_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_1 = {ofm_spram_wrap_1_7_Q,ofm_spram_wrap_1_6_Q,ofm_spram_wrap_1_5_Q,ofm_spram_wrap_1_4_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_9_Q = SPRAM_41_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_8_Q = SPRAM_40_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_11_Q = SPRAM_43_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_10_Q = SPRAM_42_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_2 = {ofm_spram_wrap_1_11_Q,ofm_spram_wrap_1_10_Q,ofm_spram_wrap_1_9_Q,ofm_spram_wrap_1_8_Q}
    ; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_13_Q = SPRAM_45_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_12_Q = SPRAM_44_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_15_Q = SPRAM_47_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_14_Q = SPRAM_46_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_3 = {ofm_spram_wrap_1_15_Q,ofm_spram_wrap_1_14_Q,ofm_spram_wrap_1_13_Q,
    ofm_spram_wrap_1_12_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_17_Q = SPRAM_49_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_16_Q = SPRAM_48_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_19_Q = SPRAM_51_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_18_Q = SPRAM_50_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_4 = {ofm_spram_wrap_1_19_Q,ofm_spram_wrap_1_18_Q,ofm_spram_wrap_1_17_Q,
    ofm_spram_wrap_1_16_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_21_Q = SPRAM_53_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_20_Q = SPRAM_52_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_23_Q = SPRAM_55_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_22_Q = SPRAM_54_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_5 = {ofm_spram_wrap_1_23_Q,ofm_spram_wrap_1_22_Q,ofm_spram_wrap_1_21_Q,
    ofm_spram_wrap_1_20_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_25_Q = SPRAM_57_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_24_Q = SPRAM_56_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_27_Q = SPRAM_59_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_26_Q = SPRAM_58_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_6 = {ofm_spram_wrap_1_27_Q,ofm_spram_wrap_1_26_Q,ofm_spram_wrap_1_25_Q,
    ofm_spram_wrap_1_24_Q}; // @[Cat.scala 33:92]
  wire [31:0] ofm_spram_wrap_1_29_Q = SPRAM_61_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_28_Q = SPRAM_60_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_31_Q = SPRAM_63_Q; // @[out_buffer.scala 46:{55,55}]
  wire [31:0] ofm_spram_wrap_1_30_Q = SPRAM_62_Q; // @[out_buffer.scala 46:{55,55}]
  wire [127:0] output_data_1_7 = {ofm_spram_wrap_1_31_Q,ofm_spram_wrap_1_30_Q,ofm_spram_wrap_1_29_Q,
    ofm_spram_wrap_1_28_Q}; // @[Cat.scala 33:92]
  wire [127:0] _GEN_23 = 3'h1 == counter_fix_1[2:0] ? output_data_1_1 : output_data_1_0; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_24 = 3'h2 == counter_fix_1[2:0] ? output_data_1_2 : _GEN_23; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_25 = 3'h3 == counter_fix_1[2:0] ? output_data_1_3 : _GEN_24; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_26 = 3'h4 == counter_fix_1[2:0] ? output_data_1_4 : _GEN_25; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_27 = 3'h5 == counter_fix_1[2:0] ? output_data_1_5 : _GEN_26; // @[out_buffer.scala 64:{33,33}]
  wire [127:0] _GEN_28 = 3'h6 == counter_fix_1[2:0] ? output_data_1_6 : _GEN_27; // @[out_buffer.scala 64:{33,33}]
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_CLK),
    .CEN(SPRAM_CEN),
    .WEN(SPRAM_WEN),
    .D(SPRAM_D),
    .Q(SPRAM_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_1 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_1_CLK),
    .CEN(SPRAM_1_CEN),
    .WEN(SPRAM_1_WEN),
    .D(SPRAM_1_D),
    .Q(SPRAM_1_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_2 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_2_CLK),
    .CEN(SPRAM_2_CEN),
    .WEN(SPRAM_2_WEN),
    .D(SPRAM_2_D),
    .Q(SPRAM_2_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_3 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_3_CLK),
    .CEN(SPRAM_3_CEN),
    .WEN(SPRAM_3_WEN),
    .D(SPRAM_3_D),
    .Q(SPRAM_3_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_4 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_4_CLK),
    .CEN(SPRAM_4_CEN),
    .WEN(SPRAM_4_WEN),
    .D(SPRAM_4_D),
    .Q(SPRAM_4_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_5 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_5_CLK),
    .CEN(SPRAM_5_CEN),
    .WEN(SPRAM_5_WEN),
    .D(SPRAM_5_D),
    .Q(SPRAM_5_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_6 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_6_CLK),
    .CEN(SPRAM_6_CEN),
    .WEN(SPRAM_6_WEN),
    .D(SPRAM_6_D),
    .Q(SPRAM_6_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_7 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_7_CLK),
    .CEN(SPRAM_7_CEN),
    .WEN(SPRAM_7_WEN),
    .D(SPRAM_7_D),
    .Q(SPRAM_7_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_8 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_8_CLK),
    .CEN(SPRAM_8_CEN),
    .WEN(SPRAM_8_WEN),
    .D(SPRAM_8_D),
    .Q(SPRAM_8_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_9 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_9_CLK),
    .CEN(SPRAM_9_CEN),
    .WEN(SPRAM_9_WEN),
    .D(SPRAM_9_D),
    .Q(SPRAM_9_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_10 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_10_CLK),
    .CEN(SPRAM_10_CEN),
    .WEN(SPRAM_10_WEN),
    .D(SPRAM_10_D),
    .Q(SPRAM_10_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_11 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_11_CLK),
    .CEN(SPRAM_11_CEN),
    .WEN(SPRAM_11_WEN),
    .D(SPRAM_11_D),
    .Q(SPRAM_11_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_12 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_12_CLK),
    .CEN(SPRAM_12_CEN),
    .WEN(SPRAM_12_WEN),
    .D(SPRAM_12_D),
    .Q(SPRAM_12_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_13 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_13_CLK),
    .CEN(SPRAM_13_CEN),
    .WEN(SPRAM_13_WEN),
    .D(SPRAM_13_D),
    .Q(SPRAM_13_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_14 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_14_CLK),
    .CEN(SPRAM_14_CEN),
    .WEN(SPRAM_14_WEN),
    .D(SPRAM_14_D),
    .Q(SPRAM_14_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_15 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_15_CLK),
    .CEN(SPRAM_15_CEN),
    .WEN(SPRAM_15_WEN),
    .D(SPRAM_15_D),
    .Q(SPRAM_15_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_16 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_16_CLK),
    .CEN(SPRAM_16_CEN),
    .WEN(SPRAM_16_WEN),
    .D(SPRAM_16_D),
    .Q(SPRAM_16_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_17 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_17_CLK),
    .CEN(SPRAM_17_CEN),
    .WEN(SPRAM_17_WEN),
    .D(SPRAM_17_D),
    .Q(SPRAM_17_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_18 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_18_CLK),
    .CEN(SPRAM_18_CEN),
    .WEN(SPRAM_18_WEN),
    .D(SPRAM_18_D),
    .Q(SPRAM_18_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_19 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_19_CLK),
    .CEN(SPRAM_19_CEN),
    .WEN(SPRAM_19_WEN),
    .D(SPRAM_19_D),
    .Q(SPRAM_19_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_20 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_20_CLK),
    .CEN(SPRAM_20_CEN),
    .WEN(SPRAM_20_WEN),
    .D(SPRAM_20_D),
    .Q(SPRAM_20_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_21 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_21_CLK),
    .CEN(SPRAM_21_CEN),
    .WEN(SPRAM_21_WEN),
    .D(SPRAM_21_D),
    .Q(SPRAM_21_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_22 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_22_CLK),
    .CEN(SPRAM_22_CEN),
    .WEN(SPRAM_22_WEN),
    .D(SPRAM_22_D),
    .Q(SPRAM_22_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_23 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_23_CLK),
    .CEN(SPRAM_23_CEN),
    .WEN(SPRAM_23_WEN),
    .D(SPRAM_23_D),
    .Q(SPRAM_23_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_24 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_24_CLK),
    .CEN(SPRAM_24_CEN),
    .WEN(SPRAM_24_WEN),
    .D(SPRAM_24_D),
    .Q(SPRAM_24_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_25 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_25_CLK),
    .CEN(SPRAM_25_CEN),
    .WEN(SPRAM_25_WEN),
    .D(SPRAM_25_D),
    .Q(SPRAM_25_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_26 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_26_CLK),
    .CEN(SPRAM_26_CEN),
    .WEN(SPRAM_26_WEN),
    .D(SPRAM_26_D),
    .Q(SPRAM_26_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_27 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_27_CLK),
    .CEN(SPRAM_27_CEN),
    .WEN(SPRAM_27_WEN),
    .D(SPRAM_27_D),
    .Q(SPRAM_27_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_28 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_28_CLK),
    .CEN(SPRAM_28_CEN),
    .WEN(SPRAM_28_WEN),
    .D(SPRAM_28_D),
    .Q(SPRAM_28_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_29 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_29_CLK),
    .CEN(SPRAM_29_CEN),
    .WEN(SPRAM_29_WEN),
    .D(SPRAM_29_D),
    .Q(SPRAM_29_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_30 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_30_CLK),
    .CEN(SPRAM_30_CEN),
    .WEN(SPRAM_30_WEN),
    .D(SPRAM_30_D),
    .Q(SPRAM_30_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_31 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_31_CLK),
    .CEN(SPRAM_31_CEN),
    .WEN(SPRAM_31_WEN),
    .D(SPRAM_31_D),
    .Q(SPRAM_31_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_32 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_32_CLK),
    .CEN(SPRAM_32_CEN),
    .WEN(SPRAM_32_WEN),
    .D(SPRAM_32_D),
    .Q(SPRAM_32_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_33 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_33_CLK),
    .CEN(SPRAM_33_CEN),
    .WEN(SPRAM_33_WEN),
    .D(SPRAM_33_D),
    .Q(SPRAM_33_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_34 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_34_CLK),
    .CEN(SPRAM_34_CEN),
    .WEN(SPRAM_34_WEN),
    .D(SPRAM_34_D),
    .Q(SPRAM_34_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_35 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_35_CLK),
    .CEN(SPRAM_35_CEN),
    .WEN(SPRAM_35_WEN),
    .D(SPRAM_35_D),
    .Q(SPRAM_35_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_36 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_36_CLK),
    .CEN(SPRAM_36_CEN),
    .WEN(SPRAM_36_WEN),
    .D(SPRAM_36_D),
    .Q(SPRAM_36_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_37 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_37_CLK),
    .CEN(SPRAM_37_CEN),
    .WEN(SPRAM_37_WEN),
    .D(SPRAM_37_D),
    .Q(SPRAM_37_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_38 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_38_CLK),
    .CEN(SPRAM_38_CEN),
    .WEN(SPRAM_38_WEN),
    .D(SPRAM_38_D),
    .Q(SPRAM_38_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_39 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_39_CLK),
    .CEN(SPRAM_39_CEN),
    .WEN(SPRAM_39_WEN),
    .D(SPRAM_39_D),
    .Q(SPRAM_39_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_40 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_40_CLK),
    .CEN(SPRAM_40_CEN),
    .WEN(SPRAM_40_WEN),
    .D(SPRAM_40_D),
    .Q(SPRAM_40_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_41 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_41_CLK),
    .CEN(SPRAM_41_CEN),
    .WEN(SPRAM_41_WEN),
    .D(SPRAM_41_D),
    .Q(SPRAM_41_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_42 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_42_CLK),
    .CEN(SPRAM_42_CEN),
    .WEN(SPRAM_42_WEN),
    .D(SPRAM_42_D),
    .Q(SPRAM_42_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_43 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_43_CLK),
    .CEN(SPRAM_43_CEN),
    .WEN(SPRAM_43_WEN),
    .D(SPRAM_43_D),
    .Q(SPRAM_43_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_44 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_44_CLK),
    .CEN(SPRAM_44_CEN),
    .WEN(SPRAM_44_WEN),
    .D(SPRAM_44_D),
    .Q(SPRAM_44_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_45 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_45_CLK),
    .CEN(SPRAM_45_CEN),
    .WEN(SPRAM_45_WEN),
    .D(SPRAM_45_D),
    .Q(SPRAM_45_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_46 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_46_CLK),
    .CEN(SPRAM_46_CEN),
    .WEN(SPRAM_46_WEN),
    .D(SPRAM_46_D),
    .Q(SPRAM_46_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_47 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_47_CLK),
    .CEN(SPRAM_47_CEN),
    .WEN(SPRAM_47_WEN),
    .D(SPRAM_47_D),
    .Q(SPRAM_47_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_48 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_48_CLK),
    .CEN(SPRAM_48_CEN),
    .WEN(SPRAM_48_WEN),
    .D(SPRAM_48_D),
    .Q(SPRAM_48_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_49 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_49_CLK),
    .CEN(SPRAM_49_CEN),
    .WEN(SPRAM_49_WEN),
    .D(SPRAM_49_D),
    .Q(SPRAM_49_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_50 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_50_CLK),
    .CEN(SPRAM_50_CEN),
    .WEN(SPRAM_50_WEN),
    .D(SPRAM_50_D),
    .Q(SPRAM_50_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_51 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_51_CLK),
    .CEN(SPRAM_51_CEN),
    .WEN(SPRAM_51_WEN),
    .D(SPRAM_51_D),
    .Q(SPRAM_51_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_52 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_52_CLK),
    .CEN(SPRAM_52_CEN),
    .WEN(SPRAM_52_WEN),
    .D(SPRAM_52_D),
    .Q(SPRAM_52_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_53 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_53_CLK),
    .CEN(SPRAM_53_CEN),
    .WEN(SPRAM_53_WEN),
    .D(SPRAM_53_D),
    .Q(SPRAM_53_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_54 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_54_CLK),
    .CEN(SPRAM_54_CEN),
    .WEN(SPRAM_54_WEN),
    .D(SPRAM_54_D),
    .Q(SPRAM_54_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_55 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_55_CLK),
    .CEN(SPRAM_55_CEN),
    .WEN(SPRAM_55_WEN),
    .D(SPRAM_55_D),
    .Q(SPRAM_55_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_56 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_56_CLK),
    .CEN(SPRAM_56_CEN),
    .WEN(SPRAM_56_WEN),
    .D(SPRAM_56_D),
    .Q(SPRAM_56_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_57 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_57_CLK),
    .CEN(SPRAM_57_CEN),
    .WEN(SPRAM_57_WEN),
    .D(SPRAM_57_D),
    .Q(SPRAM_57_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_58 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_58_CLK),
    .CEN(SPRAM_58_CEN),
    .WEN(SPRAM_58_WEN),
    .D(SPRAM_58_D),
    .Q(SPRAM_58_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_59 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_59_CLK),
    .CEN(SPRAM_59_CEN),
    .WEN(SPRAM_59_WEN),
    .D(SPRAM_59_D),
    .Q(SPRAM_59_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_60 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_60_CLK),
    .CEN(SPRAM_60_CEN),
    .WEN(SPRAM_60_WEN),
    .D(SPRAM_60_D),
    .Q(SPRAM_60_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_61 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_61_CLK),
    .CEN(SPRAM_61_CEN),
    .WEN(SPRAM_61_WEN),
    .D(SPRAM_61_D),
    .Q(SPRAM_61_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_62 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_62_CLK),
    .CEN(SPRAM_62_CEN),
    .WEN(SPRAM_62_WEN),
    .D(SPRAM_62_D),
    .Q(SPRAM_62_Q)
  );
  SPRAM #(.DATA_WIDTH(32), .DEPTH(1), .RAM_STYLE_VAL("block")) SPRAM_63 ( // @[out_buffer.scala 46:136]
    .CLK(SPRAM_63_CLK),
    .CEN(SPRAM_63_CEN),
    .WEN(SPRAM_63_WEN),
    .D(SPRAM_63_D),
    .Q(SPRAM_63_Q)
  );
  assign io_output_to_dma_0_data = 3'h7 == counter_fix_0[2:0] ? output_data_0_7 : _GEN_20; // @[out_buffer.scala 64:{33,33}]
  assign io_output_to_dma_1_data = 3'h7 == counter_fix_1[2:0] ? output_data_1_7 : _GEN_28; // @[out_buffer.scala 64:{33,33}]
  assign io_ofm_buffer_valid_0 = counter_ch_0 > 4'h0 & ~(counter_fix_0 == counter_ch_0); // @[out_buffer.scala 51:63]
  assign io_ofm_buffer_valid_1 = counter_ch_1 > 4'h0 & ~(counter_fix_1 == counter_ch_1); // @[out_buffer.scala 51:63]
  assign SPRAM_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_D = io_sum_out_0; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_1_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_1_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_1_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_1_D = io_sum_out_1; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_2_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_2_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_2_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_2_D = io_sum_out_2; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_3_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_3_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_3_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_3_D = io_sum_out_3; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_4_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_4_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_4_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_4_D = io_sum_out_4; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_5_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_5_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_5_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_5_D = io_sum_out_5; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_6_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_6_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_6_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_6_D = io_sum_out_6; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_7_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_7_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_7_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_7_D = io_sum_out_7; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_8_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_8_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_8_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_8_D = io_sum_out_8; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_9_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_9_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_9_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_9_D = io_sum_out_9; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_10_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_10_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_10_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_10_D = io_sum_out_10; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_11_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_11_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_11_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_11_D = io_sum_out_11; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_12_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_12_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_12_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_12_D = io_sum_out_12; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_13_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_13_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_13_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_13_D = io_sum_out_13; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_14_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_14_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_14_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_14_D = io_sum_out_14; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_15_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_15_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_15_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_15_D = io_sum_out_15; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_16_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_16_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_16_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_16_D = io_sum_out_16; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_17_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_17_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_17_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_17_D = io_sum_out_17; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_18_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_18_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_18_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_18_D = io_sum_out_18; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_19_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_19_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_19_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_19_D = io_sum_out_19; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_20_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_20_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_20_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_20_D = io_sum_out_20; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_21_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_21_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_21_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_21_D = io_sum_out_21; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_22_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_22_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_22_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_22_D = io_sum_out_22; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_23_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_23_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_23_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_23_D = io_sum_out_23; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_24_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_24_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_24_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_24_D = io_sum_out_24; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_25_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_25_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_25_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_25_D = io_sum_out_25; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_26_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_26_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_26_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_26_D = io_sum_out_26; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_27_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_27_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_27_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_27_D = io_sum_out_27; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_28_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_28_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_28_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_28_D = io_sum_out_28; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_29_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_29_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_29_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_29_D = io_sum_out_29; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_30_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_30_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_30_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_30_D = io_sum_out_30; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_31_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_31_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_31_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_31_D = io_sum_out_31; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_32_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_32_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_32_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_32_D = io_sum_out_32; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_33_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_33_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_33_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_33_D = io_sum_out_33; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_34_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_34_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_34_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_34_D = io_sum_out_34; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_35_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_35_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_35_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_35_D = io_sum_out_35; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_36_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_36_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_36_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_36_D = io_sum_out_36; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_37_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_37_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_37_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_37_D = io_sum_out_37; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_38_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_38_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_38_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_38_D = io_sum_out_38; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_39_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_39_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_39_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_39_D = io_sum_out_39; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_40_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_40_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_40_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_40_D = io_sum_out_40; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_41_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_41_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_41_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_41_D = io_sum_out_41; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_42_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_42_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_42_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_42_D = io_sum_out_42; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_43_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_43_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_43_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_43_D = io_sum_out_43; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_44_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_44_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_44_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_44_D = io_sum_out_44; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_45_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_45_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_45_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_45_D = io_sum_out_45; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_46_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_46_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_46_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_46_D = io_sum_out_46; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_47_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_47_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_47_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_47_D = io_sum_out_47; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_48_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_48_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_48_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_48_D = io_sum_out_48; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_49_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_49_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_49_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_49_D = io_sum_out_49; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_50_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_50_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_50_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_50_D = io_sum_out_50; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_51_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_51_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_51_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_51_D = io_sum_out_51; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_52_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_52_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_52_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_52_D = io_sum_out_52; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_53_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_53_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_53_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_53_D = io_sum_out_53; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_54_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_54_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_54_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_54_D = io_sum_out_54; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_55_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_55_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_55_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_55_D = io_sum_out_55; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_56_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_56_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_56_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_56_D = io_sum_out_56; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_57_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_57_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_57_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_57_D = io_sum_out_57; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_58_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_58_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_58_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_58_D = io_sum_out_58; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_59_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_59_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_59_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_59_D = io_sum_out_59; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_60_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_60_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_60_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_60_D = io_sum_out_60; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_61_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_61_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_61_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_61_D = io_sum_out_61; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_62_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_62_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_62_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_62_D = io_sum_out_62; // @[out_buffer.scala 46:55 58:35]
  assign SPRAM_63_CLK = clock; // @[out_buffer.scala 46:55 54:37]
  assign SPRAM_63_CEN = 1'h0; // @[out_buffer.scala 46:55 55:37]
  assign SPRAM_63_WEN = ~io_output_data_valid; // @[out_buffer.scala 56:40]
  assign SPRAM_63_D = io_sum_out_63; // @[out_buffer.scala 46:55 58:35]
  always @(posedge clock) begin
    if (counter_ch_0 == 4'h8 & counter_ch_1 == 4'h8) begin // @[out_buffer.scala 19:50]
      counter_ch_0 <= 4'h0; // @[out_buffer.scala 23:23]
    end else if (ofm_buffer_done) begin // @[out_buffer.scala 26:38]
      counter_ch_0 <= 4'h0; // @[out_buffer.scala 29:25]
    end else if (!(~io_output_to_dma_0_valid & ~io_output_to_dma_1_valid)) begin // @[out_buffer.scala 31:73]
      if (buffer_ready & io_output_to_dma_0_valid & counter_ch_0 < 4'h8) begin // @[out_buffer.scala 36:98]
        counter_ch_0 <= _counter_ch_0_T_1; // @[out_buffer.scala 37:27]
      end
    end
    if (counter_ch_0 == 4'h8 & counter_ch_1 == 4'h8) begin // @[out_buffer.scala 19:50]
      counter_ch_1 <= 4'h0; // @[out_buffer.scala 23:23]
    end else if (ofm_buffer_done) begin // @[out_buffer.scala 26:38]
      counter_ch_1 <= 4'h0; // @[out_buffer.scala 29:25]
    end else if (!(~io_output_to_dma_0_valid & ~io_output_to_dma_1_valid)) begin // @[out_buffer.scala 31:73]
      if (buffer_ready & io_output_to_dma_1_valid & counter_ch_1 < 4'h8) begin // @[out_buffer.scala 36:98]
        counter_ch_1 <= _counter_ch_1_T_1; // @[out_buffer.scala 37:27]
      end
    end
    ofm_buffer_done <= counter_ch_0 == 4'h8 & counter_ch_1 == 4'h8 | _GEN_6; // @[out_buffer.scala 19:50 20:21]
    if (counter_ch_0 == 4'h8 & counter_ch_1 == 4'h8) begin // @[out_buffer.scala 19:50]
      buffer_ready <= 1'h0; // @[out_buffer.scala 21:18]
    end else if (!(ofm_buffer_done)) begin // @[out_buffer.scala 26:38]
      buffer_ready <= _GEN_2;
    end
    counter_fix_0 <= counter_ch_0; // @[out_buffer.scala 63:23]
    counter_fix_1 <= counter_ch_1; // @[out_buffer.scala 63:23]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  counter_ch_0 = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  counter_ch_1 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  ofm_buffer_done = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  buffer_ready = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  counter_fix_0 = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  counter_fix_1 = _RAND_5[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ConV_FSM(
  input        clock,
  input        reset,
  input        io_din_valid_ConV,
  input        io_ifm_buffer_ready,
  output [4:0] io_Current_state,
  output       io_dout_valid_ConV,
  output       io_buffer_busy
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] state; // @[ConV_FSM.scala 16:22]
  reg  buffer_busy; // @[ConV_FSM.scala 18:28]
  wire  _GEN_1 = io_din_valid_ConV & io_ifm_buffer_ready | buffer_busy; // @[ConV_FSM.scala 26:87 29:19 18:28]
  wire [4:0] _state_T_1 = state + 5'h1; // @[ConV_FSM.scala 32:20]
  wire  _GEN_3 = state < 5'h11 ? 1'h0 : 1'h1; // @[ConV_FSM.scala 19:22 34:41 38:24]
  wire  _GEN_6 = state == 5'h8 ? 1'h0 : _GEN_3; // @[ConV_FSM.scala 19:22 31:37]
  assign io_Current_state = state; // @[ConV_FSM.scala 41:20]
  assign io_dout_valid_ConV = state == 5'h0 ? 1'h0 : _GEN_6; // @[ConV_FSM.scala 19:22 25:23]
  assign io_buffer_busy = buffer_busy; // @[ConV_FSM.scala 21:24]
  always @(posedge clock) begin
    if (reset) begin // @[ConV_FSM.scala 16:22]
      state <= 5'h0; // @[ConV_FSM.scala 16:22]
    end else if (state == 5'h0) begin // @[ConV_FSM.scala 25:23]
      if (io_din_valid_ConV & io_ifm_buffer_ready) begin // @[ConV_FSM.scala 26:87]
        state <= 5'h1; // @[ConV_FSM.scala 27:13]
      end
    end else if (state == 5'h8) begin // @[ConV_FSM.scala 31:37]
      state <= _state_T_1; // @[ConV_FSM.scala 32:11]
    end else if (state < 5'h11) begin // @[ConV_FSM.scala 34:41]
      state <= _state_T_1; // @[ConV_FSM.scala 35:11]
    end else begin
      state <= 5'h0; // @[ConV_FSM.scala 37:11]
    end
    if (reset) begin // @[ConV_FSM.scala 18:28]
      buffer_busy <= 1'h0; // @[ConV_FSM.scala 18:28]
    end else if (state == 5'h0) begin // @[ConV_FSM.scala 25:23]
      buffer_busy <= _GEN_1;
    end else if (state == 5'h8) begin // @[ConV_FSM.scala 31:37]
      buffer_busy <= 1'h0; // @[ConV_FSM.scala 33:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  buffer_busy = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Mux_datainarray(
  input  [127:0] io_IN_0,
  input  [127:0] io_IN_1,
  output [127:0] io_IN_Array_0,
  output [127:0] io_IN_Array_1,
  output [127:0] io_IN_Array_2,
  output [127:0] io_IN_Array_3
);
  assign io_IN_Array_0 = io_IN_1; // @[Mux_datainarray.scala 25:84]
  assign io_IN_Array_1 = io_IN_1; // @[Mux_datainarray.scala 25:84]
  assign io_IN_Array_2 = io_IN_0; // @[Mux_datainarray.scala 25:84]
  assign io_IN_Array_3 = io_IN_0; // @[Mux_datainarray.scala 25:84]
endmodule
module line_cell(
  input          clock,
  input  [127:0] io_WL,
  input  [127:0] io_IN,
  input          io_BL,
  output         io_Vout_0,
  output         io_Vout_1,
  output         io_Vout_2,
  output         io_Vout_3,
  output         io_Vout_4,
  output         io_Vout_5,
  output         io_Vout_6,
  output         io_Vout_7,
  output         io_Vout_8,
  output         io_Vout_9,
  output         io_Vout_10,
  output         io_Vout_11,
  output         io_Vout_12,
  output         io_Vout_13,
  output         io_Vout_14,
  output         io_Vout_15,
  output         io_Vout_16,
  output         io_Vout_17,
  output         io_Vout_18,
  output         io_Vout_19,
  output         io_Vout_20,
  output         io_Vout_21,
  output         io_Vout_22,
  output         io_Vout_23,
  output         io_Vout_24,
  output         io_Vout_25,
  output         io_Vout_26,
  output         io_Vout_27,
  output         io_Vout_28,
  output         io_Vout_29,
  output         io_Vout_30,
  output         io_Vout_31,
  output         io_Vout_32,
  output         io_Vout_33,
  output         io_Vout_34,
  output         io_Vout_35,
  output         io_Vout_36,
  output         io_Vout_37,
  output         io_Vout_38,
  output         io_Vout_39,
  output         io_Vout_40,
  output         io_Vout_41,
  output         io_Vout_42,
  output         io_Vout_43,
  output         io_Vout_44,
  output         io_Vout_45,
  output         io_Vout_46,
  output         io_Vout_47,
  output         io_Vout_48,
  output         io_Vout_49,
  output         io_Vout_50,
  output         io_Vout_51,
  output         io_Vout_52,
  output         io_Vout_53,
  output         io_Vout_54,
  output         io_Vout_55,
  output         io_Vout_56,
  output         io_Vout_57,
  output         io_Vout_58,
  output         io_Vout_59,
  output         io_Vout_60,
  output         io_Vout_61,
  output         io_Vout_62,
  output         io_Vout_63,
  output         io_Vout_64,
  output         io_Vout_65,
  output         io_Vout_66,
  output         io_Vout_67,
  output         io_Vout_68,
  output         io_Vout_69,
  output         io_Vout_70,
  output         io_Vout_71,
  output         io_Vout_72,
  output         io_Vout_73,
  output         io_Vout_74,
  output         io_Vout_75,
  output         io_Vout_76,
  output         io_Vout_77,
  output         io_Vout_78,
  output         io_Vout_79,
  output         io_Vout_80,
  output         io_Vout_81,
  output         io_Vout_82,
  output         io_Vout_83,
  output         io_Vout_84,
  output         io_Vout_85,
  output         io_Vout_86,
  output         io_Vout_87,
  output         io_Vout_88,
  output         io_Vout_89,
  output         io_Vout_90,
  output         io_Vout_91,
  output         io_Vout_92,
  output         io_Vout_93,
  output         io_Vout_94,
  output         io_Vout_95,
  output         io_Vout_96,
  output         io_Vout_97,
  output         io_Vout_98,
  output         io_Vout_99,
  output         io_Vout_100,
  output         io_Vout_101,
  output         io_Vout_102,
  output         io_Vout_103,
  output         io_Vout_104,
  output         io_Vout_105,
  output         io_Vout_106,
  output         io_Vout_107,
  output         io_Vout_108,
  output         io_Vout_109,
  output         io_Vout_110,
  output         io_Vout_111,
  output         io_Vout_112,
  output         io_Vout_113,
  output         io_Vout_114,
  output         io_Vout_115,
  output         io_Vout_116,
  output         io_Vout_117,
  output         io_Vout_118,
  output         io_Vout_119,
  output         io_Vout_120,
  output         io_Vout_121,
  output         io_Vout_122,
  output         io_Vout_123,
  output         io_Vout_124,
  output         io_Vout_125,
  output         io_Vout_126,
  output         io_Vout_127
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
  reg [31:0] _RAND_228;
  reg [31:0] _RAND_229;
  reg [31:0] _RAND_230;
  reg [31:0] _RAND_231;
  reg [31:0] _RAND_232;
  reg [31:0] _RAND_233;
  reg [31:0] _RAND_234;
  reg [31:0] _RAND_235;
  reg [31:0] _RAND_236;
  reg [31:0] _RAND_237;
  reg [31:0] _RAND_238;
  reg [31:0] _RAND_239;
  reg [31:0] _RAND_240;
  reg [31:0] _RAND_241;
  reg [31:0] _RAND_242;
  reg [31:0] _RAND_243;
  reg [31:0] _RAND_244;
  reg [31:0] _RAND_245;
  reg [31:0] _RAND_246;
  reg [31:0] _RAND_247;
  reg [31:0] _RAND_248;
  reg [31:0] _RAND_249;
  reg [31:0] _RAND_250;
  reg [31:0] _RAND_251;
  reg [31:0] _RAND_252;
  reg [31:0] _RAND_253;
  reg [31:0] _RAND_254;
  reg [31:0] _RAND_255;
`endif // RANDOMIZE_REG_INIT
  reg  data_0; // @[line_cell.scala 17:17]
  reg  data_1; // @[line_cell.scala 17:17]
  reg  data_2; // @[line_cell.scala 17:17]
  reg  data_3; // @[line_cell.scala 17:17]
  reg  data_4; // @[line_cell.scala 17:17]
  reg  data_5; // @[line_cell.scala 17:17]
  reg  data_6; // @[line_cell.scala 17:17]
  reg  data_7; // @[line_cell.scala 17:17]
  reg  data_8; // @[line_cell.scala 17:17]
  reg  data_9; // @[line_cell.scala 17:17]
  reg  data_10; // @[line_cell.scala 17:17]
  reg  data_11; // @[line_cell.scala 17:17]
  reg  data_12; // @[line_cell.scala 17:17]
  reg  data_13; // @[line_cell.scala 17:17]
  reg  data_14; // @[line_cell.scala 17:17]
  reg  data_15; // @[line_cell.scala 17:17]
  reg  data_16; // @[line_cell.scala 17:17]
  reg  data_17; // @[line_cell.scala 17:17]
  reg  data_18; // @[line_cell.scala 17:17]
  reg  data_19; // @[line_cell.scala 17:17]
  reg  data_20; // @[line_cell.scala 17:17]
  reg  data_21; // @[line_cell.scala 17:17]
  reg  data_22; // @[line_cell.scala 17:17]
  reg  data_23; // @[line_cell.scala 17:17]
  reg  data_24; // @[line_cell.scala 17:17]
  reg  data_25; // @[line_cell.scala 17:17]
  reg  data_26; // @[line_cell.scala 17:17]
  reg  data_27; // @[line_cell.scala 17:17]
  reg  data_28; // @[line_cell.scala 17:17]
  reg  data_29; // @[line_cell.scala 17:17]
  reg  data_30; // @[line_cell.scala 17:17]
  reg  data_31; // @[line_cell.scala 17:17]
  reg  data_32; // @[line_cell.scala 17:17]
  reg  data_33; // @[line_cell.scala 17:17]
  reg  data_34; // @[line_cell.scala 17:17]
  reg  data_35; // @[line_cell.scala 17:17]
  reg  data_36; // @[line_cell.scala 17:17]
  reg  data_37; // @[line_cell.scala 17:17]
  reg  data_38; // @[line_cell.scala 17:17]
  reg  data_39; // @[line_cell.scala 17:17]
  reg  data_40; // @[line_cell.scala 17:17]
  reg  data_41; // @[line_cell.scala 17:17]
  reg  data_42; // @[line_cell.scala 17:17]
  reg  data_43; // @[line_cell.scala 17:17]
  reg  data_44; // @[line_cell.scala 17:17]
  reg  data_45; // @[line_cell.scala 17:17]
  reg  data_46; // @[line_cell.scala 17:17]
  reg  data_47; // @[line_cell.scala 17:17]
  reg  data_48; // @[line_cell.scala 17:17]
  reg  data_49; // @[line_cell.scala 17:17]
  reg  data_50; // @[line_cell.scala 17:17]
  reg  data_51; // @[line_cell.scala 17:17]
  reg  data_52; // @[line_cell.scala 17:17]
  reg  data_53; // @[line_cell.scala 17:17]
  reg  data_54; // @[line_cell.scala 17:17]
  reg  data_55; // @[line_cell.scala 17:17]
  reg  data_56; // @[line_cell.scala 17:17]
  reg  data_57; // @[line_cell.scala 17:17]
  reg  data_58; // @[line_cell.scala 17:17]
  reg  data_59; // @[line_cell.scala 17:17]
  reg  data_60; // @[line_cell.scala 17:17]
  reg  data_61; // @[line_cell.scala 17:17]
  reg  data_62; // @[line_cell.scala 17:17]
  reg  data_63; // @[line_cell.scala 17:17]
  reg  data_64; // @[line_cell.scala 17:17]
  reg  data_65; // @[line_cell.scala 17:17]
  reg  data_66; // @[line_cell.scala 17:17]
  reg  data_67; // @[line_cell.scala 17:17]
  reg  data_68; // @[line_cell.scala 17:17]
  reg  data_69; // @[line_cell.scala 17:17]
  reg  data_70; // @[line_cell.scala 17:17]
  reg  data_71; // @[line_cell.scala 17:17]
  reg  data_72; // @[line_cell.scala 17:17]
  reg  data_73; // @[line_cell.scala 17:17]
  reg  data_74; // @[line_cell.scala 17:17]
  reg  data_75; // @[line_cell.scala 17:17]
  reg  data_76; // @[line_cell.scala 17:17]
  reg  data_77; // @[line_cell.scala 17:17]
  reg  data_78; // @[line_cell.scala 17:17]
  reg  data_79; // @[line_cell.scala 17:17]
  reg  data_80; // @[line_cell.scala 17:17]
  reg  data_81; // @[line_cell.scala 17:17]
  reg  data_82; // @[line_cell.scala 17:17]
  reg  data_83; // @[line_cell.scala 17:17]
  reg  data_84; // @[line_cell.scala 17:17]
  reg  data_85; // @[line_cell.scala 17:17]
  reg  data_86; // @[line_cell.scala 17:17]
  reg  data_87; // @[line_cell.scala 17:17]
  reg  data_88; // @[line_cell.scala 17:17]
  reg  data_89; // @[line_cell.scala 17:17]
  reg  data_90; // @[line_cell.scala 17:17]
  reg  data_91; // @[line_cell.scala 17:17]
  reg  data_92; // @[line_cell.scala 17:17]
  reg  data_93; // @[line_cell.scala 17:17]
  reg  data_94; // @[line_cell.scala 17:17]
  reg  data_95; // @[line_cell.scala 17:17]
  reg  data_96; // @[line_cell.scala 17:17]
  reg  data_97; // @[line_cell.scala 17:17]
  reg  data_98; // @[line_cell.scala 17:17]
  reg  data_99; // @[line_cell.scala 17:17]
  reg  data_100; // @[line_cell.scala 17:17]
  reg  data_101; // @[line_cell.scala 17:17]
  reg  data_102; // @[line_cell.scala 17:17]
  reg  data_103; // @[line_cell.scala 17:17]
  reg  data_104; // @[line_cell.scala 17:17]
  reg  data_105; // @[line_cell.scala 17:17]
  reg  data_106; // @[line_cell.scala 17:17]
  reg  data_107; // @[line_cell.scala 17:17]
  reg  data_108; // @[line_cell.scala 17:17]
  reg  data_109; // @[line_cell.scala 17:17]
  reg  data_110; // @[line_cell.scala 17:17]
  reg  data_111; // @[line_cell.scala 17:17]
  reg  data_112; // @[line_cell.scala 17:17]
  reg  data_113; // @[line_cell.scala 17:17]
  reg  data_114; // @[line_cell.scala 17:17]
  reg  data_115; // @[line_cell.scala 17:17]
  reg  data_116; // @[line_cell.scala 17:17]
  reg  data_117; // @[line_cell.scala 17:17]
  reg  data_118; // @[line_cell.scala 17:17]
  reg  data_119; // @[line_cell.scala 17:17]
  reg  data_120; // @[line_cell.scala 17:17]
  reg  data_121; // @[line_cell.scala 17:17]
  reg  data_122; // @[line_cell.scala 17:17]
  reg  data_123; // @[line_cell.scala 17:17]
  reg  data_124; // @[line_cell.scala 17:17]
  reg  data_125; // @[line_cell.scala 17:17]
  reg  data_126; // @[line_cell.scala 17:17]
  reg  data_127; // @[line_cell.scala 17:17]
  reg  data_out_0; // @[line_cell.scala 19:21]
  reg  data_out_1; // @[line_cell.scala 19:21]
  reg  data_out_2; // @[line_cell.scala 19:21]
  reg  data_out_3; // @[line_cell.scala 19:21]
  reg  data_out_4; // @[line_cell.scala 19:21]
  reg  data_out_5; // @[line_cell.scala 19:21]
  reg  data_out_6; // @[line_cell.scala 19:21]
  reg  data_out_7; // @[line_cell.scala 19:21]
  reg  data_out_8; // @[line_cell.scala 19:21]
  reg  data_out_9; // @[line_cell.scala 19:21]
  reg  data_out_10; // @[line_cell.scala 19:21]
  reg  data_out_11; // @[line_cell.scala 19:21]
  reg  data_out_12; // @[line_cell.scala 19:21]
  reg  data_out_13; // @[line_cell.scala 19:21]
  reg  data_out_14; // @[line_cell.scala 19:21]
  reg  data_out_15; // @[line_cell.scala 19:21]
  reg  data_out_16; // @[line_cell.scala 19:21]
  reg  data_out_17; // @[line_cell.scala 19:21]
  reg  data_out_18; // @[line_cell.scala 19:21]
  reg  data_out_19; // @[line_cell.scala 19:21]
  reg  data_out_20; // @[line_cell.scala 19:21]
  reg  data_out_21; // @[line_cell.scala 19:21]
  reg  data_out_22; // @[line_cell.scala 19:21]
  reg  data_out_23; // @[line_cell.scala 19:21]
  reg  data_out_24; // @[line_cell.scala 19:21]
  reg  data_out_25; // @[line_cell.scala 19:21]
  reg  data_out_26; // @[line_cell.scala 19:21]
  reg  data_out_27; // @[line_cell.scala 19:21]
  reg  data_out_28; // @[line_cell.scala 19:21]
  reg  data_out_29; // @[line_cell.scala 19:21]
  reg  data_out_30; // @[line_cell.scala 19:21]
  reg  data_out_31; // @[line_cell.scala 19:21]
  reg  data_out_32; // @[line_cell.scala 19:21]
  reg  data_out_33; // @[line_cell.scala 19:21]
  reg  data_out_34; // @[line_cell.scala 19:21]
  reg  data_out_35; // @[line_cell.scala 19:21]
  reg  data_out_36; // @[line_cell.scala 19:21]
  reg  data_out_37; // @[line_cell.scala 19:21]
  reg  data_out_38; // @[line_cell.scala 19:21]
  reg  data_out_39; // @[line_cell.scala 19:21]
  reg  data_out_40; // @[line_cell.scala 19:21]
  reg  data_out_41; // @[line_cell.scala 19:21]
  reg  data_out_42; // @[line_cell.scala 19:21]
  reg  data_out_43; // @[line_cell.scala 19:21]
  reg  data_out_44; // @[line_cell.scala 19:21]
  reg  data_out_45; // @[line_cell.scala 19:21]
  reg  data_out_46; // @[line_cell.scala 19:21]
  reg  data_out_47; // @[line_cell.scala 19:21]
  reg  data_out_48; // @[line_cell.scala 19:21]
  reg  data_out_49; // @[line_cell.scala 19:21]
  reg  data_out_50; // @[line_cell.scala 19:21]
  reg  data_out_51; // @[line_cell.scala 19:21]
  reg  data_out_52; // @[line_cell.scala 19:21]
  reg  data_out_53; // @[line_cell.scala 19:21]
  reg  data_out_54; // @[line_cell.scala 19:21]
  reg  data_out_55; // @[line_cell.scala 19:21]
  reg  data_out_56; // @[line_cell.scala 19:21]
  reg  data_out_57; // @[line_cell.scala 19:21]
  reg  data_out_58; // @[line_cell.scala 19:21]
  reg  data_out_59; // @[line_cell.scala 19:21]
  reg  data_out_60; // @[line_cell.scala 19:21]
  reg  data_out_61; // @[line_cell.scala 19:21]
  reg  data_out_62; // @[line_cell.scala 19:21]
  reg  data_out_63; // @[line_cell.scala 19:21]
  reg  data_out_64; // @[line_cell.scala 19:21]
  reg  data_out_65; // @[line_cell.scala 19:21]
  reg  data_out_66; // @[line_cell.scala 19:21]
  reg  data_out_67; // @[line_cell.scala 19:21]
  reg  data_out_68; // @[line_cell.scala 19:21]
  reg  data_out_69; // @[line_cell.scala 19:21]
  reg  data_out_70; // @[line_cell.scala 19:21]
  reg  data_out_71; // @[line_cell.scala 19:21]
  reg  data_out_72; // @[line_cell.scala 19:21]
  reg  data_out_73; // @[line_cell.scala 19:21]
  reg  data_out_74; // @[line_cell.scala 19:21]
  reg  data_out_75; // @[line_cell.scala 19:21]
  reg  data_out_76; // @[line_cell.scala 19:21]
  reg  data_out_77; // @[line_cell.scala 19:21]
  reg  data_out_78; // @[line_cell.scala 19:21]
  reg  data_out_79; // @[line_cell.scala 19:21]
  reg  data_out_80; // @[line_cell.scala 19:21]
  reg  data_out_81; // @[line_cell.scala 19:21]
  reg  data_out_82; // @[line_cell.scala 19:21]
  reg  data_out_83; // @[line_cell.scala 19:21]
  reg  data_out_84; // @[line_cell.scala 19:21]
  reg  data_out_85; // @[line_cell.scala 19:21]
  reg  data_out_86; // @[line_cell.scala 19:21]
  reg  data_out_87; // @[line_cell.scala 19:21]
  reg  data_out_88; // @[line_cell.scala 19:21]
  reg  data_out_89; // @[line_cell.scala 19:21]
  reg  data_out_90; // @[line_cell.scala 19:21]
  reg  data_out_91; // @[line_cell.scala 19:21]
  reg  data_out_92; // @[line_cell.scala 19:21]
  reg  data_out_93; // @[line_cell.scala 19:21]
  reg  data_out_94; // @[line_cell.scala 19:21]
  reg  data_out_95; // @[line_cell.scala 19:21]
  reg  data_out_96; // @[line_cell.scala 19:21]
  reg  data_out_97; // @[line_cell.scala 19:21]
  reg  data_out_98; // @[line_cell.scala 19:21]
  reg  data_out_99; // @[line_cell.scala 19:21]
  reg  data_out_100; // @[line_cell.scala 19:21]
  reg  data_out_101; // @[line_cell.scala 19:21]
  reg  data_out_102; // @[line_cell.scala 19:21]
  reg  data_out_103; // @[line_cell.scala 19:21]
  reg  data_out_104; // @[line_cell.scala 19:21]
  reg  data_out_105; // @[line_cell.scala 19:21]
  reg  data_out_106; // @[line_cell.scala 19:21]
  reg  data_out_107; // @[line_cell.scala 19:21]
  reg  data_out_108; // @[line_cell.scala 19:21]
  reg  data_out_109; // @[line_cell.scala 19:21]
  reg  data_out_110; // @[line_cell.scala 19:21]
  reg  data_out_111; // @[line_cell.scala 19:21]
  reg  data_out_112; // @[line_cell.scala 19:21]
  reg  data_out_113; // @[line_cell.scala 19:21]
  reg  data_out_114; // @[line_cell.scala 19:21]
  reg  data_out_115; // @[line_cell.scala 19:21]
  reg  data_out_116; // @[line_cell.scala 19:21]
  reg  data_out_117; // @[line_cell.scala 19:21]
  reg  data_out_118; // @[line_cell.scala 19:21]
  reg  data_out_119; // @[line_cell.scala 19:21]
  reg  data_out_120; // @[line_cell.scala 19:21]
  reg  data_out_121; // @[line_cell.scala 19:21]
  reg  data_out_122; // @[line_cell.scala 19:21]
  reg  data_out_123; // @[line_cell.scala 19:21]
  reg  data_out_124; // @[line_cell.scala 19:21]
  reg  data_out_125; // @[line_cell.scala 19:21]
  reg  data_out_126; // @[line_cell.scala 19:21]
  reg  data_out_127; // @[line_cell.scala 19:21]
  assign io_Vout_0 = io_IN[0] & data_out_0; // @[line_cell.scala 29:28]
  assign io_Vout_1 = io_IN[1] & data_out_1; // @[line_cell.scala 29:28]
  assign io_Vout_2 = io_IN[2] & data_out_2; // @[line_cell.scala 29:28]
  assign io_Vout_3 = io_IN[3] & data_out_3; // @[line_cell.scala 29:28]
  assign io_Vout_4 = io_IN[4] & data_out_4; // @[line_cell.scala 29:28]
  assign io_Vout_5 = io_IN[5] & data_out_5; // @[line_cell.scala 29:28]
  assign io_Vout_6 = io_IN[6] & data_out_6; // @[line_cell.scala 29:28]
  assign io_Vout_7 = io_IN[7] & data_out_7; // @[line_cell.scala 29:28]
  assign io_Vout_8 = io_IN[8] & data_out_8; // @[line_cell.scala 29:28]
  assign io_Vout_9 = io_IN[9] & data_out_9; // @[line_cell.scala 29:28]
  assign io_Vout_10 = io_IN[10] & data_out_10; // @[line_cell.scala 29:28]
  assign io_Vout_11 = io_IN[11] & data_out_11; // @[line_cell.scala 29:28]
  assign io_Vout_12 = io_IN[12] & data_out_12; // @[line_cell.scala 29:28]
  assign io_Vout_13 = io_IN[13] & data_out_13; // @[line_cell.scala 29:28]
  assign io_Vout_14 = io_IN[14] & data_out_14; // @[line_cell.scala 29:28]
  assign io_Vout_15 = io_IN[15] & data_out_15; // @[line_cell.scala 29:28]
  assign io_Vout_16 = io_IN[16] & data_out_16; // @[line_cell.scala 29:28]
  assign io_Vout_17 = io_IN[17] & data_out_17; // @[line_cell.scala 29:28]
  assign io_Vout_18 = io_IN[18] & data_out_18; // @[line_cell.scala 29:28]
  assign io_Vout_19 = io_IN[19] & data_out_19; // @[line_cell.scala 29:28]
  assign io_Vout_20 = io_IN[20] & data_out_20; // @[line_cell.scala 29:28]
  assign io_Vout_21 = io_IN[21] & data_out_21; // @[line_cell.scala 29:28]
  assign io_Vout_22 = io_IN[22] & data_out_22; // @[line_cell.scala 29:28]
  assign io_Vout_23 = io_IN[23] & data_out_23; // @[line_cell.scala 29:28]
  assign io_Vout_24 = io_IN[24] & data_out_24; // @[line_cell.scala 29:28]
  assign io_Vout_25 = io_IN[25] & data_out_25; // @[line_cell.scala 29:28]
  assign io_Vout_26 = io_IN[26] & data_out_26; // @[line_cell.scala 29:28]
  assign io_Vout_27 = io_IN[27] & data_out_27; // @[line_cell.scala 29:28]
  assign io_Vout_28 = io_IN[28] & data_out_28; // @[line_cell.scala 29:28]
  assign io_Vout_29 = io_IN[29] & data_out_29; // @[line_cell.scala 29:28]
  assign io_Vout_30 = io_IN[30] & data_out_30; // @[line_cell.scala 29:28]
  assign io_Vout_31 = io_IN[31] & data_out_31; // @[line_cell.scala 29:28]
  assign io_Vout_32 = io_IN[32] & data_out_32; // @[line_cell.scala 29:28]
  assign io_Vout_33 = io_IN[33] & data_out_33; // @[line_cell.scala 29:28]
  assign io_Vout_34 = io_IN[34] & data_out_34; // @[line_cell.scala 29:28]
  assign io_Vout_35 = io_IN[35] & data_out_35; // @[line_cell.scala 29:28]
  assign io_Vout_36 = io_IN[36] & data_out_36; // @[line_cell.scala 29:28]
  assign io_Vout_37 = io_IN[37] & data_out_37; // @[line_cell.scala 29:28]
  assign io_Vout_38 = io_IN[38] & data_out_38; // @[line_cell.scala 29:28]
  assign io_Vout_39 = io_IN[39] & data_out_39; // @[line_cell.scala 29:28]
  assign io_Vout_40 = io_IN[40] & data_out_40; // @[line_cell.scala 29:28]
  assign io_Vout_41 = io_IN[41] & data_out_41; // @[line_cell.scala 29:28]
  assign io_Vout_42 = io_IN[42] & data_out_42; // @[line_cell.scala 29:28]
  assign io_Vout_43 = io_IN[43] & data_out_43; // @[line_cell.scala 29:28]
  assign io_Vout_44 = io_IN[44] & data_out_44; // @[line_cell.scala 29:28]
  assign io_Vout_45 = io_IN[45] & data_out_45; // @[line_cell.scala 29:28]
  assign io_Vout_46 = io_IN[46] & data_out_46; // @[line_cell.scala 29:28]
  assign io_Vout_47 = io_IN[47] & data_out_47; // @[line_cell.scala 29:28]
  assign io_Vout_48 = io_IN[48] & data_out_48; // @[line_cell.scala 29:28]
  assign io_Vout_49 = io_IN[49] & data_out_49; // @[line_cell.scala 29:28]
  assign io_Vout_50 = io_IN[50] & data_out_50; // @[line_cell.scala 29:28]
  assign io_Vout_51 = io_IN[51] & data_out_51; // @[line_cell.scala 29:28]
  assign io_Vout_52 = io_IN[52] & data_out_52; // @[line_cell.scala 29:28]
  assign io_Vout_53 = io_IN[53] & data_out_53; // @[line_cell.scala 29:28]
  assign io_Vout_54 = io_IN[54] & data_out_54; // @[line_cell.scala 29:28]
  assign io_Vout_55 = io_IN[55] & data_out_55; // @[line_cell.scala 29:28]
  assign io_Vout_56 = io_IN[56] & data_out_56; // @[line_cell.scala 29:28]
  assign io_Vout_57 = io_IN[57] & data_out_57; // @[line_cell.scala 29:28]
  assign io_Vout_58 = io_IN[58] & data_out_58; // @[line_cell.scala 29:28]
  assign io_Vout_59 = io_IN[59] & data_out_59; // @[line_cell.scala 29:28]
  assign io_Vout_60 = io_IN[60] & data_out_60; // @[line_cell.scala 29:28]
  assign io_Vout_61 = io_IN[61] & data_out_61; // @[line_cell.scala 29:28]
  assign io_Vout_62 = io_IN[62] & data_out_62; // @[line_cell.scala 29:28]
  assign io_Vout_63 = io_IN[63] & data_out_63; // @[line_cell.scala 29:28]
  assign io_Vout_64 = io_IN[64] & data_out_64; // @[line_cell.scala 29:28]
  assign io_Vout_65 = io_IN[65] & data_out_65; // @[line_cell.scala 29:28]
  assign io_Vout_66 = io_IN[66] & data_out_66; // @[line_cell.scala 29:28]
  assign io_Vout_67 = io_IN[67] & data_out_67; // @[line_cell.scala 29:28]
  assign io_Vout_68 = io_IN[68] & data_out_68; // @[line_cell.scala 29:28]
  assign io_Vout_69 = io_IN[69] & data_out_69; // @[line_cell.scala 29:28]
  assign io_Vout_70 = io_IN[70] & data_out_70; // @[line_cell.scala 29:28]
  assign io_Vout_71 = io_IN[71] & data_out_71; // @[line_cell.scala 29:28]
  assign io_Vout_72 = io_IN[72] & data_out_72; // @[line_cell.scala 29:28]
  assign io_Vout_73 = io_IN[73] & data_out_73; // @[line_cell.scala 29:28]
  assign io_Vout_74 = io_IN[74] & data_out_74; // @[line_cell.scala 29:28]
  assign io_Vout_75 = io_IN[75] & data_out_75; // @[line_cell.scala 29:28]
  assign io_Vout_76 = io_IN[76] & data_out_76; // @[line_cell.scala 29:28]
  assign io_Vout_77 = io_IN[77] & data_out_77; // @[line_cell.scala 29:28]
  assign io_Vout_78 = io_IN[78] & data_out_78; // @[line_cell.scala 29:28]
  assign io_Vout_79 = io_IN[79] & data_out_79; // @[line_cell.scala 29:28]
  assign io_Vout_80 = io_IN[80] & data_out_80; // @[line_cell.scala 29:28]
  assign io_Vout_81 = io_IN[81] & data_out_81; // @[line_cell.scala 29:28]
  assign io_Vout_82 = io_IN[82] & data_out_82; // @[line_cell.scala 29:28]
  assign io_Vout_83 = io_IN[83] & data_out_83; // @[line_cell.scala 29:28]
  assign io_Vout_84 = io_IN[84] & data_out_84; // @[line_cell.scala 29:28]
  assign io_Vout_85 = io_IN[85] & data_out_85; // @[line_cell.scala 29:28]
  assign io_Vout_86 = io_IN[86] & data_out_86; // @[line_cell.scala 29:28]
  assign io_Vout_87 = io_IN[87] & data_out_87; // @[line_cell.scala 29:28]
  assign io_Vout_88 = io_IN[88] & data_out_88; // @[line_cell.scala 29:28]
  assign io_Vout_89 = io_IN[89] & data_out_89; // @[line_cell.scala 29:28]
  assign io_Vout_90 = io_IN[90] & data_out_90; // @[line_cell.scala 29:28]
  assign io_Vout_91 = io_IN[91] & data_out_91; // @[line_cell.scala 29:28]
  assign io_Vout_92 = io_IN[92] & data_out_92; // @[line_cell.scala 29:28]
  assign io_Vout_93 = io_IN[93] & data_out_93; // @[line_cell.scala 29:28]
  assign io_Vout_94 = io_IN[94] & data_out_94; // @[line_cell.scala 29:28]
  assign io_Vout_95 = io_IN[95] & data_out_95; // @[line_cell.scala 29:28]
  assign io_Vout_96 = io_IN[96] & data_out_96; // @[line_cell.scala 29:28]
  assign io_Vout_97 = io_IN[97] & data_out_97; // @[line_cell.scala 29:28]
  assign io_Vout_98 = io_IN[98] & data_out_98; // @[line_cell.scala 29:28]
  assign io_Vout_99 = io_IN[99] & data_out_99; // @[line_cell.scala 29:28]
  assign io_Vout_100 = io_IN[100] & data_out_100; // @[line_cell.scala 29:28]
  assign io_Vout_101 = io_IN[101] & data_out_101; // @[line_cell.scala 29:28]
  assign io_Vout_102 = io_IN[102] & data_out_102; // @[line_cell.scala 29:28]
  assign io_Vout_103 = io_IN[103] & data_out_103; // @[line_cell.scala 29:28]
  assign io_Vout_104 = io_IN[104] & data_out_104; // @[line_cell.scala 29:28]
  assign io_Vout_105 = io_IN[105] & data_out_105; // @[line_cell.scala 29:28]
  assign io_Vout_106 = io_IN[106] & data_out_106; // @[line_cell.scala 29:28]
  assign io_Vout_107 = io_IN[107] & data_out_107; // @[line_cell.scala 29:28]
  assign io_Vout_108 = io_IN[108] & data_out_108; // @[line_cell.scala 29:28]
  assign io_Vout_109 = io_IN[109] & data_out_109; // @[line_cell.scala 29:28]
  assign io_Vout_110 = io_IN[110] & data_out_110; // @[line_cell.scala 29:28]
  assign io_Vout_111 = io_IN[111] & data_out_111; // @[line_cell.scala 29:28]
  assign io_Vout_112 = io_IN[112] & data_out_112; // @[line_cell.scala 29:28]
  assign io_Vout_113 = io_IN[113] & data_out_113; // @[line_cell.scala 29:28]
  assign io_Vout_114 = io_IN[114] & data_out_114; // @[line_cell.scala 29:28]
  assign io_Vout_115 = io_IN[115] & data_out_115; // @[line_cell.scala 29:28]
  assign io_Vout_116 = io_IN[116] & data_out_116; // @[line_cell.scala 29:28]
  assign io_Vout_117 = io_IN[117] & data_out_117; // @[line_cell.scala 29:28]
  assign io_Vout_118 = io_IN[118] & data_out_118; // @[line_cell.scala 29:28]
  assign io_Vout_119 = io_IN[119] & data_out_119; // @[line_cell.scala 29:28]
  assign io_Vout_120 = io_IN[120] & data_out_120; // @[line_cell.scala 29:28]
  assign io_Vout_121 = io_IN[121] & data_out_121; // @[line_cell.scala 29:28]
  assign io_Vout_122 = io_IN[122] & data_out_122; // @[line_cell.scala 29:28]
  assign io_Vout_123 = io_IN[123] & data_out_123; // @[line_cell.scala 29:28]
  assign io_Vout_124 = io_IN[124] & data_out_124; // @[line_cell.scala 29:28]
  assign io_Vout_125 = io_IN[125] & data_out_125; // @[line_cell.scala 29:28]
  assign io_Vout_126 = io_IN[126] & data_out_126; // @[line_cell.scala 29:28]
  assign io_Vout_127 = io_IN[127] & data_out_127; // @[line_cell.scala 29:28]
  always @(posedge clock) begin
    if (io_WL[0]) begin // @[line_cell.scala 22:20]
      data_0 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[1]) begin // @[line_cell.scala 22:20]
      data_1 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[2]) begin // @[line_cell.scala 22:20]
      data_2 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[3]) begin // @[line_cell.scala 22:20]
      data_3 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[4]) begin // @[line_cell.scala 22:20]
      data_4 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[5]) begin // @[line_cell.scala 22:20]
      data_5 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[6]) begin // @[line_cell.scala 22:20]
      data_6 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[7]) begin // @[line_cell.scala 22:20]
      data_7 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[8]) begin // @[line_cell.scala 22:20]
      data_8 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[9]) begin // @[line_cell.scala 22:20]
      data_9 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[10]) begin // @[line_cell.scala 22:20]
      data_10 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[11]) begin // @[line_cell.scala 22:20]
      data_11 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[12]) begin // @[line_cell.scala 22:20]
      data_12 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[13]) begin // @[line_cell.scala 22:20]
      data_13 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[14]) begin // @[line_cell.scala 22:20]
      data_14 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[15]) begin // @[line_cell.scala 22:20]
      data_15 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[16]) begin // @[line_cell.scala 22:20]
      data_16 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[17]) begin // @[line_cell.scala 22:20]
      data_17 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[18]) begin // @[line_cell.scala 22:20]
      data_18 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[19]) begin // @[line_cell.scala 22:20]
      data_19 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[20]) begin // @[line_cell.scala 22:20]
      data_20 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[21]) begin // @[line_cell.scala 22:20]
      data_21 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[22]) begin // @[line_cell.scala 22:20]
      data_22 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[23]) begin // @[line_cell.scala 22:20]
      data_23 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[24]) begin // @[line_cell.scala 22:20]
      data_24 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[25]) begin // @[line_cell.scala 22:20]
      data_25 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[26]) begin // @[line_cell.scala 22:20]
      data_26 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[27]) begin // @[line_cell.scala 22:20]
      data_27 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[28]) begin // @[line_cell.scala 22:20]
      data_28 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[29]) begin // @[line_cell.scala 22:20]
      data_29 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[30]) begin // @[line_cell.scala 22:20]
      data_30 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[31]) begin // @[line_cell.scala 22:20]
      data_31 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[32]) begin // @[line_cell.scala 22:20]
      data_32 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[33]) begin // @[line_cell.scala 22:20]
      data_33 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[34]) begin // @[line_cell.scala 22:20]
      data_34 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[35]) begin // @[line_cell.scala 22:20]
      data_35 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[36]) begin // @[line_cell.scala 22:20]
      data_36 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[37]) begin // @[line_cell.scala 22:20]
      data_37 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[38]) begin // @[line_cell.scala 22:20]
      data_38 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[39]) begin // @[line_cell.scala 22:20]
      data_39 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[40]) begin // @[line_cell.scala 22:20]
      data_40 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[41]) begin // @[line_cell.scala 22:20]
      data_41 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[42]) begin // @[line_cell.scala 22:20]
      data_42 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[43]) begin // @[line_cell.scala 22:20]
      data_43 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[44]) begin // @[line_cell.scala 22:20]
      data_44 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[45]) begin // @[line_cell.scala 22:20]
      data_45 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[46]) begin // @[line_cell.scala 22:20]
      data_46 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[47]) begin // @[line_cell.scala 22:20]
      data_47 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[48]) begin // @[line_cell.scala 22:20]
      data_48 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[49]) begin // @[line_cell.scala 22:20]
      data_49 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[50]) begin // @[line_cell.scala 22:20]
      data_50 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[51]) begin // @[line_cell.scala 22:20]
      data_51 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[52]) begin // @[line_cell.scala 22:20]
      data_52 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[53]) begin // @[line_cell.scala 22:20]
      data_53 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[54]) begin // @[line_cell.scala 22:20]
      data_54 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[55]) begin // @[line_cell.scala 22:20]
      data_55 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[56]) begin // @[line_cell.scala 22:20]
      data_56 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[57]) begin // @[line_cell.scala 22:20]
      data_57 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[58]) begin // @[line_cell.scala 22:20]
      data_58 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[59]) begin // @[line_cell.scala 22:20]
      data_59 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[60]) begin // @[line_cell.scala 22:20]
      data_60 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[61]) begin // @[line_cell.scala 22:20]
      data_61 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[62]) begin // @[line_cell.scala 22:20]
      data_62 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[63]) begin // @[line_cell.scala 22:20]
      data_63 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[64]) begin // @[line_cell.scala 22:20]
      data_64 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[65]) begin // @[line_cell.scala 22:20]
      data_65 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[66]) begin // @[line_cell.scala 22:20]
      data_66 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[67]) begin // @[line_cell.scala 22:20]
      data_67 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[68]) begin // @[line_cell.scala 22:20]
      data_68 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[69]) begin // @[line_cell.scala 22:20]
      data_69 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[70]) begin // @[line_cell.scala 22:20]
      data_70 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[71]) begin // @[line_cell.scala 22:20]
      data_71 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[72]) begin // @[line_cell.scala 22:20]
      data_72 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[73]) begin // @[line_cell.scala 22:20]
      data_73 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[74]) begin // @[line_cell.scala 22:20]
      data_74 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[75]) begin // @[line_cell.scala 22:20]
      data_75 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[76]) begin // @[line_cell.scala 22:20]
      data_76 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[77]) begin // @[line_cell.scala 22:20]
      data_77 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[78]) begin // @[line_cell.scala 22:20]
      data_78 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[79]) begin // @[line_cell.scala 22:20]
      data_79 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[80]) begin // @[line_cell.scala 22:20]
      data_80 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[81]) begin // @[line_cell.scala 22:20]
      data_81 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[82]) begin // @[line_cell.scala 22:20]
      data_82 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[83]) begin // @[line_cell.scala 22:20]
      data_83 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[84]) begin // @[line_cell.scala 22:20]
      data_84 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[85]) begin // @[line_cell.scala 22:20]
      data_85 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[86]) begin // @[line_cell.scala 22:20]
      data_86 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[87]) begin // @[line_cell.scala 22:20]
      data_87 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[88]) begin // @[line_cell.scala 22:20]
      data_88 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[89]) begin // @[line_cell.scala 22:20]
      data_89 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[90]) begin // @[line_cell.scala 22:20]
      data_90 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[91]) begin // @[line_cell.scala 22:20]
      data_91 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[92]) begin // @[line_cell.scala 22:20]
      data_92 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[93]) begin // @[line_cell.scala 22:20]
      data_93 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[94]) begin // @[line_cell.scala 22:20]
      data_94 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[95]) begin // @[line_cell.scala 22:20]
      data_95 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[96]) begin // @[line_cell.scala 22:20]
      data_96 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[97]) begin // @[line_cell.scala 22:20]
      data_97 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[98]) begin // @[line_cell.scala 22:20]
      data_98 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[99]) begin // @[line_cell.scala 22:20]
      data_99 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[100]) begin // @[line_cell.scala 22:20]
      data_100 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[101]) begin // @[line_cell.scala 22:20]
      data_101 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[102]) begin // @[line_cell.scala 22:20]
      data_102 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[103]) begin // @[line_cell.scala 22:20]
      data_103 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[104]) begin // @[line_cell.scala 22:20]
      data_104 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[105]) begin // @[line_cell.scala 22:20]
      data_105 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[106]) begin // @[line_cell.scala 22:20]
      data_106 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[107]) begin // @[line_cell.scala 22:20]
      data_107 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[108]) begin // @[line_cell.scala 22:20]
      data_108 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[109]) begin // @[line_cell.scala 22:20]
      data_109 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[110]) begin // @[line_cell.scala 22:20]
      data_110 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[111]) begin // @[line_cell.scala 22:20]
      data_111 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[112]) begin // @[line_cell.scala 22:20]
      data_112 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[113]) begin // @[line_cell.scala 22:20]
      data_113 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[114]) begin // @[line_cell.scala 22:20]
      data_114 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[115]) begin // @[line_cell.scala 22:20]
      data_115 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[116]) begin // @[line_cell.scala 22:20]
      data_116 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[117]) begin // @[line_cell.scala 22:20]
      data_117 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[118]) begin // @[line_cell.scala 22:20]
      data_118 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[119]) begin // @[line_cell.scala 22:20]
      data_119 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[120]) begin // @[line_cell.scala 22:20]
      data_120 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[121]) begin // @[line_cell.scala 22:20]
      data_121 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[122]) begin // @[line_cell.scala 22:20]
      data_122 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[123]) begin // @[line_cell.scala 22:20]
      data_123 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[124]) begin // @[line_cell.scala 22:20]
      data_124 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[125]) begin // @[line_cell.scala 22:20]
      data_125 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[126]) begin // @[line_cell.scala 22:20]
      data_126 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[127]) begin // @[line_cell.scala 22:20]
      data_127 <= io_BL; // @[line_cell.scala 23:15]
    end
    if (io_WL[0]) begin // @[line_cell.scala 22:20]
      data_out_0 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_0 <= data_0; // @[line_cell.scala 27:19]
    end
    if (io_WL[1]) begin // @[line_cell.scala 22:20]
      data_out_1 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_1 <= data_1; // @[line_cell.scala 27:19]
    end
    if (io_WL[2]) begin // @[line_cell.scala 22:20]
      data_out_2 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_2 <= data_2; // @[line_cell.scala 27:19]
    end
    if (io_WL[3]) begin // @[line_cell.scala 22:20]
      data_out_3 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_3 <= data_3; // @[line_cell.scala 27:19]
    end
    if (io_WL[4]) begin // @[line_cell.scala 22:20]
      data_out_4 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_4 <= data_4; // @[line_cell.scala 27:19]
    end
    if (io_WL[5]) begin // @[line_cell.scala 22:20]
      data_out_5 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_5 <= data_5; // @[line_cell.scala 27:19]
    end
    if (io_WL[6]) begin // @[line_cell.scala 22:20]
      data_out_6 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_6 <= data_6; // @[line_cell.scala 27:19]
    end
    if (io_WL[7]) begin // @[line_cell.scala 22:20]
      data_out_7 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_7 <= data_7; // @[line_cell.scala 27:19]
    end
    if (io_WL[8]) begin // @[line_cell.scala 22:20]
      data_out_8 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_8 <= data_8; // @[line_cell.scala 27:19]
    end
    if (io_WL[9]) begin // @[line_cell.scala 22:20]
      data_out_9 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_9 <= data_9; // @[line_cell.scala 27:19]
    end
    if (io_WL[10]) begin // @[line_cell.scala 22:20]
      data_out_10 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_10 <= data_10; // @[line_cell.scala 27:19]
    end
    if (io_WL[11]) begin // @[line_cell.scala 22:20]
      data_out_11 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_11 <= data_11; // @[line_cell.scala 27:19]
    end
    if (io_WL[12]) begin // @[line_cell.scala 22:20]
      data_out_12 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_12 <= data_12; // @[line_cell.scala 27:19]
    end
    if (io_WL[13]) begin // @[line_cell.scala 22:20]
      data_out_13 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_13 <= data_13; // @[line_cell.scala 27:19]
    end
    if (io_WL[14]) begin // @[line_cell.scala 22:20]
      data_out_14 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_14 <= data_14; // @[line_cell.scala 27:19]
    end
    if (io_WL[15]) begin // @[line_cell.scala 22:20]
      data_out_15 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_15 <= data_15; // @[line_cell.scala 27:19]
    end
    if (io_WL[16]) begin // @[line_cell.scala 22:20]
      data_out_16 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_16 <= data_16; // @[line_cell.scala 27:19]
    end
    if (io_WL[17]) begin // @[line_cell.scala 22:20]
      data_out_17 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_17 <= data_17; // @[line_cell.scala 27:19]
    end
    if (io_WL[18]) begin // @[line_cell.scala 22:20]
      data_out_18 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_18 <= data_18; // @[line_cell.scala 27:19]
    end
    if (io_WL[19]) begin // @[line_cell.scala 22:20]
      data_out_19 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_19 <= data_19; // @[line_cell.scala 27:19]
    end
    if (io_WL[20]) begin // @[line_cell.scala 22:20]
      data_out_20 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_20 <= data_20; // @[line_cell.scala 27:19]
    end
    if (io_WL[21]) begin // @[line_cell.scala 22:20]
      data_out_21 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_21 <= data_21; // @[line_cell.scala 27:19]
    end
    if (io_WL[22]) begin // @[line_cell.scala 22:20]
      data_out_22 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_22 <= data_22; // @[line_cell.scala 27:19]
    end
    if (io_WL[23]) begin // @[line_cell.scala 22:20]
      data_out_23 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_23 <= data_23; // @[line_cell.scala 27:19]
    end
    if (io_WL[24]) begin // @[line_cell.scala 22:20]
      data_out_24 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_24 <= data_24; // @[line_cell.scala 27:19]
    end
    if (io_WL[25]) begin // @[line_cell.scala 22:20]
      data_out_25 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_25 <= data_25; // @[line_cell.scala 27:19]
    end
    if (io_WL[26]) begin // @[line_cell.scala 22:20]
      data_out_26 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_26 <= data_26; // @[line_cell.scala 27:19]
    end
    if (io_WL[27]) begin // @[line_cell.scala 22:20]
      data_out_27 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_27 <= data_27; // @[line_cell.scala 27:19]
    end
    if (io_WL[28]) begin // @[line_cell.scala 22:20]
      data_out_28 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_28 <= data_28; // @[line_cell.scala 27:19]
    end
    if (io_WL[29]) begin // @[line_cell.scala 22:20]
      data_out_29 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_29 <= data_29; // @[line_cell.scala 27:19]
    end
    if (io_WL[30]) begin // @[line_cell.scala 22:20]
      data_out_30 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_30 <= data_30; // @[line_cell.scala 27:19]
    end
    if (io_WL[31]) begin // @[line_cell.scala 22:20]
      data_out_31 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_31 <= data_31; // @[line_cell.scala 27:19]
    end
    if (io_WL[32]) begin // @[line_cell.scala 22:20]
      data_out_32 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_32 <= data_32; // @[line_cell.scala 27:19]
    end
    if (io_WL[33]) begin // @[line_cell.scala 22:20]
      data_out_33 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_33 <= data_33; // @[line_cell.scala 27:19]
    end
    if (io_WL[34]) begin // @[line_cell.scala 22:20]
      data_out_34 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_34 <= data_34; // @[line_cell.scala 27:19]
    end
    if (io_WL[35]) begin // @[line_cell.scala 22:20]
      data_out_35 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_35 <= data_35; // @[line_cell.scala 27:19]
    end
    if (io_WL[36]) begin // @[line_cell.scala 22:20]
      data_out_36 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_36 <= data_36; // @[line_cell.scala 27:19]
    end
    if (io_WL[37]) begin // @[line_cell.scala 22:20]
      data_out_37 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_37 <= data_37; // @[line_cell.scala 27:19]
    end
    if (io_WL[38]) begin // @[line_cell.scala 22:20]
      data_out_38 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_38 <= data_38; // @[line_cell.scala 27:19]
    end
    if (io_WL[39]) begin // @[line_cell.scala 22:20]
      data_out_39 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_39 <= data_39; // @[line_cell.scala 27:19]
    end
    if (io_WL[40]) begin // @[line_cell.scala 22:20]
      data_out_40 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_40 <= data_40; // @[line_cell.scala 27:19]
    end
    if (io_WL[41]) begin // @[line_cell.scala 22:20]
      data_out_41 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_41 <= data_41; // @[line_cell.scala 27:19]
    end
    if (io_WL[42]) begin // @[line_cell.scala 22:20]
      data_out_42 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_42 <= data_42; // @[line_cell.scala 27:19]
    end
    if (io_WL[43]) begin // @[line_cell.scala 22:20]
      data_out_43 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_43 <= data_43; // @[line_cell.scala 27:19]
    end
    if (io_WL[44]) begin // @[line_cell.scala 22:20]
      data_out_44 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_44 <= data_44; // @[line_cell.scala 27:19]
    end
    if (io_WL[45]) begin // @[line_cell.scala 22:20]
      data_out_45 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_45 <= data_45; // @[line_cell.scala 27:19]
    end
    if (io_WL[46]) begin // @[line_cell.scala 22:20]
      data_out_46 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_46 <= data_46; // @[line_cell.scala 27:19]
    end
    if (io_WL[47]) begin // @[line_cell.scala 22:20]
      data_out_47 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_47 <= data_47; // @[line_cell.scala 27:19]
    end
    if (io_WL[48]) begin // @[line_cell.scala 22:20]
      data_out_48 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_48 <= data_48; // @[line_cell.scala 27:19]
    end
    if (io_WL[49]) begin // @[line_cell.scala 22:20]
      data_out_49 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_49 <= data_49; // @[line_cell.scala 27:19]
    end
    if (io_WL[50]) begin // @[line_cell.scala 22:20]
      data_out_50 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_50 <= data_50; // @[line_cell.scala 27:19]
    end
    if (io_WL[51]) begin // @[line_cell.scala 22:20]
      data_out_51 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_51 <= data_51; // @[line_cell.scala 27:19]
    end
    if (io_WL[52]) begin // @[line_cell.scala 22:20]
      data_out_52 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_52 <= data_52; // @[line_cell.scala 27:19]
    end
    if (io_WL[53]) begin // @[line_cell.scala 22:20]
      data_out_53 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_53 <= data_53; // @[line_cell.scala 27:19]
    end
    if (io_WL[54]) begin // @[line_cell.scala 22:20]
      data_out_54 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_54 <= data_54; // @[line_cell.scala 27:19]
    end
    if (io_WL[55]) begin // @[line_cell.scala 22:20]
      data_out_55 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_55 <= data_55; // @[line_cell.scala 27:19]
    end
    if (io_WL[56]) begin // @[line_cell.scala 22:20]
      data_out_56 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_56 <= data_56; // @[line_cell.scala 27:19]
    end
    if (io_WL[57]) begin // @[line_cell.scala 22:20]
      data_out_57 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_57 <= data_57; // @[line_cell.scala 27:19]
    end
    if (io_WL[58]) begin // @[line_cell.scala 22:20]
      data_out_58 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_58 <= data_58; // @[line_cell.scala 27:19]
    end
    if (io_WL[59]) begin // @[line_cell.scala 22:20]
      data_out_59 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_59 <= data_59; // @[line_cell.scala 27:19]
    end
    if (io_WL[60]) begin // @[line_cell.scala 22:20]
      data_out_60 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_60 <= data_60; // @[line_cell.scala 27:19]
    end
    if (io_WL[61]) begin // @[line_cell.scala 22:20]
      data_out_61 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_61 <= data_61; // @[line_cell.scala 27:19]
    end
    if (io_WL[62]) begin // @[line_cell.scala 22:20]
      data_out_62 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_62 <= data_62; // @[line_cell.scala 27:19]
    end
    if (io_WL[63]) begin // @[line_cell.scala 22:20]
      data_out_63 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_63 <= data_63; // @[line_cell.scala 27:19]
    end
    if (io_WL[64]) begin // @[line_cell.scala 22:20]
      data_out_64 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_64 <= data_64; // @[line_cell.scala 27:19]
    end
    if (io_WL[65]) begin // @[line_cell.scala 22:20]
      data_out_65 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_65 <= data_65; // @[line_cell.scala 27:19]
    end
    if (io_WL[66]) begin // @[line_cell.scala 22:20]
      data_out_66 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_66 <= data_66; // @[line_cell.scala 27:19]
    end
    if (io_WL[67]) begin // @[line_cell.scala 22:20]
      data_out_67 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_67 <= data_67; // @[line_cell.scala 27:19]
    end
    if (io_WL[68]) begin // @[line_cell.scala 22:20]
      data_out_68 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_68 <= data_68; // @[line_cell.scala 27:19]
    end
    if (io_WL[69]) begin // @[line_cell.scala 22:20]
      data_out_69 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_69 <= data_69; // @[line_cell.scala 27:19]
    end
    if (io_WL[70]) begin // @[line_cell.scala 22:20]
      data_out_70 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_70 <= data_70; // @[line_cell.scala 27:19]
    end
    if (io_WL[71]) begin // @[line_cell.scala 22:20]
      data_out_71 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_71 <= data_71; // @[line_cell.scala 27:19]
    end
    if (io_WL[72]) begin // @[line_cell.scala 22:20]
      data_out_72 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_72 <= data_72; // @[line_cell.scala 27:19]
    end
    if (io_WL[73]) begin // @[line_cell.scala 22:20]
      data_out_73 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_73 <= data_73; // @[line_cell.scala 27:19]
    end
    if (io_WL[74]) begin // @[line_cell.scala 22:20]
      data_out_74 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_74 <= data_74; // @[line_cell.scala 27:19]
    end
    if (io_WL[75]) begin // @[line_cell.scala 22:20]
      data_out_75 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_75 <= data_75; // @[line_cell.scala 27:19]
    end
    if (io_WL[76]) begin // @[line_cell.scala 22:20]
      data_out_76 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_76 <= data_76; // @[line_cell.scala 27:19]
    end
    if (io_WL[77]) begin // @[line_cell.scala 22:20]
      data_out_77 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_77 <= data_77; // @[line_cell.scala 27:19]
    end
    if (io_WL[78]) begin // @[line_cell.scala 22:20]
      data_out_78 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_78 <= data_78; // @[line_cell.scala 27:19]
    end
    if (io_WL[79]) begin // @[line_cell.scala 22:20]
      data_out_79 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_79 <= data_79; // @[line_cell.scala 27:19]
    end
    if (io_WL[80]) begin // @[line_cell.scala 22:20]
      data_out_80 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_80 <= data_80; // @[line_cell.scala 27:19]
    end
    if (io_WL[81]) begin // @[line_cell.scala 22:20]
      data_out_81 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_81 <= data_81; // @[line_cell.scala 27:19]
    end
    if (io_WL[82]) begin // @[line_cell.scala 22:20]
      data_out_82 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_82 <= data_82; // @[line_cell.scala 27:19]
    end
    if (io_WL[83]) begin // @[line_cell.scala 22:20]
      data_out_83 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_83 <= data_83; // @[line_cell.scala 27:19]
    end
    if (io_WL[84]) begin // @[line_cell.scala 22:20]
      data_out_84 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_84 <= data_84; // @[line_cell.scala 27:19]
    end
    if (io_WL[85]) begin // @[line_cell.scala 22:20]
      data_out_85 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_85 <= data_85; // @[line_cell.scala 27:19]
    end
    if (io_WL[86]) begin // @[line_cell.scala 22:20]
      data_out_86 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_86 <= data_86; // @[line_cell.scala 27:19]
    end
    if (io_WL[87]) begin // @[line_cell.scala 22:20]
      data_out_87 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_87 <= data_87; // @[line_cell.scala 27:19]
    end
    if (io_WL[88]) begin // @[line_cell.scala 22:20]
      data_out_88 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_88 <= data_88; // @[line_cell.scala 27:19]
    end
    if (io_WL[89]) begin // @[line_cell.scala 22:20]
      data_out_89 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_89 <= data_89; // @[line_cell.scala 27:19]
    end
    if (io_WL[90]) begin // @[line_cell.scala 22:20]
      data_out_90 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_90 <= data_90; // @[line_cell.scala 27:19]
    end
    if (io_WL[91]) begin // @[line_cell.scala 22:20]
      data_out_91 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_91 <= data_91; // @[line_cell.scala 27:19]
    end
    if (io_WL[92]) begin // @[line_cell.scala 22:20]
      data_out_92 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_92 <= data_92; // @[line_cell.scala 27:19]
    end
    if (io_WL[93]) begin // @[line_cell.scala 22:20]
      data_out_93 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_93 <= data_93; // @[line_cell.scala 27:19]
    end
    if (io_WL[94]) begin // @[line_cell.scala 22:20]
      data_out_94 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_94 <= data_94; // @[line_cell.scala 27:19]
    end
    if (io_WL[95]) begin // @[line_cell.scala 22:20]
      data_out_95 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_95 <= data_95; // @[line_cell.scala 27:19]
    end
    if (io_WL[96]) begin // @[line_cell.scala 22:20]
      data_out_96 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_96 <= data_96; // @[line_cell.scala 27:19]
    end
    if (io_WL[97]) begin // @[line_cell.scala 22:20]
      data_out_97 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_97 <= data_97; // @[line_cell.scala 27:19]
    end
    if (io_WL[98]) begin // @[line_cell.scala 22:20]
      data_out_98 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_98 <= data_98; // @[line_cell.scala 27:19]
    end
    if (io_WL[99]) begin // @[line_cell.scala 22:20]
      data_out_99 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_99 <= data_99; // @[line_cell.scala 27:19]
    end
    if (io_WL[100]) begin // @[line_cell.scala 22:20]
      data_out_100 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_100 <= data_100; // @[line_cell.scala 27:19]
    end
    if (io_WL[101]) begin // @[line_cell.scala 22:20]
      data_out_101 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_101 <= data_101; // @[line_cell.scala 27:19]
    end
    if (io_WL[102]) begin // @[line_cell.scala 22:20]
      data_out_102 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_102 <= data_102; // @[line_cell.scala 27:19]
    end
    if (io_WL[103]) begin // @[line_cell.scala 22:20]
      data_out_103 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_103 <= data_103; // @[line_cell.scala 27:19]
    end
    if (io_WL[104]) begin // @[line_cell.scala 22:20]
      data_out_104 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_104 <= data_104; // @[line_cell.scala 27:19]
    end
    if (io_WL[105]) begin // @[line_cell.scala 22:20]
      data_out_105 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_105 <= data_105; // @[line_cell.scala 27:19]
    end
    if (io_WL[106]) begin // @[line_cell.scala 22:20]
      data_out_106 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_106 <= data_106; // @[line_cell.scala 27:19]
    end
    if (io_WL[107]) begin // @[line_cell.scala 22:20]
      data_out_107 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_107 <= data_107; // @[line_cell.scala 27:19]
    end
    if (io_WL[108]) begin // @[line_cell.scala 22:20]
      data_out_108 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_108 <= data_108; // @[line_cell.scala 27:19]
    end
    if (io_WL[109]) begin // @[line_cell.scala 22:20]
      data_out_109 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_109 <= data_109; // @[line_cell.scala 27:19]
    end
    if (io_WL[110]) begin // @[line_cell.scala 22:20]
      data_out_110 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_110 <= data_110; // @[line_cell.scala 27:19]
    end
    if (io_WL[111]) begin // @[line_cell.scala 22:20]
      data_out_111 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_111 <= data_111; // @[line_cell.scala 27:19]
    end
    if (io_WL[112]) begin // @[line_cell.scala 22:20]
      data_out_112 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_112 <= data_112; // @[line_cell.scala 27:19]
    end
    if (io_WL[113]) begin // @[line_cell.scala 22:20]
      data_out_113 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_113 <= data_113; // @[line_cell.scala 27:19]
    end
    if (io_WL[114]) begin // @[line_cell.scala 22:20]
      data_out_114 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_114 <= data_114; // @[line_cell.scala 27:19]
    end
    if (io_WL[115]) begin // @[line_cell.scala 22:20]
      data_out_115 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_115 <= data_115; // @[line_cell.scala 27:19]
    end
    if (io_WL[116]) begin // @[line_cell.scala 22:20]
      data_out_116 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_116 <= data_116; // @[line_cell.scala 27:19]
    end
    if (io_WL[117]) begin // @[line_cell.scala 22:20]
      data_out_117 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_117 <= data_117; // @[line_cell.scala 27:19]
    end
    if (io_WL[118]) begin // @[line_cell.scala 22:20]
      data_out_118 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_118 <= data_118; // @[line_cell.scala 27:19]
    end
    if (io_WL[119]) begin // @[line_cell.scala 22:20]
      data_out_119 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_119 <= data_119; // @[line_cell.scala 27:19]
    end
    if (io_WL[120]) begin // @[line_cell.scala 22:20]
      data_out_120 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_120 <= data_120; // @[line_cell.scala 27:19]
    end
    if (io_WL[121]) begin // @[line_cell.scala 22:20]
      data_out_121 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_121 <= data_121; // @[line_cell.scala 27:19]
    end
    if (io_WL[122]) begin // @[line_cell.scala 22:20]
      data_out_122 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_122 <= data_122; // @[line_cell.scala 27:19]
    end
    if (io_WL[123]) begin // @[line_cell.scala 22:20]
      data_out_123 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_123 <= data_123; // @[line_cell.scala 27:19]
    end
    if (io_WL[124]) begin // @[line_cell.scala 22:20]
      data_out_124 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_124 <= data_124; // @[line_cell.scala 27:19]
    end
    if (io_WL[125]) begin // @[line_cell.scala 22:20]
      data_out_125 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_125 <= data_125; // @[line_cell.scala 27:19]
    end
    if (io_WL[126]) begin // @[line_cell.scala 22:20]
      data_out_126 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_126 <= data_126; // @[line_cell.scala 27:19]
    end
    if (io_WL[127]) begin // @[line_cell.scala 22:20]
      data_out_127 <= 1'h0; // @[line_cell.scala 24:19]
    end else begin
      data_out_127 <= data_127; // @[line_cell.scala 27:19]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  data_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  data_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  data_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  data_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  data_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  data_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  data_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  data_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  data_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  data_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  data_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  data_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  data_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  data_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  data_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  data_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  data_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  data_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  data_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  data_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  data_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  data_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  data_23 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  data_24 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  data_25 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  data_26 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  data_27 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  data_28 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  data_29 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  data_30 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  data_31 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  data_32 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  data_33 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  data_34 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  data_35 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  data_36 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  data_37 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  data_38 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  data_39 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  data_40 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  data_41 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  data_42 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  data_43 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  data_44 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  data_45 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  data_46 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  data_47 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  data_48 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  data_49 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  data_50 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  data_51 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  data_52 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  data_53 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  data_54 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  data_55 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  data_56 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  data_57 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  data_58 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  data_59 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  data_60 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  data_61 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  data_62 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  data_63 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  data_64 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  data_65 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  data_66 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  data_67 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  data_68 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  data_69 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  data_70 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  data_71 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  data_72 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  data_73 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  data_74 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  data_75 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  data_76 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  data_77 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  data_78 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  data_79 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  data_80 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  data_81 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  data_82 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  data_83 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  data_84 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  data_85 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  data_86 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  data_87 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  data_88 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  data_89 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  data_90 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  data_91 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  data_92 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  data_93 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  data_94 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  data_95 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  data_96 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  data_97 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  data_98 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  data_99 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  data_100 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  data_101 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  data_102 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  data_103 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  data_104 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  data_105 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  data_106 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  data_107 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  data_108 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  data_109 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  data_110 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  data_111 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  data_112 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  data_113 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  data_114 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  data_115 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  data_116 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  data_117 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  data_118 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  data_119 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  data_120 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  data_121 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  data_122 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  data_123 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  data_124 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  data_125 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  data_126 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  data_127 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  data_out_0 = _RAND_128[0:0];
  _RAND_129 = {1{`RANDOM}};
  data_out_1 = _RAND_129[0:0];
  _RAND_130 = {1{`RANDOM}};
  data_out_2 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  data_out_3 = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  data_out_4 = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  data_out_5 = _RAND_133[0:0];
  _RAND_134 = {1{`RANDOM}};
  data_out_6 = _RAND_134[0:0];
  _RAND_135 = {1{`RANDOM}};
  data_out_7 = _RAND_135[0:0];
  _RAND_136 = {1{`RANDOM}};
  data_out_8 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  data_out_9 = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  data_out_10 = _RAND_138[0:0];
  _RAND_139 = {1{`RANDOM}};
  data_out_11 = _RAND_139[0:0];
  _RAND_140 = {1{`RANDOM}};
  data_out_12 = _RAND_140[0:0];
  _RAND_141 = {1{`RANDOM}};
  data_out_13 = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  data_out_14 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  data_out_15 = _RAND_143[0:0];
  _RAND_144 = {1{`RANDOM}};
  data_out_16 = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  data_out_17 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  data_out_18 = _RAND_146[0:0];
  _RAND_147 = {1{`RANDOM}};
  data_out_19 = _RAND_147[0:0];
  _RAND_148 = {1{`RANDOM}};
  data_out_20 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  data_out_21 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  data_out_22 = _RAND_150[0:0];
  _RAND_151 = {1{`RANDOM}};
  data_out_23 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  data_out_24 = _RAND_152[0:0];
  _RAND_153 = {1{`RANDOM}};
  data_out_25 = _RAND_153[0:0];
  _RAND_154 = {1{`RANDOM}};
  data_out_26 = _RAND_154[0:0];
  _RAND_155 = {1{`RANDOM}};
  data_out_27 = _RAND_155[0:0];
  _RAND_156 = {1{`RANDOM}};
  data_out_28 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  data_out_29 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  data_out_30 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  data_out_31 = _RAND_159[0:0];
  _RAND_160 = {1{`RANDOM}};
  data_out_32 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  data_out_33 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  data_out_34 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  data_out_35 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  data_out_36 = _RAND_164[0:0];
  _RAND_165 = {1{`RANDOM}};
  data_out_37 = _RAND_165[0:0];
  _RAND_166 = {1{`RANDOM}};
  data_out_38 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  data_out_39 = _RAND_167[0:0];
  _RAND_168 = {1{`RANDOM}};
  data_out_40 = _RAND_168[0:0];
  _RAND_169 = {1{`RANDOM}};
  data_out_41 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  data_out_42 = _RAND_170[0:0];
  _RAND_171 = {1{`RANDOM}};
  data_out_43 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  data_out_44 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  data_out_45 = _RAND_173[0:0];
  _RAND_174 = {1{`RANDOM}};
  data_out_46 = _RAND_174[0:0];
  _RAND_175 = {1{`RANDOM}};
  data_out_47 = _RAND_175[0:0];
  _RAND_176 = {1{`RANDOM}};
  data_out_48 = _RAND_176[0:0];
  _RAND_177 = {1{`RANDOM}};
  data_out_49 = _RAND_177[0:0];
  _RAND_178 = {1{`RANDOM}};
  data_out_50 = _RAND_178[0:0];
  _RAND_179 = {1{`RANDOM}};
  data_out_51 = _RAND_179[0:0];
  _RAND_180 = {1{`RANDOM}};
  data_out_52 = _RAND_180[0:0];
  _RAND_181 = {1{`RANDOM}};
  data_out_53 = _RAND_181[0:0];
  _RAND_182 = {1{`RANDOM}};
  data_out_54 = _RAND_182[0:0];
  _RAND_183 = {1{`RANDOM}};
  data_out_55 = _RAND_183[0:0];
  _RAND_184 = {1{`RANDOM}};
  data_out_56 = _RAND_184[0:0];
  _RAND_185 = {1{`RANDOM}};
  data_out_57 = _RAND_185[0:0];
  _RAND_186 = {1{`RANDOM}};
  data_out_58 = _RAND_186[0:0];
  _RAND_187 = {1{`RANDOM}};
  data_out_59 = _RAND_187[0:0];
  _RAND_188 = {1{`RANDOM}};
  data_out_60 = _RAND_188[0:0];
  _RAND_189 = {1{`RANDOM}};
  data_out_61 = _RAND_189[0:0];
  _RAND_190 = {1{`RANDOM}};
  data_out_62 = _RAND_190[0:0];
  _RAND_191 = {1{`RANDOM}};
  data_out_63 = _RAND_191[0:0];
  _RAND_192 = {1{`RANDOM}};
  data_out_64 = _RAND_192[0:0];
  _RAND_193 = {1{`RANDOM}};
  data_out_65 = _RAND_193[0:0];
  _RAND_194 = {1{`RANDOM}};
  data_out_66 = _RAND_194[0:0];
  _RAND_195 = {1{`RANDOM}};
  data_out_67 = _RAND_195[0:0];
  _RAND_196 = {1{`RANDOM}};
  data_out_68 = _RAND_196[0:0];
  _RAND_197 = {1{`RANDOM}};
  data_out_69 = _RAND_197[0:0];
  _RAND_198 = {1{`RANDOM}};
  data_out_70 = _RAND_198[0:0];
  _RAND_199 = {1{`RANDOM}};
  data_out_71 = _RAND_199[0:0];
  _RAND_200 = {1{`RANDOM}};
  data_out_72 = _RAND_200[0:0];
  _RAND_201 = {1{`RANDOM}};
  data_out_73 = _RAND_201[0:0];
  _RAND_202 = {1{`RANDOM}};
  data_out_74 = _RAND_202[0:0];
  _RAND_203 = {1{`RANDOM}};
  data_out_75 = _RAND_203[0:0];
  _RAND_204 = {1{`RANDOM}};
  data_out_76 = _RAND_204[0:0];
  _RAND_205 = {1{`RANDOM}};
  data_out_77 = _RAND_205[0:0];
  _RAND_206 = {1{`RANDOM}};
  data_out_78 = _RAND_206[0:0];
  _RAND_207 = {1{`RANDOM}};
  data_out_79 = _RAND_207[0:0];
  _RAND_208 = {1{`RANDOM}};
  data_out_80 = _RAND_208[0:0];
  _RAND_209 = {1{`RANDOM}};
  data_out_81 = _RAND_209[0:0];
  _RAND_210 = {1{`RANDOM}};
  data_out_82 = _RAND_210[0:0];
  _RAND_211 = {1{`RANDOM}};
  data_out_83 = _RAND_211[0:0];
  _RAND_212 = {1{`RANDOM}};
  data_out_84 = _RAND_212[0:0];
  _RAND_213 = {1{`RANDOM}};
  data_out_85 = _RAND_213[0:0];
  _RAND_214 = {1{`RANDOM}};
  data_out_86 = _RAND_214[0:0];
  _RAND_215 = {1{`RANDOM}};
  data_out_87 = _RAND_215[0:0];
  _RAND_216 = {1{`RANDOM}};
  data_out_88 = _RAND_216[0:0];
  _RAND_217 = {1{`RANDOM}};
  data_out_89 = _RAND_217[0:0];
  _RAND_218 = {1{`RANDOM}};
  data_out_90 = _RAND_218[0:0];
  _RAND_219 = {1{`RANDOM}};
  data_out_91 = _RAND_219[0:0];
  _RAND_220 = {1{`RANDOM}};
  data_out_92 = _RAND_220[0:0];
  _RAND_221 = {1{`RANDOM}};
  data_out_93 = _RAND_221[0:0];
  _RAND_222 = {1{`RANDOM}};
  data_out_94 = _RAND_222[0:0];
  _RAND_223 = {1{`RANDOM}};
  data_out_95 = _RAND_223[0:0];
  _RAND_224 = {1{`RANDOM}};
  data_out_96 = _RAND_224[0:0];
  _RAND_225 = {1{`RANDOM}};
  data_out_97 = _RAND_225[0:0];
  _RAND_226 = {1{`RANDOM}};
  data_out_98 = _RAND_226[0:0];
  _RAND_227 = {1{`RANDOM}};
  data_out_99 = _RAND_227[0:0];
  _RAND_228 = {1{`RANDOM}};
  data_out_100 = _RAND_228[0:0];
  _RAND_229 = {1{`RANDOM}};
  data_out_101 = _RAND_229[0:0];
  _RAND_230 = {1{`RANDOM}};
  data_out_102 = _RAND_230[0:0];
  _RAND_231 = {1{`RANDOM}};
  data_out_103 = _RAND_231[0:0];
  _RAND_232 = {1{`RANDOM}};
  data_out_104 = _RAND_232[0:0];
  _RAND_233 = {1{`RANDOM}};
  data_out_105 = _RAND_233[0:0];
  _RAND_234 = {1{`RANDOM}};
  data_out_106 = _RAND_234[0:0];
  _RAND_235 = {1{`RANDOM}};
  data_out_107 = _RAND_235[0:0];
  _RAND_236 = {1{`RANDOM}};
  data_out_108 = _RAND_236[0:0];
  _RAND_237 = {1{`RANDOM}};
  data_out_109 = _RAND_237[0:0];
  _RAND_238 = {1{`RANDOM}};
  data_out_110 = _RAND_238[0:0];
  _RAND_239 = {1{`RANDOM}};
  data_out_111 = _RAND_239[0:0];
  _RAND_240 = {1{`RANDOM}};
  data_out_112 = _RAND_240[0:0];
  _RAND_241 = {1{`RANDOM}};
  data_out_113 = _RAND_241[0:0];
  _RAND_242 = {1{`RANDOM}};
  data_out_114 = _RAND_242[0:0];
  _RAND_243 = {1{`RANDOM}};
  data_out_115 = _RAND_243[0:0];
  _RAND_244 = {1{`RANDOM}};
  data_out_116 = _RAND_244[0:0];
  _RAND_245 = {1{`RANDOM}};
  data_out_117 = _RAND_245[0:0];
  _RAND_246 = {1{`RANDOM}};
  data_out_118 = _RAND_246[0:0];
  _RAND_247 = {1{`RANDOM}};
  data_out_119 = _RAND_247[0:0];
  _RAND_248 = {1{`RANDOM}};
  data_out_120 = _RAND_248[0:0];
  _RAND_249 = {1{`RANDOM}};
  data_out_121 = _RAND_249[0:0];
  _RAND_250 = {1{`RANDOM}};
  data_out_122 = _RAND_250[0:0];
  _RAND_251 = {1{`RANDOM}};
  data_out_123 = _RAND_251[0:0];
  _RAND_252 = {1{`RANDOM}};
  data_out_124 = _RAND_252[0:0];
  _RAND_253 = {1{`RANDOM}};
  data_out_125 = _RAND_253[0:0];
  _RAND_254 = {1{`RANDOM}};
  data_out_126 = _RAND_254[0:0];
  _RAND_255 = {1{`RANDOM}};
  data_out_127 = _RAND_255[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder(
  input        clock,
  input  [7:0] io_a,
  input  [7:0] io_b,
  output [8:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [8:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[8:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_64(
  input        clock,
  input  [8:0] io_a,
  input  [8:0] io_b,
  output [9:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_96(
  input         clock,
  input  [9:0]  io_a,
  input  [9:0]  io_b,
  output [10:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_112(
  input         clock,
  input  [10:0] io_a,
  input  [10:0] io_b,
  output [11:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_120(
  input         clock,
  input  [11:0] io_a,
  input  [11:0] io_b,
  output [12:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [12:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[12:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_124(
  input         clock,
  input  [12:0] io_a,
  input  [12:0] io_b,
  output [13:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [13:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[13:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NBitsAdder_126(
  input         clock,
  input  [13:0] io_a,
  input  [13:0] io_b,
  output [14:0] io_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [14:0] sum; // @[AdderTree.scala 12:16]
  assign io_s = sum; // @[AdderTree.scala 15:15]
  always @(posedge clock) begin
    sum <= $signed(io_a) + $signed(io_b); // @[AdderTree.scala 13:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sum = _RAND_0[14:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AdderTree(
  input         clock,
  input  [7:0]  io_d_in_0,
  input  [7:0]  io_d_in_1,
  input  [7:0]  io_d_in_2,
  input  [7:0]  io_d_in_3,
  input  [7:0]  io_d_in_4,
  input  [7:0]  io_d_in_5,
  input  [7:0]  io_d_in_6,
  input  [7:0]  io_d_in_7,
  input  [7:0]  io_d_in_8,
  input  [7:0]  io_d_in_9,
  input  [7:0]  io_d_in_10,
  input  [7:0]  io_d_in_11,
  input  [7:0]  io_d_in_12,
  input  [7:0]  io_d_in_13,
  input  [7:0]  io_d_in_14,
  input  [7:0]  io_d_in_15,
  input  [7:0]  io_d_in_16,
  input  [7:0]  io_d_in_17,
  input  [7:0]  io_d_in_18,
  input  [7:0]  io_d_in_19,
  input  [7:0]  io_d_in_20,
  input  [7:0]  io_d_in_21,
  input  [7:0]  io_d_in_22,
  input  [7:0]  io_d_in_23,
  input  [7:0]  io_d_in_24,
  input  [7:0]  io_d_in_25,
  input  [7:0]  io_d_in_26,
  input  [7:0]  io_d_in_27,
  input  [7:0]  io_d_in_28,
  input  [7:0]  io_d_in_29,
  input  [7:0]  io_d_in_30,
  input  [7:0]  io_d_in_31,
  input  [7:0]  io_d_in_32,
  input  [7:0]  io_d_in_33,
  input  [7:0]  io_d_in_34,
  input  [7:0]  io_d_in_35,
  input  [7:0]  io_d_in_36,
  input  [7:0]  io_d_in_37,
  input  [7:0]  io_d_in_38,
  input  [7:0]  io_d_in_39,
  input  [7:0]  io_d_in_40,
  input  [7:0]  io_d_in_41,
  input  [7:0]  io_d_in_42,
  input  [7:0]  io_d_in_43,
  input  [7:0]  io_d_in_44,
  input  [7:0]  io_d_in_45,
  input  [7:0]  io_d_in_46,
  input  [7:0]  io_d_in_47,
  input  [7:0]  io_d_in_48,
  input  [7:0]  io_d_in_49,
  input  [7:0]  io_d_in_50,
  input  [7:0]  io_d_in_51,
  input  [7:0]  io_d_in_52,
  input  [7:0]  io_d_in_53,
  input  [7:0]  io_d_in_54,
  input  [7:0]  io_d_in_55,
  input  [7:0]  io_d_in_56,
  input  [7:0]  io_d_in_57,
  input  [7:0]  io_d_in_58,
  input  [7:0]  io_d_in_59,
  input  [7:0]  io_d_in_60,
  input  [7:0]  io_d_in_61,
  input  [7:0]  io_d_in_62,
  input  [7:0]  io_d_in_63,
  input  [7:0]  io_d_in_64,
  input  [7:0]  io_d_in_65,
  input  [7:0]  io_d_in_66,
  input  [7:0]  io_d_in_67,
  input  [7:0]  io_d_in_68,
  input  [7:0]  io_d_in_69,
  input  [7:0]  io_d_in_70,
  input  [7:0]  io_d_in_71,
  input  [7:0]  io_d_in_72,
  input  [7:0]  io_d_in_73,
  input  [7:0]  io_d_in_74,
  input  [7:0]  io_d_in_75,
  input  [7:0]  io_d_in_76,
  input  [7:0]  io_d_in_77,
  input  [7:0]  io_d_in_78,
  input  [7:0]  io_d_in_79,
  input  [7:0]  io_d_in_80,
  input  [7:0]  io_d_in_81,
  input  [7:0]  io_d_in_82,
  input  [7:0]  io_d_in_83,
  input  [7:0]  io_d_in_84,
  input  [7:0]  io_d_in_85,
  input  [7:0]  io_d_in_86,
  input  [7:0]  io_d_in_87,
  input  [7:0]  io_d_in_88,
  input  [7:0]  io_d_in_89,
  input  [7:0]  io_d_in_90,
  input  [7:0]  io_d_in_91,
  input  [7:0]  io_d_in_92,
  input  [7:0]  io_d_in_93,
  input  [7:0]  io_d_in_94,
  input  [7:0]  io_d_in_95,
  input  [7:0]  io_d_in_96,
  input  [7:0]  io_d_in_97,
  input  [7:0]  io_d_in_98,
  input  [7:0]  io_d_in_99,
  input  [7:0]  io_d_in_100,
  input  [7:0]  io_d_in_101,
  input  [7:0]  io_d_in_102,
  input  [7:0]  io_d_in_103,
  input  [7:0]  io_d_in_104,
  input  [7:0]  io_d_in_105,
  input  [7:0]  io_d_in_106,
  input  [7:0]  io_d_in_107,
  input  [7:0]  io_d_in_108,
  input  [7:0]  io_d_in_109,
  input  [7:0]  io_d_in_110,
  input  [7:0]  io_d_in_111,
  input  [7:0]  io_d_in_112,
  input  [7:0]  io_d_in_113,
  input  [7:0]  io_d_in_114,
  input  [7:0]  io_d_in_115,
  input  [7:0]  io_d_in_116,
  input  [7:0]  io_d_in_117,
  input  [7:0]  io_d_in_118,
  input  [7:0]  io_d_in_119,
  input  [7:0]  io_d_in_120,
  input  [7:0]  io_d_in_121,
  input  [7:0]  io_d_in_122,
  input  [7:0]  io_d_in_123,
  input  [7:0]  io_d_in_124,
  input  [7:0]  io_d_in_125,
  input  [7:0]  io_d_in_126,
  input  [7:0]  io_d_in_127,
  output [14:0] io_sum
);
  wire  NBitsAdder_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_1_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_1_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_1_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_1_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_2_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_2_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_2_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_2_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_3_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_3_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_3_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_3_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_4_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_4_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_4_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_4_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_5_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_5_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_5_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_5_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_6_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_6_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_6_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_6_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_7_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_7_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_7_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_7_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_8_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_8_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_8_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_8_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_9_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_9_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_9_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_9_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_10_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_10_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_10_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_10_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_11_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_11_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_11_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_11_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_12_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_12_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_12_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_12_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_13_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_13_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_13_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_13_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_14_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_14_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_14_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_14_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_15_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_15_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_15_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_15_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_16_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_16_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_16_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_16_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_17_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_17_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_17_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_17_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_18_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_18_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_18_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_18_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_19_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_19_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_19_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_19_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_20_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_20_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_20_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_20_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_21_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_21_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_21_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_21_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_22_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_22_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_22_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_22_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_23_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_23_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_23_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_23_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_24_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_24_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_24_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_24_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_25_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_25_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_25_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_25_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_26_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_26_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_26_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_26_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_27_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_27_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_27_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_27_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_28_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_28_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_28_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_28_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_29_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_29_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_29_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_29_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_30_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_30_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_30_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_30_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_31_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_31_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_31_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_31_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_32_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_32_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_32_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_32_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_33_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_33_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_33_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_33_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_34_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_34_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_34_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_34_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_35_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_35_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_35_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_35_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_36_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_36_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_36_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_36_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_37_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_37_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_37_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_37_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_38_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_38_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_38_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_38_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_39_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_39_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_39_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_39_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_40_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_40_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_40_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_40_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_41_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_41_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_41_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_41_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_42_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_42_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_42_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_42_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_43_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_43_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_43_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_43_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_44_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_44_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_44_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_44_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_45_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_45_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_45_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_45_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_46_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_46_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_46_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_46_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_47_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_47_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_47_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_47_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_48_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_48_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_48_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_48_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_49_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_49_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_49_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_49_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_50_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_50_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_50_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_50_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_51_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_51_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_51_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_51_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_52_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_52_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_52_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_52_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_53_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_53_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_53_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_53_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_54_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_54_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_54_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_54_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_55_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_55_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_55_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_55_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_56_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_56_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_56_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_56_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_57_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_57_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_57_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_57_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_58_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_58_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_58_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_58_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_59_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_59_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_59_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_59_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_60_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_60_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_60_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_60_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_61_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_61_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_61_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_61_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_62_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_62_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_62_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_62_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_63_clock; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_63_io_a; // @[AdderTree.scala 30:67]
  wire [7:0] NBitsAdder_63_io_b; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_63_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_64_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_64_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_64_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_64_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_65_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_65_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_65_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_65_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_66_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_66_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_66_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_66_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_67_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_67_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_67_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_67_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_68_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_68_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_68_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_68_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_69_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_69_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_69_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_69_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_70_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_70_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_70_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_70_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_71_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_71_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_71_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_71_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_72_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_72_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_72_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_72_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_73_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_73_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_73_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_73_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_74_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_74_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_74_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_74_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_75_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_75_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_75_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_75_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_76_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_76_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_76_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_76_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_77_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_77_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_77_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_77_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_78_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_78_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_78_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_78_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_79_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_79_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_79_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_79_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_80_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_80_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_80_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_80_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_81_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_81_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_81_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_81_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_82_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_82_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_82_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_82_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_83_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_83_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_83_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_83_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_84_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_84_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_84_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_84_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_85_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_85_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_85_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_85_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_86_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_86_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_86_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_86_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_87_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_87_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_87_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_87_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_88_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_88_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_88_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_88_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_89_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_89_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_89_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_89_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_90_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_90_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_90_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_90_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_91_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_91_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_91_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_91_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_92_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_92_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_92_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_92_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_93_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_93_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_93_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_93_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_94_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_94_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_94_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_94_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_95_clock; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_95_io_a; // @[AdderTree.scala 30:67]
  wire [8:0] NBitsAdder_95_io_b; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_95_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_96_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_96_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_96_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_96_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_97_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_97_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_97_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_97_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_98_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_98_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_98_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_98_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_99_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_99_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_99_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_99_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_100_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_100_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_100_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_100_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_101_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_101_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_101_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_101_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_102_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_102_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_102_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_102_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_103_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_103_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_103_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_103_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_104_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_104_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_104_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_104_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_105_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_105_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_105_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_105_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_106_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_106_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_106_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_106_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_107_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_107_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_107_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_107_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_108_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_108_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_108_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_108_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_109_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_109_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_109_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_109_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_110_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_110_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_110_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_110_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_111_clock; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_111_io_a; // @[AdderTree.scala 30:67]
  wire [9:0] NBitsAdder_111_io_b; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_111_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_112_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_112_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_112_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_112_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_113_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_113_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_113_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_113_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_114_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_114_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_114_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_114_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_115_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_115_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_115_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_115_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_116_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_116_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_116_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_116_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_117_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_117_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_117_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_117_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_118_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_118_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_118_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_118_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_119_clock; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_119_io_a; // @[AdderTree.scala 30:67]
  wire [10:0] NBitsAdder_119_io_b; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_119_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_120_clock; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_120_io_a; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_120_io_b; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_120_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_121_clock; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_121_io_a; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_121_io_b; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_121_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_122_clock; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_122_io_a; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_122_io_b; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_122_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_123_clock; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_123_io_a; // @[AdderTree.scala 30:67]
  wire [11:0] NBitsAdder_123_io_b; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_123_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_124_clock; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_124_io_a; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_124_io_b; // @[AdderTree.scala 30:67]
  wire [13:0] NBitsAdder_124_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_125_clock; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_125_io_a; // @[AdderTree.scala 30:67]
  wire [12:0] NBitsAdder_125_io_b; // @[AdderTree.scala 30:67]
  wire [13:0] NBitsAdder_125_io_s; // @[AdderTree.scala 30:67]
  wire  NBitsAdder_126_clock; // @[AdderTree.scala 30:67]
  wire [13:0] NBitsAdder_126_io_a; // @[AdderTree.scala 30:67]
  wire [13:0] NBitsAdder_126_io_b; // @[AdderTree.scala 30:67]
  wire [14:0] NBitsAdder_126_io_s; // @[AdderTree.scala 30:67]
  NBitsAdder NBitsAdder ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_clock),
    .io_a(NBitsAdder_io_a),
    .io_b(NBitsAdder_io_b),
    .io_s(NBitsAdder_io_s)
  );
  NBitsAdder NBitsAdder_1 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_1_clock),
    .io_a(NBitsAdder_1_io_a),
    .io_b(NBitsAdder_1_io_b),
    .io_s(NBitsAdder_1_io_s)
  );
  NBitsAdder NBitsAdder_2 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_2_clock),
    .io_a(NBitsAdder_2_io_a),
    .io_b(NBitsAdder_2_io_b),
    .io_s(NBitsAdder_2_io_s)
  );
  NBitsAdder NBitsAdder_3 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_3_clock),
    .io_a(NBitsAdder_3_io_a),
    .io_b(NBitsAdder_3_io_b),
    .io_s(NBitsAdder_3_io_s)
  );
  NBitsAdder NBitsAdder_4 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_4_clock),
    .io_a(NBitsAdder_4_io_a),
    .io_b(NBitsAdder_4_io_b),
    .io_s(NBitsAdder_4_io_s)
  );
  NBitsAdder NBitsAdder_5 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_5_clock),
    .io_a(NBitsAdder_5_io_a),
    .io_b(NBitsAdder_5_io_b),
    .io_s(NBitsAdder_5_io_s)
  );
  NBitsAdder NBitsAdder_6 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_6_clock),
    .io_a(NBitsAdder_6_io_a),
    .io_b(NBitsAdder_6_io_b),
    .io_s(NBitsAdder_6_io_s)
  );
  NBitsAdder NBitsAdder_7 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_7_clock),
    .io_a(NBitsAdder_7_io_a),
    .io_b(NBitsAdder_7_io_b),
    .io_s(NBitsAdder_7_io_s)
  );
  NBitsAdder NBitsAdder_8 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_8_clock),
    .io_a(NBitsAdder_8_io_a),
    .io_b(NBitsAdder_8_io_b),
    .io_s(NBitsAdder_8_io_s)
  );
  NBitsAdder NBitsAdder_9 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_9_clock),
    .io_a(NBitsAdder_9_io_a),
    .io_b(NBitsAdder_9_io_b),
    .io_s(NBitsAdder_9_io_s)
  );
  NBitsAdder NBitsAdder_10 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_10_clock),
    .io_a(NBitsAdder_10_io_a),
    .io_b(NBitsAdder_10_io_b),
    .io_s(NBitsAdder_10_io_s)
  );
  NBitsAdder NBitsAdder_11 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_11_clock),
    .io_a(NBitsAdder_11_io_a),
    .io_b(NBitsAdder_11_io_b),
    .io_s(NBitsAdder_11_io_s)
  );
  NBitsAdder NBitsAdder_12 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_12_clock),
    .io_a(NBitsAdder_12_io_a),
    .io_b(NBitsAdder_12_io_b),
    .io_s(NBitsAdder_12_io_s)
  );
  NBitsAdder NBitsAdder_13 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_13_clock),
    .io_a(NBitsAdder_13_io_a),
    .io_b(NBitsAdder_13_io_b),
    .io_s(NBitsAdder_13_io_s)
  );
  NBitsAdder NBitsAdder_14 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_14_clock),
    .io_a(NBitsAdder_14_io_a),
    .io_b(NBitsAdder_14_io_b),
    .io_s(NBitsAdder_14_io_s)
  );
  NBitsAdder NBitsAdder_15 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_15_clock),
    .io_a(NBitsAdder_15_io_a),
    .io_b(NBitsAdder_15_io_b),
    .io_s(NBitsAdder_15_io_s)
  );
  NBitsAdder NBitsAdder_16 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_16_clock),
    .io_a(NBitsAdder_16_io_a),
    .io_b(NBitsAdder_16_io_b),
    .io_s(NBitsAdder_16_io_s)
  );
  NBitsAdder NBitsAdder_17 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_17_clock),
    .io_a(NBitsAdder_17_io_a),
    .io_b(NBitsAdder_17_io_b),
    .io_s(NBitsAdder_17_io_s)
  );
  NBitsAdder NBitsAdder_18 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_18_clock),
    .io_a(NBitsAdder_18_io_a),
    .io_b(NBitsAdder_18_io_b),
    .io_s(NBitsAdder_18_io_s)
  );
  NBitsAdder NBitsAdder_19 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_19_clock),
    .io_a(NBitsAdder_19_io_a),
    .io_b(NBitsAdder_19_io_b),
    .io_s(NBitsAdder_19_io_s)
  );
  NBitsAdder NBitsAdder_20 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_20_clock),
    .io_a(NBitsAdder_20_io_a),
    .io_b(NBitsAdder_20_io_b),
    .io_s(NBitsAdder_20_io_s)
  );
  NBitsAdder NBitsAdder_21 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_21_clock),
    .io_a(NBitsAdder_21_io_a),
    .io_b(NBitsAdder_21_io_b),
    .io_s(NBitsAdder_21_io_s)
  );
  NBitsAdder NBitsAdder_22 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_22_clock),
    .io_a(NBitsAdder_22_io_a),
    .io_b(NBitsAdder_22_io_b),
    .io_s(NBitsAdder_22_io_s)
  );
  NBitsAdder NBitsAdder_23 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_23_clock),
    .io_a(NBitsAdder_23_io_a),
    .io_b(NBitsAdder_23_io_b),
    .io_s(NBitsAdder_23_io_s)
  );
  NBitsAdder NBitsAdder_24 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_24_clock),
    .io_a(NBitsAdder_24_io_a),
    .io_b(NBitsAdder_24_io_b),
    .io_s(NBitsAdder_24_io_s)
  );
  NBitsAdder NBitsAdder_25 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_25_clock),
    .io_a(NBitsAdder_25_io_a),
    .io_b(NBitsAdder_25_io_b),
    .io_s(NBitsAdder_25_io_s)
  );
  NBitsAdder NBitsAdder_26 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_26_clock),
    .io_a(NBitsAdder_26_io_a),
    .io_b(NBitsAdder_26_io_b),
    .io_s(NBitsAdder_26_io_s)
  );
  NBitsAdder NBitsAdder_27 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_27_clock),
    .io_a(NBitsAdder_27_io_a),
    .io_b(NBitsAdder_27_io_b),
    .io_s(NBitsAdder_27_io_s)
  );
  NBitsAdder NBitsAdder_28 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_28_clock),
    .io_a(NBitsAdder_28_io_a),
    .io_b(NBitsAdder_28_io_b),
    .io_s(NBitsAdder_28_io_s)
  );
  NBitsAdder NBitsAdder_29 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_29_clock),
    .io_a(NBitsAdder_29_io_a),
    .io_b(NBitsAdder_29_io_b),
    .io_s(NBitsAdder_29_io_s)
  );
  NBitsAdder NBitsAdder_30 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_30_clock),
    .io_a(NBitsAdder_30_io_a),
    .io_b(NBitsAdder_30_io_b),
    .io_s(NBitsAdder_30_io_s)
  );
  NBitsAdder NBitsAdder_31 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_31_clock),
    .io_a(NBitsAdder_31_io_a),
    .io_b(NBitsAdder_31_io_b),
    .io_s(NBitsAdder_31_io_s)
  );
  NBitsAdder NBitsAdder_32 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_32_clock),
    .io_a(NBitsAdder_32_io_a),
    .io_b(NBitsAdder_32_io_b),
    .io_s(NBitsAdder_32_io_s)
  );
  NBitsAdder NBitsAdder_33 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_33_clock),
    .io_a(NBitsAdder_33_io_a),
    .io_b(NBitsAdder_33_io_b),
    .io_s(NBitsAdder_33_io_s)
  );
  NBitsAdder NBitsAdder_34 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_34_clock),
    .io_a(NBitsAdder_34_io_a),
    .io_b(NBitsAdder_34_io_b),
    .io_s(NBitsAdder_34_io_s)
  );
  NBitsAdder NBitsAdder_35 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_35_clock),
    .io_a(NBitsAdder_35_io_a),
    .io_b(NBitsAdder_35_io_b),
    .io_s(NBitsAdder_35_io_s)
  );
  NBitsAdder NBitsAdder_36 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_36_clock),
    .io_a(NBitsAdder_36_io_a),
    .io_b(NBitsAdder_36_io_b),
    .io_s(NBitsAdder_36_io_s)
  );
  NBitsAdder NBitsAdder_37 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_37_clock),
    .io_a(NBitsAdder_37_io_a),
    .io_b(NBitsAdder_37_io_b),
    .io_s(NBitsAdder_37_io_s)
  );
  NBitsAdder NBitsAdder_38 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_38_clock),
    .io_a(NBitsAdder_38_io_a),
    .io_b(NBitsAdder_38_io_b),
    .io_s(NBitsAdder_38_io_s)
  );
  NBitsAdder NBitsAdder_39 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_39_clock),
    .io_a(NBitsAdder_39_io_a),
    .io_b(NBitsAdder_39_io_b),
    .io_s(NBitsAdder_39_io_s)
  );
  NBitsAdder NBitsAdder_40 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_40_clock),
    .io_a(NBitsAdder_40_io_a),
    .io_b(NBitsAdder_40_io_b),
    .io_s(NBitsAdder_40_io_s)
  );
  NBitsAdder NBitsAdder_41 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_41_clock),
    .io_a(NBitsAdder_41_io_a),
    .io_b(NBitsAdder_41_io_b),
    .io_s(NBitsAdder_41_io_s)
  );
  NBitsAdder NBitsAdder_42 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_42_clock),
    .io_a(NBitsAdder_42_io_a),
    .io_b(NBitsAdder_42_io_b),
    .io_s(NBitsAdder_42_io_s)
  );
  NBitsAdder NBitsAdder_43 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_43_clock),
    .io_a(NBitsAdder_43_io_a),
    .io_b(NBitsAdder_43_io_b),
    .io_s(NBitsAdder_43_io_s)
  );
  NBitsAdder NBitsAdder_44 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_44_clock),
    .io_a(NBitsAdder_44_io_a),
    .io_b(NBitsAdder_44_io_b),
    .io_s(NBitsAdder_44_io_s)
  );
  NBitsAdder NBitsAdder_45 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_45_clock),
    .io_a(NBitsAdder_45_io_a),
    .io_b(NBitsAdder_45_io_b),
    .io_s(NBitsAdder_45_io_s)
  );
  NBitsAdder NBitsAdder_46 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_46_clock),
    .io_a(NBitsAdder_46_io_a),
    .io_b(NBitsAdder_46_io_b),
    .io_s(NBitsAdder_46_io_s)
  );
  NBitsAdder NBitsAdder_47 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_47_clock),
    .io_a(NBitsAdder_47_io_a),
    .io_b(NBitsAdder_47_io_b),
    .io_s(NBitsAdder_47_io_s)
  );
  NBitsAdder NBitsAdder_48 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_48_clock),
    .io_a(NBitsAdder_48_io_a),
    .io_b(NBitsAdder_48_io_b),
    .io_s(NBitsAdder_48_io_s)
  );
  NBitsAdder NBitsAdder_49 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_49_clock),
    .io_a(NBitsAdder_49_io_a),
    .io_b(NBitsAdder_49_io_b),
    .io_s(NBitsAdder_49_io_s)
  );
  NBitsAdder NBitsAdder_50 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_50_clock),
    .io_a(NBitsAdder_50_io_a),
    .io_b(NBitsAdder_50_io_b),
    .io_s(NBitsAdder_50_io_s)
  );
  NBitsAdder NBitsAdder_51 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_51_clock),
    .io_a(NBitsAdder_51_io_a),
    .io_b(NBitsAdder_51_io_b),
    .io_s(NBitsAdder_51_io_s)
  );
  NBitsAdder NBitsAdder_52 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_52_clock),
    .io_a(NBitsAdder_52_io_a),
    .io_b(NBitsAdder_52_io_b),
    .io_s(NBitsAdder_52_io_s)
  );
  NBitsAdder NBitsAdder_53 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_53_clock),
    .io_a(NBitsAdder_53_io_a),
    .io_b(NBitsAdder_53_io_b),
    .io_s(NBitsAdder_53_io_s)
  );
  NBitsAdder NBitsAdder_54 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_54_clock),
    .io_a(NBitsAdder_54_io_a),
    .io_b(NBitsAdder_54_io_b),
    .io_s(NBitsAdder_54_io_s)
  );
  NBitsAdder NBitsAdder_55 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_55_clock),
    .io_a(NBitsAdder_55_io_a),
    .io_b(NBitsAdder_55_io_b),
    .io_s(NBitsAdder_55_io_s)
  );
  NBitsAdder NBitsAdder_56 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_56_clock),
    .io_a(NBitsAdder_56_io_a),
    .io_b(NBitsAdder_56_io_b),
    .io_s(NBitsAdder_56_io_s)
  );
  NBitsAdder NBitsAdder_57 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_57_clock),
    .io_a(NBitsAdder_57_io_a),
    .io_b(NBitsAdder_57_io_b),
    .io_s(NBitsAdder_57_io_s)
  );
  NBitsAdder NBitsAdder_58 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_58_clock),
    .io_a(NBitsAdder_58_io_a),
    .io_b(NBitsAdder_58_io_b),
    .io_s(NBitsAdder_58_io_s)
  );
  NBitsAdder NBitsAdder_59 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_59_clock),
    .io_a(NBitsAdder_59_io_a),
    .io_b(NBitsAdder_59_io_b),
    .io_s(NBitsAdder_59_io_s)
  );
  NBitsAdder NBitsAdder_60 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_60_clock),
    .io_a(NBitsAdder_60_io_a),
    .io_b(NBitsAdder_60_io_b),
    .io_s(NBitsAdder_60_io_s)
  );
  NBitsAdder NBitsAdder_61 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_61_clock),
    .io_a(NBitsAdder_61_io_a),
    .io_b(NBitsAdder_61_io_b),
    .io_s(NBitsAdder_61_io_s)
  );
  NBitsAdder NBitsAdder_62 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_62_clock),
    .io_a(NBitsAdder_62_io_a),
    .io_b(NBitsAdder_62_io_b),
    .io_s(NBitsAdder_62_io_s)
  );
  NBitsAdder NBitsAdder_63 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_63_clock),
    .io_a(NBitsAdder_63_io_a),
    .io_b(NBitsAdder_63_io_b),
    .io_s(NBitsAdder_63_io_s)
  );
  NBitsAdder_64 NBitsAdder_64 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_64_clock),
    .io_a(NBitsAdder_64_io_a),
    .io_b(NBitsAdder_64_io_b),
    .io_s(NBitsAdder_64_io_s)
  );
  NBitsAdder_64 NBitsAdder_65 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_65_clock),
    .io_a(NBitsAdder_65_io_a),
    .io_b(NBitsAdder_65_io_b),
    .io_s(NBitsAdder_65_io_s)
  );
  NBitsAdder_64 NBitsAdder_66 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_66_clock),
    .io_a(NBitsAdder_66_io_a),
    .io_b(NBitsAdder_66_io_b),
    .io_s(NBitsAdder_66_io_s)
  );
  NBitsAdder_64 NBitsAdder_67 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_67_clock),
    .io_a(NBitsAdder_67_io_a),
    .io_b(NBitsAdder_67_io_b),
    .io_s(NBitsAdder_67_io_s)
  );
  NBitsAdder_64 NBitsAdder_68 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_68_clock),
    .io_a(NBitsAdder_68_io_a),
    .io_b(NBitsAdder_68_io_b),
    .io_s(NBitsAdder_68_io_s)
  );
  NBitsAdder_64 NBitsAdder_69 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_69_clock),
    .io_a(NBitsAdder_69_io_a),
    .io_b(NBitsAdder_69_io_b),
    .io_s(NBitsAdder_69_io_s)
  );
  NBitsAdder_64 NBitsAdder_70 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_70_clock),
    .io_a(NBitsAdder_70_io_a),
    .io_b(NBitsAdder_70_io_b),
    .io_s(NBitsAdder_70_io_s)
  );
  NBitsAdder_64 NBitsAdder_71 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_71_clock),
    .io_a(NBitsAdder_71_io_a),
    .io_b(NBitsAdder_71_io_b),
    .io_s(NBitsAdder_71_io_s)
  );
  NBitsAdder_64 NBitsAdder_72 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_72_clock),
    .io_a(NBitsAdder_72_io_a),
    .io_b(NBitsAdder_72_io_b),
    .io_s(NBitsAdder_72_io_s)
  );
  NBitsAdder_64 NBitsAdder_73 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_73_clock),
    .io_a(NBitsAdder_73_io_a),
    .io_b(NBitsAdder_73_io_b),
    .io_s(NBitsAdder_73_io_s)
  );
  NBitsAdder_64 NBitsAdder_74 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_74_clock),
    .io_a(NBitsAdder_74_io_a),
    .io_b(NBitsAdder_74_io_b),
    .io_s(NBitsAdder_74_io_s)
  );
  NBitsAdder_64 NBitsAdder_75 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_75_clock),
    .io_a(NBitsAdder_75_io_a),
    .io_b(NBitsAdder_75_io_b),
    .io_s(NBitsAdder_75_io_s)
  );
  NBitsAdder_64 NBitsAdder_76 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_76_clock),
    .io_a(NBitsAdder_76_io_a),
    .io_b(NBitsAdder_76_io_b),
    .io_s(NBitsAdder_76_io_s)
  );
  NBitsAdder_64 NBitsAdder_77 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_77_clock),
    .io_a(NBitsAdder_77_io_a),
    .io_b(NBitsAdder_77_io_b),
    .io_s(NBitsAdder_77_io_s)
  );
  NBitsAdder_64 NBitsAdder_78 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_78_clock),
    .io_a(NBitsAdder_78_io_a),
    .io_b(NBitsAdder_78_io_b),
    .io_s(NBitsAdder_78_io_s)
  );
  NBitsAdder_64 NBitsAdder_79 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_79_clock),
    .io_a(NBitsAdder_79_io_a),
    .io_b(NBitsAdder_79_io_b),
    .io_s(NBitsAdder_79_io_s)
  );
  NBitsAdder_64 NBitsAdder_80 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_80_clock),
    .io_a(NBitsAdder_80_io_a),
    .io_b(NBitsAdder_80_io_b),
    .io_s(NBitsAdder_80_io_s)
  );
  NBitsAdder_64 NBitsAdder_81 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_81_clock),
    .io_a(NBitsAdder_81_io_a),
    .io_b(NBitsAdder_81_io_b),
    .io_s(NBitsAdder_81_io_s)
  );
  NBitsAdder_64 NBitsAdder_82 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_82_clock),
    .io_a(NBitsAdder_82_io_a),
    .io_b(NBitsAdder_82_io_b),
    .io_s(NBitsAdder_82_io_s)
  );
  NBitsAdder_64 NBitsAdder_83 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_83_clock),
    .io_a(NBitsAdder_83_io_a),
    .io_b(NBitsAdder_83_io_b),
    .io_s(NBitsAdder_83_io_s)
  );
  NBitsAdder_64 NBitsAdder_84 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_84_clock),
    .io_a(NBitsAdder_84_io_a),
    .io_b(NBitsAdder_84_io_b),
    .io_s(NBitsAdder_84_io_s)
  );
  NBitsAdder_64 NBitsAdder_85 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_85_clock),
    .io_a(NBitsAdder_85_io_a),
    .io_b(NBitsAdder_85_io_b),
    .io_s(NBitsAdder_85_io_s)
  );
  NBitsAdder_64 NBitsAdder_86 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_86_clock),
    .io_a(NBitsAdder_86_io_a),
    .io_b(NBitsAdder_86_io_b),
    .io_s(NBitsAdder_86_io_s)
  );
  NBitsAdder_64 NBitsAdder_87 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_87_clock),
    .io_a(NBitsAdder_87_io_a),
    .io_b(NBitsAdder_87_io_b),
    .io_s(NBitsAdder_87_io_s)
  );
  NBitsAdder_64 NBitsAdder_88 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_88_clock),
    .io_a(NBitsAdder_88_io_a),
    .io_b(NBitsAdder_88_io_b),
    .io_s(NBitsAdder_88_io_s)
  );
  NBitsAdder_64 NBitsAdder_89 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_89_clock),
    .io_a(NBitsAdder_89_io_a),
    .io_b(NBitsAdder_89_io_b),
    .io_s(NBitsAdder_89_io_s)
  );
  NBitsAdder_64 NBitsAdder_90 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_90_clock),
    .io_a(NBitsAdder_90_io_a),
    .io_b(NBitsAdder_90_io_b),
    .io_s(NBitsAdder_90_io_s)
  );
  NBitsAdder_64 NBitsAdder_91 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_91_clock),
    .io_a(NBitsAdder_91_io_a),
    .io_b(NBitsAdder_91_io_b),
    .io_s(NBitsAdder_91_io_s)
  );
  NBitsAdder_64 NBitsAdder_92 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_92_clock),
    .io_a(NBitsAdder_92_io_a),
    .io_b(NBitsAdder_92_io_b),
    .io_s(NBitsAdder_92_io_s)
  );
  NBitsAdder_64 NBitsAdder_93 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_93_clock),
    .io_a(NBitsAdder_93_io_a),
    .io_b(NBitsAdder_93_io_b),
    .io_s(NBitsAdder_93_io_s)
  );
  NBitsAdder_64 NBitsAdder_94 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_94_clock),
    .io_a(NBitsAdder_94_io_a),
    .io_b(NBitsAdder_94_io_b),
    .io_s(NBitsAdder_94_io_s)
  );
  NBitsAdder_64 NBitsAdder_95 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_95_clock),
    .io_a(NBitsAdder_95_io_a),
    .io_b(NBitsAdder_95_io_b),
    .io_s(NBitsAdder_95_io_s)
  );
  NBitsAdder_96 NBitsAdder_96 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_96_clock),
    .io_a(NBitsAdder_96_io_a),
    .io_b(NBitsAdder_96_io_b),
    .io_s(NBitsAdder_96_io_s)
  );
  NBitsAdder_96 NBitsAdder_97 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_97_clock),
    .io_a(NBitsAdder_97_io_a),
    .io_b(NBitsAdder_97_io_b),
    .io_s(NBitsAdder_97_io_s)
  );
  NBitsAdder_96 NBitsAdder_98 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_98_clock),
    .io_a(NBitsAdder_98_io_a),
    .io_b(NBitsAdder_98_io_b),
    .io_s(NBitsAdder_98_io_s)
  );
  NBitsAdder_96 NBitsAdder_99 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_99_clock),
    .io_a(NBitsAdder_99_io_a),
    .io_b(NBitsAdder_99_io_b),
    .io_s(NBitsAdder_99_io_s)
  );
  NBitsAdder_96 NBitsAdder_100 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_100_clock),
    .io_a(NBitsAdder_100_io_a),
    .io_b(NBitsAdder_100_io_b),
    .io_s(NBitsAdder_100_io_s)
  );
  NBitsAdder_96 NBitsAdder_101 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_101_clock),
    .io_a(NBitsAdder_101_io_a),
    .io_b(NBitsAdder_101_io_b),
    .io_s(NBitsAdder_101_io_s)
  );
  NBitsAdder_96 NBitsAdder_102 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_102_clock),
    .io_a(NBitsAdder_102_io_a),
    .io_b(NBitsAdder_102_io_b),
    .io_s(NBitsAdder_102_io_s)
  );
  NBitsAdder_96 NBitsAdder_103 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_103_clock),
    .io_a(NBitsAdder_103_io_a),
    .io_b(NBitsAdder_103_io_b),
    .io_s(NBitsAdder_103_io_s)
  );
  NBitsAdder_96 NBitsAdder_104 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_104_clock),
    .io_a(NBitsAdder_104_io_a),
    .io_b(NBitsAdder_104_io_b),
    .io_s(NBitsAdder_104_io_s)
  );
  NBitsAdder_96 NBitsAdder_105 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_105_clock),
    .io_a(NBitsAdder_105_io_a),
    .io_b(NBitsAdder_105_io_b),
    .io_s(NBitsAdder_105_io_s)
  );
  NBitsAdder_96 NBitsAdder_106 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_106_clock),
    .io_a(NBitsAdder_106_io_a),
    .io_b(NBitsAdder_106_io_b),
    .io_s(NBitsAdder_106_io_s)
  );
  NBitsAdder_96 NBitsAdder_107 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_107_clock),
    .io_a(NBitsAdder_107_io_a),
    .io_b(NBitsAdder_107_io_b),
    .io_s(NBitsAdder_107_io_s)
  );
  NBitsAdder_96 NBitsAdder_108 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_108_clock),
    .io_a(NBitsAdder_108_io_a),
    .io_b(NBitsAdder_108_io_b),
    .io_s(NBitsAdder_108_io_s)
  );
  NBitsAdder_96 NBitsAdder_109 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_109_clock),
    .io_a(NBitsAdder_109_io_a),
    .io_b(NBitsAdder_109_io_b),
    .io_s(NBitsAdder_109_io_s)
  );
  NBitsAdder_96 NBitsAdder_110 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_110_clock),
    .io_a(NBitsAdder_110_io_a),
    .io_b(NBitsAdder_110_io_b),
    .io_s(NBitsAdder_110_io_s)
  );
  NBitsAdder_96 NBitsAdder_111 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_111_clock),
    .io_a(NBitsAdder_111_io_a),
    .io_b(NBitsAdder_111_io_b),
    .io_s(NBitsAdder_111_io_s)
  );
  NBitsAdder_112 NBitsAdder_112 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_112_clock),
    .io_a(NBitsAdder_112_io_a),
    .io_b(NBitsAdder_112_io_b),
    .io_s(NBitsAdder_112_io_s)
  );
  NBitsAdder_112 NBitsAdder_113 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_113_clock),
    .io_a(NBitsAdder_113_io_a),
    .io_b(NBitsAdder_113_io_b),
    .io_s(NBitsAdder_113_io_s)
  );
  NBitsAdder_112 NBitsAdder_114 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_114_clock),
    .io_a(NBitsAdder_114_io_a),
    .io_b(NBitsAdder_114_io_b),
    .io_s(NBitsAdder_114_io_s)
  );
  NBitsAdder_112 NBitsAdder_115 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_115_clock),
    .io_a(NBitsAdder_115_io_a),
    .io_b(NBitsAdder_115_io_b),
    .io_s(NBitsAdder_115_io_s)
  );
  NBitsAdder_112 NBitsAdder_116 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_116_clock),
    .io_a(NBitsAdder_116_io_a),
    .io_b(NBitsAdder_116_io_b),
    .io_s(NBitsAdder_116_io_s)
  );
  NBitsAdder_112 NBitsAdder_117 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_117_clock),
    .io_a(NBitsAdder_117_io_a),
    .io_b(NBitsAdder_117_io_b),
    .io_s(NBitsAdder_117_io_s)
  );
  NBitsAdder_112 NBitsAdder_118 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_118_clock),
    .io_a(NBitsAdder_118_io_a),
    .io_b(NBitsAdder_118_io_b),
    .io_s(NBitsAdder_118_io_s)
  );
  NBitsAdder_112 NBitsAdder_119 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_119_clock),
    .io_a(NBitsAdder_119_io_a),
    .io_b(NBitsAdder_119_io_b),
    .io_s(NBitsAdder_119_io_s)
  );
  NBitsAdder_120 NBitsAdder_120 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_120_clock),
    .io_a(NBitsAdder_120_io_a),
    .io_b(NBitsAdder_120_io_b),
    .io_s(NBitsAdder_120_io_s)
  );
  NBitsAdder_120 NBitsAdder_121 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_121_clock),
    .io_a(NBitsAdder_121_io_a),
    .io_b(NBitsAdder_121_io_b),
    .io_s(NBitsAdder_121_io_s)
  );
  NBitsAdder_120 NBitsAdder_122 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_122_clock),
    .io_a(NBitsAdder_122_io_a),
    .io_b(NBitsAdder_122_io_b),
    .io_s(NBitsAdder_122_io_s)
  );
  NBitsAdder_120 NBitsAdder_123 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_123_clock),
    .io_a(NBitsAdder_123_io_a),
    .io_b(NBitsAdder_123_io_b),
    .io_s(NBitsAdder_123_io_s)
  );
  NBitsAdder_124 NBitsAdder_124 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_124_clock),
    .io_a(NBitsAdder_124_io_a),
    .io_b(NBitsAdder_124_io_b),
    .io_s(NBitsAdder_124_io_s)
  );
  NBitsAdder_124 NBitsAdder_125 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_125_clock),
    .io_a(NBitsAdder_125_io_a),
    .io_b(NBitsAdder_125_io_b),
    .io_s(NBitsAdder_125_io_s)
  );
  NBitsAdder_126 NBitsAdder_126 ( // @[AdderTree.scala 30:67]
    .clock(NBitsAdder_126_clock),
    .io_a(NBitsAdder_126_io_a),
    .io_b(NBitsAdder_126_io_b),
    .io_s(NBitsAdder_126_io_s)
  );
  assign io_sum = NBitsAdder_126_io_s; // @[AdderTree.scala 55:10]
  assign NBitsAdder_clock = clock;
  assign NBitsAdder_io_a = io_d_in_0; // @[AdderTree.scala 36:16]
  assign NBitsAdder_io_b = io_d_in_1; // @[AdderTree.scala 37:16]
  assign NBitsAdder_1_clock = clock;
  assign NBitsAdder_1_io_a = io_d_in_2; // @[AdderTree.scala 36:16]
  assign NBitsAdder_1_io_b = io_d_in_3; // @[AdderTree.scala 37:16]
  assign NBitsAdder_2_clock = clock;
  assign NBitsAdder_2_io_a = io_d_in_4; // @[AdderTree.scala 36:16]
  assign NBitsAdder_2_io_b = io_d_in_5; // @[AdderTree.scala 37:16]
  assign NBitsAdder_3_clock = clock;
  assign NBitsAdder_3_io_a = io_d_in_6; // @[AdderTree.scala 36:16]
  assign NBitsAdder_3_io_b = io_d_in_7; // @[AdderTree.scala 37:16]
  assign NBitsAdder_4_clock = clock;
  assign NBitsAdder_4_io_a = io_d_in_8; // @[AdderTree.scala 36:16]
  assign NBitsAdder_4_io_b = io_d_in_9; // @[AdderTree.scala 37:16]
  assign NBitsAdder_5_clock = clock;
  assign NBitsAdder_5_io_a = io_d_in_10; // @[AdderTree.scala 36:16]
  assign NBitsAdder_5_io_b = io_d_in_11; // @[AdderTree.scala 37:16]
  assign NBitsAdder_6_clock = clock;
  assign NBitsAdder_6_io_a = io_d_in_12; // @[AdderTree.scala 36:16]
  assign NBitsAdder_6_io_b = io_d_in_13; // @[AdderTree.scala 37:16]
  assign NBitsAdder_7_clock = clock;
  assign NBitsAdder_7_io_a = io_d_in_14; // @[AdderTree.scala 36:16]
  assign NBitsAdder_7_io_b = io_d_in_15; // @[AdderTree.scala 37:16]
  assign NBitsAdder_8_clock = clock;
  assign NBitsAdder_8_io_a = io_d_in_16; // @[AdderTree.scala 36:16]
  assign NBitsAdder_8_io_b = io_d_in_17; // @[AdderTree.scala 37:16]
  assign NBitsAdder_9_clock = clock;
  assign NBitsAdder_9_io_a = io_d_in_18; // @[AdderTree.scala 36:16]
  assign NBitsAdder_9_io_b = io_d_in_19; // @[AdderTree.scala 37:16]
  assign NBitsAdder_10_clock = clock;
  assign NBitsAdder_10_io_a = io_d_in_20; // @[AdderTree.scala 36:16]
  assign NBitsAdder_10_io_b = io_d_in_21; // @[AdderTree.scala 37:16]
  assign NBitsAdder_11_clock = clock;
  assign NBitsAdder_11_io_a = io_d_in_22; // @[AdderTree.scala 36:16]
  assign NBitsAdder_11_io_b = io_d_in_23; // @[AdderTree.scala 37:16]
  assign NBitsAdder_12_clock = clock;
  assign NBitsAdder_12_io_a = io_d_in_24; // @[AdderTree.scala 36:16]
  assign NBitsAdder_12_io_b = io_d_in_25; // @[AdderTree.scala 37:16]
  assign NBitsAdder_13_clock = clock;
  assign NBitsAdder_13_io_a = io_d_in_26; // @[AdderTree.scala 36:16]
  assign NBitsAdder_13_io_b = io_d_in_27; // @[AdderTree.scala 37:16]
  assign NBitsAdder_14_clock = clock;
  assign NBitsAdder_14_io_a = io_d_in_28; // @[AdderTree.scala 36:16]
  assign NBitsAdder_14_io_b = io_d_in_29; // @[AdderTree.scala 37:16]
  assign NBitsAdder_15_clock = clock;
  assign NBitsAdder_15_io_a = io_d_in_30; // @[AdderTree.scala 36:16]
  assign NBitsAdder_15_io_b = io_d_in_31; // @[AdderTree.scala 37:16]
  assign NBitsAdder_16_clock = clock;
  assign NBitsAdder_16_io_a = io_d_in_32; // @[AdderTree.scala 36:16]
  assign NBitsAdder_16_io_b = io_d_in_33; // @[AdderTree.scala 37:16]
  assign NBitsAdder_17_clock = clock;
  assign NBitsAdder_17_io_a = io_d_in_34; // @[AdderTree.scala 36:16]
  assign NBitsAdder_17_io_b = io_d_in_35; // @[AdderTree.scala 37:16]
  assign NBitsAdder_18_clock = clock;
  assign NBitsAdder_18_io_a = io_d_in_36; // @[AdderTree.scala 36:16]
  assign NBitsAdder_18_io_b = io_d_in_37; // @[AdderTree.scala 37:16]
  assign NBitsAdder_19_clock = clock;
  assign NBitsAdder_19_io_a = io_d_in_38; // @[AdderTree.scala 36:16]
  assign NBitsAdder_19_io_b = io_d_in_39; // @[AdderTree.scala 37:16]
  assign NBitsAdder_20_clock = clock;
  assign NBitsAdder_20_io_a = io_d_in_40; // @[AdderTree.scala 36:16]
  assign NBitsAdder_20_io_b = io_d_in_41; // @[AdderTree.scala 37:16]
  assign NBitsAdder_21_clock = clock;
  assign NBitsAdder_21_io_a = io_d_in_42; // @[AdderTree.scala 36:16]
  assign NBitsAdder_21_io_b = io_d_in_43; // @[AdderTree.scala 37:16]
  assign NBitsAdder_22_clock = clock;
  assign NBitsAdder_22_io_a = io_d_in_44; // @[AdderTree.scala 36:16]
  assign NBitsAdder_22_io_b = io_d_in_45; // @[AdderTree.scala 37:16]
  assign NBitsAdder_23_clock = clock;
  assign NBitsAdder_23_io_a = io_d_in_46; // @[AdderTree.scala 36:16]
  assign NBitsAdder_23_io_b = io_d_in_47; // @[AdderTree.scala 37:16]
  assign NBitsAdder_24_clock = clock;
  assign NBitsAdder_24_io_a = io_d_in_48; // @[AdderTree.scala 36:16]
  assign NBitsAdder_24_io_b = io_d_in_49; // @[AdderTree.scala 37:16]
  assign NBitsAdder_25_clock = clock;
  assign NBitsAdder_25_io_a = io_d_in_50; // @[AdderTree.scala 36:16]
  assign NBitsAdder_25_io_b = io_d_in_51; // @[AdderTree.scala 37:16]
  assign NBitsAdder_26_clock = clock;
  assign NBitsAdder_26_io_a = io_d_in_52; // @[AdderTree.scala 36:16]
  assign NBitsAdder_26_io_b = io_d_in_53; // @[AdderTree.scala 37:16]
  assign NBitsAdder_27_clock = clock;
  assign NBitsAdder_27_io_a = io_d_in_54; // @[AdderTree.scala 36:16]
  assign NBitsAdder_27_io_b = io_d_in_55; // @[AdderTree.scala 37:16]
  assign NBitsAdder_28_clock = clock;
  assign NBitsAdder_28_io_a = io_d_in_56; // @[AdderTree.scala 36:16]
  assign NBitsAdder_28_io_b = io_d_in_57; // @[AdderTree.scala 37:16]
  assign NBitsAdder_29_clock = clock;
  assign NBitsAdder_29_io_a = io_d_in_58; // @[AdderTree.scala 36:16]
  assign NBitsAdder_29_io_b = io_d_in_59; // @[AdderTree.scala 37:16]
  assign NBitsAdder_30_clock = clock;
  assign NBitsAdder_30_io_a = io_d_in_60; // @[AdderTree.scala 36:16]
  assign NBitsAdder_30_io_b = io_d_in_61; // @[AdderTree.scala 37:16]
  assign NBitsAdder_31_clock = clock;
  assign NBitsAdder_31_io_a = io_d_in_62; // @[AdderTree.scala 36:16]
  assign NBitsAdder_31_io_b = io_d_in_63; // @[AdderTree.scala 37:16]
  assign NBitsAdder_32_clock = clock;
  assign NBitsAdder_32_io_a = io_d_in_64; // @[AdderTree.scala 36:16]
  assign NBitsAdder_32_io_b = io_d_in_65; // @[AdderTree.scala 37:16]
  assign NBitsAdder_33_clock = clock;
  assign NBitsAdder_33_io_a = io_d_in_66; // @[AdderTree.scala 36:16]
  assign NBitsAdder_33_io_b = io_d_in_67; // @[AdderTree.scala 37:16]
  assign NBitsAdder_34_clock = clock;
  assign NBitsAdder_34_io_a = io_d_in_68; // @[AdderTree.scala 36:16]
  assign NBitsAdder_34_io_b = io_d_in_69; // @[AdderTree.scala 37:16]
  assign NBitsAdder_35_clock = clock;
  assign NBitsAdder_35_io_a = io_d_in_70; // @[AdderTree.scala 36:16]
  assign NBitsAdder_35_io_b = io_d_in_71; // @[AdderTree.scala 37:16]
  assign NBitsAdder_36_clock = clock;
  assign NBitsAdder_36_io_a = io_d_in_72; // @[AdderTree.scala 36:16]
  assign NBitsAdder_36_io_b = io_d_in_73; // @[AdderTree.scala 37:16]
  assign NBitsAdder_37_clock = clock;
  assign NBitsAdder_37_io_a = io_d_in_74; // @[AdderTree.scala 36:16]
  assign NBitsAdder_37_io_b = io_d_in_75; // @[AdderTree.scala 37:16]
  assign NBitsAdder_38_clock = clock;
  assign NBitsAdder_38_io_a = io_d_in_76; // @[AdderTree.scala 36:16]
  assign NBitsAdder_38_io_b = io_d_in_77; // @[AdderTree.scala 37:16]
  assign NBitsAdder_39_clock = clock;
  assign NBitsAdder_39_io_a = io_d_in_78; // @[AdderTree.scala 36:16]
  assign NBitsAdder_39_io_b = io_d_in_79; // @[AdderTree.scala 37:16]
  assign NBitsAdder_40_clock = clock;
  assign NBitsAdder_40_io_a = io_d_in_80; // @[AdderTree.scala 36:16]
  assign NBitsAdder_40_io_b = io_d_in_81; // @[AdderTree.scala 37:16]
  assign NBitsAdder_41_clock = clock;
  assign NBitsAdder_41_io_a = io_d_in_82; // @[AdderTree.scala 36:16]
  assign NBitsAdder_41_io_b = io_d_in_83; // @[AdderTree.scala 37:16]
  assign NBitsAdder_42_clock = clock;
  assign NBitsAdder_42_io_a = io_d_in_84; // @[AdderTree.scala 36:16]
  assign NBitsAdder_42_io_b = io_d_in_85; // @[AdderTree.scala 37:16]
  assign NBitsAdder_43_clock = clock;
  assign NBitsAdder_43_io_a = io_d_in_86; // @[AdderTree.scala 36:16]
  assign NBitsAdder_43_io_b = io_d_in_87; // @[AdderTree.scala 37:16]
  assign NBitsAdder_44_clock = clock;
  assign NBitsAdder_44_io_a = io_d_in_88; // @[AdderTree.scala 36:16]
  assign NBitsAdder_44_io_b = io_d_in_89; // @[AdderTree.scala 37:16]
  assign NBitsAdder_45_clock = clock;
  assign NBitsAdder_45_io_a = io_d_in_90; // @[AdderTree.scala 36:16]
  assign NBitsAdder_45_io_b = io_d_in_91; // @[AdderTree.scala 37:16]
  assign NBitsAdder_46_clock = clock;
  assign NBitsAdder_46_io_a = io_d_in_92; // @[AdderTree.scala 36:16]
  assign NBitsAdder_46_io_b = io_d_in_93; // @[AdderTree.scala 37:16]
  assign NBitsAdder_47_clock = clock;
  assign NBitsAdder_47_io_a = io_d_in_94; // @[AdderTree.scala 36:16]
  assign NBitsAdder_47_io_b = io_d_in_95; // @[AdderTree.scala 37:16]
  assign NBitsAdder_48_clock = clock;
  assign NBitsAdder_48_io_a = io_d_in_96; // @[AdderTree.scala 36:16]
  assign NBitsAdder_48_io_b = io_d_in_97; // @[AdderTree.scala 37:16]
  assign NBitsAdder_49_clock = clock;
  assign NBitsAdder_49_io_a = io_d_in_98; // @[AdderTree.scala 36:16]
  assign NBitsAdder_49_io_b = io_d_in_99; // @[AdderTree.scala 37:16]
  assign NBitsAdder_50_clock = clock;
  assign NBitsAdder_50_io_a = io_d_in_100; // @[AdderTree.scala 36:16]
  assign NBitsAdder_50_io_b = io_d_in_101; // @[AdderTree.scala 37:16]
  assign NBitsAdder_51_clock = clock;
  assign NBitsAdder_51_io_a = io_d_in_102; // @[AdderTree.scala 36:16]
  assign NBitsAdder_51_io_b = io_d_in_103; // @[AdderTree.scala 37:16]
  assign NBitsAdder_52_clock = clock;
  assign NBitsAdder_52_io_a = io_d_in_104; // @[AdderTree.scala 36:16]
  assign NBitsAdder_52_io_b = io_d_in_105; // @[AdderTree.scala 37:16]
  assign NBitsAdder_53_clock = clock;
  assign NBitsAdder_53_io_a = io_d_in_106; // @[AdderTree.scala 36:16]
  assign NBitsAdder_53_io_b = io_d_in_107; // @[AdderTree.scala 37:16]
  assign NBitsAdder_54_clock = clock;
  assign NBitsAdder_54_io_a = io_d_in_108; // @[AdderTree.scala 36:16]
  assign NBitsAdder_54_io_b = io_d_in_109; // @[AdderTree.scala 37:16]
  assign NBitsAdder_55_clock = clock;
  assign NBitsAdder_55_io_a = io_d_in_110; // @[AdderTree.scala 36:16]
  assign NBitsAdder_55_io_b = io_d_in_111; // @[AdderTree.scala 37:16]
  assign NBitsAdder_56_clock = clock;
  assign NBitsAdder_56_io_a = io_d_in_112; // @[AdderTree.scala 36:16]
  assign NBitsAdder_56_io_b = io_d_in_113; // @[AdderTree.scala 37:16]
  assign NBitsAdder_57_clock = clock;
  assign NBitsAdder_57_io_a = io_d_in_114; // @[AdderTree.scala 36:16]
  assign NBitsAdder_57_io_b = io_d_in_115; // @[AdderTree.scala 37:16]
  assign NBitsAdder_58_clock = clock;
  assign NBitsAdder_58_io_a = io_d_in_116; // @[AdderTree.scala 36:16]
  assign NBitsAdder_58_io_b = io_d_in_117; // @[AdderTree.scala 37:16]
  assign NBitsAdder_59_clock = clock;
  assign NBitsAdder_59_io_a = io_d_in_118; // @[AdderTree.scala 36:16]
  assign NBitsAdder_59_io_b = io_d_in_119; // @[AdderTree.scala 37:16]
  assign NBitsAdder_60_clock = clock;
  assign NBitsAdder_60_io_a = io_d_in_120; // @[AdderTree.scala 36:16]
  assign NBitsAdder_60_io_b = io_d_in_121; // @[AdderTree.scala 37:16]
  assign NBitsAdder_61_clock = clock;
  assign NBitsAdder_61_io_a = io_d_in_122; // @[AdderTree.scala 36:16]
  assign NBitsAdder_61_io_b = io_d_in_123; // @[AdderTree.scala 37:16]
  assign NBitsAdder_62_clock = clock;
  assign NBitsAdder_62_io_a = io_d_in_124; // @[AdderTree.scala 36:16]
  assign NBitsAdder_62_io_b = io_d_in_125; // @[AdderTree.scala 37:16]
  assign NBitsAdder_63_clock = clock;
  assign NBitsAdder_63_io_a = io_d_in_126; // @[AdderTree.scala 36:16]
  assign NBitsAdder_63_io_b = io_d_in_127; // @[AdderTree.scala 37:16]
  assign NBitsAdder_64_clock = clock;
  assign NBitsAdder_64_io_a = NBitsAdder_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_64_io_b = NBitsAdder_1_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_65_clock = clock;
  assign NBitsAdder_65_io_a = NBitsAdder_2_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_65_io_b = NBitsAdder_3_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_66_clock = clock;
  assign NBitsAdder_66_io_a = NBitsAdder_4_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_66_io_b = NBitsAdder_5_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_67_clock = clock;
  assign NBitsAdder_67_io_a = NBitsAdder_6_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_67_io_b = NBitsAdder_7_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_68_clock = clock;
  assign NBitsAdder_68_io_a = NBitsAdder_8_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_68_io_b = NBitsAdder_9_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_69_clock = clock;
  assign NBitsAdder_69_io_a = NBitsAdder_10_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_69_io_b = NBitsAdder_11_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_70_clock = clock;
  assign NBitsAdder_70_io_a = NBitsAdder_12_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_70_io_b = NBitsAdder_13_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_71_clock = clock;
  assign NBitsAdder_71_io_a = NBitsAdder_14_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_71_io_b = NBitsAdder_15_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_72_clock = clock;
  assign NBitsAdder_72_io_a = NBitsAdder_16_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_72_io_b = NBitsAdder_17_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_73_clock = clock;
  assign NBitsAdder_73_io_a = NBitsAdder_18_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_73_io_b = NBitsAdder_19_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_74_clock = clock;
  assign NBitsAdder_74_io_a = NBitsAdder_20_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_74_io_b = NBitsAdder_21_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_75_clock = clock;
  assign NBitsAdder_75_io_a = NBitsAdder_22_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_75_io_b = NBitsAdder_23_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_76_clock = clock;
  assign NBitsAdder_76_io_a = NBitsAdder_24_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_76_io_b = NBitsAdder_25_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_77_clock = clock;
  assign NBitsAdder_77_io_a = NBitsAdder_26_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_77_io_b = NBitsAdder_27_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_78_clock = clock;
  assign NBitsAdder_78_io_a = NBitsAdder_28_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_78_io_b = NBitsAdder_29_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_79_clock = clock;
  assign NBitsAdder_79_io_a = NBitsAdder_30_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_79_io_b = NBitsAdder_31_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_80_clock = clock;
  assign NBitsAdder_80_io_a = NBitsAdder_32_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_80_io_b = NBitsAdder_33_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_81_clock = clock;
  assign NBitsAdder_81_io_a = NBitsAdder_34_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_81_io_b = NBitsAdder_35_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_82_clock = clock;
  assign NBitsAdder_82_io_a = NBitsAdder_36_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_82_io_b = NBitsAdder_37_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_83_clock = clock;
  assign NBitsAdder_83_io_a = NBitsAdder_38_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_83_io_b = NBitsAdder_39_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_84_clock = clock;
  assign NBitsAdder_84_io_a = NBitsAdder_40_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_84_io_b = NBitsAdder_41_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_85_clock = clock;
  assign NBitsAdder_85_io_a = NBitsAdder_42_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_85_io_b = NBitsAdder_43_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_86_clock = clock;
  assign NBitsAdder_86_io_a = NBitsAdder_44_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_86_io_b = NBitsAdder_45_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_87_clock = clock;
  assign NBitsAdder_87_io_a = NBitsAdder_46_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_87_io_b = NBitsAdder_47_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_88_clock = clock;
  assign NBitsAdder_88_io_a = NBitsAdder_48_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_88_io_b = NBitsAdder_49_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_89_clock = clock;
  assign NBitsAdder_89_io_a = NBitsAdder_50_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_89_io_b = NBitsAdder_51_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_90_clock = clock;
  assign NBitsAdder_90_io_a = NBitsAdder_52_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_90_io_b = NBitsAdder_53_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_91_clock = clock;
  assign NBitsAdder_91_io_a = NBitsAdder_54_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_91_io_b = NBitsAdder_55_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_92_clock = clock;
  assign NBitsAdder_92_io_a = NBitsAdder_56_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_92_io_b = NBitsAdder_57_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_93_clock = clock;
  assign NBitsAdder_93_io_a = NBitsAdder_58_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_93_io_b = NBitsAdder_59_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_94_clock = clock;
  assign NBitsAdder_94_io_a = NBitsAdder_60_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_94_io_b = NBitsAdder_61_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_95_clock = clock;
  assign NBitsAdder_95_io_a = NBitsAdder_62_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_95_io_b = NBitsAdder_63_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_96_clock = clock;
  assign NBitsAdder_96_io_a = NBitsAdder_64_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_96_io_b = NBitsAdder_65_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_97_clock = clock;
  assign NBitsAdder_97_io_a = NBitsAdder_66_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_97_io_b = NBitsAdder_67_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_98_clock = clock;
  assign NBitsAdder_98_io_a = NBitsAdder_68_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_98_io_b = NBitsAdder_69_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_99_clock = clock;
  assign NBitsAdder_99_io_a = NBitsAdder_70_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_99_io_b = NBitsAdder_71_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_100_clock = clock;
  assign NBitsAdder_100_io_a = NBitsAdder_72_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_100_io_b = NBitsAdder_73_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_101_clock = clock;
  assign NBitsAdder_101_io_a = NBitsAdder_74_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_101_io_b = NBitsAdder_75_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_102_clock = clock;
  assign NBitsAdder_102_io_a = NBitsAdder_76_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_102_io_b = NBitsAdder_77_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_103_clock = clock;
  assign NBitsAdder_103_io_a = NBitsAdder_78_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_103_io_b = NBitsAdder_79_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_104_clock = clock;
  assign NBitsAdder_104_io_a = NBitsAdder_80_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_104_io_b = NBitsAdder_81_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_105_clock = clock;
  assign NBitsAdder_105_io_a = NBitsAdder_82_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_105_io_b = NBitsAdder_83_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_106_clock = clock;
  assign NBitsAdder_106_io_a = NBitsAdder_84_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_106_io_b = NBitsAdder_85_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_107_clock = clock;
  assign NBitsAdder_107_io_a = NBitsAdder_86_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_107_io_b = NBitsAdder_87_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_108_clock = clock;
  assign NBitsAdder_108_io_a = NBitsAdder_88_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_108_io_b = NBitsAdder_89_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_109_clock = clock;
  assign NBitsAdder_109_io_a = NBitsAdder_90_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_109_io_b = NBitsAdder_91_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_110_clock = clock;
  assign NBitsAdder_110_io_a = NBitsAdder_92_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_110_io_b = NBitsAdder_93_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_111_clock = clock;
  assign NBitsAdder_111_io_a = NBitsAdder_94_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_111_io_b = NBitsAdder_95_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_112_clock = clock;
  assign NBitsAdder_112_io_a = NBitsAdder_96_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_112_io_b = NBitsAdder_97_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_113_clock = clock;
  assign NBitsAdder_113_io_a = NBitsAdder_98_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_113_io_b = NBitsAdder_99_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_114_clock = clock;
  assign NBitsAdder_114_io_a = NBitsAdder_100_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_114_io_b = NBitsAdder_101_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_115_clock = clock;
  assign NBitsAdder_115_io_a = NBitsAdder_102_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_115_io_b = NBitsAdder_103_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_116_clock = clock;
  assign NBitsAdder_116_io_a = NBitsAdder_104_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_116_io_b = NBitsAdder_105_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_117_clock = clock;
  assign NBitsAdder_117_io_a = NBitsAdder_106_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_117_io_b = NBitsAdder_107_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_118_clock = clock;
  assign NBitsAdder_118_io_a = NBitsAdder_108_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_118_io_b = NBitsAdder_109_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_119_clock = clock;
  assign NBitsAdder_119_io_a = NBitsAdder_110_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_119_io_b = NBitsAdder_111_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_120_clock = clock;
  assign NBitsAdder_120_io_a = NBitsAdder_112_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_120_io_b = NBitsAdder_113_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_121_clock = clock;
  assign NBitsAdder_121_io_a = NBitsAdder_114_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_121_io_b = NBitsAdder_115_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_122_clock = clock;
  assign NBitsAdder_122_io_a = NBitsAdder_116_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_122_io_b = NBitsAdder_117_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_123_clock = clock;
  assign NBitsAdder_123_io_a = NBitsAdder_118_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_123_io_b = NBitsAdder_119_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_124_clock = clock;
  assign NBitsAdder_124_io_a = NBitsAdder_120_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_124_io_b = NBitsAdder_121_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_125_clock = clock;
  assign NBitsAdder_125_io_a = NBitsAdder_122_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_125_io_b = NBitsAdder_123_io_s; // @[AdderTree.scala 48:18]
  assign NBitsAdder_126_clock = clock;
  assign NBitsAdder_126_io_a = NBitsAdder_124_io_s; // @[AdderTree.scala 47:18]
  assign NBitsAdder_126_io_b = NBitsAdder_125_io_s; // @[AdderTree.scala 48:18]
endmodule
module Array_8x128(
  input          clock,
  input  [127:0] io_WL,
  input  [127:0] io_IN,
  input  [7:0]   io_BL,
  output [14:0]  io_MAC
);
  wire  line_cell_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_1_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_1_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_1_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_2_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_2_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_2_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_3_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_3_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_3_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_4_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_4_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_4_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_5_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_5_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_5_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_6_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_6_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_6_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_clock; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_7_io_WL; // @[Array_8x128.scala 17:55]
  wire [127:0] line_cell_7_io_IN; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_BL; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_0; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_1; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_2; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_3; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_4; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_5; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_6; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_7; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_8; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_9; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_10; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_11; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_12; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_13; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_14; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_15; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_16; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_17; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_18; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_19; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_20; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_21; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_22; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_23; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_24; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_25; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_26; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_27; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_28; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_29; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_30; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_31; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_32; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_33; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_34; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_35; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_36; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_37; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_38; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_39; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_40; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_41; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_42; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_43; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_44; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_45; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_46; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_47; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_48; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_49; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_50; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_51; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_52; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_53; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_54; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_55; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_56; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_57; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_58; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_59; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_60; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_61; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_62; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_63; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_64; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_65; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_66; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_67; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_68; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_69; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_70; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_71; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_72; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_73; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_74; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_75; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_76; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_77; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_78; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_79; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_80; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_81; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_82; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_83; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_84; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_85; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_86; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_87; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_88; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_89; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_90; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_91; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_92; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_93; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_94; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_95; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_96; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_97; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_98; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_99; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_100; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_101; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_102; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_103; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_104; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_105; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_106; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_107; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_108; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_109; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_110; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_111; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_112; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_113; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_114; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_115; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_116; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_117; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_118; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_119; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_120; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_121; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_122; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_123; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_124; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_125; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_126; // @[Array_8x128.scala 17:55]
  wire  line_cell_7_io_Vout_127; // @[Array_8x128.scala 17:55]
  wire  U_AdderTree_clock; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_0; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_1; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_2; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_3; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_4; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_5; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_6; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_7; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_8; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_9; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_10; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_11; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_12; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_13; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_14; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_15; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_16; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_17; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_18; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_19; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_20; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_21; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_22; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_23; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_24; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_25; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_26; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_27; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_28; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_29; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_30; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_31; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_32; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_33; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_34; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_35; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_36; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_37; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_38; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_39; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_40; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_41; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_42; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_43; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_44; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_45; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_46; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_47; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_48; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_49; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_50; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_51; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_52; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_53; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_54; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_55; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_56; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_57; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_58; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_59; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_60; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_61; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_62; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_63; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_64; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_65; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_66; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_67; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_68; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_69; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_70; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_71; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_72; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_73; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_74; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_75; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_76; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_77; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_78; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_79; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_80; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_81; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_82; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_83; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_84; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_85; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_86; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_87; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_88; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_89; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_90; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_91; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_92; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_93; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_94; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_95; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_96; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_97; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_98; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_99; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_100; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_101; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_102; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_103; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_104; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_105; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_106; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_107; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_108; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_109; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_110; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_111; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_112; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_113; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_114; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_115; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_116; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_117; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_118; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_119; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_120; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_121; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_122; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_123; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_124; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_125; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_126; // @[Array_8x128.scala 28:27]
  wire [7:0] U_AdderTree_io_d_in_127; // @[Array_8x128.scala 28:27]
  wire [14:0] U_AdderTree_io_sum; // @[Array_8x128.scala 28:27]
  wire  u_line_cell_1_Vout_0 = line_cell_1_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_0 = line_cell_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_0 = line_cell_3_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_0 = line_cell_2_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_0_lo = {u_line_cell_3_Vout_0,u_line_cell_2_Vout_0,u_line_cell_1_Vout_0,
    u_line_cell_0_Vout_0}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_0 = line_cell_5_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_0 = line_cell_4_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_0 = line_cell_7_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_0 = line_cell_6_io_Vout_0; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_0_hi = {u_line_cell_7_Vout_0,u_line_cell_6_Vout_0,u_line_cell_5_Vout_0,
    u_line_cell_4_Vout_0}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_1 = line_cell_1_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_1 = line_cell_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_1 = line_cell_3_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_1 = line_cell_2_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_1_lo = {u_line_cell_3_Vout_1,u_line_cell_2_Vout_1,u_line_cell_1_Vout_1,
    u_line_cell_0_Vout_1}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_1 = line_cell_5_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_1 = line_cell_4_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_1 = line_cell_7_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_1 = line_cell_6_io_Vout_1; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_1_hi = {u_line_cell_7_Vout_1,u_line_cell_6_Vout_1,u_line_cell_5_Vout_1,
    u_line_cell_4_Vout_1}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_2 = line_cell_1_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_2 = line_cell_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_2 = line_cell_3_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_2 = line_cell_2_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_2_lo = {u_line_cell_3_Vout_2,u_line_cell_2_Vout_2,u_line_cell_1_Vout_2,
    u_line_cell_0_Vout_2}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_2 = line_cell_5_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_2 = line_cell_4_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_2 = line_cell_7_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_2 = line_cell_6_io_Vout_2; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_2_hi = {u_line_cell_7_Vout_2,u_line_cell_6_Vout_2,u_line_cell_5_Vout_2,
    u_line_cell_4_Vout_2}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_3 = line_cell_1_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_3 = line_cell_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_3 = line_cell_3_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_3 = line_cell_2_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_3_lo = {u_line_cell_3_Vout_3,u_line_cell_2_Vout_3,u_line_cell_1_Vout_3,
    u_line_cell_0_Vout_3}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_3 = line_cell_5_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_3 = line_cell_4_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_3 = line_cell_7_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_3 = line_cell_6_io_Vout_3; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_3_hi = {u_line_cell_7_Vout_3,u_line_cell_6_Vout_3,u_line_cell_5_Vout_3,
    u_line_cell_4_Vout_3}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_4 = line_cell_1_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_4 = line_cell_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_4 = line_cell_3_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_4 = line_cell_2_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_4_lo = {u_line_cell_3_Vout_4,u_line_cell_2_Vout_4,u_line_cell_1_Vout_4,
    u_line_cell_0_Vout_4}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_4 = line_cell_5_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_4 = line_cell_4_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_4 = line_cell_7_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_4 = line_cell_6_io_Vout_4; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_4_hi = {u_line_cell_7_Vout_4,u_line_cell_6_Vout_4,u_line_cell_5_Vout_4,
    u_line_cell_4_Vout_4}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_5 = line_cell_1_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_5 = line_cell_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_5 = line_cell_3_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_5 = line_cell_2_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_5_lo = {u_line_cell_3_Vout_5,u_line_cell_2_Vout_5,u_line_cell_1_Vout_5,
    u_line_cell_0_Vout_5}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_5 = line_cell_5_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_5 = line_cell_4_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_5 = line_cell_7_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_5 = line_cell_6_io_Vout_5; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_5_hi = {u_line_cell_7_Vout_5,u_line_cell_6_Vout_5,u_line_cell_5_Vout_5,
    u_line_cell_4_Vout_5}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_6 = line_cell_1_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_6 = line_cell_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_6 = line_cell_3_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_6 = line_cell_2_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_6_lo = {u_line_cell_3_Vout_6,u_line_cell_2_Vout_6,u_line_cell_1_Vout_6,
    u_line_cell_0_Vout_6}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_6 = line_cell_5_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_6 = line_cell_4_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_6 = line_cell_7_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_6 = line_cell_6_io_Vout_6; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_6_hi = {u_line_cell_7_Vout_6,u_line_cell_6_Vout_6,u_line_cell_5_Vout_6,
    u_line_cell_4_Vout_6}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_7 = line_cell_1_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_7 = line_cell_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_7 = line_cell_3_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_7 = line_cell_2_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_7_lo = {u_line_cell_3_Vout_7,u_line_cell_2_Vout_7,u_line_cell_1_Vout_7,
    u_line_cell_0_Vout_7}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_7 = line_cell_5_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_7 = line_cell_4_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_7 = line_cell_7_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_7 = line_cell_6_io_Vout_7; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_7_hi = {u_line_cell_7_Vout_7,u_line_cell_6_Vout_7,u_line_cell_5_Vout_7,
    u_line_cell_4_Vout_7}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_8 = line_cell_1_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_8 = line_cell_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_8 = line_cell_3_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_8 = line_cell_2_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_8_lo = {u_line_cell_3_Vout_8,u_line_cell_2_Vout_8,u_line_cell_1_Vout_8,
    u_line_cell_0_Vout_8}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_8 = line_cell_5_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_8 = line_cell_4_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_8 = line_cell_7_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_8 = line_cell_6_io_Vout_8; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_8_hi = {u_line_cell_7_Vout_8,u_line_cell_6_Vout_8,u_line_cell_5_Vout_8,
    u_line_cell_4_Vout_8}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_9 = line_cell_1_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_9 = line_cell_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_9 = line_cell_3_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_9 = line_cell_2_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_9_lo = {u_line_cell_3_Vout_9,u_line_cell_2_Vout_9,u_line_cell_1_Vout_9,
    u_line_cell_0_Vout_9}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_9 = line_cell_5_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_9 = line_cell_4_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_9 = line_cell_7_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_9 = line_cell_6_io_Vout_9; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_9_hi = {u_line_cell_7_Vout_9,u_line_cell_6_Vout_9,u_line_cell_5_Vout_9,
    u_line_cell_4_Vout_9}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_10 = line_cell_1_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_10 = line_cell_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_10 = line_cell_3_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_10 = line_cell_2_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_10_lo = {u_line_cell_3_Vout_10,u_line_cell_2_Vout_10,u_line_cell_1_Vout_10,
    u_line_cell_0_Vout_10}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_10 = line_cell_5_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_10 = line_cell_4_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_10 = line_cell_7_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_10 = line_cell_6_io_Vout_10; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_10_hi = {u_line_cell_7_Vout_10,u_line_cell_6_Vout_10,u_line_cell_5_Vout_10,
    u_line_cell_4_Vout_10}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_11 = line_cell_1_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_11 = line_cell_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_11 = line_cell_3_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_11 = line_cell_2_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_11_lo = {u_line_cell_3_Vout_11,u_line_cell_2_Vout_11,u_line_cell_1_Vout_11,
    u_line_cell_0_Vout_11}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_11 = line_cell_5_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_11 = line_cell_4_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_11 = line_cell_7_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_11 = line_cell_6_io_Vout_11; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_11_hi = {u_line_cell_7_Vout_11,u_line_cell_6_Vout_11,u_line_cell_5_Vout_11,
    u_line_cell_4_Vout_11}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_12 = line_cell_1_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_12 = line_cell_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_12 = line_cell_3_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_12 = line_cell_2_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_12_lo = {u_line_cell_3_Vout_12,u_line_cell_2_Vout_12,u_line_cell_1_Vout_12,
    u_line_cell_0_Vout_12}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_12 = line_cell_5_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_12 = line_cell_4_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_12 = line_cell_7_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_12 = line_cell_6_io_Vout_12; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_12_hi = {u_line_cell_7_Vout_12,u_line_cell_6_Vout_12,u_line_cell_5_Vout_12,
    u_line_cell_4_Vout_12}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_13 = line_cell_1_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_13 = line_cell_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_13 = line_cell_3_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_13 = line_cell_2_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_13_lo = {u_line_cell_3_Vout_13,u_line_cell_2_Vout_13,u_line_cell_1_Vout_13,
    u_line_cell_0_Vout_13}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_13 = line_cell_5_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_13 = line_cell_4_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_13 = line_cell_7_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_13 = line_cell_6_io_Vout_13; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_13_hi = {u_line_cell_7_Vout_13,u_line_cell_6_Vout_13,u_line_cell_5_Vout_13,
    u_line_cell_4_Vout_13}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_14 = line_cell_1_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_14 = line_cell_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_14 = line_cell_3_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_14 = line_cell_2_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_14_lo = {u_line_cell_3_Vout_14,u_line_cell_2_Vout_14,u_line_cell_1_Vout_14,
    u_line_cell_0_Vout_14}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_14 = line_cell_5_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_14 = line_cell_4_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_14 = line_cell_7_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_14 = line_cell_6_io_Vout_14; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_14_hi = {u_line_cell_7_Vout_14,u_line_cell_6_Vout_14,u_line_cell_5_Vout_14,
    u_line_cell_4_Vout_14}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_15 = line_cell_1_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_15 = line_cell_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_15 = line_cell_3_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_15 = line_cell_2_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_15_lo = {u_line_cell_3_Vout_15,u_line_cell_2_Vout_15,u_line_cell_1_Vout_15,
    u_line_cell_0_Vout_15}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_15 = line_cell_5_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_15 = line_cell_4_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_15 = line_cell_7_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_15 = line_cell_6_io_Vout_15; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_15_hi = {u_line_cell_7_Vout_15,u_line_cell_6_Vout_15,u_line_cell_5_Vout_15,
    u_line_cell_4_Vout_15}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_16 = line_cell_1_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_16 = line_cell_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_16 = line_cell_3_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_16 = line_cell_2_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_16_lo = {u_line_cell_3_Vout_16,u_line_cell_2_Vout_16,u_line_cell_1_Vout_16,
    u_line_cell_0_Vout_16}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_16 = line_cell_5_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_16 = line_cell_4_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_16 = line_cell_7_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_16 = line_cell_6_io_Vout_16; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_16_hi = {u_line_cell_7_Vout_16,u_line_cell_6_Vout_16,u_line_cell_5_Vout_16,
    u_line_cell_4_Vout_16}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_17 = line_cell_1_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_17 = line_cell_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_17 = line_cell_3_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_17 = line_cell_2_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_17_lo = {u_line_cell_3_Vout_17,u_line_cell_2_Vout_17,u_line_cell_1_Vout_17,
    u_line_cell_0_Vout_17}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_17 = line_cell_5_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_17 = line_cell_4_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_17 = line_cell_7_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_17 = line_cell_6_io_Vout_17; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_17_hi = {u_line_cell_7_Vout_17,u_line_cell_6_Vout_17,u_line_cell_5_Vout_17,
    u_line_cell_4_Vout_17}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_18 = line_cell_1_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_18 = line_cell_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_18 = line_cell_3_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_18 = line_cell_2_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_18_lo = {u_line_cell_3_Vout_18,u_line_cell_2_Vout_18,u_line_cell_1_Vout_18,
    u_line_cell_0_Vout_18}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_18 = line_cell_5_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_18 = line_cell_4_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_18 = line_cell_7_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_18 = line_cell_6_io_Vout_18; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_18_hi = {u_line_cell_7_Vout_18,u_line_cell_6_Vout_18,u_line_cell_5_Vout_18,
    u_line_cell_4_Vout_18}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_19 = line_cell_1_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_19 = line_cell_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_19 = line_cell_3_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_19 = line_cell_2_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_19_lo = {u_line_cell_3_Vout_19,u_line_cell_2_Vout_19,u_line_cell_1_Vout_19,
    u_line_cell_0_Vout_19}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_19 = line_cell_5_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_19 = line_cell_4_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_19 = line_cell_7_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_19 = line_cell_6_io_Vout_19; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_19_hi = {u_line_cell_7_Vout_19,u_line_cell_6_Vout_19,u_line_cell_5_Vout_19,
    u_line_cell_4_Vout_19}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_20 = line_cell_1_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_20 = line_cell_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_20 = line_cell_3_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_20 = line_cell_2_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_20_lo = {u_line_cell_3_Vout_20,u_line_cell_2_Vout_20,u_line_cell_1_Vout_20,
    u_line_cell_0_Vout_20}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_20 = line_cell_5_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_20 = line_cell_4_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_20 = line_cell_7_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_20 = line_cell_6_io_Vout_20; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_20_hi = {u_line_cell_7_Vout_20,u_line_cell_6_Vout_20,u_line_cell_5_Vout_20,
    u_line_cell_4_Vout_20}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_21 = line_cell_1_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_21 = line_cell_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_21 = line_cell_3_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_21 = line_cell_2_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_21_lo = {u_line_cell_3_Vout_21,u_line_cell_2_Vout_21,u_line_cell_1_Vout_21,
    u_line_cell_0_Vout_21}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_21 = line_cell_5_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_21 = line_cell_4_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_21 = line_cell_7_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_21 = line_cell_6_io_Vout_21; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_21_hi = {u_line_cell_7_Vout_21,u_line_cell_6_Vout_21,u_line_cell_5_Vout_21,
    u_line_cell_4_Vout_21}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_22 = line_cell_1_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_22 = line_cell_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_22 = line_cell_3_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_22 = line_cell_2_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_22_lo = {u_line_cell_3_Vout_22,u_line_cell_2_Vout_22,u_line_cell_1_Vout_22,
    u_line_cell_0_Vout_22}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_22 = line_cell_5_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_22 = line_cell_4_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_22 = line_cell_7_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_22 = line_cell_6_io_Vout_22; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_22_hi = {u_line_cell_7_Vout_22,u_line_cell_6_Vout_22,u_line_cell_5_Vout_22,
    u_line_cell_4_Vout_22}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_23 = line_cell_1_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_23 = line_cell_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_23 = line_cell_3_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_23 = line_cell_2_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_23_lo = {u_line_cell_3_Vout_23,u_line_cell_2_Vout_23,u_line_cell_1_Vout_23,
    u_line_cell_0_Vout_23}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_23 = line_cell_5_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_23 = line_cell_4_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_23 = line_cell_7_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_23 = line_cell_6_io_Vout_23; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_23_hi = {u_line_cell_7_Vout_23,u_line_cell_6_Vout_23,u_line_cell_5_Vout_23,
    u_line_cell_4_Vout_23}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_24 = line_cell_1_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_24 = line_cell_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_24 = line_cell_3_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_24 = line_cell_2_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_24_lo = {u_line_cell_3_Vout_24,u_line_cell_2_Vout_24,u_line_cell_1_Vout_24,
    u_line_cell_0_Vout_24}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_24 = line_cell_5_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_24 = line_cell_4_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_24 = line_cell_7_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_24 = line_cell_6_io_Vout_24; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_24_hi = {u_line_cell_7_Vout_24,u_line_cell_6_Vout_24,u_line_cell_5_Vout_24,
    u_line_cell_4_Vout_24}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_25 = line_cell_1_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_25 = line_cell_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_25 = line_cell_3_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_25 = line_cell_2_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_25_lo = {u_line_cell_3_Vout_25,u_line_cell_2_Vout_25,u_line_cell_1_Vout_25,
    u_line_cell_0_Vout_25}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_25 = line_cell_5_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_25 = line_cell_4_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_25 = line_cell_7_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_25 = line_cell_6_io_Vout_25; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_25_hi = {u_line_cell_7_Vout_25,u_line_cell_6_Vout_25,u_line_cell_5_Vout_25,
    u_line_cell_4_Vout_25}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_26 = line_cell_1_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_26 = line_cell_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_26 = line_cell_3_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_26 = line_cell_2_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_26_lo = {u_line_cell_3_Vout_26,u_line_cell_2_Vout_26,u_line_cell_1_Vout_26,
    u_line_cell_0_Vout_26}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_26 = line_cell_5_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_26 = line_cell_4_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_26 = line_cell_7_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_26 = line_cell_6_io_Vout_26; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_26_hi = {u_line_cell_7_Vout_26,u_line_cell_6_Vout_26,u_line_cell_5_Vout_26,
    u_line_cell_4_Vout_26}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_27 = line_cell_1_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_27 = line_cell_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_27 = line_cell_3_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_27 = line_cell_2_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_27_lo = {u_line_cell_3_Vout_27,u_line_cell_2_Vout_27,u_line_cell_1_Vout_27,
    u_line_cell_0_Vout_27}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_27 = line_cell_5_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_27 = line_cell_4_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_27 = line_cell_7_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_27 = line_cell_6_io_Vout_27; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_27_hi = {u_line_cell_7_Vout_27,u_line_cell_6_Vout_27,u_line_cell_5_Vout_27,
    u_line_cell_4_Vout_27}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_28 = line_cell_1_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_28 = line_cell_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_28 = line_cell_3_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_28 = line_cell_2_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_28_lo = {u_line_cell_3_Vout_28,u_line_cell_2_Vout_28,u_line_cell_1_Vout_28,
    u_line_cell_0_Vout_28}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_28 = line_cell_5_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_28 = line_cell_4_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_28 = line_cell_7_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_28 = line_cell_6_io_Vout_28; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_28_hi = {u_line_cell_7_Vout_28,u_line_cell_6_Vout_28,u_line_cell_5_Vout_28,
    u_line_cell_4_Vout_28}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_29 = line_cell_1_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_29 = line_cell_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_29 = line_cell_3_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_29 = line_cell_2_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_29_lo = {u_line_cell_3_Vout_29,u_line_cell_2_Vout_29,u_line_cell_1_Vout_29,
    u_line_cell_0_Vout_29}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_29 = line_cell_5_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_29 = line_cell_4_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_29 = line_cell_7_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_29 = line_cell_6_io_Vout_29; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_29_hi = {u_line_cell_7_Vout_29,u_line_cell_6_Vout_29,u_line_cell_5_Vout_29,
    u_line_cell_4_Vout_29}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_30 = line_cell_1_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_30 = line_cell_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_30 = line_cell_3_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_30 = line_cell_2_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_30_lo = {u_line_cell_3_Vout_30,u_line_cell_2_Vout_30,u_line_cell_1_Vout_30,
    u_line_cell_0_Vout_30}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_30 = line_cell_5_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_30 = line_cell_4_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_30 = line_cell_7_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_30 = line_cell_6_io_Vout_30; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_30_hi = {u_line_cell_7_Vout_30,u_line_cell_6_Vout_30,u_line_cell_5_Vout_30,
    u_line_cell_4_Vout_30}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_31 = line_cell_1_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_31 = line_cell_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_31 = line_cell_3_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_31 = line_cell_2_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_31_lo = {u_line_cell_3_Vout_31,u_line_cell_2_Vout_31,u_line_cell_1_Vout_31,
    u_line_cell_0_Vout_31}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_31 = line_cell_5_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_31 = line_cell_4_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_31 = line_cell_7_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_31 = line_cell_6_io_Vout_31; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_31_hi = {u_line_cell_7_Vout_31,u_line_cell_6_Vout_31,u_line_cell_5_Vout_31,
    u_line_cell_4_Vout_31}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_32 = line_cell_1_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_32 = line_cell_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_32 = line_cell_3_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_32 = line_cell_2_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_32_lo = {u_line_cell_3_Vout_32,u_line_cell_2_Vout_32,u_line_cell_1_Vout_32,
    u_line_cell_0_Vout_32}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_32 = line_cell_5_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_32 = line_cell_4_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_32 = line_cell_7_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_32 = line_cell_6_io_Vout_32; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_32_hi = {u_line_cell_7_Vout_32,u_line_cell_6_Vout_32,u_line_cell_5_Vout_32,
    u_line_cell_4_Vout_32}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_33 = line_cell_1_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_33 = line_cell_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_33 = line_cell_3_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_33 = line_cell_2_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_33_lo = {u_line_cell_3_Vout_33,u_line_cell_2_Vout_33,u_line_cell_1_Vout_33,
    u_line_cell_0_Vout_33}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_33 = line_cell_5_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_33 = line_cell_4_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_33 = line_cell_7_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_33 = line_cell_6_io_Vout_33; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_33_hi = {u_line_cell_7_Vout_33,u_line_cell_6_Vout_33,u_line_cell_5_Vout_33,
    u_line_cell_4_Vout_33}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_34 = line_cell_1_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_34 = line_cell_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_34 = line_cell_3_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_34 = line_cell_2_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_34_lo = {u_line_cell_3_Vout_34,u_line_cell_2_Vout_34,u_line_cell_1_Vout_34,
    u_line_cell_0_Vout_34}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_34 = line_cell_5_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_34 = line_cell_4_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_34 = line_cell_7_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_34 = line_cell_6_io_Vout_34; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_34_hi = {u_line_cell_7_Vout_34,u_line_cell_6_Vout_34,u_line_cell_5_Vout_34,
    u_line_cell_4_Vout_34}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_35 = line_cell_1_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_35 = line_cell_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_35 = line_cell_3_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_35 = line_cell_2_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_35_lo = {u_line_cell_3_Vout_35,u_line_cell_2_Vout_35,u_line_cell_1_Vout_35,
    u_line_cell_0_Vout_35}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_35 = line_cell_5_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_35 = line_cell_4_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_35 = line_cell_7_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_35 = line_cell_6_io_Vout_35; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_35_hi = {u_line_cell_7_Vout_35,u_line_cell_6_Vout_35,u_line_cell_5_Vout_35,
    u_line_cell_4_Vout_35}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_36 = line_cell_1_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_36 = line_cell_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_36 = line_cell_3_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_36 = line_cell_2_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_36_lo = {u_line_cell_3_Vout_36,u_line_cell_2_Vout_36,u_line_cell_1_Vout_36,
    u_line_cell_0_Vout_36}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_36 = line_cell_5_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_36 = line_cell_4_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_36 = line_cell_7_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_36 = line_cell_6_io_Vout_36; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_36_hi = {u_line_cell_7_Vout_36,u_line_cell_6_Vout_36,u_line_cell_5_Vout_36,
    u_line_cell_4_Vout_36}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_37 = line_cell_1_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_37 = line_cell_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_37 = line_cell_3_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_37 = line_cell_2_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_37_lo = {u_line_cell_3_Vout_37,u_line_cell_2_Vout_37,u_line_cell_1_Vout_37,
    u_line_cell_0_Vout_37}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_37 = line_cell_5_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_37 = line_cell_4_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_37 = line_cell_7_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_37 = line_cell_6_io_Vout_37; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_37_hi = {u_line_cell_7_Vout_37,u_line_cell_6_Vout_37,u_line_cell_5_Vout_37,
    u_line_cell_4_Vout_37}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_38 = line_cell_1_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_38 = line_cell_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_38 = line_cell_3_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_38 = line_cell_2_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_38_lo = {u_line_cell_3_Vout_38,u_line_cell_2_Vout_38,u_line_cell_1_Vout_38,
    u_line_cell_0_Vout_38}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_38 = line_cell_5_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_38 = line_cell_4_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_38 = line_cell_7_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_38 = line_cell_6_io_Vout_38; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_38_hi = {u_line_cell_7_Vout_38,u_line_cell_6_Vout_38,u_line_cell_5_Vout_38,
    u_line_cell_4_Vout_38}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_39 = line_cell_1_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_39 = line_cell_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_39 = line_cell_3_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_39 = line_cell_2_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_39_lo = {u_line_cell_3_Vout_39,u_line_cell_2_Vout_39,u_line_cell_1_Vout_39,
    u_line_cell_0_Vout_39}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_39 = line_cell_5_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_39 = line_cell_4_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_39 = line_cell_7_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_39 = line_cell_6_io_Vout_39; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_39_hi = {u_line_cell_7_Vout_39,u_line_cell_6_Vout_39,u_line_cell_5_Vout_39,
    u_line_cell_4_Vout_39}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_40 = line_cell_1_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_40 = line_cell_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_40 = line_cell_3_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_40 = line_cell_2_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_40_lo = {u_line_cell_3_Vout_40,u_line_cell_2_Vout_40,u_line_cell_1_Vout_40,
    u_line_cell_0_Vout_40}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_40 = line_cell_5_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_40 = line_cell_4_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_40 = line_cell_7_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_40 = line_cell_6_io_Vout_40; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_40_hi = {u_line_cell_7_Vout_40,u_line_cell_6_Vout_40,u_line_cell_5_Vout_40,
    u_line_cell_4_Vout_40}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_41 = line_cell_1_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_41 = line_cell_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_41 = line_cell_3_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_41 = line_cell_2_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_41_lo = {u_line_cell_3_Vout_41,u_line_cell_2_Vout_41,u_line_cell_1_Vout_41,
    u_line_cell_0_Vout_41}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_41 = line_cell_5_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_41 = line_cell_4_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_41 = line_cell_7_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_41 = line_cell_6_io_Vout_41; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_41_hi = {u_line_cell_7_Vout_41,u_line_cell_6_Vout_41,u_line_cell_5_Vout_41,
    u_line_cell_4_Vout_41}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_42 = line_cell_1_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_42 = line_cell_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_42 = line_cell_3_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_42 = line_cell_2_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_42_lo = {u_line_cell_3_Vout_42,u_line_cell_2_Vout_42,u_line_cell_1_Vout_42,
    u_line_cell_0_Vout_42}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_42 = line_cell_5_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_42 = line_cell_4_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_42 = line_cell_7_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_42 = line_cell_6_io_Vout_42; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_42_hi = {u_line_cell_7_Vout_42,u_line_cell_6_Vout_42,u_line_cell_5_Vout_42,
    u_line_cell_4_Vout_42}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_43 = line_cell_1_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_43 = line_cell_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_43 = line_cell_3_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_43 = line_cell_2_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_43_lo = {u_line_cell_3_Vout_43,u_line_cell_2_Vout_43,u_line_cell_1_Vout_43,
    u_line_cell_0_Vout_43}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_43 = line_cell_5_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_43 = line_cell_4_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_43 = line_cell_7_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_43 = line_cell_6_io_Vout_43; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_43_hi = {u_line_cell_7_Vout_43,u_line_cell_6_Vout_43,u_line_cell_5_Vout_43,
    u_line_cell_4_Vout_43}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_44 = line_cell_1_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_44 = line_cell_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_44 = line_cell_3_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_44 = line_cell_2_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_44_lo = {u_line_cell_3_Vout_44,u_line_cell_2_Vout_44,u_line_cell_1_Vout_44,
    u_line_cell_0_Vout_44}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_44 = line_cell_5_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_44 = line_cell_4_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_44 = line_cell_7_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_44 = line_cell_6_io_Vout_44; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_44_hi = {u_line_cell_7_Vout_44,u_line_cell_6_Vout_44,u_line_cell_5_Vout_44,
    u_line_cell_4_Vout_44}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_45 = line_cell_1_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_45 = line_cell_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_45 = line_cell_3_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_45 = line_cell_2_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_45_lo = {u_line_cell_3_Vout_45,u_line_cell_2_Vout_45,u_line_cell_1_Vout_45,
    u_line_cell_0_Vout_45}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_45 = line_cell_5_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_45 = line_cell_4_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_45 = line_cell_7_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_45 = line_cell_6_io_Vout_45; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_45_hi = {u_line_cell_7_Vout_45,u_line_cell_6_Vout_45,u_line_cell_5_Vout_45,
    u_line_cell_4_Vout_45}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_46 = line_cell_1_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_46 = line_cell_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_46 = line_cell_3_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_46 = line_cell_2_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_46_lo = {u_line_cell_3_Vout_46,u_line_cell_2_Vout_46,u_line_cell_1_Vout_46,
    u_line_cell_0_Vout_46}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_46 = line_cell_5_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_46 = line_cell_4_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_46 = line_cell_7_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_46 = line_cell_6_io_Vout_46; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_46_hi = {u_line_cell_7_Vout_46,u_line_cell_6_Vout_46,u_line_cell_5_Vout_46,
    u_line_cell_4_Vout_46}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_47 = line_cell_1_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_47 = line_cell_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_47 = line_cell_3_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_47 = line_cell_2_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_47_lo = {u_line_cell_3_Vout_47,u_line_cell_2_Vout_47,u_line_cell_1_Vout_47,
    u_line_cell_0_Vout_47}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_47 = line_cell_5_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_47 = line_cell_4_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_47 = line_cell_7_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_47 = line_cell_6_io_Vout_47; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_47_hi = {u_line_cell_7_Vout_47,u_line_cell_6_Vout_47,u_line_cell_5_Vout_47,
    u_line_cell_4_Vout_47}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_48 = line_cell_1_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_48 = line_cell_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_48 = line_cell_3_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_48 = line_cell_2_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_48_lo = {u_line_cell_3_Vout_48,u_line_cell_2_Vout_48,u_line_cell_1_Vout_48,
    u_line_cell_0_Vout_48}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_48 = line_cell_5_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_48 = line_cell_4_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_48 = line_cell_7_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_48 = line_cell_6_io_Vout_48; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_48_hi = {u_line_cell_7_Vout_48,u_line_cell_6_Vout_48,u_line_cell_5_Vout_48,
    u_line_cell_4_Vout_48}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_49 = line_cell_1_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_49 = line_cell_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_49 = line_cell_3_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_49 = line_cell_2_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_49_lo = {u_line_cell_3_Vout_49,u_line_cell_2_Vout_49,u_line_cell_1_Vout_49,
    u_line_cell_0_Vout_49}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_49 = line_cell_5_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_49 = line_cell_4_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_49 = line_cell_7_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_49 = line_cell_6_io_Vout_49; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_49_hi = {u_line_cell_7_Vout_49,u_line_cell_6_Vout_49,u_line_cell_5_Vout_49,
    u_line_cell_4_Vout_49}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_50 = line_cell_1_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_50 = line_cell_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_50 = line_cell_3_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_50 = line_cell_2_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_50_lo = {u_line_cell_3_Vout_50,u_line_cell_2_Vout_50,u_line_cell_1_Vout_50,
    u_line_cell_0_Vout_50}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_50 = line_cell_5_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_50 = line_cell_4_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_50 = line_cell_7_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_50 = line_cell_6_io_Vout_50; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_50_hi = {u_line_cell_7_Vout_50,u_line_cell_6_Vout_50,u_line_cell_5_Vout_50,
    u_line_cell_4_Vout_50}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_51 = line_cell_1_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_51 = line_cell_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_51 = line_cell_3_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_51 = line_cell_2_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_51_lo = {u_line_cell_3_Vout_51,u_line_cell_2_Vout_51,u_line_cell_1_Vout_51,
    u_line_cell_0_Vout_51}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_51 = line_cell_5_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_51 = line_cell_4_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_51 = line_cell_7_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_51 = line_cell_6_io_Vout_51; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_51_hi = {u_line_cell_7_Vout_51,u_line_cell_6_Vout_51,u_line_cell_5_Vout_51,
    u_line_cell_4_Vout_51}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_52 = line_cell_1_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_52 = line_cell_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_52 = line_cell_3_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_52 = line_cell_2_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_52_lo = {u_line_cell_3_Vout_52,u_line_cell_2_Vout_52,u_line_cell_1_Vout_52,
    u_line_cell_0_Vout_52}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_52 = line_cell_5_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_52 = line_cell_4_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_52 = line_cell_7_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_52 = line_cell_6_io_Vout_52; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_52_hi = {u_line_cell_7_Vout_52,u_line_cell_6_Vout_52,u_line_cell_5_Vout_52,
    u_line_cell_4_Vout_52}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_53 = line_cell_1_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_53 = line_cell_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_53 = line_cell_3_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_53 = line_cell_2_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_53_lo = {u_line_cell_3_Vout_53,u_line_cell_2_Vout_53,u_line_cell_1_Vout_53,
    u_line_cell_0_Vout_53}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_53 = line_cell_5_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_53 = line_cell_4_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_53 = line_cell_7_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_53 = line_cell_6_io_Vout_53; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_53_hi = {u_line_cell_7_Vout_53,u_line_cell_6_Vout_53,u_line_cell_5_Vout_53,
    u_line_cell_4_Vout_53}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_54 = line_cell_1_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_54 = line_cell_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_54 = line_cell_3_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_54 = line_cell_2_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_54_lo = {u_line_cell_3_Vout_54,u_line_cell_2_Vout_54,u_line_cell_1_Vout_54,
    u_line_cell_0_Vout_54}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_54 = line_cell_5_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_54 = line_cell_4_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_54 = line_cell_7_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_54 = line_cell_6_io_Vout_54; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_54_hi = {u_line_cell_7_Vout_54,u_line_cell_6_Vout_54,u_line_cell_5_Vout_54,
    u_line_cell_4_Vout_54}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_55 = line_cell_1_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_55 = line_cell_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_55 = line_cell_3_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_55 = line_cell_2_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_55_lo = {u_line_cell_3_Vout_55,u_line_cell_2_Vout_55,u_line_cell_1_Vout_55,
    u_line_cell_0_Vout_55}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_55 = line_cell_5_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_55 = line_cell_4_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_55 = line_cell_7_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_55 = line_cell_6_io_Vout_55; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_55_hi = {u_line_cell_7_Vout_55,u_line_cell_6_Vout_55,u_line_cell_5_Vout_55,
    u_line_cell_4_Vout_55}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_56 = line_cell_1_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_56 = line_cell_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_56 = line_cell_3_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_56 = line_cell_2_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_56_lo = {u_line_cell_3_Vout_56,u_line_cell_2_Vout_56,u_line_cell_1_Vout_56,
    u_line_cell_0_Vout_56}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_56 = line_cell_5_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_56 = line_cell_4_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_56 = line_cell_7_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_56 = line_cell_6_io_Vout_56; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_56_hi = {u_line_cell_7_Vout_56,u_line_cell_6_Vout_56,u_line_cell_5_Vout_56,
    u_line_cell_4_Vout_56}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_57 = line_cell_1_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_57 = line_cell_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_57 = line_cell_3_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_57 = line_cell_2_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_57_lo = {u_line_cell_3_Vout_57,u_line_cell_2_Vout_57,u_line_cell_1_Vout_57,
    u_line_cell_0_Vout_57}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_57 = line_cell_5_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_57 = line_cell_4_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_57 = line_cell_7_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_57 = line_cell_6_io_Vout_57; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_57_hi = {u_line_cell_7_Vout_57,u_line_cell_6_Vout_57,u_line_cell_5_Vout_57,
    u_line_cell_4_Vout_57}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_58 = line_cell_1_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_58 = line_cell_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_58 = line_cell_3_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_58 = line_cell_2_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_58_lo = {u_line_cell_3_Vout_58,u_line_cell_2_Vout_58,u_line_cell_1_Vout_58,
    u_line_cell_0_Vout_58}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_58 = line_cell_5_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_58 = line_cell_4_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_58 = line_cell_7_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_58 = line_cell_6_io_Vout_58; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_58_hi = {u_line_cell_7_Vout_58,u_line_cell_6_Vout_58,u_line_cell_5_Vout_58,
    u_line_cell_4_Vout_58}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_59 = line_cell_1_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_59 = line_cell_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_59 = line_cell_3_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_59 = line_cell_2_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_59_lo = {u_line_cell_3_Vout_59,u_line_cell_2_Vout_59,u_line_cell_1_Vout_59,
    u_line_cell_0_Vout_59}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_59 = line_cell_5_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_59 = line_cell_4_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_59 = line_cell_7_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_59 = line_cell_6_io_Vout_59; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_59_hi = {u_line_cell_7_Vout_59,u_line_cell_6_Vout_59,u_line_cell_5_Vout_59,
    u_line_cell_4_Vout_59}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_60 = line_cell_1_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_60 = line_cell_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_60 = line_cell_3_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_60 = line_cell_2_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_60_lo = {u_line_cell_3_Vout_60,u_line_cell_2_Vout_60,u_line_cell_1_Vout_60,
    u_line_cell_0_Vout_60}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_60 = line_cell_5_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_60 = line_cell_4_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_60 = line_cell_7_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_60 = line_cell_6_io_Vout_60; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_60_hi = {u_line_cell_7_Vout_60,u_line_cell_6_Vout_60,u_line_cell_5_Vout_60,
    u_line_cell_4_Vout_60}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_61 = line_cell_1_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_61 = line_cell_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_61 = line_cell_3_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_61 = line_cell_2_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_61_lo = {u_line_cell_3_Vout_61,u_line_cell_2_Vout_61,u_line_cell_1_Vout_61,
    u_line_cell_0_Vout_61}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_61 = line_cell_5_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_61 = line_cell_4_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_61 = line_cell_7_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_61 = line_cell_6_io_Vout_61; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_61_hi = {u_line_cell_7_Vout_61,u_line_cell_6_Vout_61,u_line_cell_5_Vout_61,
    u_line_cell_4_Vout_61}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_62 = line_cell_1_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_62 = line_cell_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_62 = line_cell_3_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_62 = line_cell_2_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_62_lo = {u_line_cell_3_Vout_62,u_line_cell_2_Vout_62,u_line_cell_1_Vout_62,
    u_line_cell_0_Vout_62}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_62 = line_cell_5_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_62 = line_cell_4_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_62 = line_cell_7_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_62 = line_cell_6_io_Vout_62; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_62_hi = {u_line_cell_7_Vout_62,u_line_cell_6_Vout_62,u_line_cell_5_Vout_62,
    u_line_cell_4_Vout_62}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_63 = line_cell_1_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_63 = line_cell_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_63 = line_cell_3_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_63 = line_cell_2_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_63_lo = {u_line_cell_3_Vout_63,u_line_cell_2_Vout_63,u_line_cell_1_Vout_63,
    u_line_cell_0_Vout_63}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_63 = line_cell_5_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_63 = line_cell_4_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_63 = line_cell_7_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_63 = line_cell_6_io_Vout_63; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_63_hi = {u_line_cell_7_Vout_63,u_line_cell_6_Vout_63,u_line_cell_5_Vout_63,
    u_line_cell_4_Vout_63}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_64 = line_cell_1_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_64 = line_cell_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_64 = line_cell_3_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_64 = line_cell_2_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_64_lo = {u_line_cell_3_Vout_64,u_line_cell_2_Vout_64,u_line_cell_1_Vout_64,
    u_line_cell_0_Vout_64}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_64 = line_cell_5_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_64 = line_cell_4_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_64 = line_cell_7_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_64 = line_cell_6_io_Vout_64; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_64_hi = {u_line_cell_7_Vout_64,u_line_cell_6_Vout_64,u_line_cell_5_Vout_64,
    u_line_cell_4_Vout_64}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_65 = line_cell_1_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_65 = line_cell_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_65 = line_cell_3_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_65 = line_cell_2_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_65_lo = {u_line_cell_3_Vout_65,u_line_cell_2_Vout_65,u_line_cell_1_Vout_65,
    u_line_cell_0_Vout_65}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_65 = line_cell_5_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_65 = line_cell_4_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_65 = line_cell_7_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_65 = line_cell_6_io_Vout_65; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_65_hi = {u_line_cell_7_Vout_65,u_line_cell_6_Vout_65,u_line_cell_5_Vout_65,
    u_line_cell_4_Vout_65}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_66 = line_cell_1_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_66 = line_cell_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_66 = line_cell_3_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_66 = line_cell_2_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_66_lo = {u_line_cell_3_Vout_66,u_line_cell_2_Vout_66,u_line_cell_1_Vout_66,
    u_line_cell_0_Vout_66}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_66 = line_cell_5_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_66 = line_cell_4_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_66 = line_cell_7_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_66 = line_cell_6_io_Vout_66; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_66_hi = {u_line_cell_7_Vout_66,u_line_cell_6_Vout_66,u_line_cell_5_Vout_66,
    u_line_cell_4_Vout_66}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_67 = line_cell_1_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_67 = line_cell_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_67 = line_cell_3_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_67 = line_cell_2_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_67_lo = {u_line_cell_3_Vout_67,u_line_cell_2_Vout_67,u_line_cell_1_Vout_67,
    u_line_cell_0_Vout_67}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_67 = line_cell_5_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_67 = line_cell_4_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_67 = line_cell_7_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_67 = line_cell_6_io_Vout_67; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_67_hi = {u_line_cell_7_Vout_67,u_line_cell_6_Vout_67,u_line_cell_5_Vout_67,
    u_line_cell_4_Vout_67}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_68 = line_cell_1_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_68 = line_cell_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_68 = line_cell_3_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_68 = line_cell_2_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_68_lo = {u_line_cell_3_Vout_68,u_line_cell_2_Vout_68,u_line_cell_1_Vout_68,
    u_line_cell_0_Vout_68}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_68 = line_cell_5_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_68 = line_cell_4_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_68 = line_cell_7_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_68 = line_cell_6_io_Vout_68; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_68_hi = {u_line_cell_7_Vout_68,u_line_cell_6_Vout_68,u_line_cell_5_Vout_68,
    u_line_cell_4_Vout_68}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_69 = line_cell_1_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_69 = line_cell_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_69 = line_cell_3_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_69 = line_cell_2_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_69_lo = {u_line_cell_3_Vout_69,u_line_cell_2_Vout_69,u_line_cell_1_Vout_69,
    u_line_cell_0_Vout_69}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_69 = line_cell_5_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_69 = line_cell_4_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_69 = line_cell_7_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_69 = line_cell_6_io_Vout_69; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_69_hi = {u_line_cell_7_Vout_69,u_line_cell_6_Vout_69,u_line_cell_5_Vout_69,
    u_line_cell_4_Vout_69}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_70 = line_cell_1_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_70 = line_cell_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_70 = line_cell_3_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_70 = line_cell_2_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_70_lo = {u_line_cell_3_Vout_70,u_line_cell_2_Vout_70,u_line_cell_1_Vout_70,
    u_line_cell_0_Vout_70}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_70 = line_cell_5_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_70 = line_cell_4_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_70 = line_cell_7_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_70 = line_cell_6_io_Vout_70; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_70_hi = {u_line_cell_7_Vout_70,u_line_cell_6_Vout_70,u_line_cell_5_Vout_70,
    u_line_cell_4_Vout_70}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_71 = line_cell_1_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_71 = line_cell_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_71 = line_cell_3_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_71 = line_cell_2_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_71_lo = {u_line_cell_3_Vout_71,u_line_cell_2_Vout_71,u_line_cell_1_Vout_71,
    u_line_cell_0_Vout_71}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_71 = line_cell_5_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_71 = line_cell_4_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_71 = line_cell_7_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_71 = line_cell_6_io_Vout_71; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_71_hi = {u_line_cell_7_Vout_71,u_line_cell_6_Vout_71,u_line_cell_5_Vout_71,
    u_line_cell_4_Vout_71}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_72 = line_cell_1_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_72 = line_cell_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_72 = line_cell_3_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_72 = line_cell_2_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_72_lo = {u_line_cell_3_Vout_72,u_line_cell_2_Vout_72,u_line_cell_1_Vout_72,
    u_line_cell_0_Vout_72}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_72 = line_cell_5_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_72 = line_cell_4_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_72 = line_cell_7_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_72 = line_cell_6_io_Vout_72; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_72_hi = {u_line_cell_7_Vout_72,u_line_cell_6_Vout_72,u_line_cell_5_Vout_72,
    u_line_cell_4_Vout_72}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_73 = line_cell_1_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_73 = line_cell_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_73 = line_cell_3_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_73 = line_cell_2_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_73_lo = {u_line_cell_3_Vout_73,u_line_cell_2_Vout_73,u_line_cell_1_Vout_73,
    u_line_cell_0_Vout_73}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_73 = line_cell_5_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_73 = line_cell_4_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_73 = line_cell_7_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_73 = line_cell_6_io_Vout_73; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_73_hi = {u_line_cell_7_Vout_73,u_line_cell_6_Vout_73,u_line_cell_5_Vout_73,
    u_line_cell_4_Vout_73}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_74 = line_cell_1_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_74 = line_cell_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_74 = line_cell_3_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_74 = line_cell_2_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_74_lo = {u_line_cell_3_Vout_74,u_line_cell_2_Vout_74,u_line_cell_1_Vout_74,
    u_line_cell_0_Vout_74}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_74 = line_cell_5_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_74 = line_cell_4_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_74 = line_cell_7_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_74 = line_cell_6_io_Vout_74; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_74_hi = {u_line_cell_7_Vout_74,u_line_cell_6_Vout_74,u_line_cell_5_Vout_74,
    u_line_cell_4_Vout_74}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_75 = line_cell_1_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_75 = line_cell_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_75 = line_cell_3_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_75 = line_cell_2_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_75_lo = {u_line_cell_3_Vout_75,u_line_cell_2_Vout_75,u_line_cell_1_Vout_75,
    u_line_cell_0_Vout_75}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_75 = line_cell_5_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_75 = line_cell_4_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_75 = line_cell_7_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_75 = line_cell_6_io_Vout_75; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_75_hi = {u_line_cell_7_Vout_75,u_line_cell_6_Vout_75,u_line_cell_5_Vout_75,
    u_line_cell_4_Vout_75}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_76 = line_cell_1_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_76 = line_cell_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_76 = line_cell_3_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_76 = line_cell_2_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_76_lo = {u_line_cell_3_Vout_76,u_line_cell_2_Vout_76,u_line_cell_1_Vout_76,
    u_line_cell_0_Vout_76}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_76 = line_cell_5_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_76 = line_cell_4_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_76 = line_cell_7_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_76 = line_cell_6_io_Vout_76; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_76_hi = {u_line_cell_7_Vout_76,u_line_cell_6_Vout_76,u_line_cell_5_Vout_76,
    u_line_cell_4_Vout_76}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_77 = line_cell_1_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_77 = line_cell_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_77 = line_cell_3_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_77 = line_cell_2_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_77_lo = {u_line_cell_3_Vout_77,u_line_cell_2_Vout_77,u_line_cell_1_Vout_77,
    u_line_cell_0_Vout_77}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_77 = line_cell_5_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_77 = line_cell_4_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_77 = line_cell_7_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_77 = line_cell_6_io_Vout_77; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_77_hi = {u_line_cell_7_Vout_77,u_line_cell_6_Vout_77,u_line_cell_5_Vout_77,
    u_line_cell_4_Vout_77}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_78 = line_cell_1_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_78 = line_cell_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_78 = line_cell_3_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_78 = line_cell_2_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_78_lo = {u_line_cell_3_Vout_78,u_line_cell_2_Vout_78,u_line_cell_1_Vout_78,
    u_line_cell_0_Vout_78}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_78 = line_cell_5_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_78 = line_cell_4_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_78 = line_cell_7_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_78 = line_cell_6_io_Vout_78; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_78_hi = {u_line_cell_7_Vout_78,u_line_cell_6_Vout_78,u_line_cell_5_Vout_78,
    u_line_cell_4_Vout_78}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_79 = line_cell_1_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_79 = line_cell_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_79 = line_cell_3_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_79 = line_cell_2_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_79_lo = {u_line_cell_3_Vout_79,u_line_cell_2_Vout_79,u_line_cell_1_Vout_79,
    u_line_cell_0_Vout_79}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_79 = line_cell_5_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_79 = line_cell_4_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_79 = line_cell_7_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_79 = line_cell_6_io_Vout_79; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_79_hi = {u_line_cell_7_Vout_79,u_line_cell_6_Vout_79,u_line_cell_5_Vout_79,
    u_line_cell_4_Vout_79}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_80 = line_cell_1_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_80 = line_cell_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_80 = line_cell_3_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_80 = line_cell_2_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_80_lo = {u_line_cell_3_Vout_80,u_line_cell_2_Vout_80,u_line_cell_1_Vout_80,
    u_line_cell_0_Vout_80}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_80 = line_cell_5_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_80 = line_cell_4_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_80 = line_cell_7_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_80 = line_cell_6_io_Vout_80; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_80_hi = {u_line_cell_7_Vout_80,u_line_cell_6_Vout_80,u_line_cell_5_Vout_80,
    u_line_cell_4_Vout_80}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_81 = line_cell_1_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_81 = line_cell_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_81 = line_cell_3_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_81 = line_cell_2_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_81_lo = {u_line_cell_3_Vout_81,u_line_cell_2_Vout_81,u_line_cell_1_Vout_81,
    u_line_cell_0_Vout_81}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_81 = line_cell_5_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_81 = line_cell_4_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_81 = line_cell_7_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_81 = line_cell_6_io_Vout_81; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_81_hi = {u_line_cell_7_Vout_81,u_line_cell_6_Vout_81,u_line_cell_5_Vout_81,
    u_line_cell_4_Vout_81}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_82 = line_cell_1_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_82 = line_cell_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_82 = line_cell_3_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_82 = line_cell_2_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_82_lo = {u_line_cell_3_Vout_82,u_line_cell_2_Vout_82,u_line_cell_1_Vout_82,
    u_line_cell_0_Vout_82}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_82 = line_cell_5_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_82 = line_cell_4_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_82 = line_cell_7_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_82 = line_cell_6_io_Vout_82; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_82_hi = {u_line_cell_7_Vout_82,u_line_cell_6_Vout_82,u_line_cell_5_Vout_82,
    u_line_cell_4_Vout_82}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_83 = line_cell_1_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_83 = line_cell_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_83 = line_cell_3_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_83 = line_cell_2_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_83_lo = {u_line_cell_3_Vout_83,u_line_cell_2_Vout_83,u_line_cell_1_Vout_83,
    u_line_cell_0_Vout_83}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_83 = line_cell_5_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_83 = line_cell_4_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_83 = line_cell_7_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_83 = line_cell_6_io_Vout_83; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_83_hi = {u_line_cell_7_Vout_83,u_line_cell_6_Vout_83,u_line_cell_5_Vout_83,
    u_line_cell_4_Vout_83}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_84 = line_cell_1_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_84 = line_cell_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_84 = line_cell_3_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_84 = line_cell_2_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_84_lo = {u_line_cell_3_Vout_84,u_line_cell_2_Vout_84,u_line_cell_1_Vout_84,
    u_line_cell_0_Vout_84}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_84 = line_cell_5_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_84 = line_cell_4_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_84 = line_cell_7_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_84 = line_cell_6_io_Vout_84; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_84_hi = {u_line_cell_7_Vout_84,u_line_cell_6_Vout_84,u_line_cell_5_Vout_84,
    u_line_cell_4_Vout_84}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_85 = line_cell_1_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_85 = line_cell_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_85 = line_cell_3_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_85 = line_cell_2_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_85_lo = {u_line_cell_3_Vout_85,u_line_cell_2_Vout_85,u_line_cell_1_Vout_85,
    u_line_cell_0_Vout_85}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_85 = line_cell_5_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_85 = line_cell_4_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_85 = line_cell_7_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_85 = line_cell_6_io_Vout_85; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_85_hi = {u_line_cell_7_Vout_85,u_line_cell_6_Vout_85,u_line_cell_5_Vout_85,
    u_line_cell_4_Vout_85}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_86 = line_cell_1_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_86 = line_cell_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_86 = line_cell_3_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_86 = line_cell_2_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_86_lo = {u_line_cell_3_Vout_86,u_line_cell_2_Vout_86,u_line_cell_1_Vout_86,
    u_line_cell_0_Vout_86}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_86 = line_cell_5_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_86 = line_cell_4_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_86 = line_cell_7_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_86 = line_cell_6_io_Vout_86; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_86_hi = {u_line_cell_7_Vout_86,u_line_cell_6_Vout_86,u_line_cell_5_Vout_86,
    u_line_cell_4_Vout_86}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_87 = line_cell_1_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_87 = line_cell_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_87 = line_cell_3_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_87 = line_cell_2_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_87_lo = {u_line_cell_3_Vout_87,u_line_cell_2_Vout_87,u_line_cell_1_Vout_87,
    u_line_cell_0_Vout_87}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_87 = line_cell_5_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_87 = line_cell_4_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_87 = line_cell_7_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_87 = line_cell_6_io_Vout_87; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_87_hi = {u_line_cell_7_Vout_87,u_line_cell_6_Vout_87,u_line_cell_5_Vout_87,
    u_line_cell_4_Vout_87}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_88 = line_cell_1_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_88 = line_cell_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_88 = line_cell_3_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_88 = line_cell_2_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_88_lo = {u_line_cell_3_Vout_88,u_line_cell_2_Vout_88,u_line_cell_1_Vout_88,
    u_line_cell_0_Vout_88}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_88 = line_cell_5_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_88 = line_cell_4_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_88 = line_cell_7_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_88 = line_cell_6_io_Vout_88; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_88_hi = {u_line_cell_7_Vout_88,u_line_cell_6_Vout_88,u_line_cell_5_Vout_88,
    u_line_cell_4_Vout_88}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_89 = line_cell_1_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_89 = line_cell_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_89 = line_cell_3_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_89 = line_cell_2_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_89_lo = {u_line_cell_3_Vout_89,u_line_cell_2_Vout_89,u_line_cell_1_Vout_89,
    u_line_cell_0_Vout_89}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_89 = line_cell_5_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_89 = line_cell_4_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_89 = line_cell_7_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_89 = line_cell_6_io_Vout_89; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_89_hi = {u_line_cell_7_Vout_89,u_line_cell_6_Vout_89,u_line_cell_5_Vout_89,
    u_line_cell_4_Vout_89}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_90 = line_cell_1_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_90 = line_cell_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_90 = line_cell_3_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_90 = line_cell_2_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_90_lo = {u_line_cell_3_Vout_90,u_line_cell_2_Vout_90,u_line_cell_1_Vout_90,
    u_line_cell_0_Vout_90}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_90 = line_cell_5_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_90 = line_cell_4_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_90 = line_cell_7_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_90 = line_cell_6_io_Vout_90; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_90_hi = {u_line_cell_7_Vout_90,u_line_cell_6_Vout_90,u_line_cell_5_Vout_90,
    u_line_cell_4_Vout_90}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_91 = line_cell_1_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_91 = line_cell_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_91 = line_cell_3_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_91 = line_cell_2_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_91_lo = {u_line_cell_3_Vout_91,u_line_cell_2_Vout_91,u_line_cell_1_Vout_91,
    u_line_cell_0_Vout_91}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_91 = line_cell_5_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_91 = line_cell_4_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_91 = line_cell_7_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_91 = line_cell_6_io_Vout_91; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_91_hi = {u_line_cell_7_Vout_91,u_line_cell_6_Vout_91,u_line_cell_5_Vout_91,
    u_line_cell_4_Vout_91}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_92 = line_cell_1_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_92 = line_cell_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_92 = line_cell_3_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_92 = line_cell_2_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_92_lo = {u_line_cell_3_Vout_92,u_line_cell_2_Vout_92,u_line_cell_1_Vout_92,
    u_line_cell_0_Vout_92}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_92 = line_cell_5_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_92 = line_cell_4_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_92 = line_cell_7_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_92 = line_cell_6_io_Vout_92; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_92_hi = {u_line_cell_7_Vout_92,u_line_cell_6_Vout_92,u_line_cell_5_Vout_92,
    u_line_cell_4_Vout_92}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_93 = line_cell_1_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_93 = line_cell_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_93 = line_cell_3_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_93 = line_cell_2_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_93_lo = {u_line_cell_3_Vout_93,u_line_cell_2_Vout_93,u_line_cell_1_Vout_93,
    u_line_cell_0_Vout_93}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_93 = line_cell_5_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_93 = line_cell_4_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_93 = line_cell_7_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_93 = line_cell_6_io_Vout_93; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_93_hi = {u_line_cell_7_Vout_93,u_line_cell_6_Vout_93,u_line_cell_5_Vout_93,
    u_line_cell_4_Vout_93}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_94 = line_cell_1_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_94 = line_cell_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_94 = line_cell_3_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_94 = line_cell_2_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_94_lo = {u_line_cell_3_Vout_94,u_line_cell_2_Vout_94,u_line_cell_1_Vout_94,
    u_line_cell_0_Vout_94}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_94 = line_cell_5_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_94 = line_cell_4_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_94 = line_cell_7_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_94 = line_cell_6_io_Vout_94; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_94_hi = {u_line_cell_7_Vout_94,u_line_cell_6_Vout_94,u_line_cell_5_Vout_94,
    u_line_cell_4_Vout_94}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_95 = line_cell_1_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_95 = line_cell_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_95 = line_cell_3_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_95 = line_cell_2_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_95_lo = {u_line_cell_3_Vout_95,u_line_cell_2_Vout_95,u_line_cell_1_Vout_95,
    u_line_cell_0_Vout_95}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_95 = line_cell_5_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_95 = line_cell_4_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_95 = line_cell_7_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_95 = line_cell_6_io_Vout_95; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_95_hi = {u_line_cell_7_Vout_95,u_line_cell_6_Vout_95,u_line_cell_5_Vout_95,
    u_line_cell_4_Vout_95}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_96 = line_cell_1_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_96 = line_cell_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_96 = line_cell_3_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_96 = line_cell_2_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_96_lo = {u_line_cell_3_Vout_96,u_line_cell_2_Vout_96,u_line_cell_1_Vout_96,
    u_line_cell_0_Vout_96}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_96 = line_cell_5_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_96 = line_cell_4_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_96 = line_cell_7_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_96 = line_cell_6_io_Vout_96; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_96_hi = {u_line_cell_7_Vout_96,u_line_cell_6_Vout_96,u_line_cell_5_Vout_96,
    u_line_cell_4_Vout_96}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_97 = line_cell_1_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_97 = line_cell_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_97 = line_cell_3_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_97 = line_cell_2_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_97_lo = {u_line_cell_3_Vout_97,u_line_cell_2_Vout_97,u_line_cell_1_Vout_97,
    u_line_cell_0_Vout_97}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_97 = line_cell_5_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_97 = line_cell_4_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_97 = line_cell_7_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_97 = line_cell_6_io_Vout_97; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_97_hi = {u_line_cell_7_Vout_97,u_line_cell_6_Vout_97,u_line_cell_5_Vout_97,
    u_line_cell_4_Vout_97}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_98 = line_cell_1_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_98 = line_cell_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_98 = line_cell_3_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_98 = line_cell_2_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_98_lo = {u_line_cell_3_Vout_98,u_line_cell_2_Vout_98,u_line_cell_1_Vout_98,
    u_line_cell_0_Vout_98}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_98 = line_cell_5_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_98 = line_cell_4_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_98 = line_cell_7_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_98 = line_cell_6_io_Vout_98; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_98_hi = {u_line_cell_7_Vout_98,u_line_cell_6_Vout_98,u_line_cell_5_Vout_98,
    u_line_cell_4_Vout_98}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_99 = line_cell_1_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_99 = line_cell_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_99 = line_cell_3_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_99 = line_cell_2_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_99_lo = {u_line_cell_3_Vout_99,u_line_cell_2_Vout_99,u_line_cell_1_Vout_99,
    u_line_cell_0_Vout_99}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_99 = line_cell_5_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_99 = line_cell_4_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_99 = line_cell_7_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_99 = line_cell_6_io_Vout_99; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_99_hi = {u_line_cell_7_Vout_99,u_line_cell_6_Vout_99,u_line_cell_5_Vout_99,
    u_line_cell_4_Vout_99}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_100 = line_cell_1_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_100 = line_cell_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_100 = line_cell_3_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_100 = line_cell_2_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_100_lo = {u_line_cell_3_Vout_100,u_line_cell_2_Vout_100,u_line_cell_1_Vout_100,
    u_line_cell_0_Vout_100}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_100 = line_cell_5_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_100 = line_cell_4_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_100 = line_cell_7_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_100 = line_cell_6_io_Vout_100; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_100_hi = {u_line_cell_7_Vout_100,u_line_cell_6_Vout_100,u_line_cell_5_Vout_100,
    u_line_cell_4_Vout_100}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_101 = line_cell_1_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_101 = line_cell_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_101 = line_cell_3_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_101 = line_cell_2_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_101_lo = {u_line_cell_3_Vout_101,u_line_cell_2_Vout_101,u_line_cell_1_Vout_101,
    u_line_cell_0_Vout_101}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_101 = line_cell_5_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_101 = line_cell_4_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_101 = line_cell_7_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_101 = line_cell_6_io_Vout_101; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_101_hi = {u_line_cell_7_Vout_101,u_line_cell_6_Vout_101,u_line_cell_5_Vout_101,
    u_line_cell_4_Vout_101}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_102 = line_cell_1_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_102 = line_cell_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_102 = line_cell_3_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_102 = line_cell_2_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_102_lo = {u_line_cell_3_Vout_102,u_line_cell_2_Vout_102,u_line_cell_1_Vout_102,
    u_line_cell_0_Vout_102}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_102 = line_cell_5_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_102 = line_cell_4_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_102 = line_cell_7_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_102 = line_cell_6_io_Vout_102; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_102_hi = {u_line_cell_7_Vout_102,u_line_cell_6_Vout_102,u_line_cell_5_Vout_102,
    u_line_cell_4_Vout_102}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_103 = line_cell_1_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_103 = line_cell_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_103 = line_cell_3_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_103 = line_cell_2_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_103_lo = {u_line_cell_3_Vout_103,u_line_cell_2_Vout_103,u_line_cell_1_Vout_103,
    u_line_cell_0_Vout_103}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_103 = line_cell_5_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_103 = line_cell_4_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_103 = line_cell_7_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_103 = line_cell_6_io_Vout_103; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_103_hi = {u_line_cell_7_Vout_103,u_line_cell_6_Vout_103,u_line_cell_5_Vout_103,
    u_line_cell_4_Vout_103}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_104 = line_cell_1_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_104 = line_cell_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_104 = line_cell_3_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_104 = line_cell_2_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_104_lo = {u_line_cell_3_Vout_104,u_line_cell_2_Vout_104,u_line_cell_1_Vout_104,
    u_line_cell_0_Vout_104}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_104 = line_cell_5_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_104 = line_cell_4_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_104 = line_cell_7_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_104 = line_cell_6_io_Vout_104; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_104_hi = {u_line_cell_7_Vout_104,u_line_cell_6_Vout_104,u_line_cell_5_Vout_104,
    u_line_cell_4_Vout_104}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_105 = line_cell_1_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_105 = line_cell_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_105 = line_cell_3_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_105 = line_cell_2_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_105_lo = {u_line_cell_3_Vout_105,u_line_cell_2_Vout_105,u_line_cell_1_Vout_105,
    u_line_cell_0_Vout_105}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_105 = line_cell_5_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_105 = line_cell_4_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_105 = line_cell_7_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_105 = line_cell_6_io_Vout_105; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_105_hi = {u_line_cell_7_Vout_105,u_line_cell_6_Vout_105,u_line_cell_5_Vout_105,
    u_line_cell_4_Vout_105}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_106 = line_cell_1_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_106 = line_cell_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_106 = line_cell_3_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_106 = line_cell_2_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_106_lo = {u_line_cell_3_Vout_106,u_line_cell_2_Vout_106,u_line_cell_1_Vout_106,
    u_line_cell_0_Vout_106}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_106 = line_cell_5_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_106 = line_cell_4_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_106 = line_cell_7_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_106 = line_cell_6_io_Vout_106; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_106_hi = {u_line_cell_7_Vout_106,u_line_cell_6_Vout_106,u_line_cell_5_Vout_106,
    u_line_cell_4_Vout_106}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_107 = line_cell_1_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_107 = line_cell_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_107 = line_cell_3_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_107 = line_cell_2_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_107_lo = {u_line_cell_3_Vout_107,u_line_cell_2_Vout_107,u_line_cell_1_Vout_107,
    u_line_cell_0_Vout_107}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_107 = line_cell_5_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_107 = line_cell_4_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_107 = line_cell_7_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_107 = line_cell_6_io_Vout_107; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_107_hi = {u_line_cell_7_Vout_107,u_line_cell_6_Vout_107,u_line_cell_5_Vout_107,
    u_line_cell_4_Vout_107}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_108 = line_cell_1_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_108 = line_cell_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_108 = line_cell_3_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_108 = line_cell_2_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_108_lo = {u_line_cell_3_Vout_108,u_line_cell_2_Vout_108,u_line_cell_1_Vout_108,
    u_line_cell_0_Vout_108}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_108 = line_cell_5_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_108 = line_cell_4_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_108 = line_cell_7_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_108 = line_cell_6_io_Vout_108; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_108_hi = {u_line_cell_7_Vout_108,u_line_cell_6_Vout_108,u_line_cell_5_Vout_108,
    u_line_cell_4_Vout_108}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_109 = line_cell_1_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_109 = line_cell_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_109 = line_cell_3_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_109 = line_cell_2_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_109_lo = {u_line_cell_3_Vout_109,u_line_cell_2_Vout_109,u_line_cell_1_Vout_109,
    u_line_cell_0_Vout_109}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_109 = line_cell_5_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_109 = line_cell_4_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_109 = line_cell_7_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_109 = line_cell_6_io_Vout_109; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_109_hi = {u_line_cell_7_Vout_109,u_line_cell_6_Vout_109,u_line_cell_5_Vout_109,
    u_line_cell_4_Vout_109}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_110 = line_cell_1_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_110 = line_cell_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_110 = line_cell_3_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_110 = line_cell_2_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_110_lo = {u_line_cell_3_Vout_110,u_line_cell_2_Vout_110,u_line_cell_1_Vout_110,
    u_line_cell_0_Vout_110}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_110 = line_cell_5_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_110 = line_cell_4_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_110 = line_cell_7_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_110 = line_cell_6_io_Vout_110; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_110_hi = {u_line_cell_7_Vout_110,u_line_cell_6_Vout_110,u_line_cell_5_Vout_110,
    u_line_cell_4_Vout_110}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_111 = line_cell_1_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_111 = line_cell_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_111 = line_cell_3_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_111 = line_cell_2_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_111_lo = {u_line_cell_3_Vout_111,u_line_cell_2_Vout_111,u_line_cell_1_Vout_111,
    u_line_cell_0_Vout_111}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_111 = line_cell_5_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_111 = line_cell_4_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_111 = line_cell_7_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_111 = line_cell_6_io_Vout_111; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_111_hi = {u_line_cell_7_Vout_111,u_line_cell_6_Vout_111,u_line_cell_5_Vout_111,
    u_line_cell_4_Vout_111}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_112 = line_cell_1_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_112 = line_cell_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_112 = line_cell_3_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_112 = line_cell_2_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_112_lo = {u_line_cell_3_Vout_112,u_line_cell_2_Vout_112,u_line_cell_1_Vout_112,
    u_line_cell_0_Vout_112}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_112 = line_cell_5_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_112 = line_cell_4_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_112 = line_cell_7_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_112 = line_cell_6_io_Vout_112; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_112_hi = {u_line_cell_7_Vout_112,u_line_cell_6_Vout_112,u_line_cell_5_Vout_112,
    u_line_cell_4_Vout_112}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_113 = line_cell_1_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_113 = line_cell_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_113 = line_cell_3_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_113 = line_cell_2_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_113_lo = {u_line_cell_3_Vout_113,u_line_cell_2_Vout_113,u_line_cell_1_Vout_113,
    u_line_cell_0_Vout_113}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_113 = line_cell_5_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_113 = line_cell_4_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_113 = line_cell_7_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_113 = line_cell_6_io_Vout_113; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_113_hi = {u_line_cell_7_Vout_113,u_line_cell_6_Vout_113,u_line_cell_5_Vout_113,
    u_line_cell_4_Vout_113}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_114 = line_cell_1_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_114 = line_cell_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_114 = line_cell_3_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_114 = line_cell_2_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_114_lo = {u_line_cell_3_Vout_114,u_line_cell_2_Vout_114,u_line_cell_1_Vout_114,
    u_line_cell_0_Vout_114}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_114 = line_cell_5_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_114 = line_cell_4_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_114 = line_cell_7_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_114 = line_cell_6_io_Vout_114; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_114_hi = {u_line_cell_7_Vout_114,u_line_cell_6_Vout_114,u_line_cell_5_Vout_114,
    u_line_cell_4_Vout_114}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_115 = line_cell_1_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_115 = line_cell_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_115 = line_cell_3_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_115 = line_cell_2_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_115_lo = {u_line_cell_3_Vout_115,u_line_cell_2_Vout_115,u_line_cell_1_Vout_115,
    u_line_cell_0_Vout_115}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_115 = line_cell_5_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_115 = line_cell_4_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_115 = line_cell_7_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_115 = line_cell_6_io_Vout_115; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_115_hi = {u_line_cell_7_Vout_115,u_line_cell_6_Vout_115,u_line_cell_5_Vout_115,
    u_line_cell_4_Vout_115}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_116 = line_cell_1_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_116 = line_cell_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_116 = line_cell_3_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_116 = line_cell_2_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_116_lo = {u_line_cell_3_Vout_116,u_line_cell_2_Vout_116,u_line_cell_1_Vout_116,
    u_line_cell_0_Vout_116}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_116 = line_cell_5_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_116 = line_cell_4_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_116 = line_cell_7_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_116 = line_cell_6_io_Vout_116; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_116_hi = {u_line_cell_7_Vout_116,u_line_cell_6_Vout_116,u_line_cell_5_Vout_116,
    u_line_cell_4_Vout_116}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_117 = line_cell_1_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_117 = line_cell_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_117 = line_cell_3_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_117 = line_cell_2_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_117_lo = {u_line_cell_3_Vout_117,u_line_cell_2_Vout_117,u_line_cell_1_Vout_117,
    u_line_cell_0_Vout_117}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_117 = line_cell_5_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_117 = line_cell_4_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_117 = line_cell_7_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_117 = line_cell_6_io_Vout_117; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_117_hi = {u_line_cell_7_Vout_117,u_line_cell_6_Vout_117,u_line_cell_5_Vout_117,
    u_line_cell_4_Vout_117}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_118 = line_cell_1_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_118 = line_cell_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_118 = line_cell_3_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_118 = line_cell_2_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_118_lo = {u_line_cell_3_Vout_118,u_line_cell_2_Vout_118,u_line_cell_1_Vout_118,
    u_line_cell_0_Vout_118}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_118 = line_cell_5_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_118 = line_cell_4_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_118 = line_cell_7_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_118 = line_cell_6_io_Vout_118; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_118_hi = {u_line_cell_7_Vout_118,u_line_cell_6_Vout_118,u_line_cell_5_Vout_118,
    u_line_cell_4_Vout_118}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_119 = line_cell_1_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_119 = line_cell_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_119 = line_cell_3_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_119 = line_cell_2_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_119_lo = {u_line_cell_3_Vout_119,u_line_cell_2_Vout_119,u_line_cell_1_Vout_119,
    u_line_cell_0_Vout_119}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_119 = line_cell_5_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_119 = line_cell_4_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_119 = line_cell_7_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_119 = line_cell_6_io_Vout_119; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_119_hi = {u_line_cell_7_Vout_119,u_line_cell_6_Vout_119,u_line_cell_5_Vout_119,
    u_line_cell_4_Vout_119}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_120 = line_cell_1_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_120 = line_cell_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_120 = line_cell_3_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_120 = line_cell_2_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_120_lo = {u_line_cell_3_Vout_120,u_line_cell_2_Vout_120,u_line_cell_1_Vout_120,
    u_line_cell_0_Vout_120}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_120 = line_cell_5_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_120 = line_cell_4_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_120 = line_cell_7_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_120 = line_cell_6_io_Vout_120; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_120_hi = {u_line_cell_7_Vout_120,u_line_cell_6_Vout_120,u_line_cell_5_Vout_120,
    u_line_cell_4_Vout_120}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_121 = line_cell_1_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_121 = line_cell_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_121 = line_cell_3_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_121 = line_cell_2_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_121_lo = {u_line_cell_3_Vout_121,u_line_cell_2_Vout_121,u_line_cell_1_Vout_121,
    u_line_cell_0_Vout_121}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_121 = line_cell_5_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_121 = line_cell_4_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_121 = line_cell_7_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_121 = line_cell_6_io_Vout_121; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_121_hi = {u_line_cell_7_Vout_121,u_line_cell_6_Vout_121,u_line_cell_5_Vout_121,
    u_line_cell_4_Vout_121}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_122 = line_cell_1_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_122 = line_cell_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_122 = line_cell_3_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_122 = line_cell_2_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_122_lo = {u_line_cell_3_Vout_122,u_line_cell_2_Vout_122,u_line_cell_1_Vout_122,
    u_line_cell_0_Vout_122}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_122 = line_cell_5_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_122 = line_cell_4_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_122 = line_cell_7_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_122 = line_cell_6_io_Vout_122; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_122_hi = {u_line_cell_7_Vout_122,u_line_cell_6_Vout_122,u_line_cell_5_Vout_122,
    u_line_cell_4_Vout_122}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_123 = line_cell_1_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_123 = line_cell_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_123 = line_cell_3_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_123 = line_cell_2_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_123_lo = {u_line_cell_3_Vout_123,u_line_cell_2_Vout_123,u_line_cell_1_Vout_123,
    u_line_cell_0_Vout_123}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_123 = line_cell_5_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_123 = line_cell_4_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_123 = line_cell_7_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_123 = line_cell_6_io_Vout_123; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_123_hi = {u_line_cell_7_Vout_123,u_line_cell_6_Vout_123,u_line_cell_5_Vout_123,
    u_line_cell_4_Vout_123}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_124 = line_cell_1_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_124 = line_cell_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_124 = line_cell_3_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_124 = line_cell_2_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_124_lo = {u_line_cell_3_Vout_124,u_line_cell_2_Vout_124,u_line_cell_1_Vout_124,
    u_line_cell_0_Vout_124}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_124 = line_cell_5_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_124 = line_cell_4_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_124 = line_cell_7_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_124 = line_cell_6_io_Vout_124; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_124_hi = {u_line_cell_7_Vout_124,u_line_cell_6_Vout_124,u_line_cell_5_Vout_124,
    u_line_cell_4_Vout_124}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_125 = line_cell_1_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_125 = line_cell_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_125 = line_cell_3_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_125 = line_cell_2_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_125_lo = {u_line_cell_3_Vout_125,u_line_cell_2_Vout_125,u_line_cell_1_Vout_125,
    u_line_cell_0_Vout_125}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_125 = line_cell_5_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_125 = line_cell_4_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_125 = line_cell_7_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_125 = line_cell_6_io_Vout_125; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_125_hi = {u_line_cell_7_Vout_125,u_line_cell_6_Vout_125,u_line_cell_5_Vout_125,
    u_line_cell_4_Vout_125}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_126 = line_cell_1_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_126 = line_cell_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_126 = line_cell_3_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_126 = line_cell_2_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_126_lo = {u_line_cell_3_Vout_126,u_line_cell_2_Vout_126,u_line_cell_1_Vout_126,
    u_line_cell_0_Vout_126}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_126 = line_cell_5_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_126 = line_cell_4_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_126 = line_cell_7_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_126 = line_cell_6_io_Vout_126; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_126_hi = {u_line_cell_7_Vout_126,u_line_cell_6_Vout_126,u_line_cell_5_Vout_126,
    u_line_cell_4_Vout_126}; // @[Cat.scala 33:92]
  wire  u_line_cell_1_Vout_127 = line_cell_1_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_0_Vout_127 = line_cell_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_3_Vout_127 = line_cell_3_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_2_Vout_127 = line_cell_2_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_127_lo = {u_line_cell_3_Vout_127,u_line_cell_2_Vout_127,u_line_cell_1_Vout_127,
    u_line_cell_0_Vout_127}; // @[Cat.scala 33:92]
  wire  u_line_cell_5_Vout_127 = line_cell_5_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_4_Vout_127 = line_cell_4_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_7_Vout_127 = line_cell_7_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire  u_line_cell_6_Vout_127 = line_cell_6_io_Vout_127; // @[Array_8x128.scala 17:{28,28}]
  wire [3:0] U_AdderTree_io_d_in_127_hi = {u_line_cell_7_Vout_127,u_line_cell_6_Vout_127,u_line_cell_5_Vout_127,
    u_line_cell_4_Vout_127}; // @[Cat.scala 33:92]
  line_cell line_cell ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_clock),
    .io_WL(line_cell_io_WL),
    .io_IN(line_cell_io_IN),
    .io_BL(line_cell_io_BL),
    .io_Vout_0(line_cell_io_Vout_0),
    .io_Vout_1(line_cell_io_Vout_1),
    .io_Vout_2(line_cell_io_Vout_2),
    .io_Vout_3(line_cell_io_Vout_3),
    .io_Vout_4(line_cell_io_Vout_4),
    .io_Vout_5(line_cell_io_Vout_5),
    .io_Vout_6(line_cell_io_Vout_6),
    .io_Vout_7(line_cell_io_Vout_7),
    .io_Vout_8(line_cell_io_Vout_8),
    .io_Vout_9(line_cell_io_Vout_9),
    .io_Vout_10(line_cell_io_Vout_10),
    .io_Vout_11(line_cell_io_Vout_11),
    .io_Vout_12(line_cell_io_Vout_12),
    .io_Vout_13(line_cell_io_Vout_13),
    .io_Vout_14(line_cell_io_Vout_14),
    .io_Vout_15(line_cell_io_Vout_15),
    .io_Vout_16(line_cell_io_Vout_16),
    .io_Vout_17(line_cell_io_Vout_17),
    .io_Vout_18(line_cell_io_Vout_18),
    .io_Vout_19(line_cell_io_Vout_19),
    .io_Vout_20(line_cell_io_Vout_20),
    .io_Vout_21(line_cell_io_Vout_21),
    .io_Vout_22(line_cell_io_Vout_22),
    .io_Vout_23(line_cell_io_Vout_23),
    .io_Vout_24(line_cell_io_Vout_24),
    .io_Vout_25(line_cell_io_Vout_25),
    .io_Vout_26(line_cell_io_Vout_26),
    .io_Vout_27(line_cell_io_Vout_27),
    .io_Vout_28(line_cell_io_Vout_28),
    .io_Vout_29(line_cell_io_Vout_29),
    .io_Vout_30(line_cell_io_Vout_30),
    .io_Vout_31(line_cell_io_Vout_31),
    .io_Vout_32(line_cell_io_Vout_32),
    .io_Vout_33(line_cell_io_Vout_33),
    .io_Vout_34(line_cell_io_Vout_34),
    .io_Vout_35(line_cell_io_Vout_35),
    .io_Vout_36(line_cell_io_Vout_36),
    .io_Vout_37(line_cell_io_Vout_37),
    .io_Vout_38(line_cell_io_Vout_38),
    .io_Vout_39(line_cell_io_Vout_39),
    .io_Vout_40(line_cell_io_Vout_40),
    .io_Vout_41(line_cell_io_Vout_41),
    .io_Vout_42(line_cell_io_Vout_42),
    .io_Vout_43(line_cell_io_Vout_43),
    .io_Vout_44(line_cell_io_Vout_44),
    .io_Vout_45(line_cell_io_Vout_45),
    .io_Vout_46(line_cell_io_Vout_46),
    .io_Vout_47(line_cell_io_Vout_47),
    .io_Vout_48(line_cell_io_Vout_48),
    .io_Vout_49(line_cell_io_Vout_49),
    .io_Vout_50(line_cell_io_Vout_50),
    .io_Vout_51(line_cell_io_Vout_51),
    .io_Vout_52(line_cell_io_Vout_52),
    .io_Vout_53(line_cell_io_Vout_53),
    .io_Vout_54(line_cell_io_Vout_54),
    .io_Vout_55(line_cell_io_Vout_55),
    .io_Vout_56(line_cell_io_Vout_56),
    .io_Vout_57(line_cell_io_Vout_57),
    .io_Vout_58(line_cell_io_Vout_58),
    .io_Vout_59(line_cell_io_Vout_59),
    .io_Vout_60(line_cell_io_Vout_60),
    .io_Vout_61(line_cell_io_Vout_61),
    .io_Vout_62(line_cell_io_Vout_62),
    .io_Vout_63(line_cell_io_Vout_63),
    .io_Vout_64(line_cell_io_Vout_64),
    .io_Vout_65(line_cell_io_Vout_65),
    .io_Vout_66(line_cell_io_Vout_66),
    .io_Vout_67(line_cell_io_Vout_67),
    .io_Vout_68(line_cell_io_Vout_68),
    .io_Vout_69(line_cell_io_Vout_69),
    .io_Vout_70(line_cell_io_Vout_70),
    .io_Vout_71(line_cell_io_Vout_71),
    .io_Vout_72(line_cell_io_Vout_72),
    .io_Vout_73(line_cell_io_Vout_73),
    .io_Vout_74(line_cell_io_Vout_74),
    .io_Vout_75(line_cell_io_Vout_75),
    .io_Vout_76(line_cell_io_Vout_76),
    .io_Vout_77(line_cell_io_Vout_77),
    .io_Vout_78(line_cell_io_Vout_78),
    .io_Vout_79(line_cell_io_Vout_79),
    .io_Vout_80(line_cell_io_Vout_80),
    .io_Vout_81(line_cell_io_Vout_81),
    .io_Vout_82(line_cell_io_Vout_82),
    .io_Vout_83(line_cell_io_Vout_83),
    .io_Vout_84(line_cell_io_Vout_84),
    .io_Vout_85(line_cell_io_Vout_85),
    .io_Vout_86(line_cell_io_Vout_86),
    .io_Vout_87(line_cell_io_Vout_87),
    .io_Vout_88(line_cell_io_Vout_88),
    .io_Vout_89(line_cell_io_Vout_89),
    .io_Vout_90(line_cell_io_Vout_90),
    .io_Vout_91(line_cell_io_Vout_91),
    .io_Vout_92(line_cell_io_Vout_92),
    .io_Vout_93(line_cell_io_Vout_93),
    .io_Vout_94(line_cell_io_Vout_94),
    .io_Vout_95(line_cell_io_Vout_95),
    .io_Vout_96(line_cell_io_Vout_96),
    .io_Vout_97(line_cell_io_Vout_97),
    .io_Vout_98(line_cell_io_Vout_98),
    .io_Vout_99(line_cell_io_Vout_99),
    .io_Vout_100(line_cell_io_Vout_100),
    .io_Vout_101(line_cell_io_Vout_101),
    .io_Vout_102(line_cell_io_Vout_102),
    .io_Vout_103(line_cell_io_Vout_103),
    .io_Vout_104(line_cell_io_Vout_104),
    .io_Vout_105(line_cell_io_Vout_105),
    .io_Vout_106(line_cell_io_Vout_106),
    .io_Vout_107(line_cell_io_Vout_107),
    .io_Vout_108(line_cell_io_Vout_108),
    .io_Vout_109(line_cell_io_Vout_109),
    .io_Vout_110(line_cell_io_Vout_110),
    .io_Vout_111(line_cell_io_Vout_111),
    .io_Vout_112(line_cell_io_Vout_112),
    .io_Vout_113(line_cell_io_Vout_113),
    .io_Vout_114(line_cell_io_Vout_114),
    .io_Vout_115(line_cell_io_Vout_115),
    .io_Vout_116(line_cell_io_Vout_116),
    .io_Vout_117(line_cell_io_Vout_117),
    .io_Vout_118(line_cell_io_Vout_118),
    .io_Vout_119(line_cell_io_Vout_119),
    .io_Vout_120(line_cell_io_Vout_120),
    .io_Vout_121(line_cell_io_Vout_121),
    .io_Vout_122(line_cell_io_Vout_122),
    .io_Vout_123(line_cell_io_Vout_123),
    .io_Vout_124(line_cell_io_Vout_124),
    .io_Vout_125(line_cell_io_Vout_125),
    .io_Vout_126(line_cell_io_Vout_126),
    .io_Vout_127(line_cell_io_Vout_127)
  );
  line_cell line_cell_1 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_1_clock),
    .io_WL(line_cell_1_io_WL),
    .io_IN(line_cell_1_io_IN),
    .io_BL(line_cell_1_io_BL),
    .io_Vout_0(line_cell_1_io_Vout_0),
    .io_Vout_1(line_cell_1_io_Vout_1),
    .io_Vout_2(line_cell_1_io_Vout_2),
    .io_Vout_3(line_cell_1_io_Vout_3),
    .io_Vout_4(line_cell_1_io_Vout_4),
    .io_Vout_5(line_cell_1_io_Vout_5),
    .io_Vout_6(line_cell_1_io_Vout_6),
    .io_Vout_7(line_cell_1_io_Vout_7),
    .io_Vout_8(line_cell_1_io_Vout_8),
    .io_Vout_9(line_cell_1_io_Vout_9),
    .io_Vout_10(line_cell_1_io_Vout_10),
    .io_Vout_11(line_cell_1_io_Vout_11),
    .io_Vout_12(line_cell_1_io_Vout_12),
    .io_Vout_13(line_cell_1_io_Vout_13),
    .io_Vout_14(line_cell_1_io_Vout_14),
    .io_Vout_15(line_cell_1_io_Vout_15),
    .io_Vout_16(line_cell_1_io_Vout_16),
    .io_Vout_17(line_cell_1_io_Vout_17),
    .io_Vout_18(line_cell_1_io_Vout_18),
    .io_Vout_19(line_cell_1_io_Vout_19),
    .io_Vout_20(line_cell_1_io_Vout_20),
    .io_Vout_21(line_cell_1_io_Vout_21),
    .io_Vout_22(line_cell_1_io_Vout_22),
    .io_Vout_23(line_cell_1_io_Vout_23),
    .io_Vout_24(line_cell_1_io_Vout_24),
    .io_Vout_25(line_cell_1_io_Vout_25),
    .io_Vout_26(line_cell_1_io_Vout_26),
    .io_Vout_27(line_cell_1_io_Vout_27),
    .io_Vout_28(line_cell_1_io_Vout_28),
    .io_Vout_29(line_cell_1_io_Vout_29),
    .io_Vout_30(line_cell_1_io_Vout_30),
    .io_Vout_31(line_cell_1_io_Vout_31),
    .io_Vout_32(line_cell_1_io_Vout_32),
    .io_Vout_33(line_cell_1_io_Vout_33),
    .io_Vout_34(line_cell_1_io_Vout_34),
    .io_Vout_35(line_cell_1_io_Vout_35),
    .io_Vout_36(line_cell_1_io_Vout_36),
    .io_Vout_37(line_cell_1_io_Vout_37),
    .io_Vout_38(line_cell_1_io_Vout_38),
    .io_Vout_39(line_cell_1_io_Vout_39),
    .io_Vout_40(line_cell_1_io_Vout_40),
    .io_Vout_41(line_cell_1_io_Vout_41),
    .io_Vout_42(line_cell_1_io_Vout_42),
    .io_Vout_43(line_cell_1_io_Vout_43),
    .io_Vout_44(line_cell_1_io_Vout_44),
    .io_Vout_45(line_cell_1_io_Vout_45),
    .io_Vout_46(line_cell_1_io_Vout_46),
    .io_Vout_47(line_cell_1_io_Vout_47),
    .io_Vout_48(line_cell_1_io_Vout_48),
    .io_Vout_49(line_cell_1_io_Vout_49),
    .io_Vout_50(line_cell_1_io_Vout_50),
    .io_Vout_51(line_cell_1_io_Vout_51),
    .io_Vout_52(line_cell_1_io_Vout_52),
    .io_Vout_53(line_cell_1_io_Vout_53),
    .io_Vout_54(line_cell_1_io_Vout_54),
    .io_Vout_55(line_cell_1_io_Vout_55),
    .io_Vout_56(line_cell_1_io_Vout_56),
    .io_Vout_57(line_cell_1_io_Vout_57),
    .io_Vout_58(line_cell_1_io_Vout_58),
    .io_Vout_59(line_cell_1_io_Vout_59),
    .io_Vout_60(line_cell_1_io_Vout_60),
    .io_Vout_61(line_cell_1_io_Vout_61),
    .io_Vout_62(line_cell_1_io_Vout_62),
    .io_Vout_63(line_cell_1_io_Vout_63),
    .io_Vout_64(line_cell_1_io_Vout_64),
    .io_Vout_65(line_cell_1_io_Vout_65),
    .io_Vout_66(line_cell_1_io_Vout_66),
    .io_Vout_67(line_cell_1_io_Vout_67),
    .io_Vout_68(line_cell_1_io_Vout_68),
    .io_Vout_69(line_cell_1_io_Vout_69),
    .io_Vout_70(line_cell_1_io_Vout_70),
    .io_Vout_71(line_cell_1_io_Vout_71),
    .io_Vout_72(line_cell_1_io_Vout_72),
    .io_Vout_73(line_cell_1_io_Vout_73),
    .io_Vout_74(line_cell_1_io_Vout_74),
    .io_Vout_75(line_cell_1_io_Vout_75),
    .io_Vout_76(line_cell_1_io_Vout_76),
    .io_Vout_77(line_cell_1_io_Vout_77),
    .io_Vout_78(line_cell_1_io_Vout_78),
    .io_Vout_79(line_cell_1_io_Vout_79),
    .io_Vout_80(line_cell_1_io_Vout_80),
    .io_Vout_81(line_cell_1_io_Vout_81),
    .io_Vout_82(line_cell_1_io_Vout_82),
    .io_Vout_83(line_cell_1_io_Vout_83),
    .io_Vout_84(line_cell_1_io_Vout_84),
    .io_Vout_85(line_cell_1_io_Vout_85),
    .io_Vout_86(line_cell_1_io_Vout_86),
    .io_Vout_87(line_cell_1_io_Vout_87),
    .io_Vout_88(line_cell_1_io_Vout_88),
    .io_Vout_89(line_cell_1_io_Vout_89),
    .io_Vout_90(line_cell_1_io_Vout_90),
    .io_Vout_91(line_cell_1_io_Vout_91),
    .io_Vout_92(line_cell_1_io_Vout_92),
    .io_Vout_93(line_cell_1_io_Vout_93),
    .io_Vout_94(line_cell_1_io_Vout_94),
    .io_Vout_95(line_cell_1_io_Vout_95),
    .io_Vout_96(line_cell_1_io_Vout_96),
    .io_Vout_97(line_cell_1_io_Vout_97),
    .io_Vout_98(line_cell_1_io_Vout_98),
    .io_Vout_99(line_cell_1_io_Vout_99),
    .io_Vout_100(line_cell_1_io_Vout_100),
    .io_Vout_101(line_cell_1_io_Vout_101),
    .io_Vout_102(line_cell_1_io_Vout_102),
    .io_Vout_103(line_cell_1_io_Vout_103),
    .io_Vout_104(line_cell_1_io_Vout_104),
    .io_Vout_105(line_cell_1_io_Vout_105),
    .io_Vout_106(line_cell_1_io_Vout_106),
    .io_Vout_107(line_cell_1_io_Vout_107),
    .io_Vout_108(line_cell_1_io_Vout_108),
    .io_Vout_109(line_cell_1_io_Vout_109),
    .io_Vout_110(line_cell_1_io_Vout_110),
    .io_Vout_111(line_cell_1_io_Vout_111),
    .io_Vout_112(line_cell_1_io_Vout_112),
    .io_Vout_113(line_cell_1_io_Vout_113),
    .io_Vout_114(line_cell_1_io_Vout_114),
    .io_Vout_115(line_cell_1_io_Vout_115),
    .io_Vout_116(line_cell_1_io_Vout_116),
    .io_Vout_117(line_cell_1_io_Vout_117),
    .io_Vout_118(line_cell_1_io_Vout_118),
    .io_Vout_119(line_cell_1_io_Vout_119),
    .io_Vout_120(line_cell_1_io_Vout_120),
    .io_Vout_121(line_cell_1_io_Vout_121),
    .io_Vout_122(line_cell_1_io_Vout_122),
    .io_Vout_123(line_cell_1_io_Vout_123),
    .io_Vout_124(line_cell_1_io_Vout_124),
    .io_Vout_125(line_cell_1_io_Vout_125),
    .io_Vout_126(line_cell_1_io_Vout_126),
    .io_Vout_127(line_cell_1_io_Vout_127)
  );
  line_cell line_cell_2 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_2_clock),
    .io_WL(line_cell_2_io_WL),
    .io_IN(line_cell_2_io_IN),
    .io_BL(line_cell_2_io_BL),
    .io_Vout_0(line_cell_2_io_Vout_0),
    .io_Vout_1(line_cell_2_io_Vout_1),
    .io_Vout_2(line_cell_2_io_Vout_2),
    .io_Vout_3(line_cell_2_io_Vout_3),
    .io_Vout_4(line_cell_2_io_Vout_4),
    .io_Vout_5(line_cell_2_io_Vout_5),
    .io_Vout_6(line_cell_2_io_Vout_6),
    .io_Vout_7(line_cell_2_io_Vout_7),
    .io_Vout_8(line_cell_2_io_Vout_8),
    .io_Vout_9(line_cell_2_io_Vout_9),
    .io_Vout_10(line_cell_2_io_Vout_10),
    .io_Vout_11(line_cell_2_io_Vout_11),
    .io_Vout_12(line_cell_2_io_Vout_12),
    .io_Vout_13(line_cell_2_io_Vout_13),
    .io_Vout_14(line_cell_2_io_Vout_14),
    .io_Vout_15(line_cell_2_io_Vout_15),
    .io_Vout_16(line_cell_2_io_Vout_16),
    .io_Vout_17(line_cell_2_io_Vout_17),
    .io_Vout_18(line_cell_2_io_Vout_18),
    .io_Vout_19(line_cell_2_io_Vout_19),
    .io_Vout_20(line_cell_2_io_Vout_20),
    .io_Vout_21(line_cell_2_io_Vout_21),
    .io_Vout_22(line_cell_2_io_Vout_22),
    .io_Vout_23(line_cell_2_io_Vout_23),
    .io_Vout_24(line_cell_2_io_Vout_24),
    .io_Vout_25(line_cell_2_io_Vout_25),
    .io_Vout_26(line_cell_2_io_Vout_26),
    .io_Vout_27(line_cell_2_io_Vout_27),
    .io_Vout_28(line_cell_2_io_Vout_28),
    .io_Vout_29(line_cell_2_io_Vout_29),
    .io_Vout_30(line_cell_2_io_Vout_30),
    .io_Vout_31(line_cell_2_io_Vout_31),
    .io_Vout_32(line_cell_2_io_Vout_32),
    .io_Vout_33(line_cell_2_io_Vout_33),
    .io_Vout_34(line_cell_2_io_Vout_34),
    .io_Vout_35(line_cell_2_io_Vout_35),
    .io_Vout_36(line_cell_2_io_Vout_36),
    .io_Vout_37(line_cell_2_io_Vout_37),
    .io_Vout_38(line_cell_2_io_Vout_38),
    .io_Vout_39(line_cell_2_io_Vout_39),
    .io_Vout_40(line_cell_2_io_Vout_40),
    .io_Vout_41(line_cell_2_io_Vout_41),
    .io_Vout_42(line_cell_2_io_Vout_42),
    .io_Vout_43(line_cell_2_io_Vout_43),
    .io_Vout_44(line_cell_2_io_Vout_44),
    .io_Vout_45(line_cell_2_io_Vout_45),
    .io_Vout_46(line_cell_2_io_Vout_46),
    .io_Vout_47(line_cell_2_io_Vout_47),
    .io_Vout_48(line_cell_2_io_Vout_48),
    .io_Vout_49(line_cell_2_io_Vout_49),
    .io_Vout_50(line_cell_2_io_Vout_50),
    .io_Vout_51(line_cell_2_io_Vout_51),
    .io_Vout_52(line_cell_2_io_Vout_52),
    .io_Vout_53(line_cell_2_io_Vout_53),
    .io_Vout_54(line_cell_2_io_Vout_54),
    .io_Vout_55(line_cell_2_io_Vout_55),
    .io_Vout_56(line_cell_2_io_Vout_56),
    .io_Vout_57(line_cell_2_io_Vout_57),
    .io_Vout_58(line_cell_2_io_Vout_58),
    .io_Vout_59(line_cell_2_io_Vout_59),
    .io_Vout_60(line_cell_2_io_Vout_60),
    .io_Vout_61(line_cell_2_io_Vout_61),
    .io_Vout_62(line_cell_2_io_Vout_62),
    .io_Vout_63(line_cell_2_io_Vout_63),
    .io_Vout_64(line_cell_2_io_Vout_64),
    .io_Vout_65(line_cell_2_io_Vout_65),
    .io_Vout_66(line_cell_2_io_Vout_66),
    .io_Vout_67(line_cell_2_io_Vout_67),
    .io_Vout_68(line_cell_2_io_Vout_68),
    .io_Vout_69(line_cell_2_io_Vout_69),
    .io_Vout_70(line_cell_2_io_Vout_70),
    .io_Vout_71(line_cell_2_io_Vout_71),
    .io_Vout_72(line_cell_2_io_Vout_72),
    .io_Vout_73(line_cell_2_io_Vout_73),
    .io_Vout_74(line_cell_2_io_Vout_74),
    .io_Vout_75(line_cell_2_io_Vout_75),
    .io_Vout_76(line_cell_2_io_Vout_76),
    .io_Vout_77(line_cell_2_io_Vout_77),
    .io_Vout_78(line_cell_2_io_Vout_78),
    .io_Vout_79(line_cell_2_io_Vout_79),
    .io_Vout_80(line_cell_2_io_Vout_80),
    .io_Vout_81(line_cell_2_io_Vout_81),
    .io_Vout_82(line_cell_2_io_Vout_82),
    .io_Vout_83(line_cell_2_io_Vout_83),
    .io_Vout_84(line_cell_2_io_Vout_84),
    .io_Vout_85(line_cell_2_io_Vout_85),
    .io_Vout_86(line_cell_2_io_Vout_86),
    .io_Vout_87(line_cell_2_io_Vout_87),
    .io_Vout_88(line_cell_2_io_Vout_88),
    .io_Vout_89(line_cell_2_io_Vout_89),
    .io_Vout_90(line_cell_2_io_Vout_90),
    .io_Vout_91(line_cell_2_io_Vout_91),
    .io_Vout_92(line_cell_2_io_Vout_92),
    .io_Vout_93(line_cell_2_io_Vout_93),
    .io_Vout_94(line_cell_2_io_Vout_94),
    .io_Vout_95(line_cell_2_io_Vout_95),
    .io_Vout_96(line_cell_2_io_Vout_96),
    .io_Vout_97(line_cell_2_io_Vout_97),
    .io_Vout_98(line_cell_2_io_Vout_98),
    .io_Vout_99(line_cell_2_io_Vout_99),
    .io_Vout_100(line_cell_2_io_Vout_100),
    .io_Vout_101(line_cell_2_io_Vout_101),
    .io_Vout_102(line_cell_2_io_Vout_102),
    .io_Vout_103(line_cell_2_io_Vout_103),
    .io_Vout_104(line_cell_2_io_Vout_104),
    .io_Vout_105(line_cell_2_io_Vout_105),
    .io_Vout_106(line_cell_2_io_Vout_106),
    .io_Vout_107(line_cell_2_io_Vout_107),
    .io_Vout_108(line_cell_2_io_Vout_108),
    .io_Vout_109(line_cell_2_io_Vout_109),
    .io_Vout_110(line_cell_2_io_Vout_110),
    .io_Vout_111(line_cell_2_io_Vout_111),
    .io_Vout_112(line_cell_2_io_Vout_112),
    .io_Vout_113(line_cell_2_io_Vout_113),
    .io_Vout_114(line_cell_2_io_Vout_114),
    .io_Vout_115(line_cell_2_io_Vout_115),
    .io_Vout_116(line_cell_2_io_Vout_116),
    .io_Vout_117(line_cell_2_io_Vout_117),
    .io_Vout_118(line_cell_2_io_Vout_118),
    .io_Vout_119(line_cell_2_io_Vout_119),
    .io_Vout_120(line_cell_2_io_Vout_120),
    .io_Vout_121(line_cell_2_io_Vout_121),
    .io_Vout_122(line_cell_2_io_Vout_122),
    .io_Vout_123(line_cell_2_io_Vout_123),
    .io_Vout_124(line_cell_2_io_Vout_124),
    .io_Vout_125(line_cell_2_io_Vout_125),
    .io_Vout_126(line_cell_2_io_Vout_126),
    .io_Vout_127(line_cell_2_io_Vout_127)
  );
  line_cell line_cell_3 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_3_clock),
    .io_WL(line_cell_3_io_WL),
    .io_IN(line_cell_3_io_IN),
    .io_BL(line_cell_3_io_BL),
    .io_Vout_0(line_cell_3_io_Vout_0),
    .io_Vout_1(line_cell_3_io_Vout_1),
    .io_Vout_2(line_cell_3_io_Vout_2),
    .io_Vout_3(line_cell_3_io_Vout_3),
    .io_Vout_4(line_cell_3_io_Vout_4),
    .io_Vout_5(line_cell_3_io_Vout_5),
    .io_Vout_6(line_cell_3_io_Vout_6),
    .io_Vout_7(line_cell_3_io_Vout_7),
    .io_Vout_8(line_cell_3_io_Vout_8),
    .io_Vout_9(line_cell_3_io_Vout_9),
    .io_Vout_10(line_cell_3_io_Vout_10),
    .io_Vout_11(line_cell_3_io_Vout_11),
    .io_Vout_12(line_cell_3_io_Vout_12),
    .io_Vout_13(line_cell_3_io_Vout_13),
    .io_Vout_14(line_cell_3_io_Vout_14),
    .io_Vout_15(line_cell_3_io_Vout_15),
    .io_Vout_16(line_cell_3_io_Vout_16),
    .io_Vout_17(line_cell_3_io_Vout_17),
    .io_Vout_18(line_cell_3_io_Vout_18),
    .io_Vout_19(line_cell_3_io_Vout_19),
    .io_Vout_20(line_cell_3_io_Vout_20),
    .io_Vout_21(line_cell_3_io_Vout_21),
    .io_Vout_22(line_cell_3_io_Vout_22),
    .io_Vout_23(line_cell_3_io_Vout_23),
    .io_Vout_24(line_cell_3_io_Vout_24),
    .io_Vout_25(line_cell_3_io_Vout_25),
    .io_Vout_26(line_cell_3_io_Vout_26),
    .io_Vout_27(line_cell_3_io_Vout_27),
    .io_Vout_28(line_cell_3_io_Vout_28),
    .io_Vout_29(line_cell_3_io_Vout_29),
    .io_Vout_30(line_cell_3_io_Vout_30),
    .io_Vout_31(line_cell_3_io_Vout_31),
    .io_Vout_32(line_cell_3_io_Vout_32),
    .io_Vout_33(line_cell_3_io_Vout_33),
    .io_Vout_34(line_cell_3_io_Vout_34),
    .io_Vout_35(line_cell_3_io_Vout_35),
    .io_Vout_36(line_cell_3_io_Vout_36),
    .io_Vout_37(line_cell_3_io_Vout_37),
    .io_Vout_38(line_cell_3_io_Vout_38),
    .io_Vout_39(line_cell_3_io_Vout_39),
    .io_Vout_40(line_cell_3_io_Vout_40),
    .io_Vout_41(line_cell_3_io_Vout_41),
    .io_Vout_42(line_cell_3_io_Vout_42),
    .io_Vout_43(line_cell_3_io_Vout_43),
    .io_Vout_44(line_cell_3_io_Vout_44),
    .io_Vout_45(line_cell_3_io_Vout_45),
    .io_Vout_46(line_cell_3_io_Vout_46),
    .io_Vout_47(line_cell_3_io_Vout_47),
    .io_Vout_48(line_cell_3_io_Vout_48),
    .io_Vout_49(line_cell_3_io_Vout_49),
    .io_Vout_50(line_cell_3_io_Vout_50),
    .io_Vout_51(line_cell_3_io_Vout_51),
    .io_Vout_52(line_cell_3_io_Vout_52),
    .io_Vout_53(line_cell_3_io_Vout_53),
    .io_Vout_54(line_cell_3_io_Vout_54),
    .io_Vout_55(line_cell_3_io_Vout_55),
    .io_Vout_56(line_cell_3_io_Vout_56),
    .io_Vout_57(line_cell_3_io_Vout_57),
    .io_Vout_58(line_cell_3_io_Vout_58),
    .io_Vout_59(line_cell_3_io_Vout_59),
    .io_Vout_60(line_cell_3_io_Vout_60),
    .io_Vout_61(line_cell_3_io_Vout_61),
    .io_Vout_62(line_cell_3_io_Vout_62),
    .io_Vout_63(line_cell_3_io_Vout_63),
    .io_Vout_64(line_cell_3_io_Vout_64),
    .io_Vout_65(line_cell_3_io_Vout_65),
    .io_Vout_66(line_cell_3_io_Vout_66),
    .io_Vout_67(line_cell_3_io_Vout_67),
    .io_Vout_68(line_cell_3_io_Vout_68),
    .io_Vout_69(line_cell_3_io_Vout_69),
    .io_Vout_70(line_cell_3_io_Vout_70),
    .io_Vout_71(line_cell_3_io_Vout_71),
    .io_Vout_72(line_cell_3_io_Vout_72),
    .io_Vout_73(line_cell_3_io_Vout_73),
    .io_Vout_74(line_cell_3_io_Vout_74),
    .io_Vout_75(line_cell_3_io_Vout_75),
    .io_Vout_76(line_cell_3_io_Vout_76),
    .io_Vout_77(line_cell_3_io_Vout_77),
    .io_Vout_78(line_cell_3_io_Vout_78),
    .io_Vout_79(line_cell_3_io_Vout_79),
    .io_Vout_80(line_cell_3_io_Vout_80),
    .io_Vout_81(line_cell_3_io_Vout_81),
    .io_Vout_82(line_cell_3_io_Vout_82),
    .io_Vout_83(line_cell_3_io_Vout_83),
    .io_Vout_84(line_cell_3_io_Vout_84),
    .io_Vout_85(line_cell_3_io_Vout_85),
    .io_Vout_86(line_cell_3_io_Vout_86),
    .io_Vout_87(line_cell_3_io_Vout_87),
    .io_Vout_88(line_cell_3_io_Vout_88),
    .io_Vout_89(line_cell_3_io_Vout_89),
    .io_Vout_90(line_cell_3_io_Vout_90),
    .io_Vout_91(line_cell_3_io_Vout_91),
    .io_Vout_92(line_cell_3_io_Vout_92),
    .io_Vout_93(line_cell_3_io_Vout_93),
    .io_Vout_94(line_cell_3_io_Vout_94),
    .io_Vout_95(line_cell_3_io_Vout_95),
    .io_Vout_96(line_cell_3_io_Vout_96),
    .io_Vout_97(line_cell_3_io_Vout_97),
    .io_Vout_98(line_cell_3_io_Vout_98),
    .io_Vout_99(line_cell_3_io_Vout_99),
    .io_Vout_100(line_cell_3_io_Vout_100),
    .io_Vout_101(line_cell_3_io_Vout_101),
    .io_Vout_102(line_cell_3_io_Vout_102),
    .io_Vout_103(line_cell_3_io_Vout_103),
    .io_Vout_104(line_cell_3_io_Vout_104),
    .io_Vout_105(line_cell_3_io_Vout_105),
    .io_Vout_106(line_cell_3_io_Vout_106),
    .io_Vout_107(line_cell_3_io_Vout_107),
    .io_Vout_108(line_cell_3_io_Vout_108),
    .io_Vout_109(line_cell_3_io_Vout_109),
    .io_Vout_110(line_cell_3_io_Vout_110),
    .io_Vout_111(line_cell_3_io_Vout_111),
    .io_Vout_112(line_cell_3_io_Vout_112),
    .io_Vout_113(line_cell_3_io_Vout_113),
    .io_Vout_114(line_cell_3_io_Vout_114),
    .io_Vout_115(line_cell_3_io_Vout_115),
    .io_Vout_116(line_cell_3_io_Vout_116),
    .io_Vout_117(line_cell_3_io_Vout_117),
    .io_Vout_118(line_cell_3_io_Vout_118),
    .io_Vout_119(line_cell_3_io_Vout_119),
    .io_Vout_120(line_cell_3_io_Vout_120),
    .io_Vout_121(line_cell_3_io_Vout_121),
    .io_Vout_122(line_cell_3_io_Vout_122),
    .io_Vout_123(line_cell_3_io_Vout_123),
    .io_Vout_124(line_cell_3_io_Vout_124),
    .io_Vout_125(line_cell_3_io_Vout_125),
    .io_Vout_126(line_cell_3_io_Vout_126),
    .io_Vout_127(line_cell_3_io_Vout_127)
  );
  line_cell line_cell_4 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_4_clock),
    .io_WL(line_cell_4_io_WL),
    .io_IN(line_cell_4_io_IN),
    .io_BL(line_cell_4_io_BL),
    .io_Vout_0(line_cell_4_io_Vout_0),
    .io_Vout_1(line_cell_4_io_Vout_1),
    .io_Vout_2(line_cell_4_io_Vout_2),
    .io_Vout_3(line_cell_4_io_Vout_3),
    .io_Vout_4(line_cell_4_io_Vout_4),
    .io_Vout_5(line_cell_4_io_Vout_5),
    .io_Vout_6(line_cell_4_io_Vout_6),
    .io_Vout_7(line_cell_4_io_Vout_7),
    .io_Vout_8(line_cell_4_io_Vout_8),
    .io_Vout_9(line_cell_4_io_Vout_9),
    .io_Vout_10(line_cell_4_io_Vout_10),
    .io_Vout_11(line_cell_4_io_Vout_11),
    .io_Vout_12(line_cell_4_io_Vout_12),
    .io_Vout_13(line_cell_4_io_Vout_13),
    .io_Vout_14(line_cell_4_io_Vout_14),
    .io_Vout_15(line_cell_4_io_Vout_15),
    .io_Vout_16(line_cell_4_io_Vout_16),
    .io_Vout_17(line_cell_4_io_Vout_17),
    .io_Vout_18(line_cell_4_io_Vout_18),
    .io_Vout_19(line_cell_4_io_Vout_19),
    .io_Vout_20(line_cell_4_io_Vout_20),
    .io_Vout_21(line_cell_4_io_Vout_21),
    .io_Vout_22(line_cell_4_io_Vout_22),
    .io_Vout_23(line_cell_4_io_Vout_23),
    .io_Vout_24(line_cell_4_io_Vout_24),
    .io_Vout_25(line_cell_4_io_Vout_25),
    .io_Vout_26(line_cell_4_io_Vout_26),
    .io_Vout_27(line_cell_4_io_Vout_27),
    .io_Vout_28(line_cell_4_io_Vout_28),
    .io_Vout_29(line_cell_4_io_Vout_29),
    .io_Vout_30(line_cell_4_io_Vout_30),
    .io_Vout_31(line_cell_4_io_Vout_31),
    .io_Vout_32(line_cell_4_io_Vout_32),
    .io_Vout_33(line_cell_4_io_Vout_33),
    .io_Vout_34(line_cell_4_io_Vout_34),
    .io_Vout_35(line_cell_4_io_Vout_35),
    .io_Vout_36(line_cell_4_io_Vout_36),
    .io_Vout_37(line_cell_4_io_Vout_37),
    .io_Vout_38(line_cell_4_io_Vout_38),
    .io_Vout_39(line_cell_4_io_Vout_39),
    .io_Vout_40(line_cell_4_io_Vout_40),
    .io_Vout_41(line_cell_4_io_Vout_41),
    .io_Vout_42(line_cell_4_io_Vout_42),
    .io_Vout_43(line_cell_4_io_Vout_43),
    .io_Vout_44(line_cell_4_io_Vout_44),
    .io_Vout_45(line_cell_4_io_Vout_45),
    .io_Vout_46(line_cell_4_io_Vout_46),
    .io_Vout_47(line_cell_4_io_Vout_47),
    .io_Vout_48(line_cell_4_io_Vout_48),
    .io_Vout_49(line_cell_4_io_Vout_49),
    .io_Vout_50(line_cell_4_io_Vout_50),
    .io_Vout_51(line_cell_4_io_Vout_51),
    .io_Vout_52(line_cell_4_io_Vout_52),
    .io_Vout_53(line_cell_4_io_Vout_53),
    .io_Vout_54(line_cell_4_io_Vout_54),
    .io_Vout_55(line_cell_4_io_Vout_55),
    .io_Vout_56(line_cell_4_io_Vout_56),
    .io_Vout_57(line_cell_4_io_Vout_57),
    .io_Vout_58(line_cell_4_io_Vout_58),
    .io_Vout_59(line_cell_4_io_Vout_59),
    .io_Vout_60(line_cell_4_io_Vout_60),
    .io_Vout_61(line_cell_4_io_Vout_61),
    .io_Vout_62(line_cell_4_io_Vout_62),
    .io_Vout_63(line_cell_4_io_Vout_63),
    .io_Vout_64(line_cell_4_io_Vout_64),
    .io_Vout_65(line_cell_4_io_Vout_65),
    .io_Vout_66(line_cell_4_io_Vout_66),
    .io_Vout_67(line_cell_4_io_Vout_67),
    .io_Vout_68(line_cell_4_io_Vout_68),
    .io_Vout_69(line_cell_4_io_Vout_69),
    .io_Vout_70(line_cell_4_io_Vout_70),
    .io_Vout_71(line_cell_4_io_Vout_71),
    .io_Vout_72(line_cell_4_io_Vout_72),
    .io_Vout_73(line_cell_4_io_Vout_73),
    .io_Vout_74(line_cell_4_io_Vout_74),
    .io_Vout_75(line_cell_4_io_Vout_75),
    .io_Vout_76(line_cell_4_io_Vout_76),
    .io_Vout_77(line_cell_4_io_Vout_77),
    .io_Vout_78(line_cell_4_io_Vout_78),
    .io_Vout_79(line_cell_4_io_Vout_79),
    .io_Vout_80(line_cell_4_io_Vout_80),
    .io_Vout_81(line_cell_4_io_Vout_81),
    .io_Vout_82(line_cell_4_io_Vout_82),
    .io_Vout_83(line_cell_4_io_Vout_83),
    .io_Vout_84(line_cell_4_io_Vout_84),
    .io_Vout_85(line_cell_4_io_Vout_85),
    .io_Vout_86(line_cell_4_io_Vout_86),
    .io_Vout_87(line_cell_4_io_Vout_87),
    .io_Vout_88(line_cell_4_io_Vout_88),
    .io_Vout_89(line_cell_4_io_Vout_89),
    .io_Vout_90(line_cell_4_io_Vout_90),
    .io_Vout_91(line_cell_4_io_Vout_91),
    .io_Vout_92(line_cell_4_io_Vout_92),
    .io_Vout_93(line_cell_4_io_Vout_93),
    .io_Vout_94(line_cell_4_io_Vout_94),
    .io_Vout_95(line_cell_4_io_Vout_95),
    .io_Vout_96(line_cell_4_io_Vout_96),
    .io_Vout_97(line_cell_4_io_Vout_97),
    .io_Vout_98(line_cell_4_io_Vout_98),
    .io_Vout_99(line_cell_4_io_Vout_99),
    .io_Vout_100(line_cell_4_io_Vout_100),
    .io_Vout_101(line_cell_4_io_Vout_101),
    .io_Vout_102(line_cell_4_io_Vout_102),
    .io_Vout_103(line_cell_4_io_Vout_103),
    .io_Vout_104(line_cell_4_io_Vout_104),
    .io_Vout_105(line_cell_4_io_Vout_105),
    .io_Vout_106(line_cell_4_io_Vout_106),
    .io_Vout_107(line_cell_4_io_Vout_107),
    .io_Vout_108(line_cell_4_io_Vout_108),
    .io_Vout_109(line_cell_4_io_Vout_109),
    .io_Vout_110(line_cell_4_io_Vout_110),
    .io_Vout_111(line_cell_4_io_Vout_111),
    .io_Vout_112(line_cell_4_io_Vout_112),
    .io_Vout_113(line_cell_4_io_Vout_113),
    .io_Vout_114(line_cell_4_io_Vout_114),
    .io_Vout_115(line_cell_4_io_Vout_115),
    .io_Vout_116(line_cell_4_io_Vout_116),
    .io_Vout_117(line_cell_4_io_Vout_117),
    .io_Vout_118(line_cell_4_io_Vout_118),
    .io_Vout_119(line_cell_4_io_Vout_119),
    .io_Vout_120(line_cell_4_io_Vout_120),
    .io_Vout_121(line_cell_4_io_Vout_121),
    .io_Vout_122(line_cell_4_io_Vout_122),
    .io_Vout_123(line_cell_4_io_Vout_123),
    .io_Vout_124(line_cell_4_io_Vout_124),
    .io_Vout_125(line_cell_4_io_Vout_125),
    .io_Vout_126(line_cell_4_io_Vout_126),
    .io_Vout_127(line_cell_4_io_Vout_127)
  );
  line_cell line_cell_5 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_5_clock),
    .io_WL(line_cell_5_io_WL),
    .io_IN(line_cell_5_io_IN),
    .io_BL(line_cell_5_io_BL),
    .io_Vout_0(line_cell_5_io_Vout_0),
    .io_Vout_1(line_cell_5_io_Vout_1),
    .io_Vout_2(line_cell_5_io_Vout_2),
    .io_Vout_3(line_cell_5_io_Vout_3),
    .io_Vout_4(line_cell_5_io_Vout_4),
    .io_Vout_5(line_cell_5_io_Vout_5),
    .io_Vout_6(line_cell_5_io_Vout_6),
    .io_Vout_7(line_cell_5_io_Vout_7),
    .io_Vout_8(line_cell_5_io_Vout_8),
    .io_Vout_9(line_cell_5_io_Vout_9),
    .io_Vout_10(line_cell_5_io_Vout_10),
    .io_Vout_11(line_cell_5_io_Vout_11),
    .io_Vout_12(line_cell_5_io_Vout_12),
    .io_Vout_13(line_cell_5_io_Vout_13),
    .io_Vout_14(line_cell_5_io_Vout_14),
    .io_Vout_15(line_cell_5_io_Vout_15),
    .io_Vout_16(line_cell_5_io_Vout_16),
    .io_Vout_17(line_cell_5_io_Vout_17),
    .io_Vout_18(line_cell_5_io_Vout_18),
    .io_Vout_19(line_cell_5_io_Vout_19),
    .io_Vout_20(line_cell_5_io_Vout_20),
    .io_Vout_21(line_cell_5_io_Vout_21),
    .io_Vout_22(line_cell_5_io_Vout_22),
    .io_Vout_23(line_cell_5_io_Vout_23),
    .io_Vout_24(line_cell_5_io_Vout_24),
    .io_Vout_25(line_cell_5_io_Vout_25),
    .io_Vout_26(line_cell_5_io_Vout_26),
    .io_Vout_27(line_cell_5_io_Vout_27),
    .io_Vout_28(line_cell_5_io_Vout_28),
    .io_Vout_29(line_cell_5_io_Vout_29),
    .io_Vout_30(line_cell_5_io_Vout_30),
    .io_Vout_31(line_cell_5_io_Vout_31),
    .io_Vout_32(line_cell_5_io_Vout_32),
    .io_Vout_33(line_cell_5_io_Vout_33),
    .io_Vout_34(line_cell_5_io_Vout_34),
    .io_Vout_35(line_cell_5_io_Vout_35),
    .io_Vout_36(line_cell_5_io_Vout_36),
    .io_Vout_37(line_cell_5_io_Vout_37),
    .io_Vout_38(line_cell_5_io_Vout_38),
    .io_Vout_39(line_cell_5_io_Vout_39),
    .io_Vout_40(line_cell_5_io_Vout_40),
    .io_Vout_41(line_cell_5_io_Vout_41),
    .io_Vout_42(line_cell_5_io_Vout_42),
    .io_Vout_43(line_cell_5_io_Vout_43),
    .io_Vout_44(line_cell_5_io_Vout_44),
    .io_Vout_45(line_cell_5_io_Vout_45),
    .io_Vout_46(line_cell_5_io_Vout_46),
    .io_Vout_47(line_cell_5_io_Vout_47),
    .io_Vout_48(line_cell_5_io_Vout_48),
    .io_Vout_49(line_cell_5_io_Vout_49),
    .io_Vout_50(line_cell_5_io_Vout_50),
    .io_Vout_51(line_cell_5_io_Vout_51),
    .io_Vout_52(line_cell_5_io_Vout_52),
    .io_Vout_53(line_cell_5_io_Vout_53),
    .io_Vout_54(line_cell_5_io_Vout_54),
    .io_Vout_55(line_cell_5_io_Vout_55),
    .io_Vout_56(line_cell_5_io_Vout_56),
    .io_Vout_57(line_cell_5_io_Vout_57),
    .io_Vout_58(line_cell_5_io_Vout_58),
    .io_Vout_59(line_cell_5_io_Vout_59),
    .io_Vout_60(line_cell_5_io_Vout_60),
    .io_Vout_61(line_cell_5_io_Vout_61),
    .io_Vout_62(line_cell_5_io_Vout_62),
    .io_Vout_63(line_cell_5_io_Vout_63),
    .io_Vout_64(line_cell_5_io_Vout_64),
    .io_Vout_65(line_cell_5_io_Vout_65),
    .io_Vout_66(line_cell_5_io_Vout_66),
    .io_Vout_67(line_cell_5_io_Vout_67),
    .io_Vout_68(line_cell_5_io_Vout_68),
    .io_Vout_69(line_cell_5_io_Vout_69),
    .io_Vout_70(line_cell_5_io_Vout_70),
    .io_Vout_71(line_cell_5_io_Vout_71),
    .io_Vout_72(line_cell_5_io_Vout_72),
    .io_Vout_73(line_cell_5_io_Vout_73),
    .io_Vout_74(line_cell_5_io_Vout_74),
    .io_Vout_75(line_cell_5_io_Vout_75),
    .io_Vout_76(line_cell_5_io_Vout_76),
    .io_Vout_77(line_cell_5_io_Vout_77),
    .io_Vout_78(line_cell_5_io_Vout_78),
    .io_Vout_79(line_cell_5_io_Vout_79),
    .io_Vout_80(line_cell_5_io_Vout_80),
    .io_Vout_81(line_cell_5_io_Vout_81),
    .io_Vout_82(line_cell_5_io_Vout_82),
    .io_Vout_83(line_cell_5_io_Vout_83),
    .io_Vout_84(line_cell_5_io_Vout_84),
    .io_Vout_85(line_cell_5_io_Vout_85),
    .io_Vout_86(line_cell_5_io_Vout_86),
    .io_Vout_87(line_cell_5_io_Vout_87),
    .io_Vout_88(line_cell_5_io_Vout_88),
    .io_Vout_89(line_cell_5_io_Vout_89),
    .io_Vout_90(line_cell_5_io_Vout_90),
    .io_Vout_91(line_cell_5_io_Vout_91),
    .io_Vout_92(line_cell_5_io_Vout_92),
    .io_Vout_93(line_cell_5_io_Vout_93),
    .io_Vout_94(line_cell_5_io_Vout_94),
    .io_Vout_95(line_cell_5_io_Vout_95),
    .io_Vout_96(line_cell_5_io_Vout_96),
    .io_Vout_97(line_cell_5_io_Vout_97),
    .io_Vout_98(line_cell_5_io_Vout_98),
    .io_Vout_99(line_cell_5_io_Vout_99),
    .io_Vout_100(line_cell_5_io_Vout_100),
    .io_Vout_101(line_cell_5_io_Vout_101),
    .io_Vout_102(line_cell_5_io_Vout_102),
    .io_Vout_103(line_cell_5_io_Vout_103),
    .io_Vout_104(line_cell_5_io_Vout_104),
    .io_Vout_105(line_cell_5_io_Vout_105),
    .io_Vout_106(line_cell_5_io_Vout_106),
    .io_Vout_107(line_cell_5_io_Vout_107),
    .io_Vout_108(line_cell_5_io_Vout_108),
    .io_Vout_109(line_cell_5_io_Vout_109),
    .io_Vout_110(line_cell_5_io_Vout_110),
    .io_Vout_111(line_cell_5_io_Vout_111),
    .io_Vout_112(line_cell_5_io_Vout_112),
    .io_Vout_113(line_cell_5_io_Vout_113),
    .io_Vout_114(line_cell_5_io_Vout_114),
    .io_Vout_115(line_cell_5_io_Vout_115),
    .io_Vout_116(line_cell_5_io_Vout_116),
    .io_Vout_117(line_cell_5_io_Vout_117),
    .io_Vout_118(line_cell_5_io_Vout_118),
    .io_Vout_119(line_cell_5_io_Vout_119),
    .io_Vout_120(line_cell_5_io_Vout_120),
    .io_Vout_121(line_cell_5_io_Vout_121),
    .io_Vout_122(line_cell_5_io_Vout_122),
    .io_Vout_123(line_cell_5_io_Vout_123),
    .io_Vout_124(line_cell_5_io_Vout_124),
    .io_Vout_125(line_cell_5_io_Vout_125),
    .io_Vout_126(line_cell_5_io_Vout_126),
    .io_Vout_127(line_cell_5_io_Vout_127)
  );
  line_cell line_cell_6 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_6_clock),
    .io_WL(line_cell_6_io_WL),
    .io_IN(line_cell_6_io_IN),
    .io_BL(line_cell_6_io_BL),
    .io_Vout_0(line_cell_6_io_Vout_0),
    .io_Vout_1(line_cell_6_io_Vout_1),
    .io_Vout_2(line_cell_6_io_Vout_2),
    .io_Vout_3(line_cell_6_io_Vout_3),
    .io_Vout_4(line_cell_6_io_Vout_4),
    .io_Vout_5(line_cell_6_io_Vout_5),
    .io_Vout_6(line_cell_6_io_Vout_6),
    .io_Vout_7(line_cell_6_io_Vout_7),
    .io_Vout_8(line_cell_6_io_Vout_8),
    .io_Vout_9(line_cell_6_io_Vout_9),
    .io_Vout_10(line_cell_6_io_Vout_10),
    .io_Vout_11(line_cell_6_io_Vout_11),
    .io_Vout_12(line_cell_6_io_Vout_12),
    .io_Vout_13(line_cell_6_io_Vout_13),
    .io_Vout_14(line_cell_6_io_Vout_14),
    .io_Vout_15(line_cell_6_io_Vout_15),
    .io_Vout_16(line_cell_6_io_Vout_16),
    .io_Vout_17(line_cell_6_io_Vout_17),
    .io_Vout_18(line_cell_6_io_Vout_18),
    .io_Vout_19(line_cell_6_io_Vout_19),
    .io_Vout_20(line_cell_6_io_Vout_20),
    .io_Vout_21(line_cell_6_io_Vout_21),
    .io_Vout_22(line_cell_6_io_Vout_22),
    .io_Vout_23(line_cell_6_io_Vout_23),
    .io_Vout_24(line_cell_6_io_Vout_24),
    .io_Vout_25(line_cell_6_io_Vout_25),
    .io_Vout_26(line_cell_6_io_Vout_26),
    .io_Vout_27(line_cell_6_io_Vout_27),
    .io_Vout_28(line_cell_6_io_Vout_28),
    .io_Vout_29(line_cell_6_io_Vout_29),
    .io_Vout_30(line_cell_6_io_Vout_30),
    .io_Vout_31(line_cell_6_io_Vout_31),
    .io_Vout_32(line_cell_6_io_Vout_32),
    .io_Vout_33(line_cell_6_io_Vout_33),
    .io_Vout_34(line_cell_6_io_Vout_34),
    .io_Vout_35(line_cell_6_io_Vout_35),
    .io_Vout_36(line_cell_6_io_Vout_36),
    .io_Vout_37(line_cell_6_io_Vout_37),
    .io_Vout_38(line_cell_6_io_Vout_38),
    .io_Vout_39(line_cell_6_io_Vout_39),
    .io_Vout_40(line_cell_6_io_Vout_40),
    .io_Vout_41(line_cell_6_io_Vout_41),
    .io_Vout_42(line_cell_6_io_Vout_42),
    .io_Vout_43(line_cell_6_io_Vout_43),
    .io_Vout_44(line_cell_6_io_Vout_44),
    .io_Vout_45(line_cell_6_io_Vout_45),
    .io_Vout_46(line_cell_6_io_Vout_46),
    .io_Vout_47(line_cell_6_io_Vout_47),
    .io_Vout_48(line_cell_6_io_Vout_48),
    .io_Vout_49(line_cell_6_io_Vout_49),
    .io_Vout_50(line_cell_6_io_Vout_50),
    .io_Vout_51(line_cell_6_io_Vout_51),
    .io_Vout_52(line_cell_6_io_Vout_52),
    .io_Vout_53(line_cell_6_io_Vout_53),
    .io_Vout_54(line_cell_6_io_Vout_54),
    .io_Vout_55(line_cell_6_io_Vout_55),
    .io_Vout_56(line_cell_6_io_Vout_56),
    .io_Vout_57(line_cell_6_io_Vout_57),
    .io_Vout_58(line_cell_6_io_Vout_58),
    .io_Vout_59(line_cell_6_io_Vout_59),
    .io_Vout_60(line_cell_6_io_Vout_60),
    .io_Vout_61(line_cell_6_io_Vout_61),
    .io_Vout_62(line_cell_6_io_Vout_62),
    .io_Vout_63(line_cell_6_io_Vout_63),
    .io_Vout_64(line_cell_6_io_Vout_64),
    .io_Vout_65(line_cell_6_io_Vout_65),
    .io_Vout_66(line_cell_6_io_Vout_66),
    .io_Vout_67(line_cell_6_io_Vout_67),
    .io_Vout_68(line_cell_6_io_Vout_68),
    .io_Vout_69(line_cell_6_io_Vout_69),
    .io_Vout_70(line_cell_6_io_Vout_70),
    .io_Vout_71(line_cell_6_io_Vout_71),
    .io_Vout_72(line_cell_6_io_Vout_72),
    .io_Vout_73(line_cell_6_io_Vout_73),
    .io_Vout_74(line_cell_6_io_Vout_74),
    .io_Vout_75(line_cell_6_io_Vout_75),
    .io_Vout_76(line_cell_6_io_Vout_76),
    .io_Vout_77(line_cell_6_io_Vout_77),
    .io_Vout_78(line_cell_6_io_Vout_78),
    .io_Vout_79(line_cell_6_io_Vout_79),
    .io_Vout_80(line_cell_6_io_Vout_80),
    .io_Vout_81(line_cell_6_io_Vout_81),
    .io_Vout_82(line_cell_6_io_Vout_82),
    .io_Vout_83(line_cell_6_io_Vout_83),
    .io_Vout_84(line_cell_6_io_Vout_84),
    .io_Vout_85(line_cell_6_io_Vout_85),
    .io_Vout_86(line_cell_6_io_Vout_86),
    .io_Vout_87(line_cell_6_io_Vout_87),
    .io_Vout_88(line_cell_6_io_Vout_88),
    .io_Vout_89(line_cell_6_io_Vout_89),
    .io_Vout_90(line_cell_6_io_Vout_90),
    .io_Vout_91(line_cell_6_io_Vout_91),
    .io_Vout_92(line_cell_6_io_Vout_92),
    .io_Vout_93(line_cell_6_io_Vout_93),
    .io_Vout_94(line_cell_6_io_Vout_94),
    .io_Vout_95(line_cell_6_io_Vout_95),
    .io_Vout_96(line_cell_6_io_Vout_96),
    .io_Vout_97(line_cell_6_io_Vout_97),
    .io_Vout_98(line_cell_6_io_Vout_98),
    .io_Vout_99(line_cell_6_io_Vout_99),
    .io_Vout_100(line_cell_6_io_Vout_100),
    .io_Vout_101(line_cell_6_io_Vout_101),
    .io_Vout_102(line_cell_6_io_Vout_102),
    .io_Vout_103(line_cell_6_io_Vout_103),
    .io_Vout_104(line_cell_6_io_Vout_104),
    .io_Vout_105(line_cell_6_io_Vout_105),
    .io_Vout_106(line_cell_6_io_Vout_106),
    .io_Vout_107(line_cell_6_io_Vout_107),
    .io_Vout_108(line_cell_6_io_Vout_108),
    .io_Vout_109(line_cell_6_io_Vout_109),
    .io_Vout_110(line_cell_6_io_Vout_110),
    .io_Vout_111(line_cell_6_io_Vout_111),
    .io_Vout_112(line_cell_6_io_Vout_112),
    .io_Vout_113(line_cell_6_io_Vout_113),
    .io_Vout_114(line_cell_6_io_Vout_114),
    .io_Vout_115(line_cell_6_io_Vout_115),
    .io_Vout_116(line_cell_6_io_Vout_116),
    .io_Vout_117(line_cell_6_io_Vout_117),
    .io_Vout_118(line_cell_6_io_Vout_118),
    .io_Vout_119(line_cell_6_io_Vout_119),
    .io_Vout_120(line_cell_6_io_Vout_120),
    .io_Vout_121(line_cell_6_io_Vout_121),
    .io_Vout_122(line_cell_6_io_Vout_122),
    .io_Vout_123(line_cell_6_io_Vout_123),
    .io_Vout_124(line_cell_6_io_Vout_124),
    .io_Vout_125(line_cell_6_io_Vout_125),
    .io_Vout_126(line_cell_6_io_Vout_126),
    .io_Vout_127(line_cell_6_io_Vout_127)
  );
  line_cell line_cell_7 ( // @[Array_8x128.scala 17:55]
    .clock(line_cell_7_clock),
    .io_WL(line_cell_7_io_WL),
    .io_IN(line_cell_7_io_IN),
    .io_BL(line_cell_7_io_BL),
    .io_Vout_0(line_cell_7_io_Vout_0),
    .io_Vout_1(line_cell_7_io_Vout_1),
    .io_Vout_2(line_cell_7_io_Vout_2),
    .io_Vout_3(line_cell_7_io_Vout_3),
    .io_Vout_4(line_cell_7_io_Vout_4),
    .io_Vout_5(line_cell_7_io_Vout_5),
    .io_Vout_6(line_cell_7_io_Vout_6),
    .io_Vout_7(line_cell_7_io_Vout_7),
    .io_Vout_8(line_cell_7_io_Vout_8),
    .io_Vout_9(line_cell_7_io_Vout_9),
    .io_Vout_10(line_cell_7_io_Vout_10),
    .io_Vout_11(line_cell_7_io_Vout_11),
    .io_Vout_12(line_cell_7_io_Vout_12),
    .io_Vout_13(line_cell_7_io_Vout_13),
    .io_Vout_14(line_cell_7_io_Vout_14),
    .io_Vout_15(line_cell_7_io_Vout_15),
    .io_Vout_16(line_cell_7_io_Vout_16),
    .io_Vout_17(line_cell_7_io_Vout_17),
    .io_Vout_18(line_cell_7_io_Vout_18),
    .io_Vout_19(line_cell_7_io_Vout_19),
    .io_Vout_20(line_cell_7_io_Vout_20),
    .io_Vout_21(line_cell_7_io_Vout_21),
    .io_Vout_22(line_cell_7_io_Vout_22),
    .io_Vout_23(line_cell_7_io_Vout_23),
    .io_Vout_24(line_cell_7_io_Vout_24),
    .io_Vout_25(line_cell_7_io_Vout_25),
    .io_Vout_26(line_cell_7_io_Vout_26),
    .io_Vout_27(line_cell_7_io_Vout_27),
    .io_Vout_28(line_cell_7_io_Vout_28),
    .io_Vout_29(line_cell_7_io_Vout_29),
    .io_Vout_30(line_cell_7_io_Vout_30),
    .io_Vout_31(line_cell_7_io_Vout_31),
    .io_Vout_32(line_cell_7_io_Vout_32),
    .io_Vout_33(line_cell_7_io_Vout_33),
    .io_Vout_34(line_cell_7_io_Vout_34),
    .io_Vout_35(line_cell_7_io_Vout_35),
    .io_Vout_36(line_cell_7_io_Vout_36),
    .io_Vout_37(line_cell_7_io_Vout_37),
    .io_Vout_38(line_cell_7_io_Vout_38),
    .io_Vout_39(line_cell_7_io_Vout_39),
    .io_Vout_40(line_cell_7_io_Vout_40),
    .io_Vout_41(line_cell_7_io_Vout_41),
    .io_Vout_42(line_cell_7_io_Vout_42),
    .io_Vout_43(line_cell_7_io_Vout_43),
    .io_Vout_44(line_cell_7_io_Vout_44),
    .io_Vout_45(line_cell_7_io_Vout_45),
    .io_Vout_46(line_cell_7_io_Vout_46),
    .io_Vout_47(line_cell_7_io_Vout_47),
    .io_Vout_48(line_cell_7_io_Vout_48),
    .io_Vout_49(line_cell_7_io_Vout_49),
    .io_Vout_50(line_cell_7_io_Vout_50),
    .io_Vout_51(line_cell_7_io_Vout_51),
    .io_Vout_52(line_cell_7_io_Vout_52),
    .io_Vout_53(line_cell_7_io_Vout_53),
    .io_Vout_54(line_cell_7_io_Vout_54),
    .io_Vout_55(line_cell_7_io_Vout_55),
    .io_Vout_56(line_cell_7_io_Vout_56),
    .io_Vout_57(line_cell_7_io_Vout_57),
    .io_Vout_58(line_cell_7_io_Vout_58),
    .io_Vout_59(line_cell_7_io_Vout_59),
    .io_Vout_60(line_cell_7_io_Vout_60),
    .io_Vout_61(line_cell_7_io_Vout_61),
    .io_Vout_62(line_cell_7_io_Vout_62),
    .io_Vout_63(line_cell_7_io_Vout_63),
    .io_Vout_64(line_cell_7_io_Vout_64),
    .io_Vout_65(line_cell_7_io_Vout_65),
    .io_Vout_66(line_cell_7_io_Vout_66),
    .io_Vout_67(line_cell_7_io_Vout_67),
    .io_Vout_68(line_cell_7_io_Vout_68),
    .io_Vout_69(line_cell_7_io_Vout_69),
    .io_Vout_70(line_cell_7_io_Vout_70),
    .io_Vout_71(line_cell_7_io_Vout_71),
    .io_Vout_72(line_cell_7_io_Vout_72),
    .io_Vout_73(line_cell_7_io_Vout_73),
    .io_Vout_74(line_cell_7_io_Vout_74),
    .io_Vout_75(line_cell_7_io_Vout_75),
    .io_Vout_76(line_cell_7_io_Vout_76),
    .io_Vout_77(line_cell_7_io_Vout_77),
    .io_Vout_78(line_cell_7_io_Vout_78),
    .io_Vout_79(line_cell_7_io_Vout_79),
    .io_Vout_80(line_cell_7_io_Vout_80),
    .io_Vout_81(line_cell_7_io_Vout_81),
    .io_Vout_82(line_cell_7_io_Vout_82),
    .io_Vout_83(line_cell_7_io_Vout_83),
    .io_Vout_84(line_cell_7_io_Vout_84),
    .io_Vout_85(line_cell_7_io_Vout_85),
    .io_Vout_86(line_cell_7_io_Vout_86),
    .io_Vout_87(line_cell_7_io_Vout_87),
    .io_Vout_88(line_cell_7_io_Vout_88),
    .io_Vout_89(line_cell_7_io_Vout_89),
    .io_Vout_90(line_cell_7_io_Vout_90),
    .io_Vout_91(line_cell_7_io_Vout_91),
    .io_Vout_92(line_cell_7_io_Vout_92),
    .io_Vout_93(line_cell_7_io_Vout_93),
    .io_Vout_94(line_cell_7_io_Vout_94),
    .io_Vout_95(line_cell_7_io_Vout_95),
    .io_Vout_96(line_cell_7_io_Vout_96),
    .io_Vout_97(line_cell_7_io_Vout_97),
    .io_Vout_98(line_cell_7_io_Vout_98),
    .io_Vout_99(line_cell_7_io_Vout_99),
    .io_Vout_100(line_cell_7_io_Vout_100),
    .io_Vout_101(line_cell_7_io_Vout_101),
    .io_Vout_102(line_cell_7_io_Vout_102),
    .io_Vout_103(line_cell_7_io_Vout_103),
    .io_Vout_104(line_cell_7_io_Vout_104),
    .io_Vout_105(line_cell_7_io_Vout_105),
    .io_Vout_106(line_cell_7_io_Vout_106),
    .io_Vout_107(line_cell_7_io_Vout_107),
    .io_Vout_108(line_cell_7_io_Vout_108),
    .io_Vout_109(line_cell_7_io_Vout_109),
    .io_Vout_110(line_cell_7_io_Vout_110),
    .io_Vout_111(line_cell_7_io_Vout_111),
    .io_Vout_112(line_cell_7_io_Vout_112),
    .io_Vout_113(line_cell_7_io_Vout_113),
    .io_Vout_114(line_cell_7_io_Vout_114),
    .io_Vout_115(line_cell_7_io_Vout_115),
    .io_Vout_116(line_cell_7_io_Vout_116),
    .io_Vout_117(line_cell_7_io_Vout_117),
    .io_Vout_118(line_cell_7_io_Vout_118),
    .io_Vout_119(line_cell_7_io_Vout_119),
    .io_Vout_120(line_cell_7_io_Vout_120),
    .io_Vout_121(line_cell_7_io_Vout_121),
    .io_Vout_122(line_cell_7_io_Vout_122),
    .io_Vout_123(line_cell_7_io_Vout_123),
    .io_Vout_124(line_cell_7_io_Vout_124),
    .io_Vout_125(line_cell_7_io_Vout_125),
    .io_Vout_126(line_cell_7_io_Vout_126),
    .io_Vout_127(line_cell_7_io_Vout_127)
  );
  AdderTree U_AdderTree ( // @[Array_8x128.scala 28:27]
    .clock(U_AdderTree_clock),
    .io_d_in_0(U_AdderTree_io_d_in_0),
    .io_d_in_1(U_AdderTree_io_d_in_1),
    .io_d_in_2(U_AdderTree_io_d_in_2),
    .io_d_in_3(U_AdderTree_io_d_in_3),
    .io_d_in_4(U_AdderTree_io_d_in_4),
    .io_d_in_5(U_AdderTree_io_d_in_5),
    .io_d_in_6(U_AdderTree_io_d_in_6),
    .io_d_in_7(U_AdderTree_io_d_in_7),
    .io_d_in_8(U_AdderTree_io_d_in_8),
    .io_d_in_9(U_AdderTree_io_d_in_9),
    .io_d_in_10(U_AdderTree_io_d_in_10),
    .io_d_in_11(U_AdderTree_io_d_in_11),
    .io_d_in_12(U_AdderTree_io_d_in_12),
    .io_d_in_13(U_AdderTree_io_d_in_13),
    .io_d_in_14(U_AdderTree_io_d_in_14),
    .io_d_in_15(U_AdderTree_io_d_in_15),
    .io_d_in_16(U_AdderTree_io_d_in_16),
    .io_d_in_17(U_AdderTree_io_d_in_17),
    .io_d_in_18(U_AdderTree_io_d_in_18),
    .io_d_in_19(U_AdderTree_io_d_in_19),
    .io_d_in_20(U_AdderTree_io_d_in_20),
    .io_d_in_21(U_AdderTree_io_d_in_21),
    .io_d_in_22(U_AdderTree_io_d_in_22),
    .io_d_in_23(U_AdderTree_io_d_in_23),
    .io_d_in_24(U_AdderTree_io_d_in_24),
    .io_d_in_25(U_AdderTree_io_d_in_25),
    .io_d_in_26(U_AdderTree_io_d_in_26),
    .io_d_in_27(U_AdderTree_io_d_in_27),
    .io_d_in_28(U_AdderTree_io_d_in_28),
    .io_d_in_29(U_AdderTree_io_d_in_29),
    .io_d_in_30(U_AdderTree_io_d_in_30),
    .io_d_in_31(U_AdderTree_io_d_in_31),
    .io_d_in_32(U_AdderTree_io_d_in_32),
    .io_d_in_33(U_AdderTree_io_d_in_33),
    .io_d_in_34(U_AdderTree_io_d_in_34),
    .io_d_in_35(U_AdderTree_io_d_in_35),
    .io_d_in_36(U_AdderTree_io_d_in_36),
    .io_d_in_37(U_AdderTree_io_d_in_37),
    .io_d_in_38(U_AdderTree_io_d_in_38),
    .io_d_in_39(U_AdderTree_io_d_in_39),
    .io_d_in_40(U_AdderTree_io_d_in_40),
    .io_d_in_41(U_AdderTree_io_d_in_41),
    .io_d_in_42(U_AdderTree_io_d_in_42),
    .io_d_in_43(U_AdderTree_io_d_in_43),
    .io_d_in_44(U_AdderTree_io_d_in_44),
    .io_d_in_45(U_AdderTree_io_d_in_45),
    .io_d_in_46(U_AdderTree_io_d_in_46),
    .io_d_in_47(U_AdderTree_io_d_in_47),
    .io_d_in_48(U_AdderTree_io_d_in_48),
    .io_d_in_49(U_AdderTree_io_d_in_49),
    .io_d_in_50(U_AdderTree_io_d_in_50),
    .io_d_in_51(U_AdderTree_io_d_in_51),
    .io_d_in_52(U_AdderTree_io_d_in_52),
    .io_d_in_53(U_AdderTree_io_d_in_53),
    .io_d_in_54(U_AdderTree_io_d_in_54),
    .io_d_in_55(U_AdderTree_io_d_in_55),
    .io_d_in_56(U_AdderTree_io_d_in_56),
    .io_d_in_57(U_AdderTree_io_d_in_57),
    .io_d_in_58(U_AdderTree_io_d_in_58),
    .io_d_in_59(U_AdderTree_io_d_in_59),
    .io_d_in_60(U_AdderTree_io_d_in_60),
    .io_d_in_61(U_AdderTree_io_d_in_61),
    .io_d_in_62(U_AdderTree_io_d_in_62),
    .io_d_in_63(U_AdderTree_io_d_in_63),
    .io_d_in_64(U_AdderTree_io_d_in_64),
    .io_d_in_65(U_AdderTree_io_d_in_65),
    .io_d_in_66(U_AdderTree_io_d_in_66),
    .io_d_in_67(U_AdderTree_io_d_in_67),
    .io_d_in_68(U_AdderTree_io_d_in_68),
    .io_d_in_69(U_AdderTree_io_d_in_69),
    .io_d_in_70(U_AdderTree_io_d_in_70),
    .io_d_in_71(U_AdderTree_io_d_in_71),
    .io_d_in_72(U_AdderTree_io_d_in_72),
    .io_d_in_73(U_AdderTree_io_d_in_73),
    .io_d_in_74(U_AdderTree_io_d_in_74),
    .io_d_in_75(U_AdderTree_io_d_in_75),
    .io_d_in_76(U_AdderTree_io_d_in_76),
    .io_d_in_77(U_AdderTree_io_d_in_77),
    .io_d_in_78(U_AdderTree_io_d_in_78),
    .io_d_in_79(U_AdderTree_io_d_in_79),
    .io_d_in_80(U_AdderTree_io_d_in_80),
    .io_d_in_81(U_AdderTree_io_d_in_81),
    .io_d_in_82(U_AdderTree_io_d_in_82),
    .io_d_in_83(U_AdderTree_io_d_in_83),
    .io_d_in_84(U_AdderTree_io_d_in_84),
    .io_d_in_85(U_AdderTree_io_d_in_85),
    .io_d_in_86(U_AdderTree_io_d_in_86),
    .io_d_in_87(U_AdderTree_io_d_in_87),
    .io_d_in_88(U_AdderTree_io_d_in_88),
    .io_d_in_89(U_AdderTree_io_d_in_89),
    .io_d_in_90(U_AdderTree_io_d_in_90),
    .io_d_in_91(U_AdderTree_io_d_in_91),
    .io_d_in_92(U_AdderTree_io_d_in_92),
    .io_d_in_93(U_AdderTree_io_d_in_93),
    .io_d_in_94(U_AdderTree_io_d_in_94),
    .io_d_in_95(U_AdderTree_io_d_in_95),
    .io_d_in_96(U_AdderTree_io_d_in_96),
    .io_d_in_97(U_AdderTree_io_d_in_97),
    .io_d_in_98(U_AdderTree_io_d_in_98),
    .io_d_in_99(U_AdderTree_io_d_in_99),
    .io_d_in_100(U_AdderTree_io_d_in_100),
    .io_d_in_101(U_AdderTree_io_d_in_101),
    .io_d_in_102(U_AdderTree_io_d_in_102),
    .io_d_in_103(U_AdderTree_io_d_in_103),
    .io_d_in_104(U_AdderTree_io_d_in_104),
    .io_d_in_105(U_AdderTree_io_d_in_105),
    .io_d_in_106(U_AdderTree_io_d_in_106),
    .io_d_in_107(U_AdderTree_io_d_in_107),
    .io_d_in_108(U_AdderTree_io_d_in_108),
    .io_d_in_109(U_AdderTree_io_d_in_109),
    .io_d_in_110(U_AdderTree_io_d_in_110),
    .io_d_in_111(U_AdderTree_io_d_in_111),
    .io_d_in_112(U_AdderTree_io_d_in_112),
    .io_d_in_113(U_AdderTree_io_d_in_113),
    .io_d_in_114(U_AdderTree_io_d_in_114),
    .io_d_in_115(U_AdderTree_io_d_in_115),
    .io_d_in_116(U_AdderTree_io_d_in_116),
    .io_d_in_117(U_AdderTree_io_d_in_117),
    .io_d_in_118(U_AdderTree_io_d_in_118),
    .io_d_in_119(U_AdderTree_io_d_in_119),
    .io_d_in_120(U_AdderTree_io_d_in_120),
    .io_d_in_121(U_AdderTree_io_d_in_121),
    .io_d_in_122(U_AdderTree_io_d_in_122),
    .io_d_in_123(U_AdderTree_io_d_in_123),
    .io_d_in_124(U_AdderTree_io_d_in_124),
    .io_d_in_125(U_AdderTree_io_d_in_125),
    .io_d_in_126(U_AdderTree_io_d_in_126),
    .io_d_in_127(U_AdderTree_io_d_in_127),
    .io_sum(U_AdderTree_io_sum)
  );
  assign io_MAC = U_AdderTree_io_sum; // @[Array_8x128.scala 35:10]
  assign line_cell_clock = clock;
  assign line_cell_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_io_BL = io_BL[0]; // @[Array_8x128.scala 21:31]
  assign line_cell_1_clock = clock;
  assign line_cell_1_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_1_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_1_io_BL = io_BL[1]; // @[Array_8x128.scala 21:31]
  assign line_cell_2_clock = clock;
  assign line_cell_2_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_2_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_2_io_BL = io_BL[2]; // @[Array_8x128.scala 21:31]
  assign line_cell_3_clock = clock;
  assign line_cell_3_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_3_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_3_io_BL = io_BL[3]; // @[Array_8x128.scala 21:31]
  assign line_cell_4_clock = clock;
  assign line_cell_4_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_4_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_4_io_BL = io_BL[4]; // @[Array_8x128.scala 21:31]
  assign line_cell_5_clock = clock;
  assign line_cell_5_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_5_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_5_io_BL = io_BL[5]; // @[Array_8x128.scala 21:31]
  assign line_cell_6_clock = clock;
  assign line_cell_6_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_6_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_6_io_BL = io_BL[6]; // @[Array_8x128.scala 21:31]
  assign line_cell_7_clock = clock;
  assign line_cell_7_io_WL = io_WL; // @[Array_8x128.scala 17:28 19:23]
  assign line_cell_7_io_IN = io_IN; // @[Array_8x128.scala 17:28 20:23]
  assign line_cell_7_io_BL = io_BL[7]; // @[Array_8x128.scala 21:31]
  assign U_AdderTree_clock = clock;
  assign U_AdderTree_io_d_in_0 = {U_AdderTree_io_d_in_0_hi,U_AdderTree_io_d_in_0_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_1 = {U_AdderTree_io_d_in_1_hi,U_AdderTree_io_d_in_1_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_2 = {U_AdderTree_io_d_in_2_hi,U_AdderTree_io_d_in_2_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_3 = {U_AdderTree_io_d_in_3_hi,U_AdderTree_io_d_in_3_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_4 = {U_AdderTree_io_d_in_4_hi,U_AdderTree_io_d_in_4_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_5 = {U_AdderTree_io_d_in_5_hi,U_AdderTree_io_d_in_5_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_6 = {U_AdderTree_io_d_in_6_hi,U_AdderTree_io_d_in_6_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_7 = {U_AdderTree_io_d_in_7_hi,U_AdderTree_io_d_in_7_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_8 = {U_AdderTree_io_d_in_8_hi,U_AdderTree_io_d_in_8_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_9 = {U_AdderTree_io_d_in_9_hi,U_AdderTree_io_d_in_9_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_10 = {U_AdderTree_io_d_in_10_hi,U_AdderTree_io_d_in_10_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_11 = {U_AdderTree_io_d_in_11_hi,U_AdderTree_io_d_in_11_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_12 = {U_AdderTree_io_d_in_12_hi,U_AdderTree_io_d_in_12_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_13 = {U_AdderTree_io_d_in_13_hi,U_AdderTree_io_d_in_13_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_14 = {U_AdderTree_io_d_in_14_hi,U_AdderTree_io_d_in_14_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_15 = {U_AdderTree_io_d_in_15_hi,U_AdderTree_io_d_in_15_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_16 = {U_AdderTree_io_d_in_16_hi,U_AdderTree_io_d_in_16_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_17 = {U_AdderTree_io_d_in_17_hi,U_AdderTree_io_d_in_17_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_18 = {U_AdderTree_io_d_in_18_hi,U_AdderTree_io_d_in_18_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_19 = {U_AdderTree_io_d_in_19_hi,U_AdderTree_io_d_in_19_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_20 = {U_AdderTree_io_d_in_20_hi,U_AdderTree_io_d_in_20_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_21 = {U_AdderTree_io_d_in_21_hi,U_AdderTree_io_d_in_21_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_22 = {U_AdderTree_io_d_in_22_hi,U_AdderTree_io_d_in_22_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_23 = {U_AdderTree_io_d_in_23_hi,U_AdderTree_io_d_in_23_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_24 = {U_AdderTree_io_d_in_24_hi,U_AdderTree_io_d_in_24_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_25 = {U_AdderTree_io_d_in_25_hi,U_AdderTree_io_d_in_25_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_26 = {U_AdderTree_io_d_in_26_hi,U_AdderTree_io_d_in_26_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_27 = {U_AdderTree_io_d_in_27_hi,U_AdderTree_io_d_in_27_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_28 = {U_AdderTree_io_d_in_28_hi,U_AdderTree_io_d_in_28_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_29 = {U_AdderTree_io_d_in_29_hi,U_AdderTree_io_d_in_29_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_30 = {U_AdderTree_io_d_in_30_hi,U_AdderTree_io_d_in_30_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_31 = {U_AdderTree_io_d_in_31_hi,U_AdderTree_io_d_in_31_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_32 = {U_AdderTree_io_d_in_32_hi,U_AdderTree_io_d_in_32_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_33 = {U_AdderTree_io_d_in_33_hi,U_AdderTree_io_d_in_33_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_34 = {U_AdderTree_io_d_in_34_hi,U_AdderTree_io_d_in_34_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_35 = {U_AdderTree_io_d_in_35_hi,U_AdderTree_io_d_in_35_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_36 = {U_AdderTree_io_d_in_36_hi,U_AdderTree_io_d_in_36_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_37 = {U_AdderTree_io_d_in_37_hi,U_AdderTree_io_d_in_37_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_38 = {U_AdderTree_io_d_in_38_hi,U_AdderTree_io_d_in_38_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_39 = {U_AdderTree_io_d_in_39_hi,U_AdderTree_io_d_in_39_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_40 = {U_AdderTree_io_d_in_40_hi,U_AdderTree_io_d_in_40_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_41 = {U_AdderTree_io_d_in_41_hi,U_AdderTree_io_d_in_41_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_42 = {U_AdderTree_io_d_in_42_hi,U_AdderTree_io_d_in_42_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_43 = {U_AdderTree_io_d_in_43_hi,U_AdderTree_io_d_in_43_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_44 = {U_AdderTree_io_d_in_44_hi,U_AdderTree_io_d_in_44_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_45 = {U_AdderTree_io_d_in_45_hi,U_AdderTree_io_d_in_45_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_46 = {U_AdderTree_io_d_in_46_hi,U_AdderTree_io_d_in_46_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_47 = {U_AdderTree_io_d_in_47_hi,U_AdderTree_io_d_in_47_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_48 = {U_AdderTree_io_d_in_48_hi,U_AdderTree_io_d_in_48_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_49 = {U_AdderTree_io_d_in_49_hi,U_AdderTree_io_d_in_49_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_50 = {U_AdderTree_io_d_in_50_hi,U_AdderTree_io_d_in_50_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_51 = {U_AdderTree_io_d_in_51_hi,U_AdderTree_io_d_in_51_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_52 = {U_AdderTree_io_d_in_52_hi,U_AdderTree_io_d_in_52_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_53 = {U_AdderTree_io_d_in_53_hi,U_AdderTree_io_d_in_53_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_54 = {U_AdderTree_io_d_in_54_hi,U_AdderTree_io_d_in_54_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_55 = {U_AdderTree_io_d_in_55_hi,U_AdderTree_io_d_in_55_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_56 = {U_AdderTree_io_d_in_56_hi,U_AdderTree_io_d_in_56_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_57 = {U_AdderTree_io_d_in_57_hi,U_AdderTree_io_d_in_57_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_58 = {U_AdderTree_io_d_in_58_hi,U_AdderTree_io_d_in_58_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_59 = {U_AdderTree_io_d_in_59_hi,U_AdderTree_io_d_in_59_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_60 = {U_AdderTree_io_d_in_60_hi,U_AdderTree_io_d_in_60_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_61 = {U_AdderTree_io_d_in_61_hi,U_AdderTree_io_d_in_61_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_62 = {U_AdderTree_io_d_in_62_hi,U_AdderTree_io_d_in_62_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_63 = {U_AdderTree_io_d_in_63_hi,U_AdderTree_io_d_in_63_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_64 = {U_AdderTree_io_d_in_64_hi,U_AdderTree_io_d_in_64_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_65 = {U_AdderTree_io_d_in_65_hi,U_AdderTree_io_d_in_65_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_66 = {U_AdderTree_io_d_in_66_hi,U_AdderTree_io_d_in_66_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_67 = {U_AdderTree_io_d_in_67_hi,U_AdderTree_io_d_in_67_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_68 = {U_AdderTree_io_d_in_68_hi,U_AdderTree_io_d_in_68_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_69 = {U_AdderTree_io_d_in_69_hi,U_AdderTree_io_d_in_69_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_70 = {U_AdderTree_io_d_in_70_hi,U_AdderTree_io_d_in_70_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_71 = {U_AdderTree_io_d_in_71_hi,U_AdderTree_io_d_in_71_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_72 = {U_AdderTree_io_d_in_72_hi,U_AdderTree_io_d_in_72_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_73 = {U_AdderTree_io_d_in_73_hi,U_AdderTree_io_d_in_73_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_74 = {U_AdderTree_io_d_in_74_hi,U_AdderTree_io_d_in_74_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_75 = {U_AdderTree_io_d_in_75_hi,U_AdderTree_io_d_in_75_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_76 = {U_AdderTree_io_d_in_76_hi,U_AdderTree_io_d_in_76_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_77 = {U_AdderTree_io_d_in_77_hi,U_AdderTree_io_d_in_77_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_78 = {U_AdderTree_io_d_in_78_hi,U_AdderTree_io_d_in_78_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_79 = {U_AdderTree_io_d_in_79_hi,U_AdderTree_io_d_in_79_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_80 = {U_AdderTree_io_d_in_80_hi,U_AdderTree_io_d_in_80_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_81 = {U_AdderTree_io_d_in_81_hi,U_AdderTree_io_d_in_81_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_82 = {U_AdderTree_io_d_in_82_hi,U_AdderTree_io_d_in_82_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_83 = {U_AdderTree_io_d_in_83_hi,U_AdderTree_io_d_in_83_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_84 = {U_AdderTree_io_d_in_84_hi,U_AdderTree_io_d_in_84_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_85 = {U_AdderTree_io_d_in_85_hi,U_AdderTree_io_d_in_85_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_86 = {U_AdderTree_io_d_in_86_hi,U_AdderTree_io_d_in_86_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_87 = {U_AdderTree_io_d_in_87_hi,U_AdderTree_io_d_in_87_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_88 = {U_AdderTree_io_d_in_88_hi,U_AdderTree_io_d_in_88_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_89 = {U_AdderTree_io_d_in_89_hi,U_AdderTree_io_d_in_89_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_90 = {U_AdderTree_io_d_in_90_hi,U_AdderTree_io_d_in_90_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_91 = {U_AdderTree_io_d_in_91_hi,U_AdderTree_io_d_in_91_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_92 = {U_AdderTree_io_d_in_92_hi,U_AdderTree_io_d_in_92_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_93 = {U_AdderTree_io_d_in_93_hi,U_AdderTree_io_d_in_93_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_94 = {U_AdderTree_io_d_in_94_hi,U_AdderTree_io_d_in_94_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_95 = {U_AdderTree_io_d_in_95_hi,U_AdderTree_io_d_in_95_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_96 = {U_AdderTree_io_d_in_96_hi,U_AdderTree_io_d_in_96_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_97 = {U_AdderTree_io_d_in_97_hi,U_AdderTree_io_d_in_97_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_98 = {U_AdderTree_io_d_in_98_hi,U_AdderTree_io_d_in_98_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_99 = {U_AdderTree_io_d_in_99_hi,U_AdderTree_io_d_in_99_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_100 = {U_AdderTree_io_d_in_100_hi,U_AdderTree_io_d_in_100_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_101 = {U_AdderTree_io_d_in_101_hi,U_AdderTree_io_d_in_101_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_102 = {U_AdderTree_io_d_in_102_hi,U_AdderTree_io_d_in_102_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_103 = {U_AdderTree_io_d_in_103_hi,U_AdderTree_io_d_in_103_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_104 = {U_AdderTree_io_d_in_104_hi,U_AdderTree_io_d_in_104_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_105 = {U_AdderTree_io_d_in_105_hi,U_AdderTree_io_d_in_105_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_106 = {U_AdderTree_io_d_in_106_hi,U_AdderTree_io_d_in_106_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_107 = {U_AdderTree_io_d_in_107_hi,U_AdderTree_io_d_in_107_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_108 = {U_AdderTree_io_d_in_108_hi,U_AdderTree_io_d_in_108_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_109 = {U_AdderTree_io_d_in_109_hi,U_AdderTree_io_d_in_109_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_110 = {U_AdderTree_io_d_in_110_hi,U_AdderTree_io_d_in_110_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_111 = {U_AdderTree_io_d_in_111_hi,U_AdderTree_io_d_in_111_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_112 = {U_AdderTree_io_d_in_112_hi,U_AdderTree_io_d_in_112_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_113 = {U_AdderTree_io_d_in_113_hi,U_AdderTree_io_d_in_113_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_114 = {U_AdderTree_io_d_in_114_hi,U_AdderTree_io_d_in_114_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_115 = {U_AdderTree_io_d_in_115_hi,U_AdderTree_io_d_in_115_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_116 = {U_AdderTree_io_d_in_116_hi,U_AdderTree_io_d_in_116_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_117 = {U_AdderTree_io_d_in_117_hi,U_AdderTree_io_d_in_117_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_118 = {U_AdderTree_io_d_in_118_hi,U_AdderTree_io_d_in_118_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_119 = {U_AdderTree_io_d_in_119_hi,U_AdderTree_io_d_in_119_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_120 = {U_AdderTree_io_d_in_120_hi,U_AdderTree_io_d_in_120_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_121 = {U_AdderTree_io_d_in_121_hi,U_AdderTree_io_d_in_121_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_122 = {U_AdderTree_io_d_in_122_hi,U_AdderTree_io_d_in_122_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_123 = {U_AdderTree_io_d_in_123_hi,U_AdderTree_io_d_in_123_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_124 = {U_AdderTree_io_d_in_124_hi,U_AdderTree_io_d_in_124_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_125 = {U_AdderTree_io_d_in_125_hi,U_AdderTree_io_d_in_125_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_126 = {U_AdderTree_io_d_in_126_hi,U_AdderTree_io_d_in_126_lo}; // @[Cat.scala 33:92]
  assign U_AdderTree_io_d_in_127 = {U_AdderTree_io_d_in_127_hi,U_AdderTree_io_d_in_127_lo}; // @[Cat.scala 33:92]
endmodule
module Array(
  input          clock,
  input  [127:0] io_WL,
  input  [127:0] io_IN,
  input  [127:0] io_BL,
  output [14:0]  io_MAC_0,
  output [14:0]  io_MAC_1,
  output [14:0]  io_MAC_2,
  output [14:0]  io_MAC_3,
  output [14:0]  io_MAC_4,
  output [14:0]  io_MAC_5,
  output [14:0]  io_MAC_6,
  output [14:0]  io_MAC_7,
  output [14:0]  io_MAC_8,
  output [14:0]  io_MAC_9,
  output [14:0]  io_MAC_10,
  output [14:0]  io_MAC_11,
  output [14:0]  io_MAC_12,
  output [14:0]  io_MAC_13,
  output [14:0]  io_MAC_14,
  output [14:0]  io_MAC_15
);
  wire  Array_8x128_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_1_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_1_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_1_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_1_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_1_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_2_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_2_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_2_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_2_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_2_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_3_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_3_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_3_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_3_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_3_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_4_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_4_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_4_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_4_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_4_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_5_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_5_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_5_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_5_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_5_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_6_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_6_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_6_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_6_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_6_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_7_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_7_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_7_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_7_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_7_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_8_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_8_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_8_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_8_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_8_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_9_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_9_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_9_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_9_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_9_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_10_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_10_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_10_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_10_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_10_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_11_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_11_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_11_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_11_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_11_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_12_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_12_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_12_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_12_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_12_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_13_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_13_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_13_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_13_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_13_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_14_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_14_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_14_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_14_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_14_io_MAC; // @[Array.scala 23:46]
  wire  Array_8x128_15_clock; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_15_io_WL; // @[Array.scala 23:46]
  wire [127:0] Array_8x128_15_io_IN; // @[Array.scala 23:46]
  wire [7:0] Array_8x128_15_io_BL; // @[Array.scala 23:46]
  wire [14:0] Array_8x128_15_io_MAC; // @[Array.scala 23:46]
  Array_8x128 Array_8x128 ( // @[Array.scala 23:46]
    .clock(Array_8x128_clock),
    .io_WL(Array_8x128_io_WL),
    .io_IN(Array_8x128_io_IN),
    .io_BL(Array_8x128_io_BL),
    .io_MAC(Array_8x128_io_MAC)
  );
  Array_8x128 Array_8x128_1 ( // @[Array.scala 23:46]
    .clock(Array_8x128_1_clock),
    .io_WL(Array_8x128_1_io_WL),
    .io_IN(Array_8x128_1_io_IN),
    .io_BL(Array_8x128_1_io_BL),
    .io_MAC(Array_8x128_1_io_MAC)
  );
  Array_8x128 Array_8x128_2 ( // @[Array.scala 23:46]
    .clock(Array_8x128_2_clock),
    .io_WL(Array_8x128_2_io_WL),
    .io_IN(Array_8x128_2_io_IN),
    .io_BL(Array_8x128_2_io_BL),
    .io_MAC(Array_8x128_2_io_MAC)
  );
  Array_8x128 Array_8x128_3 ( // @[Array.scala 23:46]
    .clock(Array_8x128_3_clock),
    .io_WL(Array_8x128_3_io_WL),
    .io_IN(Array_8x128_3_io_IN),
    .io_BL(Array_8x128_3_io_BL),
    .io_MAC(Array_8x128_3_io_MAC)
  );
  Array_8x128 Array_8x128_4 ( // @[Array.scala 23:46]
    .clock(Array_8x128_4_clock),
    .io_WL(Array_8x128_4_io_WL),
    .io_IN(Array_8x128_4_io_IN),
    .io_BL(Array_8x128_4_io_BL),
    .io_MAC(Array_8x128_4_io_MAC)
  );
  Array_8x128 Array_8x128_5 ( // @[Array.scala 23:46]
    .clock(Array_8x128_5_clock),
    .io_WL(Array_8x128_5_io_WL),
    .io_IN(Array_8x128_5_io_IN),
    .io_BL(Array_8x128_5_io_BL),
    .io_MAC(Array_8x128_5_io_MAC)
  );
  Array_8x128 Array_8x128_6 ( // @[Array.scala 23:46]
    .clock(Array_8x128_6_clock),
    .io_WL(Array_8x128_6_io_WL),
    .io_IN(Array_8x128_6_io_IN),
    .io_BL(Array_8x128_6_io_BL),
    .io_MAC(Array_8x128_6_io_MAC)
  );
  Array_8x128 Array_8x128_7 ( // @[Array.scala 23:46]
    .clock(Array_8x128_7_clock),
    .io_WL(Array_8x128_7_io_WL),
    .io_IN(Array_8x128_7_io_IN),
    .io_BL(Array_8x128_7_io_BL),
    .io_MAC(Array_8x128_7_io_MAC)
  );
  Array_8x128 Array_8x128_8 ( // @[Array.scala 23:46]
    .clock(Array_8x128_8_clock),
    .io_WL(Array_8x128_8_io_WL),
    .io_IN(Array_8x128_8_io_IN),
    .io_BL(Array_8x128_8_io_BL),
    .io_MAC(Array_8x128_8_io_MAC)
  );
  Array_8x128 Array_8x128_9 ( // @[Array.scala 23:46]
    .clock(Array_8x128_9_clock),
    .io_WL(Array_8x128_9_io_WL),
    .io_IN(Array_8x128_9_io_IN),
    .io_BL(Array_8x128_9_io_BL),
    .io_MAC(Array_8x128_9_io_MAC)
  );
  Array_8x128 Array_8x128_10 ( // @[Array.scala 23:46]
    .clock(Array_8x128_10_clock),
    .io_WL(Array_8x128_10_io_WL),
    .io_IN(Array_8x128_10_io_IN),
    .io_BL(Array_8x128_10_io_BL),
    .io_MAC(Array_8x128_10_io_MAC)
  );
  Array_8x128 Array_8x128_11 ( // @[Array.scala 23:46]
    .clock(Array_8x128_11_clock),
    .io_WL(Array_8x128_11_io_WL),
    .io_IN(Array_8x128_11_io_IN),
    .io_BL(Array_8x128_11_io_BL),
    .io_MAC(Array_8x128_11_io_MAC)
  );
  Array_8x128 Array_8x128_12 ( // @[Array.scala 23:46]
    .clock(Array_8x128_12_clock),
    .io_WL(Array_8x128_12_io_WL),
    .io_IN(Array_8x128_12_io_IN),
    .io_BL(Array_8x128_12_io_BL),
    .io_MAC(Array_8x128_12_io_MAC)
  );
  Array_8x128 Array_8x128_13 ( // @[Array.scala 23:46]
    .clock(Array_8x128_13_clock),
    .io_WL(Array_8x128_13_io_WL),
    .io_IN(Array_8x128_13_io_IN),
    .io_BL(Array_8x128_13_io_BL),
    .io_MAC(Array_8x128_13_io_MAC)
  );
  Array_8x128 Array_8x128_14 ( // @[Array.scala 23:46]
    .clock(Array_8x128_14_clock),
    .io_WL(Array_8x128_14_io_WL),
    .io_IN(Array_8x128_14_io_IN),
    .io_BL(Array_8x128_14_io_BL),
    .io_MAC(Array_8x128_14_io_MAC)
  );
  Array_8x128 Array_8x128_15 ( // @[Array.scala 23:46]
    .clock(Array_8x128_15_clock),
    .io_WL(Array_8x128_15_io_WL),
    .io_IN(Array_8x128_15_io_IN),
    .io_BL(Array_8x128_15_io_BL),
    .io_MAC(Array_8x128_15_io_MAC)
  );
  assign io_MAC_0 = Array_8x128_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_1 = Array_8x128_1_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_2 = Array_8x128_2_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_3 = Array_8x128_3_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_4 = Array_8x128_4_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_5 = Array_8x128_5_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_6 = Array_8x128_6_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_7 = Array_8x128_7_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_8 = Array_8x128_8_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_9 = Array_8x128_9_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_10 = Array_8x128_10_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_11 = Array_8x128_11_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_12 = Array_8x128_12_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_13 = Array_8x128_13_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_14 = Array_8x128_14_io_MAC; // @[Array.scala 23:{18,18}]
  assign io_MAC_15 = Array_8x128_15_io_MAC; // @[Array.scala 23:{18,18}]
  assign Array_8x128_clock = clock;
  assign Array_8x128_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_io_BL = io_BL[127:120]; // @[Array.scala 29:23]
  assign Array_8x128_1_clock = clock;
  assign Array_8x128_1_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_1_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_1_io_BL = io_BL[119:112]; // @[Array.scala 29:23]
  assign Array_8x128_2_clock = clock;
  assign Array_8x128_2_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_2_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_2_io_BL = io_BL[111:104]; // @[Array.scala 29:23]
  assign Array_8x128_3_clock = clock;
  assign Array_8x128_3_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_3_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_3_io_BL = io_BL[103:96]; // @[Array.scala 29:23]
  assign Array_8x128_4_clock = clock;
  assign Array_8x128_4_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_4_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_4_io_BL = io_BL[95:88]; // @[Array.scala 29:23]
  assign Array_8x128_5_clock = clock;
  assign Array_8x128_5_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_5_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_5_io_BL = io_BL[87:80]; // @[Array.scala 29:23]
  assign Array_8x128_6_clock = clock;
  assign Array_8x128_6_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_6_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_6_io_BL = io_BL[79:72]; // @[Array.scala 29:23]
  assign Array_8x128_7_clock = clock;
  assign Array_8x128_7_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_7_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_7_io_BL = io_BL[71:64]; // @[Array.scala 29:23]
  assign Array_8x128_8_clock = clock;
  assign Array_8x128_8_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_8_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_8_io_BL = io_BL[63:56]; // @[Array.scala 29:23]
  assign Array_8x128_9_clock = clock;
  assign Array_8x128_9_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_9_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_9_io_BL = io_BL[55:48]; // @[Array.scala 29:23]
  assign Array_8x128_10_clock = clock;
  assign Array_8x128_10_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_10_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_10_io_BL = io_BL[47:40]; // @[Array.scala 29:23]
  assign Array_8x128_11_clock = clock;
  assign Array_8x128_11_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_11_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_11_io_BL = io_BL[39:32]; // @[Array.scala 29:23]
  assign Array_8x128_12_clock = clock;
  assign Array_8x128_12_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_12_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_12_io_BL = io_BL[31:24]; // @[Array.scala 29:23]
  assign Array_8x128_13_clock = clock;
  assign Array_8x128_13_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_13_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_13_io_BL = io_BL[23:16]; // @[Array.scala 29:23]
  assign Array_8x128_14_clock = clock;
  assign Array_8x128_14_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_14_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_14_io_BL = io_BL[15:8]; // @[Array.scala 29:23]
  assign Array_8x128_15_clock = clock;
  assign Array_8x128_15_io_WL = io_WL; // @[Array.scala 23:18 27:15]
  assign Array_8x128_15_io_IN = io_IN; // @[Array.scala 23:18 28:15]
  assign Array_8x128_15_io_BL = io_BL[7:0]; // @[Array.scala 29:23]
endmodule
module PE(
  input          clock,
  input  [127:0] io_WL,
  input  [127:0] io_IN_0,
  input  [127:0] io_IN_1,
  input  [127:0] io_BL_0,
  input  [127:0] io_BL_1,
  output [14:0]  io_MAC_0,
  output [14:0]  io_MAC_1,
  output [14:0]  io_MAC_2,
  output [14:0]  io_MAC_3,
  output [14:0]  io_MAC_4,
  output [14:0]  io_MAC_5,
  output [14:0]  io_MAC_6,
  output [14:0]  io_MAC_7,
  output [14:0]  io_MAC_8,
  output [14:0]  io_MAC_9,
  output [14:0]  io_MAC_10,
  output [14:0]  io_MAC_11,
  output [14:0]  io_MAC_12,
  output [14:0]  io_MAC_13,
  output [14:0]  io_MAC_14,
  output [14:0]  io_MAC_15,
  output [14:0]  io_MAC_16,
  output [14:0]  io_MAC_17,
  output [14:0]  io_MAC_18,
  output [14:0]  io_MAC_19,
  output [14:0]  io_MAC_20,
  output [14:0]  io_MAC_21,
  output [14:0]  io_MAC_22,
  output [14:0]  io_MAC_23,
  output [14:0]  io_MAC_24,
  output [14:0]  io_MAC_25,
  output [14:0]  io_MAC_26,
  output [14:0]  io_MAC_27,
  output [14:0]  io_MAC_28,
  output [14:0]  io_MAC_29,
  output [14:0]  io_MAC_30,
  output [14:0]  io_MAC_31
);
  wire  Array_clock; // @[PE_cim.scala 16:50]
  wire [127:0] Array_io_WL; // @[PE_cim.scala 16:50]
  wire [127:0] Array_io_IN; // @[PE_cim.scala 16:50]
  wire [127:0] Array_io_BL; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_0; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_1; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_2; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_3; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_4; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_5; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_6; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_7; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_8; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_9; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_10; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_11; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_12; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_13; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_14; // @[PE_cim.scala 16:50]
  wire [14:0] Array_io_MAC_15; // @[PE_cim.scala 16:50]
  wire  Array_1_clock; // @[PE_cim.scala 16:50]
  wire [127:0] Array_1_io_WL; // @[PE_cim.scala 16:50]
  wire [127:0] Array_1_io_IN; // @[PE_cim.scala 16:50]
  wire [127:0] Array_1_io_BL; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_0; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_1; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_2; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_3; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_4; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_5; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_6; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_7; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_8; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_9; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_10; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_11; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_12; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_13; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_14; // @[PE_cim.scala 16:50]
  wire [14:0] Array_1_io_MAC_15; // @[PE_cim.scala 16:50]
  Array Array ( // @[PE_cim.scala 16:50]
    .clock(Array_clock),
    .io_WL(Array_io_WL),
    .io_IN(Array_io_IN),
    .io_BL(Array_io_BL),
    .io_MAC_0(Array_io_MAC_0),
    .io_MAC_1(Array_io_MAC_1),
    .io_MAC_2(Array_io_MAC_2),
    .io_MAC_3(Array_io_MAC_3),
    .io_MAC_4(Array_io_MAC_4),
    .io_MAC_5(Array_io_MAC_5),
    .io_MAC_6(Array_io_MAC_6),
    .io_MAC_7(Array_io_MAC_7),
    .io_MAC_8(Array_io_MAC_8),
    .io_MAC_9(Array_io_MAC_9),
    .io_MAC_10(Array_io_MAC_10),
    .io_MAC_11(Array_io_MAC_11),
    .io_MAC_12(Array_io_MAC_12),
    .io_MAC_13(Array_io_MAC_13),
    .io_MAC_14(Array_io_MAC_14),
    .io_MAC_15(Array_io_MAC_15)
  );
  Array Array_1 ( // @[PE_cim.scala 16:50]
    .clock(Array_1_clock),
    .io_WL(Array_1_io_WL),
    .io_IN(Array_1_io_IN),
    .io_BL(Array_1_io_BL),
    .io_MAC_0(Array_1_io_MAC_0),
    .io_MAC_1(Array_1_io_MAC_1),
    .io_MAC_2(Array_1_io_MAC_2),
    .io_MAC_3(Array_1_io_MAC_3),
    .io_MAC_4(Array_1_io_MAC_4),
    .io_MAC_5(Array_1_io_MAC_5),
    .io_MAC_6(Array_1_io_MAC_6),
    .io_MAC_7(Array_1_io_MAC_7),
    .io_MAC_8(Array_1_io_MAC_8),
    .io_MAC_9(Array_1_io_MAC_9),
    .io_MAC_10(Array_1_io_MAC_10),
    .io_MAC_11(Array_1_io_MAC_11),
    .io_MAC_12(Array_1_io_MAC_12),
    .io_MAC_13(Array_1_io_MAC_13),
    .io_MAC_14(Array_1_io_MAC_14),
    .io_MAC_15(Array_1_io_MAC_15)
  );
  assign io_MAC_0 = Array_io_MAC_0; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_1 = Array_io_MAC_1; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_2 = Array_io_MAC_2; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_3 = Array_io_MAC_3; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_4 = Array_io_MAC_4; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_5 = Array_io_MAC_5; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_6 = Array_io_MAC_6; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_7 = Array_io_MAC_7; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_8 = Array_io_MAC_8; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_9 = Array_io_MAC_9; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_10 = Array_io_MAC_10; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_11 = Array_io_MAC_11; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_12 = Array_io_MAC_12; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_13 = Array_io_MAC_13; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_14 = Array_io_MAC_14; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_15 = Array_io_MAC_15; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_16 = Array_1_io_MAC_0; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_17 = Array_1_io_MAC_1; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_18 = Array_1_io_MAC_2; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_19 = Array_1_io_MAC_3; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_20 = Array_1_io_MAC_4; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_21 = Array_1_io_MAC_5; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_22 = Array_1_io_MAC_6; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_23 = Array_1_io_MAC_7; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_24 = Array_1_io_MAC_8; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_25 = Array_1_io_MAC_9; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_26 = Array_1_io_MAC_10; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_27 = Array_1_io_MAC_11; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_28 = Array_1_io_MAC_12; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_29 = Array_1_io_MAC_13; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_30 = Array_1_io_MAC_14; // @[PE_cim.scala 16:{18,18}]
  assign io_MAC_31 = Array_1_io_MAC_15; // @[PE_cim.scala 16:{18,18}]
  assign Array_clock = clock;
  assign Array_io_WL = io_WL; // @[PE_cim.scala 16:18 20:15]
  assign Array_io_IN = io_IN_0; // @[PE_cim.scala 16:18 21:15]
  assign Array_io_BL = io_BL_0; // @[PE_cim.scala 16:18 22:15]
  assign Array_1_clock = clock;
  assign Array_1_io_WL = io_WL; // @[PE_cim.scala 16:18 20:15]
  assign Array_1_io_IN = io_IN_1; // @[PE_cim.scala 16:18 21:15]
  assign Array_1_io_BL = io_BL_1; // @[PE_cim.scala 16:18 22:15]
endmodule
module Tile(
  input          clock,
  input  [127:0] io_WL,
  input  [127:0] io_IN_0,
  input  [127:0] io_IN_1,
  input  [127:0] io_IN_2,
  input  [127:0] io_IN_3,
  input  [127:0] io_BL_0,
  input  [127:0] io_BL_1,
  input  [127:0] io_BL_2,
  input  [127:0] io_BL_3,
  output [14:0]  io_MAC_0,
  output [14:0]  io_MAC_1,
  output [14:0]  io_MAC_2,
  output [14:0]  io_MAC_3,
  output [14:0]  io_MAC_4,
  output [14:0]  io_MAC_5,
  output [14:0]  io_MAC_6,
  output [14:0]  io_MAC_7,
  output [14:0]  io_MAC_8,
  output [14:0]  io_MAC_9,
  output [14:0]  io_MAC_10,
  output [14:0]  io_MAC_11,
  output [14:0]  io_MAC_12,
  output [14:0]  io_MAC_13,
  output [14:0]  io_MAC_14,
  output [14:0]  io_MAC_15,
  output [14:0]  io_MAC_16,
  output [14:0]  io_MAC_17,
  output [14:0]  io_MAC_18,
  output [14:0]  io_MAC_19,
  output [14:0]  io_MAC_20,
  output [14:0]  io_MAC_21,
  output [14:0]  io_MAC_22,
  output [14:0]  io_MAC_23,
  output [14:0]  io_MAC_24,
  output [14:0]  io_MAC_25,
  output [14:0]  io_MAC_26,
  output [14:0]  io_MAC_27,
  output [14:0]  io_MAC_28,
  output [14:0]  io_MAC_29,
  output [14:0]  io_MAC_30,
  output [14:0]  io_MAC_31,
  output [14:0]  io_MAC_32,
  output [14:0]  io_MAC_33,
  output [14:0]  io_MAC_34,
  output [14:0]  io_MAC_35,
  output [14:0]  io_MAC_36,
  output [14:0]  io_MAC_37,
  output [14:0]  io_MAC_38,
  output [14:0]  io_MAC_39,
  output [14:0]  io_MAC_40,
  output [14:0]  io_MAC_41,
  output [14:0]  io_MAC_42,
  output [14:0]  io_MAC_43,
  output [14:0]  io_MAC_44,
  output [14:0]  io_MAC_45,
  output [14:0]  io_MAC_46,
  output [14:0]  io_MAC_47,
  output [14:0]  io_MAC_48,
  output [14:0]  io_MAC_49,
  output [14:0]  io_MAC_50,
  output [14:0]  io_MAC_51,
  output [14:0]  io_MAC_52,
  output [14:0]  io_MAC_53,
  output [14:0]  io_MAC_54,
  output [14:0]  io_MAC_55,
  output [14:0]  io_MAC_56,
  output [14:0]  io_MAC_57,
  output [14:0]  io_MAC_58,
  output [14:0]  io_MAC_59,
  output [14:0]  io_MAC_60,
  output [14:0]  io_MAC_61,
  output [14:0]  io_MAC_62,
  output [14:0]  io_MAC_63
);
  wire  PE_clock; // @[Tile.scala 16:49]
  wire [127:0] PE_io_WL; // @[Tile.scala 16:49]
  wire [127:0] PE_io_IN_0; // @[Tile.scala 16:49]
  wire [127:0] PE_io_IN_1; // @[Tile.scala 16:49]
  wire [127:0] PE_io_BL_0; // @[Tile.scala 16:49]
  wire [127:0] PE_io_BL_1; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_0; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_1; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_2; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_3; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_4; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_5; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_6; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_7; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_8; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_9; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_10; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_11; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_12; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_13; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_14; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_15; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_16; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_17; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_18; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_19; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_20; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_21; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_22; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_23; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_24; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_25; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_26; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_27; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_28; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_29; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_30; // @[Tile.scala 16:49]
  wire [14:0] PE_io_MAC_31; // @[Tile.scala 16:49]
  wire  PE_1_clock; // @[Tile.scala 16:49]
  wire [127:0] PE_1_io_WL; // @[Tile.scala 16:49]
  wire [127:0] PE_1_io_IN_0; // @[Tile.scala 16:49]
  wire [127:0] PE_1_io_IN_1; // @[Tile.scala 16:49]
  wire [127:0] PE_1_io_BL_0; // @[Tile.scala 16:49]
  wire [127:0] PE_1_io_BL_1; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_0; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_1; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_2; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_3; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_4; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_5; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_6; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_7; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_8; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_9; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_10; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_11; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_12; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_13; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_14; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_15; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_16; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_17; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_18; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_19; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_20; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_21; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_22; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_23; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_24; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_25; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_26; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_27; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_28; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_29; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_30; // @[Tile.scala 16:49]
  wire [14:0] PE_1_io_MAC_31; // @[Tile.scala 16:49]
  PE PE ( // @[Tile.scala 16:49]
    .clock(PE_clock),
    .io_WL(PE_io_WL),
    .io_IN_0(PE_io_IN_0),
    .io_IN_1(PE_io_IN_1),
    .io_BL_0(PE_io_BL_0),
    .io_BL_1(PE_io_BL_1),
    .io_MAC_0(PE_io_MAC_0),
    .io_MAC_1(PE_io_MAC_1),
    .io_MAC_2(PE_io_MAC_2),
    .io_MAC_3(PE_io_MAC_3),
    .io_MAC_4(PE_io_MAC_4),
    .io_MAC_5(PE_io_MAC_5),
    .io_MAC_6(PE_io_MAC_6),
    .io_MAC_7(PE_io_MAC_7),
    .io_MAC_8(PE_io_MAC_8),
    .io_MAC_9(PE_io_MAC_9),
    .io_MAC_10(PE_io_MAC_10),
    .io_MAC_11(PE_io_MAC_11),
    .io_MAC_12(PE_io_MAC_12),
    .io_MAC_13(PE_io_MAC_13),
    .io_MAC_14(PE_io_MAC_14),
    .io_MAC_15(PE_io_MAC_15),
    .io_MAC_16(PE_io_MAC_16),
    .io_MAC_17(PE_io_MAC_17),
    .io_MAC_18(PE_io_MAC_18),
    .io_MAC_19(PE_io_MAC_19),
    .io_MAC_20(PE_io_MAC_20),
    .io_MAC_21(PE_io_MAC_21),
    .io_MAC_22(PE_io_MAC_22),
    .io_MAC_23(PE_io_MAC_23),
    .io_MAC_24(PE_io_MAC_24),
    .io_MAC_25(PE_io_MAC_25),
    .io_MAC_26(PE_io_MAC_26),
    .io_MAC_27(PE_io_MAC_27),
    .io_MAC_28(PE_io_MAC_28),
    .io_MAC_29(PE_io_MAC_29),
    .io_MAC_30(PE_io_MAC_30),
    .io_MAC_31(PE_io_MAC_31)
  );
  PE PE_1 ( // @[Tile.scala 16:49]
    .clock(PE_1_clock),
    .io_WL(PE_1_io_WL),
    .io_IN_0(PE_1_io_IN_0),
    .io_IN_1(PE_1_io_IN_1),
    .io_BL_0(PE_1_io_BL_0),
    .io_BL_1(PE_1_io_BL_1),
    .io_MAC_0(PE_1_io_MAC_0),
    .io_MAC_1(PE_1_io_MAC_1),
    .io_MAC_2(PE_1_io_MAC_2),
    .io_MAC_3(PE_1_io_MAC_3),
    .io_MAC_4(PE_1_io_MAC_4),
    .io_MAC_5(PE_1_io_MAC_5),
    .io_MAC_6(PE_1_io_MAC_6),
    .io_MAC_7(PE_1_io_MAC_7),
    .io_MAC_8(PE_1_io_MAC_8),
    .io_MAC_9(PE_1_io_MAC_9),
    .io_MAC_10(PE_1_io_MAC_10),
    .io_MAC_11(PE_1_io_MAC_11),
    .io_MAC_12(PE_1_io_MAC_12),
    .io_MAC_13(PE_1_io_MAC_13),
    .io_MAC_14(PE_1_io_MAC_14),
    .io_MAC_15(PE_1_io_MAC_15),
    .io_MAC_16(PE_1_io_MAC_16),
    .io_MAC_17(PE_1_io_MAC_17),
    .io_MAC_18(PE_1_io_MAC_18),
    .io_MAC_19(PE_1_io_MAC_19),
    .io_MAC_20(PE_1_io_MAC_20),
    .io_MAC_21(PE_1_io_MAC_21),
    .io_MAC_22(PE_1_io_MAC_22),
    .io_MAC_23(PE_1_io_MAC_23),
    .io_MAC_24(PE_1_io_MAC_24),
    .io_MAC_25(PE_1_io_MAC_25),
    .io_MAC_26(PE_1_io_MAC_26),
    .io_MAC_27(PE_1_io_MAC_27),
    .io_MAC_28(PE_1_io_MAC_28),
    .io_MAC_29(PE_1_io_MAC_29),
    .io_MAC_30(PE_1_io_MAC_30),
    .io_MAC_31(PE_1_io_MAC_31)
  );
  assign io_MAC_0 = PE_io_MAC_0; // @[Tile.scala 16:{18,18}]
  assign io_MAC_1 = PE_io_MAC_1; // @[Tile.scala 16:{18,18}]
  assign io_MAC_2 = PE_io_MAC_2; // @[Tile.scala 16:{18,18}]
  assign io_MAC_3 = PE_io_MAC_3; // @[Tile.scala 16:{18,18}]
  assign io_MAC_4 = PE_io_MAC_4; // @[Tile.scala 16:{18,18}]
  assign io_MAC_5 = PE_io_MAC_5; // @[Tile.scala 16:{18,18}]
  assign io_MAC_6 = PE_io_MAC_6; // @[Tile.scala 16:{18,18}]
  assign io_MAC_7 = PE_io_MAC_7; // @[Tile.scala 16:{18,18}]
  assign io_MAC_8 = PE_io_MAC_8; // @[Tile.scala 16:{18,18}]
  assign io_MAC_9 = PE_io_MAC_9; // @[Tile.scala 16:{18,18}]
  assign io_MAC_10 = PE_io_MAC_10; // @[Tile.scala 16:{18,18}]
  assign io_MAC_11 = PE_io_MAC_11; // @[Tile.scala 16:{18,18}]
  assign io_MAC_12 = PE_io_MAC_12; // @[Tile.scala 16:{18,18}]
  assign io_MAC_13 = PE_io_MAC_13; // @[Tile.scala 16:{18,18}]
  assign io_MAC_14 = PE_io_MAC_14; // @[Tile.scala 16:{18,18}]
  assign io_MAC_15 = PE_io_MAC_15; // @[Tile.scala 16:{18,18}]
  assign io_MAC_16 = PE_io_MAC_16; // @[Tile.scala 16:{18,18}]
  assign io_MAC_17 = PE_io_MAC_17; // @[Tile.scala 16:{18,18}]
  assign io_MAC_18 = PE_io_MAC_18; // @[Tile.scala 16:{18,18}]
  assign io_MAC_19 = PE_io_MAC_19; // @[Tile.scala 16:{18,18}]
  assign io_MAC_20 = PE_io_MAC_20; // @[Tile.scala 16:{18,18}]
  assign io_MAC_21 = PE_io_MAC_21; // @[Tile.scala 16:{18,18}]
  assign io_MAC_22 = PE_io_MAC_22; // @[Tile.scala 16:{18,18}]
  assign io_MAC_23 = PE_io_MAC_23; // @[Tile.scala 16:{18,18}]
  assign io_MAC_24 = PE_io_MAC_24; // @[Tile.scala 16:{18,18}]
  assign io_MAC_25 = PE_io_MAC_25; // @[Tile.scala 16:{18,18}]
  assign io_MAC_26 = PE_io_MAC_26; // @[Tile.scala 16:{18,18}]
  assign io_MAC_27 = PE_io_MAC_27; // @[Tile.scala 16:{18,18}]
  assign io_MAC_28 = PE_io_MAC_28; // @[Tile.scala 16:{18,18}]
  assign io_MAC_29 = PE_io_MAC_29; // @[Tile.scala 16:{18,18}]
  assign io_MAC_30 = PE_io_MAC_30; // @[Tile.scala 16:{18,18}]
  assign io_MAC_31 = PE_io_MAC_31; // @[Tile.scala 16:{18,18}]
  assign io_MAC_32 = PE_1_io_MAC_0; // @[Tile.scala 16:{18,18}]
  assign io_MAC_33 = PE_1_io_MAC_1; // @[Tile.scala 16:{18,18}]
  assign io_MAC_34 = PE_1_io_MAC_2; // @[Tile.scala 16:{18,18}]
  assign io_MAC_35 = PE_1_io_MAC_3; // @[Tile.scala 16:{18,18}]
  assign io_MAC_36 = PE_1_io_MAC_4; // @[Tile.scala 16:{18,18}]
  assign io_MAC_37 = PE_1_io_MAC_5; // @[Tile.scala 16:{18,18}]
  assign io_MAC_38 = PE_1_io_MAC_6; // @[Tile.scala 16:{18,18}]
  assign io_MAC_39 = PE_1_io_MAC_7; // @[Tile.scala 16:{18,18}]
  assign io_MAC_40 = PE_1_io_MAC_8; // @[Tile.scala 16:{18,18}]
  assign io_MAC_41 = PE_1_io_MAC_9; // @[Tile.scala 16:{18,18}]
  assign io_MAC_42 = PE_1_io_MAC_10; // @[Tile.scala 16:{18,18}]
  assign io_MAC_43 = PE_1_io_MAC_11; // @[Tile.scala 16:{18,18}]
  assign io_MAC_44 = PE_1_io_MAC_12; // @[Tile.scala 16:{18,18}]
  assign io_MAC_45 = PE_1_io_MAC_13; // @[Tile.scala 16:{18,18}]
  assign io_MAC_46 = PE_1_io_MAC_14; // @[Tile.scala 16:{18,18}]
  assign io_MAC_47 = PE_1_io_MAC_15; // @[Tile.scala 16:{18,18}]
  assign io_MAC_48 = PE_1_io_MAC_16; // @[Tile.scala 16:{18,18}]
  assign io_MAC_49 = PE_1_io_MAC_17; // @[Tile.scala 16:{18,18}]
  assign io_MAC_50 = PE_1_io_MAC_18; // @[Tile.scala 16:{18,18}]
  assign io_MAC_51 = PE_1_io_MAC_19; // @[Tile.scala 16:{18,18}]
  assign io_MAC_52 = PE_1_io_MAC_20; // @[Tile.scala 16:{18,18}]
  assign io_MAC_53 = PE_1_io_MAC_21; // @[Tile.scala 16:{18,18}]
  assign io_MAC_54 = PE_1_io_MAC_22; // @[Tile.scala 16:{18,18}]
  assign io_MAC_55 = PE_1_io_MAC_23; // @[Tile.scala 16:{18,18}]
  assign io_MAC_56 = PE_1_io_MAC_24; // @[Tile.scala 16:{18,18}]
  assign io_MAC_57 = PE_1_io_MAC_25; // @[Tile.scala 16:{18,18}]
  assign io_MAC_58 = PE_1_io_MAC_26; // @[Tile.scala 16:{18,18}]
  assign io_MAC_59 = PE_1_io_MAC_27; // @[Tile.scala 16:{18,18}]
  assign io_MAC_60 = PE_1_io_MAC_28; // @[Tile.scala 16:{18,18}]
  assign io_MAC_61 = PE_1_io_MAC_29; // @[Tile.scala 16:{18,18}]
  assign io_MAC_62 = PE_1_io_MAC_30; // @[Tile.scala 16:{18,18}]
  assign io_MAC_63 = PE_1_io_MAC_31; // @[Tile.scala 16:{18,18}]
  assign PE_clock = clock;
  assign PE_io_WL = io_WL; // @[Tile.scala 16:18 19:15]
  assign PE_io_IN_0 = io_IN_0; // @[Tile.scala 16:18 21:23]
  assign PE_io_IN_1 = io_IN_1; // @[Tile.scala 16:18 21:23]
  assign PE_io_BL_0 = io_BL_0; // @[Tile.scala 16:18 22:23]
  assign PE_io_BL_1 = io_BL_1; // @[Tile.scala 16:18 22:23]
  assign PE_1_clock = clock;
  assign PE_1_io_WL = io_WL; // @[Tile.scala 16:18 19:15]
  assign PE_1_io_IN_0 = io_IN_2; // @[Tile.scala 16:18 21:23]
  assign PE_1_io_IN_1 = io_IN_3; // @[Tile.scala 16:18 21:23]
  assign PE_1_io_BL_0 = io_BL_2; // @[Tile.scala 16:18 22:23]
  assign PE_1_io_BL_1 = io_BL_3; // @[Tile.scala 16:18 22:23]
endmodule
module ConV_8x8(
  input         clock,
  input  [14:0] io_d_in,
  input  [4:0]  io_Current_state,
  output [31:0] io_OUT
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [22:0] d_out_sign; // @[ConV_8x8.scala 69:23]
  reg [22:0] d_out_sign_fix; // @[ConV_8x8.scala 70:27]
  reg [22:0] sum_out; // @[ConV_8x8.scala 71:20]
  wire  _T_2 = io_Current_state == 5'h8; // @[ConV_8x8.scala 73:27]
  wire [22:0] _d_out_T = {1'h0,io_d_in,7'h0}; // @[Cat.scala 33:92]
  wire  _T_3 = io_Current_state == 5'h9; // @[ConV_8x8.scala 76:33]
  wire [22:0] _d_out_T_1 = {8'h0,io_d_in}; // @[Cat.scala 33:92]
  wire  _T_4 = io_Current_state == 5'ha; // @[ConV_8x8.scala 78:33]
  wire [22:0] _d_out_T_2 = {7'h0,io_d_in,1'h0}; // @[Cat.scala 33:92]
  wire  _T_5 = io_Current_state == 5'hb; // @[ConV_8x8.scala 80:33]
  wire [22:0] _d_out_T_3 = {6'h0,io_d_in,2'h0}; // @[Cat.scala 33:92]
  wire  _T_6 = io_Current_state == 5'hc; // @[ConV_8x8.scala 82:33]
  wire [22:0] _d_out_T_4 = {5'h0,io_d_in,3'h0}; // @[Cat.scala 33:92]
  wire  _T_7 = io_Current_state == 5'hd; // @[ConV_8x8.scala 84:33]
  wire [22:0] _d_out_T_5 = {4'h0,io_d_in,4'h0}; // @[Cat.scala 33:92]
  wire  _T_8 = io_Current_state == 5'he; // @[ConV_8x8.scala 86:33]
  wire [22:0] _d_out_T_6 = {3'h0,io_d_in,5'h0}; // @[Cat.scala 33:92]
  wire  _T_9 = io_Current_state == 5'hf; // @[ConV_8x8.scala 88:33]
  wire [22:0] _d_out_T_7 = {2'h0,io_d_in,6'h0}; // @[Cat.scala 33:92]
  wire [22:0] _GEN_0 = io_Current_state == 5'hf ? _d_out_T_7 : 23'h0; // @[ConV_8x8.scala 88:68 89:13 91:13]
  wire [22:0] _GEN_1 = io_Current_state == 5'he ? _d_out_T_6 : _GEN_0; // @[ConV_8x8.scala 86:68 87:13]
  wire [22:0] _GEN_2 = io_Current_state == 5'hd ? _d_out_T_5 : _GEN_1; // @[ConV_8x8.scala 84:68 85:13]
  wire [22:0] _GEN_3 = io_Current_state == 5'hc ? _d_out_T_4 : _GEN_2; // @[ConV_8x8.scala 82:68 83:13]
  wire [22:0] _GEN_4 = io_Current_state == 5'hb ? _d_out_T_3 : _GEN_3; // @[ConV_8x8.scala 80:68 81:13]
  wire [22:0] _GEN_5 = io_Current_state == 5'ha ? _d_out_T_2 : _GEN_4; // @[ConV_8x8.scala 78:68 79:13]
  wire [22:0] _GEN_6 = io_Current_state == 5'h9 ? _d_out_T_1 : _GEN_5; // @[ConV_8x8.scala 76:68 77:13]
  wire [22:0] _GEN_7 = io_Current_state == 5'h8 ? _d_out_T : _GEN_6; // @[ConV_8x8.scala 73:56 74:13]
  wire [22:0] _d_out_T_8 = {1'h1,io_d_in,7'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_9 = {8'hff,io_d_in}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_10 = {7'h7f,io_d_in,1'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_11 = {6'h3f,io_d_in,2'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_12 = {5'h1f,io_d_in,3'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_13 = {4'hf,io_d_in,4'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_14 = {3'h7,io_d_in,5'h0}; // @[Cat.scala 33:92]
  wire [22:0] _d_out_T_15 = {2'h3,io_d_in,6'h0}; // @[Cat.scala 33:92]
  wire [22:0] _GEN_9 = _T_9 ? _d_out_T_15 : 23'h0; // @[ConV_8x8.scala 109:68 110:13 112:13]
  wire [22:0] _GEN_10 = _T_8 ? _d_out_T_14 : _GEN_9; // @[ConV_8x8.scala 107:68 108:13]
  wire [22:0] _GEN_11 = _T_7 ? _d_out_T_13 : _GEN_10; // @[ConV_8x8.scala 105:68 106:13]
  wire [22:0] _GEN_12 = _T_6 ? _d_out_T_12 : _GEN_11; // @[ConV_8x8.scala 103:68 104:13]
  wire [22:0] _GEN_13 = _T_5 ? _d_out_T_11 : _GEN_12; // @[ConV_8x8.scala 101:68 102:13]
  wire [22:0] _GEN_14 = _T_4 ? _d_out_T_10 : _GEN_13; // @[ConV_8x8.scala 100:13 99:68]
  wire [22:0] _GEN_15 = _T_3 ? _d_out_T_9 : _GEN_14; // @[ConV_8x8.scala 97:68 98:13]
  wire [22:0] _GEN_16 = _T_2 ? _d_out_T_8 : _GEN_15; // @[ConV_8x8.scala 94:56 95:13]
  wire [22:0] d_out = ~io_d_in[14] ? _GEN_7 : _GEN_16; // @[ConV_8x8.scala 72:40]
  wire [22:0] _sum_out_T_1 = sum_out + d_out_sign_fix; // @[ConV_8x8.scala 117:24]
  wire [22:0] _sum_out_T_3 = sum_out + d_out; // @[ConV_8x8.scala 119:24]
  wire [38:0] _d_out_sign_fix_T = {d_out_sign, 16'h0}; // @[ConV_8x8.scala 120:35]
  wire [38:0] _GEN_26 = {{16'd0}, d_out_sign}; // @[ConV_8x8.scala 120:56]
  wire [38:0] _d_out_sign_fix_T_2 = _d_out_sign_fix_T - _GEN_26; // @[ConV_8x8.scala 120:56]
  wire [38:0] _GEN_23 = _T_3 ? _d_out_sign_fix_T_2 : {{16'd0}, d_out_sign_fix}; // @[ConV_8x8.scala 118:64 120:20 70:27]
  wire [38:0] _GEN_25 = io_Current_state == 5'h10 ? {{16'd0}, d_out_sign_fix} : _GEN_23; // @[ConV_8x8.scala 116:46 70:27]
  wire [31:0] _io_OUT_T_2 = {9'h1ff,sum_out}; // @[Cat.scala 33:92]
  assign io_OUT = sum_out[22] ? _io_OUT_T_2 : {{9'd0}, sum_out}; // @[ConV_8x8.scala 149:16]
  always @(posedge clock) begin
    if (~io_d_in[14]) begin // @[ConV_8x8.scala 72:40]
      if (io_Current_state == 5'h8) begin // @[ConV_8x8.scala 73:56]
        d_out_sign <= _d_out_T; // @[ConV_8x8.scala 75:18]
      end
    end else if (_T_2) begin // @[ConV_8x8.scala 94:56]
      d_out_sign <= _d_out_T_8; // @[ConV_8x8.scala 96:18]
    end
    d_out_sign_fix <= _GEN_25[22:0];
    if (io_Current_state == 5'h10) begin // @[ConV_8x8.scala 116:46]
      sum_out <= _sum_out_T_1; // @[ConV_8x8.scala 117:13]
    end else if (_T_3) begin // @[ConV_8x8.scala 118:64]
      sum_out <= _sum_out_T_3; // @[ConV_8x8.scala 119:13]
    end else if (io_Current_state > 5'h9) begin // @[ConV_8x8.scala 121:62]
      sum_out <= _sum_out_T_3; // @[ConV_8x8.scala 122:13]
    end else if (io_Current_state == 5'h0) begin // @[ConV_8x8.scala 123:40]
      sum_out <= 23'h0; // @[ConV_8x8.scala 124:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  d_out_sign = _RAND_0[22:0];
  _RAND_1 = {1{`RANDOM}};
  d_out_sign_fix = _RAND_1[22:0];
  _RAND_2 = {1{`RANDOM}};
  sum_out = _RAND_2[22:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ConV_8x8_Array(
  input         clock,
  input  [14:0] io_d_in_0,
  input  [14:0] io_d_in_1,
  input  [14:0] io_d_in_2,
  input  [14:0] io_d_in_3,
  input  [14:0] io_d_in_4,
  input  [14:0] io_d_in_5,
  input  [14:0] io_d_in_6,
  input  [14:0] io_d_in_7,
  input  [14:0] io_d_in_8,
  input  [14:0] io_d_in_9,
  input  [14:0] io_d_in_10,
  input  [14:0] io_d_in_11,
  input  [14:0] io_d_in_12,
  input  [14:0] io_d_in_13,
  input  [14:0] io_d_in_14,
  input  [14:0] io_d_in_15,
  input  [4:0]  io_Current_state,
  output [31:0] io_sum_0,
  output [31:0] io_sum_1,
  output [31:0] io_sum_2,
  output [31:0] io_sum_3,
  output [31:0] io_sum_4,
  output [31:0] io_sum_5,
  output [31:0] io_sum_6,
  output [31:0] io_sum_7,
  output [31:0] io_sum_8,
  output [31:0] io_sum_9,
  output [31:0] io_sum_10,
  output [31:0] io_sum_11,
  output [31:0] io_sum_12,
  output [31:0] io_sum_13,
  output [31:0] io_sum_14,
  output [31:0] io_sum_15
);
  wire  ConV_8x8_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_1_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_1_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_1_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_1_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_2_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_2_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_2_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_2_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_3_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_3_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_3_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_3_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_4_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_4_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_4_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_4_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_5_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_5_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_5_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_5_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_6_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_6_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_6_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_6_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_7_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_7_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_7_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_7_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_8_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_8_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_8_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_8_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_9_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_9_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_9_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_9_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_10_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_10_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_10_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_10_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_11_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_11_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_11_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_11_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_12_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_12_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_12_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_12_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_13_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_13_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_13_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_13_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_14_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_14_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_14_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_14_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  wire  ConV_8x8_15_clock; // @[ConV_8x8_Array.scala 15:55]
  wire [14:0] ConV_8x8_15_io_d_in; // @[ConV_8x8_Array.scala 15:55]
  wire [4:0] ConV_8x8_15_io_Current_state; // @[ConV_8x8_Array.scala 15:55]
  wire [31:0] ConV_8x8_15_io_OUT; // @[ConV_8x8_Array.scala 15:55]
  ConV_8x8 ConV_8x8 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_clock),
    .io_d_in(ConV_8x8_io_d_in),
    .io_Current_state(ConV_8x8_io_Current_state),
    .io_OUT(ConV_8x8_io_OUT)
  );
  ConV_8x8 ConV_8x8_1 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_1_clock),
    .io_d_in(ConV_8x8_1_io_d_in),
    .io_Current_state(ConV_8x8_1_io_Current_state),
    .io_OUT(ConV_8x8_1_io_OUT)
  );
  ConV_8x8 ConV_8x8_2 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_2_clock),
    .io_d_in(ConV_8x8_2_io_d_in),
    .io_Current_state(ConV_8x8_2_io_Current_state),
    .io_OUT(ConV_8x8_2_io_OUT)
  );
  ConV_8x8 ConV_8x8_3 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_3_clock),
    .io_d_in(ConV_8x8_3_io_d_in),
    .io_Current_state(ConV_8x8_3_io_Current_state),
    .io_OUT(ConV_8x8_3_io_OUT)
  );
  ConV_8x8 ConV_8x8_4 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_4_clock),
    .io_d_in(ConV_8x8_4_io_d_in),
    .io_Current_state(ConV_8x8_4_io_Current_state),
    .io_OUT(ConV_8x8_4_io_OUT)
  );
  ConV_8x8 ConV_8x8_5 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_5_clock),
    .io_d_in(ConV_8x8_5_io_d_in),
    .io_Current_state(ConV_8x8_5_io_Current_state),
    .io_OUT(ConV_8x8_5_io_OUT)
  );
  ConV_8x8 ConV_8x8_6 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_6_clock),
    .io_d_in(ConV_8x8_6_io_d_in),
    .io_Current_state(ConV_8x8_6_io_Current_state),
    .io_OUT(ConV_8x8_6_io_OUT)
  );
  ConV_8x8 ConV_8x8_7 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_7_clock),
    .io_d_in(ConV_8x8_7_io_d_in),
    .io_Current_state(ConV_8x8_7_io_Current_state),
    .io_OUT(ConV_8x8_7_io_OUT)
  );
  ConV_8x8 ConV_8x8_8 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_8_clock),
    .io_d_in(ConV_8x8_8_io_d_in),
    .io_Current_state(ConV_8x8_8_io_Current_state),
    .io_OUT(ConV_8x8_8_io_OUT)
  );
  ConV_8x8 ConV_8x8_9 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_9_clock),
    .io_d_in(ConV_8x8_9_io_d_in),
    .io_Current_state(ConV_8x8_9_io_Current_state),
    .io_OUT(ConV_8x8_9_io_OUT)
  );
  ConV_8x8 ConV_8x8_10 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_10_clock),
    .io_d_in(ConV_8x8_10_io_d_in),
    .io_Current_state(ConV_8x8_10_io_Current_state),
    .io_OUT(ConV_8x8_10_io_OUT)
  );
  ConV_8x8 ConV_8x8_11 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_11_clock),
    .io_d_in(ConV_8x8_11_io_d_in),
    .io_Current_state(ConV_8x8_11_io_Current_state),
    .io_OUT(ConV_8x8_11_io_OUT)
  );
  ConV_8x8 ConV_8x8_12 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_12_clock),
    .io_d_in(ConV_8x8_12_io_d_in),
    .io_Current_state(ConV_8x8_12_io_Current_state),
    .io_OUT(ConV_8x8_12_io_OUT)
  );
  ConV_8x8 ConV_8x8_13 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_13_clock),
    .io_d_in(ConV_8x8_13_io_d_in),
    .io_Current_state(ConV_8x8_13_io_Current_state),
    .io_OUT(ConV_8x8_13_io_OUT)
  );
  ConV_8x8 ConV_8x8_14 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_14_clock),
    .io_d_in(ConV_8x8_14_io_d_in),
    .io_Current_state(ConV_8x8_14_io_Current_state),
    .io_OUT(ConV_8x8_14_io_OUT)
  );
  ConV_8x8 ConV_8x8_15 ( // @[ConV_8x8_Array.scala 15:55]
    .clock(ConV_8x8_15_clock),
    .io_d_in(ConV_8x8_15_io_d_in),
    .io_Current_state(ConV_8x8_15_io_Current_state),
    .io_OUT(ConV_8x8_15_io_OUT)
  );
  assign io_sum_0 = ConV_8x8_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_1 = ConV_8x8_1_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_2 = ConV_8x8_2_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_3 = ConV_8x8_3_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_4 = ConV_8x8_4_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_5 = ConV_8x8_5_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_6 = ConV_8x8_6_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_7 = ConV_8x8_7_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_8 = ConV_8x8_8_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_9 = ConV_8x8_9_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_10 = ConV_8x8_10_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_11 = ConV_8x8_11_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_12 = ConV_8x8_12_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_13 = ConV_8x8_13_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_14 = ConV_8x8_14_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign io_sum_15 = ConV_8x8_15_io_OUT; // @[ConV_8x8_Array.scala 15:{27,27}]
  assign ConV_8x8_clock = clock;
  assign ConV_8x8_io_d_in = io_d_in_0; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_1_clock = clock;
  assign ConV_8x8_1_io_d_in = io_d_in_1; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_1_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_2_clock = clock;
  assign ConV_8x8_2_io_d_in = io_d_in_2; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_2_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_3_clock = clock;
  assign ConV_8x8_3_io_d_in = io_d_in_3; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_3_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_4_clock = clock;
  assign ConV_8x8_4_io_d_in = io_d_in_4; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_4_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_5_clock = clock;
  assign ConV_8x8_5_io_d_in = io_d_in_5; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_5_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_6_clock = clock;
  assign ConV_8x8_6_io_d_in = io_d_in_6; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_6_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_7_clock = clock;
  assign ConV_8x8_7_io_d_in = io_d_in_7; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_7_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_8_clock = clock;
  assign ConV_8x8_8_io_d_in = io_d_in_8; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_8_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_9_clock = clock;
  assign ConV_8x8_9_io_d_in = io_d_in_9; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_9_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_10_clock = clock;
  assign ConV_8x8_10_io_d_in = io_d_in_10; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_10_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_11_clock = clock;
  assign ConV_8x8_11_io_d_in = io_d_in_11; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_11_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_12_clock = clock;
  assign ConV_8x8_12_io_d_in = io_d_in_12; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_12_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_13_clock = clock;
  assign ConV_8x8_13_io_d_in = io_d_in_13; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_13_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_14_clock = clock;
  assign ConV_8x8_14_io_d_in = io_d_in_14; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_14_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
  assign ConV_8x8_15_clock = clock;
  assign ConV_8x8_15_io_d_in = io_d_in_15; // @[ConV_8x8_Array.scala 15:27 18:26]
  assign ConV_8x8_15_io_Current_state = io_Current_state; // @[ConV_8x8_Array.scala 15:27 19:35]
endmodule
module ConV_8x8_PE(
  input         clock,
  input  [14:0] io_d_in_0,
  input  [14:0] io_d_in_1,
  input  [14:0] io_d_in_2,
  input  [14:0] io_d_in_3,
  input  [14:0] io_d_in_4,
  input  [14:0] io_d_in_5,
  input  [14:0] io_d_in_6,
  input  [14:0] io_d_in_7,
  input  [14:0] io_d_in_8,
  input  [14:0] io_d_in_9,
  input  [14:0] io_d_in_10,
  input  [14:0] io_d_in_11,
  input  [14:0] io_d_in_12,
  input  [14:0] io_d_in_13,
  input  [14:0] io_d_in_14,
  input  [14:0] io_d_in_15,
  input  [14:0] io_d_in_16,
  input  [14:0] io_d_in_17,
  input  [14:0] io_d_in_18,
  input  [14:0] io_d_in_19,
  input  [14:0] io_d_in_20,
  input  [14:0] io_d_in_21,
  input  [14:0] io_d_in_22,
  input  [14:0] io_d_in_23,
  input  [14:0] io_d_in_24,
  input  [14:0] io_d_in_25,
  input  [14:0] io_d_in_26,
  input  [14:0] io_d_in_27,
  input  [14:0] io_d_in_28,
  input  [14:0] io_d_in_29,
  input  [14:0] io_d_in_30,
  input  [14:0] io_d_in_31,
  input  [4:0]  io_Current_state,
  output [31:0] io_sum_0,
  output [31:0] io_sum_1,
  output [31:0] io_sum_2,
  output [31:0] io_sum_3,
  output [31:0] io_sum_4,
  output [31:0] io_sum_5,
  output [31:0] io_sum_6,
  output [31:0] io_sum_7,
  output [31:0] io_sum_8,
  output [31:0] io_sum_9,
  output [31:0] io_sum_10,
  output [31:0] io_sum_11,
  output [31:0] io_sum_12,
  output [31:0] io_sum_13,
  output [31:0] io_sum_14,
  output [31:0] io_sum_15,
  output [31:0] io_sum_16,
  output [31:0] io_sum_17,
  output [31:0] io_sum_18,
  output [31:0] io_sum_19,
  output [31:0] io_sum_20,
  output [31:0] io_sum_21,
  output [31:0] io_sum_22,
  output [31:0] io_sum_23,
  output [31:0] io_sum_24,
  output [31:0] io_sum_25,
  output [31:0] io_sum_26,
  output [31:0] io_sum_27,
  output [31:0] io_sum_28,
  output [31:0] io_sum_29,
  output [31:0] io_sum_30,
  output [31:0] io_sum_31
);
  wire  ConV_8x8_Array_clock; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_0; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_1; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_2; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_3; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_4; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_5; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_6; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_7; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_8; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_9; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_10; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_11; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_12; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_13; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_14; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_io_d_in_15; // @[ConV_8x8_PE.scala 15:63]
  wire [4:0] ConV_8x8_Array_io_Current_state; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_0; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_1; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_2; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_3; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_4; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_5; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_6; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_7; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_8; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_9; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_10; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_11; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_12; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_13; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_14; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_io_sum_15; // @[ConV_8x8_PE.scala 15:63]
  wire  ConV_8x8_Array_1_clock; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_0; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_1; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_2; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_3; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_4; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_5; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_6; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_7; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_8; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_9; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_10; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_11; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_12; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_13; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_14; // @[ConV_8x8_PE.scala 15:63]
  wire [14:0] ConV_8x8_Array_1_io_d_in_15; // @[ConV_8x8_PE.scala 15:63]
  wire [4:0] ConV_8x8_Array_1_io_Current_state; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_0; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_1; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_2; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_3; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_4; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_5; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_6; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_7; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_8; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_9; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_10; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_11; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_12; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_13; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_14; // @[ConV_8x8_PE.scala 15:63]
  wire [31:0] ConV_8x8_Array_1_io_sum_15; // @[ConV_8x8_PE.scala 15:63]
  ConV_8x8_Array ConV_8x8_Array ( // @[ConV_8x8_PE.scala 15:63]
    .clock(ConV_8x8_Array_clock),
    .io_d_in_0(ConV_8x8_Array_io_d_in_0),
    .io_d_in_1(ConV_8x8_Array_io_d_in_1),
    .io_d_in_2(ConV_8x8_Array_io_d_in_2),
    .io_d_in_3(ConV_8x8_Array_io_d_in_3),
    .io_d_in_4(ConV_8x8_Array_io_d_in_4),
    .io_d_in_5(ConV_8x8_Array_io_d_in_5),
    .io_d_in_6(ConV_8x8_Array_io_d_in_6),
    .io_d_in_7(ConV_8x8_Array_io_d_in_7),
    .io_d_in_8(ConV_8x8_Array_io_d_in_8),
    .io_d_in_9(ConV_8x8_Array_io_d_in_9),
    .io_d_in_10(ConV_8x8_Array_io_d_in_10),
    .io_d_in_11(ConV_8x8_Array_io_d_in_11),
    .io_d_in_12(ConV_8x8_Array_io_d_in_12),
    .io_d_in_13(ConV_8x8_Array_io_d_in_13),
    .io_d_in_14(ConV_8x8_Array_io_d_in_14),
    .io_d_in_15(ConV_8x8_Array_io_d_in_15),
    .io_Current_state(ConV_8x8_Array_io_Current_state),
    .io_sum_0(ConV_8x8_Array_io_sum_0),
    .io_sum_1(ConV_8x8_Array_io_sum_1),
    .io_sum_2(ConV_8x8_Array_io_sum_2),
    .io_sum_3(ConV_8x8_Array_io_sum_3),
    .io_sum_4(ConV_8x8_Array_io_sum_4),
    .io_sum_5(ConV_8x8_Array_io_sum_5),
    .io_sum_6(ConV_8x8_Array_io_sum_6),
    .io_sum_7(ConV_8x8_Array_io_sum_7),
    .io_sum_8(ConV_8x8_Array_io_sum_8),
    .io_sum_9(ConV_8x8_Array_io_sum_9),
    .io_sum_10(ConV_8x8_Array_io_sum_10),
    .io_sum_11(ConV_8x8_Array_io_sum_11),
    .io_sum_12(ConV_8x8_Array_io_sum_12),
    .io_sum_13(ConV_8x8_Array_io_sum_13),
    .io_sum_14(ConV_8x8_Array_io_sum_14),
    .io_sum_15(ConV_8x8_Array_io_sum_15)
  );
  ConV_8x8_Array ConV_8x8_Array_1 ( // @[ConV_8x8_PE.scala 15:63]
    .clock(ConV_8x8_Array_1_clock),
    .io_d_in_0(ConV_8x8_Array_1_io_d_in_0),
    .io_d_in_1(ConV_8x8_Array_1_io_d_in_1),
    .io_d_in_2(ConV_8x8_Array_1_io_d_in_2),
    .io_d_in_3(ConV_8x8_Array_1_io_d_in_3),
    .io_d_in_4(ConV_8x8_Array_1_io_d_in_4),
    .io_d_in_5(ConV_8x8_Array_1_io_d_in_5),
    .io_d_in_6(ConV_8x8_Array_1_io_d_in_6),
    .io_d_in_7(ConV_8x8_Array_1_io_d_in_7),
    .io_d_in_8(ConV_8x8_Array_1_io_d_in_8),
    .io_d_in_9(ConV_8x8_Array_1_io_d_in_9),
    .io_d_in_10(ConV_8x8_Array_1_io_d_in_10),
    .io_d_in_11(ConV_8x8_Array_1_io_d_in_11),
    .io_d_in_12(ConV_8x8_Array_1_io_d_in_12),
    .io_d_in_13(ConV_8x8_Array_1_io_d_in_13),
    .io_d_in_14(ConV_8x8_Array_1_io_d_in_14),
    .io_d_in_15(ConV_8x8_Array_1_io_d_in_15),
    .io_Current_state(ConV_8x8_Array_1_io_Current_state),
    .io_sum_0(ConV_8x8_Array_1_io_sum_0),
    .io_sum_1(ConV_8x8_Array_1_io_sum_1),
    .io_sum_2(ConV_8x8_Array_1_io_sum_2),
    .io_sum_3(ConV_8x8_Array_1_io_sum_3),
    .io_sum_4(ConV_8x8_Array_1_io_sum_4),
    .io_sum_5(ConV_8x8_Array_1_io_sum_5),
    .io_sum_6(ConV_8x8_Array_1_io_sum_6),
    .io_sum_7(ConV_8x8_Array_1_io_sum_7),
    .io_sum_8(ConV_8x8_Array_1_io_sum_8),
    .io_sum_9(ConV_8x8_Array_1_io_sum_9),
    .io_sum_10(ConV_8x8_Array_1_io_sum_10),
    .io_sum_11(ConV_8x8_Array_1_io_sum_11),
    .io_sum_12(ConV_8x8_Array_1_io_sum_12),
    .io_sum_13(ConV_8x8_Array_1_io_sum_13),
    .io_sum_14(ConV_8x8_Array_1_io_sum_14),
    .io_sum_15(ConV_8x8_Array_1_io_sum_15)
  );
  assign io_sum_0 = ConV_8x8_Array_io_sum_0; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_1 = ConV_8x8_Array_io_sum_1; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_2 = ConV_8x8_Array_io_sum_2; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_3 = ConV_8x8_Array_io_sum_3; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_4 = ConV_8x8_Array_io_sum_4; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_5 = ConV_8x8_Array_io_sum_5; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_6 = ConV_8x8_Array_io_sum_6; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_7 = ConV_8x8_Array_io_sum_7; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_8 = ConV_8x8_Array_io_sum_8; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_9 = ConV_8x8_Array_io_sum_9; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_10 = ConV_8x8_Array_io_sum_10; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_11 = ConV_8x8_Array_io_sum_11; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_12 = ConV_8x8_Array_io_sum_12; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_13 = ConV_8x8_Array_io_sum_13; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_14 = ConV_8x8_Array_io_sum_14; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_15 = ConV_8x8_Array_io_sum_15; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_16 = ConV_8x8_Array_1_io_sum_0; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_17 = ConV_8x8_Array_1_io_sum_1; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_18 = ConV_8x8_Array_1_io_sum_2; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_19 = ConV_8x8_Array_1_io_sum_3; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_20 = ConV_8x8_Array_1_io_sum_4; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_21 = ConV_8x8_Array_1_io_sum_5; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_22 = ConV_8x8_Array_1_io_sum_6; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_23 = ConV_8x8_Array_1_io_sum_7; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_24 = ConV_8x8_Array_1_io_sum_8; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_25 = ConV_8x8_Array_1_io_sum_9; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_26 = ConV_8x8_Array_1_io_sum_10; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_27 = ConV_8x8_Array_1_io_sum_11; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_28 = ConV_8x8_Array_1_io_sum_12; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_29 = ConV_8x8_Array_1_io_sum_13; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_30 = ConV_8x8_Array_1_io_sum_14; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign io_sum_31 = ConV_8x8_Array_1_io_sum_15; // @[ConV_8x8_PE.scala 15:{33,33}]
  assign ConV_8x8_Array_clock = clock;
  assign ConV_8x8_Array_io_d_in_0 = io_d_in_0; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_1 = io_d_in_1; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_2 = io_d_in_2; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_3 = io_d_in_3; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_4 = io_d_in_4; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_5 = io_d_in_5; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_6 = io_d_in_6; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_7 = io_d_in_7; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_8 = io_d_in_8; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_9 = io_d_in_9; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_10 = io_d_in_10; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_11 = io_d_in_11; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_12 = io_d_in_12; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_13 = io_d_in_13; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_14 = io_d_in_14; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_d_in_15 = io_d_in_15; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_io_Current_state = io_Current_state; // @[ConV_8x8_PE.scala 15:33 18:41]
  assign ConV_8x8_Array_1_clock = clock;
  assign ConV_8x8_Array_1_io_d_in_0 = io_d_in_16; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_1 = io_d_in_17; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_2 = io_d_in_18; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_3 = io_d_in_19; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_4 = io_d_in_20; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_5 = io_d_in_21; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_6 = io_d_in_22; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_7 = io_d_in_23; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_8 = io_d_in_24; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_9 = io_d_in_25; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_10 = io_d_in_26; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_11 = io_d_in_27; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_12 = io_d_in_28; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_13 = io_d_in_29; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_14 = io_d_in_30; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_d_in_15 = io_d_in_31; // @[ConV_8x8_PE.scala 15:33 20:40]
  assign ConV_8x8_Array_1_io_Current_state = io_Current_state; // @[ConV_8x8_PE.scala 15:33 18:41]
endmodule
module ConV_8x8_Tile(
  input         clock,
  input  [14:0] io_d_in_0,
  input  [14:0] io_d_in_1,
  input  [14:0] io_d_in_2,
  input  [14:0] io_d_in_3,
  input  [14:0] io_d_in_4,
  input  [14:0] io_d_in_5,
  input  [14:0] io_d_in_6,
  input  [14:0] io_d_in_7,
  input  [14:0] io_d_in_8,
  input  [14:0] io_d_in_9,
  input  [14:0] io_d_in_10,
  input  [14:0] io_d_in_11,
  input  [14:0] io_d_in_12,
  input  [14:0] io_d_in_13,
  input  [14:0] io_d_in_14,
  input  [14:0] io_d_in_15,
  input  [14:0] io_d_in_16,
  input  [14:0] io_d_in_17,
  input  [14:0] io_d_in_18,
  input  [14:0] io_d_in_19,
  input  [14:0] io_d_in_20,
  input  [14:0] io_d_in_21,
  input  [14:0] io_d_in_22,
  input  [14:0] io_d_in_23,
  input  [14:0] io_d_in_24,
  input  [14:0] io_d_in_25,
  input  [14:0] io_d_in_26,
  input  [14:0] io_d_in_27,
  input  [14:0] io_d_in_28,
  input  [14:0] io_d_in_29,
  input  [14:0] io_d_in_30,
  input  [14:0] io_d_in_31,
  input  [14:0] io_d_in_32,
  input  [14:0] io_d_in_33,
  input  [14:0] io_d_in_34,
  input  [14:0] io_d_in_35,
  input  [14:0] io_d_in_36,
  input  [14:0] io_d_in_37,
  input  [14:0] io_d_in_38,
  input  [14:0] io_d_in_39,
  input  [14:0] io_d_in_40,
  input  [14:0] io_d_in_41,
  input  [14:0] io_d_in_42,
  input  [14:0] io_d_in_43,
  input  [14:0] io_d_in_44,
  input  [14:0] io_d_in_45,
  input  [14:0] io_d_in_46,
  input  [14:0] io_d_in_47,
  input  [14:0] io_d_in_48,
  input  [14:0] io_d_in_49,
  input  [14:0] io_d_in_50,
  input  [14:0] io_d_in_51,
  input  [14:0] io_d_in_52,
  input  [14:0] io_d_in_53,
  input  [14:0] io_d_in_54,
  input  [14:0] io_d_in_55,
  input  [14:0] io_d_in_56,
  input  [14:0] io_d_in_57,
  input  [14:0] io_d_in_58,
  input  [14:0] io_d_in_59,
  input  [14:0] io_d_in_60,
  input  [14:0] io_d_in_61,
  input  [14:0] io_d_in_62,
  input  [14:0] io_d_in_63,
  input  [4:0]  io_Current_state,
  output [31:0] io_sum_0,
  output [31:0] io_sum_1,
  output [31:0] io_sum_2,
  output [31:0] io_sum_3,
  output [31:0] io_sum_4,
  output [31:0] io_sum_5,
  output [31:0] io_sum_6,
  output [31:0] io_sum_7,
  output [31:0] io_sum_8,
  output [31:0] io_sum_9,
  output [31:0] io_sum_10,
  output [31:0] io_sum_11,
  output [31:0] io_sum_12,
  output [31:0] io_sum_13,
  output [31:0] io_sum_14,
  output [31:0] io_sum_15,
  output [31:0] io_sum_16,
  output [31:0] io_sum_17,
  output [31:0] io_sum_18,
  output [31:0] io_sum_19,
  output [31:0] io_sum_20,
  output [31:0] io_sum_21,
  output [31:0] io_sum_22,
  output [31:0] io_sum_23,
  output [31:0] io_sum_24,
  output [31:0] io_sum_25,
  output [31:0] io_sum_26,
  output [31:0] io_sum_27,
  output [31:0] io_sum_28,
  output [31:0] io_sum_29,
  output [31:0] io_sum_30,
  output [31:0] io_sum_31,
  output [31:0] io_sum_32,
  output [31:0] io_sum_33,
  output [31:0] io_sum_34,
  output [31:0] io_sum_35,
  output [31:0] io_sum_36,
  output [31:0] io_sum_37,
  output [31:0] io_sum_38,
  output [31:0] io_sum_39,
  output [31:0] io_sum_40,
  output [31:0] io_sum_41,
  output [31:0] io_sum_42,
  output [31:0] io_sum_43,
  output [31:0] io_sum_44,
  output [31:0] io_sum_45,
  output [31:0] io_sum_46,
  output [31:0] io_sum_47,
  output [31:0] io_sum_48,
  output [31:0] io_sum_49,
  output [31:0] io_sum_50,
  output [31:0] io_sum_51,
  output [31:0] io_sum_52,
  output [31:0] io_sum_53,
  output [31:0] io_sum_54,
  output [31:0] io_sum_55,
  output [31:0] io_sum_56,
  output [31:0] io_sum_57,
  output [31:0] io_sum_58,
  output [31:0] io_sum_59,
  output [31:0] io_sum_60,
  output [31:0] io_sum_61,
  output [31:0] io_sum_62,
  output [31:0] io_sum_63
);
  wire  ConV_8x8_PE_clock; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_0; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_1; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_2; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_3; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_4; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_5; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_6; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_7; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_8; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_9; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_10; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_11; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_12; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_13; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_14; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_15; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_16; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_17; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_18; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_19; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_20; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_21; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_22; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_23; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_24; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_25; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_26; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_27; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_28; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_29; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_30; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_io_d_in_31; // @[ConV_8x8_Tile.scala 15:59]
  wire [4:0] ConV_8x8_PE_io_Current_state; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_0; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_1; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_2; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_3; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_4; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_5; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_6; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_7; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_8; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_9; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_10; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_11; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_12; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_13; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_14; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_15; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_16; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_17; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_18; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_19; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_20; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_21; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_22; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_23; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_24; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_25; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_26; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_27; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_28; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_29; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_30; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_io_sum_31; // @[ConV_8x8_Tile.scala 15:59]
  wire  ConV_8x8_PE_1_clock; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_0; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_1; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_2; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_3; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_4; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_5; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_6; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_7; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_8; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_9; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_10; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_11; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_12; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_13; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_14; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_15; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_16; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_17; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_18; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_19; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_20; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_21; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_22; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_23; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_24; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_25; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_26; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_27; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_28; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_29; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_30; // @[ConV_8x8_Tile.scala 15:59]
  wire [14:0] ConV_8x8_PE_1_io_d_in_31; // @[ConV_8x8_Tile.scala 15:59]
  wire [4:0] ConV_8x8_PE_1_io_Current_state; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_0; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_1; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_2; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_3; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_4; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_5; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_6; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_7; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_8; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_9; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_10; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_11; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_12; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_13; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_14; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_15; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_16; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_17; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_18; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_19; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_20; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_21; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_22; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_23; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_24; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_25; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_26; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_27; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_28; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_29; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_30; // @[ConV_8x8_Tile.scala 15:59]
  wire [31:0] ConV_8x8_PE_1_io_sum_31; // @[ConV_8x8_Tile.scala 15:59]
  ConV_8x8_PE ConV_8x8_PE ( // @[ConV_8x8_Tile.scala 15:59]
    .clock(ConV_8x8_PE_clock),
    .io_d_in_0(ConV_8x8_PE_io_d_in_0),
    .io_d_in_1(ConV_8x8_PE_io_d_in_1),
    .io_d_in_2(ConV_8x8_PE_io_d_in_2),
    .io_d_in_3(ConV_8x8_PE_io_d_in_3),
    .io_d_in_4(ConV_8x8_PE_io_d_in_4),
    .io_d_in_5(ConV_8x8_PE_io_d_in_5),
    .io_d_in_6(ConV_8x8_PE_io_d_in_6),
    .io_d_in_7(ConV_8x8_PE_io_d_in_7),
    .io_d_in_8(ConV_8x8_PE_io_d_in_8),
    .io_d_in_9(ConV_8x8_PE_io_d_in_9),
    .io_d_in_10(ConV_8x8_PE_io_d_in_10),
    .io_d_in_11(ConV_8x8_PE_io_d_in_11),
    .io_d_in_12(ConV_8x8_PE_io_d_in_12),
    .io_d_in_13(ConV_8x8_PE_io_d_in_13),
    .io_d_in_14(ConV_8x8_PE_io_d_in_14),
    .io_d_in_15(ConV_8x8_PE_io_d_in_15),
    .io_d_in_16(ConV_8x8_PE_io_d_in_16),
    .io_d_in_17(ConV_8x8_PE_io_d_in_17),
    .io_d_in_18(ConV_8x8_PE_io_d_in_18),
    .io_d_in_19(ConV_8x8_PE_io_d_in_19),
    .io_d_in_20(ConV_8x8_PE_io_d_in_20),
    .io_d_in_21(ConV_8x8_PE_io_d_in_21),
    .io_d_in_22(ConV_8x8_PE_io_d_in_22),
    .io_d_in_23(ConV_8x8_PE_io_d_in_23),
    .io_d_in_24(ConV_8x8_PE_io_d_in_24),
    .io_d_in_25(ConV_8x8_PE_io_d_in_25),
    .io_d_in_26(ConV_8x8_PE_io_d_in_26),
    .io_d_in_27(ConV_8x8_PE_io_d_in_27),
    .io_d_in_28(ConV_8x8_PE_io_d_in_28),
    .io_d_in_29(ConV_8x8_PE_io_d_in_29),
    .io_d_in_30(ConV_8x8_PE_io_d_in_30),
    .io_d_in_31(ConV_8x8_PE_io_d_in_31),
    .io_Current_state(ConV_8x8_PE_io_Current_state),
    .io_sum_0(ConV_8x8_PE_io_sum_0),
    .io_sum_1(ConV_8x8_PE_io_sum_1),
    .io_sum_2(ConV_8x8_PE_io_sum_2),
    .io_sum_3(ConV_8x8_PE_io_sum_3),
    .io_sum_4(ConV_8x8_PE_io_sum_4),
    .io_sum_5(ConV_8x8_PE_io_sum_5),
    .io_sum_6(ConV_8x8_PE_io_sum_6),
    .io_sum_7(ConV_8x8_PE_io_sum_7),
    .io_sum_8(ConV_8x8_PE_io_sum_8),
    .io_sum_9(ConV_8x8_PE_io_sum_9),
    .io_sum_10(ConV_8x8_PE_io_sum_10),
    .io_sum_11(ConV_8x8_PE_io_sum_11),
    .io_sum_12(ConV_8x8_PE_io_sum_12),
    .io_sum_13(ConV_8x8_PE_io_sum_13),
    .io_sum_14(ConV_8x8_PE_io_sum_14),
    .io_sum_15(ConV_8x8_PE_io_sum_15),
    .io_sum_16(ConV_8x8_PE_io_sum_16),
    .io_sum_17(ConV_8x8_PE_io_sum_17),
    .io_sum_18(ConV_8x8_PE_io_sum_18),
    .io_sum_19(ConV_8x8_PE_io_sum_19),
    .io_sum_20(ConV_8x8_PE_io_sum_20),
    .io_sum_21(ConV_8x8_PE_io_sum_21),
    .io_sum_22(ConV_8x8_PE_io_sum_22),
    .io_sum_23(ConV_8x8_PE_io_sum_23),
    .io_sum_24(ConV_8x8_PE_io_sum_24),
    .io_sum_25(ConV_8x8_PE_io_sum_25),
    .io_sum_26(ConV_8x8_PE_io_sum_26),
    .io_sum_27(ConV_8x8_PE_io_sum_27),
    .io_sum_28(ConV_8x8_PE_io_sum_28),
    .io_sum_29(ConV_8x8_PE_io_sum_29),
    .io_sum_30(ConV_8x8_PE_io_sum_30),
    .io_sum_31(ConV_8x8_PE_io_sum_31)
  );
  ConV_8x8_PE ConV_8x8_PE_1 ( // @[ConV_8x8_Tile.scala 15:59]
    .clock(ConV_8x8_PE_1_clock),
    .io_d_in_0(ConV_8x8_PE_1_io_d_in_0),
    .io_d_in_1(ConV_8x8_PE_1_io_d_in_1),
    .io_d_in_2(ConV_8x8_PE_1_io_d_in_2),
    .io_d_in_3(ConV_8x8_PE_1_io_d_in_3),
    .io_d_in_4(ConV_8x8_PE_1_io_d_in_4),
    .io_d_in_5(ConV_8x8_PE_1_io_d_in_5),
    .io_d_in_6(ConV_8x8_PE_1_io_d_in_6),
    .io_d_in_7(ConV_8x8_PE_1_io_d_in_7),
    .io_d_in_8(ConV_8x8_PE_1_io_d_in_8),
    .io_d_in_9(ConV_8x8_PE_1_io_d_in_9),
    .io_d_in_10(ConV_8x8_PE_1_io_d_in_10),
    .io_d_in_11(ConV_8x8_PE_1_io_d_in_11),
    .io_d_in_12(ConV_8x8_PE_1_io_d_in_12),
    .io_d_in_13(ConV_8x8_PE_1_io_d_in_13),
    .io_d_in_14(ConV_8x8_PE_1_io_d_in_14),
    .io_d_in_15(ConV_8x8_PE_1_io_d_in_15),
    .io_d_in_16(ConV_8x8_PE_1_io_d_in_16),
    .io_d_in_17(ConV_8x8_PE_1_io_d_in_17),
    .io_d_in_18(ConV_8x8_PE_1_io_d_in_18),
    .io_d_in_19(ConV_8x8_PE_1_io_d_in_19),
    .io_d_in_20(ConV_8x8_PE_1_io_d_in_20),
    .io_d_in_21(ConV_8x8_PE_1_io_d_in_21),
    .io_d_in_22(ConV_8x8_PE_1_io_d_in_22),
    .io_d_in_23(ConV_8x8_PE_1_io_d_in_23),
    .io_d_in_24(ConV_8x8_PE_1_io_d_in_24),
    .io_d_in_25(ConV_8x8_PE_1_io_d_in_25),
    .io_d_in_26(ConV_8x8_PE_1_io_d_in_26),
    .io_d_in_27(ConV_8x8_PE_1_io_d_in_27),
    .io_d_in_28(ConV_8x8_PE_1_io_d_in_28),
    .io_d_in_29(ConV_8x8_PE_1_io_d_in_29),
    .io_d_in_30(ConV_8x8_PE_1_io_d_in_30),
    .io_d_in_31(ConV_8x8_PE_1_io_d_in_31),
    .io_Current_state(ConV_8x8_PE_1_io_Current_state),
    .io_sum_0(ConV_8x8_PE_1_io_sum_0),
    .io_sum_1(ConV_8x8_PE_1_io_sum_1),
    .io_sum_2(ConV_8x8_PE_1_io_sum_2),
    .io_sum_3(ConV_8x8_PE_1_io_sum_3),
    .io_sum_4(ConV_8x8_PE_1_io_sum_4),
    .io_sum_5(ConV_8x8_PE_1_io_sum_5),
    .io_sum_6(ConV_8x8_PE_1_io_sum_6),
    .io_sum_7(ConV_8x8_PE_1_io_sum_7),
    .io_sum_8(ConV_8x8_PE_1_io_sum_8),
    .io_sum_9(ConV_8x8_PE_1_io_sum_9),
    .io_sum_10(ConV_8x8_PE_1_io_sum_10),
    .io_sum_11(ConV_8x8_PE_1_io_sum_11),
    .io_sum_12(ConV_8x8_PE_1_io_sum_12),
    .io_sum_13(ConV_8x8_PE_1_io_sum_13),
    .io_sum_14(ConV_8x8_PE_1_io_sum_14),
    .io_sum_15(ConV_8x8_PE_1_io_sum_15),
    .io_sum_16(ConV_8x8_PE_1_io_sum_16),
    .io_sum_17(ConV_8x8_PE_1_io_sum_17),
    .io_sum_18(ConV_8x8_PE_1_io_sum_18),
    .io_sum_19(ConV_8x8_PE_1_io_sum_19),
    .io_sum_20(ConV_8x8_PE_1_io_sum_20),
    .io_sum_21(ConV_8x8_PE_1_io_sum_21),
    .io_sum_22(ConV_8x8_PE_1_io_sum_22),
    .io_sum_23(ConV_8x8_PE_1_io_sum_23),
    .io_sum_24(ConV_8x8_PE_1_io_sum_24),
    .io_sum_25(ConV_8x8_PE_1_io_sum_25),
    .io_sum_26(ConV_8x8_PE_1_io_sum_26),
    .io_sum_27(ConV_8x8_PE_1_io_sum_27),
    .io_sum_28(ConV_8x8_PE_1_io_sum_28),
    .io_sum_29(ConV_8x8_PE_1_io_sum_29),
    .io_sum_30(ConV_8x8_PE_1_io_sum_30),
    .io_sum_31(ConV_8x8_PE_1_io_sum_31)
  );
  assign io_sum_0 = ConV_8x8_PE_io_sum_0; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_1 = ConV_8x8_PE_io_sum_1; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_2 = ConV_8x8_PE_io_sum_2; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_3 = ConV_8x8_PE_io_sum_3; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_4 = ConV_8x8_PE_io_sum_4; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_5 = ConV_8x8_PE_io_sum_5; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_6 = ConV_8x8_PE_io_sum_6; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_7 = ConV_8x8_PE_io_sum_7; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_8 = ConV_8x8_PE_io_sum_8; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_9 = ConV_8x8_PE_io_sum_9; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_10 = ConV_8x8_PE_io_sum_10; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_11 = ConV_8x8_PE_io_sum_11; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_12 = ConV_8x8_PE_io_sum_12; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_13 = ConV_8x8_PE_io_sum_13; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_14 = ConV_8x8_PE_io_sum_14; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_15 = ConV_8x8_PE_io_sum_15; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_16 = ConV_8x8_PE_io_sum_16; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_17 = ConV_8x8_PE_io_sum_17; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_18 = ConV_8x8_PE_io_sum_18; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_19 = ConV_8x8_PE_io_sum_19; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_20 = ConV_8x8_PE_io_sum_20; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_21 = ConV_8x8_PE_io_sum_21; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_22 = ConV_8x8_PE_io_sum_22; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_23 = ConV_8x8_PE_io_sum_23; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_24 = ConV_8x8_PE_io_sum_24; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_25 = ConV_8x8_PE_io_sum_25; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_26 = ConV_8x8_PE_io_sum_26; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_27 = ConV_8x8_PE_io_sum_27; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_28 = ConV_8x8_PE_io_sum_28; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_29 = ConV_8x8_PE_io_sum_29; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_30 = ConV_8x8_PE_io_sum_30; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_31 = ConV_8x8_PE_io_sum_31; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_32 = ConV_8x8_PE_1_io_sum_0; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_33 = ConV_8x8_PE_1_io_sum_1; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_34 = ConV_8x8_PE_1_io_sum_2; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_35 = ConV_8x8_PE_1_io_sum_3; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_36 = ConV_8x8_PE_1_io_sum_4; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_37 = ConV_8x8_PE_1_io_sum_5; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_38 = ConV_8x8_PE_1_io_sum_6; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_39 = ConV_8x8_PE_1_io_sum_7; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_40 = ConV_8x8_PE_1_io_sum_8; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_41 = ConV_8x8_PE_1_io_sum_9; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_42 = ConV_8x8_PE_1_io_sum_10; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_43 = ConV_8x8_PE_1_io_sum_11; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_44 = ConV_8x8_PE_1_io_sum_12; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_45 = ConV_8x8_PE_1_io_sum_13; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_46 = ConV_8x8_PE_1_io_sum_14; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_47 = ConV_8x8_PE_1_io_sum_15; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_48 = ConV_8x8_PE_1_io_sum_16; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_49 = ConV_8x8_PE_1_io_sum_17; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_50 = ConV_8x8_PE_1_io_sum_18; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_51 = ConV_8x8_PE_1_io_sum_19; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_52 = ConV_8x8_PE_1_io_sum_20; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_53 = ConV_8x8_PE_1_io_sum_21; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_54 = ConV_8x8_PE_1_io_sum_22; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_55 = ConV_8x8_PE_1_io_sum_23; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_56 = ConV_8x8_PE_1_io_sum_24; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_57 = ConV_8x8_PE_1_io_sum_25; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_58 = ConV_8x8_PE_1_io_sum_26; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_59 = ConV_8x8_PE_1_io_sum_27; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_60 = ConV_8x8_PE_1_io_sum_28; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_61 = ConV_8x8_PE_1_io_sum_29; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_62 = ConV_8x8_PE_1_io_sum_30; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign io_sum_63 = ConV_8x8_PE_1_io_sum_31; // @[ConV_8x8_Tile.scala 15:{30,30}]
  assign ConV_8x8_PE_clock = clock;
  assign ConV_8x8_PE_io_d_in_0 = io_d_in_0; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_1 = io_d_in_1; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_2 = io_d_in_2; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_3 = io_d_in_3; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_4 = io_d_in_4; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_5 = io_d_in_5; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_6 = io_d_in_6; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_7 = io_d_in_7; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_8 = io_d_in_8; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_9 = io_d_in_9; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_10 = io_d_in_10; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_11 = io_d_in_11; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_12 = io_d_in_12; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_13 = io_d_in_13; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_14 = io_d_in_14; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_15 = io_d_in_15; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_16 = io_d_in_16; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_17 = io_d_in_17; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_18 = io_d_in_18; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_19 = io_d_in_19; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_20 = io_d_in_20; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_21 = io_d_in_21; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_22 = io_d_in_22; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_23 = io_d_in_23; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_24 = io_d_in_24; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_25 = io_d_in_25; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_26 = io_d_in_26; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_27 = io_d_in_27; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_28 = io_d_in_28; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_29 = io_d_in_29; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_30 = io_d_in_30; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_d_in_31 = io_d_in_31; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_io_Current_state = io_Current_state; // @[ConV_8x8_Tile.scala 15:30 18:38]
  assign ConV_8x8_PE_1_clock = clock;
  assign ConV_8x8_PE_1_io_d_in_0 = io_d_in_32; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_1 = io_d_in_33; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_2 = io_d_in_34; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_3 = io_d_in_35; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_4 = io_d_in_36; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_5 = io_d_in_37; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_6 = io_d_in_38; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_7 = io_d_in_39; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_8 = io_d_in_40; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_9 = io_d_in_41; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_10 = io_d_in_42; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_11 = io_d_in_43; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_12 = io_d_in_44; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_13 = io_d_in_45; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_14 = io_d_in_46; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_15 = io_d_in_47; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_16 = io_d_in_48; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_17 = io_d_in_49; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_18 = io_d_in_50; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_19 = io_d_in_51; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_20 = io_d_in_52; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_21 = io_d_in_53; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_22 = io_d_in_54; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_23 = io_d_in_55; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_24 = io_d_in_56; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_25 = io_d_in_57; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_26 = io_d_in_58; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_27 = io_d_in_59; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_28 = io_d_in_60; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_29 = io_d_in_61; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_30 = io_d_in_62; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_d_in_31 = io_d_in_63; // @[ConV_8x8_Tile.scala 15:30 20:37]
  assign ConV_8x8_PE_1_io_Current_state = io_Current_state; // @[ConV_8x8_Tile.scala 15:30 18:38]
endmodule
module top_cim(
  input          clock,
  input          reset,
  input  [127:0] io_BL_0,
  input  [127:0] io_BL_1,
  input  [127:0] io_BL_2,
  input  [127:0] io_BL_3,
  input  [127:0] io_WL,
  input  [127:0] io_IN_0,
  input  [127:0] io_IN_1,
  input          io_ifm_buffer_ready,
  input          io_din_valid_ConV,
  output         io_dout_valid_ConV,
  output         io_buffer_busy,
  output [31:0]  io_sum_out_0,
  output [31:0]  io_sum_out_1,
  output [31:0]  io_sum_out_2,
  output [31:0]  io_sum_out_3,
  output [31:0]  io_sum_out_4,
  output [31:0]  io_sum_out_5,
  output [31:0]  io_sum_out_6,
  output [31:0]  io_sum_out_7,
  output [31:0]  io_sum_out_8,
  output [31:0]  io_sum_out_9,
  output [31:0]  io_sum_out_10,
  output [31:0]  io_sum_out_11,
  output [31:0]  io_sum_out_12,
  output [31:0]  io_sum_out_13,
  output [31:0]  io_sum_out_14,
  output [31:0]  io_sum_out_15,
  output [31:0]  io_sum_out_16,
  output [31:0]  io_sum_out_17,
  output [31:0]  io_sum_out_18,
  output [31:0]  io_sum_out_19,
  output [31:0]  io_sum_out_20,
  output [31:0]  io_sum_out_21,
  output [31:0]  io_sum_out_22,
  output [31:0]  io_sum_out_23,
  output [31:0]  io_sum_out_24,
  output [31:0]  io_sum_out_25,
  output [31:0]  io_sum_out_26,
  output [31:0]  io_sum_out_27,
  output [31:0]  io_sum_out_28,
  output [31:0]  io_sum_out_29,
  output [31:0]  io_sum_out_30,
  output [31:0]  io_sum_out_31,
  output [31:0]  io_sum_out_32,
  output [31:0]  io_sum_out_33,
  output [31:0]  io_sum_out_34,
  output [31:0]  io_sum_out_35,
  output [31:0]  io_sum_out_36,
  output [31:0]  io_sum_out_37,
  output [31:0]  io_sum_out_38,
  output [31:0]  io_sum_out_39,
  output [31:0]  io_sum_out_40,
  output [31:0]  io_sum_out_41,
  output [31:0]  io_sum_out_42,
  output [31:0]  io_sum_out_43,
  output [31:0]  io_sum_out_44,
  output [31:0]  io_sum_out_45,
  output [31:0]  io_sum_out_46,
  output [31:0]  io_sum_out_47,
  output [31:0]  io_sum_out_48,
  output [31:0]  io_sum_out_49,
  output [31:0]  io_sum_out_50,
  output [31:0]  io_sum_out_51,
  output [31:0]  io_sum_out_52,
  output [31:0]  io_sum_out_53,
  output [31:0]  io_sum_out_54,
  output [31:0]  io_sum_out_55,
  output [31:0]  io_sum_out_56,
  output [31:0]  io_sum_out_57,
  output [31:0]  io_sum_out_58,
  output [31:0]  io_sum_out_59,
  output [31:0]  io_sum_out_60,
  output [31:0]  io_sum_out_61,
  output [31:0]  io_sum_out_62,
  output [31:0]  io_sum_out_63
);
  wire  U_ConV_FSM_clock; // @[top.scala 22:26]
  wire  U_ConV_FSM_reset; // @[top.scala 22:26]
  wire  U_ConV_FSM_io_din_valid_ConV; // @[top.scala 22:26]
  wire  U_ConV_FSM_io_ifm_buffer_ready; // @[top.scala 22:26]
  wire [4:0] U_ConV_FSM_io_Current_state; // @[top.scala 22:26]
  wire  U_ConV_FSM_io_dout_valid_ConV; // @[top.scala 22:26]
  wire  U_ConV_FSM_io_buffer_busy; // @[top.scala 22:26]
  wire [127:0] U_Mux_datainarray_io_IN_0; // @[top.scala 37:33]
  wire [127:0] U_Mux_datainarray_io_IN_1; // @[top.scala 37:33]
  wire [127:0] U_Mux_datainarray_io_IN_Array_0; // @[top.scala 37:33]
  wire [127:0] U_Mux_datainarray_io_IN_Array_1; // @[top.scala 37:33]
  wire [127:0] U_Mux_datainarray_io_IN_Array_2; // @[top.scala 37:33]
  wire [127:0] U_Mux_datainarray_io_IN_Array_3; // @[top.scala 37:33]
  wire  Tile_clock; // @[top.scala 44:50]
  wire [127:0] Tile_io_WL; // @[top.scala 44:50]
  wire [127:0] Tile_io_IN_0; // @[top.scala 44:50]
  wire [127:0] Tile_io_IN_1; // @[top.scala 44:50]
  wire [127:0] Tile_io_IN_2; // @[top.scala 44:50]
  wire [127:0] Tile_io_IN_3; // @[top.scala 44:50]
  wire [127:0] Tile_io_BL_0; // @[top.scala 44:50]
  wire [127:0] Tile_io_BL_1; // @[top.scala 44:50]
  wire [127:0] Tile_io_BL_2; // @[top.scala 44:50]
  wire [127:0] Tile_io_BL_3; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_0; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_1; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_2; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_3; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_4; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_5; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_6; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_7; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_8; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_9; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_10; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_11; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_12; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_13; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_14; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_15; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_16; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_17; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_18; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_19; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_20; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_21; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_22; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_23; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_24; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_25; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_26; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_27; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_28; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_29; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_30; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_31; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_32; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_33; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_34; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_35; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_36; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_37; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_38; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_39; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_40; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_41; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_42; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_43; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_44; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_45; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_46; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_47; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_48; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_49; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_50; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_51; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_52; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_53; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_54; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_55; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_56; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_57; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_58; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_59; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_60; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_61; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_62; // @[top.scala 44:50]
  wire [14:0] Tile_io_MAC_63; // @[top.scala 44:50]
  wire  ConV_8x8_Tile_clock; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_0; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_1; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_2; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_3; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_4; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_5; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_6; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_7; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_8; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_9; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_10; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_11; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_12; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_13; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_14; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_15; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_16; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_17; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_18; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_19; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_20; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_21; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_22; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_23; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_24; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_25; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_26; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_27; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_28; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_29; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_30; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_31; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_32; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_33; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_34; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_35; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_36; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_37; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_38; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_39; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_40; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_41; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_42; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_43; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_44; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_45; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_46; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_47; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_48; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_49; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_50; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_51; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_52; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_53; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_54; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_55; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_56; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_57; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_58; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_59; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_60; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_61; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_62; // @[top.scala 75:59]
  wire [14:0] ConV_8x8_Tile_io_d_in_63; // @[top.scala 75:59]
  wire [4:0] ConV_8x8_Tile_io_Current_state; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_0; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_1; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_2; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_3; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_4; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_5; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_6; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_7; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_8; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_9; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_10; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_11; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_12; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_13; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_14; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_15; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_16; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_17; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_18; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_19; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_20; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_21; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_22; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_23; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_24; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_25; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_26; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_27; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_28; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_29; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_30; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_31; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_32; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_33; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_34; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_35; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_36; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_37; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_38; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_39; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_40; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_41; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_42; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_43; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_44; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_45; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_46; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_47; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_48; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_49; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_50; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_51; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_52; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_53; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_54; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_55; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_56; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_57; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_58; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_59; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_60; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_61; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_62; // @[top.scala 75:59]
  wire [31:0] ConV_8x8_Tile_io_sum_63; // @[top.scala 75:59]
  ConV_FSM U_ConV_FSM ( // @[top.scala 22:26]
    .clock(U_ConV_FSM_clock),
    .reset(U_ConV_FSM_reset),
    .io_din_valid_ConV(U_ConV_FSM_io_din_valid_ConV),
    .io_ifm_buffer_ready(U_ConV_FSM_io_ifm_buffer_ready),
    .io_Current_state(U_ConV_FSM_io_Current_state),
    .io_dout_valid_ConV(U_ConV_FSM_io_dout_valid_ConV),
    .io_buffer_busy(U_ConV_FSM_io_buffer_busy)
  );
  Mux_datainarray U_Mux_datainarray ( // @[top.scala 37:33]
    .io_IN_0(U_Mux_datainarray_io_IN_0),
    .io_IN_1(U_Mux_datainarray_io_IN_1),
    .io_IN_Array_0(U_Mux_datainarray_io_IN_Array_0),
    .io_IN_Array_1(U_Mux_datainarray_io_IN_Array_1),
    .io_IN_Array_2(U_Mux_datainarray_io_IN_Array_2),
    .io_IN_Array_3(U_Mux_datainarray_io_IN_Array_3)
  );
  Tile Tile ( // @[top.scala 44:50]
    .clock(Tile_clock),
    .io_WL(Tile_io_WL),
    .io_IN_0(Tile_io_IN_0),
    .io_IN_1(Tile_io_IN_1),
    .io_IN_2(Tile_io_IN_2),
    .io_IN_3(Tile_io_IN_3),
    .io_BL_0(Tile_io_BL_0),
    .io_BL_1(Tile_io_BL_1),
    .io_BL_2(Tile_io_BL_2),
    .io_BL_3(Tile_io_BL_3),
    .io_MAC_0(Tile_io_MAC_0),
    .io_MAC_1(Tile_io_MAC_1),
    .io_MAC_2(Tile_io_MAC_2),
    .io_MAC_3(Tile_io_MAC_3),
    .io_MAC_4(Tile_io_MAC_4),
    .io_MAC_5(Tile_io_MAC_5),
    .io_MAC_6(Tile_io_MAC_6),
    .io_MAC_7(Tile_io_MAC_7),
    .io_MAC_8(Tile_io_MAC_8),
    .io_MAC_9(Tile_io_MAC_9),
    .io_MAC_10(Tile_io_MAC_10),
    .io_MAC_11(Tile_io_MAC_11),
    .io_MAC_12(Tile_io_MAC_12),
    .io_MAC_13(Tile_io_MAC_13),
    .io_MAC_14(Tile_io_MAC_14),
    .io_MAC_15(Tile_io_MAC_15),
    .io_MAC_16(Tile_io_MAC_16),
    .io_MAC_17(Tile_io_MAC_17),
    .io_MAC_18(Tile_io_MAC_18),
    .io_MAC_19(Tile_io_MAC_19),
    .io_MAC_20(Tile_io_MAC_20),
    .io_MAC_21(Tile_io_MAC_21),
    .io_MAC_22(Tile_io_MAC_22),
    .io_MAC_23(Tile_io_MAC_23),
    .io_MAC_24(Tile_io_MAC_24),
    .io_MAC_25(Tile_io_MAC_25),
    .io_MAC_26(Tile_io_MAC_26),
    .io_MAC_27(Tile_io_MAC_27),
    .io_MAC_28(Tile_io_MAC_28),
    .io_MAC_29(Tile_io_MAC_29),
    .io_MAC_30(Tile_io_MAC_30),
    .io_MAC_31(Tile_io_MAC_31),
    .io_MAC_32(Tile_io_MAC_32),
    .io_MAC_33(Tile_io_MAC_33),
    .io_MAC_34(Tile_io_MAC_34),
    .io_MAC_35(Tile_io_MAC_35),
    .io_MAC_36(Tile_io_MAC_36),
    .io_MAC_37(Tile_io_MAC_37),
    .io_MAC_38(Tile_io_MAC_38),
    .io_MAC_39(Tile_io_MAC_39),
    .io_MAC_40(Tile_io_MAC_40),
    .io_MAC_41(Tile_io_MAC_41),
    .io_MAC_42(Tile_io_MAC_42),
    .io_MAC_43(Tile_io_MAC_43),
    .io_MAC_44(Tile_io_MAC_44),
    .io_MAC_45(Tile_io_MAC_45),
    .io_MAC_46(Tile_io_MAC_46),
    .io_MAC_47(Tile_io_MAC_47),
    .io_MAC_48(Tile_io_MAC_48),
    .io_MAC_49(Tile_io_MAC_49),
    .io_MAC_50(Tile_io_MAC_50),
    .io_MAC_51(Tile_io_MAC_51),
    .io_MAC_52(Tile_io_MAC_52),
    .io_MAC_53(Tile_io_MAC_53),
    .io_MAC_54(Tile_io_MAC_54),
    .io_MAC_55(Tile_io_MAC_55),
    .io_MAC_56(Tile_io_MAC_56),
    .io_MAC_57(Tile_io_MAC_57),
    .io_MAC_58(Tile_io_MAC_58),
    .io_MAC_59(Tile_io_MAC_59),
    .io_MAC_60(Tile_io_MAC_60),
    .io_MAC_61(Tile_io_MAC_61),
    .io_MAC_62(Tile_io_MAC_62),
    .io_MAC_63(Tile_io_MAC_63)
  );
  ConV_8x8_Tile ConV_8x8_Tile ( // @[top.scala 75:59]
    .clock(ConV_8x8_Tile_clock),
    .io_d_in_0(ConV_8x8_Tile_io_d_in_0),
    .io_d_in_1(ConV_8x8_Tile_io_d_in_1),
    .io_d_in_2(ConV_8x8_Tile_io_d_in_2),
    .io_d_in_3(ConV_8x8_Tile_io_d_in_3),
    .io_d_in_4(ConV_8x8_Tile_io_d_in_4),
    .io_d_in_5(ConV_8x8_Tile_io_d_in_5),
    .io_d_in_6(ConV_8x8_Tile_io_d_in_6),
    .io_d_in_7(ConV_8x8_Tile_io_d_in_7),
    .io_d_in_8(ConV_8x8_Tile_io_d_in_8),
    .io_d_in_9(ConV_8x8_Tile_io_d_in_9),
    .io_d_in_10(ConV_8x8_Tile_io_d_in_10),
    .io_d_in_11(ConV_8x8_Tile_io_d_in_11),
    .io_d_in_12(ConV_8x8_Tile_io_d_in_12),
    .io_d_in_13(ConV_8x8_Tile_io_d_in_13),
    .io_d_in_14(ConV_8x8_Tile_io_d_in_14),
    .io_d_in_15(ConV_8x8_Tile_io_d_in_15),
    .io_d_in_16(ConV_8x8_Tile_io_d_in_16),
    .io_d_in_17(ConV_8x8_Tile_io_d_in_17),
    .io_d_in_18(ConV_8x8_Tile_io_d_in_18),
    .io_d_in_19(ConV_8x8_Tile_io_d_in_19),
    .io_d_in_20(ConV_8x8_Tile_io_d_in_20),
    .io_d_in_21(ConV_8x8_Tile_io_d_in_21),
    .io_d_in_22(ConV_8x8_Tile_io_d_in_22),
    .io_d_in_23(ConV_8x8_Tile_io_d_in_23),
    .io_d_in_24(ConV_8x8_Tile_io_d_in_24),
    .io_d_in_25(ConV_8x8_Tile_io_d_in_25),
    .io_d_in_26(ConV_8x8_Tile_io_d_in_26),
    .io_d_in_27(ConV_8x8_Tile_io_d_in_27),
    .io_d_in_28(ConV_8x8_Tile_io_d_in_28),
    .io_d_in_29(ConV_8x8_Tile_io_d_in_29),
    .io_d_in_30(ConV_8x8_Tile_io_d_in_30),
    .io_d_in_31(ConV_8x8_Tile_io_d_in_31),
    .io_d_in_32(ConV_8x8_Tile_io_d_in_32),
    .io_d_in_33(ConV_8x8_Tile_io_d_in_33),
    .io_d_in_34(ConV_8x8_Tile_io_d_in_34),
    .io_d_in_35(ConV_8x8_Tile_io_d_in_35),
    .io_d_in_36(ConV_8x8_Tile_io_d_in_36),
    .io_d_in_37(ConV_8x8_Tile_io_d_in_37),
    .io_d_in_38(ConV_8x8_Tile_io_d_in_38),
    .io_d_in_39(ConV_8x8_Tile_io_d_in_39),
    .io_d_in_40(ConV_8x8_Tile_io_d_in_40),
    .io_d_in_41(ConV_8x8_Tile_io_d_in_41),
    .io_d_in_42(ConV_8x8_Tile_io_d_in_42),
    .io_d_in_43(ConV_8x8_Tile_io_d_in_43),
    .io_d_in_44(ConV_8x8_Tile_io_d_in_44),
    .io_d_in_45(ConV_8x8_Tile_io_d_in_45),
    .io_d_in_46(ConV_8x8_Tile_io_d_in_46),
    .io_d_in_47(ConV_8x8_Tile_io_d_in_47),
    .io_d_in_48(ConV_8x8_Tile_io_d_in_48),
    .io_d_in_49(ConV_8x8_Tile_io_d_in_49),
    .io_d_in_50(ConV_8x8_Tile_io_d_in_50),
    .io_d_in_51(ConV_8x8_Tile_io_d_in_51),
    .io_d_in_52(ConV_8x8_Tile_io_d_in_52),
    .io_d_in_53(ConV_8x8_Tile_io_d_in_53),
    .io_d_in_54(ConV_8x8_Tile_io_d_in_54),
    .io_d_in_55(ConV_8x8_Tile_io_d_in_55),
    .io_d_in_56(ConV_8x8_Tile_io_d_in_56),
    .io_d_in_57(ConV_8x8_Tile_io_d_in_57),
    .io_d_in_58(ConV_8x8_Tile_io_d_in_58),
    .io_d_in_59(ConV_8x8_Tile_io_d_in_59),
    .io_d_in_60(ConV_8x8_Tile_io_d_in_60),
    .io_d_in_61(ConV_8x8_Tile_io_d_in_61),
    .io_d_in_62(ConV_8x8_Tile_io_d_in_62),
    .io_d_in_63(ConV_8x8_Tile_io_d_in_63),
    .io_Current_state(ConV_8x8_Tile_io_Current_state),
    .io_sum_0(ConV_8x8_Tile_io_sum_0),
    .io_sum_1(ConV_8x8_Tile_io_sum_1),
    .io_sum_2(ConV_8x8_Tile_io_sum_2),
    .io_sum_3(ConV_8x8_Tile_io_sum_3),
    .io_sum_4(ConV_8x8_Tile_io_sum_4),
    .io_sum_5(ConV_8x8_Tile_io_sum_5),
    .io_sum_6(ConV_8x8_Tile_io_sum_6),
    .io_sum_7(ConV_8x8_Tile_io_sum_7),
    .io_sum_8(ConV_8x8_Tile_io_sum_8),
    .io_sum_9(ConV_8x8_Tile_io_sum_9),
    .io_sum_10(ConV_8x8_Tile_io_sum_10),
    .io_sum_11(ConV_8x8_Tile_io_sum_11),
    .io_sum_12(ConV_8x8_Tile_io_sum_12),
    .io_sum_13(ConV_8x8_Tile_io_sum_13),
    .io_sum_14(ConV_8x8_Tile_io_sum_14),
    .io_sum_15(ConV_8x8_Tile_io_sum_15),
    .io_sum_16(ConV_8x8_Tile_io_sum_16),
    .io_sum_17(ConV_8x8_Tile_io_sum_17),
    .io_sum_18(ConV_8x8_Tile_io_sum_18),
    .io_sum_19(ConV_8x8_Tile_io_sum_19),
    .io_sum_20(ConV_8x8_Tile_io_sum_20),
    .io_sum_21(ConV_8x8_Tile_io_sum_21),
    .io_sum_22(ConV_8x8_Tile_io_sum_22),
    .io_sum_23(ConV_8x8_Tile_io_sum_23),
    .io_sum_24(ConV_8x8_Tile_io_sum_24),
    .io_sum_25(ConV_8x8_Tile_io_sum_25),
    .io_sum_26(ConV_8x8_Tile_io_sum_26),
    .io_sum_27(ConV_8x8_Tile_io_sum_27),
    .io_sum_28(ConV_8x8_Tile_io_sum_28),
    .io_sum_29(ConV_8x8_Tile_io_sum_29),
    .io_sum_30(ConV_8x8_Tile_io_sum_30),
    .io_sum_31(ConV_8x8_Tile_io_sum_31),
    .io_sum_32(ConV_8x8_Tile_io_sum_32),
    .io_sum_33(ConV_8x8_Tile_io_sum_33),
    .io_sum_34(ConV_8x8_Tile_io_sum_34),
    .io_sum_35(ConV_8x8_Tile_io_sum_35),
    .io_sum_36(ConV_8x8_Tile_io_sum_36),
    .io_sum_37(ConV_8x8_Tile_io_sum_37),
    .io_sum_38(ConV_8x8_Tile_io_sum_38),
    .io_sum_39(ConV_8x8_Tile_io_sum_39),
    .io_sum_40(ConV_8x8_Tile_io_sum_40),
    .io_sum_41(ConV_8x8_Tile_io_sum_41),
    .io_sum_42(ConV_8x8_Tile_io_sum_42),
    .io_sum_43(ConV_8x8_Tile_io_sum_43),
    .io_sum_44(ConV_8x8_Tile_io_sum_44),
    .io_sum_45(ConV_8x8_Tile_io_sum_45),
    .io_sum_46(ConV_8x8_Tile_io_sum_46),
    .io_sum_47(ConV_8x8_Tile_io_sum_47),
    .io_sum_48(ConV_8x8_Tile_io_sum_48),
    .io_sum_49(ConV_8x8_Tile_io_sum_49),
    .io_sum_50(ConV_8x8_Tile_io_sum_50),
    .io_sum_51(ConV_8x8_Tile_io_sum_51),
    .io_sum_52(ConV_8x8_Tile_io_sum_52),
    .io_sum_53(ConV_8x8_Tile_io_sum_53),
    .io_sum_54(ConV_8x8_Tile_io_sum_54),
    .io_sum_55(ConV_8x8_Tile_io_sum_55),
    .io_sum_56(ConV_8x8_Tile_io_sum_56),
    .io_sum_57(ConV_8x8_Tile_io_sum_57),
    .io_sum_58(ConV_8x8_Tile_io_sum_58),
    .io_sum_59(ConV_8x8_Tile_io_sum_59),
    .io_sum_60(ConV_8x8_Tile_io_sum_60),
    .io_sum_61(ConV_8x8_Tile_io_sum_61),
    .io_sum_62(ConV_8x8_Tile_io_sum_62),
    .io_sum_63(ConV_8x8_Tile_io_sum_63)
  );
  assign io_dout_valid_ConV = U_ConV_FSM_io_dout_valid_ConV; // @[top.scala 31:22]
  assign io_buffer_busy = U_ConV_FSM_io_buffer_busy; // @[top.scala 26:24]
  assign io_sum_out_0 = ConV_8x8_Tile_io_sum_0; // @[top.scala 75:{32,32}]
  assign io_sum_out_1 = ConV_8x8_Tile_io_sum_1; // @[top.scala 75:{32,32}]
  assign io_sum_out_2 = ConV_8x8_Tile_io_sum_2; // @[top.scala 75:{32,32}]
  assign io_sum_out_3 = ConV_8x8_Tile_io_sum_3; // @[top.scala 75:{32,32}]
  assign io_sum_out_4 = ConV_8x8_Tile_io_sum_4; // @[top.scala 75:{32,32}]
  assign io_sum_out_5 = ConV_8x8_Tile_io_sum_5; // @[top.scala 75:{32,32}]
  assign io_sum_out_6 = ConV_8x8_Tile_io_sum_6; // @[top.scala 75:{32,32}]
  assign io_sum_out_7 = ConV_8x8_Tile_io_sum_7; // @[top.scala 75:{32,32}]
  assign io_sum_out_8 = ConV_8x8_Tile_io_sum_8; // @[top.scala 75:{32,32}]
  assign io_sum_out_9 = ConV_8x8_Tile_io_sum_9; // @[top.scala 75:{32,32}]
  assign io_sum_out_10 = ConV_8x8_Tile_io_sum_10; // @[top.scala 75:{32,32}]
  assign io_sum_out_11 = ConV_8x8_Tile_io_sum_11; // @[top.scala 75:{32,32}]
  assign io_sum_out_12 = ConV_8x8_Tile_io_sum_12; // @[top.scala 75:{32,32}]
  assign io_sum_out_13 = ConV_8x8_Tile_io_sum_13; // @[top.scala 75:{32,32}]
  assign io_sum_out_14 = ConV_8x8_Tile_io_sum_14; // @[top.scala 75:{32,32}]
  assign io_sum_out_15 = ConV_8x8_Tile_io_sum_15; // @[top.scala 75:{32,32}]
  assign io_sum_out_16 = ConV_8x8_Tile_io_sum_16; // @[top.scala 75:{32,32}]
  assign io_sum_out_17 = ConV_8x8_Tile_io_sum_17; // @[top.scala 75:{32,32}]
  assign io_sum_out_18 = ConV_8x8_Tile_io_sum_18; // @[top.scala 75:{32,32}]
  assign io_sum_out_19 = ConV_8x8_Tile_io_sum_19; // @[top.scala 75:{32,32}]
  assign io_sum_out_20 = ConV_8x8_Tile_io_sum_20; // @[top.scala 75:{32,32}]
  assign io_sum_out_21 = ConV_8x8_Tile_io_sum_21; // @[top.scala 75:{32,32}]
  assign io_sum_out_22 = ConV_8x8_Tile_io_sum_22; // @[top.scala 75:{32,32}]
  assign io_sum_out_23 = ConV_8x8_Tile_io_sum_23; // @[top.scala 75:{32,32}]
  assign io_sum_out_24 = ConV_8x8_Tile_io_sum_24; // @[top.scala 75:{32,32}]
  assign io_sum_out_25 = ConV_8x8_Tile_io_sum_25; // @[top.scala 75:{32,32}]
  assign io_sum_out_26 = ConV_8x8_Tile_io_sum_26; // @[top.scala 75:{32,32}]
  assign io_sum_out_27 = ConV_8x8_Tile_io_sum_27; // @[top.scala 75:{32,32}]
  assign io_sum_out_28 = ConV_8x8_Tile_io_sum_28; // @[top.scala 75:{32,32}]
  assign io_sum_out_29 = ConV_8x8_Tile_io_sum_29; // @[top.scala 75:{32,32}]
  assign io_sum_out_30 = ConV_8x8_Tile_io_sum_30; // @[top.scala 75:{32,32}]
  assign io_sum_out_31 = ConV_8x8_Tile_io_sum_31; // @[top.scala 75:{32,32}]
  assign io_sum_out_32 = ConV_8x8_Tile_io_sum_32; // @[top.scala 75:{32,32}]
  assign io_sum_out_33 = ConV_8x8_Tile_io_sum_33; // @[top.scala 75:{32,32}]
  assign io_sum_out_34 = ConV_8x8_Tile_io_sum_34; // @[top.scala 75:{32,32}]
  assign io_sum_out_35 = ConV_8x8_Tile_io_sum_35; // @[top.scala 75:{32,32}]
  assign io_sum_out_36 = ConV_8x8_Tile_io_sum_36; // @[top.scala 75:{32,32}]
  assign io_sum_out_37 = ConV_8x8_Tile_io_sum_37; // @[top.scala 75:{32,32}]
  assign io_sum_out_38 = ConV_8x8_Tile_io_sum_38; // @[top.scala 75:{32,32}]
  assign io_sum_out_39 = ConV_8x8_Tile_io_sum_39; // @[top.scala 75:{32,32}]
  assign io_sum_out_40 = ConV_8x8_Tile_io_sum_40; // @[top.scala 75:{32,32}]
  assign io_sum_out_41 = ConV_8x8_Tile_io_sum_41; // @[top.scala 75:{32,32}]
  assign io_sum_out_42 = ConV_8x8_Tile_io_sum_42; // @[top.scala 75:{32,32}]
  assign io_sum_out_43 = ConV_8x8_Tile_io_sum_43; // @[top.scala 75:{32,32}]
  assign io_sum_out_44 = ConV_8x8_Tile_io_sum_44; // @[top.scala 75:{32,32}]
  assign io_sum_out_45 = ConV_8x8_Tile_io_sum_45; // @[top.scala 75:{32,32}]
  assign io_sum_out_46 = ConV_8x8_Tile_io_sum_46; // @[top.scala 75:{32,32}]
  assign io_sum_out_47 = ConV_8x8_Tile_io_sum_47; // @[top.scala 75:{32,32}]
  assign io_sum_out_48 = ConV_8x8_Tile_io_sum_48; // @[top.scala 75:{32,32}]
  assign io_sum_out_49 = ConV_8x8_Tile_io_sum_49; // @[top.scala 75:{32,32}]
  assign io_sum_out_50 = ConV_8x8_Tile_io_sum_50; // @[top.scala 75:{32,32}]
  assign io_sum_out_51 = ConV_8x8_Tile_io_sum_51; // @[top.scala 75:{32,32}]
  assign io_sum_out_52 = ConV_8x8_Tile_io_sum_52; // @[top.scala 75:{32,32}]
  assign io_sum_out_53 = ConV_8x8_Tile_io_sum_53; // @[top.scala 75:{32,32}]
  assign io_sum_out_54 = ConV_8x8_Tile_io_sum_54; // @[top.scala 75:{32,32}]
  assign io_sum_out_55 = ConV_8x8_Tile_io_sum_55; // @[top.scala 75:{32,32}]
  assign io_sum_out_56 = ConV_8x8_Tile_io_sum_56; // @[top.scala 75:{32,32}]
  assign io_sum_out_57 = ConV_8x8_Tile_io_sum_57; // @[top.scala 75:{32,32}]
  assign io_sum_out_58 = ConV_8x8_Tile_io_sum_58; // @[top.scala 75:{32,32}]
  assign io_sum_out_59 = ConV_8x8_Tile_io_sum_59; // @[top.scala 75:{32,32}]
  assign io_sum_out_60 = ConV_8x8_Tile_io_sum_60; // @[top.scala 75:{32,32}]
  assign io_sum_out_61 = ConV_8x8_Tile_io_sum_61; // @[top.scala 75:{32,32}]
  assign io_sum_out_62 = ConV_8x8_Tile_io_sum_62; // @[top.scala 75:{32,32}]
  assign io_sum_out_63 = ConV_8x8_Tile_io_sum_63; // @[top.scala 75:{32,32}]
  assign U_ConV_FSM_clock = clock;
  assign U_ConV_FSM_reset = reset;
  assign U_ConV_FSM_io_din_valid_ConV = io_din_valid_ConV; // @[top.scala 23:32]
  assign U_ConV_FSM_io_ifm_buffer_ready = io_ifm_buffer_ready; // @[top.scala 25:40]
  assign U_Mux_datainarray_io_IN_0 = io_IN_0; // @[top.scala 38:27]
  assign U_Mux_datainarray_io_IN_1 = io_IN_1; // @[top.scala 38:27]
  assign Tile_clock = clock;
  assign Tile_io_WL = io_WL; // @[top.scala 44:23 47:18]
  assign Tile_io_IN_0 = U_Mux_datainarray_io_IN_Array_0; // @[top.scala 36:22 39:12]
  assign Tile_io_IN_1 = U_Mux_datainarray_io_IN_Array_1; // @[top.scala 36:22 39:12]
  assign Tile_io_IN_2 = U_Mux_datainarray_io_IN_Array_2; // @[top.scala 36:22 39:12]
  assign Tile_io_IN_3 = U_Mux_datainarray_io_IN_Array_3; // @[top.scala 36:22 39:12]
  assign Tile_io_BL_0 = io_BL_3; // @[top.scala 44:23 49:23]
  assign Tile_io_BL_1 = io_BL_2; // @[top.scala 44:23 49:23]
  assign Tile_io_BL_2 = io_BL_1; // @[top.scala 44:23 49:23]
  assign Tile_io_BL_3 = io_BL_0; // @[top.scala 44:23 49:23]
  assign ConV_8x8_Tile_clock = clock;
  assign ConV_8x8_Tile_io_d_in_0 = Tile_io_MAC_0; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_1 = Tile_io_MAC_1; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_2 = Tile_io_MAC_2; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_3 = Tile_io_MAC_3; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_4 = Tile_io_MAC_4; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_5 = Tile_io_MAC_5; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_6 = Tile_io_MAC_6; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_7 = Tile_io_MAC_7; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_8 = Tile_io_MAC_8; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_9 = Tile_io_MAC_9; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_10 = Tile_io_MAC_10; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_11 = Tile_io_MAC_11; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_12 = Tile_io_MAC_12; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_13 = Tile_io_MAC_13; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_14 = Tile_io_MAC_14; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_15 = Tile_io_MAC_15; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_16 = Tile_io_MAC_16; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_17 = Tile_io_MAC_17; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_18 = Tile_io_MAC_18; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_19 = Tile_io_MAC_19; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_20 = Tile_io_MAC_20; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_21 = Tile_io_MAC_21; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_22 = Tile_io_MAC_22; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_23 = Tile_io_MAC_23; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_24 = Tile_io_MAC_24; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_25 = Tile_io_MAC_25; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_26 = Tile_io_MAC_26; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_27 = Tile_io_MAC_27; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_28 = Tile_io_MAC_28; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_29 = Tile_io_MAC_29; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_30 = Tile_io_MAC_30; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_31 = Tile_io_MAC_31; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_32 = Tile_io_MAC_32; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_33 = Tile_io_MAC_33; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_34 = Tile_io_MAC_34; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_35 = Tile_io_MAC_35; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_36 = Tile_io_MAC_36; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_37 = Tile_io_MAC_37; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_38 = Tile_io_MAC_38; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_39 = Tile_io_MAC_39; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_40 = Tile_io_MAC_40; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_41 = Tile_io_MAC_41; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_42 = Tile_io_MAC_42; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_43 = Tile_io_MAC_43; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_44 = Tile_io_MAC_44; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_45 = Tile_io_MAC_45; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_46 = Tile_io_MAC_46; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_47 = Tile_io_MAC_47; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_48 = Tile_io_MAC_48; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_49 = Tile_io_MAC_49; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_50 = Tile_io_MAC_50; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_51 = Tile_io_MAC_51; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_52 = Tile_io_MAC_52; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_53 = Tile_io_MAC_53; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_54 = Tile_io_MAC_54; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_55 = Tile_io_MAC_55; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_56 = Tile_io_MAC_56; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_57 = Tile_io_MAC_57; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_58 = Tile_io_MAC_58; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_59 = Tile_io_MAC_59; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_60 = Tile_io_MAC_60; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_61 = Tile_io_MAC_61; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_62 = Tile_io_MAC_62; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_d_in_63 = Tile_io_MAC_63; // @[top.scala 44:{23,23}]
  assign ConV_8x8_Tile_io_Current_state = U_ConV_FSM_io_Current_state; // @[top.scala 21:27 30:17]
endmodule
module top(
  input          clock,
  input          reset,
  input          io_din_valid_ConV,
  output         io_dout_valid_ConV,
  input          io_input_data_valid,
  input          io_wgt_data_valid,
  output         io_wgt_buffer_done,
  output         io_ofm_buffer_done,
  output         io_buffer_busy,
  output         io_axi_ch1_m_arid,
  output [63:0]  io_axi_ch1_m_araddr,
  output [7:0]   io_axi_ch1_m_arlen,
  output [2:0]   io_axi_ch1_m_arsize,
  output [1:0]   io_axi_ch1_m_arburst,
  output         io_axi_ch1_m_arlock,
  output [3:0]   io_axi_ch1_m_arcache,
  output [2:0]   io_axi_ch1_m_arprot,
  output [3:0]   io_axi_ch1_m_arqos,
  output         io_axi_ch1_m_arvalid,
  input          io_axi_ch1_m_arready,
  input          io_axi_ch1_m_rid,
  input  [127:0] io_axi_ch1_m_rdata,
  input  [1:0]   io_axi_ch1_m_rresp,
  input          io_axi_ch1_m_rlast,
  input          io_axi_ch1_m_rvalid,
  output         io_axi_ch1_m_rready,
  output         io_axi_ch1_m_awid,
  output [63:0]  io_axi_ch1_m_awaddr,
  output [7:0]   io_axi_ch1_m_awlen,
  output [2:0]   io_axi_ch1_m_awsize,
  output [1:0]   io_axi_ch1_m_awburst,
  output         io_axi_ch1_m_awlock,
  output [3:0]   io_axi_ch1_m_awcache,
  output [2:0]   io_axi_ch1_m_awprot,
  output [3:0]   io_axi_ch1_m_awqos,
  output         io_axi_ch1_m_awvalid,
  input          io_axi_ch1_m_awready,
  output         io_axi_ch1_m_wid,
  output [127:0] io_axi_ch1_m_wdata,
  output [15:0]  io_axi_ch1_m_wstrb,
  output         io_axi_ch1_m_wlast,
  output         io_axi_ch1_m_wvalid,
  input          io_axi_ch1_m_wready,
  input          io_axi_ch1_m_bid,
  input  [1:0]   io_axi_ch1_m_bresp,
  input          io_axi_ch1_m_bvalid,
  output         io_axi_ch1_m_bready,
  output         io_axi_ch2_m_arid,
  output [63:0]  io_axi_ch2_m_araddr,
  output [7:0]   io_axi_ch2_m_arlen,
  output [2:0]   io_axi_ch2_m_arsize,
  output [1:0]   io_axi_ch2_m_arburst,
  output         io_axi_ch2_m_arlock,
  output [3:0]   io_axi_ch2_m_arcache,
  output [2:0]   io_axi_ch2_m_arprot,
  output [3:0]   io_axi_ch2_m_arqos,
  output         io_axi_ch2_m_arvalid,
  input          io_axi_ch2_m_arready,
  input          io_axi_ch2_m_rid,
  input  [127:0] io_axi_ch2_m_rdata,
  input  [1:0]   io_axi_ch2_m_rresp,
  input          io_axi_ch2_m_rlast,
  input          io_axi_ch2_m_rvalid,
  output         io_axi_ch2_m_rready,
  output         io_axi_ch2_m_awid,
  output [63:0]  io_axi_ch2_m_awaddr,
  output [7:0]   io_axi_ch2_m_awlen,
  output [2:0]   io_axi_ch2_m_awsize,
  output [1:0]   io_axi_ch2_m_awburst,
  output         io_axi_ch2_m_awlock,
  output [3:0]   io_axi_ch2_m_awcache,
  output [2:0]   io_axi_ch2_m_awprot,
  output [3:0]   io_axi_ch2_m_awqos,
  output         io_axi_ch2_m_awvalid,
  input          io_axi_ch2_m_awready,
  output         io_axi_ch2_m_wid,
  output [127:0] io_axi_ch2_m_wdata,
  output [15:0]  io_axi_ch2_m_wstrb,
  output         io_axi_ch2_m_wlast,
  output         io_axi_ch2_m_wvalid,
  input          io_axi_ch2_m_wready,
  input          io_axi_ch2_m_bid,
  input  [1:0]   io_axi_ch2_m_bresp,
  input          io_axi_ch2_m_bvalid,
  output         io_axi_ch2_m_bready,
  output         io_test3,
  output         io_test6,
  output         io_test9,
  output         io_test12,
  output         io_test15,
  input          io_dma_ch0_r_dmaEn,
  input          io_dma_ch0_r_dmaAreq,
  input  [31:0]  io_dma_ch0_r_dmaSize,
  input  [63:0]  io_dma_ch0_r_dmaAddr,
  input          io_dma_ch1_r_dmaEn,
  input          io_dma_ch1_r_dmaAreq,
  input  [31:0]  io_dma_ch1_r_dmaSize,
  input  [63:0]  io_dma_ch1_r_dmaAddr,
  input          io_dma_ch0_w_dmaEn,
  input          io_dma_ch0_w_dmaAreq,
  input  [31:0]  io_dma_ch0_w_dmaSize,
  input  [63:0]  io_dma_ch0_w_dmaAddr,
  input          io_dma_ch1_w_dmaEn,
  input          io_dma_ch1_w_dmaAreq,
  input  [31:0]  io_dma_ch1_w_dmaSize,
  input  [63:0]  io_dma_ch1_w_dmaAddr,
  input  [31:0]  io_sim_alu_reg_mathfunc_ctrl_reg,
  input  [31:0]  io_sim_alu_reg_actfunc_ctrl_reg,
  input  [31:0]  io_sim_alu_reg_alu_veclen_ch0_reg,
  input  [63:0]  io_sim_alu_reg_src0_addr_ch0_reg,
  input  [63:0]  io_sim_alu_reg_src1_addr_ch0_reg,
  input  [63:0]  io_sim_alu_reg_dst_addr_ch0_reg,
  input  [31:0]  io_sim_alu_reg_alu_veclen_ch1_reg,
  input  [63:0]  io_sim_alu_reg_src0_addr_ch1_reg,
  input  [63:0]  io_sim_alu_reg_src1_addr_ch1_reg,
  input  [63:0]  io_sim_alu_reg_dst_addr_ch1_reg,
  input  [31:0]  io_sim_alu_reg_math_alpha_reg,
  input  [31:0]  io_sim_alu_reg_math_beta_reg,
  input  [31:0]  io_sim_alu_reg_act_coefficient_a_reg_0,
  input  [31:0]  io_sim_alu_reg_act_coefficient_a_reg_1,
  input  [31:0]  io_sim_alu_reg_act_coefficient_a_reg_2,
  input  [31:0]  io_sim_alu_reg_act_coefficient_a_reg_3,
  input  [31:0]  io_sim_alu_reg_act_coefficient_a_reg_4,
  input  [31:0]  io_sim_alu_reg_act_coefficient_b_reg_0,
  input  [31:0]  io_sim_alu_reg_act_coefficient_b_reg_1,
  input  [31:0]  io_sim_alu_reg_act_coefficient_b_reg_2,
  input  [31:0]  io_sim_alu_reg_act_coefficient_b_reg_3,
  input  [31:0]  io_sim_alu_reg_act_coefficient_b_reg_4,
  input  [31:0]  io_sim_alu_reg_act_coefficient_c_reg_0,
  input  [31:0]  io_sim_alu_reg_act_coefficient_c_reg_1,
  input  [31:0]  io_sim_alu_reg_act_coefficient_c_reg_2,
  input  [31:0]  io_sim_alu_reg_act_coefficient_c_reg_3,
  input  [31:0]  io_sim_alu_reg_act_coefficient_c_reg_4,
  input  [31:0]  io_sim_alu_reg_act_range_reg_0,
  input  [31:0]  io_sim_alu_reg_act_range_reg_1,
  input  [31:0]  io_sim_alu_reg_act_range_reg_2,
  input  [31:0]  io_sim_alu_reg_act_range_reg_3,
  input  [31:0]  io_sim_alu_reg_innerprod_ctrl_reg,
  input  [31:0]  io_sim_pool_reg_pool_ctrl_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_ic_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_iwh_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_icstep_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_oc_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_owh_reg,
  input  [31:0]  io_sim_pool_reg_pool_shape_ocstep_reg,
  input  [63:0]  io_sim_pool_reg_pool_ifm_addr_reg,
  input  [63:0]  io_sim_pool_reg_pool_ofm_addr_reg,
  input  [31:0]  io_sim_pool_reg_pool_pad_value_reg,
  input  [31:0]  io_sim_gemm_reg_gemm_ctrl_reg,
  input  [31:0]  io_sim_gemm_reg_quant_data_reg,
  input  [31:0]  io_sim_gemm_reg_requant_data_reg,
  input  [63:0]  io_sim_gemm_reg_dequant_addr_reg,
  input  [63:0]  io_sim_gemm_reg_bias_addr_reg,
  input  [31:0]  io_sim_gemm_reg_ifm_shape_c_reg,
  input  [31:0]  io_sim_gemm_reg_ifm_shape_wh_reg,
  input  [31:0]  io_sim_gemm_reg_ifm_shape_cstep_reg,
  input  [31:0]  io_sim_gemm_reg_ofm_shape_c_reg,
  input  [31:0]  io_sim_gemm_reg_ofm_shape_wh_reg,
  input  [31:0]  io_sim_gemm_reg_ofm_shape_cstep_reg,
  input  [31:0]  io_sim_gemm_reg_wgt_len_reg,
  input  [63:0]  io_sim_gemm_reg_ifm_baseaddr_reg,
  input  [63:0]  io_sim_gemm_reg_wgt_baseaddr_reg,
  input  [63:0]  io_sim_gemm_reg_ofm_baseaddr_reg,
  input  [31:0]  io_sim_gemm_reg_div_ifm_c_reg,
  input  [31:0]  io_sim_reset_reg_reset_reg,
  input          io_sim_areq_reg_dmaEn,
  input          io_sim_areq_reg_dmaAreq,
  input  [31:0]  io_sim_areq_reg_dmaSize,
  input  [63:0]  io_sim_areq_reg_dmaAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  dma_ch_clock; // @[tcp.scala 112:48]
  wire  dma_ch_reset; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_io_dmaR_addr; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaR_areq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_io_dmaR_size; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_io_dmaR_data; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaR_valid; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaR_ready; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_io_dmaW_addr; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaW_areq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_io_dmaW_size; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_io_dmaW_data; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaW_valid; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmar_gemm_areq_dmaEn; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmar_gemm_areq_dmaAreq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_io_dmar_gemm_areq_dmaSize; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_io_dmar_gemm_areq_dmaAddr; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmar_gemm_data_valid; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_io_dmar_gemm_data_data; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaw_sendbuf_areq_dmaEn; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaw_sendbuf_areq_dmaAreq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_io_dmaw_sendbuf_areq_dmaSize; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_io_dmaw_sendbuf_areq_dmaAddr; // @[tcp.scala 112:48]
  wire  dma_ch_io_dmaw_sendbuf_data_valid; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_io_dmaw_sendbuf_data_data; // @[tcp.scala 112:48]
  wire  dma_ch_1_clock; // @[tcp.scala 112:48]
  wire  dma_ch_1_reset; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_1_io_dmaR_addr; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaR_areq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_1_io_dmaR_size; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_1_io_dmaR_data; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaR_valid; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaR_ready; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_1_io_dmaW_addr; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaW_areq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_1_io_dmaW_size; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_1_io_dmaW_data; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaW_valid; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmar_gemm_areq_dmaEn; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmar_gemm_areq_dmaAreq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_1_io_dmar_gemm_areq_dmaSize; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_1_io_dmar_gemm_areq_dmaAddr; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmar_gemm_data_valid; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_1_io_dmar_gemm_data_data; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaw_sendbuf_areq_dmaEn; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaw_sendbuf_areq_dmaAreq; // @[tcp.scala 112:48]
  wire [31:0] dma_ch_1_io_dmaw_sendbuf_areq_dmaSize; // @[tcp.scala 112:48]
  wire [63:0] dma_ch_1_io_dmaw_sendbuf_areq_dmaAddr; // @[tcp.scala 112:48]
  wire  dma_ch_1_io_dmaw_sendbuf_data_valid; // @[tcp.scala 112:48]
  wire [127:0] dma_ch_1_io_dmaw_sendbuf_data_data; // @[tcp.scala 112:48]
  wire  axi_ch0_ctrl_clock; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_reset; // @[tcp.scala 126:30]
  wire [63:0] axi_ch0_ctrl_io_axi_m_araddr; // @[tcp.scala 126:30]
  wire [7:0] axi_ch0_ctrl_io_axi_m_arlen; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_axi_m_arvalid; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_axi_m_arready; // @[tcp.scala 126:30]
  wire [127:0] axi_ch0_ctrl_io_axi_m_rdata; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_axi_m_rlast; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_axi_m_rvalid; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_axi_m_rready; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_dma_areq; // @[tcp.scala 126:30]
  wire [63:0] axi_ch0_ctrl_io_dma_addr; // @[tcp.scala 126:30]
  wire [31:0] axi_ch0_ctrl_io_dma_size; // @[tcp.scala 126:30]
  wire [127:0] axi_ch0_ctrl_io_dma_data; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_dma_valid; // @[tcp.scala 126:30]
  wire  axi_ch0_ctrl_io_dma_ready; // @[tcp.scala 126:30]
  wire  axi_ch1_ctrl_clock; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_reset; // @[tcp.scala 127:30]
  wire [63:0] axi_ch1_ctrl_io_axi_m_araddr; // @[tcp.scala 127:30]
  wire [7:0] axi_ch1_ctrl_io_axi_m_arlen; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_axi_m_arvalid; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_axi_m_arready; // @[tcp.scala 127:30]
  wire [127:0] axi_ch1_ctrl_io_axi_m_rdata; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_axi_m_rlast; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_axi_m_rvalid; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_axi_m_rready; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_dma_areq; // @[tcp.scala 127:30]
  wire [63:0] axi_ch1_ctrl_io_dma_addr; // @[tcp.scala 127:30]
  wire [31:0] axi_ch1_ctrl_io_dma_size; // @[tcp.scala 127:30]
  wire [127:0] axi_ch1_ctrl_io_dma_data; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_dma_valid; // @[tcp.scala 127:30]
  wire  axi_ch1_ctrl_io_dma_ready; // @[tcp.scala 127:30]
  wire  axi_send_clock; // @[tcp.scala 129:31]
  wire  axi_send_reset; // @[tcp.scala 129:31]
  wire [127:0] axi_send_io_opfusion_send_ch0_data; // @[tcp.scala 129:31]
  wire [31:0] axi_send_io_opfusion_send_ch0_size; // @[tcp.scala 129:31]
  wire [63:0] axi_send_io_opfusion_send_ch0_addr; // @[tcp.scala 129:31]
  wire  axi_send_io_opfusion_send_ch0_data_valid; // @[tcp.scala 129:31]
  wire  axi_send_io_opfusion_send_ch0_addr_valid; // @[tcp.scala 129:31]
  wire [127:0] axi_send_io_opfusion_send_ch1_data; // @[tcp.scala 129:31]
  wire [31:0] axi_send_io_opfusion_send_ch1_size; // @[tcp.scala 129:31]
  wire [63:0] axi_send_io_opfusion_send_ch1_addr; // @[tcp.scala 129:31]
  wire  axi_send_io_opfusion_send_ch1_data_valid; // @[tcp.scala 129:31]
  wire  axi_send_io_opfusion_send_ch1_addr_valid; // @[tcp.scala 129:31]
  wire [63:0] axi_send_io_axi_ch0_m_awaddr; // @[tcp.scala 129:31]
  wire [7:0] axi_send_io_axi_ch0_m_awlen; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch0_m_awvalid; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch0_m_awready; // @[tcp.scala 129:31]
  wire [127:0] axi_send_io_axi_ch0_m_wdata; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch0_m_wlast; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch0_m_wvalid; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch0_m_wready; // @[tcp.scala 129:31]
  wire [63:0] axi_send_io_axi_ch1_m_awaddr; // @[tcp.scala 129:31]
  wire [7:0] axi_send_io_axi_ch1_m_awlen; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch1_m_awvalid; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch1_m_awready; // @[tcp.scala 129:31]
  wire [127:0] axi_send_io_axi_ch1_m_wdata; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch1_m_wlast; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch1_m_wvalid; // @[tcp.scala 129:31]
  wire  axi_send_io_axi_ch1_m_wready; // @[tcp.scala 129:31]
  wire  fifo_clock; // @[tcp.scala 156:22]
  wire  fifo_reset; // @[tcp.scala 156:22]
  wire  fifo_io_enq_0_valid; // @[tcp.scala 156:22]
  wire [127:0] fifo_io_enq_0_data; // @[tcp.scala 156:22]
  wire  fifo_io_enq_1_valid; // @[tcp.scala 156:22]
  wire [127:0] fifo_io_enq_1_data; // @[tcp.scala 156:22]
  wire  fifo_io_deq_0_valid; // @[tcp.scala 156:22]
  wire [127:0] fifo_io_deq_0_data; // @[tcp.scala 156:22]
  wire  fifo_io_deq_1_valid; // @[tcp.scala 156:22]
  wire [127:0] fifo_io_deq_1_data; // @[tcp.scala 156:22]
  wire  ifmbuffer_clock; // @[tcp.scala 160:27]
  wire  ifmbuffer_reset; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_input_data_valid; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_dma_to_buffer_0_valid; // @[tcp.scala 160:27]
  wire [127:0] ifmbuffer_io_dma_to_buffer_0_data; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_dma_to_buffer_1_valid; // @[tcp.scala 160:27]
  wire [127:0] ifmbuffer_io_dma_to_buffer_1_data; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_din_valid_ConV; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_dout_valid_ConV; // @[tcp.scala 160:27]
  wire [127:0] ifmbuffer_io_buffer_to_input_0; // @[tcp.scala 160:27]
  wire [127:0] ifmbuffer_io_buffer_to_input_1; // @[tcp.scala 160:27]
  wire  ifmbuffer_io_ifm_buffer_ready; // @[tcp.scala 160:27]
  wire  wgtbuffer_clock; // @[tcp.scala 179:13]
  wire  wgtbuffer_reset; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_wgt_data_valid; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_dma_to_wgtbuffer_0_valid; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_dma_to_wgtbuffer_0_data; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_dma_to_wgtbuffer_1_valid; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_dma_to_wgtbuffer_1_data; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_buffer_to_BL_0; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_buffer_to_BL_1; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_buffer_to_BL_2; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_buffer_to_BL_3; // @[tcp.scala 179:13]
  wire [127:0] wgtbuffer_io_buffer_to_WL; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_wgt_buffer_done; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_test3; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_test6; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_test9; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_test12; // @[tcp.scala 179:13]
  wire  wgtbuffer_io_test15; // @[tcp.scala 179:13]
  wire  outbuffer_clock; // @[tcp.scala 200:27]
  wire  outbuffer_io_output_data_valid; // @[tcp.scala 200:27]
  wire  outbuffer_io_output_to_dma_0_valid; // @[tcp.scala 200:27]
  wire [127:0] outbuffer_io_output_to_dma_0_data; // @[tcp.scala 200:27]
  wire  outbuffer_io_output_to_dma_1_valid; // @[tcp.scala 200:27]
  wire [127:0] outbuffer_io_output_to_dma_1_data; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_0; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_1; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_2; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_3; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_4; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_5; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_6; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_7; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_8; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_9; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_10; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_11; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_12; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_13; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_14; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_15; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_16; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_17; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_18; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_19; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_20; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_21; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_22; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_23; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_24; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_25; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_26; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_27; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_28; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_29; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_30; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_31; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_32; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_33; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_34; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_35; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_36; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_37; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_38; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_39; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_40; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_41; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_42; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_43; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_44; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_45; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_46; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_47; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_48; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_49; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_50; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_51; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_52; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_53; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_54; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_55; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_56; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_57; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_58; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_59; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_60; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_61; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_62; // @[tcp.scala 200:27]
  wire [31:0] outbuffer_io_sum_out_63; // @[tcp.scala 200:27]
  wire  outbuffer_io_ofm_buffer_valid_0; // @[tcp.scala 200:27]
  wire  outbuffer_io_ofm_buffer_valid_1; // @[tcp.scala 200:27]
  wire  cim_macro_clock; // @[tcp.scala 260:27]
  wire  cim_macro_reset; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_BL_0; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_BL_1; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_BL_2; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_BL_3; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_WL; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_IN_0; // @[tcp.scala 260:27]
  wire [127:0] cim_macro_io_IN_1; // @[tcp.scala 260:27]
  wire  cim_macro_io_ifm_buffer_ready; // @[tcp.scala 260:27]
  wire  cim_macro_io_din_valid_ConV; // @[tcp.scala 260:27]
  wire  cim_macro_io_dout_valid_ConV; // @[tcp.scala 260:27]
  wire  cim_macro_io_buffer_busy; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_0; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_1; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_2; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_3; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_4; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_5; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_6; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_7; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_8; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_9; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_10; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_11; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_12; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_13; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_14; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_15; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_16; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_17; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_18; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_19; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_20; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_21; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_22; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_23; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_24; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_25; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_26; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_27; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_28; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_29; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_30; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_31; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_32; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_33; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_34; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_35; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_36; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_37; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_38; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_39; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_40; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_41; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_42; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_43; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_44; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_45; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_46; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_47; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_48; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_49; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_50; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_51; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_52; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_53; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_54; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_55; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_56; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_57; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_58; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_59; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_60; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_61; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_62; // @[tcp.scala 260:27]
  wire [31:0] cim_macro_io_sum_out_63; // @[tcp.scala 260:27]
  reg  ofm_buffer_done; // @[tcp.scala 205:34]
  reg [1:0] state_out; // @[tcp.scala 209:28]
  wire  _T_1 = io_axi_ch1_m_wlast & io_axi_ch2_m_wlast; // @[tcp.scala 213:37]
  wire [1:0] _GEN_0 = io_axi_ch2_m_wlast ? 2'h2 : 2'h0; // @[tcp.scala 219:44 220:21 223:21]
  wire [1:0] _GEN_8 = io_axi_ch1_m_wlast ? 2'h0 : 2'h2; // @[tcp.scala 237:38 238:21 241:21]
  dma_ch dma_ch ( // @[tcp.scala 112:48]
    .clock(dma_ch_clock),
    .reset(dma_ch_reset),
    .io_dmaR_addr(dma_ch_io_dmaR_addr),
    .io_dmaR_areq(dma_ch_io_dmaR_areq),
    .io_dmaR_size(dma_ch_io_dmaR_size),
    .io_dmaR_data(dma_ch_io_dmaR_data),
    .io_dmaR_valid(dma_ch_io_dmaR_valid),
    .io_dmaR_ready(dma_ch_io_dmaR_ready),
    .io_dmaW_addr(dma_ch_io_dmaW_addr),
    .io_dmaW_areq(dma_ch_io_dmaW_areq),
    .io_dmaW_size(dma_ch_io_dmaW_size),
    .io_dmaW_data(dma_ch_io_dmaW_data),
    .io_dmaW_valid(dma_ch_io_dmaW_valid),
    .io_dmar_gemm_areq_dmaEn(dma_ch_io_dmar_gemm_areq_dmaEn),
    .io_dmar_gemm_areq_dmaAreq(dma_ch_io_dmar_gemm_areq_dmaAreq),
    .io_dmar_gemm_areq_dmaSize(dma_ch_io_dmar_gemm_areq_dmaSize),
    .io_dmar_gemm_areq_dmaAddr(dma_ch_io_dmar_gemm_areq_dmaAddr),
    .io_dmar_gemm_data_valid(dma_ch_io_dmar_gemm_data_valid),
    .io_dmar_gemm_data_data(dma_ch_io_dmar_gemm_data_data),
    .io_dmaw_sendbuf_areq_dmaEn(dma_ch_io_dmaw_sendbuf_areq_dmaEn),
    .io_dmaw_sendbuf_areq_dmaAreq(dma_ch_io_dmaw_sendbuf_areq_dmaAreq),
    .io_dmaw_sendbuf_areq_dmaSize(dma_ch_io_dmaw_sendbuf_areq_dmaSize),
    .io_dmaw_sendbuf_areq_dmaAddr(dma_ch_io_dmaw_sendbuf_areq_dmaAddr),
    .io_dmaw_sendbuf_data_valid(dma_ch_io_dmaw_sendbuf_data_valid),
    .io_dmaw_sendbuf_data_data(dma_ch_io_dmaw_sendbuf_data_data)
  );
  dma_ch dma_ch_1 ( // @[tcp.scala 112:48]
    .clock(dma_ch_1_clock),
    .reset(dma_ch_1_reset),
    .io_dmaR_addr(dma_ch_1_io_dmaR_addr),
    .io_dmaR_areq(dma_ch_1_io_dmaR_areq),
    .io_dmaR_size(dma_ch_1_io_dmaR_size),
    .io_dmaR_data(dma_ch_1_io_dmaR_data),
    .io_dmaR_valid(dma_ch_1_io_dmaR_valid),
    .io_dmaR_ready(dma_ch_1_io_dmaR_ready),
    .io_dmaW_addr(dma_ch_1_io_dmaW_addr),
    .io_dmaW_areq(dma_ch_1_io_dmaW_areq),
    .io_dmaW_size(dma_ch_1_io_dmaW_size),
    .io_dmaW_data(dma_ch_1_io_dmaW_data),
    .io_dmaW_valid(dma_ch_1_io_dmaW_valid),
    .io_dmar_gemm_areq_dmaEn(dma_ch_1_io_dmar_gemm_areq_dmaEn),
    .io_dmar_gemm_areq_dmaAreq(dma_ch_1_io_dmar_gemm_areq_dmaAreq),
    .io_dmar_gemm_areq_dmaSize(dma_ch_1_io_dmar_gemm_areq_dmaSize),
    .io_dmar_gemm_areq_dmaAddr(dma_ch_1_io_dmar_gemm_areq_dmaAddr),
    .io_dmar_gemm_data_valid(dma_ch_1_io_dmar_gemm_data_valid),
    .io_dmar_gemm_data_data(dma_ch_1_io_dmar_gemm_data_data),
    .io_dmaw_sendbuf_areq_dmaEn(dma_ch_1_io_dmaw_sendbuf_areq_dmaEn),
    .io_dmaw_sendbuf_areq_dmaAreq(dma_ch_1_io_dmaw_sendbuf_areq_dmaAreq),
    .io_dmaw_sendbuf_areq_dmaSize(dma_ch_1_io_dmaw_sendbuf_areq_dmaSize),
    .io_dmaw_sendbuf_areq_dmaAddr(dma_ch_1_io_dmaw_sendbuf_areq_dmaAddr),
    .io_dmaw_sendbuf_data_valid(dma_ch_1_io_dmaw_sendbuf_data_valid),
    .io_dmaw_sendbuf_data_data(dma_ch_1_io_dmaw_sendbuf_data_data)
  );
  axi_r_ctrl axi_ch0_ctrl ( // @[tcp.scala 126:30]
    .clock(axi_ch0_ctrl_clock),
    .reset(axi_ch0_ctrl_reset),
    .io_axi_m_araddr(axi_ch0_ctrl_io_axi_m_araddr),
    .io_axi_m_arlen(axi_ch0_ctrl_io_axi_m_arlen),
    .io_axi_m_arvalid(axi_ch0_ctrl_io_axi_m_arvalid),
    .io_axi_m_arready(axi_ch0_ctrl_io_axi_m_arready),
    .io_axi_m_rdata(axi_ch0_ctrl_io_axi_m_rdata),
    .io_axi_m_rlast(axi_ch0_ctrl_io_axi_m_rlast),
    .io_axi_m_rvalid(axi_ch0_ctrl_io_axi_m_rvalid),
    .io_axi_m_rready(axi_ch0_ctrl_io_axi_m_rready),
    .io_dma_areq(axi_ch0_ctrl_io_dma_areq),
    .io_dma_addr(axi_ch0_ctrl_io_dma_addr),
    .io_dma_size(axi_ch0_ctrl_io_dma_size),
    .io_dma_data(axi_ch0_ctrl_io_dma_data),
    .io_dma_valid(axi_ch0_ctrl_io_dma_valid),
    .io_dma_ready(axi_ch0_ctrl_io_dma_ready)
  );
  axi_r_ctrl axi_ch1_ctrl ( // @[tcp.scala 127:30]
    .clock(axi_ch1_ctrl_clock),
    .reset(axi_ch1_ctrl_reset),
    .io_axi_m_araddr(axi_ch1_ctrl_io_axi_m_araddr),
    .io_axi_m_arlen(axi_ch1_ctrl_io_axi_m_arlen),
    .io_axi_m_arvalid(axi_ch1_ctrl_io_axi_m_arvalid),
    .io_axi_m_arready(axi_ch1_ctrl_io_axi_m_arready),
    .io_axi_m_rdata(axi_ch1_ctrl_io_axi_m_rdata),
    .io_axi_m_rlast(axi_ch1_ctrl_io_axi_m_rlast),
    .io_axi_m_rvalid(axi_ch1_ctrl_io_axi_m_rvalid),
    .io_axi_m_rready(axi_ch1_ctrl_io_axi_m_rready),
    .io_dma_areq(axi_ch1_ctrl_io_dma_areq),
    .io_dma_addr(axi_ch1_ctrl_io_dma_addr),
    .io_dma_size(axi_ch1_ctrl_io_dma_size),
    .io_dma_data(axi_ch1_ctrl_io_dma_data),
    .io_dma_valid(axi_ch1_ctrl_io_dma_valid),
    .io_dma_ready(axi_ch1_ctrl_io_dma_ready)
  );
  axiSendBuffer axi_send ( // @[tcp.scala 129:31]
    .clock(axi_send_clock),
    .reset(axi_send_reset),
    .io_opfusion_send_ch0_data(axi_send_io_opfusion_send_ch0_data),
    .io_opfusion_send_ch0_size(axi_send_io_opfusion_send_ch0_size),
    .io_opfusion_send_ch0_addr(axi_send_io_opfusion_send_ch0_addr),
    .io_opfusion_send_ch0_data_valid(axi_send_io_opfusion_send_ch0_data_valid),
    .io_opfusion_send_ch0_addr_valid(axi_send_io_opfusion_send_ch0_addr_valid),
    .io_opfusion_send_ch1_data(axi_send_io_opfusion_send_ch1_data),
    .io_opfusion_send_ch1_size(axi_send_io_opfusion_send_ch1_size),
    .io_opfusion_send_ch1_addr(axi_send_io_opfusion_send_ch1_addr),
    .io_opfusion_send_ch1_data_valid(axi_send_io_opfusion_send_ch1_data_valid),
    .io_opfusion_send_ch1_addr_valid(axi_send_io_opfusion_send_ch1_addr_valid),
    .io_axi_ch0_m_awaddr(axi_send_io_axi_ch0_m_awaddr),
    .io_axi_ch0_m_awlen(axi_send_io_axi_ch0_m_awlen),
    .io_axi_ch0_m_awvalid(axi_send_io_axi_ch0_m_awvalid),
    .io_axi_ch0_m_awready(axi_send_io_axi_ch0_m_awready),
    .io_axi_ch0_m_wdata(axi_send_io_axi_ch0_m_wdata),
    .io_axi_ch0_m_wlast(axi_send_io_axi_ch0_m_wlast),
    .io_axi_ch0_m_wvalid(axi_send_io_axi_ch0_m_wvalid),
    .io_axi_ch0_m_wready(axi_send_io_axi_ch0_m_wready),
    .io_axi_ch1_m_awaddr(axi_send_io_axi_ch1_m_awaddr),
    .io_axi_ch1_m_awlen(axi_send_io_axi_ch1_m_awlen),
    .io_axi_ch1_m_awvalid(axi_send_io_axi_ch1_m_awvalid),
    .io_axi_ch1_m_awready(axi_send_io_axi_ch1_m_awready),
    .io_axi_ch1_m_wdata(axi_send_io_axi_ch1_m_wdata),
    .io_axi_ch1_m_wlast(axi_send_io_axi_ch1_m_wlast),
    .io_axi_ch1_m_wvalid(axi_send_io_axi_ch1_m_wvalid),
    .io_axi_ch1_m_wready(axi_send_io_axi_ch1_m_wready)
  );
  standard_fifo_two_channel fifo ( // @[tcp.scala 156:22]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_0_valid(fifo_io_enq_0_valid),
    .io_enq_0_data(fifo_io_enq_0_data),
    .io_enq_1_valid(fifo_io_enq_1_valid),
    .io_enq_1_data(fifo_io_enq_1_data),
    .io_deq_0_valid(fifo_io_deq_0_valid),
    .io_deq_0_data(fifo_io_deq_0_data),
    .io_deq_1_valid(fifo_io_deq_1_valid),
    .io_deq_1_data(fifo_io_deq_1_data)
  );
  ifm_buffer ifmbuffer ( // @[tcp.scala 160:27]
    .clock(ifmbuffer_clock),
    .reset(ifmbuffer_reset),
    .io_input_data_valid(ifmbuffer_io_input_data_valid),
    .io_dma_to_buffer_0_valid(ifmbuffer_io_dma_to_buffer_0_valid),
    .io_dma_to_buffer_0_data(ifmbuffer_io_dma_to_buffer_0_data),
    .io_dma_to_buffer_1_valid(ifmbuffer_io_dma_to_buffer_1_valid),
    .io_dma_to_buffer_1_data(ifmbuffer_io_dma_to_buffer_1_data),
    .io_din_valid_ConV(ifmbuffer_io_din_valid_ConV),
    .io_dout_valid_ConV(ifmbuffer_io_dout_valid_ConV),
    .io_buffer_to_input_0(ifmbuffer_io_buffer_to_input_0),
    .io_buffer_to_input_1(ifmbuffer_io_buffer_to_input_1),
    .io_ifm_buffer_ready(ifmbuffer_io_ifm_buffer_ready)
  );
  wgt_buffer wgtbuffer ( // @[tcp.scala 179:13]
    .clock(wgtbuffer_clock),
    .reset(wgtbuffer_reset),
    .io_wgt_data_valid(wgtbuffer_io_wgt_data_valid),
    .io_dma_to_wgtbuffer_0_valid(wgtbuffer_io_dma_to_wgtbuffer_0_valid),
    .io_dma_to_wgtbuffer_0_data(wgtbuffer_io_dma_to_wgtbuffer_0_data),
    .io_dma_to_wgtbuffer_1_valid(wgtbuffer_io_dma_to_wgtbuffer_1_valid),
    .io_dma_to_wgtbuffer_1_data(wgtbuffer_io_dma_to_wgtbuffer_1_data),
    .io_buffer_to_BL_0(wgtbuffer_io_buffer_to_BL_0),
    .io_buffer_to_BL_1(wgtbuffer_io_buffer_to_BL_1),
    .io_buffer_to_BL_2(wgtbuffer_io_buffer_to_BL_2),
    .io_buffer_to_BL_3(wgtbuffer_io_buffer_to_BL_3),
    .io_buffer_to_WL(wgtbuffer_io_buffer_to_WL),
    .io_wgt_buffer_done(wgtbuffer_io_wgt_buffer_done),
    .io_test3(wgtbuffer_io_test3),
    .io_test6(wgtbuffer_io_test6),
    .io_test9(wgtbuffer_io_test9),
    .io_test12(wgtbuffer_io_test12),
    .io_test15(wgtbuffer_io_test15)
  );
  out_buffer outbuffer ( // @[tcp.scala 200:27]
    .clock(outbuffer_clock),
    .io_output_data_valid(outbuffer_io_output_data_valid),
    .io_output_to_dma_0_valid(outbuffer_io_output_to_dma_0_valid),
    .io_output_to_dma_0_data(outbuffer_io_output_to_dma_0_data),
    .io_output_to_dma_1_valid(outbuffer_io_output_to_dma_1_valid),
    .io_output_to_dma_1_data(outbuffer_io_output_to_dma_1_data),
    .io_sum_out_0(outbuffer_io_sum_out_0),
    .io_sum_out_1(outbuffer_io_sum_out_1),
    .io_sum_out_2(outbuffer_io_sum_out_2),
    .io_sum_out_3(outbuffer_io_sum_out_3),
    .io_sum_out_4(outbuffer_io_sum_out_4),
    .io_sum_out_5(outbuffer_io_sum_out_5),
    .io_sum_out_6(outbuffer_io_sum_out_6),
    .io_sum_out_7(outbuffer_io_sum_out_7),
    .io_sum_out_8(outbuffer_io_sum_out_8),
    .io_sum_out_9(outbuffer_io_sum_out_9),
    .io_sum_out_10(outbuffer_io_sum_out_10),
    .io_sum_out_11(outbuffer_io_sum_out_11),
    .io_sum_out_12(outbuffer_io_sum_out_12),
    .io_sum_out_13(outbuffer_io_sum_out_13),
    .io_sum_out_14(outbuffer_io_sum_out_14),
    .io_sum_out_15(outbuffer_io_sum_out_15),
    .io_sum_out_16(outbuffer_io_sum_out_16),
    .io_sum_out_17(outbuffer_io_sum_out_17),
    .io_sum_out_18(outbuffer_io_sum_out_18),
    .io_sum_out_19(outbuffer_io_sum_out_19),
    .io_sum_out_20(outbuffer_io_sum_out_20),
    .io_sum_out_21(outbuffer_io_sum_out_21),
    .io_sum_out_22(outbuffer_io_sum_out_22),
    .io_sum_out_23(outbuffer_io_sum_out_23),
    .io_sum_out_24(outbuffer_io_sum_out_24),
    .io_sum_out_25(outbuffer_io_sum_out_25),
    .io_sum_out_26(outbuffer_io_sum_out_26),
    .io_sum_out_27(outbuffer_io_sum_out_27),
    .io_sum_out_28(outbuffer_io_sum_out_28),
    .io_sum_out_29(outbuffer_io_sum_out_29),
    .io_sum_out_30(outbuffer_io_sum_out_30),
    .io_sum_out_31(outbuffer_io_sum_out_31),
    .io_sum_out_32(outbuffer_io_sum_out_32),
    .io_sum_out_33(outbuffer_io_sum_out_33),
    .io_sum_out_34(outbuffer_io_sum_out_34),
    .io_sum_out_35(outbuffer_io_sum_out_35),
    .io_sum_out_36(outbuffer_io_sum_out_36),
    .io_sum_out_37(outbuffer_io_sum_out_37),
    .io_sum_out_38(outbuffer_io_sum_out_38),
    .io_sum_out_39(outbuffer_io_sum_out_39),
    .io_sum_out_40(outbuffer_io_sum_out_40),
    .io_sum_out_41(outbuffer_io_sum_out_41),
    .io_sum_out_42(outbuffer_io_sum_out_42),
    .io_sum_out_43(outbuffer_io_sum_out_43),
    .io_sum_out_44(outbuffer_io_sum_out_44),
    .io_sum_out_45(outbuffer_io_sum_out_45),
    .io_sum_out_46(outbuffer_io_sum_out_46),
    .io_sum_out_47(outbuffer_io_sum_out_47),
    .io_sum_out_48(outbuffer_io_sum_out_48),
    .io_sum_out_49(outbuffer_io_sum_out_49),
    .io_sum_out_50(outbuffer_io_sum_out_50),
    .io_sum_out_51(outbuffer_io_sum_out_51),
    .io_sum_out_52(outbuffer_io_sum_out_52),
    .io_sum_out_53(outbuffer_io_sum_out_53),
    .io_sum_out_54(outbuffer_io_sum_out_54),
    .io_sum_out_55(outbuffer_io_sum_out_55),
    .io_sum_out_56(outbuffer_io_sum_out_56),
    .io_sum_out_57(outbuffer_io_sum_out_57),
    .io_sum_out_58(outbuffer_io_sum_out_58),
    .io_sum_out_59(outbuffer_io_sum_out_59),
    .io_sum_out_60(outbuffer_io_sum_out_60),
    .io_sum_out_61(outbuffer_io_sum_out_61),
    .io_sum_out_62(outbuffer_io_sum_out_62),
    .io_sum_out_63(outbuffer_io_sum_out_63),
    .io_ofm_buffer_valid_0(outbuffer_io_ofm_buffer_valid_0),
    .io_ofm_buffer_valid_1(outbuffer_io_ofm_buffer_valid_1)
  );
  top_cim cim_macro ( // @[tcp.scala 260:27]
    .clock(cim_macro_clock),
    .reset(cim_macro_reset),
    .io_BL_0(cim_macro_io_BL_0),
    .io_BL_1(cim_macro_io_BL_1),
    .io_BL_2(cim_macro_io_BL_2),
    .io_BL_3(cim_macro_io_BL_3),
    .io_WL(cim_macro_io_WL),
    .io_IN_0(cim_macro_io_IN_0),
    .io_IN_1(cim_macro_io_IN_1),
    .io_ifm_buffer_ready(cim_macro_io_ifm_buffer_ready),
    .io_din_valid_ConV(cim_macro_io_din_valid_ConV),
    .io_dout_valid_ConV(cim_macro_io_dout_valid_ConV),
    .io_buffer_busy(cim_macro_io_buffer_busy),
    .io_sum_out_0(cim_macro_io_sum_out_0),
    .io_sum_out_1(cim_macro_io_sum_out_1),
    .io_sum_out_2(cim_macro_io_sum_out_2),
    .io_sum_out_3(cim_macro_io_sum_out_3),
    .io_sum_out_4(cim_macro_io_sum_out_4),
    .io_sum_out_5(cim_macro_io_sum_out_5),
    .io_sum_out_6(cim_macro_io_sum_out_6),
    .io_sum_out_7(cim_macro_io_sum_out_7),
    .io_sum_out_8(cim_macro_io_sum_out_8),
    .io_sum_out_9(cim_macro_io_sum_out_9),
    .io_sum_out_10(cim_macro_io_sum_out_10),
    .io_sum_out_11(cim_macro_io_sum_out_11),
    .io_sum_out_12(cim_macro_io_sum_out_12),
    .io_sum_out_13(cim_macro_io_sum_out_13),
    .io_sum_out_14(cim_macro_io_sum_out_14),
    .io_sum_out_15(cim_macro_io_sum_out_15),
    .io_sum_out_16(cim_macro_io_sum_out_16),
    .io_sum_out_17(cim_macro_io_sum_out_17),
    .io_sum_out_18(cim_macro_io_sum_out_18),
    .io_sum_out_19(cim_macro_io_sum_out_19),
    .io_sum_out_20(cim_macro_io_sum_out_20),
    .io_sum_out_21(cim_macro_io_sum_out_21),
    .io_sum_out_22(cim_macro_io_sum_out_22),
    .io_sum_out_23(cim_macro_io_sum_out_23),
    .io_sum_out_24(cim_macro_io_sum_out_24),
    .io_sum_out_25(cim_macro_io_sum_out_25),
    .io_sum_out_26(cim_macro_io_sum_out_26),
    .io_sum_out_27(cim_macro_io_sum_out_27),
    .io_sum_out_28(cim_macro_io_sum_out_28),
    .io_sum_out_29(cim_macro_io_sum_out_29),
    .io_sum_out_30(cim_macro_io_sum_out_30),
    .io_sum_out_31(cim_macro_io_sum_out_31),
    .io_sum_out_32(cim_macro_io_sum_out_32),
    .io_sum_out_33(cim_macro_io_sum_out_33),
    .io_sum_out_34(cim_macro_io_sum_out_34),
    .io_sum_out_35(cim_macro_io_sum_out_35),
    .io_sum_out_36(cim_macro_io_sum_out_36),
    .io_sum_out_37(cim_macro_io_sum_out_37),
    .io_sum_out_38(cim_macro_io_sum_out_38),
    .io_sum_out_39(cim_macro_io_sum_out_39),
    .io_sum_out_40(cim_macro_io_sum_out_40),
    .io_sum_out_41(cim_macro_io_sum_out_41),
    .io_sum_out_42(cim_macro_io_sum_out_42),
    .io_sum_out_43(cim_macro_io_sum_out_43),
    .io_sum_out_44(cim_macro_io_sum_out_44),
    .io_sum_out_45(cim_macro_io_sum_out_45),
    .io_sum_out_46(cim_macro_io_sum_out_46),
    .io_sum_out_47(cim_macro_io_sum_out_47),
    .io_sum_out_48(cim_macro_io_sum_out_48),
    .io_sum_out_49(cim_macro_io_sum_out_49),
    .io_sum_out_50(cim_macro_io_sum_out_50),
    .io_sum_out_51(cim_macro_io_sum_out_51),
    .io_sum_out_52(cim_macro_io_sum_out_52),
    .io_sum_out_53(cim_macro_io_sum_out_53),
    .io_sum_out_54(cim_macro_io_sum_out_54),
    .io_sum_out_55(cim_macro_io_sum_out_55),
    .io_sum_out_56(cim_macro_io_sum_out_56),
    .io_sum_out_57(cim_macro_io_sum_out_57),
    .io_sum_out_58(cim_macro_io_sum_out_58),
    .io_sum_out_59(cim_macro_io_sum_out_59),
    .io_sum_out_60(cim_macro_io_sum_out_60),
    .io_sum_out_61(cim_macro_io_sum_out_61),
    .io_sum_out_62(cim_macro_io_sum_out_62),
    .io_sum_out_63(cim_macro_io_sum_out_63)
  );
  assign io_dout_valid_ConV = cim_macro_io_dout_valid_ConV; // @[tcp.scala 266:34]
  assign io_wgt_buffer_done = wgtbuffer_io_wgt_buffer_done; // @[tcp.scala 189:34]
  assign io_ofm_buffer_done = ofm_buffer_done; // @[tcp.scala 206:28]
  assign io_buffer_busy = cim_macro_io_buffer_busy; // @[tcp.scala 267:34]
  assign io_axi_ch1_m_arid = 1'h0; // @[axiIO.scala 156:19]
  assign io_axi_ch1_m_araddr = axi_ch0_ctrl_io_axi_m_araddr; // @[axiIO.scala 157:21]
  assign io_axi_ch1_m_arlen = axi_ch0_ctrl_io_axi_m_arlen; // @[axiIO.scala 158:20]
  assign io_axi_ch1_m_arsize = 3'h4; // @[axiIO.scala 159:21]
  assign io_axi_ch1_m_arburst = 2'h1; // @[axiIO.scala 160:22]
  assign io_axi_ch1_m_arlock = 1'h0; // @[axiIO.scala 161:21]
  assign io_axi_ch1_m_arcache = 4'h2; // @[axiIO.scala 162:22]
  assign io_axi_ch1_m_arprot = 3'h0; // @[axiIO.scala 163:21]
  assign io_axi_ch1_m_arqos = 4'h0; // @[axiIO.scala 164:20]
  assign io_axi_ch1_m_arvalid = axi_ch0_ctrl_io_axi_m_arvalid; // @[axiIO.scala 165:22]
  assign io_axi_ch1_m_rready = axi_ch0_ctrl_io_axi_m_rready; // @[axiIO.scala 172:21]
  assign io_axi_ch1_m_awid = 1'h0; // @[axiIO.scala 131:19]
  assign io_axi_ch1_m_awaddr = axi_send_io_axi_ch0_m_awaddr; // @[axiIO.scala 132:21]
  assign io_axi_ch1_m_awlen = axi_send_io_axi_ch0_m_awlen; // @[axiIO.scala 133:20]
  assign io_axi_ch1_m_awsize = 3'h4; // @[axiIO.scala 134:21]
  assign io_axi_ch1_m_awburst = 2'h1; // @[axiIO.scala 135:22]
  assign io_axi_ch1_m_awlock = 1'h0; // @[axiIO.scala 136:21]
  assign io_axi_ch1_m_awcache = 4'h2; // @[axiIO.scala 137:22]
  assign io_axi_ch1_m_awprot = 3'h0; // @[axiIO.scala 138:21]
  assign io_axi_ch1_m_awqos = 4'h0; // @[axiIO.scala 139:20]
  assign io_axi_ch1_m_awvalid = axi_send_io_axi_ch0_m_awvalid; // @[axiIO.scala 140:22]
  assign io_axi_ch1_m_wid = 1'h0; // @[axiIO.scala 142:18]
  assign io_axi_ch1_m_wdata = axi_send_io_axi_ch0_m_wdata; // @[axiIO.scala 143:20]
  assign io_axi_ch1_m_wstrb = 16'hffff; // @[axiIO.scala 144:20]
  assign io_axi_ch1_m_wlast = axi_send_io_axi_ch0_m_wlast; // @[axiIO.scala 145:20]
  assign io_axi_ch1_m_wvalid = axi_send_io_axi_ch0_m_wvalid; // @[axiIO.scala 146:21]
  assign io_axi_ch1_m_bready = 1'h1; // @[axiIO.scala 151:21]
  assign io_axi_ch2_m_arid = 1'h0; // @[axiIO.scala 156:19]
  assign io_axi_ch2_m_araddr = axi_ch1_ctrl_io_axi_m_araddr; // @[axiIO.scala 157:21]
  assign io_axi_ch2_m_arlen = axi_ch1_ctrl_io_axi_m_arlen; // @[axiIO.scala 158:20]
  assign io_axi_ch2_m_arsize = 3'h4; // @[axiIO.scala 159:21]
  assign io_axi_ch2_m_arburst = 2'h1; // @[axiIO.scala 160:22]
  assign io_axi_ch2_m_arlock = 1'h0; // @[axiIO.scala 161:21]
  assign io_axi_ch2_m_arcache = 4'h2; // @[axiIO.scala 162:22]
  assign io_axi_ch2_m_arprot = 3'h0; // @[axiIO.scala 163:21]
  assign io_axi_ch2_m_arqos = 4'h0; // @[axiIO.scala 164:20]
  assign io_axi_ch2_m_arvalid = axi_ch1_ctrl_io_axi_m_arvalid; // @[axiIO.scala 165:22]
  assign io_axi_ch2_m_rready = axi_ch1_ctrl_io_axi_m_rready; // @[axiIO.scala 172:21]
  assign io_axi_ch2_m_awid = 1'h0; // @[axiIO.scala 131:19]
  assign io_axi_ch2_m_awaddr = axi_send_io_axi_ch1_m_awaddr; // @[axiIO.scala 132:21]
  assign io_axi_ch2_m_awlen = axi_send_io_axi_ch1_m_awlen; // @[axiIO.scala 133:20]
  assign io_axi_ch2_m_awsize = 3'h4; // @[axiIO.scala 134:21]
  assign io_axi_ch2_m_awburst = 2'h1; // @[axiIO.scala 135:22]
  assign io_axi_ch2_m_awlock = 1'h0; // @[axiIO.scala 136:21]
  assign io_axi_ch2_m_awcache = 4'h2; // @[axiIO.scala 137:22]
  assign io_axi_ch2_m_awprot = 3'h0; // @[axiIO.scala 138:21]
  assign io_axi_ch2_m_awqos = 4'h0; // @[axiIO.scala 139:20]
  assign io_axi_ch2_m_awvalid = axi_send_io_axi_ch1_m_awvalid; // @[axiIO.scala 140:22]
  assign io_axi_ch2_m_wid = 1'h0; // @[axiIO.scala 142:18]
  assign io_axi_ch2_m_wdata = axi_send_io_axi_ch1_m_wdata; // @[axiIO.scala 143:20]
  assign io_axi_ch2_m_wstrb = 16'hffff; // @[axiIO.scala 144:20]
  assign io_axi_ch2_m_wlast = axi_send_io_axi_ch1_m_wlast; // @[axiIO.scala 145:20]
  assign io_axi_ch2_m_wvalid = axi_send_io_axi_ch1_m_wvalid; // @[axiIO.scala 146:21]
  assign io_axi_ch2_m_bready = 1'h1; // @[axiIO.scala 151:21]
  assign io_test3 = wgtbuffer_io_test3; // @[tcp.scala 184:24]
  assign io_test6 = wgtbuffer_io_test6; // @[tcp.scala 185:24]
  assign io_test9 = wgtbuffer_io_test9; // @[tcp.scala 186:24]
  assign io_test12 = wgtbuffer_io_test12; // @[tcp.scala 187:25]
  assign io_test15 = wgtbuffer_io_test15; // @[tcp.scala 188:25]
  assign dma_ch_clock = clock;
  assign dma_ch_reset = reset;
  assign dma_ch_io_dmaR_data = axi_ch0_ctrl_io_dma_data; // @[tcp.scala 112:29 131:25]
  assign dma_ch_io_dmaR_valid = axi_ch0_ctrl_io_dma_valid; // @[tcp.scala 112:29 131:25]
  assign dma_ch_io_dmaW_valid = dma_ch_io_dmaW_areq; // @[tcp.scala 112:{29,29}]
  assign dma_ch_io_dmar_gemm_areq_dmaEn = io_dma_ch0_r_dmaEn; // @[tcp.scala 112:29 120:38]
  assign dma_ch_io_dmar_gemm_areq_dmaAreq = io_dma_ch0_r_dmaAreq; // @[tcp.scala 112:29 120:38]
  assign dma_ch_io_dmar_gemm_areq_dmaSize = io_dma_ch0_r_dmaSize; // @[tcp.scala 112:29 120:38]
  assign dma_ch_io_dmar_gemm_areq_dmaAddr = io_dma_ch0_r_dmaAddr; // @[tcp.scala 112:29 120:38]
  assign dma_ch_io_dmaw_sendbuf_areq_dmaEn = io_dma_ch0_w_dmaEn; // @[tcp.scala 112:29 121:41]
  assign dma_ch_io_dmaw_sendbuf_areq_dmaAreq = io_dma_ch0_w_dmaAreq; // @[tcp.scala 112:29 121:41]
  assign dma_ch_io_dmaw_sendbuf_areq_dmaSize = io_dma_ch0_w_dmaSize; // @[tcp.scala 112:29 121:41]
  assign dma_ch_io_dmaw_sendbuf_areq_dmaAddr = io_dma_ch0_w_dmaAddr; // @[tcp.scala 112:29 121:41]
  assign dma_ch_io_dmaw_sendbuf_data_data = outbuffer_io_output_to_dma_0_data; // @[tcp.scala 112:29 248:39]
  assign dma_ch_1_clock = clock;
  assign dma_ch_1_reset = reset;
  assign dma_ch_1_io_dmaR_data = axi_ch1_ctrl_io_dma_data; // @[tcp.scala 112:29 132:25]
  assign dma_ch_1_io_dmaR_valid = axi_ch1_ctrl_io_dma_valid; // @[tcp.scala 112:29 132:25]
  assign dma_ch_1_io_dmaW_valid = dma_ch_1_io_dmaW_areq; // @[tcp.scala 112:{29,29}]
  assign dma_ch_1_io_dmar_gemm_areq_dmaEn = io_dma_ch1_r_dmaEn; // @[tcp.scala 112:29 122:38]
  assign dma_ch_1_io_dmar_gemm_areq_dmaAreq = io_dma_ch1_r_dmaAreq; // @[tcp.scala 112:29 122:38]
  assign dma_ch_1_io_dmar_gemm_areq_dmaSize = io_dma_ch1_r_dmaSize; // @[tcp.scala 112:29 122:38]
  assign dma_ch_1_io_dmar_gemm_areq_dmaAddr = io_dma_ch1_r_dmaAddr; // @[tcp.scala 112:29 122:38]
  assign dma_ch_1_io_dmaw_sendbuf_areq_dmaEn = io_dma_ch1_w_dmaEn; // @[tcp.scala 112:29 123:41]
  assign dma_ch_1_io_dmaw_sendbuf_areq_dmaAreq = io_dma_ch1_w_dmaAreq; // @[tcp.scala 112:29 123:41]
  assign dma_ch_1_io_dmaw_sendbuf_areq_dmaSize = io_dma_ch1_w_dmaSize; // @[tcp.scala 112:29 123:41]
  assign dma_ch_1_io_dmaw_sendbuf_areq_dmaAddr = io_dma_ch1_w_dmaAddr; // @[tcp.scala 112:29 123:41]
  assign dma_ch_1_io_dmaw_sendbuf_data_data = outbuffer_io_output_to_dma_1_data; // @[tcp.scala 112:29 248:39]
  assign axi_ch0_ctrl_clock = clock;
  assign axi_ch0_ctrl_reset = reset;
  assign axi_ch0_ctrl_io_axi_m_arready = io_axi_ch1_m_arready; // @[axiIO.scala 166:22]
  assign axi_ch0_ctrl_io_axi_m_rdata = io_axi_ch1_m_rdata; // @[axiIO.scala 168:20]
  assign axi_ch0_ctrl_io_axi_m_rlast = io_axi_ch1_m_rlast; // @[axiIO.scala 170:20]
  assign axi_ch0_ctrl_io_axi_m_rvalid = io_axi_ch1_m_rvalid; // @[axiIO.scala 171:21]
  assign axi_ch0_ctrl_io_dma_areq = dma_ch_io_dmaR_areq; // @[tcp.scala 112:{29,29}]
  assign axi_ch0_ctrl_io_dma_addr = dma_ch_io_dmaR_addr; // @[tcp.scala 112:{29,29}]
  assign axi_ch0_ctrl_io_dma_size = dma_ch_io_dmaR_size; // @[tcp.scala 112:{29,29}]
  assign axi_ch0_ctrl_io_dma_ready = dma_ch_io_dmaR_ready; // @[tcp.scala 112:{29,29}]
  assign axi_ch1_ctrl_clock = clock;
  assign axi_ch1_ctrl_reset = reset;
  assign axi_ch1_ctrl_io_axi_m_arready = io_axi_ch2_m_arready; // @[axiIO.scala 166:22]
  assign axi_ch1_ctrl_io_axi_m_rdata = io_axi_ch2_m_rdata; // @[axiIO.scala 168:20]
  assign axi_ch1_ctrl_io_axi_m_rlast = io_axi_ch2_m_rlast; // @[axiIO.scala 170:20]
  assign axi_ch1_ctrl_io_axi_m_rvalid = io_axi_ch2_m_rvalid; // @[axiIO.scala 171:21]
  assign axi_ch1_ctrl_io_dma_areq = dma_ch_1_io_dmaR_areq; // @[tcp.scala 112:{29,29}]
  assign axi_ch1_ctrl_io_dma_addr = dma_ch_1_io_dmaR_addr; // @[tcp.scala 112:{29,29}]
  assign axi_ch1_ctrl_io_dma_size = dma_ch_1_io_dmaR_size; // @[tcp.scala 112:{29,29}]
  assign axi_ch1_ctrl_io_dma_ready = dma_ch_1_io_dmaR_ready; // @[tcp.scala 112:{29,29}]
  assign axi_send_clock = clock;
  assign axi_send_reset = reset;
  assign axi_send_io_opfusion_send_ch0_data = dma_ch_io_dmaW_data; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch0_size = dma_ch_io_dmaW_size; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch0_addr = dma_ch_io_dmaW_addr; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch0_data_valid = outbuffer_io_ofm_buffer_valid_0; // @[tcp.scala 252:46]
  assign axi_send_io_opfusion_send_ch0_addr_valid = dma_ch_io_dmaW_areq; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch1_data = dma_ch_1_io_dmaW_data; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch1_size = dma_ch_1_io_dmaW_size; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch1_addr = dma_ch_1_io_dmaW_addr; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_opfusion_send_ch1_data_valid = outbuffer_io_ofm_buffer_valid_1; // @[tcp.scala 253:46]
  assign axi_send_io_opfusion_send_ch1_addr_valid = dma_ch_1_io_dmaW_areq; // @[tcp.scala 112:{29,29}]
  assign axi_send_io_axi_ch0_m_awready = io_axi_ch1_m_awready; // @[axiIO.scala 141:22]
  assign axi_send_io_axi_ch0_m_wready = io_axi_ch1_m_wready; // @[axiIO.scala 147:21]
  assign axi_send_io_axi_ch1_m_awready = io_axi_ch2_m_awready; // @[axiIO.scala 141:22]
  assign axi_send_io_axi_ch1_m_wready = io_axi_ch2_m_wready; // @[axiIO.scala 147:21]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_0_valid = dma_ch_io_dmar_gemm_data_valid; // @[tcp.scala 112:{29,29}]
  assign fifo_io_enq_0_data = dma_ch_io_dmar_gemm_data_data; // @[tcp.scala 112:{29,29}]
  assign fifo_io_enq_1_valid = dma_ch_1_io_dmar_gemm_data_valid; // @[tcp.scala 112:{29,29}]
  assign fifo_io_enq_1_data = dma_ch_1_io_dmar_gemm_data_data; // @[tcp.scala 112:{29,29}]
  assign ifmbuffer_clock = clock;
  assign ifmbuffer_reset = reset;
  assign ifmbuffer_io_input_data_valid = io_input_data_valid; // @[tcp.scala 163:35]
  assign ifmbuffer_io_dma_to_buffer_0_valid = fifo_io_deq_0_valid; // @[tcp.scala 167:39]
  assign ifmbuffer_io_dma_to_buffer_0_data = fifo_io_deq_0_data; // @[tcp.scala 167:39]
  assign ifmbuffer_io_dma_to_buffer_1_valid = fifo_io_deq_1_valid; // @[tcp.scala 167:39]
  assign ifmbuffer_io_dma_to_buffer_1_data = fifo_io_deq_1_data; // @[tcp.scala 167:39]
  assign ifmbuffer_io_din_valid_ConV = io_din_valid_ConV; // @[tcp.scala 162:33]
  assign ifmbuffer_io_dout_valid_ConV = io_dout_valid_ConV; // @[tcp.scala 170:34]
  assign wgtbuffer_clock = clock;
  assign wgtbuffer_reset = reset;
  assign wgtbuffer_io_wgt_data_valid = io_wgt_data_valid; // @[tcp.scala 182:33]
  assign wgtbuffer_io_dma_to_wgtbuffer_0_valid = fifo_io_deq_0_valid; // @[tcp.scala 192:42]
  assign wgtbuffer_io_dma_to_wgtbuffer_0_data = fifo_io_deq_0_data; // @[tcp.scala 192:42]
  assign wgtbuffer_io_dma_to_wgtbuffer_1_valid = fifo_io_deq_1_valid; // @[tcp.scala 192:42]
  assign wgtbuffer_io_dma_to_wgtbuffer_1_data = fifo_io_deq_1_data; // @[tcp.scala 192:42]
  assign outbuffer_clock = clock;
  assign outbuffer_io_output_data_valid = io_dout_valid_ConV; // @[tcp.scala 202:36]
  assign outbuffer_io_output_to_dma_0_valid = dma_ch_io_dmaw_sendbuf_data_valid; // @[tcp.scala 112:{29,29}]
  assign outbuffer_io_output_to_dma_1_valid = dma_ch_1_io_dmaw_sendbuf_data_valid; // @[tcp.scala 112:{29,29}]
  assign outbuffer_io_sum_out_0 = cim_macro_io_sum_out_0; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_1 = cim_macro_io_sum_out_1; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_2 = cim_macro_io_sum_out_2; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_3 = cim_macro_io_sum_out_3; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_4 = cim_macro_io_sum_out_4; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_5 = cim_macro_io_sum_out_5; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_6 = cim_macro_io_sum_out_6; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_7 = cim_macro_io_sum_out_7; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_8 = cim_macro_io_sum_out_8; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_9 = cim_macro_io_sum_out_9; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_10 = cim_macro_io_sum_out_10; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_11 = cim_macro_io_sum_out_11; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_12 = cim_macro_io_sum_out_12; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_13 = cim_macro_io_sum_out_13; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_14 = cim_macro_io_sum_out_14; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_15 = cim_macro_io_sum_out_15; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_16 = cim_macro_io_sum_out_16; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_17 = cim_macro_io_sum_out_17; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_18 = cim_macro_io_sum_out_18; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_19 = cim_macro_io_sum_out_19; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_20 = cim_macro_io_sum_out_20; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_21 = cim_macro_io_sum_out_21; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_22 = cim_macro_io_sum_out_22; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_23 = cim_macro_io_sum_out_23; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_24 = cim_macro_io_sum_out_24; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_25 = cim_macro_io_sum_out_25; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_26 = cim_macro_io_sum_out_26; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_27 = cim_macro_io_sum_out_27; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_28 = cim_macro_io_sum_out_28; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_29 = cim_macro_io_sum_out_29; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_30 = cim_macro_io_sum_out_30; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_31 = cim_macro_io_sum_out_31; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_32 = cim_macro_io_sum_out_32; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_33 = cim_macro_io_sum_out_33; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_34 = cim_macro_io_sum_out_34; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_35 = cim_macro_io_sum_out_35; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_36 = cim_macro_io_sum_out_36; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_37 = cim_macro_io_sum_out_37; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_38 = cim_macro_io_sum_out_38; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_39 = cim_macro_io_sum_out_39; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_40 = cim_macro_io_sum_out_40; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_41 = cim_macro_io_sum_out_41; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_42 = cim_macro_io_sum_out_42; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_43 = cim_macro_io_sum_out_43; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_44 = cim_macro_io_sum_out_44; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_45 = cim_macro_io_sum_out_45; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_46 = cim_macro_io_sum_out_46; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_47 = cim_macro_io_sum_out_47; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_48 = cim_macro_io_sum_out_48; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_49 = cim_macro_io_sum_out_49; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_50 = cim_macro_io_sum_out_50; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_51 = cim_macro_io_sum_out_51; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_52 = cim_macro_io_sum_out_52; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_53 = cim_macro_io_sum_out_53; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_54 = cim_macro_io_sum_out_54; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_55 = cim_macro_io_sum_out_55; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_56 = cim_macro_io_sum_out_56; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_57 = cim_macro_io_sum_out_57; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_58 = cim_macro_io_sum_out_58; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_59 = cim_macro_io_sum_out_59; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_60 = cim_macro_io_sum_out_60; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_61 = cim_macro_io_sum_out_61; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_62 = cim_macro_io_sum_out_62; // @[tcp.scala 272:26]
  assign outbuffer_io_sum_out_63 = cim_macro_io_sum_out_63; // @[tcp.scala 272:26]
  assign cim_macro_clock = clock;
  assign cim_macro_reset = reset;
  assign cim_macro_io_BL_0 = wgtbuffer_io_buffer_to_BL_0; // @[tcp.scala 268:21]
  assign cim_macro_io_BL_1 = wgtbuffer_io_buffer_to_BL_1; // @[tcp.scala 268:21]
  assign cim_macro_io_BL_2 = wgtbuffer_io_buffer_to_BL_2; // @[tcp.scala 268:21]
  assign cim_macro_io_BL_3 = wgtbuffer_io_buffer_to_BL_3; // @[tcp.scala 268:21]
  assign cim_macro_io_WL = wgtbuffer_io_buffer_to_WL; // @[tcp.scala 269:21]
  assign cim_macro_io_IN_0 = ifmbuffer_io_buffer_to_input_0; // @[tcp.scala 270:21]
  assign cim_macro_io_IN_1 = ifmbuffer_io_buffer_to_input_1; // @[tcp.scala 270:21]
  assign cim_macro_io_ifm_buffer_ready = ifmbuffer_io_ifm_buffer_ready; // @[tcp.scala 271:39]
  assign cim_macro_io_din_valid_ConV = io_din_valid_ConV; // @[tcp.scala 263:33]
  always @(posedge clock) begin
    if (reset) begin // @[tcp.scala 205:34]
      ofm_buffer_done <= 1'h0; // @[tcp.scala 205:34]
    end else if (2'h0 == state_out) begin // @[tcp.scala 211:23]
      ofm_buffer_done <= _T_1;
    end else if (2'h1 == state_out) begin // @[tcp.scala 211:23]
      ofm_buffer_done <= io_axi_ch2_m_wlast;
    end else if (2'h2 == state_out) begin // @[tcp.scala 211:23]
      ofm_buffer_done <= io_axi_ch1_m_wlast;
    end
    if (reset) begin // @[tcp.scala 209:28]
      state_out <= 2'h0; // @[tcp.scala 209:28]
    end else if (2'h0 == state_out) begin // @[tcp.scala 211:23]
      if (io_axi_ch1_m_wlast & io_axi_ch2_m_wlast) begin // @[tcp.scala 213:64]
        state_out <= 2'h0; // @[tcp.scala 214:21]
      end else if (io_axi_ch1_m_wlast) begin // @[tcp.scala 216:44]
        state_out <= 2'h1; // @[tcp.scala 217:21]
      end else begin
        state_out <= _GEN_0;
      end
    end else if (2'h1 == state_out) begin // @[tcp.scala 211:23]
      if (io_axi_ch2_m_wlast) begin // @[tcp.scala 228:38]
        state_out <= 2'h0; // @[tcp.scala 229:21]
      end else begin
        state_out <= 2'h1; // @[tcp.scala 232:21]
      end
    end else if (2'h2 == state_out) begin // @[tcp.scala 211:23]
      state_out <= _GEN_8;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ofm_buffer_done = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  state_out = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
