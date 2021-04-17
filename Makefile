TARGETS = $(BDFS) $(TTFS)

SRC_FONTS  = src/hd44780-1.font.txt \
	     src/hd44780-2.font.txt \
	     src/apple2.font.txt    \
	     src/st0766-0A.font.txt \
	     src/st0766-0B.font.txt
SRC_CHARS  = $(patsubst src/%.font.txt,src/%.chars.txt,$(SRC_FONTS))
BDFS       = $(patsubst src/%.font.txt,bdf/%.bdf,$(SRC_FONTS))
TTFS       = $(patsubst src/%.font.txt,ttf/%.ttf,$(SRC_FONTS))

BDFBDF                 = ~/git/dse.d/perl-font-bitmap/bin/bdfbdf
BDFBDF_OPTIONS         = --assume --resolution-x=66 --resolution-y=61
BITMAPFONT2TTF         = bitmapfont2ttf
BITMAPFONT2TTF_OPTIONS = --dot-width 0.833333 --dot-height 0.833333 --fill-bounding-box-width

default: $(TARGETS)

debug:
	BITMAPFONT2TTF=1 make default

bdf/%.bdf: src/%.font.txt src/%.chars.txt Makefile
	mkdir -p bdf || true
	$(BDFBDF) $(BDFBDF_OPTIONS) $< > $@.tmp.bdf
	mv $@.tmp.bdf $@

ttf/%.ttf: bdf/%.bdf Makefile
	mkdir -p ttf || true
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.ttf
	mv $@.tmp.ttf $@

clean:
	/bin/rm $(BDFS) $(TTFS) ttf/*.tmp.sfd || true
