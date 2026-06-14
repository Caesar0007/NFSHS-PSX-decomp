.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HighExecute__20AIHigh_BTC_HumanPerp, 0x58

glabel HighExecute__20AIHigh_BTC_HumanPerp
    /* 50A9C 8006029C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 50AA0 800602A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50AA4 800602A4 21808000 */  addu       $s0, $a0, $zero
    /* 50AA8 800602A8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 50AAC 800602AC 7C00038E */  lw         $v1, 0x7C($s0)
    /* 50AB0 800602B0 01000224 */  addiu      $v0, $zero, 0x1
    /* 50AB4 800602B4 09006214 */  bne        $v1, $v0, .L800602DC
    /* 50AB8 800602B8 00000000 */   nop
    /* 50ABC 800602BC DD7F010C */  jal        CheckForActivation__15AIHigh_BTC_Perp
    /* 50AC0 800602C0 00000000 */   nop
    /* 50AC4 800602C4 05004010 */  beqz       $v0, .L800602DC
    /* 50AC8 800602C8 21200002 */   addu      $a0, $s0, $zero
    /* 50ACC 800602CC 1F80010C */  jal        NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop
    /* 50AD0 800602D0 21284000 */   addu      $a1, $v0, $zero
    /* 50AD4 800602D4 B9800108 */  j          .L800602E4
    /* 50AD8 800602D8 00000000 */   nop
  .L800602DC:
    /* 50ADC 800602DC DE7D010C */  jal        HandleCops__15AIHigh_BTC_Perp
    /* 50AE0 800602E0 21200002 */   addu      $a0, $s0, $zero
  .L800602E4:
    /* 50AE4 800602E4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 50AE8 800602E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 50AEC 800602EC 0800E003 */  jr         $ra
    /* 50AF0 800602F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HighExecute__20AIHigh_BTC_HumanPerp
