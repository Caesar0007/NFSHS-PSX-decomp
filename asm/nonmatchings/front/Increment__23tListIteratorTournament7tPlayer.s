.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__23tListIteratorTournament7tPlayer, 0xA0

glabel Increment__23tListIteratorTournament7tPlayer
    /* 24680 80033E80 1180023C */  lui        $v0, %hi(D_80114722)
    /* 24684 80033E84 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 24688 80033E88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2468C 80033E8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 24690 80033E90 21808000 */  addu       $s0, $a0, $zero
    /* 24694 80033E94 1800BFAF */  sw         $ra, 0x18($sp)
    /* 24698 80033E98 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2469C 80033E9C 1000048E */  lw         $a0, 0x10($s0)
    /* 246A0 80033EA0 40100300 */  sll        $v0, $v1, 1
    /* 246A4 80033EA4 21104300 */  addu       $v0, $v0, $v1
    /* 246A8 80033EA8 1800838C */  lw         $v1, 0x18($a0)
    /* 246AC 80033EAC 80100200 */  sll        $v0, $v0, 2
    /* 246B0 80033EB0 21886200 */  addu       $s1, $v1, $v0
  .L80033EB4:
    /* 246B4 80033EB4 0400038E */  lw         $v1, 0x4($s0)
    /* 246B8 80033EB8 00000000 */  nop
    /* 246BC 80033EBC 00006290 */  lbu        $v0, 0x0($v1)
    /* 246C0 80033EC0 00000000 */  nop
    /* 246C4 80033EC4 01004224 */  addiu      $v0, $v0, 0x1
    /* 246C8 80033EC8 000062A0 */  sb         $v0, 0x0($v1)
    /* 246CC 80033ECC 0400048E */  lw         $a0, 0x4($s0)
    /* 246D0 80033ED0 00002392 */  lbu        $v1, 0x0($s1)
    /* 246D4 80033ED4 00008290 */  lbu        $v0, 0x0($a0)
    /* 246D8 80033ED8 00000000 */  nop
    /* 246DC 80033EDC 2B104300 */  sltu       $v0, $v0, $v1
    /* 246E0 80033EE0 02004014 */  bnez       $v0, .L80033EEC
    /* 246E4 80033EE4 00000000 */   nop
    /* 246E8 80033EE8 000080A0 */  sb         $zero, 0x0($a0)
  .L80033EEC:
    /* 246EC 80033EEC 0400028E */  lw         $v0, 0x4($s0)
    /* 246F0 80033EF0 00000000 */  nop
    /* 246F4 80033EF4 00004590 */  lbu        $a1, 0x0($v0)
    /* 246F8 80033EF8 ECCF000C */  jal        ValidTournament__23tListIteratorTournamentc
    /* 246FC 80033EFC 21200002 */   addu      $a0, $s0, $zero
    /* 24700 80033F00 01004238 */  xori       $v0, $v0, 0x1
    /* 24704 80033F04 EBFF4014 */  bnez       $v0, .L80033EB4
    /* 24708 80033F08 00000000 */   nop
    /* 2470C 80033F0C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 24710 80033F10 1400B18F */  lw         $s1, 0x14($sp)
    /* 24714 80033F14 1000B08F */  lw         $s0, 0x10($sp)
    /* 24718 80033F18 0800E003 */  jr         $ra
    /* 2471C 80033F1C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Increment__23tListIteratorTournament7tPlayer
