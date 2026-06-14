.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartCARD2, 0xC

glabel StartCARD2
    /* FD3A0 8010CBA0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD3A4 8010CBA4 08004001 */  jr         $t2
    /* FD3A8 8010CBA8 4B000924 */   addiu     $t1, $zero, 0x4B
endlabel StartCARD2
    /* FD3AC 8010CBAC 00000000 */  nop
