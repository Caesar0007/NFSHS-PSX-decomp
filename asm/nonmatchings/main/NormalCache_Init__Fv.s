.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NormalCache_Init__Fv, 0x3C

glabel NormalCache_Init__Fv
    /* 709AC 800801AC 8C0280AF */  sw         $zero, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 709B0 800801B0 21200000 */  addu       $a0, $zero, $zero
    /* 709B4 800801B4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 709B8 800801B8 1180023C */  lui        $v0, %hi(BWSM_NormalCache)
    /* 709BC 800801BC ACF04324 */  addiu      $v1, $v0, %lo(BWSM_NormalCache)
  .L800801C0:
    /* 709C0 800801C0 000065A4 */  sh         $a1, 0x0($v1)
    /* 709C4 800801C4 030065A0 */  sb         $a1, 0x3($v1)
    /* 709C8 800801C8 020060A0 */  sb         $zero, 0x2($v1)
    /* 709CC 800801CC 1C0060AC */  sw         $zero, 0x1C($v1)
    /* 709D0 800801D0 01008424 */  addiu      $a0, $a0, 0x1
    /* 709D4 800801D4 10008228 */  slti       $v0, $a0, 0x10
    /* 709D8 800801D8 F9FF4014 */  bnez       $v0, .L800801C0
    /* 709DC 800801DC 20006324 */   addiu     $v1, $v1, 0x20
    /* 709E0 800801E0 0800E003 */  jr         $ra
    /* 709E4 800801E4 00000000 */   nop
endlabel NormalCache_Init__Fv
