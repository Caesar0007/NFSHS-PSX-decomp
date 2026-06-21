.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__13tListIterator7tPlayer, 0x88

glabel Decrement__13tListIterator7tPlayer
    /* 146D8 80023ED8 0400838C */  lw         $v1, 0x4($a0)
    /* 146DC 80023EDC 00000000 */  nop
    /* 146E0 80023EE0 00006290 */  lbu        $v0, 0x0($v1)
    /* 146E4 80023EE4 00000000 */  nop
    /* 146E8 80023EE8 19004014 */  bnez       $v0, .L80023F50
    /* 146EC 80023EEC 21286000 */   addu      $a1, $v1, $zero
    /* 146F0 80023EF0 FF004230 */  andi       $v0, $v0, 0xFF
    /* 146F4 80023EF4 0000838C */  lw         $v1, 0x0($a0)
    /* 146F8 80023EF8 40100200 */  sll        $v0, $v0, 1
    /* 146FC 80023EFC 21104300 */  addu       $v0, $v0, $v1
    /* 14700 80023F00 02004284 */  lh         $v0, 0x2($v0)
    /* 14704 80023F04 00000000 */  nop
    /* 14708 80023F08 13004018 */  blez       $v0, .L80023F58
    /* 1470C 80023F0C 00000000 */   nop
  .L80023F10:
    /* 14710 80023F10 0000A290 */  lbu        $v0, 0x0($a1)
    /* 14714 80023F14 00000000 */  nop
    /* 14718 80023F18 01004224 */  addiu      $v0, $v0, 0x1
    /* 1471C 80023F1C 0000A2A0 */  sb         $v0, 0x0($a1)
    /* 14720 80023F20 0400858C */  lw         $a1, 0x4($a0)
    /* 14724 80023F24 00000000 */  nop
    /* 14728 80023F28 0000A290 */  lbu        $v0, 0x0($a1)
    /* 1472C 80023F2C 0000838C */  lw         $v1, 0x0($a0)
    /* 14730 80023F30 40100200 */  sll        $v0, $v0, 1
    /* 14734 80023F34 21104300 */  addu       $v0, $v0, $v1
    /* 14738 80023F38 02004284 */  lh         $v0, 0x2($v0)
    /* 1473C 80023F3C 00000000 */  nop
    /* 14740 80023F40 F3FF401C */  bgtz       $v0, .L80023F10
    /* 14744 80023F44 00000000 */   nop
    /* 14748 80023F48 0800E003 */  jr         $ra
    /* 1474C 80023F4C 00000000 */   nop
  .L80023F50:
    /* 14750 80023F50 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 14754 80023F54 000062A0 */  sb         $v0, 0x0($v1)
  .L80023F58:
    /* 14758 80023F58 0800E003 */  jr         $ra
    /* 1475C 80023F5C 00000000 */   nop
endlabel Decrement__13tListIterator7tPlayer
