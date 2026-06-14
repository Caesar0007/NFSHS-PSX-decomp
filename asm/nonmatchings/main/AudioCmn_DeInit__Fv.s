.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_DeInit__Fv, 0xD8

glabel AudioCmn_DeInit__Fv
    /* 67744 80076F44 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 67748 80076F48 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6774C 80076F4C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 67750 80076F50 1400B1AF */  sw         $s1, 0x14($sp)
    /* 67754 80076F54 16F1010C */  jal        AudioEng_StopServer__Fv
    /* 67758 80076F58 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6775C 80076F5C 4DF1010C */  jal        AudioEng_CleanUp__Fv
    /* 67760 80076F60 21880000 */   addu      $s1, $zero, $zero
    /* 67764 80076F64 AF66020C */  jal        CopSpeak_Stop__Fv
    /* 67768 80076F68 FFFF1224 */   addiu     $s2, $zero, -0x1
    /* 6776C 80076F6C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 67770 80076F70 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 67774 80076F74 F400438C */  lw         $v1, 0xF4($v0)
    /* 67778 80076F78 F000428C */  lw         $v0, 0xF0($v0)
    /* 6777C 80076F7C 080183AF */  sw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 67780 80076F80 040182AF */  sw         $v0, %gp_rel(gMasterMusicLevel)($gp)
    /* 67784 80076F84 4BF5010C */  jal        AudioTrk_CleanUp__Fv
    /* 67788 80076F88 00000000 */   nop
    /* 6778C 80076F8C 8FD9010C */  jal        AudioCmn_DeInitAsyncSfx__Fv
    /* 67790 80076F90 00000000 */   nop
    /* 67794 80076F94 1180023C */  lui        $v0, %hi(gaChannel)
    /* 67798 80076F98 FCE85024 */  addiu      $s0, $v0, %lo(gaChannel)
  .L80076F9C:
    /* 6779C 80076F9C 0000048E */  lw         $a0, 0x0($s0)
    /* 677A0 80076FA0 00000000 */  nop
    /* 677A4 80076FA4 05009210 */  beq        $a0, $s2, .L80076FBC
    /* 677A8 80076FA8 00000000 */   nop
    /* 677AC 80076FAC A09F030C */  jal        SNDstop
    /* 677B0 80076FB0 00000000 */   nop
    /* 677B4 80076FB4 000012AE */  sw         $s2, 0x0($s0)
    /* 677B8 80076FB8 040012AE */  sw         $s2, 0x4($s0)
  .L80076FBC:
    /* 677BC 80076FBC 01003126 */  addiu      $s1, $s1, 0x1
    /* 677C0 80076FC0 4700222A */  slti       $v0, $s1, 0x47
    /* 677C4 80076FC4 F5FF4014 */  bnez       $v0, .L80076F9C
    /* 677C8 80076FC8 08001026 */   addiu     $s0, $s0, 0x8
    /* 677CC 80076FCC 6AA0030C */  jal        SNDstopall
    /* 677D0 80076FD0 00000000 */   nop
    /* 677D4 80076FD4 9D99030C */  jal        SNDbankremove
    /* 677D8 80076FD8 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 677DC 80076FDC 30EF020C */  jal        Audio_CleanUp__Fv
    /* 677E0 80076FE0 00000000 */   nop
    /* 677E4 80076FE4 2C018293 */  lbu        $v0, %gp_rel(fReverbOn)($gp)
    /* 677E8 80076FE8 00000000 */  nop
    /* 677EC 80076FEC 03004010 */  beqz       $v0, .L80076FFC
    /* 677F0 80076FF0 00000000 */   nop
    /* 677F4 80076FF4 B3E7010C */  jal        AudioCmn_ReverbOff__Fv
    /* 677F8 80076FF8 00000000 */   nop
  .L80076FFC:
    /* 677FC 80076FFC 2001828F */  lw         $v0, %gp_rel(gFEmusicON)($gp)
    /* 67800 80077000 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 67804 80077004 1800B28F */  lw         $s2, 0x18($sp)
    /* 67808 80077008 1400B18F */  lw         $s1, 0x14($sp)
    /* 6780C 8007700C 1000B08F */  lw         $s0, 0x10($sp)
    /* 67810 80077010 FC0082AF */  sw         $v0, %gp_rel(AudioCmn_kAudioStreamingOn)($gp)
    /* 67814 80077014 0800E003 */  jr         $ra
    /* 67818 80077018 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_DeInit__Fv
