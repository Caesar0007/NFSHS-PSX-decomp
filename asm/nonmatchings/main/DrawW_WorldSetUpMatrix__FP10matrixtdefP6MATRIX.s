.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX, 0x9C

glabel DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* B7D3C 800C753C 0000828C */  lw         $v0, 0x0($a0)
    /* B7D40 800C7540 0C00838C */  lw         $v1, 0xC($a0)
    /* B7D44 800C7544 1800868C */  lw         $a2, 0x18($a0)
    /* B7D48 800C7548 03110200 */  sra        $v0, $v0, 4
    /* B7D4C 800C754C 03190300 */  sra        $v1, $v1, 4
    /* B7D50 800C7550 03310600 */  sra        $a2, $a2, 4
    /* B7D54 800C7554 0000A2A4 */  sh         $v0, 0x0($a1)
    /* B7D58 800C7558 0200A3A4 */  sh         $v1, 0x2($a1)
    /* B7D5C 800C755C 0400A6A4 */  sh         $a2, 0x4($a1)
    /* B7D60 800C7560 0400828C */  lw         $v0, 0x4($a0)
    /* B7D64 800C7564 1000838C */  lw         $v1, 0x10($a0)
    /* B7D68 800C7568 1C00868C */  lw         $a2, 0x1C($a0)
    /* B7D6C 800C756C 03110200 */  sra        $v0, $v0, 4
    /* B7D70 800C7570 03190300 */  sra        $v1, $v1, 4
    /* B7D74 800C7574 03310600 */  sra        $a2, $a2, 4
    /* B7D78 800C7578 0600A2A4 */  sh         $v0, 0x6($a1)
    /* B7D7C 800C757C 0800A3A4 */  sh         $v1, 0x8($a1)
    /* B7D80 800C7580 0A00A6A4 */  sh         $a2, 0xA($a1)
    /* B7D84 800C7584 0800828C */  lw         $v0, 0x8($a0)
    /* B7D88 800C7588 1400838C */  lw         $v1, 0x14($a0)
    /* B7D8C 800C758C 2000848C */  lw         $a0, 0x20($a0)
    /* B7D90 800C7590 03110200 */  sra        $v0, $v0, 4
    /* B7D94 800C7594 03190300 */  sra        $v1, $v1, 4
    /* B7D98 800C7598 03210400 */  sra        $a0, $a0, 4
    /* B7D9C 800C759C 0C00A2A4 */  sh         $v0, 0xC($a1)
    /* B7DA0 800C75A0 0E00A3A4 */  sh         $v1, 0xE($a1)
    /* B7DA4 800C75A4 1000A4A4 */  sh         $a0, 0x10($a1)
    /* B7DA8 800C75A8 0000AC8C */  lw         $t4, 0x0($a1)
    /* B7DAC 800C75AC 0400AD8C */  lw         $t5, 0x4($a1)
    /* B7DB0 800C75B0 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B7DB4 800C75B4 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B7DB8 800C75B8 0800AC8C */  lw         $t4, 0x8($a1)
    /* B7DBC 800C75BC 0C00AD8C */  lw         $t5, 0xC($a1)
    /* B7DC0 800C75C0 1000AE8C */  lw         $t6, 0x10($a1)
    /* B7DC4 800C75C4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B7DC8 800C75C8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B7DCC 800C75CC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B7DD0 800C75D0 0800E003 */  jr         $ra
    /* B7DD4 800C75D4 00000000 */   nop
endlabel DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
