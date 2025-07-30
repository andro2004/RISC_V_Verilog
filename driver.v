module driver #(parameter WIDTH=8) (data_in,data_out,data_en);

input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;
input data_en;

always @(*)
begin

if(data_en)data_out=data_in;
else
data_out=8'bzzzzzzzz;

end

endmodule
