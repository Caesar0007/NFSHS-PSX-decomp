.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__23tListIteratorTournament7tPlayer, 0x90

glabel Decrement__23tListIteratorTournament7tPlayer
    /* 24720 80033F20 1180023C */  lui        $v0, %hi(D_80114722)
    /* 24724 80033F24 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 24728 80033F28 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2472C 80033F2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 24730 80033F30 21808000 */  addu       $s0, $a0, $zero
    /* 24734 80033F34 1800BFAF */  sw         $ra, 0x18($sp)
    /* 24738 80033F38 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2473C 80033F3C 1000048E */  lw         $a0, 0x10($s0)
    /* 24740 80033F40 40100300 */  sll        $v0, $v1, 1
    /* 24744 80033F44 21104300 */  addu       $v0, $v0, $v1
    /* 24748 80033F48 1800838C */  lw         $v1, 0x18($a0)
    /* 2474C 80033F4C 80100200 */  sll        $v0, $v0, 2
    /* 24750 80033F50 21886200 */  addu       $s1, $v1, $v0
  .L80033F54:
    /* 24754 80033F54 0400038E */  lw         $v1, 0x4($s0)
    /* 24758 80033F58 00000000 */  nop
    /* 2475C 80033F5C 00006290 */  lbu        $v0, 0x0($v1)
    /* 24760 80033F60 00000000 */  nop
    /* 24764 80033F64 04004014 */  bnez       $v0, .L80033F78
    /* 24768 80033F68 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 2476C 80033F6C 00002292 */  lbu        $v0, 0x0($s1)
    /* 24770 80033F70 00000000 */  nop
    /* 24774 80033F74 FFFF4224 */  addiu      $v0, $v0, -0x1
  .L80033F78:
    /* 24778 80033F78 000062A0 */  sb         $v0, 0x0($v1)
    /* 2477C 80033F7C 0400028E */  lw         $v0, 0x4($s0)
    /* 24780 80033F80 00000000 */  nop
    /* 24784 80033F84 00004590 */  lbu        $a1, 0x0($v0)
    /* 24788 80033F88 ECCF000C */  jal        ValidTournament__23tListIteratorTournamentc
    /* 2478C 80033F8C 21200002 */   addu      $a0, $s0, $zero
    /* 24790 80033F90 01004238 */  xori       $v0, $v0, 0x1
    /* 24794 80033F94 EFFF4014 */  bnez       $v0, .L80033F54
    /* 24798 80033F98 00000000 */   nop
    /* 2479C 80033F9C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 247A0 80033FA0 1400B18F */  lw         $s1, 0x14($sp)
    /* 247A4 80033FA4 1000B08F */  lw         $s0, 0x10($sp)
    /* 247A8 80033FA8 0800E003 */  jr         $ra
    /* 247AC 80033FAC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Decrement__23tListIteratorTournament7tPlayer
