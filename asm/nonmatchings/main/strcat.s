.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strcat, 0xC

glabel strcat
    /* D80E8 800E78E8 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* D80EC 800E78EC 08004001 */  jr         $t2
    /* D80F0 800E78F0 15000924 */   addiu     $t1, $zero, 0x15
endlabel strcat
    /* D80F4 800E78F4 00000000 */  nop
