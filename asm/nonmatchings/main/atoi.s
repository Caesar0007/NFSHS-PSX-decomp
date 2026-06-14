.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching atoi, 0xC

glabel atoi
    /* DB900 800EB100 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* DB904 800EB104 08004001 */  jr         $t2
    /* DB908 800EB108 10000924 */   addiu     $t1, $zero, 0x10
endlabel atoi
    /* DB90C 800EB10C 00000000 */  nop
