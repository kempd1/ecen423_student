# synth_buttoncount.tcl
#
# This Tcl script is used to synthesize the ButtonCount design.
# It demostrates the commands needed by the Vivado synthesis tool to
# read in the design files, apply constraints, and run synthesis.

# Read the verilog files into the synthesis tool
read_verilog -sv ButtonCount.sv
read_verilog -sv ../include/synchronizer.sv
read_verilog -sv ../include/OneShot.sv

# Read the constraints file
read_xdc ButtonCount.xdc

# Change the error message severity levels. Use this for all your
# synthesis and implementation Tcl scripts.
source ../resources/messages.tcl

# Run the sythesis command
synth_design -top ButtonCount -part xc7a35tcpg236-1 -verbose

# Write out the synthesized design checkpoint. This checkpoint file
# is needed for the implementation step.
write_checkpoint -force ButtonCount_synth.dcp
