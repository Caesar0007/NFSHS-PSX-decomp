.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TestEvent, 0xC

glabel TestEvent
    /* FD074 8010C874 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD078 8010C878 08004001 */  jr         $t2
    /* FD07C 8010C87C 0B000924 */   addiu     $t1, $zero, 0xB
endlabel TestEvent
    /* FD080 8010C880 00000000 */  nop
