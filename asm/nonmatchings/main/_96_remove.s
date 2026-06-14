.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _96_remove, 0xC

glabel _96_remove
    /* F7154 80106954 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F7158 80106958 08004001 */  jr         $t2
    /* F715C 8010695C 72000924 */   addiu     $t1, $zero, 0x72
endlabel _96_remove
    /* F7160 80106960 00000000 */  nop
    /* F7164 80106964 00000000 */  nop
    /* F7168 80106968 00000000 */  nop
