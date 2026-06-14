.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetVoice__6SpeechP8Car_tObj, 0x28

glabel GetVoice__6SpeechP8Car_tObj
    /* 87DF8 800975F8 21288000 */  addu       $a1, $a0, $zero
    /* 87DFC 800975FC 3808848F */  lw         $a0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 87E00 80097600 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 87E04 80097604 1000BFAF */  sw         $ra, 0x10($sp)
    /* 87E08 80097608 575D020C */  jal        PickVoice__6SpeechP8Car_tObj
    /* 87E0C 8009760C 00000000 */   nop
    /* 87E10 80097610 1000BF8F */  lw         $ra, 0x10($sp)
    /* 87E14 80097614 00000000 */  nop
    /* 87E18 80097618 0800E003 */  jr         $ra
    /* 87E1C 8009761C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetVoice__6SpeechP8Car_tObj
