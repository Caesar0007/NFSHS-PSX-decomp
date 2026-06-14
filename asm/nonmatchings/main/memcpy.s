.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memcpy, 0xC

glabel memcpy
    /* DB2C4 800EAAC4 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* DB2C8 800EAAC8 08004001 */  jr         $t2
    /* DB2CC 800EAACC 2A000924 */   addiu     $t1, $zero, 0x2A
endlabel memcpy
    /* DB2D0 800EAAD0 00000000 */  nop
