.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__10tMenuBlank, 0x8

glabel DebounceKeys__10tMenuBlank
    /* C1D4 8001B9D4 0800E003 */  jr         $ra
    /* C1D8 8001B9D8 FFFF0224 */   addiu     $v0, $zero, -0x1
endlabel DebounceKeys__10tMenuBlank
