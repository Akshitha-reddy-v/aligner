///////////////////////////////////////////////////////////////////////////////
// File:        algn_test_mid_reset.sv
// Author:      Akshitha
// Date:        11-11-2025
// Description: Test for Aligner mid-sequence reset functionality
///////////////////////////////////////////////////////////////////////////////

`include "algn_vseq_rst_midseq.sv"
`include "algn_vseq_legal_rx.sv"


`ifndef ALGN_TEST_MID_RESET_SV
`define ALGN_TEST_MID_RESET_SV

class algn_test_mid_reset extends cfs_algn_test_base;
	// Factory registration
	`uvm_component_utils(algn_test_mid_reset)

	algn_vseq_rst_midseq rst_seq;
	algn_vseq_legal_rx rx_seq;
	cfs_apb_vif apb_vif;
	//cfs_md_sequence_slave_response_forever tx_seq;

	// Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction

	// run_phase()
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this,"Starting mid-reset test");

		apb_vif = env.apb_agent.agent_config.get_vif();
	
		#(100ns);

		// Start TX slave responder
		/*fork
			begin
				tx_seq = cfs_md_sequence_slave_response_forever::type_id::create("tx_seq");
				tx_seq.start(env.md_tx_agent.sequencer);
			end
		join_none*/

		// Start mid-reset virtual sequence
		rst_seq = algn_vseq_rst_midseq::type_id::create("rst_seq");
		rst_seq.set_sequencer(env.virtual_sequencer);
		//void'(rst_seq.randomize());
		rst_seq.start(env.virtual_sequencer);

		repeat(3) @(posedge apb_vif.pclk);

		apb_vif.preset_n <= 1'b1;

		rx_seq = algn_vseq_legal_rx::type_id::create("rx_seq");
		rx_seq.set_sequencer(env.virtual_sequencer);
		rx_seq.start(env.virtual_sequencer);

		//if(!uvm_hdl_force("testbench.dut.reset_n",1'b1))
		//	`uvm_error("RST_TEST","cannot force the value into reset_n")

		#(500ns);		

		phase.drop_objection(this,"Completed mid-reset test");
	endtask


endclass

`endif
