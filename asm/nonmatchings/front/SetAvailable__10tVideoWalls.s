.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetAvailable__10tVideoWalls, 0x8

glabel SetAvailable__10tVideoWalls
    /* 271D4 800369D4 0800E003 */  jr         $ra
    /* 271D8 800369D8 1E0085A4 */   sh        $a1, 0x1E($a0)
endlabel SetAvailable__10tVideoWalls
