.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching mdec, 0x118

glabel mdec
    /* 412EC 80050AEC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 412F0 80050AF0 0580023C */  lui        $v0, %hi(gMDECinfo)
    /* 412F4 80050AF4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 412F8 80050AF8 282B5324 */  addiu      $s3, $v0, %lo(gMDECinfo)
    /* 412FC 80050AFC 1480023C */  lui        $v0, %hi(ticks)
    /* 41300 80050B00 1800B2AF */  sw         $s2, 0x18($sp)
    /* 41304 80050B04 21904000 */  addu       $s2, $v0, $zero
    /* 41308 80050B08 1480023C */  lui        $v0, %hi(timerhz)
    /* 4130C 80050B0C C4DC428C */  lw         $v0, %lo(timerhz)($v0)
    /* 41310 80050B10 ACDC438E */  lw         $v1, %lo(ticks)($s2)
    /* 41314 80050B14 2000B4AF */  sw         $s4, 0x20($sp)
    /* 41318 80050B18 21A08000 */  addu       $s4, $a0, $zero
    /* 4131C 80050B1C 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 41320 80050B20 21B8A000 */  addu       $s7, $a1, $zero
    /* 41324 80050B24 2400B5AF */  sw         $s5, 0x24($sp)
    /* 41328 80050B28 21A8C000 */  addu       $s5, $a2, $zero
    /* 4132C 80050B2C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 41330 80050B30 21B0E000 */  addu       $s6, $a3, $zero
    /* 41334 80050B34 1000B0AF */  sw         $s0, 0x10($sp)
    /* 41338 80050B38 21808002 */  addu       $s0, $s4, $zero
    /* 4133C 80050B3C 3000BFAF */  sw         $ra, 0x30($sp)
    /* 41340 80050B40 1400B1AF */  sw         $s1, 0x14($sp)
    /* 41344 80050B44 80100200 */  sll        $v0, $v0, 2
    /* 41348 80050B48 21886200 */  addu       $s1, $v1, $v0
  .L80050B4C:
    /* 4134C 80050B4C 0400628E */  lw         $v0, 0x4($s3)
    /* 41350 80050B50 00000000 */  nop
    /* 41354 80050B54 0C004010 */  beqz       $v0, .L80050B88
    /* 41358 80050B58 00000000 */   nop
    /* 4135C 80050B5C 019B030C */  jal        systemtask
    /* 41360 80050B60 21200000 */   addu      $a0, $zero, $zero
    /* 41364 80050B64 ACDC428E */  lw         $v0, %lo(ticks)($s2)
    /* 41368 80050B68 00000000 */  nop
    /* 4136C 80050B6C 2A102202 */  slt        $v0, $s1, $v0
    /* 41370 80050B70 F6FF4010 */  beqz       $v0, .L80050B4C
    /* 41374 80050B74 00000000 */   nop
    /* 41378 80050B78 AA42010C */  jal        mdecreset__Fv
    /* 4137C 80050B7C 00000000 */   nop
    /* 41380 80050B80 D3420108 */  j          .L80050B4C
    /* 41384 80050B84 00000000 */   nop
  .L80050B88:
    /* 41388 80050B88 040074AE */  sw         $s4, 0x4($s3)
    /* 4138C 80050B8C 2800058E */  lw         $a1, 0x28($s0)
    /* 41390 80050B90 0CDD030C */  jal        DecDCTvlc
    /* 41394 80050B94 0800E426 */   addiu     $a0, $s7, 0x8
    /* 41398 80050B98 02000524 */  addiu      $a1, $zero, 0x2
    /* 4139C 80050B9C 0C00038E */  lw         $v1, 0xC($s0)
    /* 413A0 80050BA0 18000224 */  addiu      $v0, $zero, 0x18
    /* 413A4 80050BA4 180015A6 */  sh         $s5, 0x18($s0)
    /* 413A8 80050BA8 100015A6 */  sh         $s5, 0x10($s0)
    /* 413AC 80050BAC 1A0016A6 */  sh         $s6, 0x1A($s0)
    /* 413B0 80050BB0 02006214 */  bne        $v1, $v0, .L80050BBC
    /* 413B4 80050BB4 120016A6 */   sh        $s6, 0x12($s0)
    /* 413B8 80050BB8 03000524 */  addiu      $a1, $zero, 0x3
  .L80050BBC:
    /* 413BC 80050BBC 2800048E */  lw         $a0, 0x28($s0)
    /* 413C0 80050BC0 7FE2030C */  jal        DecDCTin
    /* 413C4 80050BC4 00000000 */   nop
    /* 413C8 80050BC8 2400048E */  lw         $a0, 0x24($s0)
    /* 413CC 80050BCC 2000058E */  lw         $a1, 0x20($s0)
    /* 413D0 80050BD0 9EE2030C */  jal        DecDCTout
    /* 413D4 80050BD4 00000000 */   nop
    /* 413D8 80050BD8 3000BF8F */  lw         $ra, 0x30($sp)
    /* 413DC 80050BDC 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 413E0 80050BE0 2800B68F */  lw         $s6, 0x28($sp)
    /* 413E4 80050BE4 2400B58F */  lw         $s5, 0x24($sp)
    /* 413E8 80050BE8 2000B48F */  lw         $s4, 0x20($sp)
    /* 413EC 80050BEC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 413F0 80050BF0 1800B28F */  lw         $s2, 0x18($sp)
    /* 413F4 80050BF4 1400B18F */  lw         $s1, 0x14($sp)
    /* 413F8 80050BF8 1000B08F */  lw         $s0, 0x10($sp)
    /* 413FC 80050BFC 0800E003 */  jr         $ra
    /* 41400 80050C00 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel mdec
