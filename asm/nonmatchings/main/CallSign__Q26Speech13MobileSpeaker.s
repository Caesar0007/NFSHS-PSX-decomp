.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CallSign__Q26Speech13MobileSpeaker, 0xC

glabel CallSign__Q26Speech13MobileSpeaker
    /* 89A80 80099280 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89A84 80099284 0800E003 */  jr         $ra
    /* 89A88 80099288 D8024224 */   addiu     $v0, $v0, 0x2D8
endlabel CallSign__Q26Speech13MobileSpeaker
