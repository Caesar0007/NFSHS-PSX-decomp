.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetAvailableText__10tVideoWallsss, 0x1C

glabel SetAvailableText__10tVideoWallsss
    /* 2718C 8003698C 01000224 */  addiu      $v0, $zero, 0x1
    /* 27190 80036990 1C0085A4 */  sh         $a1, 0x1C($a0)
    /* 27194 80036994 240086A4 */  sh         $a2, 0x24($a0)
    /* 27198 80036998 260087A4 */  sh         $a3, 0x26($a0)
    /* 2719C 8003699C 200080A4 */  sh         $zero, 0x20($a0)
    /* 271A0 800369A0 0800E003 */  jr         $ra
    /* 271A4 800369A4 1E0082A4 */   sh        $v0, 0x1E($a0)
endlabel SetAvailableText__10tVideoWallsss
