.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__9tMenuItem, 0x8

glabel DebounceKeys__9tMenuItem
    /* 14F98 80024798 0800E003 */  jr         $ra
    /* 14F9C 8002479C FFFF0224 */   addiu     $v0, $zero, -0x1
endlabel DebounceKeys__9tMenuItem
