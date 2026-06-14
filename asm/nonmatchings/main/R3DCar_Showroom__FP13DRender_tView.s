.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_Showroom__FP13DRender_tView, 0x50

glabel R3DCar_Showroom__FP13DRender_tView
    /* A3388 800B2B88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A338C 800B2B8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* A3390 800B2B90 21808000 */  addu       $s0, $a0, $zero
    /* A3394 800B2B94 1400B1AF */  sw         $s1, 0x14($sp)
    /* A3398 800B2B98 44001126 */  addiu      $s1, $s0, 0x44
    /* A339C 800B2B9C 21202002 */  addu       $a0, $s1, $zero
    /* A33A0 800B2BA0 38001026 */  addiu      $s0, $s0, 0x38
    /* A33A4 800B2BA4 21280002 */  addu       $a1, $s0, $zero
    /* A33A8 800B2BA8 1800BFAF */  sw         $ra, 0x18($sp)
    /* A33AC 800B2BAC E112030C */  jal        DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
    /* A33B0 800B2BB0 801F063C */   lui       $a2, (0x1F800000 >> 16)
    /* A33B4 800B2BB4 21202002 */  addu       $a0, $s1, $zero
    /* A33B8 800B2BB8 21280002 */  addu       $a1, $s0, $zero
    /* A33BC 800B2BBC 0012030C */  jal        DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
    /* A33C0 800B2BC0 801F063C */   lui       $a2, (0x1F800000 >> 16)
    /* A33C4 800B2BC4 1800BF8F */  lw         $ra, 0x18($sp)
    /* A33C8 800B2BC8 1400B18F */  lw         $s1, 0x14($sp)
    /* A33CC 800B2BCC 1000B08F */  lw         $s0, 0x10($sp)
    /* A33D0 800B2BD0 0800E003 */  jr         $ra
    /* A33D4 800B2BD4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_Showroom__FP13DRender_tView
