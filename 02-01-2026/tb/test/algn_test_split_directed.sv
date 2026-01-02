`include "algn_vseq_split_directed.sv"


`ifndef ALGN_TEST_SPLIT_DIRECTED_SV
`define ALGN_TEST_SPLIT_DIRECTED_SV

class algn_test_split_directed extends cfs_algn_test_base;
  `uvm_component_utils(algn_test_split_directed)

  algn_vseq_split_directed vseq;

  function new(string name="", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    vseq = algn_vseq_split_directed::type_id::create("vseq");
    vseq.set_sequencer(env.virtual_sequencer);
    vseq.start(env.virtual_sequencer);

    phase.drop_objection(this);
  endtask
endclass

`endif
