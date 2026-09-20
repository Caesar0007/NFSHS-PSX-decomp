.include "macro.inc"
/* window.obj initialized-data oracle, 0x8013DD64..0x8013DD70 (2026-09-20, owner proven by retail link order).
 * Raw bytes and labels are retained for src; recon uses the typed owner. */

.section .sdata, "wa"

nonmatching videopages

dlabel videopages
    /* 12E564 8013DD64 00000000 */ .word 0x00000000
enddlabel videopages

nonmatching videopage

dlabel videopage
    /* 12E568 8013DD68 00000000 */ .word 0x00000000
enddlabel videopage

nonmatching windowpage

dlabel windowpage
    /* 12E56C 8013DD6C 00000000 */ .word 0x00000000
enddlabel windowpage

