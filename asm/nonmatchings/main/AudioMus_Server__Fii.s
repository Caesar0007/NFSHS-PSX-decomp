.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_Server__Fii, 0x4B0

glabel AudioMus_Server__Fii
    /* 6ABD0 8007A3D0 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6ABD4 8007A3D4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6ABD8 8007A3D8 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6ABDC 8007A3DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6ABE0 8007A3E0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6ABE4 8007A3E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6ABE8 8007A3E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6ABEC 8007A3EC 8C00628C */  lw         $v0, 0x8C($v1)
    /* 6ABF0 8007A3F0 00000000 */  nop
    /* 6ABF4 8007A3F4 1A014010 */  beqz       $v0, .L8007A860
    /* 6ABF8 8007A3F8 2E000224 */   addiu     $v0, $zero, 0x2E
    /* 6ABFC 8007A3FC AC006390 */  lbu        $v1, 0xAC($v1)
    /* 6AC00 8007A400 00000000 */  nop
    /* 6AC04 8007A404 1B006210 */  beq        $v1, $v0, .L8007A474
    /* 6AC08 8007A408 00000000 */   nop
    /* 6AC0C 8007A40C 12A1030C */  jal        CdDiskReady
    /* 6AC10 8007A410 01000424 */   addiu     $a0, $zero, 0x1
    /* 6AC14 8007A414 10000324 */  addiu      $v1, $zero, 0x10
    /* 6AC18 8007A418 16004314 */  bne        $v0, $v1, .L8007A474
    /* 6AC1C 8007A41C 00000000 */   nop
    /* 6AC20 8007A420 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6AC24 8007A424 00000000 */  nop
    /* 6AC28 8007A428 2000828C */  lw         $v0, 0x20($a0)
    /* 6AC2C 8007A42C 00000000 */  nop
    /* 6AC30 8007A430 0C014014 */  bnez       $v0, .L8007A864
    /* 6AC34 8007A434 21100000 */   addu      $v0, $zero, $zero
    /* 6AC38 8007A438 0C00838C */  lw         $v1, 0xC($a0)
    /* 6AC3C 8007A43C FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 6AC40 8007A440 200082AC */  sw         $v0, 0x20($a0)
    /* 6AC44 8007A444 01000224 */  addiu      $v0, $zero, 0x1
    /* 6AC48 8007A448 05016004 */  bltz       $v1, .L8007A860
    /* 6AC4C 8007A44C 180082AC */   sw        $v0, 0x18($a0)
    /* 6AC50 8007A450 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6AC54 8007A454 00000000 */   nop
    /* 6AC58 8007A458 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AC5C 8007A45C 21284000 */  addu       $a1, $v0, $zero
    /* 6AC60 8007A460 7400648C */  lw         $a0, 0x74($v1)
    /* 6AC64 8007A464 7AA7030C */  jal        SNDSTRM_autovol
    /* 6AC68 8007A468 21300000 */   addu      $a2, $zero, $zero
    /* 6AC6C 8007A46C 19EA0108 */  j          .L8007A864
    /* 6AC70 8007A470 21100000 */   addu      $v0, $zero, $zero
  .L8007A474:
    /* 6AC74 8007A474 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AC78 8007A478 00000000 */  nop
    /* 6AC7C 8007A47C 2000438C */  lw         $v1, 0x20($v0)
    /* 6AC80 8007A480 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 6AC84 8007A484 11006214 */  bne        $v1, $v0, .L8007A4CC
    /* 6AC88 8007A488 00000000 */   nop
    /* 6AC8C 8007A48C 12A1030C */  jal        CdDiskReady
    /* 6AC90 8007A490 01000424 */   addiu     $a0, $zero, 0x1
    /* 6AC94 8007A494 21284000 */  addu       $a1, $v0, $zero
    /* 6AC98 8007A498 02000224 */  addiu      $v0, $zero, 0x2
    /* 6AC9C 8007A49C F100A214 */  bne        $a1, $v0, .L8007A864
    /* 6ACA0 8007A4A0 21100000 */   addu      $v0, $zero, $zero
    /* 6ACA4 8007A4A4 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6ACA8 8007A4A8 00000000 */  nop
    /* 6ACAC 8007A4AC 0C00838C */  lw         $v1, 0xC($a0)
    /* 6ACB0 8007A4B0 FBFF0224 */  addiu      $v0, $zero, -0x5
    /* 6ACB4 8007A4B4 EA006004 */  bltz       $v1, .L8007A860
    /* 6ACB8 8007A4B8 200082AC */   sw        $v0, 0x20($a0)
    /* 6ACBC 8007A4BC 01000224 */  addiu      $v0, $zero, 0x1
    /* 6ACC0 8007A4C0 180082AC */  sw         $v0, 0x18($a0)
    /* 6ACC4 8007A4C4 BFE90108 */  j          .L8007A6FC
    /* 6ACC8 8007A4C8 140085AC */   sw        $a1, 0x14($a0)
  .L8007A4CC:
    /* 6ACCC 8007A4CC BDE7010C */  jal        AudioMus_RefreshStatus__Fv
    /* 6ACD0 8007A4D0 00000000 */   nop
    /* 6ACD4 8007A4D4 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 6ACD8 8007A4D8 00000000 */   nop
    /* 6ACDC 8007A4DC 35004010 */  beqz       $v0, .L8007A5B4
    /* 6ACE0 8007A4E0 00000000 */   nop
    /* 6ACE4 8007A4E4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6ACE8 8007A4E8 00000000 */  nop
    /* 6ACEC 8007A4EC 1400438C */  lw         $v1, 0x14($v0)
    /* 6ACF0 8007A4F0 02000224 */  addiu      $v0, $zero, 0x2
    /* 6ACF4 8007A4F4 2F006210 */  beq        $v1, $v0, .L8007A5B4
    /* 6ACF8 8007A4F8 00000000 */   nop
    /* 6ACFC 8007A4FC F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6AD00 8007A500 00000000 */   nop
    /* 6AD04 8007A504 26024228 */  slti       $v0, $v0, 0x226
    /* 6AD08 8007A508 05004010 */  beqz       $v0, .L8007A520
    /* 6AD0C 8007A50C 00000000 */   nop
    /* 6AD10 8007A510 77E8010C */  jal        AudioMus_Fail__Fi
    /* 6AD14 8007A514 FBFF0424 */   addiu     $a0, $zero, -0x5
    /* 6AD18 8007A518 6DE90108 */  j          .L8007A5B4
    /* 6AD1C 8007A51C 00000000 */   nop
  .L8007A520:
    /* 6AD20 8007A520 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6AD24 8007A524 00000000 */   nop
    /* 6AD28 8007A528 DC054228 */  slti       $v0, $v0, 0x5DC
    /* 6AD2C 8007A52C 0E004010 */  beqz       $v0, .L8007A568
    /* 6AD30 8007A530 00000000 */   nop
    /* 6AD34 8007A534 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AD38 8007A538 00000000 */  nop
    /* 6AD3C 8007A53C 8400628C */  lw         $v0, 0x84($v1)
    /* 6AD40 8007A540 00000000 */  nop
    /* 6AD44 8007A544 1B004014 */  bnez       $v0, .L8007A5B4
    /* 6AD48 8007A548 00000000 */   nop
    /* 6AD4C 8007A54C 7400648C */  lw         $a0, 0x74($v1)
    /* 6AD50 8007A550 63A7030C */  jal        SNDSTRM_setgreedystate
    /* 6AD54 8007A554 01000524 */   addiu     $a1, $zero, 0x1
    /* 6AD58 8007A558 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AD5C 8007A55C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6AD60 8007A560 6DE90108 */  j          .L8007A5B4
    /* 6AD64 8007A564 840062AC */   sw        $v0, 0x84($v1)
  .L8007A568:
    /* 6AD68 8007A568 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6AD6C 8007A56C 00000000 */   nop
    /* 6AD70 8007A570 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6AD74 8007A574 00000000 */  nop
    /* 6AD78 8007A578 8800838C */  lw         $v1, 0x88($a0)
    /* 6AD7C 8007A57C 00000000 */  nop
    /* 6AD80 8007A580 2A104300 */  slt        $v0, $v0, $v1
    /* 6AD84 8007A584 0B004014 */  bnez       $v0, .L8007A5B4
    /* 6AD88 8007A588 00000000 */   nop
    /* 6AD8C 8007A58C 8400828C */  lw         $v0, 0x84($a0)
    /* 6AD90 8007A590 00000000 */  nop
    /* 6AD94 8007A594 07004010 */  beqz       $v0, .L8007A5B4
    /* 6AD98 8007A598 00000000 */   nop
    /* 6AD9C 8007A59C 7400848C */  lw         $a0, 0x74($a0)
    /* 6ADA0 8007A5A0 63A7030C */  jal        SNDSTRM_setgreedystate
    /* 6ADA4 8007A5A4 21280000 */   addu      $a1, $zero, $zero
    /* 6ADA8 8007A5A8 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6ADAC 8007A5AC 00000000 */  nop
    /* 6ADB0 8007A5B0 840040AC */  sw         $zero, 0x84($v0)
  .L8007A5B4:
    /* 6ADB4 8007A5B4 D401878F */  lw         $a3, %gp_rel(AudioMus_g)($gp)
    /* 6ADB8 8007A5B8 00000000 */  nop
    /* 6ADBC 8007A5BC 1400E28C */  lw         $v0, 0x14($a3)
    /* 6ADC0 8007A5C0 00000000 */  nop
    /* 6ADC4 8007A5C4 55004010 */  beqz       $v0, .L8007A71C
    /* 6ADC8 8007A5C8 02001024 */   addiu     $s0, $zero, 0x2
    /* 6ADCC 8007A5CC 2F005014 */  bne        $v0, $s0, .L8007A68C
    /* 6ADD0 8007A5D0 00000000 */   nop
    /* 6ADD4 8007A5D4 7000E28C */  lw         $v0, 0x70($a3)
    /* 6ADD8 8007A5D8 00000000 */  nop
    /* 6ADDC 8007A5DC 05004014 */  bnez       $v0, .L8007A5F4
    /* 6ADE0 8007A5E0 00000000 */   nop
    /* 6ADE4 8007A5E4 77E8010C */  jal        AudioMus_Fail__Fi
    /* 6ADE8 8007A5E8 FCFF0424 */   addiu     $a0, $zero, -0x4
    /* 6ADEC 8007A5EC 19EA0108 */  j          .L8007A864
    /* 6ADF0 8007A5F0 21100000 */   addu      $v0, $zero, $zero
  .L8007A5F4:
    /* 6ADF4 8007A5F4 7400E28C */  lw         $v0, 0x74($a3)
    /* 6ADF8 8007A5F8 00000000 */  nop
    /* 6ADFC 8007A5FC 05004104 */  bgez       $v0, .L8007A614
    /* 6AE00 8007A600 00000000 */   nop
    /* 6AE04 8007A604 77E8010C */  jal        AudioMus_Fail__Fi
    /* 6AE08 8007A608 FDFF0424 */   addiu     $a0, $zero, -0x3
    /* 6AE0C 8007A60C 19EA0108 */  j          .L8007A864
    /* 6AE10 8007A610 21100000 */   addu      $v0, $zero, $zero
  .L8007A614:
    /* 6AE14 8007A614 9000E28C */  lw         $v0, 0x90($a3)
    /* 6AE18 8007A618 00000000 */  nop
    /* 6AE1C 8007A61C 91004010 */  beqz       $v0, .L8007A864
    /* 6AE20 8007A620 21100000 */   addu      $v0, $zero, $zero
    /* 6AE24 8007A624 A800E38C */  lw         $v1, 0xA8($a3)
    /* 6AE28 8007A628 8800E28C */  lw         $v0, 0x88($a3)
    /* 6AE2C 8007A62C 00000000 */  nop
    /* 6AE30 8007A630 2A104300 */  slt        $v0, $v0, $v1
    /* 6AE34 8007A634 8A004010 */  beqz       $v0, .L8007A860
    /* 6AE38 8007A638 FBFF0224 */   addiu     $v0, $zero, -0x5
    /* 6AE3C 8007A63C 2000E38C */  lw         $v1, 0x20($a3)
    /* 6AE40 8007A640 00000000 */  nop
    /* 6AE44 8007A644 05006214 */  bne        $v1, $v0, .L8007A65C
    /* 6AE48 8007A648 D0070524 */   addiu     $a1, $zero, 0x7D0
    /* 6AE4C 8007A64C 7400E48C */  lw         $a0, 0x74($a3)
    /* 6AE50 8007A650 0000E68C */  lw         $a2, 0x0($a3)
    /* 6AE54 8007A654 9EE90108 */  j          .L8007A678
    /* 6AE58 8007A658 2000E0AC */   sw        $zero, 0x20($a3)
  .L8007A65C:
    /* 6AE5C 8007A65C E4E8010C */  jal        AudioMus_SetCurrentSongInfo__Fv
    /* 6AE60 8007A660 00000000 */   nop
    /* 6AE64 8007A664 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AE68 8007A668 00000000 */  nop
    /* 6AE6C 8007A66C 7400448C */  lw         $a0, 0x74($v0)
    /* 6AE70 8007A670 0000468C */  lw         $a2, 0x0($v0)
    /* 6AE74 8007A674 D0070524 */  addiu      $a1, $zero, 0x7D0
  .L8007A678:
    /* 6AE78 8007A678 7AA7030C */  jal        SNDSTRM_autovol
    /* 6AE7C 8007A67C 00000000 */   nop
    /* 6AE80 8007A680 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AE84 8007A684 18EA0108 */  j          .L8007A860
    /* 6AE88 8007A688 140040AC */   sw        $zero, 0x14($v0)
  .L8007A68C:
    /* 6AE8C 8007A68C 9000E28C */  lw         $v0, 0x90($a3)
    /* 6AE90 8007A690 00000000 */  nop
    /* 6AE94 8007A694 06004010 */  beqz       $v0, .L8007A6B0
    /* 6AE98 8007A698 00000000 */   nop
    /* 6AE9C 8007A69C 7400E48C */  lw         $a0, 0x74($a3)
    /* 6AEA0 8007A6A0 FBA0030C */  jal        SNDSTRM_getvol
    /* 6AEA4 8007A6A4 00000000 */   nop
    /* 6AEA8 8007A6A8 6E004014 */  bnez       $v0, .L8007A864
    /* 6AEAC 8007A6AC 21100000 */   addu      $v0, $zero, $zero
  .L8007A6B0:
    /* 6AEB0 8007A6B0 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AEB4 8007A6B4 00000000 */  nop
    /* 6AEB8 8007A6B8 7400448C */  lw         $a0, 0x74($v0)
    /* 6AEBC 8007A6BC 00000000 */  nop
    /* 6AEC0 8007A6C0 03008004 */  bltz       $a0, .L8007A6D0
    /* 6AEC4 8007A6C4 00000000 */   nop
    /* 6AEC8 8007A6C8 16A7030C */  jal        SNDSTRM_purge
    /* 6AECC 8007A6CC 00000000 */   nop
  .L8007A6D0:
    /* 6AED0 8007A6D0 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6AED4 8007A6D4 00000000 */  nop
    /* 6AED8 8007A6D8 1400838C */  lw         $v1, 0x14($a0)
    /* 6AEDC 8007A6DC 01000224 */  addiu      $v0, $zero, 0x1
    /* 6AEE0 8007A6E0 0C006214 */  bne        $v1, $v0, .L8007A714
    /* 6AEE4 8007A6E4 2C0080AC */   sw        $zero, 0x2C($a0)
    /* 6AEE8 8007A6E8 96E8010C */  jal        AudioMus_QueueRequestedSong__Fv
    /* 6AEEC 8007A6EC 240080AC */   sw        $zero, 0x24($a0)
    /* 6AEF0 8007A6F0 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AEF4 8007A6F4 00000000 */  nop
    /* 6AEF8 8007A6F8 140050AC */  sw         $s0, 0x14($v0)
  .L8007A6FC:
    /* 6AEFC 8007A6FC 88A0030C */  jal        gettick
    /* 6AF00 8007A700 00000000 */   nop
    /* 6AF04 8007A704 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AF08 8007A708 80024224 */  addiu      $v0, $v0, 0x280
    /* 6AF0C 8007A70C 18EA0108 */  j          .L8007A860
    /* 6AF10 8007A710 1C0062AC */   sw        $v0, 0x1C($v1)
  .L8007A714:
    /* 6AF14 8007A714 18EA0108 */  j          .L8007A860
    /* 6AF18 8007A718 140080AC */   sw        $zero, 0x14($a0)
  .L8007A71C:
    /* 6AF1C 8007A71C 9000E28C */  lw         $v0, 0x90($a3)
    /* 6AF20 8007A720 00000000 */  nop
    /* 6AF24 8007A724 4F004014 */  bnez       $v0, .L8007A864
    /* 6AF28 8007A728 21100000 */   addu      $v0, $zero, $zero
    /* 6AF2C 8007A72C 0C00E38C */  lw         $v1, 0xC($a3)
    /* 6AF30 8007A730 00000000 */  nop
    /* 6AF34 8007A734 4B006004 */  bltz       $v1, .L8007A864
    /* 6AF38 8007A738 00000000 */   nop
    /* 6AF3C 8007A73C 0800F08C */  lw         $s0, 0x8($a3)
    /* 6AF40 8007A740 00000000 */  nop
    /* 6AF44 8007A744 0200022A */  slti       $v0, $s0, 0x2
    /* 6AF48 8007A748 3A004014 */  bnez       $v0, .L8007A834
    /* 6AF4C 8007A74C 00000000 */   nop
    /* 6AF50 8007A750 2800E28C */  lw         $v0, 0x28($a3)
    /* 6AF54 8007A754 00000000 */  nop
    /* 6AF58 8007A758 28004010 */  beqz       $v0, .L8007A7FC
    /* 6AF5C 8007A75C 21200000 */   addu      $a0, $zero, $zero
    /* 6AF60 8007A760 2198E000 */  addu       $s3, $a3, $zero
    /* 6AF64 8007A764 FFFF1126 */  addiu      $s1, $s0, -0x1
    /* 6AF68 8007A768 C3A7030C */  jal        GetRCnt
    /* 6AF6C 8007A76C 01007224 */   addiu     $s2, $v1, 0x1
    /* 6AF70 8007A770 05004018 */  blez       $v0, .L8007A788
    /* 6AF74 8007A774 00000000 */   nop
    /* 6AF78 8007A778 C3A7030C */  jal        GetRCnt
    /* 6AF7C 8007A77C 21200000 */   addu      $a0, $zero, $zero
    /* 6AF80 8007A780 E5E90108 */  j          .L8007A794
    /* 6AF84 8007A784 00000000 */   nop
  .L8007A788:
    /* 6AF88 8007A788 C3A7030C */  jal        GetRCnt
    /* 6AF8C 8007A78C 21200000 */   addu      $a0, $zero, $zero
    /* 6AF90 8007A790 23100200 */  negu       $v0, $v0
  .L8007A794:
    /* 6AF94 8007A794 1A005100 */  div        $zero, $v0, $s1
    /* 6AF98 8007A798 02002016 */  bnez       $s1, .L8007A7A4
    /* 6AF9C 8007A79C 00000000 */   nop
    /* 6AFA0 8007A7A0 0D000700 */  break      7
  .L8007A7A4:
    /* 6AFA4 8007A7A4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6AFA8 8007A7A8 04002116 */  bne        $s1, $at, .L8007A7BC
    /* 6AFAC 8007A7AC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6AFB0 8007A7B0 02004114 */  bne        $v0, $at, .L8007A7BC
    /* 6AFB4 8007A7B4 00000000 */   nop
    /* 6AFB8 8007A7B8 0D000600 */  break      6
  .L8007A7BC:
    /* 6AFBC 8007A7BC 10180000 */  mfhi       $v1
    /* 6AFC0 8007A7C0 00000000 */  nop
    /* 6AFC4 8007A7C4 21184302 */  addu       $v1, $s2, $v1
    /* 6AFC8 8007A7C8 1A007000 */  div        $zero, $v1, $s0
    /* 6AFCC 8007A7CC 02000016 */  bnez       $s0, .L8007A7D8
    /* 6AFD0 8007A7D0 00000000 */   nop
    /* 6AFD4 8007A7D4 0D000700 */  break      7
  .L8007A7D8:
    /* 6AFD8 8007A7D8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6AFDC 8007A7DC 04000116 */  bne        $s0, $at, .L8007A7F0
    /* 6AFE0 8007A7E0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6AFE4 8007A7E4 02006114 */  bne        $v1, $at, .L8007A7F0
    /* 6AFE8 8007A7E8 00000000 */   nop
    /* 6AFEC 8007A7EC 0D000600 */  break      6
  .L8007A7F0:
    /* 6AFF0 8007A7F0 10100000 */  mfhi       $v0
    /* 6AFF4 8007A7F4 0DEA0108 */  j          .L8007A834
    /* 6AFF8 8007A7F8 0C0062AE */   sw        $v0, 0xC($s3)
  .L8007A7FC:
    /* 6AFFC 8007A7FC 01006224 */  addiu      $v0, $v1, 0x1
    /* 6B000 8007A800 1A005000 */  div        $zero, $v0, $s0
    /* 6B004 8007A804 02000016 */  bnez       $s0, .L8007A810
    /* 6B008 8007A808 00000000 */   nop
    /* 6B00C 8007A80C 0D000700 */  break      7
  .L8007A810:
    /* 6B010 8007A810 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6B014 8007A814 04000116 */  bne        $s0, $at, .L8007A828
    /* 6B018 8007A818 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6B01C 8007A81C 02004114 */  bne        $v0, $at, .L8007A828
    /* 6B020 8007A820 00000000 */   nop
    /* 6B024 8007A824 0D000600 */  break      6
  .L8007A828:
    /* 6B028 8007A828 10180000 */  mfhi       $v1
    /* 6B02C 8007A82C 00000000 */  nop
    /* 6B030 8007A830 0C00E3AC */  sw         $v1, 0xC($a3)
  .L8007A834:
    /* 6B034 8007A834 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B038 8007A838 00000000 */  nop
    /* 6B03C 8007A83C 7400448C */  lw         $a0, 0x74($v0)
    /* 6B040 8007A840 36A8030C */  jal        SNDSTRM_vol
    /* 6B044 8007A844 21280000 */   addu      $a1, $zero, $zero
    /* 6B048 8007A848 96E8010C */  jal        AudioMus_QueueRequestedSong__Fv
    /* 6B04C 8007A84C 00000000 */   nop
    /* 6B050 8007A850 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B054 8007A854 01000224 */  addiu      $v0, $zero, 0x1
    /* 6B058 8007A858 180062AC */  sw         $v0, 0x18($v1)
    /* 6B05C 8007A85C 100062AC */  sw         $v0, 0x10($v1)
  .L8007A860:
    /* 6B060 8007A860 21100000 */  addu       $v0, $zero, $zero
  .L8007A864:
    /* 6B064 8007A864 2000BF8F */  lw         $ra, 0x20($sp)
    /* 6B068 8007A868 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6B06C 8007A86C 1800B28F */  lw         $s2, 0x18($sp)
    /* 6B070 8007A870 1400B18F */  lw         $s1, 0x14($sp)
    /* 6B074 8007A874 1000B08F */  lw         $s0, 0x10($sp)
    /* 6B078 8007A878 0800E003 */  jr         $ra
    /* 6B07C 8007A87C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AudioMus_Server__Fii
