.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__25tListIteratorRangeIndexed7tPlayer, 0x3C

glabel Increment__25tListIteratorRangeIndexed7tPlayer
    /* 14EBC 800246BC 1000828C */  lw         $v0, 0x10($a0)
    /* 14EC0 800246C0 00000000 */  nop
    /* 14EC4 800246C4 00004390 */  lbu        $v1, 0x0($v0)
    /* 14EC8 800246C8 0400828C */  lw         $v0, 0x4($a0)
    /* 14ECC 800246CC 00000000 */  nop
    /* 14ED0 800246D0 21284300 */  addu       $a1, $v0, $v1
    /* 14ED4 800246D4 0000A390 */  lbu        $v1, 0x0($a1)
    /* 14ED8 800246D8 09008290 */  lbu        $v0, 0x9($a0)
    /* 14EDC 800246DC 00000000 */  nop
    /* 14EE0 800246E0 2B106200 */  sltu       $v0, $v1, $v0
    /* 14EE4 800246E4 02004010 */  beqz       $v0, .L800246F0
    /* 14EE8 800246E8 01006224 */   addiu     $v0, $v1, 0x1
    /* 14EEC 800246EC 0000A2A0 */  sb         $v0, 0x0($a1)
  .L800246F0:
    /* 14EF0 800246F0 0800E003 */  jr         $ra
    /* 14EF4 800246F4 00000000 */   nop
endlabel Increment__25tListIteratorRangeIndexed7tPlayer
