.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__25tListIteratorRangeIndexed7tPlayer, 0x3C

glabel Decrement__25tListIteratorRangeIndexed7tPlayer
    /* 14EF8 800246F8 1000828C */  lw         $v0, 0x10($a0)
    /* 14EFC 800246FC 00000000 */  nop
    /* 14F00 80024700 00004390 */  lbu        $v1, 0x0($v0)
    /* 14F04 80024704 0400828C */  lw         $v0, 0x4($a0)
    /* 14F08 80024708 00000000 */  nop
    /* 14F0C 8002470C 21284300 */  addu       $a1, $v0, $v1
    /* 14F10 80024710 0000A390 */  lbu        $v1, 0x0($a1)
    /* 14F14 80024714 08008290 */  lbu        $v0, 0x8($a0)
    /* 14F18 80024718 00000000 */  nop
    /* 14F1C 8002471C 2B104300 */  sltu       $v0, $v0, $v1
    /* 14F20 80024720 02004010 */  beqz       $v0, .L8002472C
    /* 14F24 80024724 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* 14F28 80024728 0000A2A0 */  sb         $v0, 0x0($a1)
  .L8002472C:
    /* 14F2C 8002472C 0800E003 */  jr         $ra
    /* 14F30 80024730 00000000 */   nop
endlabel Decrement__25tListIteratorRangeIndexed7tPlayer
