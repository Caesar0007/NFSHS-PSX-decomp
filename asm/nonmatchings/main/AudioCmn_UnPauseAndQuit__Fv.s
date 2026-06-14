.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_UnPauseAndQuit__Fv, 0xE8

glabel AudioCmn_UnPauseAndQuit__Fv
    /* 6A4A4 80079CA4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6A4A8 80079CA8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6A4AC 80079CAC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6A4B0 80079CB0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6A4B4 80079CB4 1000B0AF */  sw         $s0, 0x10($sp)
  .L80079CB8:
    /* 6A4B8 80079CB8 8C01848F */  lw         $a0, %gp_rel(AudioCmn_gCursorSndHandle)($gp)
    /* 6A4BC 80079CBC C59E030C */  jal        SNDover
    /* 6A4C0 80079CC0 00000000 */   nop
    /* 6A4C4 80079CC4 05004014 */  bnez       $v0, .L80079CDC
    /* 6A4C8 80079CC8 00000000 */   nop
    /* 6A4CC 80079CCC 019B030C */  jal        systemtask
    /* 6A4D0 80079CD0 21200000 */   addu      $a0, $zero, $zero
    /* 6A4D4 80079CD4 2EE70108 */  j          .L80079CB8
    /* 6A4D8 80079CD8 00000000 */   nop
  .L80079CDC:
    /* 6A4DC 80079CDC AF66020C */  jal        CopSpeak_Stop__Fv
    /* 6A4E0 80079CE0 21880000 */   addu      $s1, $zero, $zero
    /* 6A4E4 80079CE4 FC9F030C */  jal        SNDmastervol
    /* 6A4E8 80079CE8 21200000 */   addu      $a0, $zero, $zero
    /* 6A4EC 80079CEC 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 6A4F0 80079CF0 21200000 */   addu      $a0, $zero, $zero
    /* 6A4F4 80079CF4 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 6A4F8 80079CF8 1180023C */  lui        $v0, %hi(gaChannel)
    /* 6A4FC 80079CFC FCE85024 */  addiu      $s0, $v0, %lo(gaChannel)
  .L80079D00:
    /* 6A500 80079D00 0000048E */  lw         $a0, 0x0($s0)
    /* 6A504 80079D04 00000000 */  nop
    /* 6A508 80079D08 05009210 */  beq        $a0, $s2, .L80079D20
    /* 6A50C 80079D0C 00000000 */   nop
    /* 6A510 80079D10 A09F030C */  jal        SNDstop
    /* 6A514 80079D14 00000000 */   nop
    /* 6A518 80079D18 000012AE */  sw         $s2, 0x0($s0)
    /* 6A51C 80079D1C 040012AE */  sw         $s2, 0x4($s0)
  .L80079D20:
    /* 6A520 80079D20 01003126 */  addiu      $s1, $s1, 0x1
    /* 6A524 80079D24 4700222A */  slti       $v0, $s1, 0x47
    /* 6A528 80079D28 F5FF4014 */  bnez       $v0, .L80079D00
    /* 6A52C 80079D2C 08001026 */   addiu     $s0, $s0, 0x8
    /* 6A530 80079D30 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 6A534 80079D34 0801838F */  lw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 6A538 80079D38 0401848F */  lw         $a0, %gp_rel(gMasterMusicLevel)($gp)
    /* 6A53C 80079D3C 2C018593 */  lbu        $a1, %gp_rel(fReverbOn)($gp)
    /* 6A540 80079D40 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 6A544 80079D44 F40043AC */  sw         $v1, 0xF4($v0)
    /* 6A548 80079D48 0300A010 */  beqz       $a1, .L80079D58
    /* 6A54C 80079D4C F00044AC */   sw        $a0, 0xF0($v0)
    /* 6A550 80079D50 B3E7010C */  jal        AudioCmn_ReverbOff__Fv
    /* 6A554 80079D54 00000000 */   nop
  .L80079D58:
    /* 6A558 80079D58 21800000 */  addu       $s0, $zero, $zero
  .L80079D5C:
    /* 6A55C 80079D5C FC9F030C */  jal        SNDmastervol
    /* 6A560 80079D60 21200002 */   addu      $a0, $s0, $zero
    /* 6A564 80079D64 01001026 */  addiu      $s0, $s0, 0x1
    /* 6A568 80079D68 8000022A */  slti       $v0, $s0, 0x80
    /* 6A56C 80079D6C FBFF4014 */  bnez       $v0, .L80079D5C
    /* 6A570 80079D70 00000000 */   nop
    /* 6A574 80079D74 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6A578 80079D78 1800B28F */  lw         $s2, 0x18($sp)
    /* 6A57C 80079D7C 1400B18F */  lw         $s1, 0x14($sp)
    /* 6A580 80079D80 1000B08F */  lw         $s0, 0x10($sp)
    /* 6A584 80079D84 0800E003 */  jr         $ra
    /* 6A588 80079D88 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_UnPauseAndQuit__Fv
