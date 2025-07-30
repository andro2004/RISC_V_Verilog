module  counter #(parameter WIDTH=5)(cnt_in,cnt_out,enab,load,clk,rst);

input [WIDTH-1:0] cnt_in;
output reg [WIDTH-1:0] cnt_out;
input enab,load,clk,rst;

always@(posedge clk)begin

if(rst) cnt_out<=0;
else if(!load) cnt_out<=cnt_out+1;
else cnt_out<=cnt_in;

end

endmodule
