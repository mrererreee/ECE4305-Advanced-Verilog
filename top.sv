`timescale 1ns / 1ps

module top(
       input logic clk,
       input logic [8:0] addr,
       input logic select,
       output logic [6:0] sseg,
       output logic [7:0] an
    );
    
    logic [7:0] out1, out2, mux_out;
    
    synch_rom #("tempConvs.mem") rom1 (
        .clk(clk),
        .addr(addr),
        .data(out1)
    );    
    
    logic[11:0] data_bcd;
    
    bin2BCD bin2bcdIN (
	   .binary(out1),
	   .Hundreds(data_bcd[11:8]),
	   .Tens(data_bcd[7:4]),
	   .Ones(data_bcd[3:0])
	);
	
	logic[11:0] input_bcd;
	
	bin2BCD bin2bcdOUT (
	   .binary(addr),
	   .Hundreds(input_bcd[11:8]),
	   .Tens(input_bcd[7:4]),
	   .Ones(input_bcd[3:0])
	);
	
    
 /*   binary_counter counter(
        .clk(clk),
        .reset(1'b0),
        .q(),
        .en(1'b1), // input
        .max_tick(),
        .*
    ); */
    
    time_mux_disp disp (
        .in0({1'b1, data_bcd[3:0], 1'b1}),
        .in1({1'b1, data_bcd[7:4], 1'b1}),
        .in2({1'b1, data_bcd[11:8],1'b1}),
        .in3(),
        .in4({1'b1, input_bcd[3:0], 1'b1}),
        .in5({1'b1, input_bcd[7:4], 1'b1}),
        .in6({1'b1, input_bcd[11:8], 1'b1}),
        .in7(),
        .dp(),
        .*
    );
    
endmodule