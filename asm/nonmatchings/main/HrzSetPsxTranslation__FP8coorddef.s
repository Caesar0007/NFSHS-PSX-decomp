.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HrzSetPsxTranslation__FP8coorddef, 0x50

glabel HrzSetPsxTranslation__FP8coorddef
    /* C111C 800D091C 0000828C */  lw         $v0, 0x0($a0)
    /* C1120 800D0920 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C1124 800D0924 83120200 */  sra        $v0, $v0, 10
    /* C1128 800D0928 1400A2AF */  sw         $v0, 0x14($sp)
    /* C112C 800D092C 0400828C */  lw         $v0, 0x4($a0)
    /* C1130 800D0930 00000000 */  nop
    /* C1134 800D0934 83120200 */  sra        $v0, $v0, 10
    /* C1138 800D0938 1800A2AF */  sw         $v0, 0x18($sp)
    /* C113C 800D093C 0800828C */  lw         $v0, 0x8($a0)
    /* C1140 800D0940 00000000 */  nop
    /* C1144 800D0944 83120200 */  sra        $v0, $v0, 10
    /* C1148 800D0948 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* C114C 800D094C 1400AC8F */  lw         $t4, 0x14($sp)
    /* C1150 800D0950 1800AD8F */  lw         $t5, 0x18($sp)
    /* C1154 800D0954 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* C1158 800D0958 1C00AE8F */  lw         $t6, 0x1C($sp)
    /* C115C 800D095C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* C1160 800D0960 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* C1164 800D0964 0800E003 */  jr         $ra
    /* C1168 800D0968 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel HrzSetPsxTranslation__FP8coorddef
