///////////////////////////////////////////////////////////////////////////////
// File:        algn_test_rxfifo_full.sv
// Author:      Akshitha
// Date:        28-11-2025
// Description: Test to send 8 number of legal RX ransactions
///////////////////////////////////////////////////////////////////////////////

`include "algn_vseq_rxfifo_full.sv"

`ifndef ALGN_TEST_RXFIFO_FULL_SV
`define ALGN_TEST_RXFIFO_FULL_SV

class algn_test_rxfifo_full extends cfs_algn_test_base;
	// Factory registration
	`uvm_component_utils(algn_test_rxfifo_full)

	algn_vseq_rxfifo_full rx_vseq;
	md_sequence_tx_stall stall_seq;

	// Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction

	// run_phase()
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this,"Starting RXFIFO_FULL test");
	
		#(100ns);

		// Disable TX protocol checks before stall
		//env.md_tx_agent.agent_config.set_has_checks(0);
		
		// Prepare RX virtual sequence
		rx_vseq = algn_vseq_rxfifo_full::type_id::create("rx_vseq");
		rx_vseq.set_sequencer(env.virtual_sequencer);


		// Prepare TX stall sequence
		stall_seq = md_sequence_tx_stall::type_id::create("stall_seq");

		// Start TX stall in parallel
		fork
			stall_seq.start(env.md_tx_agent.sequencer);
		join_none

		env.md_tx_agent.agent_config.set_has_checks(0);
		
		// Kill any default slave sequences running on TX agent
		//env.md_tx_agent.sequencer.stop_sequences();

		
		// Start RX virtual sequence
		rx_vseq.start(env.virtual_sequencer);

		#(500ns);		

		phase.drop_objection(this,"Completed RXFIFO_FULL test");
	endtask


endclass

`endif
