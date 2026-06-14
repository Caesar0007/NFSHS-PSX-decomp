.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_load, 0xC

glabel _card_load
    /* FA560 80109D60 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* FA564 80109D64 08004001 */  jr         $t2
    /* FA568 80109D68 AC000924 */   addiu     $t1, $zero, 0xAC
endlabel _card_load
    /* FA56C 80109D6C 00000000 */  nop
