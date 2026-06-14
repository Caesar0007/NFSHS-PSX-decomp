.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strchr, 0xC

glabel strchr
    /* E6A14 800F6214 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* E6A18 800F6218 08004001 */  jr         $t2
    /* E6A1C 800F621C 1E000924 */   addiu     $t1, $zero, 0x1E
endlabel strchr
    /* E6A20 800F6220 00000000 */  nop
