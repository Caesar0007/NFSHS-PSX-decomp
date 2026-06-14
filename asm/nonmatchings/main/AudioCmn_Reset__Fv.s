.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_Reset__Fv, 0x358

glabel AudioCmn_Reset__Fv
    /* 673EC 80076BEC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 673F0 80076BF0 21200000 */  addu       $a0, $zero, $zero
    /* 673F4 80076BF4 21288000 */  addu       $a1, $a0, $zero
    /* 673F8 80076BF8 3400BFAF */  sw         $ra, 0x34($sp)
    /* 673FC 80076BFC 3000B6AF */  sw         $s6, 0x30($sp)
    /* 67400 80076C00 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 67404 80076C04 2800B4AF */  sw         $s4, 0x28($sp)
    /* 67408 80076C08 2400B3AF */  sw         $s3, 0x24($sp)
    /* 6740C 80076C0C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 67410 80076C10 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 67414 80076C14 8865020C */  jal        CopSpeak_SilenceCop__FP8Car_tObji
    /* 67418 80076C18 1800B0AF */   sw        $s0, 0x18($sp)
    /* 6741C 80076C1C 8766020C */  jal        CopSpeak_Cancel__Fv
    /* 67420 80076C20 21880000 */   addu      $s1, $zero, $zero
    /* 67424 80076C24 389D030C */  jal        SPCH_ClearEventQueue
    /* 67428 80076C28 FFFF1224 */   addiu     $s2, $zero, -0x1
    /* 6742C 80076C2C 8FD9010C */  jal        AudioCmn_DeInitAsyncSfx__Fv
    /* 67430 80076C30 00000000 */   nop
    /* 67434 80076C34 1180023C */  lui        $v0, %hi(gaChannel)
    /* 67438 80076C38 FCE85024 */  addiu      $s0, $v0, %lo(gaChannel)
  .L80076C3C:
    /* 6743C 80076C3C 0000048E */  lw         $a0, 0x0($s0)
    /* 67440 80076C40 00000000 */  nop
    /* 67444 80076C44 05009210 */  beq        $a0, $s2, .L80076C5C
    /* 67448 80076C48 00000000 */   nop
    /* 6744C 80076C4C A09F030C */  jal        SNDstop
    /* 67450 80076C50 00000000 */   nop
    /* 67454 80076C54 000012AE */  sw         $s2, 0x0($s0)
    /* 67458 80076C58 040012AE */  sw         $s2, 0x4($s0)
  .L80076C5C:
    /* 6745C 80076C5C 01003126 */  addiu      $s1, $s1, 0x1
    /* 67460 80076C60 4700222A */  slti       $v0, $s1, 0x47
    /* 67464 80076C64 F5FF4014 */  bnez       $v0, .L80076C3C
    /* 67468 80076C68 08001026 */   addiu     $s0, $s0, 0x8
    /* 6746C 80076C6C 2C018293 */  lbu        $v0, %gp_rel(fReverbOn)($gp)
    /* 67470 80076C70 00000000 */  nop
    /* 67474 80076C74 03004010 */  beqz       $v0, .L80076C84
    /* 67478 80076C78 00000000 */   nop
    /* 6747C 80076C7C B3E7010C */  jal        AudioCmn_ReverbOff__Fv
    /* 67480 80076C80 00000000 */   nop
  .L80076C84:
    /* 67484 80076C84 9DDA010C */  jal        AudioCmn_Init__Fv
    /* 67488 80076C88 00000000 */   nop
    /* 6748C 80076C8C 1401828F */  lw         $v0, %gp_rel(gMasterAmbientLevel)($gp)
    /* 67490 80076C90 00000000 */  nop
    /* 67494 80076C94 55004018 */  blez       $v0, .L80076DEC
    /* 67498 80076C98 00000000 */   nop
    /* 6749C 80076C9C 88A0030C */  jal        gettick
    /* 674A0 80076CA0 21880000 */   addu      $s1, $zero, $zero
    /* 674A4 80076CA4 80025624 */  addiu      $s6, $v0, 0x280
    /* 674A8 80076CA8 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 674AC 80076CAC 1180153C */  lui        $s5, %hi(GameSetup_gData)
    /* 674B0 80076CB0 EC31B426 */  addiu      $s4, $s5, %lo(GameSetup_gData)
  .L80076CB4:
    /* 674B4 80076CB4 4D002016 */  bnez       $s1, .L80076DEC
    /* 674B8 80076CB8 00000000 */   nop
    /* 674BC 80076CBC 88A0030C */  jal        gettick
    /* 674C0 80076CC0 00000000 */   nop
    /* 674C4 80076CC4 2A105600 */  slt        $v0, $v0, $s6
    /* 674C8 80076CC8 48004010 */  beqz       $v0, .L80076DEC
    /* 674CC 80076CCC 00000000 */   nop
    /* 674D0 80076CD0 656A020C */  jal        CopSpeak_Server__Fv
    /* 674D4 80076CD4 01001124 */   addiu     $s1, $zero, 0x1
    /* 674D8 80076CD8 019B030C */  jal        systemtask
    /* 674DC 80076CDC 21200000 */   addu      $a0, $zero, $zero
    /* 674E0 80076CE0 3B9F030C */  jal        SNDmemlargestunused
    /* 674E4 80076CE4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 674E8 80076CE8 00800334 */  ori        $v1, $zero, 0x8000
    /* 674EC 80076CEC 2A186200 */  slt        $v1, $v1, $v0
    /* 674F0 80076CF0 F0FF6010 */  beqz       $v1, .L80076CB4
    /* 674F4 80076CF4 00000000 */   nop
    /* 674F8 80076CF8 EC31A28E */  lw         $v0, %lo(GameSetup_gData)($s5)
    /* 674FC 80076CFC 00000000 */  nop
    /* 67500 80076D00 0C005114 */  bne        $v0, $s1, .L80076D34
    /* 67504 80076D04 02000424 */   addiu     $a0, $zero, 0x2
    /* 67508 80076D08 21800000 */  addu       $s0, $zero, $zero
  .L80076D0C:
    /* 6750C 80076D0C 2F000526 */  addiu      $a1, $s0, 0x2F
    /* 67510 80076D10 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 67514 80076D14 21300000 */   addu      $a2, $zero, $zero
    /* 67518 80076D18 02005314 */  bne        $v0, $s3, .L80076D24
    /* 6751C 80076D1C 00000000 */   nop
    /* 67520 80076D20 21880000 */  addu       $s1, $zero, $zero
  .L80076D24:
    /* 67524 80076D24 01001026 */  addiu      $s0, $s0, 0x1
    /* 67528 80076D28 0400022A */  slti       $v0, $s0, 0x4
    /* 6752C 80076D2C F7FF4014 */  bnez       $v0, .L80076D0C
    /* 67530 80076D30 02000424 */   addiu     $a0, $zero, 0x2
  .L80076D34:
    /* 67534 80076D34 4800838E */  lw         $v1, 0x48($s4)
    /* 67538 80076D38 01000224 */  addiu      $v0, $zero, 0x1
    /* 6753C 80076D3C 08006214 */  bne        $v1, $v0, .L80076D60
    /* 67540 80076D40 21900000 */   addu      $s2, $zero, $zero
    /* 67544 80076D44 21204000 */  addu       $a0, $v0, $zero
    /* 67548 80076D48 21280000 */  addu       $a1, $zero, $zero
    /* 6754C 80076D4C 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 67550 80076D50 2130A000 */   addu      $a2, $a1, $zero
    /* 67554 80076D54 02005314 */  bne        $v0, $s3, .L80076D60
    /* 67558 80076D58 21900000 */   addu      $s2, $zero, $zero
    /* 6755C 80076D5C 21880000 */  addu       $s1, $zero, $zero
  .L80076D60:
    /* 67560 80076D60 21808002 */  addu       $s0, $s4, $zero
  .L80076D64:
    /* 67564 80076D64 C403828E */  lw         $v0, 0x3C4($s4)
    /* 67568 80076D68 00000000 */  nop
    /* 6756C 80076D6C 2A104202 */  slt        $v0, $s2, $v0
    /* 67570 80076D70 D0FF4010 */  beqz       $v0, .L80076CB4
    /* 67574 80076D74 02000224 */   addiu     $v0, $zero, 0x2
    /* 67578 80076D78 D803038E */  lw         $v1, 0x3D8($s0)
    /* 6757C 80076D7C 00000000 */  nop
    /* 67580 80076D80 17006214 */  bne        $v1, $v0, .L80076DE0
    /* 67584 80076D84 00000000 */   nop
    /* 67588 80076D88 D403048E */  lw         $a0, 0x3D4($s0)
    /* 6758C 80076D8C B368020C */  jal        CopSpeak_GetEnginePatch__Fii
    /* 67590 80076D90 21280000 */   addu      $a1, $zero, $zero
    /* 67594 80076D94 07004004 */  bltz       $v0, .L80076DB4
    /* 67598 80076D98 01000424 */   addiu     $a0, $zero, 0x1
    /* 6759C 80076D9C 21284000 */  addu       $a1, $v0, $zero
    /* 675A0 80076DA0 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 675A4 80076DA4 21300000 */   addu      $a2, $zero, $zero
    /* 675A8 80076DA8 02005314 */  bne        $v0, $s3, .L80076DB4
    /* 675AC 80076DAC 00000000 */   nop
    /* 675B0 80076DB0 21880000 */  addu       $s1, $zero, $zero
  .L80076DB4:
    /* 675B4 80076DB4 D403048E */  lw         $a0, 0x3D4($s0)
    /* 675B8 80076DB8 B368020C */  jal        CopSpeak_GetEnginePatch__Fii
    /* 675BC 80076DBC 01000524 */   addiu     $a1, $zero, 0x1
    /* 675C0 80076DC0 07004004 */  bltz       $v0, .L80076DE0
    /* 675C4 80076DC4 01000424 */   addiu     $a0, $zero, 0x1
    /* 675C8 80076DC8 21284000 */  addu       $a1, $v0, $zero
    /* 675CC 80076DCC 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 675D0 80076DD0 21300000 */   addu      $a2, $zero, $zero
    /* 675D4 80076DD4 02005314 */  bne        $v0, $s3, .L80076DE0
    /* 675D8 80076DD8 00000000 */   nop
    /* 675DC 80076DDC 21880000 */  addu       $s1, $zero, $zero
  .L80076DE0:
    /* 675E0 80076DE0 B4001026 */  addiu      $s0, $s0, 0xB4
    /* 675E4 80076DE4 59DB0108 */  j          .L80076D64
    /* 675E8 80076DE8 01005226 */   addiu     $s2, $s2, 0x1
  .L80076DEC:
    /* 675EC 80076DEC D7F4010C */  jal        AudioTrk_PreLoad__Fv
    /* 675F0 80076DF0 00000000 */   nop
    /* 675F4 80076DF4 0401848F */  lw         $a0, %gp_rel(gMasterMusicLevel)($gp)
    /* 675F8 80076DF8 00000000 */  nop
    /* 675FC 80076DFC 47008010 */  beqz       $a0, .L80076F1C
    /* 67600 80076E00 00000000 */   nop
    /* 67604 80076E04 08D9010C */  jal        AudioCmn_MusicLevel__Fi
    /* 67608 80076E08 00000000 */   nop
    /* 6760C 80076E0C ACEC010C */  jal        AudioMus_Volume__Fi
    /* 67610 80076E10 21204000 */   addu      $a0, $v0, $zero
    /* 67614 80076E14 1480043C */  lui        $a0, %hi(gMusicHandle)
    /* 67618 80076E18 1CD5848C */  lw         $a0, %lo(gMusicHandle)($a0)
    /* 6761C 80076E1C FF000524 */  addiu      $a1, $zero, 0xFF
    /* 67620 80076E20 3C9B030C */  jal        SNDSTRM_setpriority
    /* 67624 80076E24 2130A000 */   addu      $a2, $a1, $zero
    /* 67628 80076E28 88A0030C */  jal        gettick
    /* 6762C 80076E2C 00000000 */   nop
    /* 67630 80076E30 21804000 */  addu       $s0, $v0, $zero
    /* 67634 80076E34 88A0030C */  jal        gettick
    /* 67638 80076E38 00011326 */   addiu     $s3, $s0, 0x100
    /* 6763C 80076E3C F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 67640 80076E40 40001226 */   addiu     $s2, $s0, 0x40
    /* 67644 80076E44 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 67648 80076E48 00000000 */   nop
  .L80076E4C:
    /* 6764C 80076E4C 88A0030C */  jal        gettick
    /* 67650 80076E50 21880000 */   addu      $s1, $zero, $zero
    /* 67654 80076E54 2A105200 */  slt        $v0, $v0, $s2
    /* 67658 80076E58 0C004014 */  bnez       $v0, .L80076E8C
    /* 6765C 80076E5C 00000000 */   nop
    /* 67660 80076E60 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 67664 80076E64 00000000 */   nop
    /* 67668 80076E68 08004018 */  blez       $v0, .L80076E8C
    /* 6766C 80076E6C 00000000 */   nop
    /* 67670 80076E70 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 67674 80076E74 00000000 */   nop
    /* 67678 80076E78 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 6767C 80076E7C 21804000 */   addu      $s0, $v0, $zero
    /* 67680 80076E80 2A800202 */  slt        $s0, $s0, $v0
    /* 67684 80076E84 07000012 */  beqz       $s0, .L80076EA4
    /* 67688 80076E88 00000000 */   nop
  .L80076E8C:
    /* 6768C 80076E8C 88A0030C */  jal        gettick
    /* 67690 80076E90 00000000 */   nop
    /* 67694 80076E94 2A105300 */  slt        $v0, $v0, $s3
    /* 67698 80076E98 02004010 */  beqz       $v0, .L80076EA4
    /* 6769C 80076E9C 00000000 */   nop
    /* 676A0 80076EA0 01001124 */  addiu      $s1, $zero, 0x1
  .L80076EA4:
    /* 676A4 80076EA4 05002012 */  beqz       $s1, .L80076EBC
    /* 676A8 80076EA8 00000000 */   nop
    /* 676AC 80076EAC 019B030C */  jal        systemtask
    /* 676B0 80076EB0 21200000 */   addu      $a0, $zero, $zero
    /* 676B4 80076EB4 93DB0108 */  j          .L80076E4C
    /* 676B8 80076EB8 00000000 */   nop
  .L80076EBC:
    /* 676BC 80076EBC F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 676C0 80076EC0 00000000 */   nop
    /* 676C4 80076EC4 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 676C8 80076EC8 21804000 */   addu      $s0, $v0, $zero
    /* 676CC 80076ECC 9CFF4224 */  addiu      $v0, $v0, -0x64
    /* 676D0 80076ED0 2A800202 */  slt        $s0, $s0, $v0
    /* 676D4 80076ED4 09000012 */  beqz       $s0, .L80076EFC
    /* 676D8 80076ED8 1180023C */   lui       $v0, %hi(D_801132DC)
    /* 676DC 80076EDC DC3240AC */  sw         $zero, %lo(D_801132DC)($v0)
    /* 676E0 80076EE0 040180AF */  sw         $zero, %gp_rel(gMasterMusicLevel)($gp)
    /* 676E4 80076EE4 08D9010C */  jal        AudioCmn_MusicLevel__Fi
    /* 676E8 80076EE8 21200000 */   addu      $a0, $zero, $zero
    /* 676EC 80076EEC ACEC010C */  jal        AudioMus_Volume__Fi
    /* 676F0 80076EF0 21204000 */   addu      $a0, $v0, $zero
    /* 676F4 80076EF4 C1DB0108 */  j          .L80076F04
    /* 676F8 80076EF8 00000000 */   nop
  .L80076EFC:
    /* 676FC 80076EFC 88A0030C */  jal        gettick
    /* 67700 80076F00 00000000 */   nop
  .L80076F04:
    /* 67704 80076F04 88A0030C */  jal        gettick
    /* 67708 80076F08 00000000 */   nop
    /* 6770C 80076F0C F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 67710 80076F10 00000000 */   nop
    /* 67714 80076F14 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 67718 80076F18 00000000 */   nop
  .L80076F1C:
    /* 6771C 80076F1C 3400BF8F */  lw         $ra, 0x34($sp)
    /* 67720 80076F20 3000B68F */  lw         $s6, 0x30($sp)
    /* 67724 80076F24 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 67728 80076F28 2800B48F */  lw         $s4, 0x28($sp)
    /* 6772C 80076F2C 2400B38F */  lw         $s3, 0x24($sp)
    /* 67730 80076F30 2000B28F */  lw         $s2, 0x20($sp)
    /* 67734 80076F34 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 67738 80076F38 1800B08F */  lw         $s0, 0x18($sp)
    /* 6773C 80076F3C 0800E003 */  jr         $ra
    /* 67740 80076F40 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AudioCmn_Reset__Fv
