TARGETS = $(TTFS)
BDFS := hd44780-1.bdf hd44780-2.bdf
TTFS := hd44780-1.ttf hd44780-2.ttf
BDFBDF := ~/git/dse.d/perl-font-bitmap/bin/bdfbdf
BDFBDF_OPTIONS := --assume
BITMAPFONT2TTF := bitmapfont2ttf
BITMAPFONT2TTF_OPTIONS := --pixel-width 0.85 --pixel-height 0.85 --save-sfd --fill-bounding-box-width

default: $(TARGETS)

hd44780-1.bdf: hd44780-1.font.txt hd44780-1.chars.txt Makefile
	$(BDFBDF) $(BDFBDF_OPTIONS) $< > $@.tmp.bdf
	mv $@.tmp.bdf $@

hd44780-2.bdf: hd44780-2.font.txt hd44780-2.chars.txt Makefile
	$(BDFBDF) $(BDFBDF_OPTIONS) $< > $@.tmp.bdf
	mv $@.tmp.bdf $@

hd44780-1.ttf: hd44780-1.bdf Makefile
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.ttf
	mv $@.tmp.ttf $@

hd44780-2.ttf: hd44780-2.bdf Makefile
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.ttf
	mv $@.tmp.ttf $@

clean:
	/bin/rm $(BDFS) $(TTFS) || true
