///////////////////////////////////////////////////////////////////////////////
// File:        algn_vseq_rst_midseq.sv
// Author:      Akshitha
// Date:        11-11-2025
// Description: Virtual sequence for testing reset behavior in the middle of MD RX traffic.
///////////////////////////////////////////////////////////////////////////////

`ifndef ALGN_VSEQ_RST_MIDSEQ_SV
`define ALGN_VSEQ_RST_MIDSEQ_SV
	
class algn_vseq_rst_midseq extends cfs_algn_virtual_sequence_base;
	// Factory registration
	`uvm_object_utils(algn_vseq_rst_midseq)

	// Virtual interface handle
	virtual cfs_algn_if vif;
	virtual cfs_apb_if apb_vif;

	// sequence handle
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


	// body()
	virtual task body();
			
		`uvm_info(get_type_name(), "*******************Starting mid-sequence reset test sequence***************", UVM_LOW)

		if(!uvm_config_db#(virtual cfs_apb_if)::get(null,get_full_name(),"vif",apb_vif))
			`uvm_fatal("ALGN_VSEQ_RST_MIDSEQ", "cannot get vif for apb from uvm_config")
		else
			`uvm_info("ALGN_VSEQ_RST_MIDSEQ", "got config_db for APB VIF",UVM_LOW)


		// Get virtual interface from env_config
		vif = p_sequencer.model.env_config.get_vif();
		if (vif == null)
			`uvm_fatal(get_type_name(), "Failed to get virtual interface handle")

		// Get data width
		data_width = p_sequencer.model.env_config.get_algn_data_width();
		$display("data_width = %0d\n",data_width);

		// configure register
		cfg_ctrl_reg(1, 1);

		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);


		// Start initial RX transaction
		fork
			repeat(20) begin
				rx_seq = md_sequence_legal_rx::type_id::create("rx_seq");
				rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);
				rx_seq.start(p_sequencer.md_rx_sequencer);
			end
		join_none
			
		// delay
		repeat(30) @(posedge vif.clk);

		// Assert reset_n mid sequence
		`uvm_info(get_type_name(), "==============Asserting reset_n mid-sequence==============", UVM_LOW)
		apb_vif.preset_n <= 1'b0;

		//`uvm_info("AFTER RESET", $sformatf("Post-reset RX transaction -> data_size: %0d, offset: %0d",data_size_after_reset, offset_after_reset), UVM_LOW)

		// Deassert reset_n after a few cycles
		repeat(2) @(posedge vif.clk);
		`uvm_info(get_type_name(), "==============Deasserting reset_n=============", UVM_LOW)
		apb_vif.preset_n <= 1'b1;

		// Delay(for DUT stabilization)
		repeat(50) @(posedge vif.clk);

		// Drive another RX transaction post-reset
		/*rx_seq = md_sequence_legal_rx::type_id::create("rx_seq");
		rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);
		rx_seq.start(p_sequencer.md_rx_sequencer);
*/
		`uvm_info(get_type_name(), "********************Completed mid-sequence reset test sequence**************", UVM_LOW)
			
	endtask

endclass

`endif
