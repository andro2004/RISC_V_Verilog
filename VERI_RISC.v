module VERI_RISC(clk,rst,halt);

parameter DATA_WIDTH=8;
parameter addr_WIDTH=5;
input clk,rst;
output halt;
wire [2:0] phase;
wire sel,rd,ld_ir,w_halt,inc_pc,ld_pc,data_e,ld_ac,wr;
wire zero;
wire [2:0] opcode;
wire [DATA_WIDTH-1:0] alu_out;
wire [DATA_WIDTH-1:0] ac_out;
wire [DATA_WIDTH-1:0] data;
wire [DATA_WIDTH-1:0] instruction_register_out;
wire [addr_WIDTH-1:0] ir_addr;
wire [addr_WIDTH-1:0] pc_addr;
wire [addr_WIDTH-1:0] addr;

counter #(3) phase_generator (0,phase,1,0,clk,rst);
controller controller_inst (phase,zero,opcode,sel,rd,ld_ir,w_halt,inc_pc,ld_pc,data_e,ld_ac,wr);

assign halt=w_halt;

register #(DATA_WIDTH)register_ac(alu_out,ld_ac,clk,rst,ac_out);
alu #(DATA_WIDTH) ALU (ac_out,data,opcode,alu_out,zero);

driver #(DATA_WIDTH) driver_inst (alu_out,data,data_e);

register #(DATA_WIDTH) instruction_register (data,ld_ir,clk,rst,instruction_register_out); 
assign opcode=instruction_register_out[2:0];
assign ir_addr=instruction_register_out[7:3];

counter #(addr_WIDTH) program_counter (ir_addr,pc_addr,inc_pc,ld_pc,clk,rst);

multiplexor #(addr_WIDTH) mux (ir_addr,pc_addr,sel,addr);

memory #(addr_WIDTH,DATA_WIDTH) memory_inst (addr,data,clk,wr,rd);




endmodule
