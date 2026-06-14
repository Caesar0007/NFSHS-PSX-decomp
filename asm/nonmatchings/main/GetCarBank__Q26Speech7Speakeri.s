.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCarBank__Q26Speech7Speakeri, 0x8

glabel GetCarBank__Q26Speech7Speakeri
    /* 89B74 80099374 0800E003 */  jr         $ra
    /* 89B78 80099378 21100000 */   addu      $v0, $zero, $zero
endlabel GetCarBank__Q26Speech7Speakeri
