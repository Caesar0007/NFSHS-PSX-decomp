.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__24tListIteratorMultiPlayer7tPlayer, 0x28

glabel Value__24tListIteratorMultiPlayer7tPlayer
    /* 14BB8 800243B8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 14BBC 800243BC 0200A214 */  bne        $a1, $v0, .L800243C8
    /* 14BC0 800243C0 00000000 */   nop
    /* 14BC4 800243C4 21280000 */  addu       $a1, $zero, $zero
  .L800243C8:
    /* 14BC8 800243C8 0400828C */  lw         $v0, 0x4($a0)
    /* 14BCC 800243CC 00000000 */  nop
    /* 14BD0 800243D0 21104500 */  addu       $v0, $v0, $a1
    /* 14BD4 800243D4 00004290 */  lbu        $v0, 0x0($v0)
    /* 14BD8 800243D8 0800E003 */  jr         $ra
    /* 14BDC 800243DC 00000000 */   nop
endlabel Value__24tListIteratorMultiPlayer7tPlayer
