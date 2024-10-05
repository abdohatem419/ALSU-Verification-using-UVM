vlib work
vlog -f src_files.list +cover
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover

add wave /top/ALSU_if/*
coverage save top.ucdb -onexit 
run -all
