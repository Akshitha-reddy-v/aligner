///////////////////////////////////////////////////////////////////////////////
// File:        algn_test_reg_access.sv
// Author:      Akshitha
// Date:        08-12-2025
// Description: Test to check various register access functionality
///////////////////////////////////////////////////////////////////////////////

`include "algn_vseq_reg_access.sv"
//`include "cfs_algn_virtual_sequence_reg_access_unmapped.sv"

`ifndef ALGN_TEST_REG_ACCESS_SV
`define ALGN_TEST_REG_ACCESS_SV

class algn_test_reg_access extends cfs_algn_test_base;
	// Factory registration
	`uvm_component_utils(algn_test_reg_access)

	algn_vseq_reg_access rx_seq;
	cfs_algn_virtual_sequence_reg_access_unmapped vseq;
	uvm_status_e status;
	uvm_reg_data_t data;
	uvm_reg_addr_t unmapped_addr = 32'h0004;

	cfs_md_sequence_slave_response_forever tx_seq;

	// Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction

	// run_phase()
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this,"**************Starting REG ACCESS test*****************");
	
		#(100ns);

		// Start TX slave responder
		fork
			begin
				tx_seq = cfs_md_sequence_slave_response_forever::type_id::create("tx_seq");
				tx_seq.start(env.md_tx_agent.sequencer);
			end
		join_none

		// Start legal RX virtual sequence
		rx_seq = algn_vseq_reg_access::type_id::create("rx_seq");
		rx_seq.set_sequencer(env.virtual_sequencer);
		//void'(rx_seq.randomize());
		rx_seq.start(env.virtual_sequencer);

		vseq = cfs_algn_virtual_sequence_reg_access_unmapped::type_id::create("vseq");
		vseq.set_sequencer(env.virtual_sequencer);
		//void'(rx_seq.randomize());
		vseq.start(env.virtual_sequencer);


		#(20ns);
		`uvm_info("UNMAPPED", $sformatf("Accessing unmapped APB address = 0x%0h", unmapped_addr), UVM_LOW)
		
		// APB read to unmapped address
		/*env.virtual_sequencer.model.reg_block.default_map.raw_read(
			.status(status),
			.value(data),
			.addr(unmapped_addr),
			.parent(this)
		);*/

		//if (status != UVM_NOT_OK)
    		//	`uvm_error("UNMAPPED", "Expected PSLVERR NOT returned for unmapped address!")
		//else
    		//	`uvm_info("UNMAPPED", "Correct PSLVERR received for unmapped address.", UVM_LOW);
		
		
		#(500ns);		

		phase.drop_objection(this,"*******Completed REG ACCESS test********8");
	endtask


endclass

`endif
