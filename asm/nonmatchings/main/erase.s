.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching erase, 0xC

glabel erase
    /* FA870 8010A070 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA874 8010A074 08004001 */  jr         $t2
    /* FA878 8010A078 45000924 */   addiu     $t1, $zero, 0x45
endlabel erase
    /* FA87C 8010A07C 00000000 */  nop
