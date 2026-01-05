# synth_buttoncount.tcl
#
# This Tcl script is used to synthesize the buttoncount design.
# It demostrates the commands needed by the Vivado synthesis tool to
# read in the design files, apply constraints, and run synthesis.

# Read the verilog files into the synthesis tool
read_verilog -sv buttoncount.sv
read_verilog -sv ../include/synchronizer.sv
read_verilog -sv ../include/oneshot.sv

# Read the constraints file
read_xdc buttoncount.xdc

# Change the error message severity levels. Use this for all your
# synthesis and implementation Tcl scripts.
source ../resources/messages.tcl

# Run the sythesis command
synth_design -top buttoncount -part xc7a35tcpg236-1 -verbose

# Write out the synthesized design checkpoint. This checkpoint file
# is needed for the implementation step.
write_checkpoint -force buttoncount_synth.dcp
