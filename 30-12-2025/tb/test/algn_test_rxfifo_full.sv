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
	//cfs_md_agent_config_slave#(ALGN_DATA_WIDTH) agent_config;


	// Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void start_of_simulation_phase(uvm_phase phase);
		env.agent_config.set_ready_at_reset(0);
		$display("----------%0d-----------",env.agent_config.get_ready_at_reset());
	endfunction

	// run_phase()
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this,"Starting RXFIFO_FULL test");
	
		#(100ns);

		//env.agent_config.set_ready_at_reset(0);

		env.md_tx_agent.agent_config.set_has_checks(0);

		
		//$display("----------%0d-----------",env.agent_config.get_ready_at_reset());

		fork
			begin
				stall_seq = md_sequence_tx_stall::type_id::create("stall_seq");
				stall_seq.start(env.md_tx_agent.sequencer);
			end
		join_none

		rx_vseq = algn_vseq_rxfifo_full::type_id::create("rx_vseq");
		rx_vseq.set_sequencer(env.virtual_sequencer);
		rx_vseq.start(env.virtual_sequencer);

	

		#(200ns);		

		phase.drop_objection(this,"Completed RXFIFO_FULL test");
	endtask


endclass



`endif
