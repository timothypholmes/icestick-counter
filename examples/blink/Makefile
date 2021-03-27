flash: top.bin
	iceprog top.bin

top.blif: top.v
	yosys -p "synth_ice40 -blif top.blif" top.v

top.txt: top.blif icestick.pcf
	arachne-pnr -d 1k -p icestick.pcf top.blif -o top.txt

top.bin: top.txt
	icepack top.txt top.bin