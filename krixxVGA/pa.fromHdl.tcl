
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name krixxVGA -dir "/home/jaxc/Desktop/KRIXXVGA/krixxVGA/planAhead_run_3" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "VGA_MEM.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {charrom_package.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {charrom.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VGA_MEM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top VGA_MEM $srcset
add_files [list {VGA_MEM.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/CHARROM.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
