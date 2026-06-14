.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Get__23AIDataRecord_AccTable_ti, 0x18

glabel Get__23AIDataRecord_AccTable_ti
    /* 5D9F4 8006D1F4 4800828C */  lw         $v0, 0x48($a0)
    /* 5D9F8 8006D1F8 40280500 */  sll        $a1, $a1, 1
    /* 5D9FC 8006D1FC 2128A200 */  addu       $a1, $a1, $v0
    /* 5DA00 8006D200 0000A284 */  lh         $v0, 0x0($a1)
    /* 5DA04 8006D204 0800E003 */  jr         $ra
    /* 5DA08 8006D208 00120200 */   sll       $v0, $v0, 8
endlabel Get__23AIDataRecord_AccTable_ti
