`ifndef ALGN_VSEQ_SPLIT_DIRECTED_SV
`define ALGN_VSEQ_SPLIT_DIRECTED_SV


class algn_vseq_split_directed extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(algn_vseq_split_directed)

  md_sequence_legal_rx rx_seq;
  virtual cfs_algn_if vif;

  function new(string name="");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;

    vif = p_sequencer.model.env_config.get_vif();

    // 1. Program CTRL to force split
    p_sequencer.model.reg_block.CTRL.write(
      status,
      (1 << p_sequencer.model.reg_block.CTRL.SIZE.get_lsb_pos()) |
      (3 << p_sequencer.model.reg_block.CTRL.OFFSET.get_lsb_pos()),
      .parent(this)
    );

    // 2. Wait for clean state
    repeat (5) @(posedge vif.clk);

    // 3. Send RX with forced offset/size
    rx_seq = md_sequence_legal_rx::type_id::create("rx_seq");

    rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);

    assert(rx_seq.randomize() with {
      item.offset == 3;
      item.data.size() == 1;
    });

    rx_seq.start(p_sequencer.md_rx_sequencer);

    // 4. Let model complete split
    repeat (10) @(posedge vif.clk);
  endtask
endclass



`endif

