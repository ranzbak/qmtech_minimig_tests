
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
�

�	
Reference - Incremental Comparison Summary

1. Comparison with Reference Run
--------------------------------

+-----------------+---------------------------+---------------------------+---------------------------+
|                 |          WNS(ns)          |  Runtime(elapsed)(hh:mm)  |    Runtime(cpu)(hh:mm)    |
+-----------------+-------------+-------------+-------------+-------------+-------------+-------------+
|      Stage      |  Reference  | Incremental |  Reference  | Incremental |  Reference  | Incremental |
+-----------------+-------------+-------------+-------------+-------------+-------------+-------------+
| synth_design    |             |             |     < 1 min |     < 1 min |     < 1 min |     < 1 min |
| opt_design      |             |             |     < 1 min |     < 1 min |     < 1 min |     < 1 min |
| read_checkpoint |             |             |             |     < 1 min |             |     < 1 min |
| place_design    |         N/A |      30.743 |     < 1 min |     < 1 min |     < 1 min |     < 1 min |
| route_design    |      30.743 |      30.743 |     < 1 min |     < 1 min |     < 1 min |     < 1 min |
+-----------------+-------------+-------------+-------------+-------------+-------------+-------------+


*commonh px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
552default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2304.5512default:default2
0.0002default:default2
23582default:default2
279242default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.052default:default2
00:00:00.022default:default2
2304.5512default:default2
0.0002default:default2
23582default:default2
279252default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
s/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.runs/impl_1/hello_aars_top_routed.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
Executing : report_drc -file hello_aars_top_drc_routed.rpt -pb hello_aars_top_drc_routed.pb -rpx hello_aars_top_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
rreport_drc -file hello_aars_top_drc_routed.rpt -pb hello_aars_top_drc_routed.pb -rpx hello_aars_top_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
w/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.runs/impl_1/hello_aars_top_drc_routed.rptw/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.runs/impl_1/hello_aars_top_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file hello_aars_top_methodology_drc_routed.rpt -pb hello_aars_top_methodology_drc_routed.pb -rpx hello_aars_top_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file hello_aars_top_methodology_drc_routed.rpt -pb hello_aars_top_methodology_drc_routed.pb -rpx hello_aars_top_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
42default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
�/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.runs/impl_1/hello_aars_top_methodology_drc_routed.rpt�/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.runs/impl_1/hello_aars_top_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_power -file hello_aars_top_power_routed.rpt -pb hello_aars_top_power_summary_routed.pb -rpx hello_aars_top_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file hello_aars_top_power_routed.rpt -pb hello_aars_top_power_summary_routed.pb -rpx hello_aars_top_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
672default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
%s4*runtcl2}
iExecuting : report_route_status -file hello_aars_top_route_status.rpt -pb hello_aars_top_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file hello_aars_top_timing_summary_routed.rpt -pb hello_aars_top_timing_summary_routed.pb -rpx hello_aars_top_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
42default:defaultZ38-191h px� 
�
%s4*runtcl2k
WExecuting : report_incremental_reuse -file hello_aars_top_incremental_reuse_routed.rpt
2default:defaulth px� 
�
EReporting incremental reuse summary using design-checkpoint file '%s'55*	vivadotcl2�
�/home/paul/work/fpga/Xilinx/artix7/qmtech_minimig_tests/hello_aars/hello_aars.srcs/utils_1/imports/impl_1/hello_aars_top_routed.dcp2default:defaultZ4-115h px� 
g

Starting %s Task
103*constraints2,
Report Incremental Reuse2default:defaultZ18-103h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.12 . Memory (MB): peak = 2341.953 ; gain = 0.000 ; free physical = 2322 ; free virtual = 278882default:defaulth px� 
�
�report_incremental_reuse: Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.12 . Memory (MB): peak = 2341.953 ; gain = 0.000 ; free physical = 2322 ; free virtual = 27888
*commonh px� 
�
%s4*runtcl2k
WExecuting : report_clock_utilization -file hello_aars_top_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file hello_aars_top_bus_skew_routed.rpt -pb hello_aars_top_bus_skew_routed.pb -rpx hello_aars_top_bus_skew_routed.rpx
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
42default:defaultZ38-191h px� 


End Record