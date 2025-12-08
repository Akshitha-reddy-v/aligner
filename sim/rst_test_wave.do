onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /testbench/clk
add wave -noupdate -group APB /testbench/apb_if/pclk
add wave -noupdate -group APB /testbench/apb_if/preset_n
add wave -noupdate -group APB /testbench/apb_if/paddr
add wave -noupdate -group APB /testbench/apb_if/pwrite
add wave -noupdate -group APB /testbench/apb_if/psel
add wave -noupdate -group APB /testbench/apb_if/penable
add wave -noupdate -group APB /testbench/apb_if/pwdata
add wave -noupdate -group APB /testbench/apb_if/pready
add wave -noupdate -group APB /testbench/apb_if/prdata
add wave -noupdate -group APB /testbench/apb_if/pslverr
add wave -noupdate -group APB /testbench/apb_if/has_checks
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/clk
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/reset_n
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/valid
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/data
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/offset
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/size
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/ready
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/err
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/has_checks
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/clk
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/reset_n
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/valid
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/data
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/offset
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/size
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/ready
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/err
add wave -noupdate -group MD_TX_IF /testbench/md_tx_if/has_checks
add wave -noupdate -group ALGN_IF /testbench/algn_if/clk
add wave -noupdate -group ALGN_IF /testbench/algn_if/reset_n
add wave -noupdate -group ALGN_IF /testbench/algn_if/irq
add wave -noupdate -group ALGN_IF /testbench/algn_if/rx_fifo_push
add wave -noupdate -group ALGN_IF /testbench/algn_if/rx_fifo_pop
add wave -noupdate -group ALGN_IF /testbench/algn_if/tx_fifo_push
add wave -noupdate -group ALGN_IF /testbench/algn_if/tx_fifo_pop
add wave -noupdate -group DUT /testbench/dut/clk
add wave -noupdate -group DUT /testbench/dut/reset_n
add wave -noupdate -group DUT /testbench/dut/paddr
add wave -noupdate -group DUT /testbench/dut/pwrite
add wave -noupdate -group DUT /testbench/dut/psel
add wave -noupdate -group DUT /testbench/dut/penable
add wave -noupdate -group DUT /testbench/dut/pwdata
add wave -noupdate -group DUT /testbench/dut/pready
add wave -noupdate -group DUT /testbench/dut/prdata
add wave -noupdate -group DUT /testbench/dut/pslverr
add wave -noupdate -group DUT /testbench/dut/md_rx_valid
add wave -noupdate -group DUT /testbench/dut/md_rx_data
add wave -noupdate -group DUT /testbench/dut/md_rx_offset
add wave -noupdate -group DUT /testbench/dut/md_rx_size
add wave -noupdate -group DUT /testbench/dut/md_rx_ready
add wave -noupdate -group DUT /testbench/dut/md_rx_err
add wave -noupdate -group DUT /testbench/dut/md_tx_valid
add wave -noupdate -group DUT /testbench/dut/md_tx_data
add wave -noupdate -group DUT /testbench/dut/md_tx_offset
add wave -noupdate -group DUT /testbench/dut/md_tx_size
add wave -noupdate -group DUT /testbench/dut/md_tx_ready
add wave -noupdate -group DUT /testbench/dut/md_tx_err
add wave -noupdate -group DUT /testbench/dut/irq
add wave -noupdate -group CORE /testbench/dut/core/pclk
add wave -noupdate -group CORE /testbench/dut/core/preset_n
add wave -noupdate -group CORE /testbench/dut/core/paddr
add wave -noupdate -group CORE /testbench/dut/core/pwrite
add wave -noupdate -group CORE /testbench/dut/core/psel
add wave -noupdate -group CORE /testbench/dut/core/penable
add wave -noupdate -group CORE /testbench/dut/core/pwdata
add wave -noupdate -group CORE /testbench/dut/core/pready
add wave -noupdate -group CORE /testbench/dut/core/prdata
add wave -noupdate -group CORE /testbench/dut/core/pslverr
add wave -noupdate -group CORE /testbench/dut/core/md_rx_clk
add wave -noupdate -group CORE /testbench/dut/core/md_rx_valid
add wave -noupdate -group CORE /testbench/dut/core/md_rx_data
add wave -noupdate -group CORE /testbench/dut/core/md_rx_offset
add wave -noupdate -group CORE /testbench/dut/core/md_rx_size
add wave -noupdate -group CORE /testbench/dut/core/md_rx_ready
add wave -noupdate -group CORE /testbench/dut/core/md_rx_err
add wave -noupdate -group CORE /testbench/dut/core/md_tx_clk
add wave -noupdate -group CORE /testbench/dut/core/md_tx_valid
add wave -noupdate -group CORE /testbench/dut/core/md_tx_data
add wave -noupdate -group CORE /testbench/dut/core/md_tx_offset
add wave -noupdate -group CORE /testbench/dut/core/md_tx_size
add wave -noupdate -group CORE /testbench/dut/core/md_tx_ready
add wave -noupdate -group CORE /testbench/dut/core/md_tx_err
add wave -noupdate -group CORE /testbench/dut/core/irq
add wave -noupdate -group CORE /testbench/dut/core/rx_ctrl_2_regs_status_cnt_drop
add wave -noupdate -group CORE /testbench/dut/core/regs_2_rx_ctrl_ctrl_clr
add wave -noupdate -group CORE /testbench/dut/core/rx_ctrl_2_rx_fifo_push_valid
add wave -noupdate -group CORE /testbench/dut/core/rx_ctrl_2_rx_fifo_push_data
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_rx_ctrl_push_ready
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_rx_ctrl_push_full
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_regs_fifo_full
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_regs_fifo_empty
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_regs_fifo_lvl
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_regs_fifo_lvl
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_regs_fifo_empty
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_regs_fifo_full
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_tx_ctrl_pop_valid
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_tx_ctrl_pop_data
add wave -noupdate -group CORE /testbench/dut/core/tx_fifo_2_tx_ctrl_pop_ready
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_ctrl_pop_valid
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_ctrl_pop_data
add wave -noupdate -group CORE /testbench/dut/core/rx_fifo_2_ctrl_pop_ready
add wave -noupdate -group CORE /testbench/dut/core/ctrl_2_tx_fifo_push_valid
add wave -noupdate -group CORE /testbench/dut/core/ctrl_2_tx_fifo_push_data
add wave -noupdate -group CORE /testbench/dut/core/ctrl_2_tx_fifo_push_ready
add wave -noupdate -group CORE /testbench/dut/core/regs_2_ctrl_ctrl_offset
add wave -noupdate -group CORE /testbench/dut/core/regs_2_ctrl_ctrl_size
add wave -noupdate -group REGS /testbench/dut/core/regs/pclk
add wave -noupdate -group REGS /testbench/dut/core/regs/presetn
add wave -noupdate -group REGS /testbench/dut/core/regs/paddr
add wave -noupdate -group REGS /testbench/dut/core/regs/pwrite
add wave -noupdate -group REGS /testbench/dut/core/regs/psel
add wave -noupdate -group REGS /testbench/dut/core/regs/penable
add wave -noupdate -group REGS /testbench/dut/core/regs/pwdata
add wave -noupdate -group REGS /testbench/dut/core/regs/pready
add wave -noupdate -group REGS /testbench/dut/core/regs/prdata
add wave -noupdate -group REGS /testbench/dut/core/regs/pslverr
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_offset
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_size
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_clr
add wave -noupdate -group REGS /testbench/dut/core/regs/status_cnt_drop
add wave -noupdate -group REGS /testbench/dut/core/regs/status_rx_lvl
add wave -noupdate -group REGS /testbench/dut/core/regs/status_tx_lvl
add wave -noupdate -group REGS /testbench/dut/core/regs/rx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/rx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/tx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/tx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/max_drop
add wave -noupdate -group REGS /testbench/dut/core/regs/irq
add wave -noupdate -group REGS /testbench/dut/core/regs/addr_aligned
add wave -noupdate -group REGS /testbench/dut/core/regs/wr_ctrl_is_illegal
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_size_wr_val
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_offset_wr_val
add wave -noupdate -group REGS /testbench/dut/core/regs/ctrl_rd_val
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_rx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_rx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_tx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_tx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_max_drop
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_rx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_rx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_tx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_tx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_max_drop
add wave -noupdate -group REGS /testbench/dut/core/regs/status_rd_val
add wave -noupdate -group REGS /testbench/dut/core/regs/irqen_rd_val
add wave -noupdate -group REGS /testbench/dut/core/regs/irq_rd_val
add wave -noupdate -group REGS /testbench/dut/core/regs/edge_rx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/edge_rx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/edge_tx_fifo_empty
add wave -noupdate -group REGS /testbench/dut/core/regs/edge_tx_fifo_full
add wave -noupdate -group REGS /testbench/dut/core/regs/edge_max_drop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {9380 ns}
