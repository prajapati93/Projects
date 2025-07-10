`ifndef AFIFO_ENV
`define AFIFO_ENV

class afifo_env;

    afifo_gen       gen_h;
    afifo_trans     trans_h;
    afifo_drv       drv_h;
    afifo_mon       mon_h;
    afifo_rf        rf_h;
    afifo_sb        sb_h;

    //Virtual interface for driver and monitor
    virtual afifo_interface.WR_DRV_MP d_wvif;
    virtual afifo_interface.RD_DRV_MP d_rvif;

    virtual afifo_interface.WR_MON_MP m_wvif;
    virtual afifo_interface.RD_MON_MP m_rvif;


 //Mailboxes declared as new 
   mailbox #(afifo_trans) gen_drv = new();  
   mailbox #(afifo_trans) drv_rf = new();
   mailbox #(afifo_trans) mon_rf = new();
   mailbox #(afifo_trans) mon_sb = new();
   mailbox #(afifo_trans) rf_sb = new();

  //Constructor method for interfaces
    function new ( virtual afifo_interface.WR_DRV_MP d_wvif,
                   virtual afifo_interface.RD_DRV_MP d_rvif,
                   virtual afifo_interface.WR_MON_MP m_wvif,
                   virtual afifo_interface.RD_MON_MP m_rvif);

         this.d_wvif  = d_wvif;
         this.d_rvif  = d_rvif;
         this.m_wvif  = m_wvif;
         this.m_rvif  = m_rvif;
    endfunction
 
    //Methods to build using mailboxes and to call run method from each class instance  
    extern function void build ();
    extern task run();
    
endclass 

function void afifo_env::build ();
        gen_h = new(gen_drv);
        drv_h = new(d_wvif,d_rvif,gen_drv);
        mon_h = new(m_wvif,m_rvif,mon_sb,mon_rf);
        rf_h  = new(mon_rf,rf_sb);
        sb_h  = new(rf_sb,mon_rf);
endfunction

task afifo_env::run();
    fork
		gen_h.run();
		drv_h.run();
		mon_h.run();
		rf_h.run();
		sb_h.run();
    join_none
endtask
	
`endif
