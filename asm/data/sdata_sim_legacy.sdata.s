.include "macro.inc"
/* P882: oracle-only Sim .sdata, 0x8013D40C..0x8013D434.
 * Reconstruction selects the exact sim.cpp.o(.sdata) payload. */

.section .sdata, "wa"

nonmatching InBetween

dlabel InBetween
    /* 12DC0C 8013D40C 00000000 */ .word 0x00000000
enddlabel InBetween

.align 2
nonmatching D_8013D410

dlabel D_8013D410
    /* 12DC10 8013D410 */ .asciz "Sc32-1"
    /* 536333322D310000 */
.align 2
enddlabel D_8013D410

.align 2
nonmatching D_8013D418

dlabel D_8013D418
    /* 12DC18 8013D418 */ .asciz "Sc32-2"
    /* 536333322D320000 */
.align 2
enddlabel D_8013D418

.align 2
nonmatching D_8013D420

dlabel D_8013D420
    /* 12DC20 8013D420 */ .asciz "Sc64"
    /* 5363363400000000 */
.align 2
enddlabel D_8013D420

nonmatching unPauseDelay

dlabel unPauseDelay
    /* 12DC28 8013D428 00000000 */ .word 0x00000000
enddlabel unPauseDelay

nonmatching skipRender

dlabel skipRender
    /* 12DC2C 8013D42C 00000000 */ .word 0x00000000
enddlabel skipRender

nonmatching quitType

dlabel quitType
    /* 12DC30 8013D430 00000000 */ .word 0x00000000
enddlabel quitType
