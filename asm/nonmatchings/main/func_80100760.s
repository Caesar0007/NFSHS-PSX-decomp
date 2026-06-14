.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80100760, 0x1C

glabel func_80100760
    /* F0F60 80100760 40300600 */  sll        $a2, $a2, 1
    /* F0F64 80100764 2130C500 */  addu       $a2, $a2, $a1
    /* F0F68 80100768 0000C294 */  lhu        $v0, 0x0($a2)
    /* F0F6C 8010076C 00000000 */  nop
    /* F0F70 80100770 80100200 */  sll        $v0, $v0, 2
    /* F0F74 80100774 0800E003 */  jr         $ra
    /* F0F78 80100778 21108200 */   addu      $v0, $a0, $v0
endlabel func_80100760
