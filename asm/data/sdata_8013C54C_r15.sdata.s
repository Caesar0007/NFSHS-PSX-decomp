.include "macro.inc"
/* W64-A18: residual segment of sdata_8013C54C -- labels no recon TU defines
 * (or a record tail a recon TU's section stops short of).
 * Linked by BOTH lanes. */

/* P882: Sim's preceding 0x28-byte span is selected separately. */

.section .sdata.r15_simqueue_legacy, "wa"

nonmatching gSimQueue_Ticker

dlabel gSimQueue_Ticker
    /* 12DC34 8013D434 FFFFFFFF */ .word 0xFFFFFFFF
enddlabel gSimQueue_Ticker

nonmatching gSimQueue_BlockSelf

dlabel gSimQueue_BlockSelf
    /* 12DC38 8013D438 01000000 */ .word 0x00000001
enddlabel gSimQueue_BlockSelf

nonmatching gSimQueue_BlockOther

dlabel gSimQueue_BlockOther
    /* 12DC3C 8013D43C 01000000 */ .word 0x00000001
enddlabel gSimQueue_BlockOther

.section .sdata.r15_after_simqueue, "wa"

.align 2
nonmatching D_8013D440

dlabel D_8013D440
    /* 12DC40 8013D440 */ .asciz "souffle"
    /* 736F7566666C6500 */
.align 2
enddlabel D_8013D440
