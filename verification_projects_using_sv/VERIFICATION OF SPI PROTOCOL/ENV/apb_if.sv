//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: interface for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


interface abp_if;

  logic preset_n;
  logic pclk;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] paddr,pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;
  
endinterface