.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__24tMenuItemLeftRightSlider, 0x8

glabel DebounceKeys__24tMenuItemLeftRightSlider
    /* 1537C 80024B7C 0800E003 */  jr         $ra
    /* 15380 80024B80 00060224 */   addiu     $v0, $zero, 0x600
endlabel DebounceKeys__24tMenuItemLeftRightSlider
