.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_write, 0xC

glabel _card_write
    /* FA8A0 8010A0A0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA8A4 8010A0A4 08004001 */  jr         $t2
    /* FA8A8 8010A0A8 4E000924 */   addiu     $t1, $zero, 0x4E
endlabel _card_write
    /* FA8AC 8010A0AC 00000000 */  nop
