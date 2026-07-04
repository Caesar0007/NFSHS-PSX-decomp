.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX, 0x44

glabel DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B7DD8 800C75D8 0000828C */  lw         $v0, 0x0($a0)
    /* B7DDC 800C75DC 0400838C */  lw         $v1, 0x4($a0)
    /* B7DE0 800C75E0 0800848C */  lw         $a0, 0x8($a0)
    /* B7DE4 800C75E4 83120200 */  sra        $v0, $v0, 10
    /* B7DE8 800C75E8 831A0300 */  sra        $v1, $v1, 10
    /* B7DEC 800C75EC 83220400 */  sra        $a0, $a0, 10
    /* B7DF0 800C75F0 1400A2AC */  sw         $v0, 0x14($a1)
    /* B7DF4 800C75F4 1800A3AC */  sw         $v1, 0x18($a1)
    /* B7DF8 800C75F8 1C00A4AC */  sw         $a0, 0x1C($a1)
    /* B7DFC 800C75FC 1400AC8C */  lw         $t4, 0x14($a1)
    /* B7E00 800C7600 1800AD8C */  lw         $t5, 0x18($a1)
    /* B7E04 800C7604 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B7E08 800C7608 1C00AE8C */  lw         $t6, 0x1C($a1)
    /* B7E0C 800C760C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B7E10 800C7610 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B7E14 800C7614 0800E003 */  jr         $ra
    /* B7E18 800C7618 00000000 */   nop
endlabel DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
