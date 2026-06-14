.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SoundSpeech__Fv, 0x30

glabel AudioClc_SoundSpeech__Fv
    /* 66930 80076130 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 66934 80076134 1000BFAF */  sw         $ra, 0x10($sp)
    /* 66938 80076138 07DC010C */  jal        AudioCmn_SetLevels__Fv
    /* 6693C 8007613C 00000000 */   nop
    /* 66940 80076140 7E57020C */  jal        Speech_Server__Fv
    /* 66944 80076144 00000000 */   nop
    /* 66948 80076148 656A020C */  jal        CopSpeak_Server__Fv
    /* 6694C 8007614C 00000000 */   nop
    /* 66950 80076150 1000BF8F */  lw         $ra, 0x10($sp)
    /* 66954 80076154 00000000 */  nop
    /* 66958 80076158 0800E003 */  jr         $ra
    /* 6695C 8007615C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioClc_SoundSpeech__Fv
