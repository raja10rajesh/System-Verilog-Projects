`include "eth32bit.v"
///////////////////
// Company: VITAP
// Engineer:  Rajesh K
// 
// Create Date: 15.05.2020 16:08:03
// Design Name:  Project_17BEV7015
// Module Name: eth32bit
// Project Name: design and verification of Ethernet switch
// Tool Versions:  synopsys
// Compile Options: -timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog
// Run Options:	+UVM_TESTNAME=eth_wr_rd_test +UVM_VERBOSITY=UVM_LOW
// Dependencies: UVM 1.2 library
// 
// Revision: 3.02 21-05-2020 12:54 AM
// Revision 0.01 - File Created
// Additional Comments: made by rajesh 
// 
//////////////////////////////////////////////////////////////////////////////////

//this module emulates the functioning of Ethernet switch 
//features like packet delivery adressing and port mapping are emulated here
//UPD inspired NOT UDP packet used, 
//**********32 bit single packet is used.**************

//------------------------------------------------------------------------
/*
              -----------------
              |               |
 inDataA ---->|               |<---inDataB
     Ain ---->|               |<---Bin
              |               |
 outDataA<----|               |--->outDataB
    Aout <----|               |--->Bout
			  |               |
              |               |
              |               |
              | Eth Switchl   |
              |               |
              |               |
              -----------------
                   ^     ^
                   |     |
                  clk  rst_n
                  
Packet format
              LSB                                      MSB
              0                               30   31   32
              --------------------------------------------
              |      Data bits       |Address bits(last2)|
              --------------------------------------------

-------------------------------------------------------------------------- */
