.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadTrophy__17tScreenTrophyRoom, 0xD8

glabel LoadTrophy__17tScreenTrophyRoom
    /* 3172C 80040F2C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 31730 80040F30 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 31734 80040F34 21888000 */  addu       $s1, $a0, $zero
    /* 31738 80040F38 2000BFAF */  sw         $ra, 0x20($sp)
    /* 3173C 80040F3C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 31740 80040F40 D000228E */  lw         $v0, 0xD0($s1)
    /* 31744 80040F44 00000000 */  nop
    /* 31748 80040F48 40100200 */  sll        $v0, $v0, 1
    /* 3174C 80040F4C 21282202 */  addu       $a1, $s1, $v0
    /* 31750 80040F50 D400A384 */  lh         $v1, 0xD4($a1)
    /* 31754 80040F54 9C002292 */  lbu        $v0, 0x9C($s1)
    /* 31758 80040F58 00000000 */  nop
    /* 3175C 80040F5C 24006210 */  beq        $v1, $v0, .L80040FF0
    /* 31760 80040F60 1180023C */   lui       $v0, %hi(D_80114722)
    /* 31764 80040F64 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 31768 80040F68 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 3176C 80040F6C 0580103C */  lui        $s0, %hi(gSwapFileName)
    /* 31770 80040F70 64201026 */  addiu      $s0, $s0, %lo(gSwapFileName)
    /* 31774 80040F74 21380002 */  addu       $a3, $s0, $zero
    /* 31778 80040F78 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 3177C 80040F7C 1800868C */  lw         $a2, 0x18($a0)
    /* 31780 80040F80 D400A590 */  lbu        $a1, 0xD4($a1)
    /* 31784 80040F84 40100300 */  sll        $v0, $v1, 1
    /* 31788 80040F88 21104300 */  addu       $v0, $v0, $v1
    /* 3178C 80040F8C 80100200 */  sll        $v0, $v0, 2
    /* 31790 80040F90 2110C200 */  addu       $v0, $a2, $v0
    /* 31794 80040F94 02004390 */  lbu        $v1, 0x2($v0)
    /* 31798 80040F98 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3179C 80040F9C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 317A0 80040FA0 21186500 */  addu       $v1, $v1, $a1
    /* 317A4 80040FA4 80280300 */  sll        $a1, $v1, 2
    /* 317A8 80040FA8 2128A300 */  addu       $a1, $a1, $v1
    /* 317AC 80040FAC 80280500 */  sll        $a1, $a1, 2
    /* 317B0 80040FB0 2128A300 */  addu       $a1, $a1, $v1
    /* 317B4 80040FB4 80280500 */  sll        $a1, $a1, 2
    /* 317B8 80040FB8 2400A524 */  addiu      $a1, $a1, 0x24
    /* 317BC 80040FBC 2128C500 */  addu       $a1, $a2, $a1
    /* 317C0 80040FC0 D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 317C4 80040FC4 21300000 */   addu      $a2, $zero, $zero
    /* 317C8 80040FC8 21202002 */  addu       $a0, $s1, $zero
    /* 317CC 80040FCC 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 317D0 80040FD0 21280002 */   addu      $a1, $s0, $zero
    /* 317D4 80040FD4 D000228E */  lw         $v0, 0xD0($s1)
    /* 317D8 80040FD8 00000000 */  nop
    /* 317DC 80040FDC 40100200 */  sll        $v0, $v0, 1
    /* 317E0 80040FE0 21102202 */  addu       $v0, $s1, $v0
    /* 317E4 80040FE4 D4004290 */  lbu        $v0, 0xD4($v0)
    /* 317E8 80040FE8 00000000 */  nop
    /* 317EC 80040FEC 9C0022A2 */  sb         $v0, 0x9C($s1)
  .L80040FF0:
    /* 317F0 80040FF0 2000BF8F */  lw         $ra, 0x20($sp)
    /* 317F4 80040FF4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 317F8 80040FF8 1800B08F */  lw         $s0, 0x18($sp)
    /* 317FC 80040FFC 0800E003 */  jr         $ra
    /* 31800 80041000 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel LoadTrophy__17tScreenTrophyRoom
    /* 31804 80041004 00000000 */  nop
