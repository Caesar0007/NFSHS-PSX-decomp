.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DisableEvent, 0xC

glabel DisableEvent
    /* F7630 80106E30 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F7634 80106E34 08004001 */  jr         $t2
    /* F7638 80106E38 0D000924 */   addiu     $t1, $zero, 0xD
endlabel DisableEvent
    /* F763C 80106E3C 00000000 */  nop
