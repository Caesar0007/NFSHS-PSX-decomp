.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindClosestLocationTo__Q26Speech13MobileSpeakeri, 0x28

glabel FindClosestLocationTo__Q26Speech13MobileSpeakeri
    /* 89A8C 8009928C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 89A90 80099290 3808848F */  lw         $a0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89A94 80099294 2130A000 */  addu       $a2, $a1, $zero
    /* 89A98 80099298 1000BFAF */  sw         $ra, 0x10($sp)
    /* 89A9C 8009929C 4052020C */  jal        FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki
    /* 89AA0 800992A0 D8008524 */   addiu     $a1, $a0, 0xD8
    /* 89AA4 800992A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 89AA8 800992A8 00000000 */  nop
    /* 89AAC 800992AC 0800E003 */  jr         $ra
    /* 89AB0 800992B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FindClosestLocationTo__Q26Speech13MobileSpeakeri
