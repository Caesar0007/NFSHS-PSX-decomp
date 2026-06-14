.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching EnableEvent, 0xC

glabel EnableEvent
    /* F7610 80106E10 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F7614 80106E14 08004001 */  jr         $t2
    /* F7618 80106E18 0C000924 */   addiu     $t1, $zero, 0xC
endlabel EnableEvent
    /* F761C 80106E1C 00000000 */  nop
