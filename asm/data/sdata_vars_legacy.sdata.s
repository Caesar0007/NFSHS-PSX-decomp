.include "macro.inc"
/* P886: native vars.obj initialized-data oracle, 0x8013DC64..0x8013DD04.
 * Raw bytes and all labels are retained for src; recon uses the typed owner. */

.section .sdata, "wa"

nonmatching kanjiwidth

dlabel kanjiwidth
    /* 12E464 8013DC64 00000000 */ .word 0x00000000
enddlabel kanjiwidth

nonmatching grmode

dlabel grmode
    /* 12E468 8013DC68 00000000 */ .word 0x00000000
enddlabel grmode

nonmatching mouseflag

dlabel mouseflag
    /* 12E46C 8013DC6C 00000000 */ .word 0x00000000
enddlabel mouseflag

nonmatching mx

dlabel mx
    /* 12E470 8013DC70 00000000 */ .word 0x00000000
enddlabel mx

nonmatching my

dlabel my
    /* 12E474 8013DC74 00000000 */ .word 0x00000000
enddlabel my

nonmatching mbuttons

dlabel mbuttons
    /* 12E478 8013DC78 00000000 */ .word 0x00000000
enddlabel mbuttons

nonmatching mouseshown

dlabel mouseshown
    /* 12E47C 8013DC7C 00000000 */ .word 0x00000000
enddlabel mouseshown

nonmatching mouseratio

dlabel mouseratio
    /* 12E480 8013DC80 00000000 */ .word 0x00000000
enddlabel mouseratio

nonmatching numjoy

dlabel numjoy
    /* 12E484 8013DC84 00000000 */ .word 0x00000000
enddlabel numjoy

nonmatching screenwidth

dlabel screenwidth
    /* 12E488 8013DC88 00000000 */ .word 0x00000000
enddlabel screenwidth

nonmatching screenheight

dlabel screenheight
    /* 12E48C 8013DC8C 00000000 */ .word 0x00000000
enddlabel screenheight

nonmatching screenbpp

dlabel screenbpp
    /* 12E490 8013DC90 00000000 */ .word 0x00000000
enddlabel screenbpp

nonmatching screenvisiblex

dlabel screenvisiblex
    /* 12E494 8013DC94 10000000 */ .word 0x00000010
enddlabel screenvisiblex

nonmatching screenvisibley

dlabel screenvisibley
    /* 12E498 8013DC98 10000000 */ .word 0x00000010
enddlabel screenvisibley

nonmatching screenvisiblew

dlabel screenvisiblew
    /* 12E49C 8013DC9C 20010000 */ .word 0x00000120
enddlabel screenvisiblew

nonmatching screenvisibleh

dlabel screenvisibleh
    /* 12E4A0 8013DCA0 D0000000 */ .word 0x000000D0
enddlabel screenvisibleh

.align 2
nonmatching zclipvalue

dlabel zclipvalue
    /* 12E4A4 8013DCA4 */ .asciz "\n"
    /* 0A000000 */
.align 2
enddlabel zclipvalue

nonmatching zclipflag

dlabel zclipflag
    /* 12E4A8 8013DCA8 00000000 */ .word 0x00000000
enddlabel zclipflag

nonmatching ticks

dlabel ticks
    /* 12E4AC 8013DCAC 00000000 */ .word 0x00000000
enddlabel ticks

nonmatching libticks

dlabel libticks
    /* 12E4B0 8013DCB0 00000000 */ .word 0x00000000
enddlabel libticks

nonmatching vblflag

dlabel vblflag
    /* 12E4B4 8013DCB4 00000000 */ .word 0x00000000
enddlabel vblflag

nonmatching pageflipflag

dlabel pageflipflag
    /* 12E4B8 8013DCB8 00000000 */ .word 0x00000000
enddlabel pageflipflag

nonmatching vblticks

dlabel vblticks
    /* 12E4BC 8013DCBC 00000000 */ .word 0x00000000
enddlabel vblticks

nonmatching debugexit

dlabel debugexit
    /* 12E4C0 8013DCC0 00000000 */ .word 0x00000000
enddlabel debugexit

nonmatching timerhz

dlabel timerhz
    /* 12E4C4 8013DCC4 00000000 */ .word 0x00000000
enddlabel timerhz

nonmatching mb_default

dlabel mb_default
    /* 12E4C8 8013DCC8 00000000 */ .word 0x00000000
enddlabel mb_default

nonmatching loadfilesize

dlabel loadfilesize
    /* 12E4CC 8013DCCC 00000000 */ .word 0x00000000
enddlabel loadfilesize

nonmatching sendtoprintmem

dlabel sendtoprintmem
    /* 12E4D0 8013DCD0 00000000 */ .word 0x00000000
enddlabel sendtoprintmem

nonmatching abortflag

dlabel abortflag
    /* 12E4D4 8013DCD4 00000000 */ .word 0x00000000
enddlabel abortflag

nonmatching cenxpix

dlabel cenxpix
    /* 12E4D8 8013DCD8 A0000000 */ .word 0x000000A0
enddlabel cenxpix

.align 2
nonmatching cenypix

dlabel cenypix
    /* 12E4DC 8013DCDC */ .asciz "d"
    /* 64000000 */
.align 2
enddlabel cenypix

nonmatching originx

dlabel originx
    /* 12E4E0 8013DCE0 00000000 */ .word 0x00000000
enddlabel originx

nonmatching originy

dlabel originy
    /* 12E4E4 8013DCE4 00000000 */ .word 0x00000000
enddlabel originy

nonmatching centerx

dlabel centerx
    /* 12E4E8 8013DCE8 A0000000 */ .word 0x000000A0
enddlabel centerx

.align 2
nonmatching centery

dlabel centery
    /* 12E4EC 8013DCEC */ .asciz "d"
    /* 64000000 */
.align 2
enddlabel centery

nonmatching xscale

dlabel xscale
    /* 12E4F0 8013DCF0 00000000 */ .word 0x00000000
enddlabel xscale

nonmatching yscale

dlabel yscale
    /* 12E4F4 8013DCF4 00000000 */ .word 0x00000000
enddlabel yscale

nonmatching xbangle

dlabel xbangle
    /* 12E4F8 8013DCF8 00000000 */ .word 0x00000000
enddlabel xbangle

nonmatching ybangle

dlabel ybangle
    /* 12E4FC 8013DCFC 00000000 */ .word 0x00000000
enddlabel ybangle

nonmatching aspectratio

dlabel aspectratio
    /* 12E500 8013DD00 00000100 */ .word 0x00010000
enddlabel aspectratio

