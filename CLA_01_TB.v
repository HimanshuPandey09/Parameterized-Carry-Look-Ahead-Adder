`timescale 1ns / 1ps



module CLA_01_TB();


parameter N = 32;
//wire [N-1:0] G,P;
reg [N:1] a,b;
reg cin;
wire cout;
wire [N:1] sum;


CLA_01 CLA01(sum,cout,a,b,cin);

initial begin
//    a = 8'b00001110;
//    b = 8'b00001011;
//    a = 16'b0000000001101100;
//    b = 16'b0000001000110010;
//    cin = 1'b0;
//    #50 a = 16'h3A9A; b = 16'hE544; cin = 1'b0;
    #50 a = 32'hD47856ED; b = 32'hDCBE1597 ; cin = 1'b1;
    #20 $finish;
end
endmodule

