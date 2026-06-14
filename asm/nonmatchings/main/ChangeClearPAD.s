.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ChangeClearPAD, 0xC

glabel ChangeClearPAD
    /* F6E54 80106654 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F6E58 80106658 08004001 */  jr         $t2
    /* F6E5C 8010665C 5B000924 */   addiu     $t1, $zero, 0x5B
endlabel ChangeClearPAD
    /* F6E60 80106660 00000000 */  nop
