.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsDisabled__10tPMenuItem, 0xC

glabel IsDisabled__10tPMenuItem
    /* 98EBC 800A86BC 0000828C */  lw         $v0, 0x0($a0)
    /* 98EC0 800A86C0 0800E003 */  jr         $ra
    /* 98EC4 800A86C4 01004230 */   andi      $v0, $v0, 0x1
endlabel IsDisabled__10tPMenuItem
