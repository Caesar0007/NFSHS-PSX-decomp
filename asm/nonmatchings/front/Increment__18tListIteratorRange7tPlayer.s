.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__18tListIteratorRange7tPlayer, 0x28

glabel Increment__18tListIteratorRange7tPlayer
    /* 14DD4 800245D4 0400858C */  lw         $a1, 0x4($a0)
    /* 14DD8 800245D8 09008290 */  lbu        $v0, 0x9($a0)
    /* 14DDC 800245DC 0000A390 */  lbu        $v1, 0x0($a1)
    /* 14DE0 800245E0 00000000 */  nop
    /* 14DE4 800245E4 2B106200 */  sltu       $v0, $v1, $v0
    /* 14DE8 800245E8 02004010 */  beqz       $v0, .L800245F4
    /* 14DEC 800245EC 01006224 */   addiu     $v0, $v1, 0x1
    /* 14DF0 800245F0 0000A2A0 */  sb         $v0, 0x0($a1)
  .L800245F4:
    /* 14DF4 800245F4 0800E003 */  jr         $ra
    /* 14DF8 800245F8 00000000 */   nop
endlabel Increment__18tListIteratorRange7tPlayer
