`include "algn_vseq_legal_rx_ctrl_directed.sv"

`ifndef ALGN_TEST_LEGAL_RX_CTRL_DIRECTED_SV
`define ALGN_TEST_LEGAL_RX_CTRL_DIRECTED_SV

class algn_test_legal_rx_ctrl_directed extends cfs_algn_test_base;
	// Factory registration
	`uvm_component_utils(algn_test_legal_rx_ctrl_directed)

	algn_vseq_legal_rx_ctrl_directed rx_seq;
	cfs_md_sequence_slave_response_forever tx_seq;

	// Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction

	// run_phase()
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this,"Starting legal RX test");
	
		#(100ns);

		// Start TX slave responder
		fork
			begin
				tx_seq = cfs_md_sequence_slave_response_forever::type_id::create("tx_seq");
				tx_seq.start(env.md_tx_agent.sequencer);
			end
		join_none

		// Start legal RX virtual sequence
		rx_seq = algn_vseq_legal_rx_ctrl_directed::type_id::create("rx_seq");
		rx_seq.set_sequencer(env.virtual_sequencer);

		//void'(rx_seq.randomize());
		rx_seq.start(env.virtual_sequencer);

		#(500ns);		

		phase.drop_objection(this,"Completed legal RX test");
	endtask


endclass

`endif
