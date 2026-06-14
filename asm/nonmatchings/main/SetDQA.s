.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching SetDQA, 0xC

glabel SetDQA
    /* F6E74 80106674 00D8C448 */  ctc2       $a0, $27 /* handwritten instruction */
    /* F6E78 80106678 0800E003 */  jr         $ra
    /* F6E7C 8010667C 00000000 */   nop
endlabel SetDQA
