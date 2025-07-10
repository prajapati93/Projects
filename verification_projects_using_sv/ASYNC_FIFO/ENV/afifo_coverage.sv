
class afifo_coverage();
  
  afifo_trans t_h;

  covergroup cvg();
	din 	: coverpoint t_h.din{
			bins D0 = {[0:3]}; 
			bins D1 = {[4:7]};
			bins D2 = {[8:11]};
			bins D3 = {[12:15]};	 	 
					}
	wr_en 	: coverpoint t_h.wr_en{
			bins WENB_SET = (0 => 1);
			bins WENB_RST= (1 => 0);
								   }

	rd_enb : coverpoint t_h.rd_en{
					bins RENB_SET = (0 => 1);
					bins RENB_RST= (1 => 0);
								   }

	empty : coverpoint t_h.empty{
					bins EMP_SET = (0 => 1);
					bins EMP_RST = (1 => 0);
								  }

	al_empty : coverpoint t_h.almost_empty{
					bins A_EMP_SET = (0 => 1);
					bins A_EMP_RST = (1 => 0);
										 }

	full : coverpoint t_h.full{
					bins FULL_SET = (0 => 1);
					bins FULL_RST = (1 => 0);
								 }

	al_full: coverpoint t_h.almost_full{
					bins A_FULL_SET = (0 => 1);
					bins A_FULL_RST = (1 => 0);
										}

	wr_ack : coverpoint t_h.wr_ack{
					bins W_ACK_SET = (0 => 1);
					bins W_ACK_RST = (1 => 0);
								   }
	rd_ack : coverpoint t_h.rd_ack{
					bins R_ACK_SET = (0 => 1);
					bins R_ACK_RST = (1 => 0);
								   }

	wr_err : coverpoint t_h.wr_err{
					bins WR_ERR_SET = (0 => 1);
					bins WR_ERR_RST = (1 => 0);
								   }

	rd_err : coverpoint t_h.rd_err{
					bins RD_ERR_SET = (0 => 1);
					bins RD+ERR_RST = (1 => 0);
								   }

	clear : coverpoint t_h.clear_n{
					bins CLR_SET = (0 => 1);
					bins CLR_RST = (1 => 0);
								   }

  endgroup 


endclass
