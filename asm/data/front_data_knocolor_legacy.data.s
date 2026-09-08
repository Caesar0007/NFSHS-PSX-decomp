.include "macro.inc"
/* P887: native drawshp.obj kNoColor oracle, 0x800529D0..0x800529D4.
 * This four-byte cell is src-only; recon uses its typed source owner. */

.section .data, "wa"

nonmatching kNoColor

dlabel kNoColor
    /* 431D0 800529D0 80808000 */ .word 0x00808080
enddlabel kNoColor
