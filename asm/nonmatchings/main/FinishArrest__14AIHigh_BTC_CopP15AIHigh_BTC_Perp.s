.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp, 0x60

glabel FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D680 8005CE80 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D684 8005CE84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D688 8005CE88 21808000 */  addu       $s0, $a0, $zero
    /* 4D68C 8005CE8C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4D690 8005CE90 6000038E */  lw         $v1, 0x60($s0)
    /* 4D694 8005CE94 03000224 */  addiu      $v0, $zero, 0x3
    /* 4D698 8005CE98 03006210 */  beq        $v1, $v0, .L8005CEA8
    /* 4D69C 8005CE9C 00000000 */   nop
    /* 4D6A0 8005CEA0 0B006014 */  bnez       $v1, .L8005CED0
    /* 4D6A4 8005CEA4 00000000 */   nop
  .L8005CEA8:
    /* 4D6A8 8005CEA8 1400038E */  lw         $v1, 0x14($s0)
    /* 4D6AC 8005CEAC 04000224 */  addiu      $v0, $zero, 0x4
    /* 4D6B0 8005CEB0 600002AE */  sw         $v0, 0x60($s0)
    /* 4D6B4 8005CEB4 18006484 */  lh         $a0, 0x18($v1)
    /* 4D6B8 8005CEB8 1C00628C */  lw         $v0, 0x1C($v1)
    /* 4D6BC 8005CEBC 00000000 */  nop
    /* 4D6C0 8005CEC0 09F84000 */  jalr       $v0
    /* 4D6C4 8005CEC4 21200402 */   addu      $a0, $s0, $a0
    /* 4D6C8 8005CEC8 C173010C */  jal        HudOff__14AIHigh_BTC_Cop
    /* 4D6CC 8005CECC 21200002 */   addu      $a0, $s0, $zero
  .L8005CED0:
    /* 4D6D0 8005CED0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4D6D4 8005CED4 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D6D8 8005CED8 0800E003 */  jr         $ra
    /* 4D6DC 8005CEDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
