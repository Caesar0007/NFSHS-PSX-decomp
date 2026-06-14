.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_SetCamera__FP13DRender_tView, 0x38

glabel Camera_SetCamera__FP13DRender_tView
    /* 70F04 80080704 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 70F08 80080708 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70F0C 8008070C 21808000 */  addu       $s0, $a0, $zero
    /* 70F10 80080710 1400BFAF */  sw         $ra, 0x14($sp)
    /* 70F14 80080714 0400048E */  lw         $a0, 0x4($s0)
    /* 70F18 80080718 0000068E */  lw         $a2, 0x0($s0)
    /* 70F1C 8008071C 0214020C */  jal        Camera_GetViewInfo__FiP17DRender_tCalcViewi
    /* 70F20 80080720 08000526 */   addiu     $a1, $s0, 0x8
    /* 70F24 80080724 8286030C */  jal        TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
    /* 70F28 80080728 21200002 */   addu      $a0, $s0, $zero
    /* 70F2C 8008072C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 70F30 80080730 1000B08F */  lw         $s0, 0x10($sp)
    /* 70F34 80080734 0800E003 */  jr         $ra
    /* 70F38 80080738 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Camera_SetCamera__FP13DRender_tView
