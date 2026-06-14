.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindClosestLocationTo__Q26Speech15DispatchSpeakeri, 0x28

glabel FindClosestLocationTo__Q26Speech15DispatchSpeakeri
    /* 89B00 80099300 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 89B04 80099304 3808848F */  lw         $a0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89B08 80099308 2130A000 */  addu       $a2, $a1, $zero
    /* 89B0C 8009930C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 89B10 80099310 4052020C */  jal        FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki
    /* 89B14 80099314 D8018524 */   addiu     $a1, $a0, 0x1D8
    /* 89B18 80099318 1000BF8F */  lw         $ra, 0x10($sp)
    /* 89B1C 8009931C 00000000 */  nop
    /* 89B20 80099320 0800E003 */  jr         $ra
    /* 89B24 80099324 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FindClosestLocationTo__Q26Speech15DispatchSpeakeri
