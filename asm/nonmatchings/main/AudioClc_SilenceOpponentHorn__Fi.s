.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SilenceOpponentHorn__Fi, 0x20

glabel AudioClc_SilenceOpponentHorn__Fi
    /* 65808 80075008 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6580C 8007500C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 65810 80075010 34E0010C */  jal        freeVoiceChannel__Fi
    /* 65814 80075014 25008424 */   addiu     $a0, $a0, 0x25
    /* 65818 80075018 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6581C 8007501C 00000000 */  nop
    /* 65820 80075020 0800E003 */  jr         $ra
    /* 65824 80075024 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioClc_SilenceOpponentHorn__Fi
