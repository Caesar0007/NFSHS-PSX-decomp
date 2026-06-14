.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIHigh_StartUp__Fv, 0x3A8

glabel AIHigh_StartUp__Fv
    /* 4B594 8005AD94 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4B598 8005AD98 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4B59C 8005AD9C 21900000 */  addu       $s2, $zero, $zero
    /* 4B5A0 8005ADA0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4B5A4 8005ADA4 21A04002 */  addu       $s4, $s2, $zero
    /* 4B5A8 8005ADA8 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 4B5AC 8005ADAC 2800B6AF */  sw         $s6, 0x28($sp)
    /* 4B5B0 8005ADB0 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4B5B4 8005ADB4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4B5B8 8005ADB8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4B5BC 8005ADBC 69BE010C */  jal        AIState_StartUp__Fv
    /* 4B5C0 8005ADC0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 4B5C4 8005ADC4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 4B5C8 8005ADC8 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 4B5CC 8005ADCC 01000224 */  addiu      $v0, $zero, 0x1
    /* 4B5D0 8005ADD0 03006210 */  beq        $v1, $v0, .L8005ADE0
    /* 4B5D4 8005ADD4 05000224 */   addiu     $v0, $zero, 0x5
    /* 4B5D8 8005ADD8 83006214 */  bne        $v1, $v0, .L8005AFE8
    /* 4B5DC 8005ADDC 21980000 */   addu      $s3, $zero, $zero
  .L8005ADE0:
    /* 4B5E0 8005ADE0 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 4B5E4 8005ADE4 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 4B5E8 8005ADE8 00000000 */  nop
    /* 4B5EC 8005ADEC 6002428C */  lw         $v0, 0x260($v0)
    /* 4B5F0 8005ADF0 00000000 */  nop
    /* 4B5F4 8005ADF4 00024230 */  andi       $v0, $v0, 0x200
    /* 4B5F8 8005ADF8 0D004014 */  bnez       $v0, .L8005AE30
    /* 4B5FC 8005ADFC 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 4B600 8005AE00 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 4B604 8005AE04 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 4B608 8005AE08 02000224 */  addiu      $v0, $zero, 0x2
    /* 4B60C 8005AE0C 76006214 */  bne        $v1, $v0, .L8005AFE8
    /* 4B610 8005AE10 21980000 */   addu      $s3, $zero, $zero
    /* 4B614 8005AE14 0400828C */  lw         $v0, 0x4($a0)
    /* 4B618 8005AE18 00000000 */  nop
    /* 4B61C 8005AE1C 6002428C */  lw         $v0, 0x260($v0)
    /* 4B620 8005AE20 00000000 */  nop
    /* 4B624 8005AE24 00024230 */  andi       $v0, $v0, 0x200
    /* 4B628 8005AE28 6F004010 */  beqz       $v0, .L8005AFE8
    /* 4B62C 8005AE2C 00000000 */   nop
  .L8005AE30:
    /* 4B630 8005AE30 21980000 */  addu       $s3, $zero, $zero
    /* 4B634 8005AE34 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4B638 8005AE38 DCF95524 */  addiu      $s5, $v0, %lo(Cars_gList)
  .L8005AE3C:
    /* 4B63C 8005AE3C 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4B640 8005AE40 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4B644 8005AE44 00000000 */  nop
    /* 4B648 8005AE48 2A106202 */  slt        $v0, $s3, $v0
    /* 4B64C 8005AE4C 54004010 */  beqz       $v0, .L8005AFA0
    /* 4B650 8005AE50 80181300 */   sll       $v1, $s3, 2
    /* 4B654 8005AE54 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4B658 8005AE58 0000B18E */  lw         $s1, 0x0($s5)
    /* 4B65C 8005AE5C 38CD4224 */  addiu      $v0, $v0, %lo(highLevelAIObjs)
    /* 4B660 8005AE60 6002248E */  lw         $a0, 0x260($s1)
    /* 4B664 8005AE64 21B06200 */  addu       $s6, $v1, $v0
    /* 4B668 8005AE68 00028230 */  andi       $v0, $a0, 0x200
    /* 4B66C 8005AE6C 0A004010 */  beqz       $v0, .L8005AE98
    /* 4B670 8005AE70 04008230 */   andi      $v0, $a0, 0x4
    /* 4B674 8005AE74 578F020C */  jal        __builtin_new
    /* 4B678 8005AE78 8C000424 */   addiu     $a0, $zero, 0x8C
    /* 4B67C 8005AE7C 21304002 */  addu       $a2, $s2, $zero
    /* 4B680 8005AE80 01005226 */  addiu      $s2, $s2, 0x1
    /* 4B684 8005AE84 21204000 */  addu       $a0, $v0, $zero
    /* 4B688 8005AE88 CD73010C */  jal        __19AIHigh_BTC_HumanCopP8Car_tObji
    /* 4B68C 8005AE8C 21282002 */   addu      $a1, $s1, $zero
    /* 4B690 8005AE90 DE6B0108 */  j          .L8005AF78
    /* 4B694 8005AE94 21804000 */   addu      $s0, $v0, $zero
  .L8005AE98:
    /* 4B698 8005AE98 11004010 */  beqz       $v0, .L8005AEE0
    /* 4B69C 8005AE9C 08008230 */   andi      $v0, $a0, 0x8
    /* 4B6A0 8005AEA0 578F020C */  jal        __builtin_new
    /* 4B6A4 8005AEA4 88000424 */   addiu     $a0, $zero, 0x88
    /* 4B6A8 8005AEA8 21804000 */  addu       $s0, $v0, $zero
    /* 4B6AC 8005AEAC 21200002 */  addu       $a0, $s0, $zero
    /* 4B6B0 8005AEB0 3D70010C */  jal        __16AIHigh_BasicPerpP8Car_tObj
    /* 4B6B4 8005AEB4 21282002 */   addu      $a1, $s1, $zero
    /* 4B6B8 8005AEB8 0580023C */  lui        $v0, %hi(D_80054DCC)
    /* 4B6BC 8005AEBC CC4D4224 */  addiu      $v0, $v0, %lo(D_80054DCC)
    /* 4B6C0 8005AEC0 140002AE */  sw         $v0, 0x14($s0)
    /* 4B6C4 8005AEC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 4B6C8 8005AEC8 7C0002AE */  sw         $v0, 0x7C($s0)
    /* 4B6CC 8005AECC 0580023C */  lui        $v0, %hi(_vt_20AIHigh_BTC_HumanPerp)
    /* 4B6D0 8005AED0 C04F4224 */  addiu      $v0, $v0, %lo(_vt_20AIHigh_BTC_HumanPerp)
    /* 4B6D4 8005AED4 800000AE */  sw         $zero, 0x80($s0)
    /* 4B6D8 8005AED8 DD6B0108 */  j          .L8005AF74
    /* 4B6DC 8005AEDC 840000AE */   sw        $zero, 0x84($s0)
  .L8005AEE0:
    /* 4B6E0 8005AEE0 08004010 */  beqz       $v0, .L8005AF04
    /* 4B6E4 8005AEE4 10008230 */   andi      $v0, $a0, 0x10
    /* 4B6E8 8005AEE8 578F020C */  jal        __builtin_new
    /* 4B6EC 8005AEEC AC000424 */   addiu     $a0, $zero, 0xAC
    /* 4B6F0 8005AEF0 21204000 */  addu       $a0, $v0, $zero
    /* 4B6F4 8005AEF4 BD80010C */  jal        __17AIHigh_BTC_AIPerpP8Car_tObj
    /* 4B6F8 8005AEF8 21282002 */   addu      $a1, $s1, $zero
    /* 4B6FC 8005AEFC DE6B0108 */  j          .L8005AF78
    /* 4B700 8005AF00 21804000 */   addu      $s0, $v0, $zero
  .L8005AF04:
    /* 4B704 8005AF04 08004010 */  beqz       $v0, .L8005AF28
    /* 4B708 8005AF08 20008230 */   andi      $v0, $a0, 0x20
    /* 4B70C 8005AF0C 578F020C */  jal        __builtin_new
    /* 4B710 8005AF10 24000424 */   addiu     $a0, $zero, 0x24
    /* 4B714 8005AF14 21204000 */  addu       $a0, $v0, $zero
    /* 4B718 8005AF18 BE99010C */  jal        __14AIHigh_TrafficP8Car_tObj
    /* 4B71C 8005AF1C 21282002 */   addu      $a1, $s1, $zero
    /* 4B720 8005AF20 DE6B0108 */  j          .L8005AF78
    /* 4B724 8005AF24 21804000 */   addu      $s0, $v0, $zero
  .L8005AF28:
    /* 4B728 8005AF28 0A004010 */  beqz       $v0, .L8005AF54
    /* 4B72C 8005AF2C 00000000 */   nop
    /* 4B730 8005AF30 578F020C */  jal        __builtin_new
    /* 4B734 8005AF34 7C000424 */   addiu     $a0, $zero, 0x7C
    /* 4B738 8005AF38 21304002 */  addu       $a2, $s2, $zero
    /* 4B73C 8005AF3C 01005226 */  addiu      $s2, $s2, 0x1
    /* 4B740 8005AF40 21204000 */  addu       $a0, $v0, $zero
    /* 4B744 8005AF44 BC78010C */  jal        __18AIHigh_BTC_WingmanP8Car_tObji
    /* 4B748 8005AF48 21282002 */   addu      $a1, $s1, $zero
    /* 4B74C 8005AF4C DE6B0108 */  j          .L8005AF78
    /* 4B750 8005AF50 21804000 */   addu      $s0, $v0, $zero
  .L8005AF54:
    /* 4B754 8005AF54 578F020C */  jal        __builtin_new
    /* 4B758 8005AF58 18000424 */   addiu     $a0, $zero, 0x18
    /* 4B75C 8005AF5C 21804000 */  addu       $s0, $v0, $zero
    /* 4B760 8005AF60 21200002 */  addu       $a0, $s0, $zero
    /* 4B764 8005AF64 C66C010C */  jal        __11AIHigh_BaseP8Car_tObj
    /* 4B768 8005AF68 21282002 */   addu      $a1, $s1, $zero
    /* 4B76C 8005AF6C 0580023C */  lui        $v0, %hi(D_80054DEC)
    /* 4B770 8005AF70 EC4D4224 */  addiu      $v0, $v0, %lo(D_80054DEC)
  .L8005AF74:
    /* 4B774 8005AF74 140002AE */  sw         $v0, 0x14($s0)
  .L8005AF78:
    /* 4B778 8005AF78 0000D0AE */  sw         $s0, 0x0($s6)
    /* 4B77C 8005AF7C 6002228E */  lw         $v0, 0x260($s1)
    /* 4B780 8005AF80 00000000 */  nop
    /* 4B784 8005AF84 00024230 */  andi       $v0, $v0, 0x200
    /* 4B788 8005AF88 02004010 */  beqz       $v0, .L8005AF94
    /* 4B78C 8005AF8C 00000000 */   nop
    /* 4B790 8005AF90 01009426 */  addiu      $s4, $s4, 0x1
  .L8005AF94:
    /* 4B794 8005AF94 0400B526 */  addiu      $s5, $s5, 0x4
    /* 4B798 8005AF98 8F6B0108 */  j          .L8005AE3C
    /* 4B79C 8005AF9C 01007326 */   addiu     $s3, $s3, 0x1
  .L8005AFA0:
    /* 4B7A0 8005AFA0 02000224 */  addiu      $v0, $zero, 0x2
    /* 4B7A4 8005AFA4 05008216 */  bne        $s4, $v0, .L8005AFBC
    /* 4B7A8 8005AFA8 01000224 */   addiu     $v0, $zero, 0x1
    /* 4B7AC 8005AFAC 03000224 */  addiu      $v0, $zero, 0x3
    /* 4B7B0 8005AFB0 100082AF */  sw         $v0, %gp_rel(AIHigh_CopGameType)($gp)
    /* 4B7B4 8005AFB4 456C0108 */  j          .L8005B114
    /* 4B7B8 8005AFB8 00000000 */   nop
  .L8005AFBC:
    /* 4B7BC 8005AFBC 07008216 */  bne        $s4, $v0, .L8005AFDC
    /* 4B7C0 8005AFC0 02000224 */   addiu     $v0, $zero, 0x2
    /* 4B7C4 8005AFC4 05005416 */  bne        $s2, $s4, .L8005AFDC
    /* 4B7C8 8005AFC8 00000000 */   nop
    /* 4B7CC 8005AFCC 04000224 */  addiu      $v0, $zero, 0x4
    /* 4B7D0 8005AFD0 100082AF */  sw         $v0, %gp_rel(AIHigh_CopGameType)($gp)
    /* 4B7D4 8005AFD4 456C0108 */  j          .L8005B114
    /* 4B7D8 8005AFD8 00000000 */   nop
  .L8005AFDC:
    /* 4B7DC 8005AFDC 100082AF */  sw         $v0, %gp_rel(AIHigh_CopGameType)($gp)
    /* 4B7E0 8005AFE0 456C0108 */  j          .L8005B114
    /* 4B7E4 8005AFE4 00000000 */   nop
  .L8005AFE8:
    /* 4B7E8 8005AFE8 21906002 */  addu       $s2, $s3, $zero
    /* 4B7EC 8005AFEC 0580023C */  lui        $v0, %hi(D_80054DEC)
    /* 4B7F0 8005AFF0 EC4D5624 */  addiu      $s6, $v0, %lo(D_80054DEC)
    /* 4B7F4 8005AFF4 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4B7F8 8005AFF8 38CD5524 */  addiu      $s5, $v0, %lo(highLevelAIObjs)
    /* 4B7FC 8005AFFC 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4B800 8005B000 DCF95424 */  addiu      $s4, $v0, %lo(Cars_gList)
  .L8005B004:
    /* 4B804 8005B004 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4B808 8005B008 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4B80C 8005B00C 00000000 */  nop
    /* 4B810 8005B010 2A106202 */  slt        $v0, $s3, $v0
    /* 4B814 8005B014 39004010 */  beqz       $v0, .L8005B0FC
    /* 4B818 8005B018 00000000 */   nop
    /* 4B81C 8005B01C 0000918E */  lw         $s1, 0x0($s4)
    /* 4B820 8005B020 00000000 */  nop
    /* 4B824 8005B024 6002238E */  lw         $v1, 0x260($s1)
    /* 4B828 8005B028 00000000 */  nop
    /* 4B82C 8005B02C 04006230 */  andi       $v0, $v1, 0x4
    /* 4B830 8005B030 08004010 */  beqz       $v0, .L8005B054
    /* 4B834 8005B034 08006230 */   andi      $v0, $v1, 0x8
    /* 4B838 8005B038 578F020C */  jal        __builtin_new
    /* 4B83C 8005B03C B0000424 */   addiu     $a0, $zero, 0xB0
    /* 4B840 8005B040 21204000 */  addu       $a0, $v0, $zero
    /* 4B844 8005B044 AB8C010C */  jal        __12AIHigh_HumanP8Car_tObj
    /* 4B848 8005B048 21282002 */   addu      $a1, $s1, $zero
    /* 4B84C 8005B04C 3B6C0108 */  j          .L8005B0EC
    /* 4B850 8005B050 0000A2AE */   sw        $v0, 0x0($s5)
  .L8005B054:
    /* 4B854 8005B054 08004010 */  beqz       $v0, .L8005B078
    /* 4B858 8005B058 10006230 */   andi      $v0, $v1, 0x10
    /* 4B85C 8005B05C 578F020C */  jal        __builtin_new
    /* 4B860 8005B060 C0000424 */   addiu     $a0, $zero, 0xC0
    /* 4B864 8005B064 21204000 */  addu       $a0, $v0, $zero
    /* 4B868 8005B068 BA8E010C */  jal        __15AIHigh_OpponentP8Car_tObj
    /* 4B86C 8005B06C 21282002 */   addu      $a1, $s1, $zero
    /* 4B870 8005B070 3B6C0108 */  j          .L8005B0EC
    /* 4B874 8005B074 0000A2AE */   sw        $v0, 0x0($s5)
  .L8005B078:
    /* 4B878 8005B078 08004010 */  beqz       $v0, .L8005B09C
    /* 4B87C 8005B07C 20006230 */   andi      $v0, $v1, 0x20
    /* 4B880 8005B080 578F020C */  jal        __builtin_new
    /* 4B884 8005B084 24000424 */   addiu     $a0, $zero, 0x24
    /* 4B888 8005B088 21204000 */  addu       $a0, $v0, $zero
    /* 4B88C 8005B08C BE99010C */  jal        __14AIHigh_TrafficP8Car_tObj
    /* 4B890 8005B090 21282002 */   addu      $a1, $s1, $zero
    /* 4B894 8005B094 3B6C0108 */  j          .L8005B0EC
    /* 4B898 8005B098 0000A2AE */   sw        $v0, 0x0($s5)
  .L8005B09C:
    /* 4B89C 8005B09C 0A004010 */  beqz       $v0, .L8005B0C8
    /* 4B8A0 8005B0A0 00000000 */   nop
    /* 4B8A4 8005B0A4 578F020C */  jal        __builtin_new
    /* 4B8A8 8005B0A8 6C000424 */   addiu     $a0, $zero, 0x6C
    /* 4B8AC 8005B0AC 21304002 */  addu       $a2, $s2, $zero
    /* 4B8B0 8005B0B0 01005226 */  addiu      $s2, $s2, 0x1
    /* 4B8B4 8005B0B4 21204000 */  addu       $a0, $v0, $zero
    /* 4B8B8 8005B0B8 008F010C */  jal        __10AIHigh_CopP8Car_tObji
    /* 4B8BC 8005B0BC 21282002 */   addu      $a1, $s1, $zero
    /* 4B8C0 8005B0C0 3B6C0108 */  j          .L8005B0EC
    /* 4B8C4 8005B0C4 0000A2AE */   sw        $v0, 0x0($s5)
  .L8005B0C8:
    /* 4B8C8 8005B0C8 578F020C */  jal        __builtin_new
    /* 4B8CC 8005B0CC 18000424 */   addiu     $a0, $zero, 0x18
    /* 4B8D0 8005B0D0 21804000 */  addu       $s0, $v0, $zero
    /* 4B8D4 8005B0D4 21200002 */  addu       $a0, $s0, $zero
    /* 4B8D8 8005B0D8 C66C010C */  jal        __11AIHigh_BaseP8Car_tObj
    /* 4B8DC 8005B0DC 21282002 */   addu      $a1, $s1, $zero
    /* 4B8E0 8005B0E0 140016AE */  sw         $s6, 0x14($s0)
    /* 4B8E4 8005B0E4 21100002 */  addu       $v0, $s0, $zero
    /* 4B8E8 8005B0E8 0000A2AE */  sw         $v0, 0x0($s5)
  .L8005B0EC:
    /* 4B8EC 8005B0EC 0400B526 */  addiu      $s5, $s5, 0x4
    /* 4B8F0 8005B0F0 04009426 */  addiu      $s4, $s4, 0x4
    /* 4B8F4 8005B0F4 016C0108 */  j          .L8005B004
    /* 4B8F8 8005B0F8 01007326 */   addiu     $s3, $s3, 0x1
  .L8005B0FC:
    /* 4B8FC 8005B0FC 0400401A */  blez       $s2, .L8005B110
    /* 4B900 8005B100 01000224 */   addiu     $v0, $zero, 0x1
    /* 4B904 8005B104 100082AF */  sw         $v0, %gp_rel(AIHigh_CopGameType)($gp)
    /* 4B908 8005B108 456C0108 */  j          .L8005B114
    /* 4B90C 8005B10C 00000000 */   nop
  .L8005B110:
    /* 4B910 8005B110 100080AF */  sw         $zero, %gp_rel(AIHigh_CopGameType)($gp)
  .L8005B114:
    /* 4B914 8005B114 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 4B918 8005B118 2800B68F */  lw         $s6, 0x28($sp)
    /* 4B91C 8005B11C 2400B58F */  lw         $s5, 0x24($sp)
    /* 4B920 8005B120 2000B48F */  lw         $s4, 0x20($sp)
    /* 4B924 8005B124 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4B928 8005B128 1800B28F */  lw         $s2, 0x18($sp)
    /* 4B92C 8005B12C 1400B18F */  lw         $s1, 0x14($sp)
    /* 4B930 8005B130 1000B08F */  lw         $s0, 0x10($sp)
    /* 4B934 8005B134 0800E003 */  jr         $ra
    /* 4B938 8005B138 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIHigh_StartUp__Fv
