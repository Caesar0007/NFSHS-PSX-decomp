.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching read, 0xC

glabel read
    /* FA5A0 80109DA0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA5A4 80109DA4 08004001 */  jr         $t2
    /* FA5A8 80109DA8 34000924 */   addiu     $t1, $zero, 0x34
endlabel read
    /* FA5AC 80109DAC 00000000 */  nop
