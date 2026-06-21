.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawCongratsMessage__25tScreenTournamentCongrats, 0xCC

glabel DrawCongratsMessage__25tScreenTournamentCongrats
    /* 39ED4 800496D4 58FEBD27 */  addiu      $sp, $sp, -0x1A8
    /* 39ED8 800496D8 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 39EDC 800496DC D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 39EE0 800496E0 1800A527 */  addiu      $a1, $sp, 0x18
    /* 39EE4 800496E4 29000224 */  addiu      $v0, $zero, 0x29
    /* 39EE8 800496E8 1000A2A7 */  sh         $v0, 0x10($sp)
    /* 39EEC 800496EC 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 39EF0 800496F0 1200A2A7 */  sh         $v0, 0x12($sp)
    /* 39EF4 800496F4 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 39EF8 800496F8 1400A2A7 */  sh         $v0, 0x14($sp)
    /* 39EFC 800496FC 90010224 */  addiu      $v0, $zero, 0x190
    /* 39F00 80049700 A401BFAF */  sw         $ra, 0x1A4($sp)
    /* 39F04 80049704 A001B0AF */  sw         $s0, 0x1A0($sp)
    /* 39F08 80049708 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 39F0C 8004970C 1600A2A7 */   sh        $v0, 0x16($sp)
    /* 39F10 80049710 4C00A487 */  lh         $a0, 0x4C($sp)
    /* 39F14 80049714 94E4020C */  jal        TextSys_Word__Fi
    /* 39F18 80049718 00000000 */   nop
    /* 39F1C 8004971C 21204000 */  addu       $a0, $v0, $zero
    /* 39F20 80049720 1000A527 */  addiu      $a1, $sp, 0x10
    /* 39F24 80049724 01000624 */  addiu      $a2, $zero, 0x1
    /* 39F28 80049728 FA85000C */  jal        FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
    /* 39F2C 8004972C 0A000724 */   addiu     $a3, $zero, 0xA
    /* 39F30 80049730 5400A28F */  lw         $v0, 0x54($sp)
    /* 39F34 80049734 00000000 */  nop
    /* 39F38 80049738 15004010 */  beqz       $v0, .L80049790
    /* 39F3C 8004973C 6001B027 */   addiu     $s0, $sp, 0x160
    /* 39F40 80049740 21200002 */  addu       $a0, $s0, $zero
    /* 39F44 80049744 5800A58F */  lw         $a1, 0x58($sp)
    /* 39F48 80049748 B4000224 */  addiu      $v0, $zero, 0xB4
    /* 39F4C 8004974C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* 39F50 80049750 AE010224 */  addiu      $v0, $zero, 0x1AE
    /* 39F54 80049754 389B000C */  jal        FeTools_FormatMoney__FPcl
    /* 39F58 80049758 1400A2A7 */   sh        $v0, 0x14($sp)
    /* 39F5C 8004975C 94E4020C */  jal        TextSys_Word__Fi
    /* 39F60 80049760 40000424 */   addiu     $a0, $zero, 0x40
    /* 39F64 80049764 6000A427 */  addiu      $a0, $sp, 0x60
    /* 39F68 80049768 21284000 */  addu       $a1, $v0, $zero
    /* 39F6C 8004976C 2F91030C */  jal        sprintf
    /* 39F70 80049770 21300002 */   addu      $a2, $s0, $zero
    /* 39F74 80049774 94E4020C */  jal        TextSys_Word__Fi
    /* 39F78 80049778 40000424 */   addiu     $a0, $zero, 0x40
    /* 39F7C 8004977C 21204000 */  addu       $a0, $v0, $zero
    /* 39F80 80049780 1000A527 */  addiu      $a1, $sp, 0x10
    /* 39F84 80049784 01000624 */  addiu      $a2, $zero, 0x1
    /* 39F88 80049788 FA85000C */  jal        FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
    /* 39F8C 8004978C 0A000724 */   addiu     $a3, $zero, 0xA
  .L80049790:
    /* 39F90 80049790 A401BF8F */  lw         $ra, 0x1A4($sp)
    /* 39F94 80049794 A001B08F */  lw         $s0, 0x1A0($sp)
    /* 39F98 80049798 0800E003 */  jr         $ra
    /* 39F9C 8004979C A801BD27 */   addiu     $sp, $sp, 0x1A8
endlabel DrawCongratsMessage__25tScreenTournamentCongrats
