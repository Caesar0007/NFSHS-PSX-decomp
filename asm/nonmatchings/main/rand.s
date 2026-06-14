.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching rand, 0xC

glabel rand
    /* DB2D4 800EAAD4 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* DB2D8 800EAAD8 08004001 */  jr         $t2
    /* DB2DC 800EAADC 2F000924 */   addiu     $t1, $zero, 0x2F
endlabel rand
    /* DB2E0 800EAAE0 00000000 */  nop
