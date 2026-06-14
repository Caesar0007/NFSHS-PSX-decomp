.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei, 0x1D8

glabel Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei
    /* 97238 800A6A38 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* 9723C 800A6A3C 7400B1AF */  sw         $s1, 0x74($sp)
    /* 97240 800A6A40 21888000 */  addu       $s1, $a0, $zero
    /* 97244 800A6A44 7800B2AF */  sw         $s2, 0x78($sp)
    /* 97248 800A6A48 2190A000 */  addu       $s2, $a1, $zero
    /* 9724C 800A6A4C 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 97250 800A6A50 2198C000 */  addu       $s3, $a2, $zero
    /* 97254 800A6A54 8000B4AF */  sw         $s4, 0x80($sp)
    /* 97258 800A6A58 21A0E000 */  addu       $s4, $a3, $zero
    /* 9725C 800A6A5C 21280000 */  addu       $a1, $zero, $zero
    /* 97260 800A6A60 7000B0AF */  sw         $s0, 0x70($sp)
    /* 97264 800A6A64 4800B027 */  addiu      $s0, $sp, 0x48
    /* 97268 800A6A68 21300002 */  addu       $a2, $s0, $zero
    /* 9726C 800A6A6C 8400BFAF */  sw         $ra, 0x84($sp)
    /* 97270 800A6A70 2800248E */  lw         $a0, 0x28($s1)
    /* 97274 800A6A74 89D1010C */  jal        GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 97278 800A6A78 2000A727 */   addiu     $a3, $sp, 0x20
    /* 9727C 800A6A7C 01004224 */  addiu      $v0, $v0, 0x1
    /* 97280 800A6A80 0200422C */  sltiu      $v0, $v0, 0x2
    /* 97284 800A6A84 20004010 */  beqz       $v0, .L800A6B08
    /* 97288 800A6A88 21280000 */   addu      $a1, $zero, $zero
    /* 9728C 800A6A8C 1000228E */  lw         $v0, 0x10($s1)
    /* 97290 800A6A90 2C00308E */  lw         $s0, 0x2C($s1)
    /* 97294 800A6A94 0E004384 */  lh         $v1, 0xE($v0)
    /* 97298 800A6A98 1180023C */  lui        $v0, %hi(gSimObjAnims)
    /* 9729C 800A6A9C 605D4224 */  addiu      $v0, $v0, %lo(gSimObjAnims)
    /* 972A0 800A6AA0 2C0020AE */  sw         $zero, 0x2C($s1)
    /* 972A4 800A6AA4 80180300 */  sll        $v1, $v1, 2
    /* 972A8 800A6AA8 21886200 */  addu       $s1, $v1, $v0
    /* 972AC 800A6AAC 0000238E */  lw         $v1, 0x0($s1)
    /* 972B0 800A6AB0 00000000 */  nop
    /* 972B4 800A6AB4 08006010 */  beqz       $v1, .L800A6AD8
    /* 972B8 800A6AB8 03000524 */   addiu     $a1, $zero, 0x3
    /* 972BC 800A6ABC 0000628C */  lw         $v0, 0x0($v1)
    /* 972C0 800A6AC0 00000000 */  nop
    /* 972C4 800A6AC4 08004484 */  lh         $a0, 0x8($v0)
    /* 972C8 800A6AC8 0C00428C */  lw         $v0, 0xC($v0)
    /* 972CC 800A6ACC 00000000 */  nop
    /* 972D0 800A6AD0 09F84000 */  jalr       $v0
    /* 972D4 800A6AD4 21206400 */   addu      $a0, $v1, $a0
  .L800A6AD8:
    /* 972D8 800A6AD8 21284002 */  addu       $a1, $s2, $zero
    /* 972DC 800A6ADC 21306002 */  addu       $a2, $s3, $zero
    /* 972E0 800A6AE0 000030AE */  sw         $s0, 0x0($s1)
    /* 972E4 800A6AE4 0000028E */  lw         $v0, 0x0($s0)
    /* 972E8 800A6AE8 21388002 */  addu       $a3, $s4, $zero
    /* 972EC 800A6AEC 10004484 */  lh         $a0, 0x10($v0)
    /* 972F0 800A6AF0 1400428C */  lw         $v0, 0x14($v0)
    /* 972F4 800A6AF4 00000000 */  nop
    /* 972F8 800A6AF8 09F84000 */  jalr       $v0
    /* 972FC 800A6AFC 21200402 */   addu      $a0, $s0, $a0
    /* 97300 800A6B00 FC9A0208 */  j          .L800A6BF0
    /* 97304 800A6B04 00000000 */   nop
  .L800A6B08:
    /* 97308 800A6B08 21300002 */  addu       $a2, $s0, $zero
    /* 9730C 800A6B0C 2800248E */  lw         $a0, 0x28($s1)
    /* 97310 800A6B10 1800308E */  lw         $s0, 0x18($s1)
    /* 97314 800A6B14 89D1010C */  jal        GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 97318 800A6B18 2000A727 */   addiu     $a3, $sp, 0x20
    /* 9731C 800A6B1C 6800A527 */  addiu      $a1, $sp, 0x68
    /* 97320 800A6B20 2800248E */  lw         $a0, 0x28($s1)
    /* 97324 800A6B24 4FD1010C */  jal        GetAnimFrameInfo__10AnimScriptPiT1
    /* 97328 800A6B28 6C00A627 */   addiu     $a2, $sp, 0x6C
    /* 9732C 800A6B2C 6800A48F */  lw         $a0, 0x68($sp)
    /* 97330 800A6B30 6C00A28F */  lw         $v0, 0x6C($sp)
    /* 97334 800A6B34 00240400 */  sll        $a0, $a0, 16
    /* 97338 800A6B38 1A008200 */  div        $zero, $a0, $v0
    /* 9733C 800A6B3C 02004014 */  bnez       $v0, .L800A6B48
    /* 97340 800A6B40 00000000 */   nop
    /* 97344 800A6B44 0D000700 */  break      7
  .L800A6B48:
    /* 97348 800A6B48 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9734C 800A6B4C 04004114 */  bne        $v0, $at, .L800A6B60
    /* 97350 800A6B50 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 97354 800A6B54 02008114 */  bne        $a0, $at, .L800A6B60
    /* 97358 800A6B58 00000000 */   nop
    /* 9735C 800A6B5C 0D000600 */  break      6
  .L800A6B60:
    /* 97360 800A6B60 12200000 */  mflo       $a0
    /* 97364 800A6B64 1400228E */  lw         $v0, 0x14($s1)
    /* 97368 800A6B68 00000000 */  nop
    /* 9736C 800A6B6C 0800488C */  lw         $t0, 0x8($v0)
    /* 97370 800A6B70 0C00498C */  lw         $t1, 0xC($v0)
    /* 97374 800A6B74 10004A8C */  lw         $t2, 0x10($v0)
    /* 97378 800A6B78 5800A8AF */  sw         $t0, 0x58($sp)
    /* 9737C 800A6B7C 5C00A9AF */  sw         $t1, 0x5C($sp)
    /* 97380 800A6B80 6000AAAF */  sw         $t2, 0x60($sp)
    /* 97384 800A6B84 5800A28F */  lw         $v0, 0x58($sp)
    /* 97388 800A6B88 4800A38F */  lw         $v1, 0x48($sp)
    /* 9738C 800A6B8C 4C00A58F */  lw         $a1, 0x4C($sp)
    /* 97390 800A6B90 5000A68F */  lw         $a2, 0x50($sp)
    /* 97394 800A6B94 21104300 */  addu       $v0, $v0, $v1
    /* 97398 800A6B98 5800A2AF */  sw         $v0, 0x58($sp)
    /* 9739C 800A6B9C 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 973A0 800A6BA0 6000A38F */  lw         $v1, 0x60($sp)
    /* 973A4 800A6BA4 21104500 */  addu       $v0, $v0, $a1
    /* 973A8 800A6BA8 21186600 */  addu       $v1, $v1, $a2
    /* 973AC 800A6BAC 5C00A2AF */  sw         $v0, 0x5C($sp)
    /* 973B0 800A6BB0 6000A3AF */  sw         $v1, 0x60($sp)
    /* 973B4 800A6BB4 2000258E */  lw         $a1, 0x20($s1)
    /* 973B8 800A6BB8 2400268E */  lw         $a2, 0x24($s1)
    /* 973BC 800A6BBC FA92020C */  jal        BuildObjCollisionMatrix__FiiiP10matrixtdef
    /* 973C0 800A6BC0 2000A727 */   addiu     $a3, $sp, 0x20
    /* 973C4 800A6BC4 21204002 */  addu       $a0, $s2, $zero
    /* 973C8 800A6BC8 21286002 */  addu       $a1, $s3, $zero
    /* 973CC 800A6BCC 2000A627 */  addiu      $a2, $sp, 0x20
    /* 973D0 800A6BD0 21380002 */  addu       $a3, $s0, $zero
    /* 973D4 800A6BD4 5800A227 */  addiu      $v0, $sp, 0x58
    /* 973D8 800A6BD8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 973DC 800A6BDC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 973E0 800A6BE0 1400B4AF */  sw         $s4, 0x14($sp)
    /* 973E4 800A6BE4 AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* 973E8 800A6BE8 1800A2AF */   sw        $v0, 0x18($sp)
    /* 973EC 800A6BEC 04000224 */  addiu      $v0, $zero, 0x4
  .L800A6BF0:
    /* 973F0 800A6BF0 8400BF8F */  lw         $ra, 0x84($sp)
    /* 973F4 800A6BF4 8000B48F */  lw         $s4, 0x80($sp)
    /* 973F8 800A6BF8 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 973FC 800A6BFC 7800B28F */  lw         $s2, 0x78($sp)
    /* 97400 800A6C00 7400B18F */  lw         $s1, 0x74($sp)
    /* 97404 800A6C04 7000B08F */  lw         $s0, 0x70($sp)
    /* 97408 800A6C08 0800E003 */  jr         $ra
    /* 9740C 800A6C0C 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei
