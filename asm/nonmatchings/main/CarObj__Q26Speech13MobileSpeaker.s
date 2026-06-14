.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarObj__Q26Speech13MobileSpeaker, 0xC

glabel CarObj__Q26Speech13MobileSpeaker
    /* 89ACC 800992CC 6000828C */  lw         $v0, 0x60($a0)
    /* 89AD0 800992D0 0800E003 */  jr         $ra
    /* 89AD4 800992D4 00000000 */   nop
endlabel CarObj__Q26Speech13MobileSpeaker
