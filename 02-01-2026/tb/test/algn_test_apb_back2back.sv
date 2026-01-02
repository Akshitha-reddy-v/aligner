

//`include "apb_back2back_seq.sv"

`ifndef ALGN_TEST_APB_BACK2BACK_SV
`define ALGN_TEST_APB_BACK2BACK_SV


class algn_test_apb_back2back extends cfs_algn_test_base;
  `uvm_component_utils(algn_test_apb_back2back)

  function new(string name="", uvm_component parent);
	super.new(name,parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    apb_back2back_seq seq;

    phase.raise_objection(this);

    seq = apb_back2back_seq::type_id::create("seq");

    // First APB access
    seq.start(env.apb_agent.sequencer);
    seq.start(env.apb_agent.sequencer);

    // Immediately start second APB access
    //seq.start(env.apb_agent.sequencer);

    phase.drop_objection(this);
  endtask

  endclass

`endif

