.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitHeap, 0xC

glabel InitHeap
    /* EE518 800FDD18 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* EE51C 800FDD1C 08004001 */  jr         $t2
    /* EE520 800FDD20 39000924 */   addiu     $t1, $zero, 0x39
endlabel InitHeap
    /* EE524 800FDD24 00000000 */  nop
