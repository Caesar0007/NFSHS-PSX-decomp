.include "macro.inc"
/* textfor.obj initialized-data oracle, 0x8013DD50..0x8013DD5C (2026-09-20, owner proven by retail link order).
 * Raw bytes and labels are retained for src; recon uses the typed owner. */

.section .sdata, "wa"

nonmatching textntabstops

dlabel textntabstops
    /* 12E550 8013DD50 00000000 */ .word 0x00000000
enddlabel textntabstops

nonmatching texttabstops

dlabel texttabstops
    /* 12E554 8013DD54 00000000 */ .word 0x00000000
enddlabel texttabstops

nonmatching showmissingcharacters

dlabel showmissingcharacters
    /* 12E558 8013DD58 00000000 */ .word 0x00000000
enddlabel showmissingcharacters

