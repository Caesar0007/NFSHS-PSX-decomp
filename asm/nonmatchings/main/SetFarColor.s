.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetFarColor, 0x20

glabel SetFarColor
    /* E2FBC 800F27BC 00210400 */  sll        $a0, $a0, 4
    /* E2FC0 800F27C0 00290500 */  sll        $a1, $a1, 4
    /* E2FC4 800F27C4 00310600 */  sll        $a2, $a2, 4
    /* E2FC8 800F27C8 00A8C448 */  ctc2       $a0, $21 /* handwritten instruction */
    /* E2FCC 800F27CC 00B0C548 */  ctc2       $a1, $22 /* handwritten instruction */
    /* E2FD0 800F27D0 00B8C648 */  ctc2       $a2, $23 /* handwritten instruction */
    /* E2FD4 800F27D4 0800E003 */  jr         $ra
    /* E2FD8 800F27D8 00000000 */   nop
endlabel SetFarColor
