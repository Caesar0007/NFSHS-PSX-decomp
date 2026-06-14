.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strstr, 0xC

glabel strstr
    /* D6ACC 800E62CC A0000A24 */  addiu      $t2, $zero, 0xA0
    /* D6AD0 800E62D0 08004001 */  jr         $t2
    /* D6AD4 800E62D4 24000924 */   addiu     $t1, $zero, 0x24
endlabel strstr
    /* D6AD8 800E62D8 00000000 */  nop
