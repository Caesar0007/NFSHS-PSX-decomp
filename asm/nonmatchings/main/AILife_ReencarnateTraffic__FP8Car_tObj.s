.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_ReencarnateTraffic__FP8Car_tObj, 0xB0

glabel AILife_ReencarnateTraffic__FP8Car_tObj
    /* 586E4 80067EE4 1480023C */  lui        $v0, %hi(fastRandom)
    /* 586E8 80067EE8 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 586EC 80067EEC 1480033C */  lui        $v1, %hi(randSeed)
    /* 586F0 80067EF0 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 586F4 80067EF4 00000000 */  nop
    /* 586F8 80067EF8 18004300 */  mult       $v0, $v1
    /* 586FC 80067EFC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 58700 80067F00 1000B0AF */  sw         $s0, 0x10($sp)
    /* 58704 80067F04 21808000 */  addu       $s0, $a0, $zero
    /* 58708 80067F08 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5870C 80067F0C 12100000 */  mflo       $v0
    /* 58710 80067F10 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 58714 80067F14 1480013C */  lui        $at, %hi(randtemp)
    /* 58718 80067F18 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 5871C 80067F1C 02120200 */  srl        $v0, $v0, 8
    /* 58720 80067F20 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 58724 80067F24 1480013C */  lui        $at, %hi(fastRandom)
    /* 58728 80067F28 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 5872C 80067F2C 40180200 */  sll        $v1, $v0, 1
    /* 58730 80067F30 21186200 */  addu       $v1, $v1, $v0
    /* 58734 80067F34 6002028E */  lw         $v0, 0x260($s0)
    /* 58738 80067F38 00000000 */  nop
    /* 5873C 80067F3C 10004230 */  andi       $v0, $v0, 0x10
    /* 58740 80067F40 03004010 */  beqz       $v0, .L80067F50
    /* 58744 80067F44 022C0300 */   srl       $a1, $v1, 16
    /* 58748 80067F48 0BB7020C */  jal        R3DCar_ChangeTrafficColor__FP8Car_tObji
    /* 5874C 80067F4C 00000000 */   nop
  .L80067F50:
    /* 58750 80067F50 776A010C */  jal        AI_ChooseNewLaneSlack__FP8Car_tObj
    /* 58754 80067F54 21200002 */   addu      $a0, $s0, $zero
    /* 58758 80067F58 CABB010C */  jal        AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
    /* 5875C 80067F5C 21200002 */   addu      $a0, $s0, $zero
    /* 58760 80067F60 B99D010C */  jal        AILife_RCPickSliceAndDirection__FP8Car_tObj
    /* 58764 80067F64 21200002 */   addu      $a0, $s0, $zero
    /* 58768 80067F68 C79E010C */  jal        AILife_RCPickDesiredLatPosition__FP8Car_tObj
    /* 5876C 80067F6C 21200002 */   addu      $a0, $s0, $zero
    /* 58770 80067F70 AD9D010C */  jal        AILife_RCSetSpeeds__FP8Car_tObj
    /* 58774 80067F74 21200002 */   addu      $a0, $s0, $zero
    /* 58778 80067F78 21200002 */  addu       $a0, $s0, $zero
    /* 5877C 80067F7C 389F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObji
    /* 58780 80067F80 21280000 */   addu      $a1, $zero, $zero
    /* 58784 80067F84 1400BF8F */  lw         $ra, 0x14($sp)
    /* 58788 80067F88 1000B08F */  lw         $s0, 0x10($sp)
    /* 5878C 80067F8C 0800E003 */  jr         $ra
    /* 58790 80067F90 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_ReencarnateTraffic__FP8Car_tObj
