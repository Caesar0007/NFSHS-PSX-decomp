.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR, 0x2C

glabel DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
    /* B63B4 800C5BB4 0000A28C */  lw         $v0, 0x0($a1)
    /* B63B8 800C5BB8 0400A38C */  lw         $v1, 0x4($a1)
    /* B63BC 800C5BBC 0800A58C */  lw         $a1, 0x8($a1)
    /* B63C0 800C5BC0 80100200 */  sll        $v0, $v0, 2
    /* B63C4 800C5BC4 801C0300 */  sll        $v1, $v1, 18
    /* B63C8 800C5BC8 80280500 */  sll        $a1, $a1, 2
    /* B63CC 800C5BCC FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* B63D0 800C5BD0 25186200 */  or         $v1, $v1, $v0
    /* B63D4 800C5BD4 000083AC */  sw         $v1, 0x0($a0)
    /* B63D8 800C5BD8 0800E003 */  jr         $ra
    /* B63DC 800C5BDC 040085A4 */   sh        $a1, 0x4($a0)
endlabel DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
