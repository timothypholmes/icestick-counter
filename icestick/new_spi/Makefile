DEVICE = 1k
PACKAGE = tq144

VERILOGS = spi.v
PCF = icestick.pcf

all: upload

%.blif: $(VERILOGS)
	yosys -q -p 'synth_ice40 -top top -blif $@' $(VERILOGS)

%.txt: %.blif
	arachne-pnr -d $(DEVICE) -P $(PACKAGE) -o $@ -p $(PCF) $<

%.bin: %.txt
	icepack $< $@

upload: top.bin
	iceprog $<

explain: top.txt
	icebox_explain $<

clean:
	rm -f *.bin *.txt *.blif

.PRECIOUS: %.bin %.txt %.blif

.PHONY: all explain install clean
