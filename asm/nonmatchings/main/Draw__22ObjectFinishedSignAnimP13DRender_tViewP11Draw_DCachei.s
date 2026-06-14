.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei, 0x48

glabel Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei
    /* 96F1C 800A671C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 96F20 800A6720 21408000 */  addu       $t0, $a0, $zero
    /* 96F24 800A6724 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 96F28 800A6728 2120A000 */  addu       $a0, $a1, $zero
    /* 96F2C 800A672C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 96F30 800A6730 2C00038D */  lw         $v1, 0x2C($t0)
    /* 96F34 800A6734 2128C000 */  addu       $a1, $a2, $zero
    /* 96F38 800A6738 1400A7AF */  sw         $a3, 0x14($sp)
    /* 96F3C 800A673C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 96F40 800A6740 08006324 */  addiu      $v1, $v1, 0x8
    /* 96F44 800A6744 1000A3AF */  sw         $v1, 0x10($sp)
    /* 96F48 800A6748 2800078D */  lw         $a3, 0x28($t0)
    /* 96F4C 800A674C AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* 96F50 800A6750 04000625 */   addiu     $a2, $t0, 0x4
    /* 96F54 800A6754 2000BF8F */  lw         $ra, 0x20($sp)
    /* 96F58 800A6758 02000224 */  addiu      $v0, $zero, 0x2
    /* 96F5C 800A675C 0800E003 */  jr         $ra
    /* 96F60 800A6760 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei
