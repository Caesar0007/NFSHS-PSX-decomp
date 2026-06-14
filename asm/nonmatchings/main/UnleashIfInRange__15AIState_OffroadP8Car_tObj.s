.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UnleashIfInRange__15AIState_OffroadP8Car_tObj, 0x78

glabel UnleashIfInRange__15AIState_OffroadP8Car_tObj
    /* 61A68 80071268 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 61A6C 8007126C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 61A70 80071270 21888000 */  addu       $s1, $a0, $zero
    /* 61A74 80071274 1000B0AF */  sw         $s0, 0x10($sp)
    /* 61A78 80071278 1800BFAF */  sw         $ra, 0x18($sp)
    /* 61A7C 8007127C 0000248E */  lw         $a0, 0x0($s1)
    /* 61A80 80071280 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 61A84 80071284 2180A000 */   addu      $s0, $a1, $zero
    /* 61A88 80071288 C000048E */  lw         $a0, 0xC0($s0)
    /* 61A8C 8007128C 6400258E */  lw         $a1, 0x64($s1)
    /* 61A90 80071290 02004104 */  bgez       $v0, .L8007129C
    /* 61A94 80071294 21804000 */   addu      $s0, $v0, $zero
    /* 61A98 80071298 23801000 */  negu       $s0, $s0
  .L8007129C:
    /* 61A9C 8007129C CA90030C */  jal        fixedmult
    /* 61AA0 800712A0 00000000 */   nop
    /* 61AA4 800712A4 21184000 */  addu       $v1, $v0, $zero
    /* 61AA8 800712A8 1400023C */  lui        $v0, (0x140000 >> 16)
    /* 61AAC 800712AC 2A106200 */  slt        $v0, $v1, $v0
    /* 61AB0 800712B0 03004010 */  beqz       $v0, .L800712C0
    /* 61AB4 800712B4 2A100302 */   slt       $v0, $s0, $v1
    /* 61AB8 800712B8 1400033C */  lui        $v1, (0x140000 >> 16)
    /* 61ABC 800712BC 2A100302 */  slt        $v0, $s0, $v1
  .L800712C0:
    /* 61AC0 800712C0 02004010 */  beqz       $v0, .L800712CC
    /* 61AC4 800712C4 01000224 */   addiu     $v0, $zero, 0x1
    /* 61AC8 800712C8 5C0022AE */  sw         $v0, 0x5C($s1)
  .L800712CC:
    /* 61ACC 800712CC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 61AD0 800712D0 1400B18F */  lw         $s1, 0x14($sp)
    /* 61AD4 800712D4 1000B08F */  lw         $s0, 0x10($sp)
    /* 61AD8 800712D8 0800E003 */  jr         $ra
    /* 61ADC 800712DC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UnleashIfInRange__15AIState_OffroadP8Car_tObj
