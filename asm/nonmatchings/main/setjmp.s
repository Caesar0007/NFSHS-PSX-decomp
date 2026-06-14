.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setjmp, 0xC

glabel setjmp
    /* F6E8C 8010668C A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F6E90 80106690 08004001 */  jr         $t2
    /* F6E94 80106694 13000924 */   addiu     $t1, $zero, 0x13
endlabel setjmp
    /* F6E98 80106698 00000000 */  nop
