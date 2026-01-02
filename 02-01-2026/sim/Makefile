#Makefile for UVM Testbench - Lab 06

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL= ../rtl/design.sv
work= work #library name
SVTB1= ../tb/testbench.sv
INC = +incdir+../tb +incdir+../tb/apb +incdir+../tb/md +incdir+../tb/test +incdir+../tb/vseq
SVTB2 = ../tb/cfs_algn_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit mem_cov9;run -all; exit"
VSIMBATCH10= -c -do  " log -r /* ;coverage save -onexit mem_cov10;run -all; exit"
VSIMBATCH11= -c -do  " log -r /* ;coverage save -onexit mem_cov11;run -all; exit"


help:
	@echo =============================================================================================================
	@echo "! USAGE   			--  make target                             								!"
	@echo "! clean   			=>  clean the earlier log and intermediate files.       						!"
	@echo "! sv_cmp    			=>  Create library and compile the code.                   						!"
	@echo "! run_test		 	=>  clean, compile & run the simulation for cfs_algn_test_base in batch mode.				!" 
	@echo "! run_test1			=>  clean, compile & run the simulation for algn_test_mid_reset in batch mode.				!" 
	@echo "! run_test2			=>  clean, compile & run the simulation for algn_test_legal_rx in batch mode.				!" 
	@echo "! run_test3			=>  clean, compile & run the simulation for cfs_algn_test_random_rx_err in batch mode.			!" 
	@echo "! run_test4			=>  clean, compile & run the simulation for algn_test_illegal_rx in batch mode.				!" 
	@echo "! run_test5			=>  clean, compile & run the simulation for algn_test_rxfifo_full in batch mode.			!" 
	@echo "! run_test6			=>  clean, compile & run the simulation for algn_test_reg_access in batch mode.				!" 
	@echo "! run_test7			=>  clean, compile & run the simulation for algn_test_apb_back2back in batch mode.			!"
	@echo "! run_test8			=>  clean, compile & run the simulation for algn_test_apb_reset_during_access in batch mode.		!"
	@echo "! run_test9			=>  clean, compile & run the simulation for algn_test_split_directed in batch mode.			!"
	@echo "! run_test10			=>  clean, compile & run the simulation for algn_test_legal_rx_ctrl_directed in batch mode.		!"
	@echo "! view_wave1 			=>  To view the waveform of cfs_algn_test_base	    							!" 
	@echo "! view_wave2 			=>  To view the waveform of algn_test_mid_reset	    							!" 
	@echo "! view_wave3 			=>  To view the waveform of algn_test_legal_rx  							!" 
	@echo "! view_wave4 			=>  To view the waveform of cfs_algn_test_random_rx_err  						!" 
	@echo "! view_wave5 			=>  To view the waveform of algn_test_illegal_rx  							!" 
	@echo "! view_wave6 			=>  To view the waveform of algn_test_rxfifo_full  							!"
	@echo "! view_wave7 			=>  To view the waveform of algn_test_reg_access  							!"
	@echo "! view_wave8 			=>  To view the waveform of algn_test_apb_back2back  							!"
	@echo "! view_wave9 			=>  To view the waveform of algn_test_apb_reset_during_access  						!"
	@echo "! view_wave10 			=>  To view the waveform of algn_test_split_directed  							!"
	@echo "! view_wave11			=>  To view the waveform of algn_test_legal_rx_ctrl_directed  						!"
	@echo "! regress    			=>  clean, compile and run all testcases in batch mode.		    					!"
	@echo "! report     			=>  To merge coverage reports for all testcases and  convert to html format.				!"
	@echo "! cov        			=>  To open merged coverage report in html format.							!"	
	@echo ====================================================================================================================

clean  		       : clean_$(SIMULATOR)
sv_cmp 		       : sv_cmp_$(SIMULATOR)
run_test 	       : run_test_$(SIMULATOR)
run_test1              : run_test1_$(SIMULATOR)
run_test2              : run_test2_$(SIMULATOR)
run_test3              : run_test3_$(SIMULATOR)
run_test4              : run_test4_$(SIMULATOR)
run_test5              : run_test5_$(SIMULATOR)
run_test6              : run_test6_$(SIMULATOR)
run_test7              : run_test7_$(SIMULATOR)
run_test8              : run_test8_$(SIMULATOR)
run_test9              : run_test9_$(SIMULATOR)
run_test10             : run_test10_$(SIMULATOR)
regress 	       : regress_$(SIMULATOR)
report  	       : report_$(SIMULATOR)
cov     	       : cov_$(SIMULATOR)
view_wave1             : view_wave1_$(SIMULATOR)
view_wave2             : view_wave2_$(SIMULATOR)
view_wave3             : view_wave3_$(SIMULATOR)
view_wave4             : view_wave4_$(SIMULATOR)
view_wave5             : view_wave5_$(SIMULATOR)
view_wave6             : view_wave6_$(SIMULATOR)
view_wave7             : view_wave7_$(SIMULATOR)
view_wave8             : view_wave8_$(SIMULATOR)
view_wave9             : view_wave9_$(SIMULATOR)
view_wave10            : view_wave10_$(SIMULATOR)
view_wave11            : view_wave11_$(SIMULATOR)




# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave.wlf -l test1.log  -sv_seed random  work.testbench +UVM_TESTNAME=cfs_algn_test_base 
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave1.wlf -l test2.log  -sv_seed 428050963  work.testbench +UVM_TESTNAME=algn_test_mid_reset
	#vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave1.wlf -l test2.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_mid_reset
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2
	#firefox covhtmlreport/index.html&

run_test2_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave2.wlf -l test3.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_legal_rx +UVM_VERBOSITY=UVM_LOW 
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3
	#firefox covhtmlreport/index.html&
	#firefox --new-window covhtmlreport/index.html&

run_test3_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave3.wlf -l test4.log  -sv_seed 227862305  work.testbench +UVM_TESTNAME=cfs_algn_test_reg_access
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4
	#firefox covhtmlreport/index.html&

run_test4_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave4.wlf -l test5.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_illegal_rx
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5
	#firefox covhtmlreport/index.html&

run_test5_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave5.wlf -l test6.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_rxfifo_full
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6
	#firefox covhtmlreport/index.html&

run_test6_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave6.wlf -l test7.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_reg_access
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7
	#firefox covhtmlreport/index.html&

run_test7_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave7.wlf -l test8.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_apb_back2back
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8
	#firefox covhtmlreport/index.html&

run_test8_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave8.wlf -l test9.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_apb_reset_during_access
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9
	#firefox covhtmlreport/index.html&

run_test9_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10)  -wlf wave9.wlf -l test10.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_split_directed
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10
	#firefox covhtmlreport/index.html&

run_test10_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10)  -wlf wave10.wlf -l test11.log  -sv_seed random  work.testbench +UVM_TESTNAME=algn_test_legal_rx_ctrl_directed
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10
	#firefox covhtmlreport/index.html&




#run_test3_Questa: clean sv_cmp
#	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave3.wlf -l test4.log  -sv_seed 227862305  work.testbench +UVM_TESTNAME=cfs_algn_test_random_rx_err 
# to stop the simulation after 1 error add +UVM_MAX_QUIT_COUNT=1
# run_test3 seed=3339765295, this seed doesn't issue any errors
view_wave1_Questa: 
	vsim -view wave.wlf

view_wave2_Questa: 
	vsim -view wave1.wlf

view_wave3_Questa: 
	vsim -view wave2.wlf

view_wave4_Questa: 
	vsim -view wave3.wlf

view_wave5_Questa: 
	vsim -view wave4.wlf

view_wave6_Questa: 
	vsim -view wave5.wlf

view_wave7_Questa: 
	vsim -view wave6.wlf

view_wave8_Questa: 
	vsim -view wave7.wlf

view_wave9_Questa: 
	vsim -view wave8.wlf
	
view_wave10_Questa: 
	vsim -view wave9.wlf

view_wave11_Questa: 
	vsim -view wave10.wlf




report_Questa:
	#vcover merge mem_cov mem_cov1 mem_cov3 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10 mem_cov11
#	vcover merge mem_cov mem_cov6
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

#regress_Questa: clean_Questa run_test_Questa run_test2_Questa run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa run_test8_Questa run_test9_Questa report_Questa cov_Questa
regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa run_test8_Questa run_test9_Questa run_test10_Questa report_Questa cov_Questa
#regress_Questa: clean_Questa run_test5_Questa report_Questa cov_Questa


cov_Questa:
	firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear







# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) 
	      
run_test_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=ram_single_addr_test
	
run_test1_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=ram_ten_addr_test 	
	
run_test2_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave2.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=ram_odd_addr_test
	
run_test3_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave3.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=ram_even_addr_test 	
	
clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h *.fsdb verdi*
	clear

view_wave1_VCS: 
	verdi -ssf wave.fsdb
        
view_wave2_VCS: 
	verdi -ssf wave1.fsdb

view_wave3_VCS: 
	verdi -ssf wave2.fsdb

view_wave4_VCS: 
	verdi -ssf wave3.fsdb   

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
