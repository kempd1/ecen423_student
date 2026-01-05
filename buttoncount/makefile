#
# This is a makefile to demonstrate how to create simple rules for simulating,
# synthesizing, and building the buttoncount application. This makefile provides
# an example of common makefile rules you will use all semester.
#

################################
# Simulation
################################

# This section includes all the rules for simulating the SystemVerilog design.
# The rules in this section will create the 'xsim.dir' directory. The
# clean rule at the bottom of this makefile will remove this directory.
# An entry in the .gitignore file will ignore this directory.

# Analyze - compile the SystemVerilog files for simulation.#
# This rule will perform the HDL analysis step for the buttoncount design.
# The file xvlog.pb will be created with this command (should be ignored and cleaned).
#  $^ refers to all the dependencies of the rule (the SV files)
analyze_buttoncount: buttoncount.sv ../include/synchronizer.sv ../include/oneshot.sv buttoncount_tb.sv
	xvlog $^ -sv --nolog

# This rule will 'elaborate' the top-level design (buttoncount) in preparation
# for simulation of the top-level design. The SV files need to be analyzed before the
# elaboration step.
# The file xelab.pb will be created with this command (should be ignored and cleaned).
elab_buttoncount: analyze_buttoncount
	xelab buttoncount -debug typical -nolog

# This rule will 'elaborate' the testbench in preparation
# for simulation of the testbench.
elab_buttoncount_tb: analyze_buttoncount
	xelab buttoncount_tb -debug typical -nolog

# This rule will simulate the buttoncount design in GUI mode.
# Elaboration needs to be complete before simulation.
# It will create the waveform file buttoncount.wdb
sim_buttoncount_gui: elab_buttoncount
	xsim buttoncount -gui --nolog

# Rule for simulating the testbench in command line mode. 
#  Note the use of the --runall option that will run the simulation until completion.
#  Note also the 'log' option that will create a log file for the simulation. This
#  log file will be analyzed for correctness. You will need to ignore and clean this file.
sim_buttoncount_tb: elab_buttoncount_tb
	xsim buttoncount_tb --log sim_buttoncount_tb.log --runall

################################
# Implementation
################################


# This rule will perform the 'synthesis' step for the buttoncount design.
# It relies on the 'synth_buttoncount.tcl' synthesis script.
# It will create the directory .Xil directory (which should be ignored
# and cleaned). The target for this rule is the "design checkpoint" (dcp) file
# buttoncount_synth.dcp. It is needed for the subsequent place and route steps.
# This rule also creates the synth_buttoncount.log file that should be reviewed
# for synthesis warnings and errors. This log file should also be ignored and cleaned.
buttoncount_synth.dcp: synth_buttoncount.tcl buttoncount.sv
	vivado -mode batch -script synth_buttoncount.tcl -nojournal -log buttoncount_synth.log

# This rule will perform the 'implementation' step for the buttoncount design.
# The following files will be created with this command. Each of these commands
# should be ignored and cleaned.
# - imp_buttoncount.log          : logfile for the implementation step
# - buttoncount.bit              : the bitstream file for programming the FPGA
# - buttoncount.dcp		         : the design checkpoint after implementation
# - buttoncount_timing.rpt       : Timing report after implementation
# - buttoncount_utilization.rpt  : Utilization report after implementation
# - clockInfo.txt                : Intermediate clock information file (not needed)
buttoncount.bit: buttoncount_synth.dcp
	vivado -mode batch -script imp_buttoncount.tcl -log buttoncount_imp.log

# All labs must have a 'clean' rule to remove generated files. This clean rule
# will remove all generated files for the buttoncount design.
clean:
	rm -rf xsim.dir .Xil buttoncount_tb.wdb xsim*.jou xelab.pb xvlog.log xvlog.pb vivado*.str vivado*.jou
	rm -f sim_buttoncount_tb*.log *.wdb
	rm -f buttoncount_synth.dcp buttoncount_synth*.log
	rm -f buttoncount.bit buttoncount.dcp
	rm -f clockInfo.txt buttoncount_timing.rpt buttoncount_utilization.rpt buttoncount_imp*.log