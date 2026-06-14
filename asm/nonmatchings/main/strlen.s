.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strlen, 0xC

glabel strlen
    /* DA774 800E9F74 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* DA778 800E9F78 08004001 */  jr         $t2
    /* DA77C 800E9F7C 1B000924 */   addiu     $t1, $zero, 0x1B
endlabel strlen
    /* DA780 800E9F80 00000000 */  nop
