.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Upgrade__30AIDataRecord_CurveSpeedTable_ti, 0x8C

glabel Upgrade__30AIDataRecord_CurveSpeedTable_ti
    /* 5DC80 8006D480 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5DC84 8006D484 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5DC88 8006D488 21888000 */  addu       $s1, $a0, $zero
    /* 5DC8C 8006D48C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5DC90 8006D490 2198A000 */  addu       $s3, $a1, $zero
    /* 5DC94 8006D494 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5DC98 8006D498 21800000 */  addu       $s0, $zero, $zero
    /* 5DC9C 8006D49C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5DCA0 8006D4A0 FFFF1234 */  ori        $s2, $zero, 0xFFFF
    /* 5DCA4 8006D4A4 2000BFAF */  sw         $ra, 0x20($sp)
  .L8006D4A8:
    /* 5DCA8 8006D4A8 0000228E */  lw         $v0, 0x0($s1)
    /* 5DCAC 8006D4AC 00000000 */  nop
    /* 5DCB0 8006D4B0 2A100202 */  slt        $v0, $s0, $v0
    /* 5DCB4 8006D4B4 0E004010 */  beqz       $v0, .L8006D4F0
    /* 5DCB8 8006D4B8 21202002 */   addu      $a0, $s1, $zero
    /* 5DCBC 8006D4BC 13B5010C */  jal        Get__30AIDataRecord_CurveSpeedTable_ti
    /* 5DCC0 8006D4C0 21280002 */   addu      $a1, $s0, $zero
    /* 5DCC4 8006D4C4 21204000 */  addu       $a0, $v0, $zero
    /* 5DCC8 8006D4C8 CA90030C */  jal        fixedmult
    /* 5DCCC 8006D4CC 21286002 */   addu      $a1, $s3, $zero
    /* 5DCD0 8006D4D0 4800238E */  lw         $v1, 0x48($s1)
    /* 5DCD4 8006D4D4 02004104 */  bgez       $v0, .L8006D4E0
    /* 5DCD8 8006D4D8 21187000 */   addu      $v1, $v1, $s0
    /* 5DCDC 8006D4DC 21105200 */  addu       $v0, $v0, $s2
  .L8006D4E0:
    /* 5DCE0 8006D4E0 03140200 */  sra        $v0, $v0, 16
    /* 5DCE4 8006D4E4 000062A0 */  sb         $v0, 0x0($v1)
    /* 5DCE8 8006D4E8 2AB50108 */  j          .L8006D4A8
    /* 5DCEC 8006D4EC 01001026 */   addiu     $s0, $s0, 0x1
  .L8006D4F0:
    /* 5DCF0 8006D4F0 2000BF8F */  lw         $ra, 0x20($sp)
    /* 5DCF4 8006D4F4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5DCF8 8006D4F8 1800B28F */  lw         $s2, 0x18($sp)
    /* 5DCFC 8006D4FC 1400B18F */  lw         $s1, 0x14($sp)
    /* 5DD00 8006D500 1000B08F */  lw         $s0, 0x10($sp)
    /* 5DD04 8006D504 0800E003 */  jr         $ra
    /* 5DD08 8006D508 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Upgrade__30AIDataRecord_CurveSpeedTable_ti
