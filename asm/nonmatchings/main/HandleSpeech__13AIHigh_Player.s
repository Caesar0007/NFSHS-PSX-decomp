.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HandleSpeech__13AIHigh_Player, 0x14C

glabel HandleSpeech__13AIHigh_Player
    /* 52CEC 800624EC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 52CF0 800624F0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 52CF4 800624F4 21808000 */  addu       $s0, $a0, $zero
    /* 52CF8 800624F8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 52CFC 800624FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 52D00 80062500 2000038E */  lw         $v1, 0x20($s0)
    /* 52D04 80062504 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 52D08 80062508 05006214 */  bne        $v1, $v0, .L80062520
    /* 52D0C 8006250C 21886000 */   addu      $s1, $v1, $zero
    /* 52D10 80062510 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 52D14 80062514 B4FA428C */  lw         $v0, %lo(Cars_gCopCarList)($v0)
    /* 52D18 80062518 00000000 */  nop
    /* 52D1C 8006251C 5402518C */  lw         $s1, 0x254($v0)
  .L80062520:
    /* 52D20 80062520 2800038E */  lw         $v1, 0x28($s0)
    /* 52D24 80062524 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 52D28 80062528 04006210 */  beq        $v1, $v0, .L8006253C
    /* 52D2C 8006252C 2A107100 */   slt       $v0, $v1, $s1
    /* 52D30 80062530 02004010 */  beqz       $v0, .L8006253C
    /* 52D34 80062534 00000000 */   nop
    /* 52D38 80062538 21886000 */  addu       $s1, $v1, $zero
  .L8006253C:
    /* 52D3C 8006253C 3000038E */  lw         $v1, 0x30($s0)
    /* 52D40 80062540 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 52D44 80062544 04006210 */  beq        $v1, $v0, .L80062558
    /* 52D48 80062548 2A107100 */   slt       $v0, $v1, $s1
    /* 52D4C 8006254C 02004010 */  beqz       $v0, .L80062558
    /* 52D50 80062550 00000000 */   nop
    /* 52D54 80062554 21886000 */  addu       $s1, $v1, $zero
  .L80062558:
    /* 52D58 80062558 01000324 */  addiu      $v1, $zero, 0x1
    /* 52D5C 8006255C 0000028E */  lw         $v0, 0x0($s0)
    /* 52D60 80062560 1800058E */  lw         $a1, 0x18($s0)
    /* 52D64 80062564 5402448C */  lw         $a0, 0x254($v0)
    /* 52D68 80062568 0900A310 */  beq        $a1, $v1, .L80062590
    /* 52D6C 8006256C 0200A228 */   slti      $v0, $a1, 0x2
    /* 52D70 80062570 05004014 */  bnez       $v0, .L80062588
    /* 52D74 80062574 02000224 */   addiu     $v0, $zero, 0x2
    /* 52D78 80062578 0900A210 */  beq        $a1, $v0, .L800625A0
    /* 52D7C 8006257C 03000224 */   addiu     $v0, $zero, 0x3
    /* 52D80 80062580 1000A210 */  beq        $a1, $v0, .L800625C4
    /* 52D84 80062584 00000000 */   nop
  .L80062588:
    /* 52D88 80062588 74890108 */  j          .L800625D0
    /* 52D8C 8006258C 04001024 */   addiu     $s0, $zero, 0x4
  .L80062590:
    /* 52D90 80062590 4966030C */  jal        Hud_Perp_OverlayOn__Fii
    /* 52D94 80062594 21280000 */   addu      $a1, $zero, $zero
    /* 52D98 80062598 74890108 */  j          .L800625D0
    /* 52D9C 8006259C 02001024 */   addiu     $s0, $zero, 0x2
  .L800625A0:
    /* 52DA0 800625A0 4966030C */  jal        Hud_Perp_OverlayOn__Fii
    /* 52DA4 800625A4 01000524 */   addiu     $a1, $zero, 0x1
    /* 52DA8 800625A8 8000048E */  lw         $a0, 0x80($s0)
    /* 52DAC 800625AC 00000000 */  nop
    /* 52DB0 800625B0 03008228 */  slti       $v0, $a0, 0x3
    /* 52DB4 800625B4 06004014 */  bnez       $v0, .L800625D0
    /* 52DB8 800625B8 08001024 */   addiu     $s0, $zero, 0x8
    /* 52DBC 800625BC 74890108 */  j          .L800625D0
    /* 52DC0 800625C0 06009024 */   addiu     $s0, $a0, 0x6
  .L800625C4:
    /* 52DC4 800625C4 4966030C */  jal        Hud_Perp_OverlayOn__Fii
    /* 52DC8 800625C8 02000524 */   addiu     $a1, $zero, 0x2
    /* 52DCC 800625CC 01001024 */  addiu      $s0, $zero, 0x1
  .L800625D0:
    /* 52DD0 800625D0 1480023C */  lui        $v0, %hi(AICop_gRoadBlockState)
    /* 52DD4 800625D4 74C5428C */  lw         $v0, %lo(AICop_gRoadBlockState)($v0)
    /* 52DD8 800625D8 00000000 */  nop
    /* 52DDC 800625DC 03004010 */  beqz       $v0, .L800625EC
    /* 52DE0 800625E0 02000224 */   addiu     $v0, $zero, 0x2
    /* 52DE4 800625E4 1480013C */  lui        $at, %hi(AICop_gRoadBlockState)
    /* 52DE8 800625E8 74C522AC */  sw         $v0, %lo(AICop_gRoadBlockState)($at)
  .L800625EC:
    /* 52DEC 800625EC 1180033C */  lui        $v1, %hi(Cars_gList)
    /* 52DF0 800625F0 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 52DF4 800625F4 80101100 */  sll        $v0, $s1, 2
    /* 52DF8 800625F8 21104300 */  addu       $v0, $v0, $v1
    /* 52DFC 800625FC 0000448C */  lw         $a0, 0x0($v0)
    /* 52E00 80062600 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 52E04 80062604 00000000 */   nop
    /* 52E08 80062608 4C00438C */  lw         $v1, 0x4C($v0)
    /* 52E0C 8006260C 21280002 */  addu       $a1, $s0, $zero
    /* 52E10 80062610 48006484 */  lh         $a0, 0x48($v1)
    /* 52E14 80062614 4C00638C */  lw         $v1, 0x4C($v1)
    /* 52E18 80062618 00000000 */  nop
    /* 52E1C 8006261C 09F86000 */  jalr       $v1
    /* 52E20 80062620 21204400 */   addu      $a0, $v0, $a0
    /* 52E24 80062624 1800BF8F */  lw         $ra, 0x18($sp)
    /* 52E28 80062628 1400B18F */  lw         $s1, 0x14($sp)
    /* 52E2C 8006262C 1000B08F */  lw         $s0, 0x10($sp)
    /* 52E30 80062630 0800E003 */  jr         $ra
    /* 52E34 80062634 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel HandleSpeech__13AIHigh_Player
