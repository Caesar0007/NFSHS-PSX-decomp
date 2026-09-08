.include "macro.inc"
/* P885: oracle-only SNDEF .data, 0x80136CD0..0x80136CD8.
 * Original _stacksize/_ramsize symbols still denote data-cell addresses,
 * not their stored integer values. Reconstruction uses typed SNDEF.c. */

.section .data, "wa"

nonmatching _stacksize

dlabel _stacksize
    /* 1274D0 80136CD0 00800000 */ .word 0x00008000
enddlabel _stacksize

nonmatching _ramsize

dlabel _ramsize
    /* 1274D4 80136CD4 00008000 */ .word 0x00800000
enddlabel _ramsize
