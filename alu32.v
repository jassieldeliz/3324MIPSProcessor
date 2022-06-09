`timescale 1ns / 1ps


module alu32(               //top 32-bit alu module
   output[31:0] d,          //alu output d
   output Cout, V,          //alu carry-out
   input [31:0] a, b,       //alu inputs a and b
   input Cin,               //alu input carry-in
   input [2:0] S,            //alu operation select code
   output reg Z
   );
   wire [31:0] c, g, p;     
   wire gout, pout;     
   
   always@(d) begin         //zero detector 
        if(d == 0)
            Z = 1;
        else
            Z = 0; 
   end     
   
   alu_cell alucell[31:0] ( //structural alu cell module
      .d(d),
      .g(g),
      .p(p),
      .a(a),
      .b(b),
      .c(c),
      .S(S)
   );
   
   lac5 laclevel5(
      .c(c),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(g),
      .p(p)
   );

   overflow over(       //structural module to detect overflow
    .Cout(Cout),
    .V(V),
    .c31(c[31]),
    .gout(gout),
    .pout(pout),
    .Cin(Cin)
   );   
  
endmodule



module alu_cell (d, g, p, a, b, c, S);  //behavioral alu module
   output d, g, p;
   input a, b, c;
   input [2:0] S;      
   reg g,p,d,cint,bint;
     
   always @(a,b,c,S,p,g) begin 
     bint = S[0] ^ b;
     g = a & bint;
     p = a ^ bint;
     cint = S[1] & c;
     if(S[2] == 1)
         case(S[1:0])
            2'b00: d = a|b;
            2'b01: d = ~(a|b);
            2'b10: d = a&b;
            2'b11: d = 0;
         endcase
      else if(S[2] == 0)
            d = p ^ cint;
end
endmodule


module overflow (Cin, c31, Cout, V, gout, pout);    //behavioral overflow module
    output Cout;
    output V;
    input Cin;
    input c31;
    input gout;
    input pout;
    
    
    assign Cout = gout | (pout & Cin);  //detects overflow for unsigned numbers
    assign V = c31 ^ Cout;              //detects over/underflow for signed numbers
    
endmodule


module lac(c, gout, pout, Cin, g, p);   //look-ahead-carry module

   output [1:0] c;
   output gout;
   output pout;
   input Cin;
   input [1:0] g;
   input [1:0] p;

   assign c[0] = Cin;
   assign c[1] = g[0] | ( p[0] & Cin );
   assign gout = g[1] | ( p[1] & g[0] );
   assign pout = p[1] & p[0];
	
endmodule


module lac2 (c, gout, pout, Cin, g, p); //second layer LAC
   output [3:0] c;
   output gout, pout;
   input Cin;
   input [3:0] g, p;
   
   wire [1:0] cint, gint, pint;
   
   lac leaf0(
      .c(c[1:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[1:0]),
      .p(p[1:0])
   );
   
   lac leaf1(       //lac leaf
      .c(c[3:2]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[3:2]),
      .p(p[3:2])
   );
   
   lac root(        //lac leaf
      .c(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );
endmodule   


module lac3 (c, gout, pout, Cin, g, p);     //third layer LAC
   output [7:0] c;
   output gout, pout;
   input Cin;
   input [7:0] g, p;
   
   wire [1:0] cint, gint, pint;
   
   lac2 leaf0(      
      .c(c[3:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[3:0]),
      .p(p[3:0])
   );
   
   lac2 leaf1(
      .c(c[7:4]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[7:4]),
      .p(p[7:4])
   );
   
   lac root(
      .c(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );
endmodule


module lac4 (c, gout, pout, Cin, g, p);     //fourth layer LAC
   output [15:0] c;
   output gout, pout;
   input Cin;
   input [15:0] g, p;

   wire [1:0] cint, gint, pint;

   lac3 leaf0(
      .c(c[7:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[7:0]),
      .p(p[7:0])      
   );

   lac3 leaf1(
      .c(c[15:8]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[15:8]),
      .p(p[15:8])
   );

   lac root(
      .c(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );

endmodule


module lac5 (c, gout, pout, Cin, g, p); //fifth layer LAC
   output [31:0] c;
   output gout, pout;
   input Cin;
   input [31:0] g, p;

   wire [1:0] cint, gint, pint;

   lac4 leaf0(
      .c(c[15:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[15:0]),
      .p(p[15:0])      
   );

    lac4 leaf1(
      .c(c[31:16]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[31:16]),
      .p(p[31:16])
   );

   lac root(
      .c(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );
endmodule
