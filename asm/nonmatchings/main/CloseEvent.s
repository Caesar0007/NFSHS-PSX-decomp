.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CloseEvent, 0xC

glabel CloseEvent
    /* FD064 8010C864 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD068 8010C868 08004001 */  jr         $t2
    /* FD06C 8010C86C 09000924 */   addiu     $t1, $zero, 0x9
endlabel CloseEvent
    /* FD070 8010C870 00000000 */  nop
