.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VoxSentence_GetNumPhrases, 0xC

glabel VoxSentence_GetNumPhrases
    /* F0F30 80100730 03008290 */  lbu        $v0, 0x3($a0)
    /* F0F34 80100734 0800E003 */  jr         $ra
    /* F0F38 80100738 82100200 */   srl       $v0, $v0, 2
endlabel VoxSentence_GetNumPhrases
