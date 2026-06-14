.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Unit__Q26Speech13MobileSpeaker, 0xC

glabel Unit__Q26Speech13MobileSpeaker
    /* 89A74 80099274 5C00828C */  lw         $v0, 0x5C($a0)
    /* 89A78 80099278 0800E003 */  jr         $ra
    /* 89A7C 8009927C 00000000 */   nop
endlabel Unit__Q26Speech13MobileSpeaker
