.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_SetupOncomingLaneDemerits__FP8Car_tObj, 0x158

glabel AI_SetupOncomingLaneDemerits__FP8Car_tObj
    /* 48E94 80058694 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 48E98 80058698 1000B0AF */  sw         $s0, 0x10($sp)
    /* 48E9C 8005869C 21808000 */  addu       $s0, $a0, $zero
    /* 48EA0 800586A0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 48EA4 800586A4 8A69010C */  jal        AI_IsMellowZone__FP8Car_tObji
    /* 48EA8 800586A8 3C00053C */   lui       $a1, (0x3C0000 >> 16)
    /* 48EAC 800586AC 4B004014 */  bnez       $v0, .L800587DC
    /* 48EB0 800586B0 00000000 */   nop
    /* 48EB4 800586B4 6002028E */  lw         $v0, 0x260($s0)
    /* 48EB8 800586B8 00000000 */  nop
    /* 48EBC 800586BC 10004230 */  andi       $v0, $v0, 0x10
    /* 48EC0 800586C0 02004010 */  beqz       $v0, .L800586CC
    /* 48EC4 800586C4 FCFF043C */   lui       $a0, (0xFFFC0000 >> 16)
    /* 48EC8 800586C8 F4FF043C */  lui        $a0, (0xFFF40000 >> 16)
  .L800586CC:
    /* 48ECC 800586CC 1480023C */  lui        $v0, %hi(Cars_gNumTrafficCars)
    /* 48ED0 800586D0 08C8428C */  lw         $v0, %lo(Cars_gNumTrafficCars)($v0)
    /* 48ED4 800586D4 00000000 */  nop
    /* 48ED8 800586D8 06004014 */  bnez       $v0, .L800586F4
    /* 48EDC 800586DC 00000000 */   nop
    /* 48EE0 800586E0 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 48EE4 800586E4 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 48EE8 800586E8 00000000 */  nop
    /* 48EEC 800586EC 3B004010 */  beqz       $v0, .L800587DC
    /* 48EF0 800586F0 00000000 */   nop
  .L800586F4:
    /* 48EF4 800586F4 1480023C */  lui        $v0, %hi(AITune_oneWay)
    /* 48EF8 800586F8 F0C5428C */  lw         $v0, %lo(AITune_oneWay)($v0)
    /* 48EFC 800586FC 00000000 */  nop
    /* 48F00 80058700 36004014 */  bnez       $v0, .L800587DC
    /* 48F04 80058704 00000000 */   nop
    /* 48F08 80058708 7005028E */  lw         $v0, 0x570($s0)
    /* 48F0C 8005870C 00000000 */  nop
    /* 48F10 80058710 02004230 */  andi       $v0, $v0, 0x2
    /* 48F14 80058714 31004014 */  bnez       $v0, .L800587DC
    /* 48F18 80058718 00000000 */   nop
    /* 48F1C 8005871C 5405038E */  lw         $v1, 0x554($s0)
    /* 48F20 80058720 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 48F24 80058724 F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 48F28 80058728 00000000 */  nop
    /* 48F2C 8005872C 16006214 */  bne        $v1, $v0, .L80058788
    /* 48F30 80058730 00000000 */   nop
    /* 48F34 80058734 C406028E */  lw         $v0, 0x6C4($s0)
    /* 48F38 80058738 00000000 */  nop
    /* 48F3C 8005873C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 48F40 80058740 07004228 */  slti       $v0, $v0, 0x7
    /* 48F44 80058744 05004010 */  beqz       $v0, .L8005875C
    /* 48F48 80058748 1180033C */   lui       $v1, %hi(CarLogic_gObs)
    /* 48F4C 8005874C E4CC628C */  lw         $v0, %lo(CarLogic_gObs)($v1)
    /* 48F50 80058750 00000000 */  nop
    /* 48F54 80058754 21104400 */  addu       $v0, $v0, $a0
    /* 48F58 80058758 E4CC62AC */  sw         $v0, %lo(CarLogic_gObs)($v1)
  .L8005875C:
    /* 48F5C 8005875C C406028E */  lw         $v0, 0x6C4($s0)
    /* 48F60 80058760 00000000 */  nop
    /* 48F64 80058764 07004228 */  slti       $v0, $v0, 0x7
    /* 48F68 80058768 1C004010 */  beqz       $v0, .L800587DC
    /* 48F6C 8005876C 1180033C */   lui       $v1, %hi(CarLogic_gObs)
    /* 48F70 80058770 E4CC6324 */  addiu      $v1, $v1, %lo(CarLogic_gObs)
    /* 48F74 80058774 0400628C */  lw         $v0, 0x4($v1)
    /* 48F78 80058778 00000000 */  nop
    /* 48F7C 8005877C 21104400 */  addu       $v0, $v0, $a0
    /* 48F80 80058780 F7610108 */  j          .L800587DC
    /* 48F84 80058784 040062AC */   sw        $v0, 0x4($v1)
  .L80058788:
    /* 48F88 80058788 C406028E */  lw         $v0, 0x6C4($s0)
    /* 48F8C 8005878C 00000000 */  nop
    /* 48F90 80058790 07004228 */  slti       $v0, $v0, 0x7
    /* 48F94 80058794 06004014 */  bnez       $v0, .L800587B0
    /* 48F98 80058798 1180033C */   lui       $v1, %hi(CarLogic_gObs)
    /* 48F9C 8005879C E4CC6324 */  addiu      $v1, $v1, %lo(CarLogic_gObs)
    /* 48FA0 800587A0 0400628C */  lw         $v0, 0x4($v1)
    /* 48FA4 800587A4 00000000 */  nop
    /* 48FA8 800587A8 21104400 */  addu       $v0, $v0, $a0
    /* 48FAC 800587AC 040062AC */  sw         $v0, 0x4($v1)
  .L800587B0:
    /* 48FB0 800587B0 C406028E */  lw         $v0, 0x6C4($s0)
    /* 48FB4 800587B4 00000000 */  nop
    /* 48FB8 800587B8 01004224 */  addiu      $v0, $v0, 0x1
    /* 48FBC 800587BC 07004228 */  slti       $v0, $v0, 0x7
    /* 48FC0 800587C0 06004014 */  bnez       $v0, .L800587DC
    /* 48FC4 800587C4 1180033C */   lui       $v1, %hi(CarLogic_gObs)
    /* 48FC8 800587C8 E4CC6324 */  addiu      $v1, $v1, %lo(CarLogic_gObs)
    /* 48FCC 800587CC 0800628C */  lw         $v0, 0x8($v1)
    /* 48FD0 800587D0 00000000 */  nop
    /* 48FD4 800587D4 21104400 */  addu       $v0, $v0, $a0
    /* 48FD8 800587D8 080062AC */  sw         $v0, 0x8($v1)
  .L800587DC:
    /* 48FDC 800587DC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 48FE0 800587E0 1000B08F */  lw         $s0, 0x10($sp)
    /* 48FE4 800587E4 0800E003 */  jr         $ra
    /* 48FE8 800587E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_SetupOncomingLaneDemerits__FP8Car_tObj
