.include "macro.inc"
/* P905: exact merged-EXE transport oracle,8013DE68..8013DE90. These zeros
 * are not evidence of a native initialized section: MAP says SBSS and CPE
 * contains no load here. Src keeps this leaf; recon owns NOBITS in primate.c. */
.section .data, "wa"
nonmatching oti
dlabel oti
    /* 12E668 8013DE68 00000000 */ .word 0x00000000
enddlabel oti
nonmatching otp
dlabel otp
    /* 12E66C 8013DE6C 00000000 */ .word 0x00000000
enddlabel otp
nonmatching otbl
dlabel otbl
    /* 12E670 8013DE70 00000000 */ .word 0x00000000
enddlabel otbl
nonmatching D_8013DE74
dlabel D_8013DE74
    /* 12E674 8013DE74 00000000 */ .word 0x00000000
enddlabel D_8013DE74
nonmatching nextprim
dlabel nextprim
    /* 12E678 8013DE78 00000000 */ .word 0x00000000
enddlabel nextprim
nonmatching maxot
dlabel maxot
    /* 12E67C 8013DE7C 00000000 */ .word 0x00000000
enddlabel maxot
nonmatching primptr
dlabel primptr
    /* 12E680 8013DE80 00000000 */ .word 0x00000000
enddlabel primptr
nonmatching primbase
dlabel primbase
    /* 12E684 8013DE84 00000000 */ .word 0x00000000
enddlabel primbase
nonmatching D_8013DE88
dlabel D_8013DE88
    /* 12E688 8013DE88 00000000 */ .word 0x00000000
enddlabel D_8013DE88
nonmatching maxprim
dlabel maxprim
    /* 12E68C 8013DE8C 00000000 */ .word 0x00000000
enddlabel maxprim
