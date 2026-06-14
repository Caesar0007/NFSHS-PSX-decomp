.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ResetEntryInt, 0xC

glabel ResetEntryInt
    /* F719C 8010699C B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F71A0 801069A0 08004001 */  jr         $t2
    /* F71A4 801069A4 18000924 */   addiu     $t1, $zero, 0x18
endlabel ResetEntryInt
    /* F71A8 801069A8 00000000 */  nop
