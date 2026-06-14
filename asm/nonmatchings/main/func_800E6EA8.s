.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E6EA8, 0x1C

glabel func_800E6EA8
    /* D76A8 800E6EA8 40300600 */  sll        $a2, $a2, 1
    /* D76AC 800E6EAC 2130C500 */  addu       $a2, $a2, $a1
    /* D76B0 800E6EB0 0000C294 */  lhu        $v0, 0x0($a2)
    /* D76B4 800E6EB4 00000000 */  nop
    /* D76B8 800E6EB8 80100200 */  sll        $v0, $v0, 2
    /* D76BC 800E6EBC 0800E003 */  jr         $ra
    /* D76C0 800E6EC0 21108200 */   addu      $v0, $a0, $v0
endlabel func_800E6EA8
