.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_SplineDistance__FP8Car_tObjiP8coorddef, 0x5C

glabel AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
    /* 63A7C 8007327C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 63A80 80073280 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63A84 80073284 21808000 */  addu       $s0, $a0, $zero
    /* 63A88 80073288 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63A8C 8007328C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 63A90 80073290 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 63A94 80073294 2188C000 */   addu      $s1, $a2, $zero
    /* 63A98 80073298 21204000 */  addu       $a0, $v0, $zero
    /* 63A9C 8007329C 0C00033C */  lui        $v1, (0xC0000 >> 16)
    /* 63AA0 800732A0 21188300 */  addu       $v1, $a0, $v1
    /* 63AA4 800732A4 1800023C */  lui        $v0, (0x180000 >> 16)
    /* 63AA8 800732A8 2B104300 */  sltu       $v0, $v0, $v1
    /* 63AAC 800732AC 05004014 */  bnez       $v0, .L800732C4
    /* 63AB0 800732B0 21108000 */   addu      $v0, $a0, $zero
    /* 63AB4 800732B4 A0000426 */  addiu      $a0, $s0, 0xA0
    /* 63AB8 800732B8 21282002 */  addu       $a1, $s1, $zero
    /* 63ABC 800732BC 09CC010C */  jal        AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
    /* 63AC0 800732C0 44010626 */   addiu     $a2, $s0, 0x144
  .L800732C4:
    /* 63AC4 800732C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 63AC8 800732C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 63ACC 800732CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 63AD0 800732D0 0800E003 */  jr         $ra
    /* 63AD4 800732D4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
