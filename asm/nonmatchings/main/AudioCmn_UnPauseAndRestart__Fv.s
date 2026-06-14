.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_UnPauseAndRestart__Fv, 0xFC

glabel AudioCmn_UnPauseAndRestart__Fv
    /* 6A58C 80079D8C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6A590 80079D90 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6A594 80079D94 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6A598 80079D98 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6A59C 80079D9C 389D030C */  jal        SPCH_ClearEventQueue
    /* 6A5A0 80079DA0 1000B0AF */   sw        $s0, 0x10($sp)
  .L80079DA4:
    /* 6A5A4 80079DA4 8C01848F */  lw         $a0, %gp_rel(AudioCmn_gCursorSndHandle)($gp)
    /* 6A5A8 80079DA8 C59E030C */  jal        SNDover
    /* 6A5AC 80079DAC 00000000 */   nop
    /* 6A5B0 80079DB0 05004014 */  bnez       $v0, .L80079DC8
    /* 6A5B4 80079DB4 00000000 */   nop
    /* 6A5B8 80079DB8 019B030C */  jal        systemtask
    /* 6A5BC 80079DBC 21200000 */   addu      $a0, $zero, $zero
    /* 6A5C0 80079DC0 69E70108 */  j          .L80079DA4
    /* 6A5C4 80079DC4 00000000 */   nop
  .L80079DC8:
    /* 6A5C8 80079DC8 8766020C */  jal        CopSpeak_Cancel__Fv
    /* 6A5CC 80079DCC 21880000 */   addu      $s1, $zero, $zero
    /* 6A5D0 80079DD0 FC9F030C */  jal        SNDmastervol
    /* 6A5D4 80079DD4 21200000 */   addu      $a0, $zero, $zero
    /* 6A5D8 80079DD8 8FD9010C */  jal        AudioCmn_DeInitAsyncSfx__Fv
    /* 6A5DC 80079DDC FFFF1224 */   addiu     $s2, $zero, -0x1
    /* 6A5E0 80079DE0 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 6A5E4 80079DE4 21200000 */   addu      $a0, $zero, $zero
    /* 6A5E8 80079DE8 1180023C */  lui        $v0, %hi(gaChannel)
    /* 6A5EC 80079DEC FCE85024 */  addiu      $s0, $v0, %lo(gaChannel)
  .L80079DF0:
    /* 6A5F0 80079DF0 0000048E */  lw         $a0, 0x0($s0)
    /* 6A5F4 80079DF4 00000000 */  nop
    /* 6A5F8 80079DF8 05009210 */  beq        $a0, $s2, .L80079E10
    /* 6A5FC 80079DFC 00000000 */   nop
    /* 6A600 80079E00 A09F030C */  jal        SNDstop
    /* 6A604 80079E04 00000000 */   nop
    /* 6A608 80079E08 000012AE */  sw         $s2, 0x0($s0)
    /* 6A60C 80079E0C 040012AE */  sw         $s2, 0x4($s0)
  .L80079E10:
    /* 6A610 80079E10 01003126 */  addiu      $s1, $s1, 0x1
    /* 6A614 80079E14 4700222A */  slti       $v0, $s1, 0x47
    /* 6A618 80079E18 F5FF4014 */  bnez       $v0, .L80079DF0
    /* 6A61C 80079E1C 08001026 */   addiu     $s0, $s0, 0x8
    /* 6A620 80079E20 21800000 */  addu       $s0, $zero, $zero
  .L80079E24:
    /* 6A624 80079E24 FC9F030C */  jal        SNDmastervol
    /* 6A628 80079E28 21200002 */   addu      $a0, $s0, $zero
    /* 6A62C 80079E2C 01001026 */  addiu      $s0, $s0, 0x1
    /* 6A630 80079E30 8000022A */  slti       $v0, $s0, 0x80
    /* 6A634 80079E34 FBFF4014 */  bnez       $v0, .L80079E24
    /* 6A638 80079E38 00000000 */   nop
    /* 6A63C 80079E3C 2C018293 */  lbu        $v0, %gp_rel(fReverbOn)($gp)
    /* 6A640 80079E40 00000000 */  nop
    /* 6A644 80079E44 04004010 */  beqz       $v0, .L80079E58
    /* 6A648 80079E48 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 6A64C 80079E4C B3E7010C */  jal        AudioCmn_ReverbOff__Fv
    /* 6A650 80079E50 00000000 */   nop
    /* 6A654 80079E54 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L80079E58:
    /* 6A658 80079E58 0801838F */  lw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 6A65C 80079E5C 0401848F */  lw         $a0, %gp_rel(gMasterMusicLevel)($gp)
    /* 6A660 80079E60 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 6A664 80079E64 F40043AC */  sw         $v1, 0xF4($v0)
    /* 6A668 80079E68 9DDA010C */  jal        AudioCmn_Init__Fv
    /* 6A66C 80079E6C F00044AC */   sw        $a0, 0xF0($v0)
    /* 6A670 80079E70 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6A674 80079E74 1800B28F */  lw         $s2, 0x18($sp)
    /* 6A678 80079E78 1400B18F */  lw         $s1, 0x14($sp)
    /* 6A67C 80079E7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 6A680 80079E80 0800E003 */  jr         $ra
    /* 6A684 80079E84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_UnPauseAndRestart__Fv
