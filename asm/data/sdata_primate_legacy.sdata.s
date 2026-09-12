.include "macro.inc"
/* P904: native primate.obj initialized-data oracle,8013DD04..8013DD18.
 * The src lane retains these exact labels/bytes; recon uses primate.c. */
.section .sdata, "wa"
nonmatching otbuf
dlabel otbuf
    /* 12E504 8013DD04 00000000 */ .word 0x00000000
enddlabel otbuf
nonmatching primbuf
dlabel primbuf
    /* 12E508 8013DD08 00000000 */ .word 0x00000000
enddlabel primbuf
nonmatching linkmodeflag
dlabel linkmodeflag
    /* 12E50C 8013DD0C 00000000 */ .word 0x00000000
enddlabel linkmodeflag
nonmatching drawpending
dlabel drawpending
    /* 12E510 8013DD10 00000000 */ .word 0x00000000
enddlabel drawpending
nonmatching semitrans
dlabel semitrans
    /* 12E514 8013DD14 01000000 */ .word 0x00000001
enddlabel semitrans
