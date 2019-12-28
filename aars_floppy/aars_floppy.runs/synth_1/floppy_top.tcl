# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_param chipscope.maxJobs 1
create_project -in_memory -part xc7a35tftg256-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.cache/wt [current_project]
set_property parent.project_path /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/new/floppy_input.sv
  /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/new/push_on_off.sv
  /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/new/floppy_top.sv
}
read_verilog -library xil_defaultlib /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/new/floppy_output.v
read_ip -quiet /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/constrs_1/new/floppy_constrs.xdc
set_property used_in_implementation false [get_files /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/constrs_1/new/floppy_constrs.xdc]

set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental /home/paul/work/fpga/Xilinx/artix7/projects/aars_floppy/aars_floppy.srcs/utils_1/imports/synth_1/floppy_top.dcp
close [open __synthesis_is_running__ w]

synth_design -top floppy_top -part xc7a35tftg256-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef -incremental_synth floppy_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file floppy_top_utilization_synth.rpt -pb floppy_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
