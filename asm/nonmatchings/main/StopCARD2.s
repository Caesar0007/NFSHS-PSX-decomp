.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StopCARD2, 0xC

glabel StopCARD2
    /* FD3B0 8010CBB0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD3B4 8010CBB4 08004001 */  jr         $t2
    /* FD3B8 8010CBB8 4C000924 */   addiu     $t1, $zero, 0x4C
endlabel StopCARD2
    /* FD3BC 8010CBBC 00000000 */  nop
