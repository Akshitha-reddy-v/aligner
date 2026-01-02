`ifndef ALGN_TEST_APB_RESET_DURING_ACCESS_SV
`define ALGN_TEST_APB_RESET_DURING_ACCESS_SV


class algn_test_apb_reset_during_access extends cfs_algn_test_base;
  `uvm_component_utils(algn_test_apb_reset_during_access)

  // Constructor
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction


  virtual task run_phase(uvm_phase phase);
    cfs_apb_sequence_simple seq;
    cfs_apb_vif vif;

    phase.raise_objection(this);

    vif = env.apb_agent.agent_config.get_vif();

    fork
      begin
        seq = cfs_apb_sequence_simple::type_id::create("seq");
        seq.start(env.apb_agent.sequencer);
      end
      begin
        @(posedge vif.psel);
        vif.preset_n <= 0;
        repeat(2) @(posedge vif.pclk);
        vif.preset_n <= 1;
      end
    join

    phase.drop_objection(this);
  endtask
endclass


`endif

