SRC_FONTS  := $(wildcard src/*.font.txt)
SRC_CHARS  := $(patsubst src/%.font.txt,src/%.chars.txt,$(SRC_FONTS))
BDFS       := $(patsubst src/%.font.txt,bdf/%.bdf,$(SRC_FONTS))
TTFS       := $(patsubst src/%.font.txt,ttf/%.ttf,$(SRC_FONTS))
SFDS       := $(patsubst src/%.font.txt,sfd/%.sfd,$(SRC_FONTS))

BDFBDF                 := ~/git/dse.d/perl-font-bitmap/bin/bdfbdf
BDFBDF_OPTIONS         := --guess --resolution-x=66 --resolution-y=61
BITMAPFONT2TTF         := bitmapfont2ttf
BITMAPFONT2TTF_OPTIONS := --dot-width 0.833333 --dot-height 0.833333 --fill-bounding-box-width

TARGETS := $(BDFS) $(TTFS)

default: echo $(TARGETS)
sfd: $(SFDS)

debug:
	BITMAPFONT2TTF=1 make default

bdf/%.bdf: src/%.font.txt src/%.chars.txt Makefile
	mkdir -p bdf || true
	$(BDFBDF) $(BDFBDF_OPTIONS) $< > $@.tmp.bdf
	mv $@.tmp.bdf $@

sfd/%.sfd: bdf/%.bdf Makefile
	mkdir -p sfd || true
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.sfd
	mv $@.tmp.sfd $@

ttf/%.ttf: bdf/%.bdf Makefile
	mkdir -p ttf || true
	$(BITMAPFONT2TTF) $(BITMAPFONT2TTF_OPTIONS) $< $@.tmp.ttf
	mv $@.tmp.ttf $@

clean:
	/bin/rm $(BDFS) $(TTFS) */*.tmp.* >/dev/null 2>/dev/null || true

echo:
	@echo "SRC_FONTS = $(SRC_FONTS)"
	@echo "SRC_CHARS = $(SRC_CHARS)"
	@echo "BDFS = $(BDFS)"
	@echo "TTFS = $(TTFS)"
