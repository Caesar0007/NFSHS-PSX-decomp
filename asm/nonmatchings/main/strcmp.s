.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strcmp, 0xC

glabel strcmp
    /* D657C 800E5D7C A0000A24 */  addiu      $t2, $zero, 0xA0
    /* D6580 800E5D80 08004001 */  jr         $t2
    /* D6584 800E5D84 17000924 */   addiu     $t1, $zero, 0x17
endlabel strcmp
    /* D6588 800E5D88 00000000 */  nop
