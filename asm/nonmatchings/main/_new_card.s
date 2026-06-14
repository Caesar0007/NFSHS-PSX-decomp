.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _new_card, 0xC

glabel _new_card
    /* FA890 8010A090 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA894 8010A094 08004001 */  jr         $t2
    /* FA898 8010A098 50000924 */   addiu     $t1, $zero, 0x50
endlabel _new_card
    /* FA89C 8010A09C 00000000 */  nop
