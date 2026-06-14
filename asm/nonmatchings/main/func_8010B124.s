.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010B124, 0x1C

glabel func_8010B124
    /* FB924 8010B124 40300600 */  sll        $a2, $a2, 1
    /* FB928 8010B128 2130C500 */  addu       $a2, $a2, $a1
    /* FB92C 8010B12C 0000C294 */  lhu        $v0, 0x0($a2)
    /* FB930 8010B130 00000000 */  nop
    /* FB934 8010B134 80100200 */  sll        $v0, $v0, 2
    /* FB938 8010B138 0800E003 */  jr         $ra
    /* FB93C 8010B13C 21108200 */   addu      $v0, $a0, $v0
endlabel func_8010B124
