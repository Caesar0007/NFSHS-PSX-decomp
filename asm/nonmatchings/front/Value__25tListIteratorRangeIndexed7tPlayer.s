.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__25tListIteratorRangeIndexed7tPlayer, 0x24

glabel Value__25tListIteratorRangeIndexed7tPlayer
    /* 14E98 80024698 1000828C */  lw         $v0, 0x10($a0)
    /* 14E9C 8002469C 00000000 */  nop
    /* 14EA0 800246A0 00004390 */  lbu        $v1, 0x0($v0)
    /* 14EA4 800246A4 0400828C */  lw         $v0, 0x4($a0)
    /* 14EA8 800246A8 00000000 */  nop
    /* 14EAC 800246AC 21104300 */  addu       $v0, $v0, $v1
    /* 14EB0 800246B0 00004290 */  lbu        $v0, 0x0($v0)
    /* 14EB4 800246B4 0800E003 */  jr         $ra
    /* 14EB8 800246B8 00000000 */   nop
endlabel Value__25tListIteratorRangeIndexed7tPlayer
