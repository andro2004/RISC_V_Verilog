module memory#(parameter AWIDTH=5,DWIDTH=8)(addr,data,clk,wr,rd);

input [AWIDTH-1:0]addr;
input wr,rd,clk;
inout reg[DWIDTH-1:0]data;

reg [DWIDTH-1:0] mem[31:0];

assign data = (rd)? mem[addr]:0;

always@(posedge clk) begin

if (wr) mem[addr]=data;

end
endmodule
