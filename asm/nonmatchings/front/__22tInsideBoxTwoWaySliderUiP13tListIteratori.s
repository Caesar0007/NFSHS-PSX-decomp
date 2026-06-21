.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __22tInsideBoxTwoWaySliderUiP13tListIteratori, 0x54

glabel __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* FC74 8001F474 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FC78 8001F478 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC7C 8001F47C 21808000 */  addu       $s0, $a0, $zero
    /* FC80 8001F480 1400B1AF */  sw         $s1, 0x14($sp)
    /* FC84 8001F484 1800BFAF */  sw         $ra, 0x18($sp)
    /* FC88 8001F488 BE92000C */  jal        __24tMenuItemLeftRightSliderUiP13tListIterator
    /* FC8C 8001F48C 2188E000 */   addu      $s1, $a3, $zero
    /* FC90 8001F490 21100002 */  addu       $v0, $s0, $zero
    /* FC94 8001F494 0180033C */  lui        $v1, %hi(_vt_22tInsideBoxTwoWaySlider)
    /* FC98 8001F498 700B6324 */  addiu      $v1, $v1, %lo(_vt_22tInsideBoxTwoWaySlider)
    /* FC9C 8001F49C 180043AC */  sw         $v1, 0x18($v0)
    /* FCA0 8001F4A0 05000324 */  addiu      $v1, $zero, 0x5
    /* FCA4 8001F4A4 280051A4 */  sh         $s1, 0x28($v0)
    /* FCA8 8001F4A8 080040A4 */  sh         $zero, 0x8($v0)
    /* FCAC 8001F4AC 260043A4 */  sh         $v1, 0x26($v0)
    /* FCB0 8001F4B0 2C0040AC */  sw         $zero, 0x2C($v0)
    /* FCB4 8001F4B4 1800BF8F */  lw         $ra, 0x18($sp)
    /* FCB8 8001F4B8 1400B18F */  lw         $s1, 0x14($sp)
    /* FCBC 8001F4BC 1000B08F */  lw         $s0, 0x10($sp)
    /* FCC0 8001F4C0 0800E003 */  jr         $ra
    /* FCC4 8001F4C4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __22tInsideBoxTwoWaySliderUiP13tListIteratori
