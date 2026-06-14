.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Debounce__25tPMenuItemLeftRightSlider, 0x8

glabel Debounce__25tPMenuItemLeftRightSlider
    /* 980A4 800A78A4 0800E003 */  jr         $ra
    /* 980A8 800A78A8 21100000 */   addu      $v0, $zero, $zero
endlabel Debounce__25tPMenuItemLeftRightSlider
