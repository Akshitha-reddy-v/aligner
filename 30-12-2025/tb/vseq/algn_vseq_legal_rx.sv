///////////////////////////////////////////////////////////////////////////////
// File:        algn_vseq_legal_rx.sv
// Author:      Akshitha
// Date:        12-11-2025
// Description: Virtual sequence for testing legal MD RX traffic behaviour.
///////////////////////////////////////////////////////////////////////////////

`ifndef ALGN_VSEQ_LEGAL_RX_SV
`define ALGN_VSEQ_LEGAL_RX_SV

class algn_ctrl_legal_cfg extends uvm_object;
	rand int unsigned size;
	rand int unsigned offset;

	int unsigned data_bytes;

	constraint legal_c {
		size   inside {[1:4]};
		offset inside {[0:3]};

		((data_bytes + offset) % size) == 0;
		(size + offset) <= data_bytes;
	}

	`uvm_object_utils(algn_ctrl_legal_cfg)

	function new(string name="algn_ctrl_legal_cfg");
    		super.new(name);
  	endfunction

endclass
	
class algn_vseq_legal_rx extends cfs_algn_virtual_sequence_base;
	// Factory registration
	`uvm_object_utils(algn_vseq_legal_rx)

	// Virtual interface handle
	virtual cfs_algn_if vif;
	algn_ctrl_legal_cfg ctrl_cfg;

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

	// write to IRQ register
	task automatic cfg_irq_reg(int unsigned rxempty_val, int unsigned txempty_val);
		uvm_status_e status;	
		uvm_reg_data_t irq_value;

		irq_value =    (rxempty_val<< p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_lsb_pos()) 
			     | (txempty_val << p_sequencer.model.reg_block.IRQ.TX_FIFO_EMPTY.get_lsb_pos());
		// write to Interrupt request(IRQ) register
		p_sequencer.model.reg_block.IRQ.write(status, irq_value, .parent(this));
		`uvm_info("IRQ REG CONFIGURING", $sformatf("==========RX_FIFO_EMPTY: %0d | TX_FIFO_EMPTY: %0d==========", 
			p_sequencer.model.reg_block.IRQ.RX_FIFO_EMPTY.get_mirrored_value(),
			p_sequencer.model.reg_block.IRQ.TX_FIFO_EMPTY.get_mirrored_value()), UVM_LOW)

	endtask

	// read the cnt_drop value in status reg
	task automatic rd_status_reg();
		uvm_status_e status;	
		uvm_reg_data_t status_value;

		// read from STATUS register
		p_sequencer.model.reg_block.STATUS.read(status, status_value);
		`uvm_info("STATUS REG", $sformatf("---------------CNT_DROP: %0d | RX_LVL: %0d | TX_LVL: %0d---------", 
			p_sequencer.model.reg_block.STATUS.CNT_DROP.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.RX_LVL.get_mirrored_value(),
			p_sequencer.model.reg_block.STATUS.TX_LVL.get_mirrored_value()), UVM_LOW)

	endtask

	// body()
	virtual task body();
			
		`uvm_info(get_type_name(), "********Starting legal RX test sequence*********", UVM_LOW)

		// Get virtual interface from env_cofig
		vif = p_sequencer.model.env_config.get_vif();
		if (vif == null)
			`uvm_fatal("LEGAL VSEQ", "Failed to get virtual interface handle")
		// Get data width
		data_width = p_sequencer.model.env_config.get_algn_data_width();
		$display("data_width = %0d",data_width);
		
		// configure register
		ctrl_cfg = algn_ctrl_legal_cfg::type_id::create("ctrl_cfg");
		ctrl_cfg.data_bytes = data_width / 8;
		$display("data_bytes = %0d", ctrl_cfg.data_bytes);
		//cfg_ctrl_reg(1,3);

		rd_status_reg();
		$display();
		rd_status_reg();
		$display();


		// Wait before generating RX traffic
		repeat(5) @(posedge vif.clk);

		repeat(2) begin

			wait(p_sequencer.model.is_empty());

			assert(ctrl_cfg.randomize())
			else
				`uvm_fatal("CTRL_CFG","Failed to randomize legal CTRL config");

			cfg_ctrl_reg(ctrl_cfg.size, ctrl_cfg.offset);

			`uvm_info("CTRL_CFG",
      					$sformatf("=========Randomized CTRL: SIZE=%0d | OFFSET=%0d=========",
                			ctrl_cfg.size, ctrl_cfg.offset),
      				UVM_LOW)
			
			repeat(2) @(posedge vif.clk);

			// Start legal RX transactions
			for(int i=0;i<8;i++) begin
				rx_seq = md_sequence_legal_rx::type_id::create("rx_seq");
				//rx_seq.data_width = p_sequencer.model.env_config.get_algn_data_width();
				rx_seq.set_sequencer(p_sequencer.md_rx_sequencer);
				rx_seq.start(p_sequencer.md_rx_sequencer);

				#20;

			
				
			end
			repeat(5) @(posedge vif.clk);
		end

		//cfg_irq_reg(1,1);

		// delay
		repeat(30) @(posedge vif.clk);



		`uvm_info(get_type_name(), "Completed legal RX test sequence", UVM_LOW)
			
	endtask

endclass

`endif

