.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToTournTrackInfo__FR12tMenuCommand, 0x168

glabel MenuExtended_GoToTournTrackInfo__FR12tMenuCommand
    /* 1D740 8002CF40 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 1D744 8002CF44 C400B3AF */  sw         $s3, 0xC4($sp)
    /* 1D748 8002CF48 21988000 */  addu       $s3, $a0, $zero
    /* 1D74C 8002CF4C 1180043C */  lui        $a0, %hi(frontEnd)
    /* 1D750 8002CF50 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 1D754 8002CF54 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1D758 8002CF58 D84A5124 */  addiu      $s1, $v0, %lo(tournamentManager)
    /* 1D75C 8002CF5C 00468424 */  addiu      $a0, $a0, %lo(frontEnd)
    /* 1D760 8002CF60 C800BFAF */  sw         $ra, 0xC8($sp)
    /* 1D764 8002CF64 C000B2AF */  sw         $s2, 0xC0($sp)
    /* 1D768 8002CF68 B800B0AF */  sw         $s0, 0xB8($sp)
    /* 1D76C 8002CF6C 1800258E */  lw         $a1, 0x18($s1)
    /* 1D770 8002CF70 20018290 */  lbu        $v0, 0x120($a0)
    /* 1D774 8002CF74 220180A0 */  sb         $zero, 0x122($a0)
    /* 1D778 8002CF78 0200A390 */  lbu        $v1, 0x2($a1)
    /* 1D77C 8002CF7C 00000000 */  nop
    /* 1D780 8002CF80 21186200 */  addu       $v1, $v1, $v0
    /* 1D784 8002CF84 80100300 */  sll        $v0, $v1, 2
    /* 1D788 8002CF88 21104300 */  addu       $v0, $v0, $v1
    /* 1D78C 8002CF8C 80100200 */  sll        $v0, $v0, 2
    /* 1D790 8002CF90 21104300 */  addu       $v0, $v0, $v1
    /* 1D794 8002CF94 80100200 */  sll        $v0, $v0, 2
    /* 1D798 8002CF98 24004224 */  addiu      $v0, $v0, 0x24
    /* 1D79C 8002CF9C 2128A200 */  addu       $a1, $a1, $v0
    /* 1D7A0 8002CFA0 3000A38C */  lw         $v1, 0x30($a1)
    /* 1D7A4 8002CFA4 00000000 */  nop
    /* 1D7A8 8002CFA8 2C006018 */  blez       $v1, .L8002D05C
    /* 1D7AC 8002CFAC 2190A000 */   addu      $s2, $a1, $zero
    /* 1D7B0 8002CFB0 1400228E */  lw         $v0, 0x14($s1)
    /* 1D7B4 8002CFB4 00000000 */  nop
    /* 1D7B8 8002CFB8 2A104300 */  slt        $v0, $v0, $v1
    /* 1D7BC 8002CFBC 0A004010 */  beqz       $v0, .L8002CFE8
    /* 1D7C0 8002CFC0 0580023C */   lui       $v0, %hi(FEApp)
    /* 1D7C4 8002CFC4 C014508C */  lw         $s0, %lo(FEApp)($v0)
    /* 1D7C8 8002CFC8 F6000424 */  addiu      $a0, $zero, 0xF6
    /* 1D7CC 8002CFCC 94E4020C */  jal        TextSys_Word__Fi
    /* 1D7D0 8002CFD0 2C001026 */   addiu     $s0, $s0, 0x2C
    /* 1D7D4 8002CFD4 21200002 */  addu       $a0, $s0, $zero
    /* 1D7D8 8002CFD8 1062000C */  jal        Display__11tDialogBase
    /* 1D7DC 8002CFDC 900082AC */   sw        $v0, 0x90($a0)
    /* 1D7E0 8002CFE0 23B40008 */  j          .L8002D08C
    /* 1D7E4 8002CFE4 00000000 */   nop
  .L8002CFE8:
    /* 1D7E8 8002CFE8 A366000C */  jal        __12tDialogYesNo
    /* 1D7EC 8002CFEC 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1D7F0 8002CFF0 94E4020C */  jal        TextSys_Word__Fi
    /* 1D7F4 8002CFF4 F7000424 */   addiu     $a0, $zero, 0xF7
    /* 1D7F8 8002CFF8 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1D7FC 8002CFFC 21200002 */  addu       $a0, $s0, $zero
    /* 1D800 8002D000 900002AE */  sw         $v0, 0x90($s0)
    /* 1D804 8002D004 22030224 */  addiu      $v0, $zero, 0x322
    /* 1D808 8002D008 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1D80C 8002D00C 21030224 */  addiu      $v0, $zero, 0x321
    /* 1D810 8002D010 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1D814 8002D014 FA65000C */  jal        Run__18tDialogInteractive
    /* 1D818 8002D018 880000A6 */   sh        $zero, 0x88($s0)
    /* 1D81C 8002D01C 00140200 */  sll        $v0, $v0, 16
    /* 1D820 8002D020 05004014 */  bnez       $v0, .L8002D038
    /* 1D824 8002D024 21200002 */   addu      $a0, $s0, $zero
    /* 1D828 8002D028 1E98000C */  jal        ___7tScreen
    /* 1D82C 8002D02C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1D830 8002D030 23B40008 */  j          .L8002D08C
    /* 1D834 8002D034 00000000 */   nop
  .L8002D038:
    /* 1D838 8002D038 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1D83C 8002D03C 1A000424 */   addiu     $a0, $zero, 0x1A
    /* 1D840 8002D040 21200002 */  addu       $a0, $s0, $zero
    /* 1D844 8002D044 3000438E */  lw         $v1, 0x30($s2)
    /* 1D848 8002D048 1400228E */  lw         $v0, 0x14($s1)
    /* 1D84C 8002D04C 02000524 */  addiu      $a1, $zero, 0x2
    /* 1D850 8002D050 23104300 */  subu       $v0, $v0, $v1
    /* 1D854 8002D054 1E98000C */  jal        ___7tScreen
    /* 1D858 8002D058 140022AE */   sw        $v0, 0x14($s1)
  .L8002D05C:
    /* 1D85C 8002D05C 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 1D860 8002D060 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 1D864 8002D064 1180023C */  lui        $v0, %hi(D_80114720)
    /* 1D868 8002D068 20474690 */  lbu        $a2, %lo(D_80114720)($v0)
    /* 1D86C 8002D06C E1C9000C */  jal        StartNewTournament__18tTournamentManagerUcUc
    /* 1D870 8002D070 21280000 */   addu      $a1, $zero, $zero
    /* 1D874 8002D074 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1D878 8002D078 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D87C 8002D07C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D880 8002D080 000063AE */  sw         $v1, 0x0($s3)
    /* 1D884 8002D084 F0104224 */  addiu      $v0, $v0, 0x10F0
    /* 1D888 8002D088 040062AE */  sw         $v0, 0x4($s3)
  .L8002D08C:
    /* 1D88C 8002D08C C800BF8F */  lw         $ra, 0xC8($sp)
    /* 1D890 8002D090 C400B38F */  lw         $s3, 0xC4($sp)
    /* 1D894 8002D094 C000B28F */  lw         $s2, 0xC0($sp)
    /* 1D898 8002D098 BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1D89C 8002D09C B800B08F */  lw         $s0, 0xB8($sp)
    /* 1D8A0 8002D0A0 0800E003 */  jr         $ra
    /* 1D8A4 8002D0A4 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel MenuExtended_GoToTournTrackInfo__FR12tMenuCommand
