.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strcpy, 0xC

glabel strcpy
    /* D6328 800E5B28 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* D632C 800E5B2C 08004001 */  jr         $t2
    /* D6330 800E5B30 19000924 */   addiu     $t1, $zero, 0x19
endlabel strcpy
    /* D6334 800E5B34 00000000 */  nop
