onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 74 -max 63.0 -radix unsigned /tb/the_top/cntdelay
add wave -noupdate -radix unsigned /tb/the_top/cntdata
add wave -noupdate -format Analog-Step -height 74 -max 100.0 -radix unsigned /tb/the_top/the_display/cntscan
add wave -noupdate /tb/the_top/the_display/ds
add wave -noupdate /tb/the_top/Seg
add wave -noupdate /tb/the_top/the_display/Seg0001/Bcd
add wave -noupdate /tb/the_top/the_display/Seg0001/Seg
add wave -noupdate /tb/the_top/the_display/Seg0010/Bcd
add wave -noupdate /tb/the_top/the_display/Seg0010/Seg
add wave -noupdate /tb/the_top/the_display/Seg0100/Bcd
add wave -noupdate /tb/the_top/the_display/Seg0100/Seg
add wave -noupdate /tb/the_top/the_display/Seg1000/Bcd
add wave -noupdate /tb/the_top/the_display/Seg1000/Seg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4923798 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {10500 ns}
