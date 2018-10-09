`timescale 1ns / 1ps

module Top(
    input wire clk,
    input wire rst,
    input wire [4: 0] addr,
    output wire [31: 0] RegData,
    output wire [31: 0] InstructionRegister,
    output wire [31: 0] currentPC
);

    reg [31: 0] PC, IR, MDR, ALUOut, A, B;
    reg [3: 0] State;
    
    wire PCWrite, IorD, MemRead, MemWrite, IRWrite, ALUSrcA, RegWrite, RegDst, MemtoReg, PCWriteCond, zero;
    wire [1: 0] PCSource, ALUOp, ALUSrcB;
    wire [3: 0] NextState;
    wire [31: 0] MemData, ImmExt, ALUResult, ReadData1, ReadData2, NextPC;
    wire [2: 0] ALUOperation;
    
    assign InstructionRegister = IR;
    assign currentPC = PC;

    Control c0(
        .Op(IR[31: 26]),
        .State(State),
        .PCWriteCond(PCWriteCond),
        .PCWrite(PCWrite),
        .IorD(IorD),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .IRWrite(IRWrite),
        .PCSource(PCSource),
        .ALUOp(ALUOp),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .NextState(NextState)
    );
    
    Mem m0(
        .clka(clk),
        .wea(MemWrite),
        .addra(IorD ? ALUOut : (PC >> 2)),
        .dina(B),
        .douta(MemData)
    );
    
    SignExtend s0(
        .i(IR[15: 0]),
        .o(ImmExt)
    );
    
    ALUControl a0(
        .Func(IR[5: 0]),
        .ALUOp(ALUOp),
        .ALUOperation(ALUOperation)
    );
    
    ALU a1(
        .A(ALUSrcA ? A : PC),
        .B(ALUSrcB == 2'd0 ? B : (ALUSrcB == 2'd1 ? 32'd4 : (ALUSrcB == 2'd2 ? ImmExt : (ImmExt << 2)))),
        .ALUOperation(ALUOperation),
        .result(ALUResult),
        .zero(zero)
    );
    
    Registers r0(
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .ReadRegAddr1(IR[25: 21]),
        .ReadRegAddr2(IR[20: 16]),
        .ReadRegAddr3(addr),
        .WriteRegAddr(RegDst ? IR[15: 11] : IR[20: 16]),
        .WriteData(MemtoReg ? MDR : ALUOut),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ReadData3(RegData)
    );
    
    assign NextPC = 
        PCSource == 2'd0 ? ALUResult : (
            PCSource == 2'd1 ? ALUOut : ({PC[31: 28], IR[25: 0], 2'b0})
        );
    
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            IR <= 32'b0;
            MDR <= 32'b0;
            ALUOut <= 32'b0;
            A <= 32'b0;
            B <= 32'b0;
            PC <= 32'b0;
            State <= 32'b0;
        end else begin
            if (IRWrite)
                IR <= MemData;
            MDR <= MemData;
            ALUOut <= ALUResult;
            A <= ReadData1;
            B <= ReadData2;
            if (PCWrite || (PCWriteCond && zero))
                PC <= NextPC;
            State <= NextState;
        end
    end

endmodule
