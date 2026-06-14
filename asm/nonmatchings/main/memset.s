.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memset, 0xC

glabel memset
    /* D4B18 800E4318 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* D4B1C 800E431C 08004001 */  jr         $t2
    /* D4B20 800E4320 2B000924 */   addiu     $t1, $zero, 0x2B
endlabel memset
    /* D4B24 800E4324 00000000 */  nop
