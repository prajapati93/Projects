class read_only_test extends afifo_gen;

    function new(mailbox #(afifo_trans)gen_drv);
       super.new(gen_drv);
    endfunction

    virtual task run();
      t_h = new();  
       repeat(iteration)begin 
          assert(t_h.randomize() with {wr_en==0; rd_en==1; clear_n==1;});
          t_h1 = new t_h;
          gen_drv.put(t_h1);
       end
    endtask 

endclass