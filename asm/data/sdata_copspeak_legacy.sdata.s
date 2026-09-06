.include "macro.inc"
/* P882: oracle-only CopSpeak .sdata, 0x8013D07C..0x8013D0FC.
 * Source payload is 0x7E bytes. The last existing raw word also retains
 * two retail alignment bytes; reconstruction gets them from SUBALIGN(4). */

.section .sdata, "wa"

nonmatching cdsectorreseek

dlabel cdsectorreseek
    /* 12D87C 8013D07C 00000000 */ .word 0x00000000
enddlabel cdsectorreseek

nonmatching CopSpeak_gHandleCount

dlabel CopSpeak_gHandleCount
    /* 12D880 8013D080 00000000 */ .word 0x00000000
enddlabel CopSpeak_gHandleCount

.align 2
nonmatching D_8013D084

dlabel D_8013D084
    /* 12D884 8013D084 */ .asciz "BAD!"
    /* 4241442100000000 */
.align 2
enddlabel D_8013D084

.align 2
nonmatching D_8013D08C

dlabel D_8013D08C
    /* 12D88C 8013D08C */ .asciz "lden"
    /* 6C64656E00000000 */
.align 2
enddlabel D_8013D08C

.align 2
nonmatching D_8013D094

dlabel D_8013D094
    /* 12D894 8013D094 */ .asciz "ldex"
    /* 6C64657800000000 */
.align 2
enddlabel D_8013D094

.align 2
nonmatching D_8013D09C

dlabel D_8013D09C
    /* 12D89C 8013D09C */ .asciz "fre"
    /* 66726500 */
.align 2
enddlabel D_8013D09C

.align 2
nonmatching D_8013D0A0

dlabel D_8013D0A0
    /* 12D8A0 8013D0A0 */ .asciz "ger"
    /* 67657200 */
.align 2
enddlabel D_8013D0A0

.align 2
nonmatching D_8013D0A4

dlabel D_8013D0A4
    /* 12D8A4 8013D0A4 */ .asciz "eng"
    /* 656E6700 */
.align 2
enddlabel D_8013D0A4

.align 2
nonmatching D_8013D0A8

dlabel D_8013D0A8
    /* 12D8A8 8013D0A8 */ .asciz "x"
    /* 78000000 */
.align 2
enddlabel D_8013D0A8

.align 2
nonmatching D_8013D0AC

dlabel D_8013D0AC
    /* 12D8AC 8013D0AC */ .asciz "s"
    /* 73000000 */
.align 2
enddlabel D_8013D0AC

.align 2
nonmatching D_8013D0B0

dlabel D_8013D0B0
    /* 12D8B0 8013D0B0 */ .asciz "."
    /* 2E000000 */
.align 2
enddlabel D_8013D0B0

.align 2
nonmatching D_8013D0B4

dlabel D_8013D0B4
    /* 12D8B4 8013D0B4 */ .asciz "n"
    /* 6E000000 */
.align 2
enddlabel D_8013D0B4

.align 2
nonmatching D_8013D0B8

dlabel D_8013D0B8
    /* 12D8B8 8013D0B8 */ .asciz "D"
    /* 44000000 */
.align 2
enddlabel D_8013D0B8

.align 2
nonmatching D_8013D0BC

dlabel D_8013D0BC
    /* 12D8BC 8013D0BC */ .asciz "%s%d"
    /* 2573256400000000 */
.align 2
enddlabel D_8013D0BC

.align 2
nonmatching D_8013D0C4

dlabel D_8013D0C4
    /* 12D8C4 8013D0C4 */ .asciz "|"
    /* 7C000000 */
.align 2
enddlabel D_8013D0C4

nonmatching CopSpeak_gQueueHead

dlabel CopSpeak_gQueueHead
    /* 12D8C8 8013D0C8 00000000 */ .word 0x00000000
enddlabel CopSpeak_gQueueHead

nonmatching CopSpeak_gQueuePlay

dlabel CopSpeak_gQueuePlay
    /* 12D8CC 8013D0CC 00000000 */ .word 0x00000000
enddlabel CopSpeak_gQueuePlay

nonmatching CopSpeak_gSpchHandle

dlabel CopSpeak_gSpchHandle
    /* 12D8D0 8013D0D0 00000000 */ .word 0x00000000
enddlabel CopSpeak_gSpchHandle

nonmatching CopSpeak_gNumTrackSfx

dlabel CopSpeak_gNumTrackSfx
    /* 12D8D4 8013D0D4 00000000 */ .word 0x00000000
enddlabel CopSpeak_gNumTrackSfx

nonmatching CopSpeak_gQueueLoad

dlabel CopSpeak_gQueueLoad
    /* 12D8D8 8013D0D8 00000000 */ .word 0x00000000
enddlabel CopSpeak_gQueueLoad

nonmatching CopSpeak_gQueueReady

dlabel CopSpeak_gQueueReady
    /* 12D8DC 8013D0DC 00000000 */ .word 0x00000000
enddlabel CopSpeak_gQueueReady

nonmatching CopSpeak_gWrongWay

dlabel CopSpeak_gWrongWay
    /* 12D8E0 8013D0E0 00000000 */ .word 0x00000000
enddlabel CopSpeak_gWrongWay

nonmatching CopSpeak_gBuffer

dlabel CopSpeak_gBuffer
    /* 12D8E4 8013D0E4 00000000 */ .word 0x00000000
enddlabel CopSpeak_gBuffer

nonmatching CopSpeak_gBufferLow

dlabel CopSpeak_gBufferLow
    /* 12D8E8 8013D0E8 */ .short 0x0000
enddlabel CopSpeak_gBufferLow

nonmatching CopSpeak_gBufferStart

dlabel CopSpeak_gBufferStart
    /* 12D8EA 8013D0EA */ .short 0x0000
enddlabel CopSpeak_gBufferStart

nonmatching CopSpeak_gBufferEnd

dlabel CopSpeak_gBufferEnd
    /* 12D8EC 8013D0EC */ .short 0x0000
enddlabel CopSpeak_gBufferEnd

nonmatching CopSpeak_gBufferHigh

dlabel CopSpeak_gBufferHigh
    /* 12D8EE 8013D0EE */ .short 0x0000
enddlabel CopSpeak_gBufferHigh

nonmatching CopSpeak_gStaticHandle

dlabel CopSpeak_gStaticHandle
    /* 12D8F0 8013D0F0 00000000 */ .word 0x00000000
    /* 12D8F4 8013D0F4 00000000 */ .word 0x00000000
enddlabel CopSpeak_gStaticHandle

nonmatching CopSpeak_gStaticPatch

dlabel CopSpeak_gStaticPatch
    /* 12D8F8 8013D0F8 00000000 */ .word 0x00000000
enddlabel CopSpeak_gStaticPatch
