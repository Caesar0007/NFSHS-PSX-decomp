.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching tolower, 0xC

glabel tolower
    /* F3DA0 801035A0 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F3DA4 801035A4 08004001 */  jr         $t2
    /* F3DA8 801035A8 26000924 */   addiu     $t1, $zero, 0x26
endlabel tolower
    /* F3DAC 801035AC 00000000 */  nop
