`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2024 10:30:03 PM
// Design Name: 
// Module Name: synch_rom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module synch_rom
    #(parameter file = "file_name.mem")(
        input logic clk,
        input logic [8:0] addr,
        output logic [7:0] data
    );
    
    // signal declaration
    (*rom_style = "block" *)logic [7:0] rom [0:511];
    
    initial
        $readmemb(file, rom);
        
    always_ff @(posedge clk) begin
        if(addr[8]) begin
            data <= rom[addr[7:0] + 256];
        end else begin
            data <= rom[addr];
        end
    end    
    
endmodule
