.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching close, 0xC

glabel close
    /* FA580 80109D80 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA584 80109D84 08004001 */  jr         $t2
    /* FA588 80109D88 36000924 */   addiu     $t1, $zero, 0x36
endlabel close
    /* FA58C 80109D8C 00000000 */  nop
