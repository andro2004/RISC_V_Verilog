module controller (phase,zero,opcode,sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr);

input [2:0] phase;
input zero;
input [2:0] opcode;
output reg sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e;

reg HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP,ALU_OP;

always @(*)
begin
case(opcode)
3'b000: begin HLT=1;SKZ=0;ADD=0;AND=0;XOR=0;LDA=0;STO=0;JMP=0;ALU_OP=0;end
3'b001: begin HLT=0;SKZ=1;ADD=0;AND=0;XOR=0;LDA=0;STO=0;JMP=0;ALU_OP=0;end
3'b010: begin HLT=0;SKZ=0;ADD=1;AND=0;XOR=0;LDA=0;STO=0;JMP=0;ALU_OP=1;end
3'b011: begin HLT=0;SKZ=0;ADD=0;AND=1;XOR=0;LDA=0;STO=0;JMP=0;ALU_OP=1;end
3'b100: begin HLT=0;SKZ=0;ADD=0;AND=0;XOR=1;LDA=0;STO=0;JMP=0;ALU_OP=1;end
3'b101: begin HLT=0;SKZ=0;ADD=0;AND=0;XOR=0;LDA=1;STO=0;JMP=0;ALU_OP=1;end
3'b110: begin HLT=0;SKZ=0;ADD=0;AND=0;XOR=0;LDA=0;STO=1;JMP=0;ALU_OP=0;end
3'b111: begin HLT=0;SKZ=0;ADD=0;AND=0;XOR=0;LDA=0;STO=0;JMP=1;ALU_OP=0;end
endcase
case(phase)
3'b000:begin sel=1;rd=0;ld_ir=0;halt=0;inc_pc=0;ld_ac=0;ld_pc=0;wr=0;data_e=0; end
3'b001:begin sel=1;rd=1;ld_ir=0;halt=0;inc_pc=0;ld_ac=0;ld_pc=0;wr=0;data_e=0;end
3'b010:begin sel=1;rd=1;ld_ir=1;halt=0;inc_pc=0;ld_ac=0;ld_pc=0;wr=0;data_e=0; end
3'b011:begin sel=1;rd=1;ld_ir=1;halt=0;inc_pc=0;ld_ac=0;ld_pc=0;wr=0;data_e=0; end
3'b100:begin sel=0;rd=0;ld_ir=0;halt=HLT;inc_pc=1;ld_ac=0;ld_pc=0;wr=0;data_e=0;end
3'b101:begin sel=0;rd=ALU_OP;ld_ir=0;halt=0;inc_pc=0;ld_ac=0;ld_pc=0;wr=0;data_e=0; end
3'b110:begin sel=0;rd=ALU_OP;ld_ir=0;halt=0;inc_pc=SKZ&&zero;ld_ac=0;ld_pc=JMP;wr=0;data_e=STO; end
3'b111:begin sel=0;rd=ALU_OP;ld_ir=0;halt=0;inc_pc=0;ld_ac=ALU_OP;ld_pc=JMP;wr=STO;data_e=STO;end
endcase
end

endmodule
