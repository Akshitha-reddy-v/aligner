///////////////////////////////////////////////////////////////////////////////
// File:        algn_vseq_reg_access.sv
// Author:      Akshitha
// Date:        08-12-2025
// Description: Virtual sequence for testing various register access behaviour.
///////////////////////////////////////////////////////////////////////////////

`ifndef ALGN_VSEQ_REG_ACCESS_SV
`define ALGN_VSEQ_REG_ACCESS_SV
	
class algn_vseq_reg_access extends cfs_algn_virtual_sequence_base;
	// Factory registration
	`uvm_object_utils(algn_vseq_reg_access)

	// Virtual interface handle
	virtual cfs_algn_if vif;

	md_sequence_legal_rx legal_seq;
	md_sequence_illegal_rx illegal_seq;
	int unsigned data_width;

	// Constructor
	function new(string name = "");
		super.new(name);
	endfunction

	// Write to CTRL register
	task automatic cfg_ctrl_reg(int unsigned size_val, int unsigned offset_val, bit clr_val = 0);
		uvm_status_e status;	
		uvm_reg_data_t ctrl_value;

		ctrl_value =   (size_val   << p_sequencer.model.reg_block.CTRL.SIZE.get_lsb_pos()) 
			     | (offset_val << p_sequencer.model.reg_block.CTRL.OFFSET.get_lsb_pos())
			     | (clr_val    << p_sequencer.model.reg_block.CTRL.CLR.get_lsb_pos());
		// write to control(CTRL) register
		p_sequencer.model.reg_block.CTRL.write(status, ctrl_value, .parent(this));
		`uvm_info("CTRL REG CONFIGURING", $sformatf("OFFSET: %0d | SIZE: %0d | CLR: %0d", 
			p_sequencer.model.reg_block.CTRL.OFFSET.get_mirrored_value(),
			p_sequencer.model.reg_block.CTRL.SIZE.get_mirrored_value(),
			p_sequencer.model.reg_block.CTRL.CLR.get_mirrored_value()), UVM_LOW)

	endtask

	// Read clr value from CTRL register
	task automatic rd_clr_val();
		uvm_status_e status;	
		uvm_reg_data_t ctrl_value;

		//ctrl_value =   (clr_val    << p_sequencer.model.reg_block.CTRL.CLR.get_lsb_pos());

		p_sequencer.model.reg_block.CTRL.read(status, ctrl_value);
		`uvm_info("READ CLR VALUE", $sformatf("CLR: %0d", 
			p_sequencer.model.reg_block.CTRL.CLR.get_mirrored_value()), UVM_LOW)

	endtask



	// write to status reg
	task automatic wr_status_reg(int unsigned cnt_drop_val, int unsigned rx_lvl_val, int unsigned tx_lvl_val);
		uvm_status_e status;	
		uvm_reg_data_t status_value;
		
		status_value = (cnt_drop_val   << p_sequencer.model.reg_block.STATUS.CNT_DROP.get_lsb_pos()) 
			     | (rx_lvl_val     << p_sequencer.model.reg_block.STATUS.RX_LVL.get_lsb_pos())
			     | (tx_lvl_val     << p_sequencer.model.reg_block.STATUS.TX_LVL.get_lsb_pos());
		
		p_sequencer.model.reg_block.STATUS.write(status, status_value, .parent(this));
		`uvm_info("STATUS REG", $sformatf("CNT_DROP: %0d | RX_LVL: %0d | TX_LVL: %0d", 
			p_sequencer.model.reg_block.STATUS.CNT_DROP.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.RX_LVL.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.TX_LVL.get_mirrored_value()), UVM_LOW)

	endtask



	// body()
	virtual task body();

		`uvm_info(get_type_name(), "===========Starting Register Access test sequence==========", UVM_LOW)

		// Get virtual interface from env_config
		vif = p_sequencer.model.env_config.get_vif();
		if (vif == null)
			`uvm_fatal("REG ACCESS VSEQ", "Failed to get virtual interface handle")

		// Get data width
		data_width = p_sequencer.model.env_config.get_algn_data_width();
		$display("data_width = %0d",data_width);

		// write to control register with illegal combination of
		// offset & size
		cfg_ctrl_reg(3,1);			// APB Error: 1
		
		rd_clr_val();

		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);

		// write to status register
		wr_status_reg(1,1,1);			// APB Error: 2

		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);

		// Read CLR value 			// APB Error: 3
		rd_clr_val();

		// Start initial RX transaction
		repeat(260) begin
			legal_seq = md_sequence_legal_rx::type_id::create("rx_seq");
			legal_seq.set_sequencer(p_sequencer.md_rx_sequencer);
			legal_seq.start(p_sequencer.md_rx_sequencer);
		end

		//rd_status_reg();

		// Making CLR in CTRL reg as high
		//cfg_ctrl_reg(4,0,1);

		repeat(4) @(posedge vif.clk);

		// Writing 1 to IRQ.MAX_DROP
		//cfg_irq_reg(1,0);

		//rd_status_reg();


		// delay
		repeat(30) @(posedge vif.clk);



		`uvm_info(get_type_name(), "=========Completed Register Access test sequence=========", UVM_LOW)
			
	endtask

endclass

`endif

