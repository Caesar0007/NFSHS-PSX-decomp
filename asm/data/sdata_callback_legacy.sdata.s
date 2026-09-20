.include "macro.inc"
/* callback.obj initialized-data oracle, 0x8013DD60..0x8013DD64 (2026-09-20, owner proven by retail link order).
 * Raw bytes and labels are retained for src; recon uses the typed owner. */

.section .sdata, "wa"

nonmatching loadfilecallback

dlabel loadfilecallback
    /* 12E560 8013DD60 00000000 */ .word 0x00000000
enddlabel loadfilecallback

