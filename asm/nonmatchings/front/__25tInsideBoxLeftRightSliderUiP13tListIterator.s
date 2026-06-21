.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __25tInsideBoxLeftRightSliderUiP13tListIterator, 0x40

glabel __25tInsideBoxLeftRightSliderUiP13tListIterator
    /* FA88 8001F288 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA8C 8001F28C 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA90 8001F290 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA94 8001F294 BE92000C */  jal        __24tMenuItemLeftRightSliderUiP13tListIterator
    /* FA98 8001F298 21808000 */   addu      $s0, $a0, $zero
    /* FA9C 8001F29C 21100002 */  addu       $v0, $s0, $zero
    /* FAA0 8001F2A0 0180033C */  lui        $v1, %hi(_vt_25tInsideBoxLeftRightSlider)
    /* FAA4 8001F2A4 C80B6324 */  addiu      $v1, $v1, %lo(_vt_25tInsideBoxLeftRightSlider)
    /* FAA8 8001F2A8 180043AC */  sw         $v1, 0x18($v0)
    /* FAAC 8001F2AC 05000324 */  addiu      $v1, $zero, 0x5
    /* FAB0 8001F2B0 080040A4 */  sh         $zero, 0x8($v0)
    /* FAB4 8001F2B4 260043A4 */  sh         $v1, 0x26($v0)
    /* FAB8 8001F2B8 1400BF8F */  lw         $ra, 0x14($sp)
    /* FABC 8001F2BC 1000B08F */  lw         $s0, 0x10($sp)
    /* FAC0 8001F2C0 0800E003 */  jr         $ra
    /* FAC4 8001F2C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __25tInsideBoxLeftRightSliderUiP13tListIterator
