.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_SplineDistance__FP8Car_tObjT0, 0x58

glabel AIWorld_SplineDistance__FP8Car_tObjT0
    /* 63A24 80073224 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 63A28 80073228 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63A2C 8007322C 21808000 */  addu       $s0, $a0, $zero
    /* 63A30 80073230 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63A34 80073234 1800BFAF */  sw         $ra, 0x18($sp)
    /* 63A38 80073238 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 63A3C 8007323C 2188A000 */   addu      $s1, $a1, $zero
    /* 63A40 80073240 21204000 */  addu       $a0, $v0, $zero
    /* 63A44 80073244 0C00033C */  lui        $v1, (0xC0000 >> 16)
    /* 63A48 80073248 21188300 */  addu       $v1, $a0, $v1
    /* 63A4C 8007324C 1800023C */  lui        $v0, (0x180000 >> 16)
    /* 63A50 80073250 2B104300 */  sltu       $v0, $v0, $v1
    /* 63A54 80073254 04004014 */  bnez       $v0, .L80073268
    /* 63A58 80073258 21108000 */   addu      $v0, $a0, $zero
    /* 63A5C 8007325C 21200002 */  addu       $a0, $s0, $zero
    /* 63A60 80073260 E4CB010C */  jal        AIWorld_ZSplineDistance__FP8Car_tObjT0
    /* 63A64 80073264 21282002 */   addu      $a1, $s1, $zero
  .L80073268:
    /* 63A68 80073268 1800BF8F */  lw         $ra, 0x18($sp)
    /* 63A6C 8007326C 1400B18F */  lw         $s1, 0x14($sp)
    /* 63A70 80073270 1000B08F */  lw         $s0, 0x10($sp)
    /* 63A74 80073274 0800E003 */  jr         $ra
    /* 63A78 80073278 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIWorld_SplineDistance__FP8Car_tObjT0
