`timescale 1ns / 1ps

module Control(
    input wire [5: 0] Op,
    input wire [3: 0] State,
    output reg PCWriteCond,
    output reg PCWrite,
    output reg IorD,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,
    output reg [1: 0] PCSource,
    output reg [1: 0] ALUOp,
    output reg [1: 0] ALUSrcB,
    output reg ALUSrcA,
    output reg RegWrite,
    output reg RegDst,
    output reg [3: 0] NextState
);

    wire LW, SW, R, Jump, BEQ;
    assign LW = Op == 6'b10_0011;
    assign SW = Op == 6'b10_1011;
    assign R = Op == 6'b00_0000;
    assign Jump = Op == 6'b00_0010;
    assign BEQ = Op == 6'b00_0100;
    
    always @* begin
        // NextState
        case (State)
            4'd0:
                NextState = 4'd1;
            4'd1:
                if (Jump)
                    NextState = 4'd9;
                else if (R)
                    NextState = 4'd6;
                else if (SW || LW)
                    NextState = 4'd2;
                else if (BEQ)
                    NextState = 4'd8;
            4'd2:
                if (LW)
                    NextState = 4'd3;
                else if (SW)
                    NextState = 4'd5;
            4'd3:
                NextState = 4'd4;
            4'd4, 4'd5:
                NextState = 4'd0;
            4'd6:
                NextState = 4'd7;
            4'd7, 4'd8, 4'd9:
                NextState = 4'd0;
        endcase
    end
    
    always @* begin
        // PCWriteCond
        if (State == 4'd8)
            PCWriteCond = 1'b1;
        else
            PCWriteCond = 1'b0;
    end
    
    always @* begin
        // PCWrite
        case (State)
            4'd0:
                PCWrite = 1'b1;
            4'd1:
                PCWrite = 1'b0;
            4'd2:
                PCWrite = 1'b0;
            4'd3:
                PCWrite = 1'b0;
            4'd4:
                PCWrite = 1'b0;
            4'd5:
                PCWrite = 1'b0;
            4'd6:
                PCWrite = 1'b0;
            4'd7:
                PCWrite = 1'b0;
            4'd8:
                PCWrite = 1'b0;
            4'd9:
                PCWrite = 1'b1;
        endcase
    end
    
    always @* begin
        // IorD
        case (State)
            4'd0:
                IorD = 1'b0;
            4'd1:
                IorD = 1'bx;
            4'd2:
                IorD = 1'bx;
            4'd3:
                IorD = 1'b1;
            4'd4:
                IorD = 1'bx;
            4'd5:
                IorD = 1'b1;
            4'd6:
                IorD = 1'bx;
            4'd7:
                IorD = 1'bx;
            4'd8:
                IorD = 1'bx;
            4'd9:
                IorD = 1'bx;
        endcase
    end
    
    always @* begin
        // MemRead
        case (State)
            4'd0:
                MemRead = 1'b1;
            4'd1:
                MemRead = 1'b0;
            4'd2:
                MemRead = 1'b0;
            4'd3:
                MemRead = 1'b1;
            4'd4:
                MemRead = 1'b0;
            4'd5:
                MemRead = 1'b0;
            4'd6:
                MemRead = 1'b0;
            4'd7:
                MemRead = 1'b0;
            4'd8:
                MemRead = 1'b0;
            4'd9:
                MemRead = 1'b0;
        endcase
    end
    
    always @* begin
        // MemWrite
        case (State)
            4'd0:
                MemWrite = 1'b0;
            4'd1:
                MemWrite = 1'b0;
            4'd2:
                MemWrite = 1'b0;
            4'd3:
                MemWrite = 1'b0;
            4'd4:
                MemWrite = 1'b0;
            4'd5:
                MemWrite = 1'b1;
            4'd6:
                MemWrite = 1'b0;
            4'd7:
                MemWrite = 1'b0;
            4'd8:
                MemWrite = 1'b0;
            4'd9:
                MemWrite = 1'b0;
        endcase
    end
    
    always @* begin
        // MemtoReg
        case (State)
            4'd0:
                MemtoReg = 1'bx;
            4'd1:
                MemtoReg = 1'bx;
            4'd2:
                MemtoReg = 1'bx;
            4'd3:
                MemtoReg = 1'bx;
            4'd4:
                MemtoReg = 1'b1;
            4'd5:
                MemtoReg = 1'bx;
            4'd6:
                MemtoReg = 1'bx;
            4'd7:
                MemtoReg = 1'b0;
            4'd8:
                MemtoReg = 1'bx;
            4'd9:
                MemtoReg = 1'bx;
        endcase
    end
    
    always @* begin
        // IRWrite
        case (State)
            4'd0:
                IRWrite = 1'b1;
            4'd1:
                IRWrite = 1'b0;
            4'd2:
                IRWrite = 1'b0;
            4'd3:
                IRWrite = 1'b0;
            4'd4:
                IRWrite = 1'b0;
            4'd5:
                IRWrite = 1'b0;
            4'd6:
                IRWrite = 1'b0;
            4'd7:
                IRWrite = 1'b0;
            4'd8:
                IRWrite = 1'b0;
            4'd9:
                IRWrite = 1'b0;
        endcase
    end
    
    always @* begin
        // PCSource
        case (State)
            4'd0:
                PCSource = 2'b00;
            4'd1:
                PCSource = 2'bxx;
            4'd2:
                PCSource = 2'bxx;
            4'd3:
                PCSource = 2'bxx;
            4'd4:
                PCSource = 2'bxx;
            4'd5:
                PCSource = 2'bxx;
            4'd6:
                PCSource = 2'bxx;
            4'd7:
                PCSource = 2'bxx;
            4'd8:
                PCSource = 2'b01;
            4'd9:
                PCSource = 2'b10;
        endcase
    end
    
    always @* begin
        // ALUOp
        case (State)
            4'd0:
                ALUOp = 2'b00;
            4'd1:
                ALUOp = 2'b00;
            4'd2:
                ALUOp = 2'b00;
            4'd3:
                ALUOp = 2'bxx;
            4'd4:
                ALUOp = 2'bxx;
            4'd5:
                ALUOp = 2'bxx;
            4'd6:
                ALUOp = 2'b10;
            4'd7:
                ALUOp = 2'bxx;
            4'd8:
                ALUOp = 2'b01;
            4'd9:
                ALUOp = 2'bxx;
        endcase
    end
    
    always @* begin
        // ALUSrcB
        case (State)
            4'd0:
                ALUSrcB = 2'b01;
            4'd1:
                ALUSrcB = 2'b11;
            4'd2:
                ALUSrcB = 2'b10;
            4'd3:
                ALUSrcB = 2'bxx;
            4'd4:
                ALUSrcB = 2'bxx;
            4'd5:
                ALUSrcB = 2'bxx;
            4'd6:
                ALUSrcB = 2'b00;
            4'd7:
                ALUSrcB = 2'bxx;
            4'd8:
                ALUSrcB = 2'b00;
            4'd9:
                ALUSrcB = 2'bxx;
        endcase
    end
    
    always @* begin
        // ALUSrcA
        case (State)
            4'd0:
                ALUSrcA = 1'b0;
            4'd1:
                ALUSrcA = 1'b0;
            4'd2:
                ALUSrcA = 1'b1;
            4'd3:
                ALUSrcA = 1'bx;
            4'd4:
                ALUSrcA = 1'bx;
            4'd5:
                ALUSrcA = 1'bx;
            4'd6:
                ALUSrcA = 1'b1;
            4'd7:
                ALUSrcA = 1'bx;
            4'd8:
                ALUSrcA = 1'b1;
            4'd9:
                ALUSrcA = 1'bx;
        endcase
    end
    
    always @* begin
        // RegWrite
        case (State)
            4'd0:
                RegWrite = 1'b0;
            4'd1:
                RegWrite = 1'b0;
            4'd2:
                RegWrite = 1'b0;
            4'd3:
                RegWrite = 1'b0;
            4'd4:
                RegWrite = 1'b1;
            4'd5:
                RegWrite = 1'b0;
            4'd6:
                RegWrite = 1'b0;
            4'd7:
                RegWrite = 1'b1;
            4'd8:
                RegWrite = 1'b0;
            4'd9:
                RegWrite = 1'b0;
        endcase
    end
    
    always @* begin
        // RegDst
        case (State)
            4'd0:
                RegDst = 1'bx;
            4'd1:
                RegDst = 1'bx;
            4'd2:
                RegDst = 1'bx;
            4'd3:
                RegDst = 1'bx;
            4'd4:
                RegDst = 1'b0;
            4'd5:
                RegDst = 1'bx;
            4'd6:
                RegDst = 1'bx;
            4'd7:
                RegDst = 1'b1;
            4'd8:
                RegDst = 1'bx;
            4'd9:
                RegDst = 1'bx;
        endcase
    end
    
endmodule
