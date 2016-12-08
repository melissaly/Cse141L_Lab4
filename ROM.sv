module ROM(
	input [4:0] immediate,
	output [7:0] address
	);

	always_comb
	case(immediate)
		0: address = 1;
		1: address = 2; 
		2: address = 3;
		3: address = 4;
		4: address = 5;
		5: address = 6;
		6: address = 7;
		7: adress = 19;
		8: address = 20;
		9: address = 32;
		10: address = 64;
		11: addresss = 127;
		12: address = 128;
		13: address = 255;
		default: address = 0;
	endcase
endmodule

