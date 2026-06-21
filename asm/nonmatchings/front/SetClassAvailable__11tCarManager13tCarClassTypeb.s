.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetClassAvailable__11tCarManager13tCarClassTypeb, 0x84

glabel SetClassAvailable__11tCarManager13tCarClassTypeb
    /* 7568 80016D68 0000828C */  lw         $v0, 0x0($a0)
    /* 756C 80016D6C 00000000 */  nop
    /* 7570 80016D70 1C004010 */  beqz       $v0, .L80016DE4
    /* 7574 80016D74 21400000 */   addu      $t0, $zero, $zero
    /* 7578 80016D78 01000924 */  addiu      $t1, $zero, 0x1
    /* 757C 80016D7C 21380001 */  addu       $a3, $t0, $zero
  .L80016D80:
    /* 7580 80016D80 0400828C */  lw         $v0, 0x4($a0)
    /* 7584 80016D84 00000000 */  nop
    /* 7588 80016D88 2110E200 */  addu       $v0, $a3, $v0
    /* 758C 80016D8C 00004380 */  lb         $v1, 0x0($v0)
    /* 7590 80016D90 00000000 */  nop
    /* 7594 80016D94 0E006004 */  bltz       $v1, .L80016DD0
    /* 7598 80016D98 00000000 */   nop
    /* 759C 80016D9C 02004290 */  lbu        $v0, 0x2($v0)
    /* 75A0 80016DA0 00000000 */  nop
    /* 75A4 80016DA4 0A004514 */  bne        $v0, $a1, .L80016DD0
    /* 75A8 80016DA8 21108300 */   addu      $v0, $a0, $v1
    /* 75AC 80016DAC 0800C010 */  beqz       $a2, .L80016DD0
    /* 75B0 80016DB0 080246A0 */   sb        $a2, 0x208($v0)
    /* 75B4 80016DB4 0400828C */  lw         $v0, 0x4($a0)
    /* 75B8 80016DB8 00000000 */  nop
    /* 75BC 80016DBC 2110E200 */  addu       $v0, $a3, $v0
    /* 75C0 80016DC0 00004280 */  lb         $v0, 0x0($v0)
    /* 75C4 80016DC4 00000000 */  nop
    /* 75C8 80016DC8 21108200 */  addu       $v0, $a0, $v0
    /* 75CC 80016DCC 380249A0 */  sb         $t1, 0x238($v0)
  .L80016DD0:
    /* 75D0 80016DD0 0000828C */  lw         $v0, 0x0($a0)
    /* 75D4 80016DD4 01000825 */  addiu      $t0, $t0, 0x1
    /* 75D8 80016DD8 2B100201 */  sltu       $v0, $t0, $v0
    /* 75DC 80016DDC E8FF4014 */  bnez       $v0, .L80016D80
    /* 75E0 80016DE0 CC00E724 */   addiu     $a3, $a3, 0xCC
  .L80016DE4:
    /* 75E4 80016DE4 0800E003 */  jr         $ra
    /* 75E8 80016DE8 00000000 */   nop
endlabel SetClassAvailable__11tCarManager13tCarClassTypeb
