TARGETS = $(BDFS) $(TTFS)
SRCS := src/hd44780-1.font.txt src/hd44780-1.chars.txt \
	src/hd44780-2.font.txt src/hd44780-2.chars.txt
BDFS := bdf/hd44780-1.bdf bdf/hd44780-2.bdf
TTFS := ttf/hd44780-1.ttf ttf/hd44780-2.ttf
BDFBDF := ~/git/dse.d/perl-font-bitmap/bin/bdfbdf
BDFBDF_OPTIONS := --assume --resolution-x=66 --resolution-y=61
BITMAPFONT2TTF := bitmapfont2ttf
BITMAPFONT2TTF_OPTIONS := --dot-width 0.833333 --dot-height 0.833333 --save-sfd --fill-bounding-box-width

default: $(TARGETS)

debug:
	BITMAPFONT2TTF=1 make default

bdf/%.bdf: src/%.font.txt src/%.chars.txt Makefile
	$(BDFBDF) $(BDFBDF_OPTIONS) $< > $@.tmp.bdf
	mv $@.tmp.bdf $@

ttf/%.ttf: bdf/%.bdf Makefile
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.ttf
	mv $@.tmp.ttf $@

clean:
	/bin/rm $(BDFS) $(TTFS) || true
