//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: interface for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


interface apb_if();

  logic pclk;
  logic preset_n;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] paddr,pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;
  
endinterface