.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_PreLoad__Fv, 0x1D0

glabel AudioTrk_PreLoad__Fv
    /* 6DB5C 8007D35C 1480023C */  lui        $v0, %hi(gGameAudioList)
    /* 6DB60 8007D360 30C7428C */  lw         $v0, %lo(gGameAudioList)($v0)
    /* 6DB64 8007D364 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 6DB68 8007D368 3800BFAF */  sw         $ra, 0x38($sp)
    /* 6DB6C 8007D36C 3400B7AF */  sw         $s7, 0x34($sp)
    /* 6DB70 8007D370 3000B6AF */  sw         $s6, 0x30($sp)
    /* 6DB74 8007D374 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 6DB78 8007D378 2800B4AF */  sw         $s4, 0x28($sp)
    /* 6DB7C 8007D37C 2400B3AF */  sw         $s3, 0x24($sp)
    /* 6DB80 8007D380 2000B2AF */  sw         $s2, 0x20($sp)
    /* 6DB84 8007D384 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 6DB88 8007D388 06004010 */  beqz       $v0, .L8007D3A4
    /* 6DB8C 8007D38C 1800B0AF */   sw        $s0, 0x18($sp)
    /* 6DB90 8007D390 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 6DB94 8007D394 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 6DB98 8007D398 00000000 */  nop
    /* 6DB9C 8007D39C 03004014 */  bnez       $v0, .L8007D3AC
    /* 6DBA0 8007D3A0 00000000 */   nop
  .L8007D3A4:
    /* 6DBA4 8007D3A4 40F50108 */  j          .L8007D500
    /* 6DBA8 8007D3A8 01000224 */   addiu     $v0, $zero, 0x1
  .L8007D3AC:
    /* 6DBAC 8007D3AC 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 6DBB0 8007D3B0 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 6DBB4 8007D3B4 00000000 */  nop
    /* 6DBB8 8007D3B8 0000558C */  lw         $s5, 0x0($v0)
    /* 6DBBC 8007D3BC 0800548C */  lw         $s4, 0x8($v0)
    /* 6DBC0 8007D3C0 88A0030C */  jal        gettick
    /* 6DBC4 8007D3C4 21980000 */   addu      $s3, $zero, $zero
    /* 6DBC8 8007D3C8 1480033C */  lui        $v1, %hi(gGameAudioList)
    /* 6DBCC 8007D3CC 30C7638C */  lw         $v1, %lo(gGameAudioList)($v1)
    /* 6DBD0 8007D3D0 80025724 */  addiu      $s7, $v0, 0x280
    /* 6DBD4 8007D3D4 0400768C */  lw         $s6, 0x4($v1)
    /* 6DBD8 8007D3D8 21800000 */  addu       $s0, $zero, $zero
  .L8007D3DC:
    /* 6DBDC 8007D3DC 0A006016 */  bnez       $s3, .L8007D408
    /* 6DBE0 8007D3E0 00000000 */   nop
    /* 6DBE4 8007D3E4 88A0030C */  jal        gettick
    /* 6DBE8 8007D3E8 00000000 */   nop
    /* 6DBEC 8007D3EC 2A105700 */  slt        $v0, $v0, $s7
    /* 6DBF0 8007D3F0 05004010 */  beqz       $v0, .L8007D408
    /* 6DBF4 8007D3F4 00000000 */   nop
    /* 6DBF8 8007D3F8 3B9F030C */  jal        SNDmemlargestunused
    /* 6DBFC 8007D3FC 1000A427 */   addiu     $a0, $sp, 0x10
    /* 6DC00 8007D400 00800334 */  ori        $v1, $zero, 0x8000
    /* 6DC04 8007D404 2A806200 */  slt        $s0, $v1, $v0
  .L8007D408:
    /* 6DC08 8007D408 3A000012 */  beqz       $s0, .L8007D4F4
    /* 6DC0C 8007D40C 01001324 */   addiu     $s3, $zero, 0x1
    /* 6DC10 8007D410 1480023C */  lui        $v0, %hi(gGameAudioList)
    /* 6DC14 8007D414 30C7428C */  lw         $v0, %lo(gGameAudioList)($v0)
    /* 6DC18 8007D418 21900000 */  addu       $s2, $zero, $zero
    /* 6DC1C 8007D41C 10005124 */  addiu      $s1, $v0, 0x10
    /* 6DC20 8007D420 1E005024 */  addiu      $s0, $v0, 0x1E
  .L8007D424:
    /* 6DC24 8007D424 2A105602 */  slt        $v0, $s2, $s6
    /* 6DC28 8007D428 2C004010 */  beqz       $v0, .L8007D4DC
    /* 6DC2C 8007D42C 00000000 */   nop
    /* 6DC30 8007D430 0000228E */  lw         $v0, 0x0($s1)
    /* 6DC34 8007D434 00000000 */  nop
    /* 6DC38 8007D438 23205500 */  subu       $a0, $v0, $s5
    /* 6DC3C 8007D43C 0200801C */  bgtz       $a0, .L8007D448
    /* 6DC40 8007D440 00000000 */   nop
    /* 6DC44 8007D444 2320A202 */  subu       $a0, $s5, $v0
  .L8007D448:
    /* 6DC48 8007D448 FAFF028E */  lw         $v0, -0x6($s0)
    /* 6DC4C 8007D44C 00000000 */  nop
    /* 6DC50 8007D450 23185400 */  subu       $v1, $v0, $s4
    /* 6DC54 8007D454 0200601C */  bgtz       $v1, .L8007D460
    /* 6DC58 8007D458 00000000 */   nop
    /* 6DC5C 8007D45C 23188202 */  subu       $v1, $s4, $v0
  .L8007D460:
    /* 6DC60 8007D460 2A106400 */  slt        $v0, $v1, $a0
    /* 6DC64 8007D464 03004010 */  beqz       $v0, .L8007D474
    /* 6DC68 8007D468 83100300 */   sra       $v0, $v1, 2
    /* 6DC6C 8007D46C 1FF50108 */  j          .L8007D47C
    /* 6DC70 8007D470 21188200 */   addu      $v1, $a0, $v0
  .L8007D474:
    /* 6DC74 8007D474 83100400 */  sra        $v0, $a0, 2
    /* 6DC78 8007D478 21186200 */  addu       $v1, $v1, $v0
  .L8007D47C:
    /* 6DC7C 8007D47C 02000286 */  lh         $v0, 0x2($s0)
    /* 6DC80 8007D480 00000000 */  nop
    /* 6DC84 8007D484 64004224 */  addiu      $v0, $v0, 0x64
    /* 6DC88 8007D488 00140200 */  sll        $v0, $v0, 16
    /* 6DC8C 8007D48C 2A106200 */  slt        $v0, $v1, $v0
    /* 6DC90 8007D490 0E004010 */  beqz       $v0, .L8007D4CC
    /* 6DC94 8007D494 00000000 */   nop
    /* 6DC98 8007D498 00000592 */  lbu        $a1, 0x0($s0)
    /* 6DC9C 8007D49C 1480023C */  lui        $v0, %hi(CopSpeak_gNumTrackSfx)
    /* 6DCA0 8007D4A0 D4D0428C */  lw         $v0, %lo(CopSpeak_gNumTrackSfx)($v0)
    /* 6DCA4 8007D4A4 00000000 */  nop
    /* 6DCA8 8007D4A8 2A10A200 */  slt        $v0, $a1, $v0
    /* 6DCAC 8007D4AC 07004010 */  beqz       $v0, .L8007D4CC
    /* 6DCB0 8007D4B0 21200000 */   addu      $a0, $zero, $zero
    /* 6DCB4 8007D4B4 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 6DCB8 8007D4B8 21308000 */   addu      $a2, $a0, $zero
    /* 6DCBC 8007D4BC FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 6DCC0 8007D4C0 02004314 */  bne        $v0, $v1, .L8007D4CC
    /* 6DCC4 8007D4C4 00000000 */   nop
    /* 6DCC8 8007D4C8 21980000 */  addu       $s3, $zero, $zero
  .L8007D4CC:
    /* 6DCCC 8007D4CC 18001026 */  addiu      $s0, $s0, 0x18
    /* 6DCD0 8007D4D0 18003126 */  addiu      $s1, $s1, 0x18
    /* 6DCD4 8007D4D4 09F50108 */  j          .L8007D424
    /* 6DCD8 8007D4D8 01005226 */   addiu     $s2, $s2, 0x1
  .L8007D4DC:
    /* 6DCDC 8007D4DC 656A020C */  jal        CopSpeak_Server__Fv
    /* 6DCE0 8007D4E0 21800000 */   addu      $s0, $zero, $zero
    /* 6DCE4 8007D4E4 019B030C */  jal        systemtask
    /* 6DCE8 8007D4E8 21200000 */   addu      $a0, $zero, $zero
    /* 6DCEC 8007D4EC F7F40108 */  j          .L8007D3DC
    /* 6DCF0 8007D4F0 00000000 */   nop
  .L8007D4F4:
    /* 6DCF4 8007D4F4 88A0030C */  jal        gettick
    /* 6DCF8 8007D4F8 00000000 */   nop
    /* 6DCFC 8007D4FC 2A105700 */  slt        $v0, $v0, $s7
  .L8007D500:
    /* 6DD00 8007D500 3800BF8F */  lw         $ra, 0x38($sp)
    /* 6DD04 8007D504 3400B78F */  lw         $s7, 0x34($sp)
    /* 6DD08 8007D508 3000B68F */  lw         $s6, 0x30($sp)
    /* 6DD0C 8007D50C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 6DD10 8007D510 2800B48F */  lw         $s4, 0x28($sp)
    /* 6DD14 8007D514 2400B38F */  lw         $s3, 0x24($sp)
    /* 6DD18 8007D518 2000B28F */  lw         $s2, 0x20($sp)
    /* 6DD1C 8007D51C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 6DD20 8007D520 1800B08F */  lw         $s0, 0x18($sp)
    /* 6DD24 8007D524 0800E003 */  jr         $ra
    /* 6DD28 8007D528 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel AudioTrk_PreLoad__Fv
