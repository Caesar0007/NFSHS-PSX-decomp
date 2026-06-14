.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_Pause__Fv, 0xB8

glabel AudioCmn_Pause__Fv
    /* 6A360 80079B60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6A364 80079B64 21200000 */  addu       $a0, $zero, $zero
    /* 6A368 80079B68 21288000 */  addu       $a1, $a0, $zero
    /* 6A36C 80079B6C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6A370 80079B70 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6A374 80079B74 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6A378 80079B78 8865020C */  jal        CopSpeak_SilenceCop__FP8Car_tObji
    /* 6A37C 80079B7C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6A380 80079B80 21880000 */  addu       $s1, $zero, $zero
    /* 6A384 80079B84 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 6A388 80079B88 1180023C */  lui        $v0, %hi(gaChannel)
    /* 6A38C 80079B8C FCE85024 */  addiu      $s0, $v0, %lo(gaChannel)
  .L80079B90:
    /* 6A390 80079B90 0000048E */  lw         $a0, 0x0($s0)
    /* 6A394 80079B94 00000000 */  nop
    /* 6A398 80079B98 03009210 */  beq        $a0, $s2, .L80079BA8
    /* 6A39C 80079B9C 00000000 */   nop
    /* 6A3A0 80079BA0 A59A030C */  jal        SNDvol
    /* 6A3A4 80079BA4 21280000 */   addu      $a1, $zero, $zero
  .L80079BA8:
    /* 6A3A8 80079BA8 01003126 */  addiu      $s1, $s1, 0x1
    /* 6A3AC 80079BAC 4700222A */  slti       $v0, $s1, 0x47
    /* 6A3B0 80079BB0 F7FF4014 */  bnez       $v0, .L80079B90
    /* 6A3B4 80079BB4 08001026 */   addiu     $s0, $s0, 0x8
    /* 6A3B8 80079BB8 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 6A3BC 80079BBC 21200000 */   addu      $a0, $zero, $zero
    /* 6A3C0 80079BC0 2C018293 */  lbu        $v0, %gp_rel(fReverbOn)($gp)
    /* 6A3C4 80079BC4 00000000 */  nop
    /* 6A3C8 80079BC8 03004010 */  beqz       $v0, .L80079BD8
    /* 6A3CC 80079BCC 00000000 */   nop
    /* 6A3D0 80079BD0 B3E7010C */  jal        AudioCmn_ReverbOff__Fv
    /* 6A3D4 80079BD4 00000000 */   nop
  .L80079BD8:
    /* 6A3D8 80079BD8 1FF1010C */  jal        AudioEng_Pause__Fv
    /* 6A3DC 80079BDC 00000000 */   nop
    /* 6A3E0 80079BE0 6AA0030C */  jal        SNDstopall
    /* 6A3E4 80079BE4 00000000 */   nop
    /* 6A3E8 80079BE8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 6A3EC 80079BEC EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 6A3F0 80079BF0 F400438C */  lw         $v1, 0xF4($v0)
    /* 6A3F4 80079BF4 F000428C */  lw         $v0, 0xF0($v0)
    /* 6A3F8 80079BF8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6A3FC 80079BFC 1800B28F */  lw         $s2, 0x18($sp)
    /* 6A400 80079C00 1400B18F */  lw         $s1, 0x14($sp)
    /* 6A404 80079C04 1000B08F */  lw         $s0, 0x10($sp)
    /* 6A408 80079C08 080183AF */  sw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 6A40C 80079C0C 040182AF */  sw         $v0, %gp_rel(gMasterMusicLevel)($gp)
    /* 6A410 80079C10 0800E003 */  jr         $ra
    /* 6A414 80079C14 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_Pause__Fv
