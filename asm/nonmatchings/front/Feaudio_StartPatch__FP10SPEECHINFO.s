.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Feaudio_StartPatch__FP10SPEECHINFO, 0x124

glabel Feaudio_StartPatch__FP10SPEECHINFO
    /* 6024 80015824 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6028 80015828 2800B0AF */  sw         $s0, 0x28($sp)
    /* 602C 8001582C 21808000 */  addu       $s0, $a0, $zero
    /* 6030 80015830 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 6034 80015834 1800058E */  lw         $a1, 0x18($s0)
    /* 6038 80015838 00000000 */  nop
    /* 603C 8001583C 3E00A010 */  beqz       $a1, .L80015938
    /* 6040 80015840 00000000 */   nop
    /* 6044 80015844 7B9F030C */  jal        SNDbankadd
    /* 6048 80015848 08000426 */   addiu     $a0, $s0, 0x8
    /* 604C 8001584C 07000324 */  addiu      $v1, $zero, 0x7
    /* 6050 80015850 15004314 */  bne        $v0, $v1, .L800158A8
    /* 6054 80015854 00000000 */   nop
    /* 6058 80015858 0800048E */  lw         $a0, 0x8($s0)
    /* 605C 8001585C D99E030C */  jal        SNDbankheadersize
    /* 6060 80015860 00000000 */   nop
    /* 6064 80015864 0180043C */  lui        $a0, %hi(D_80010104)
    /* 6068 80015868 04018424 */  addiu      $a0, $a0, %lo(D_80010104)
    /* 606C 8001586C 21284000 */  addu       $a1, $v0, $zero
    /* 6070 80015870 CF94030C */  jal        reservememadr
    /* 6074 80015874 10000624 */   addiu     $a2, $zero, 0x10
    /* 6078 80015878 0800058E */  lw         $a1, 0x8($s0)
    /* 607C 8001587C 21204000 */  addu       $a0, $v0, $zero
    /* 6080 80015880 EA9E030C */  jal        SNDbankheadercopy
    /* 6084 80015884 140004AE */   sw        $a0, 0x14($s0)
    /* 6088 80015888 1800048E */  lw         $a0, 0x18($s0)
    /* 608C 8001588C 00000000 */  nop
    /* 6090 80015890 08008010 */  beqz       $a0, .L800158B4
    /* 6094 80015894 00000000 */   nop
    /* 6098 80015898 5095030C */  jal        purgememadr
    /* 609C 8001589C 00000000 */   nop
    /* 60A0 800158A0 2D560008 */  j          .L800158B4
    /* 60A4 800158A4 180000AE */   sw        $zero, 0x18($s0)
  .L800158A8:
    /* 60A8 800158A8 1800028E */  lw         $v0, 0x18($s0)
    /* 60AC 800158AC 180000AE */  sw         $zero, 0x18($s0)
    /* 60B0 800158B0 1C0002AE */  sw         $v0, 0x1C($s0)
  .L800158B4:
    /* 60B4 800158B4 0D9A030C */  jal        SNDplaysetdef
    /* 60B8 800158B8 1000A427 */   addiu     $a0, $sp, 0x10
    /* 60BC 800158BC 0580023C */  lui        $v0, %hi(commentaryActualLevel)
    /* 60C0 800158C0 08000392 */  lbu        $v1, 0x8($s0)
    /* 60C4 800158C4 38154290 */  lbu        $v0, %lo(commentaryActualLevel)($v0)
    /* 60C8 800158C8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 60CC 800158CC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 60D0 800158D0 1400A3A3 */  sb         $v1, 0x14($sp)
    /* 60D4 800158D4 8C9E030C */  jal        SNDplay
    /* 60D8 800158D8 1800A2A3 */   sb        $v0, 0x18($sp)
    /* 60DC 800158DC 0400038E */  lw         $v1, 0x4($s0)
    /* 60E0 800158E0 0C0002AE */  sw         $v0, 0xC($s0)
    /* 60E4 800158E4 01000224 */  addiu      $v0, $zero, 0x1
    /* 60E8 800158E8 13006010 */  beqz       $v1, .L80015938
    /* 60EC 800158EC 110002A2 */   sb        $v0, 0x11($s0)
    /* 60F0 800158F0 02000292 */  lbu        $v0, 0x2($s0)
    /* 60F4 800158F4 00000000 */  nop
    /* 60F8 800158F8 7A00422C */  sltiu      $v0, $v0, 0x7A
    /* 60FC 800158FC 0C004010 */  beqz       $v0, .L80015930
    /* 6100 80015900 0580023C */   lui       $v0, %hi(gCurrentVIV)
    /* 6104 80015904 CC144390 */  lbu        $v1, %lo(gCurrentVIV)($v0)
    /* 6108 80015908 00000000 */  nop
    /* 610C 8001590C 01006324 */  addiu      $v1, $v1, 0x1
    /* 6110 80015910 CC1443A0 */  sb         $v1, %lo(gCurrentVIV)($v0)
    /* 6114 80015914 02000292 */  lbu        $v0, 0x2($s0)
    /* 6118 80015918 21200002 */  addu       $a0, $s0, $zero
    /* 611C 8001591C 01004224 */  addiu      $v0, $v0, 0x1
    /* 6120 80015920 E055000C */  jal        FEAudio_StartLoadPatch__FP10SPEECHINFO
    /* 6124 80015924 020082A0 */   sb        $v0, 0x2($a0)
    /* 6128 80015928 4E560008 */  j          .L80015938
    /* 612C 8001592C 00000000 */   nop
  .L80015930:
    /* 6130 80015930 100000A2 */  sb         $zero, 0x10($s0)
    /* 6134 80015934 120000A2 */  sb         $zero, 0x12($s0)
  .L80015938:
    /* 6138 80015938 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 613C 8001593C 2800B08F */  lw         $s0, 0x28($sp)
    /* 6140 80015940 0800E003 */  jr         $ra
    /* 6144 80015944 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Feaudio_StartPatch__FP10SPEECHINFO
