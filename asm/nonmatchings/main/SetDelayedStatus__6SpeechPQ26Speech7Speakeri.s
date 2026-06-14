.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDelayedStatus__6SpeechPQ26Speech7Speakeri, 0x20

glabel SetDelayedStatus__6SpeechPQ26Speech7Speakeri
    /* 86634 80095E34 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 86638 80095E38 00000000 */  nop
    /* 8663C 80095E3C A003438C */  lw         $v1, 0x3A0($v0)
    /* 86640 80095E40 00000000 */  nop
    /* 86644 80095E44 540065AC */  sw         $a1, 0x54($v1)
    /* 86648 80095E48 A003428C */  lw         $v0, 0x3A0($v0)
    /* 8664C 80095E4C 0800E003 */  jr         $ra
    /* 86650 80095E50 500046AC */   sw        $a2, 0x50($v0)
endlabel SetDelayedStatus__6SpeechPQ26Speech7Speakeri
