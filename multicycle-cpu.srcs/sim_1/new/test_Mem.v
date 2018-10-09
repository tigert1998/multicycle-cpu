`timescale 1ns / 1ps

module test_Mem;

    reg clk, wea;
    reg [9: 0] addra;
    reg [31: 0] dina;
    wire [31: 0] douta;

    Mem uut(
        .clka(clk),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .douta(douta)
    );
    
    initial begin
        clk = 0;
        wea = 0;
        addra = 10'd1;
        dina = 32'd10086;
        
        #100;
        clk = 1;
        
        #100;
        clk = 0;
    end

endmodule