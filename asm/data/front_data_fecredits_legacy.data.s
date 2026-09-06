.include "macro.inc"
/* P881 oracle-only FECredits data at 80051AA0..80051AA8.
 * The reconstruction lane uses fecredits.cpp CREDFADETICKS and local lasttick.
 * Keep this byte-exact raw copy only for the src/oracle lane. */
.section .data, "wa"

nonmatching CREDFADETICKS

dlabel CREDFADETICKS
    /* 422A0 80051AA0 BC020000 */ .word 0x000002BC
enddlabel CREDFADETICKS

nonmatching D_80051AA4

dlabel D_80051AA4
    /* 422A4 80051AA4 00000000 */ .word 0x00000000
enddlabel D_80051AA4
