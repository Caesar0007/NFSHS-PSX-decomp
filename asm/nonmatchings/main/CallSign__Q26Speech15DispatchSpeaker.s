.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CallSign__Q26Speech15DispatchSpeaker, 0xC

glabel CallSign__Q26Speech15DispatchSpeaker
    /* 89AF4 800992F4 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89AF8 800992F8 0800E003 */  jr         $ra
    /* 89AFC 800992FC 1C034224 */   addiu     $v0, $v0, 0x31C
endlabel CallSign__Q26Speech15DispatchSpeaker
