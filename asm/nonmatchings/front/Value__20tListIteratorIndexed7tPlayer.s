.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__20tListIteratorIndexed7tPlayer, 0x24

glabel Value__20tListIteratorIndexed7tPlayer
    /* 147CC 80023FCC 1000828C */  lw         $v0, 0x10($a0)
    /* 147D0 80023FD0 00000000 */  nop
    /* 147D4 80023FD4 00004390 */  lbu        $v1, 0x0($v0)
    /* 147D8 80023FD8 0400828C */  lw         $v0, 0x4($a0)
    /* 147DC 80023FDC 00000000 */  nop
    /* 147E0 80023FE0 21104300 */  addu       $v0, $v0, $v1
    /* 147E4 80023FE4 00004290 */  lbu        $v0, 0x0($v0)
    /* 147E8 80023FE8 0800E003 */  jr         $ra
    /* 147EC 80023FEC 00000000 */   nop
endlabel Value__20tListIteratorIndexed7tPlayer
