.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetRezIndex__Fi, 0x20

glabel GetRezIndex__Fi
    /* 6E554 8007DD54 4402828F */  lw         $v0, %gp_rel(gCurrContext)($gp)
    /* 6E558 8007DD58 00000000 */  nop
    /* 6E55C 8007DD5C 9400428C */  lw         $v0, 0x94($v0)
    /* 6E560 8007DD60 00000000 */  nop
    /* 6E564 8007DD64 2A104400 */  slt        $v0, $v0, $a0
    /* 6E568 8007DD68 01004238 */  xori       $v0, $v0, 0x1
    /* 6E56C 8007DD6C 0800E003 */  jr         $ra
    /* 6E570 8007DD70 80100200 */   sll       $v0, $v0, 2
endlabel GetRezIndex__Fi
