.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_InitRenderEngine__Fiiiiii, 0xA4

glabel Draw_InitRenderEngine__Fiiiiii
    /* AEDD8 800BE5D8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AEDDC 800BE5DC 21108000 */  addu       $v0, $a0, $zero
    /* AEDE0 800BE5E0 2118A000 */  addu       $v1, $a1, $zero
    /* AEDE4 800BE5E4 2400B3AF */  sw         $s3, 0x24($sp)
    /* AEDE8 800BE5E8 2198C000 */  addu       $s3, $a2, $zero
    /* AEDEC 800BE5EC 2800B4AF */  sw         $s4, 0x28($sp)
    /* AEDF0 800BE5F0 21A0E000 */  addu       $s4, $a3, $zero
    /* AEDF4 800BE5F4 1800B0AF */  sw         $s0, 0x18($sp)
    /* AEDF8 800BE5F8 1280103C */  lui        $s0, %hi(gEnviro)
    /* AEDFC 800BE5FC 24F41026 */  addiu      $s0, $s0, %lo(gEnviro)
    /* AEE00 800BE600 21200002 */  addu       $a0, $s0, $zero
    /* AEE04 800BE604 21284000 */  addu       $a1, $v0, $zero
    /* AEE08 800BE608 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* AEE0C 800BE60C 4000B18F */  lw         $s1, 0x40($sp)
    /* AEE10 800BE610 21306000 */  addu       $a2, $v1, $zero
    /* AEE14 800BE614 2000B2AF */  sw         $s2, 0x20($sp)
    /* AEE18 800BE618 4400B28F */  lw         $s2, 0x44($sp)
    /* AEE1C 800BE61C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AEE20 800BE620 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* AEE24 800BE624 681282AF */  sw         $v0, %gp_rel(gFlip)($gp)
    /* AEE28 800BE628 140000AE */  sw         $zero, 0x14($s0)
    /* AEE2C 800BE62C 2C0000AE */  sw         $zero, 0x2C($s0)
    /* AEE30 800BE630 21382002 */  addu       $a3, $s1, $zero
    /* AEE34 800BE634 B8C8030C */  jal        SetDefDispEnv
    /* AEE38 800BE638 1000B2AF */   sw        $s2, 0x10($sp)
    /* AEE3C 800BE63C 18000426 */  addiu      $a0, $s0, 0x18
    /* AEE40 800BE640 21286002 */  addu       $a1, $s3, $zero
    /* AEE44 800BE644 21308002 */  addu       $a2, $s4, $zero
    /* AEE48 800BE648 21382002 */  addu       $a3, $s1, $zero
    /* AEE4C 800BE64C B8C8030C */  jal        SetDefDispEnv
    /* AEE50 800BE650 1000B2AF */   sw        $s2, 0x10($sp)
    /* AEE54 800BE654 D8F8020C */  jal        Draw_SetDrawSyncCallback__FPFv_v
    /* AEE58 800BE658 21200000 */   addu      $a0, $zero, $zero
    /* AEE5C 800BE65C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* AEE60 800BE660 2800B48F */  lw         $s4, 0x28($sp)
    /* AEE64 800BE664 2400B38F */  lw         $s3, 0x24($sp)
    /* AEE68 800BE668 2000B28F */  lw         $s2, 0x20($sp)
    /* AEE6C 800BE66C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* AEE70 800BE670 1800B08F */  lw         $s0, 0x18($sp)
    /* AEE74 800BE674 0800E003 */  jr         $ra
    /* AEE78 800BE678 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw_InitRenderEngine__Fiiiiii
