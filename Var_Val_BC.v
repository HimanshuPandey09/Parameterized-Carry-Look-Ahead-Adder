`timescale 1ns / 1ps

module Var_Val_BC(output outG,
                  output outP,
                  input g,
                  input p);
parameter N = 32;
parameter GS = 8;               
wire [GS:1] g, p;
wire [GS:1] GI;  // Generate Intermediate.
wire [GS-1:1] PI;

assign GI[1] = g[1];
assign PI[1] = p[1]&p[2];
genvar i;
generate for (i = 2; i <= GS; i = i + 1) begin: abc
    
    assign GI[i] = g[i] | (p[i]&GI[i-1]);
    if(i<GS)
        assign PI[i] = PI[i-1] & p[i+1];     
    if(i == GS)
        assign outG = GI[GS];
        assign outP = PI[GS-1];
    
    
    end
endgenerate



endmodule
