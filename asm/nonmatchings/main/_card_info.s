.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_info, 0xC

glabel _card_info
    /* FA510 80109D10 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* FA514 80109D14 08004001 */  jr         $t2
    /* FA518 80109D18 AB000924 */   addiu     $t1, $zero, 0xAB
endlabel _card_info
    /* FA51C 80109D1C 00000000 */  nop
