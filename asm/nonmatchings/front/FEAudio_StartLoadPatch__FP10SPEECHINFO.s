.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FEAudio_StartLoadPatch__FP10SPEECHINFO, 0xA4

glabel FEAudio_StartLoadPatch__FP10SPEECHINFO
    /* 5F80 80015780 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5F84 80015784 1800B0AF */  sw         $s0, 0x18($sp)
    /* 5F88 80015788 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 5F8C 8001578C 45D8030C */  jal        setclipwindow
    /* 5F90 80015790 21808000 */   addu      $s0, $a0, $zero
    /* 5F94 80015794 21280002 */  addu       $a1, $s0, $zero
    /* 5F98 80015798 1000A627 */  addiu      $a2, $sp, 0x10
    /* 5F9C 8001579C 0580023C */  lui        $v0, %hi(speechfileHeader)
    /* 5FA0 800157A0 0C15448C */  lw         $a0, %lo(speechfileHeader)($v0)
    /* 5FA4 800157A4 7357000C */  jal        FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
    /* 5FA8 800157A8 1400A727 */   addiu     $a3, $sp, 0x14
    /* 5FAC 800157AC 1000A28F */  lw         $v0, 0x10($sp)
    /* 5FB0 800157B0 00000000 */  nop
    /* 5FB4 800157B4 17004010 */  beqz       $v0, .L80015814
    /* 5FB8 800157B8 21100000 */   addu      $v0, $zero, $zero
    /* 5FBC 800157BC 1400A28F */  lw         $v0, 0x14($sp)
    /* 5FC0 800157C0 00000000 */  nop
    /* 5FC4 800157C4 13004010 */  beqz       $v0, .L80015814
    /* 5FC8 800157C8 21100000 */   addu      $v0, $zero, $zero
    /* 5FCC 800157CC 1800048E */  lw         $a0, 0x18($s0)
    /* 5FD0 800157D0 00000000 */  nop
    /* 5FD4 800157D4 04008010 */  beqz       $a0, .L800157E8
    /* 5FD8 800157D8 00000000 */   nop
    /* 5FDC 800157DC 5095030C */  jal        purgememadr
    /* 5FE0 800157E0 00000000 */   nop
    /* 5FE4 800157E4 180000AE */  sw         $zero, 0x18($s0)
  .L800157E8:
    /* 5FE8 800157E8 0580043C */  lui        $a0, %hi(currentSpeechViv)
    /* 5FEC 800157EC 10158424 */  addiu      $a0, $a0, %lo(currentSpeechViv)
    /* 5FF0 800157F0 1000A58F */  lw         $a1, 0x10($sp)
    /* 5FF4 800157F4 1400A68F */  lw         $a2, 0x14($sp)
    /* 5FF8 800157F8 4D57000C */  jal        FeAudio_StartBigfileRead__FPciiPi
    /* 5FFC 800157FC 20000726 */   addiu     $a3, $s0, 0x20
    /* 6000 80015800 180002AE */  sw         $v0, 0x18($s0)
    /* 6004 80015804 01000224 */  addiu      $v0, $zero, 0x1
    /* 6008 80015808 21184000 */  addu       $v1, $v0, $zero
    /* 600C 8001580C 100003A2 */  sb         $v1, 0x10($s0)
    /* 6010 80015810 120000A2 */  sb         $zero, 0x12($s0)
  .L80015814:
    /* 6014 80015814 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6018 80015818 1800B08F */  lw         $s0, 0x18($sp)
    /* 601C 8001581C 0800E003 */  jr         $ra
    /* 6020 80015820 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FEAudio_StartLoadPatch__FP10SPEECHINFO
