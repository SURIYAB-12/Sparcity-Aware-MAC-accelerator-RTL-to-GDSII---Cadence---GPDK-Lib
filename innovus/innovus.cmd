#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Mar 11 10:24:05 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.15-s110_1 (64bit) 09/23/2022 13:08 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.15-s110_1 NR220912-2004/21_15-UB (database version 18.20.592) {superthreading v2.17}
#@(#)CDS: AAE 21.15-s039 (64bit) 09/23/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.15-s038_1 () Sep 20 2022 11:42:13 ( )
#@(#)CDS: SYNTECH 21.15-s012_1 () Sep  5 2022 10:25:51 ( )
#@(#)CDS: CPE v21.15-s076
#@(#)CDS: IQuantus/TQuantus 21.1.1-s867 (64bit) Sun Jun 26 22:12:54 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
win
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set dbgDualViewAwareXTree 1
set defHierChar /
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set enable_ilm_dual_view_gui_and_attribute 1
set enc_enable_print_mode_command_reset_options 1
set init_design_settop 0
set init_gnd_net vss
set init_lef_file {/home/install/FOUNDRY/digital/90nm/dig/lef/gsclib090_translated.lef ../../../install/FOUNDRY/digital/90nm/dig/lef/gsclib090_translated_ref.lef}
set init_mmmc_file Default.view
set init_pwr_net vdd
set init_verilog netlist.txt
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
set pegEnableDualViewForTQuantus 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set report_inactive_arcs_format {from to when arc_type sense reason}
set spgUnflattenIlmInCheckPlace 2
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
get_message -id GLOBAL-100 -suppress
suppressMessage -silent GLOBAL-100
unsuppressMessage -silent GLOBAL-100
set timing_enable_default_delay_arc 1
set init_verilog_tolerate_port_mismatch 0
set load_netlist_ignore_undefined_cell 1
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site gsclib090site -r 0.990355731225 0.699974 8 8 8 8
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site gsclib090site -r 0.93471810089 0.69894 8.12 8.12 8.12 8.12
uiSetTool select
getIoFlowFlag
fit
clearGlobalNets
globalNetConnect vss -type pgpin -pin vss -instanceBasename * -hierarchicalInstance {}
globalNetConnect vdd -type pgpin -pin vdd -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect vss -type pgpin -pin vss -instanceBasename * -hierarchicalInstance {}
globalNetConnect vdd -type pgpin -pin vdd -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect vss -type pgpin -pin vss -instanceBasename * -hierarchicalInstance {}
globalNetConnect vdd -type pgpin -pin vdd -instanceBasename * -hierarchicalInstance {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {vss vdd} -type core_rings -follow core -layer {top Metal1 bottom Metal1 left Metal2 right Metal2} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {vss vdd} -type core_rings -follow core -layer {top Metal1 bottom Metal1 left Metal2 right Metal2} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 0.5 bottom 0.5 left 0.5 right 0.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {vss vdd} -layer Metal9 -direction horizontal -width 1.8 -spacing 0.5 -number_of_sets 3 -start_from bottom -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {vss vdd} -layer Metal8 -direction vertical -width 1.8 -spacing 0.5 -number_of_sets 3 -start_from left -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {vss vdd} -layer Metal8 -direction vertical -width 1.8 -spacing 0.5 -number_of_sets 3 -start_from left -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal9(9) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal9(9) } -nets { vss vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal9(9) }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal9(9) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal9(9) } -nets { vss vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal9(9) }
addEndCap -preCap FILL4 -postCap FILL4 -prefix ENDCAP
addEndCap -preCap FILL4 -postCap FILL4 -prefix ENDCAP
addWellTap -cell FILL4 -cellInterval 35 -prefix WELLTAP
addWellTap -cell FILL4 -cellInterval 35 -prefix WELLTAP
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -droutePostRouteWidenWireRule LEFDefaultRouteSpec_gpdk090
setNanoRouteMode -quiet -timingEngine {}
setUsefulSkewMode -noBoundary false -maxAllowedDelay 1
setPlaceMode -reset
setPlaceMode -congEffort auto -timingDriven 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 1 -moduleAwareSpare 0 -preserveRouting 1 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setUsefulSkewMode -noBoundary false -maxAllowedDelay 1
setMultiCpuUsage -localCpu 20 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setDistributeHost -local
setMultiCpuUsage -localCpu 20 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setDistributeHost -local
setPlaceMode -fp false
place_design
setPlaceMode -fp false
place_design
zoomBox 16.73650 55.65650 63.68100 78.95750
zoomBox 19.53700 57.84950 59.44050 77.65550
zoomBox 21.91800 59.71350 55.83600 76.54850
zoomBox 0.99800 41.85900 90.93050 86.49700
zoomBox -4.92950 36.75200 100.87350 89.26750
zoomBox -7.45150 28.25700 117.02350 90.04000
zoomBox -13.66150 7.10450 158.62200 92.61750
zoomBox -2.90500 35.38550 102.89900 87.90150
gui_select -rect {6.29750 86.16400 12.60450 74.57950}
deselectAll
gui_select -rect {10.15900 84.16850 24.38200 75.86650}
zoomBox -90.15600 -30.97950 298.12850 161.74550
zoomBox -136.60150 -66.26750 400.81650 200.48000
zoomBox 10.60550 31.87050 213.29350 132.47500
zoomBox 65.89350 68.88250 142.33950 106.82650
deselectAll
selectWire 4.3100 94.3700 109.6600 96.1700 9 vss
deselectAll
selectInst {u_regs_skipped_ops_reg[7]}
zoomBox 51.25550 55.03350 175.73500 116.81900
zoomBox 40.00050 41.13250 212.29100 126.64900
zoomBox 32.18350 -77.50350 664.46700 236.33050
zoomBox 33.68100 -4.54650 314.22900 134.70350
zoomBox 37.10700 24.32900 183.55500 97.01850
deselectAll
selectInst {u_regs_total_ops_reg[17]}
deselectAll
selectVia 102.4400 66.7150 102.5900 66.9750 2 {total_ops_out[17]}
zoomBox 42.71850 31.81150 167.20000 93.59800
zoomBox 47.48850 38.17200 153.29800 90.69050
zoomBox 55.93400 54.80900 111.16850 82.22450
deselectAll
selectInst {u_regs_total_ops_reg[2]}
zoomBox -3.38250 21.91100 168.91750 107.43200
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix sa_mac_soc_top_preCTS -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix sa_mac_soc_top_preCTS -outDir timingReports
report_area
report_power
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -preCTS
getCTSMode -engine -quiet
create_ccopt_clock_tree_spec
ctd_win -side none -id ctd_window
deselectInst {u_regs_total_ops_reg[2]}
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeTopRoutingLayer 9
setNanoRouteMode -quiet -routeBottomRoutingLayer 1
setNanoRouteMode -quiet -drouteEndIteration 1
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail
zoomBox -18.65950 16.73250 184.04650 117.34550
fit
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix sa_mac_soc_top_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix sa_mac_soc_top_postRoute -outDir timingReports
report_power
report_area
saveDesign sa_mac_soc_top
saveDesign sa_mac_soc_top
saveNetlist sa_mac_soc_top.v
streamOut samac_route.enc -mapFile streamout.map -libName DesignLib -units 2000 -mode ALL
streamOut samac_route.enc -mapFile streamOut.map -libName DesignLib -units 2000 -mode ALL
streamOut samac_route.enc -mapFile streamOut.map -libName DesignLib -units 2000 -mode ALL
