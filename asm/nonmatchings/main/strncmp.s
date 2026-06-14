.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strncmp, 0xC

glabel strncmp
    /* DB9D0 800EB1D0 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* DB9D4 800EB1D4 08004001 */  jr         $t2
    /* DB9D8 800EB1D8 18000924 */   addiu     $t1, $zero, 0x18
endlabel strncmp
    /* DB9DC 800EB1DC 00000000 */  nop
