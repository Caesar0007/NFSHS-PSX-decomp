.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetValid__10tVideoWalls, 0x8

glabel SetValid__10tVideoWalls
    /* 271DC 800369DC 0800E003 */  jr         $ra
    /* 271E0 800369E0 220085A4 */   sh        $a1, 0x22($a0)
endlabel SetValid__10tVideoWalls
