.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strncpy, 0xC

glabel strncpy
    /* E6904 800F6104 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* E6908 800F6108 08004001 */  jr         $t2
    /* E690C 800F610C 1A000924 */   addiu     $t1, $zero, 0x1A
endlabel strncpy
    /* E6910 800F6110 00000000 */  nop
