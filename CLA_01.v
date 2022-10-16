`timescale 1ns / 1ps

module CLA_01(output sum,
              output cout,
              input a,
              input b,
              input cin);

parameter N = 32;        
parameter GS = 8;  
wire [N:1] a, b;
wire [N:0] g, p;
wire [N:0] G, P;
wire [N:1] sum; 


wire [N/GS:0] pn;
wire [N/GS:0] gn;
assign g[0] = cin,
       p[0] = 1'b0;

assign G[0] = g[0],
       P[0] = 1'b0;
     
genvar i;
                     
generate for(i = 1; i <= N; i = i + 1) begin: bitPG
    assign g[i] = a[i] & b[i],
           p[i] = a[i] ^ b[i];
    end
endgenerate
         
genvar j,k;

generate for(j = 0; j < N; j = j + GS ) begin: GPLogic
    
    Var_Val_BC vvbc01(gn[j/GS], pn[j/GS], g[j+GS:j+1], p[j+GS:j+1]);

    assign G[j+GS] = gn[j/GS] | pn[j/GS] & G[j];
    
    for (k = j+1; k <= GS -1+j; k = k + 1) begin:  abc
        assign G[k] = g[k] | p[k] & G[k-1];
    end
    end
    
endgenerate

genvar l;
generate for (l = 1; l <= N; l = l+1) begin: sumLogic

    assign sum[l] = p[l] ^ G[l-1];
    
    if (l == N)
        assign cout = G[N];
    
end
endgenerate



 
endmodule
