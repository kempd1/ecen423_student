# imp_buttoncount.tcl
#
# This Tcl script is used to perform implementation
# (placement, routing, and timing analysis) on the buttoncount design.
# It demonstrates the commands needed by the Vivado implementation
# tool. It requires the buttoncount_synth.dcp file generated from
# the synthesis step.

# Read the synthesized design checkpoint file
open_checkpoint buttoncount_synth.dcp
# Update the message severity
source ../resources/messages.tcl

# Perform design optimization, placement, and routing
opt_design
place_design
route_design

# Generate a timing report
report_timing_summary -max_paths 10 -report_unconstrained -file buttoncount_timing.rpt -warn_on_violation
# Generate a utilization report
report_utilization -file buttoncount_utilization.rpt

# Generate the bitstream and final design checkpoint
write_bitstream -force buttoncount.bit
write_checkpoint -force buttoncount.dcp