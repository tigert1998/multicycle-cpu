`timescale 1ns / 1ps

module test_Top;

	// Inputs
	reg clk;
	reg rst;
	reg [4:0] addr;

	// Outputs
	wire [31:0] RegData, IR, PC;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.RegData(RegData),
		.InstructionRegister(IR),
		.currentPC(PC)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		addr = 5'd15;

		// Wait 100 ns for global reset to finish
		#100;
		
		rst = 0;
		
		#100;
        
		// Add stimulus here
		
		forever begin
			clk = ~clk;
			#100;
		end

	end
      
endmodule

