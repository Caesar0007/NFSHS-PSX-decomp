.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__15tScreenCongratsRsT1PPcT3, 0x258

glabel GetShapeInfo__15tScreenCongratsRsT1PPcT3
    /* 3868C 80047E8C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 38690 80047E90 2400B3AF */  sw         $s3, 0x24($sp)
    /* 38694 80047E94 21988000 */  addu       $s3, $a0, $zero
    /* 38698 80047E98 2140A000 */  addu       $t0, $a1, $zero
    /* 3869C 80047E9C 3400B7AF */  sw         $s7, 0x34($sp)
    /* 386A0 80047EA0 21B8C000 */  addu       $s7, $a2, $zero
    /* 386A4 80047EA4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 386A8 80047EA8 2180E000 */  addu       $s0, $a3, $zero
    /* 386AC 80047EAC 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 386B0 80047EB0 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 386B4 80047EB4 3800BFAF */  sw         $ra, 0x38($sp)
    /* 386B8 80047EB8 3000B6AF */  sw         $s6, 0x30($sp)
    /* 386BC 80047EBC 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 386C0 80047EC0 2800B4AF */  sw         $s4, 0x28($sp)
    /* 386C4 80047EC4 2000B2AF */  sw         $s2, 0x20($sp)
    /* 386C8 80047EC8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 386CC 80047ECC 0400838C */  lw         $v1, 0x4($a0)
    /* 386D0 80047ED0 1800858C */  lw         $a1, 0x18($a0)
    /* 386D4 80047ED4 40100300 */  sll        $v0, $v1, 1
    /* 386D8 80047ED8 21104300 */  addu       $v0, $v0, $v1
    /* 386DC 80047EDC 80100200 */  sll        $v0, $v0, 2
    /* 386E0 80047EE0 2110A200 */  addu       $v0, $a1, $v0
    /* 386E4 80047EE4 02004390 */  lbu        $v1, 0x2($v0)
    /* 386E8 80047EE8 0800828C */  lw         $v0, 0x8($a0)
    /* 386EC 80047EEC 740060AE */  sw         $zero, 0x74($s3)
    /* 386F0 80047EF0 700060AE */  sw         $zero, 0x70($s3)
    /* 386F4 80047EF4 21186200 */  addu       $v1, $v1, $v0
    /* 386F8 80047EF8 80100300 */  sll        $v0, $v1, 2
    /* 386FC 80047EFC 21104300 */  addu       $v0, $v0, $v1
    /* 38700 80047F00 80100200 */  sll        $v0, $v0, 2
    /* 38704 80047F04 21104300 */  addu       $v0, $v0, $v1
    /* 38708 80047F08 80100200 */  sll        $v0, $v0, 2
    /* 3870C 80047F0C 24004224 */  addiu      $v0, $v0, 0x24
    /* 38710 80047F10 21A0A200 */  addu       $s4, $a1, $v0
    /* 38714 80047F14 6400628E */  lw         $v0, 0x64($s3)
    /* 38718 80047F18 5000B68F */  lw         $s6, 0x50($sp)
    /* 3871C 80047F1C 02004014 */  bnez       $v0, .L80047F28
    /* 38720 80047F20 16000424 */   addiu     $a0, $zero, 0x16
    /* 38724 80047F24 2B000424 */  addiu      $a0, $zero, 0x2B
  .L80047F28:
    /* 38728 80047F28 0580023C */  lui        $v0, %hi(fPermFileNameBuf)
    /* 3872C 80047F2C 000004A5 */  sh         $a0, 0x0($t0)
    /* 38730 80047F30 64294424 */  addiu      $a0, $v0, %lo(fPermFileNameBuf)
    /* 38734 80047F34 0180023C */  lui        $v0, %hi(D_80012284)
    /* 38738 80047F38 6400638E */  lw         $v1, 0x64($s3)
    /* 3873C 80047F3C 00000000 */  nop
    /* 38740 80047F40 04006014 */  bnez       $v1, .L80047F54
    /* 38744 80047F44 84224524 */   addiu     $a1, $v0, %lo(D_80012284)
    /* 38748 80047F48 0180023C */  lui        $v0, %hi(D_8001228C)
    /* 3874C 80047F4C D71F0108 */  j          .L80047F5C
    /* 38750 80047F50 8C224624 */   addiu     $a2, $v0, %lo(D_8001228C)
  .L80047F54:
    /* 38754 80047F54 0180023C */  lui        $v0, %hi(D_80012294)
    /* 38758 80047F58 94224624 */  addiu      $a2, $v0, %lo(D_80012294)
  .L80047F5C:
    /* 3875C 80047F5C 1180023C */  lui        $v0, %hi(D_80114940)
    /* 38760 80047F60 40494790 */  lbu        $a3, %lo(D_80114940)($v0)
    /* 38764 80047F64 2F91030C */  jal        sprintf
    /* 38768 80047F68 00000000 */   nop
    /* 3876C 80047F6C 0580023C */  lui        $v0, %hi(fPermFileNameBuf)
    /* 38770 80047F70 64294224 */  addiu      $v0, $v0, %lo(fPermFileNameBuf)
    /* 38774 80047F74 000002AE */  sw         $v0, 0x0($s0)
    /* 38778 80047F78 6800628E */  lw         $v0, 0x68($s3)
    /* 3877C 80047F7C 00000000 */  nop
    /* 38780 80047F80 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* 38784 80047F84 0200422C */  sltiu      $v0, $v0, 0x2
    /* 38788 80047F88 29004014 */  bnez       $v0, .L80048030
    /* 3878C 80047F8C 01000224 */   addiu     $v0, $zero, 0x1
    /* 38790 80047F90 84031224 */  addiu      $s2, $zero, 0x384
    /* 38794 80047F94 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 38798 80047F98 D84A8224 */  addiu      $v0, $a0, %lo(tournamentManager)
    /* 3879C 80047F9C 05008392 */  lbu        $v1, 0x5($s4)
    /* 387A0 80047FA0 10004284 */  lh         $v0, 0x10($v0)
    /* 387A4 80047FA4 2B180300 */  sltu       $v1, $zero, $v1
    /* 387A8 80047FA8 21104300 */  addu       $v0, $v0, $v1
    /* 387AC 80047FAC 00140200 */  sll        $v0, $v0, 16
    /* 387B0 80047FB0 03140200 */  sra        $v0, $v0, 16
    /* 387B4 80047FB4 10004018 */  blez       $v0, .L80047FF8
    /* 387B8 80047FB8 01001024 */   addiu     $s0, $zero, 0x1
    /* 387BC 80047FBC 21A88000 */  addu       $s5, $a0, $zero
    /* 387C0 80047FC0 21884000 */  addu       $s1, $v0, $zero
    /* 387C4 80047FC4 D84AA426 */  addiu      $a0, $s5, %lo(tournamentManager)
  .L80047FC8:
    /* 387C8 80047FC8 002C1000 */  sll        $a1, $s0, 16
    /* 387CC 80047FCC AACE000C */  jal        PlayerRanking__18tTournamentManagers
    /* 387D0 80047FD0 032C0500 */   sra       $a1, $a1, 16
    /* 387D4 80047FD4 00140200 */  sll        $v0, $v0, 16
    /* 387D8 80047FD8 02004014 */  bnez       $v0, .L80047FE4
    /* 387DC 80047FDC 00000000 */   nop
    /* 387E0 80047FE0 21900002 */  addu       $s2, $s0, $zero
  .L80047FE4:
    /* 387E4 80047FE4 01001026 */  addiu      $s0, $s0, 0x1
    /* 387E8 80047FE8 2A103002 */  slt        $v0, $s1, $s0
    /* 387EC 80047FEC F6FF4010 */  beqz       $v0, .L80047FC8
    /* 387F0 80047FF0 D84AA426 */   addiu     $a0, $s5, %lo(tournamentManager)
    /* 387F4 80047FF4 1180043C */  lui        $a0, %hi(tournamentManager)
  .L80047FF8:
    /* 387F8 80047FF8 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 387FC 80047FFC 21288002 */  addu       $a1, $s4, $zero
    /* 38800 80048000 02000624 */  addiu      $a2, $zero, 0x2
    /* 38804 80048004 0580103C */  lui        $s0, %hi(congratsSwapFileName)
    /* 38808 80048008 54291026 */  addiu      $s0, $s0, %lo(congratsSwapFileName)
    /* 3880C 8004800C 21380002 */  addu       $a3, $s0, $zero
    /* 38810 80048010 D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 38814 80048014 1000B2AF */   sw        $s2, 0x10($sp)
    /* 38818 80048018 20000224 */  addiu      $v0, $zero, 0x20
    /* 3881C 8004801C 0000D0AE */  sw         $s0, 0x0($s6)
    /* 38820 80048020 0000E2A6 */  sh         $v0, 0x0($s7)
    /* 38824 80048024 20000224 */  addiu      $v0, $zero, 0x20
    /* 38828 80048028 2E200108 */  j          .L800480B8
    /* 3882C 8004802C 700062AE */   sw        $v0, 0x70($s3)
  .L80048030:
    /* 38830 80048030 6C00638E */  lw         $v1, 0x6C($s3)
    /* 38834 80048034 00000000 */  nop
    /* 38838 80048038 05006210 */  beq        $v1, $v0, .L80048050
    /* 3883C 8004803C 02000224 */   addiu     $v0, $zero, 0x2
    /* 38840 80048040 13006210 */  beq        $v1, $v0, .L80048090
    /* 38844 80048044 0180023C */   lui       $v0, %hi(D_800122A4)
    /* 38848 80048048 2C200108 */  j          .L800480B0
    /* 3884C 8004804C A4224224 */   addiu     $v0, $v0, %lo(D_800122A4)
  .L80048050:
    /* 38850 80048050 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 38854 80048054 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 38858 80048058 21288002 */  addu       $a1, $s4, $zero
    /* 3885C 8004805C 21300000 */  addu       $a2, $zero, $zero
    /* 38860 80048060 0580103C */  lui        $s0, %hi(congratsSwapFileName)
    /* 38864 80048064 54291026 */  addiu      $s0, $s0, %lo(congratsSwapFileName)
    /* 38868 80048068 21380002 */  addu       $a3, $s0, $zero
    /* 3886C 8004806C 20000224 */  addiu      $v0, $zero, 0x20
    /* 38870 80048070 0000E2A6 */  sh         $v0, 0x0($s7)
    /* 38874 80048074 20000224 */  addiu      $v0, $zero, 0x20
    /* 38878 80048078 740062AE */  sw         $v0, 0x74($s3)
    /* 3887C 8004807C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 38880 80048080 D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 38884 80048084 1000A2AF */   sw        $v0, 0x10($sp)
    /* 38888 80048088 2E200108 */  j          .L800480B8
    /* 3888C 8004808C 0000D0AE */   sw        $s0, 0x0($s6)
  .L80048090:
    /* 38890 80048090 0A000224 */  addiu      $v0, $zero, 0xA
    /* 38894 80048094 0000E2A6 */  sh         $v0, 0x0($s7)
    /* 38898 80048098 0A000224 */  addiu      $v0, $zero, 0xA
    /* 3889C 8004809C 740062AE */  sw         $v0, 0x74($s3)
    /* 388A0 800480A0 0180023C */  lui        $v0, %hi(D_8001229C)
    /* 388A4 800480A4 9C224224 */  addiu      $v0, $v0, %lo(D_8001229C)
    /* 388A8 800480A8 2E200108 */  j          .L800480B8
    /* 388AC 800480AC 0000C2AE */   sw        $v0, 0x0($s6)
  .L800480B0:
    /* 388B0 800480B0 0000C2AE */  sw         $v0, 0x0($s6)
    /* 388B4 800480B4 0000E0A6 */  sh         $zero, 0x0($s7)
  .L800480B8:
    /* 388B8 800480B8 3800BF8F */  lw         $ra, 0x38($sp)
    /* 388BC 800480BC 3400B78F */  lw         $s7, 0x34($sp)
    /* 388C0 800480C0 3000B68F */  lw         $s6, 0x30($sp)
    /* 388C4 800480C4 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 388C8 800480C8 2800B48F */  lw         $s4, 0x28($sp)
    /* 388CC 800480CC 2400B38F */  lw         $s3, 0x24($sp)
    /* 388D0 800480D0 2000B28F */  lw         $s2, 0x20($sp)
    /* 388D4 800480D4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 388D8 800480D8 1800B08F */  lw         $s0, 0x18($sp)
    /* 388DC 800480DC 0800E003 */  jr         $ra
    /* 388E0 800480E0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel GetShapeInfo__15tScreenCongratsRsT1PPcT3
