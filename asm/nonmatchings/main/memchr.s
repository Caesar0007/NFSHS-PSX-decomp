.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memchr, 0xC

glabel memchr
    /* EEB88 800FE388 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* EEB8C 800FE38C 08004001 */  jr         $t2
    /* EEB90 800FE390 2E000924 */   addiu     $t1, $zero, 0x2E
endlabel memchr
    /* EEB94 800FE394 00000000 */  nop
