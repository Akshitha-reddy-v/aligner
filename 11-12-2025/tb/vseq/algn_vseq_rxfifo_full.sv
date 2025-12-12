///////////////////////////////////////////////////////////////////////////////
// File:        algn_vseq_rxfifo_full.sv
// Author:      Akshitha
// Date:        28-11-2025
// Description: Virtual sequence for testing RX FIFO FULL behavior.
///////////////////////////////////////////////////////////////////////////////

`ifndef ALGN_VSEQ_RXFIFO_FULL_SV
`define ALGN_VSEQ_RXFIFO_FULL_SV
	
class algn_vseq_rxfifo_full extends cfs_algn_virtual_sequence_base;
	// Factory registration
	`uvm_object_utils(algn_vseq_rxfifo_full)

	// Virtual interface handle
	virtual cfs_algn_if vif;

	md_sequence_rxfifo_full rx_seq;
	int unsigned data_width;

	// Constructor
	function new(string name = "");
		super.new(name);
	endfunction

	// write legal configuration to CTRL register
	task automatic cfg_ctrl_reg(int unsigned size_val, int unsigned offset_val);
		uvm_status_e status;	
		uvm_reg_data_t ctrl_value;

		ctrl_value = (size_val   << p_sequencer.model.reg_block.CTRL.SIZE.get_lsb_pos()) |
			     (offset_val << p_sequencer.model.reg_block.CTRL.OFFSET.get_lsb_pos());
		// write to control(CTRL) register
		p_sequencer.model.reg_block.CTRL.write(status, ctrl_value, .parent(this));
		`uvm_info("CTRL REG CONFIGURING", $sformatf("CTRL reg configured: %0h", p_sequencer.model.reg_block.CTRL.get_mirrored_value()), UVM_LOW)

	endtask

	// write to IRQ register
	task automatic cfg_irq_reg(int unsigned rxempty_val, int unsigned rxfull_val, int unsigned txfull_val);
		uvm_status_e status;	
		uvm_reg_data_t irq_value;

		irq_value =    (rxempty_val<< p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_lsb_pos()) 
			     | (rxfull_val << p_sequencer.model.reg_block.IRQ.RX_FIFO_FULL.get_lsb_pos())
			     | (txfull_val << p_sequencer.model.reg_block.IRQ.TX_FIFO_FULL.get_lsb_pos());
		// write to Interrupt request(IRQ) register
		p_sequencer.model.reg_block.IRQ.write(status, irq_value, .parent(this));
		`uvm_info("IRQ REG CONFIGURING", $sformatf("==========RX_FIFO_EMPTY: %0d | RX_FIFO_FULL: %0d | TX_FIFO_FULL: %0d==========", 
			p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_mirrored_value(),
			p_sequencer.model.reg_block.IRQ.RX_FIFO_FULL.get_mirrored_value(),
			p_sequencer.model.reg_block.IRQ.TX_FIFO_FULL.get_mirrored_value()), UVM_LOW)

	endtask


	// body()
	virtual task body();
			
		`uvm_info(get_type_name(), "*********Starting RXFIFO_FULL test sequence********", UVM_LOW)

		// Get virtual interface from env_config
		vif = p_sequencer.model.env_config.get_vif();
		if (vif == null)
			`uvm_fatal("RXFIFO_FULL VSEQ", "Failed to get virtual interface handle")
		
		// Get data width
		data_width = p_sequencer.model.env_config.get_algn_data_width();
		$display("data_width = %0d",data_width);
		
		// configure register
		cfg_ctrl_reg(2,2);

		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);

		// Start legal RX transactions
		repeat(13) begin
			rx_seq = md_sequence_rxfifo_full::type_id::create("rx_seq");
			rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);
			rx_seq.start(p_sequencer.md_rx_sequencer);
		end

		// delay
		repeat(30) @(posedge vif.clk);

		cfg_irq_reg(1,1,1);


		`uvm_info(get_type_name(), "*********Completed RXFIFO_FULL test sequence**********", UVM_LOW)
			
	endtask

endclass

`endif

