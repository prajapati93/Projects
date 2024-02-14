////////////////////////////////////////////////
// RAM Verification in SV
// File description: Package which includes all the components from env and test layers.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`include "ram_interface.sv"
package ram_pkg;
 
  `include "ram_defines.sv"
  `include "ram_trans.sv"
  `include "ram_gen.sv"
  `include "ram_rd.sv"
  `include "ram_rm.sv"
  `include "ram_rf.sv"
  `include "ram_sb.sv"
  `include "ram_wd.sv"
  `include "ram_wm.sv"
  `include "ram_env.sv"
  
  //testcases
  `include "ram_wr_test.sv"
  `include "ram_sim_test.sv"
  `include "ram_mem_test.sv"
  `include "ram_lr_test.sv"
  `include "ram_hr_test.sv"
  `include "ram_rst_test.sv"
  `include "ram_base_test.sv"
  
endpackage