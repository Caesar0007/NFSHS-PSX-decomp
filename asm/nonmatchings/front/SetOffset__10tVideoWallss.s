.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetOffset__10tVideoWallss, 0xC

glabel SetOffset__10tVideoWallss
    /* 271C8 800369C8 180085A4 */  sh         $a1, 0x18($a0)
    /* 271CC 800369CC 0800E003 */  jr         $ra
    /* 271D0 800369D0 1A0086A4 */   sh        $a2, 0x1A($a0)
endlabel SetOffset__10tVideoWallss
