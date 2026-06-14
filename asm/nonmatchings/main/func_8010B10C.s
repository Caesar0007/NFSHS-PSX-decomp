.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010B10C, 0x18

glabel func_8010B10C
    /* FB90C 8010B10C 2128A600 */  addu       $a1, $a1, $a2
    /* FB910 8010B110 0000A290 */  lbu        $v0, 0x0($a1)
    /* FB914 8010B114 00000000 */  nop
    /* FB918 8010B118 80100200 */  sll        $v0, $v0, 2
    /* FB91C 8010B11C 0800E003 */  jr         $ra
    /* FB920 8010B120 21108200 */   addu      $v0, $a0, $v0
endlabel func_8010B10C
