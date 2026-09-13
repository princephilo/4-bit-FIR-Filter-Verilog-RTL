# Cadence Innovus Implementation TCL Script for 4-Bit FIR Filter

# 1. Set Design and Library Variables
set DESIGN_NAME "fir"
set NETLIST_FILE "../../synthesis/fir_synth.v"
set TOP_MODULE "fir"

# 2. Initialize Design
init_design

# 3. Floorplanning
# Core utilization 40%, aspect ratio 1.0, 10um margins
floorPlan -r 1.0 0.40 10.0 10.0 10.0 10.0

# 4. Power Planning (VDD/VSS Rings & Stripes)
addRing -type core_rings -nets {VDD VSS} -width 1.0 -spacing 0.5 -layer {top M3 bottom M3 left M2 right M2}
addStripe -nets {VDD VSS} -layer M3 -width 1.0 -spacing 0.5 -set_to_set_distance 20

# 5. Placement
setPlaceMode -fp false
place_design -noPrePlaceOpt

# 6. Clock Tree Synthesis (CTS)
create_ccopt_clock_tree_spec
ccopt_design

# 7. Routing (NanoRoute)
setNanoRouteMode -quiet -drouteEndIteration default
routeDesign -globalDetail

# 8. Verification & Signoff
checkPlace
checkRoute
verify_drc
verify_connectivity

# 9. Export Final Outputs (DEF & GDS)
defOut -floorplan -routing physical_design/innovus/fir_innovus.def
streamOut physical_design/innovus/fir_innovus.gds -mapFile gds2.map -libName DesignLib -units 1000 -mode ALL
