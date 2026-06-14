.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsEnabled__10tPMenuItem, 0x14

glabel IsEnabled__10tPMenuItem
    /* 98EA8 800A86A8 0000828C */  lw         $v0, 0x0($a0)
    /* 98EAC 800A86AC 00000000 */  nop
    /* 98EB0 800A86B0 01004238 */  xori       $v0, $v0, 0x1
    /* 98EB4 800A86B4 0800E003 */  jr         $ra
    /* 98EB8 800A86B8 01004230 */   andi      $v0, $v0, 0x1
endlabel IsEnabled__10tPMenuItem
