.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand, 0x16C

glabel MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand
    /* 1D8A8 8002D0A8 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 1D8AC 8002D0AC C400B3AF */  sw         $s3, 0xC4($sp)
    /* 1D8B0 8002D0B0 21988000 */  addu       $s3, $a0, $zero
    /* 1D8B4 8002D0B4 1180043C */  lui        $a0, %hi(frontEnd)
    /* 1D8B8 8002D0B8 00468424 */  addiu      $a0, $a0, %lo(frontEnd)
    /* 1D8BC 8002D0BC 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 1D8C0 8002D0C0 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1D8C4 8002D0C4 D84A5124 */  addiu      $s1, $v0, %lo(tournamentManager)
    /* 1D8C8 8002D0C8 C800BFAF */  sw         $ra, 0xC8($sp)
    /* 1D8CC 8002D0CC C000B2AF */  sw         $s2, 0xC0($sp)
    /* 1D8D0 8002D0D0 B800B0AF */  sw         $s0, 0xB8($sp)
    /* 1D8D4 8002D0D4 1800258E */  lw         $a1, 0x18($s1)
    /* 1D8D8 8002D0D8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D8DC 8002D0DC 220182A0 */  sb         $v0, 0x122($a0)
    /* 1D8E0 8002D0E0 21018290 */  lbu        $v0, 0x121($a0)
    /* 1D8E4 8002D0E4 0E00A390 */  lbu        $v1, 0xE($a1)
    /* 1D8E8 8002D0E8 00000000 */  nop
    /* 1D8EC 8002D0EC 21186200 */  addu       $v1, $v1, $v0
    /* 1D8F0 8002D0F0 80100300 */  sll        $v0, $v1, 2
    /* 1D8F4 8002D0F4 21104300 */  addu       $v0, $v0, $v1
    /* 1D8F8 8002D0F8 80100200 */  sll        $v0, $v0, 2
    /* 1D8FC 8002D0FC 21104300 */  addu       $v0, $v0, $v1
    /* 1D900 8002D100 80100200 */  sll        $v0, $v0, 2
    /* 1D904 8002D104 24004224 */  addiu      $v0, $v0, 0x24
    /* 1D908 8002D108 2128A200 */  addu       $a1, $a1, $v0
    /* 1D90C 8002D10C 3000A38C */  lw         $v1, 0x30($a1)
    /* 1D910 8002D110 00000000 */  nop
    /* 1D914 8002D114 2C006018 */  blez       $v1, .L8002D1C8
    /* 1D918 8002D118 2190A000 */   addu      $s2, $a1, $zero
    /* 1D91C 8002D11C 1400228E */  lw         $v0, 0x14($s1)
    /* 1D920 8002D120 00000000 */  nop
    /* 1D924 8002D124 2A104300 */  slt        $v0, $v0, $v1
    /* 1D928 8002D128 0A004010 */  beqz       $v0, .L8002D154
    /* 1D92C 8002D12C 0580023C */   lui       $v0, %hi(FEApp)
    /* 1D930 8002D130 C014508C */  lw         $s0, %lo(FEApp)($v0)
    /* 1D934 8002D134 F6000424 */  addiu      $a0, $zero, 0xF6
    /* 1D938 8002D138 94E4020C */  jal        TextSys_Word__Fi
    /* 1D93C 8002D13C 2C001026 */   addiu     $s0, $s0, 0x2C
    /* 1D940 8002D140 21200002 */  addu       $a0, $s0, $zero
    /* 1D944 8002D144 1062000C */  jal        Display__11tDialogBase
    /* 1D948 8002D148 900082AC */   sw        $v0, 0x90($a0)
    /* 1D94C 8002D14C 7EB40008 */  j          .L8002D1F8
    /* 1D950 8002D150 00000000 */   nop
  .L8002D154:
    /* 1D954 8002D154 A366000C */  jal        __12tDialogYesNo
    /* 1D958 8002D158 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1D95C 8002D15C 94E4020C */  jal        TextSys_Word__Fi
    /* 1D960 8002D160 F7000424 */   addiu     $a0, $zero, 0xF7
    /* 1D964 8002D164 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1D968 8002D168 21200002 */  addu       $a0, $s0, $zero
    /* 1D96C 8002D16C 900002AE */  sw         $v0, 0x90($s0)
    /* 1D970 8002D170 21030224 */  addiu      $v0, $zero, 0x321
    /* 1D974 8002D174 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1D978 8002D178 22030224 */  addiu      $v0, $zero, 0x322
    /* 1D97C 8002D17C A40002AE */  sw         $v0, 0xA4($s0)
    /* 1D980 8002D180 FA65000C */  jal        Run__18tDialogInteractive
    /* 1D984 8002D184 880000A6 */   sh        $zero, 0x88($s0)
    /* 1D988 8002D188 00140200 */  sll        $v0, $v0, 16
    /* 1D98C 8002D18C 05004014 */  bnez       $v0, .L8002D1A4
    /* 1D990 8002D190 21200002 */   addu      $a0, $s0, $zero
    /* 1D994 8002D194 1E98000C */  jal        ___7tScreen
    /* 1D998 8002D198 02000524 */   addiu     $a1, $zero, 0x2
    /* 1D99C 8002D19C 7EB40008 */  j          .L8002D1F8
    /* 1D9A0 8002D1A0 00000000 */   nop
  .L8002D1A4:
    /* 1D9A4 8002D1A4 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1D9A8 8002D1A8 1A000424 */   addiu     $a0, $zero, 0x1A
    /* 1D9AC 8002D1AC 21200002 */  addu       $a0, $s0, $zero
    /* 1D9B0 8002D1B0 3000438E */  lw         $v1, 0x30($s2)
    /* 1D9B4 8002D1B4 1400228E */  lw         $v0, 0x14($s1)
    /* 1D9B8 8002D1B8 02000524 */  addiu      $a1, $zero, 0x2
    /* 1D9BC 8002D1BC 23104300 */  subu       $v0, $v0, $v1
    /* 1D9C0 8002D1C0 1E98000C */  jal        ___7tScreen
    /* 1D9C4 8002D1C4 140022AE */   sw        $v0, 0x14($s1)
  .L8002D1C8:
    /* 1D9C8 8002D1C8 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 1D9CC 8002D1CC D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 1D9D0 8002D1D0 1180023C */  lui        $v0, %hi(D_80114721)
    /* 1D9D4 8002D1D4 21474690 */  lbu        $a2, %lo(D_80114721)($v0)
    /* 1D9D8 8002D1D8 E1C9000C */  jal        StartNewTournament__18tTournamentManagerUcUc
    /* 1D9DC 8002D1DC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1D9E0 8002D1E0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1D9E4 8002D1E4 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D9E8 8002D1E8 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D9EC 8002D1EC 000063AE */  sw         $v1, 0x0($s3)
    /* 1D9F0 8002D1F0 F0104224 */  addiu      $v0, $v0, 0x10F0
    /* 1D9F4 8002D1F4 040062AE */  sw         $v0, 0x4($s3)
  .L8002D1F8:
    /* 1D9F8 8002D1F8 C800BF8F */  lw         $ra, 0xC8($sp)
    /* 1D9FC 8002D1FC C400B38F */  lw         $s3, 0xC4($sp)
    /* 1DA00 8002D200 C000B28F */  lw         $s2, 0xC0($sp)
    /* 1DA04 8002D204 BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1DA08 8002D208 B800B08F */  lw         $s0, 0xB8($sp)
    /* 1DA0C 8002D20C 0800E003 */  jr         $ra
    /* 1DA10 8002D210 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand
