.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopCheck__14AIHigh_TrafficPi, 0x10C

glabel CopCheck__14AIHigh_TrafficPi
    /* 56560 80065D60 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 56564 80065D64 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 56568 80065D68 2188A000 */  addu       $s1, $a1, $zero
    /* 5656C 80065D6C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 56570 80065D70 1800B0AF */  sw         $s0, 0x18($sp)
    /* 56574 80065D74 000020AE */  sw         $zero, 0x0($s1)
    /* 56578 80065D78 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 5657C 80065D7C 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 56580 80065D80 00000000 */  nop
    /* 56584 80065D84 32004010 */  beqz       $v0, .L80065E50
    /* 56588 80065D88 21800000 */   addu      $s0, $zero, $zero
    /* 5658C 80065D8C 2397010C */  jal        CheckForCops__14AIHigh_TrafficPi
    /* 56590 80065D90 1000A527 */   addiu     $a1, $sp, 0x10
    /* 56594 80065D94 21204000 */  addu       $a0, $v0, $zero
    /* 56598 80065D98 2F008010 */  beqz       $a0, .L80065E58
    /* 5659C 80065D9C 21100000 */   addu      $v0, $zero, $zero
    /* 565A0 80065DA0 0100023C */  lui        $v0, (0x1FFFF >> 16)
    /* 565A4 80065DA4 6405838C */  lw         $v1, 0x564($a0)
    /* 565A8 80065DA8 FFFF4234 */  ori        $v0, $v0, (0x1FFFF & 0xFFFF)
    /* 565AC 80065DAC 02006104 */  bgez       $v1, .L80065DB8
    /* 565B0 80065DB0 21286000 */   addu      $a1, $v1, $zero
    /* 565B4 80065DB4 23280500 */  negu       $a1, $a1
  .L80065DB8:
    /* 565B8 80065DB8 2A104500 */  slt        $v0, $v0, $a1
    /* 565BC 80065DBC 16004014 */  bnez       $v0, .L80065E18
    /* 565C0 80065DC0 0200023C */   lui       $v0, (0x20000 >> 16)
    /* 565C4 80065DC4 4A00023C */  lui        $v0, (0x4AFFFF >> 16)
    /* 565C8 80065DC8 1000A38F */  lw         $v1, 0x10($sp)
    /* 565CC 80065DCC FFFF4234 */  ori        $v0, $v0, (0x4AFFFF & 0xFFFF)
    /* 565D0 80065DD0 2A104300 */  slt        $v0, $v0, $v1
    /* 565D4 80065DD4 10004014 */  bnez       $v0, .L80065E18
    /* 565D8 80065DD8 0200023C */   lui       $v0, (0x20000 >> 16)
    /* 565DC 80065DDC 01000224 */  addiu      $v0, $zero, 0x1
    /* 565E0 80065DE0 1180033C */  lui        $v1, %hi(highLevelAIObjs)
    /* 565E4 80065DE4 000022AE */  sw         $v0, 0x0($s1)
    /* 565E8 80065DE8 5402828C */  lw         $v0, 0x254($a0)
    /* 565EC 80065DEC 38CD6324 */  addiu      $v1, $v1, %lo(highLevelAIObjs)
    /* 565F0 80065DF0 80100200 */  sll        $v0, $v0, 2
    /* 565F4 80065DF4 21104300 */  addu       $v0, $v0, $v1
    /* 565F8 80065DF8 0000508C */  lw         $s0, 0x0($v0)
    /* 565FC 80065DFC 00000000 */  nop
    /* 56600 80065E00 5800028E */  lw         $v0, 0x58($s0)
    /* 56604 80065E04 00000000 */  nop
    /* 56608 80065E08 13004014 */  bnez       $v0, .L80065E58
    /* 5660C 80065E0C 21100002 */   addu      $v0, $s0, $zero
    /* 56610 80065E10 94970108 */  j          .L80065E50
    /* 56614 80065E14 21800000 */   addu      $s0, $zero, $zero
  .L80065E18:
    /* 56618 80065E18 2A104500 */  slt        $v0, $v0, $a1
    /* 5661C 80065E1C 0C004010 */  beqz       $v0, .L80065E50
    /* 56620 80065E20 4A00023C */   lui       $v0, (0x4AFFFF >> 16)
    /* 56624 80065E24 1000A38F */  lw         $v1, 0x10($sp)
    /* 56628 80065E28 FFFF4234 */  ori        $v0, $v0, (0x4AFFFF & 0xFFFF)
    /* 5662C 80065E2C 2A104300 */  slt        $v0, $v0, $v1
    /* 56630 80065E30 09004014 */  bnez       $v0, .L80065E58
    /* 56634 80065E34 21100002 */   addu      $v0, $s0, $zero
    /* 56638 80065E38 1180033C */  lui        $v1, %hi(highLevelAIObjs)
    /* 5663C 80065E3C 5402828C */  lw         $v0, 0x254($a0)
    /* 56640 80065E40 38CD6324 */  addiu      $v1, $v1, %lo(highLevelAIObjs)
    /* 56644 80065E44 80100200 */  sll        $v0, $v0, 2
    /* 56648 80065E48 21104300 */  addu       $v0, $v0, $v1
    /* 5664C 80065E4C 0000508C */  lw         $s0, 0x0($v0)
  .L80065E50:
    /* 56650 80065E50 00000000 */  nop
    /* 56654 80065E54 21100002 */  addu       $v0, $s0, $zero
  .L80065E58:
    /* 56658 80065E58 2000BF8F */  lw         $ra, 0x20($sp)
    /* 5665C 80065E5C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 56660 80065E60 1800B08F */  lw         $s0, 0x18($sp)
    /* 56664 80065E64 0800E003 */  jr         $ra
    /* 56668 80065E68 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CopCheck__14AIHigh_TrafficPi
