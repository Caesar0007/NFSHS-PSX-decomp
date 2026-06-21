.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__18tListIteratorRange7tPlayer, 0x28

glabel Decrement__18tListIteratorRange7tPlayer
    /* 14DFC 800245FC 0400858C */  lw         $a1, 0x4($a0)
    /* 14E00 80024600 08008290 */  lbu        $v0, 0x8($a0)
    /* 14E04 80024604 0000A390 */  lbu        $v1, 0x0($a1)
    /* 14E08 80024608 00000000 */  nop
    /* 14E0C 8002460C 2B104300 */  sltu       $v0, $v0, $v1
    /* 14E10 80024610 02004010 */  beqz       $v0, .L8002461C
    /* 14E14 80024614 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* 14E18 80024618 0000A2A0 */  sb         $v0, 0x0($a1)
  .L8002461C:
    /* 14E1C 8002461C 0800E003 */  jr         $ra
    /* 14E20 80024620 00000000 */   nop
endlabel Decrement__18tListIteratorRange7tPlayer
