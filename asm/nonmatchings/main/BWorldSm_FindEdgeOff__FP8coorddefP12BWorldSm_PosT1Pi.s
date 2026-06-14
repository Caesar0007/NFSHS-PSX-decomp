.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi, 0x11C

glabel BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
    /* 70528 8007FD28 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 7052C 8007FD2C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 70530 8007FD30 21A88000 */  addu       $s5, $a0, $zero
    /* 70534 8007FD34 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 70538 8007FD38 2198A000 */  addu       $s3, $a1, $zero
    /* 7053C 8007FD3C 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 70540 8007FD40 21B8C000 */  addu       $s7, $a2, $zero
    /* 70544 8007FD44 3000BEAF */  sw         $fp, 0x30($sp)
    /* 70548 8007FD48 21F0E000 */  addu       $fp, $a3, $zero
    /* 7054C 8007FD4C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 70550 8007FD50 08007226 */  addiu      $s2, $s3, 0x8
    /* 70554 8007FD54 2800B6AF */  sw         $s6, 0x28($sp)
    /* 70558 8007FD58 20007626 */  addiu      $s6, $s3, 0x20
    /* 7055C 8007FD5C 2120C002 */  addu       $a0, $s6, $zero
    /* 70560 8007FD60 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70564 8007FD64 2C007026 */  addiu      $s0, $s3, 0x2C
    /* 70568 8007FD68 21280002 */  addu       $a1, $s0, $zero
    /* 7056C 8007FD6C 2130A002 */  addu       $a2, $s5, $zero
    /* 70570 8007FD70 3400BFAF */  sw         $ra, 0x34($sp)
    /* 70574 8007FD74 2000B4AF */  sw         $s4, 0x20($sp)
    /* 70578 8007FD78 2CFF010C */  jal        PointDirection__FP8coorddefN20
    /* 7057C 8007FD7C 1400B1AF */   sw        $s1, 0x14($sp)
    /* 70580 8007FD80 FEFF143C */  lui        $s4, (0xFFFE8000 >> 16)
    /* 70584 8007FD84 00809436 */  ori        $s4, $s4, (0xFFFE8000 & 0xFFFF)
    /* 70588 8007FD88 2A105400 */  slt        $v0, $v0, $s4
    /* 7058C 8007FD8C 01005138 */  xori       $s1, $v0, 0x1
    /* 70590 8007FD90 21200002 */  addu       $a0, $s0, $zero
    /* 70594 8007FD94 21284002 */  addu       $a1, $s2, $zero
    /* 70598 8007FD98 2CFF010C */  jal        PointDirection__FP8coorddefN20
    /* 7059C 8007FD9C 2130A002 */   addu      $a2, $s5, $zero
    /* 705A0 8007FDA0 02004004 */  bltz       $v0, .L8007FDAC
    /* 705A4 8007FDA4 21204002 */   addu      $a0, $s2, $zero
    /* 705A8 8007FDA8 08003136 */  ori        $s1, $s1, 0x8
  .L8007FDAC:
    /* 705AC 8007FDAC 14007026 */  addiu      $s0, $s3, 0x14
    /* 705B0 8007FDB0 21280002 */  addu       $a1, $s0, $zero
    /* 705B4 8007FDB4 2CFF010C */  jal        PointDirection__FP8coorddefN20
    /* 705B8 8007FDB8 2130A002 */   addu      $a2, $s5, $zero
    /* 705BC 8007FDBC 2A105400 */  slt        $v0, $v0, $s4
    /* 705C0 8007FDC0 02004014 */  bnez       $v0, .L8007FDCC
    /* 705C4 8007FDC4 21200002 */   addu      $a0, $s0, $zero
    /* 705C8 8007FDC8 02003136 */  ori        $s1, $s1, 0x2
  .L8007FDCC:
    /* 705CC 8007FDCC 2128C002 */  addu       $a1, $s6, $zero
    /* 705D0 8007FDD0 2CFF010C */  jal        PointDirection__FP8coorddefN20
    /* 705D4 8007FDD4 2130A002 */   addu      $a2, $s5, $zero
    /* 705D8 8007FDD8 02004004 */  bltz       $v0, .L8007FDE4
    /* 705DC 8007FDDC 0800F226 */   addiu     $s2, $s7, 0x8
    /* 705E0 8007FDE0 04003136 */  ori        $s1, $s1, 0x4
  .L8007FDE4:
    /* 705E4 8007FDE4 0400438E */  lw         $v1, 0x4($s2)
    /* 705E8 8007FDE8 1000448E */  lw         $a0, 0x10($s2)
    /* 705EC 8007FDEC 21102002 */  addu       $v0, $s1, $zero
    /* 705F0 8007FDF0 21186400 */  addu       $v1, $v1, $a0
    /* 705F4 8007FDF4 1C00448E */  lw         $a0, 0x1C($s2)
    /* 705F8 8007FDF8 2800458E */  lw         $a1, 0x28($s2)
    /* 705FC 8007FDFC 21186400 */  addu       $v1, $v1, $a0
    /* 70600 8007FE00 21186500 */  addu       $v1, $v1, $a1
    /* 70604 8007FE04 0400A48E */  lw         $a0, 0x4($s5)
    /* 70608 8007FE08 83180300 */  sra        $v1, $v1, 2
    /* 7060C 8007FE0C 23186400 */  subu       $v1, $v1, $a0
    /* 70610 8007FE10 0000C3AF */  sw         $v1, 0x0($fp)
    /* 70614 8007FE14 3400BF8F */  lw         $ra, 0x34($sp)
    /* 70618 8007FE18 3000BE8F */  lw         $fp, 0x30($sp)
    /* 7061C 8007FE1C 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 70620 8007FE20 2800B68F */  lw         $s6, 0x28($sp)
    /* 70624 8007FE24 2400B58F */  lw         $s5, 0x24($sp)
    /* 70628 8007FE28 2000B48F */  lw         $s4, 0x20($sp)
    /* 7062C 8007FE2C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 70630 8007FE30 1800B28F */  lw         $s2, 0x18($sp)
    /* 70634 8007FE34 1400B18F */  lw         $s1, 0x14($sp)
    /* 70638 8007FE38 1000B08F */  lw         $s0, 0x10($sp)
    /* 7063C 8007FE3C 0800E003 */  jr         $ra
    /* 70640 8007FE40 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
