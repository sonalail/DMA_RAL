compile:
	vlib work;
	vlog -l compile.log ../src/$(top_file)

run:
	vsim -c -novopt -suppress 12110 work.$(top_module) $(arg) -l run.log -do "/*; add wave -r /*; run -all; exit;" -wlf waveform.wlf

view:
	vsim -view waveform.wlf

clean:
	rm -rf transcript *.vcd *.wlf work/ *.log *.ucdb *.vstf covReport covhtmlreport 
