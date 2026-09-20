.include "macro.inc"
/* pageflip.obj initialized-data oracle, 0x8013DD70..0x8013DD7C (2026-09-20, owner proven by retail link order).
 * Raw bytes and labels are retained for src; recon uses the typed owner. */

.section .sdata, "wa"

nonmatching gpusetdispenv

dlabel gpusetdispenv
    /* 12E570 8013DD70 00000000 */ .word 0x00000000
enddlabel gpusetdispenv

nonmatching vblsetdispenv

dlabel vblsetdispenv
    /* 12E574 8013DD74 00000000 */ .word 0x00000000
enddlabel vblsetdispenv

nonmatching vsdeferred

dlabel vsdeferred
    /* 12E578 8013DD78 00000000 */ .word 0x00000000
enddlabel vsdeferred

