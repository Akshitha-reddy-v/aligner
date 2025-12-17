///////////////////////////////////////////////////////////////////////////////
// File:        algn_vseq_legal_rx.sv
// Author:      Akshitha
// Date:        12-11-2025
// Description: Virtual sequence for testing legal MD RX traffic behaviour.
///////////////////////////////////////////////////////////////////////////////

`ifndef ALGN_VSEQ_LEGAL_RX_SV
`define ALGN_VSEQ_LEGAL_RX_SV
	
class algn_vseq_legal_rx extends cfs_algn_virtual_sequence_base;
	// Factory registration
	`uvm_object_utils(algn_vseq_legal_rx)

	// Virtual interface handle
	virtual cfs_algn_if vif;

	md_sequence_legal_rx rx_seq;
	int unsigned data_width;

	// Constructor
	function new(string name = "");
		super.new(name);
	endfunction

	// write legal configuration to CTRL register
	task automatic cfg_ctrl_reg(int unsigned size_val, int unsigned offset_val);
		uvm_status_e status;	
		uvm_reg_data_t ctrl_value;

		ctrl_value = (size_val << p_sequencer.model.reg_block.CTRL.SIZE.get_lsb_pos()) |
			     (offset_val << p_sequencer.model.reg_block.CTRL.OFFSET.get_lsb_pos());
		// write to control(CTRL) register
		p_sequencer.model.reg_block.CTRL.write(status, ctrl_value, .parent(this));
		`uvm_info("CTRL REG CONFIGURING", $sformatf("CTRL reg configured: %0h", p_sequencer.model.reg_block.CTRL.get_mirrored_value()), UVM_LOW)

	endtask

	// write to IRQ register
	task automatic cfg_irq_reg(int unsigned rxempty_val, int unsigned txempty_val);
		uvm_status_e status;	
		uvm_reg_data_t irq_value;

		irq_value =    (rxempty_val<< p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_lsb_pos()) 
			     | (txempty_val << p_sequencer.model.reg_block.IRQ.TX_FIFO_EMPTY.get_lsb_pos());
		// write to Interrupt request(IRQ) register
		p_sequencer.model.reg_block.IRQ.write(status, irq_value, .parent(this));
		`uvm_info("IRQ REG CONFIGURING", $sformatf("==========RX_FIFO_EMPTY: %0d | TX_FIFO_EMPTY: %0d==========", 
			p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_mirrored_value(),
			p_sequencer.model.reg_block.IRQ.TX_FIFO_EMPTY.get_mirrored_value()), UVM_LOW)

	endtask

	// read the cnt_drop value in status reg
	task automatic rd_status_reg();
		uvm_status_e status;	
		uvm_reg_data_t status_value;

		// read from STATUS register
		p_sequencer.model.reg_block.STATUS.read(status, status_value);
		`uvm_info("STATUS REG", $sformatf("CNT_DROP: %0d | RX_LVL: %0d | TX_LVL: %0d", 
			p_sequencer.model.reg_block.STATUS.CNT_DROP.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.RX_LVL.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.TX_LVL.get_mirrored_value()), UVM_LOW)

	endtask

	// body()
	virtual task body();
			
		`uvm_info(get_type_name(), "Starting legal RX test sequence", UVM_LOW)

		// Get virtual interface from env_config
		vif = p_sequencer.model.env_config.get_vif();
		if (vif == null)
			`uvm_fatal("LEGAL VSEQ", "Failed to get virtual interface handle")
		// Get data width
		data_width = p_sequencer.model.env_config.get_algn_data_width();
		$display("data_width = %0d",data_width);
		
		// configure register
		cfg_ctrl_reg(2,0);
		//cfg_ctrl_reg(1,3);

		rd_status_reg();
		$display();
		rd_status_reg();


		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);


		// Start legal RX transactions
		for(int i=0;i<100;i++) begin
			rx_seq = md_sequence_legal_rx::type_id::create("rx_seq");
			//rx_seq.data_width = p_sequencer.model.env_config.get_algn_data_width();
			rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);
			rx_seq.start(p_sequencer.md_rx_sequencer);
			/*if(i==48)
				cfg_irq_reg(1,0);
			if(i==50)
				cfg_irq_reg(0,1);
			if(i==20)
				cfg_ctrl_reg(1,1);
			if(i==30)
				cfg_ctrl_reg(1,2);
			if(i==40)
				cfg_ctrl_reg(2,2);
			if(i==50)
				cfg_ctrl_reg(1,3);
			else
				$display();*/

			
				
		end

		//cfg_irq_reg(1,1);

		// delay
		repeat(30) @(posedge vif.clk);



		`uvm_info(get_type_name(), "Completed legal RX test sequence", UVM_LOW)
			
	endtask

endclass

`endif

