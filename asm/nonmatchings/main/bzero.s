.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching bzero, 0xC

glabel bzero
    /* FAD40 8010A540 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* FAD44 8010A544 08004001 */  jr         $t2
    /* FAD48 8010A548 28000924 */   addiu     $t1, $zero, 0x28
endlabel bzero
    /* FAD4C 8010A54C 00000000 */  nop
