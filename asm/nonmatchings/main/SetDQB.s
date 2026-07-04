.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDQB, 0xC

glabel SetDQB
    /* F6E80 80106680 00E0C448 */  ctc2       $a0, $28 /* handwritten instruction */
    /* F6E84 80106684 0800E003 */  jr         $ra
    /* F6E88 80106688 00000000 */   nop
endlabel SetDQB
