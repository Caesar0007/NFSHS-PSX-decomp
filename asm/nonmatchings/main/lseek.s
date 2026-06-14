.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching lseek, 0xC

glabel lseek
    /* FA590 80109D90 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA594 80109D94 08004001 */  jr         $t2
    /* FA598 80109D98 33000924 */   addiu     $t1, $zero, 0x33
endlabel lseek
    /* FA59C 80109D9C 00000000 */  nop
