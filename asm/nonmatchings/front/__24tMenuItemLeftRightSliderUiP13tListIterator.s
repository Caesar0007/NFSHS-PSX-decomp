.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __24tMenuItemLeftRightSliderUiP13tListIterator, 0x5C

glabel __24tMenuItemLeftRightSliderUiP13tListIterator
    /* 152F8 80024AF8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 152FC 80024AFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 15300 80024B00 21808000 */  addu       $s0, $a0, $zero
    /* 15304 80024B04 1400B1AF */  sw         $s1, 0x14($sp)
    /* 15308 80024B08 1800BFAF */  sw         $ra, 0x18($sp)
    /* 1530C 80024B0C 2A92000C */  jal        __20tMenuItemInteractiveUi
    /* 15310 80024B10 2188C000 */   addu      $s1, $a2, $zero
    /* 15314 80024B14 0000038E */  lw         $v1, 0x0($s0)
    /* 15318 80024B18 21100002 */  addu       $v0, $s0, $zero
    /* 1531C 80024B1C 1C0051AC */  sw         $s1, 0x1C($v0)
    /* 15320 80024B20 80006334 */  ori        $v1, $v1, 0x80
    /* 15324 80024B24 000043AC */  sw         $v1, 0x0($v0)
    /* 15328 80024B28 0180033C */  lui        $v1, %hi(_vt_24tMenuItemLeftRightSlider)
    /* 1532C 80024B2C 0000448C */  lw         $a0, 0x0($v0)
    /* 15330 80024B30 78116324 */  addiu      $v1, $v1, %lo(_vt_24tMenuItemLeftRightSlider)
    /* 15334 80024B34 180043AC */  sw         $v1, 0x18($v0)
    /* 15338 80024B38 80008434 */  ori        $a0, $a0, 0x80
    /* 1533C 80024B3C 000044AC */  sw         $a0, 0x0($v0)
    /* 15340 80024B40 1800BF8F */  lw         $ra, 0x18($sp)
    /* 15344 80024B44 1400B18F */  lw         $s1, 0x14($sp)
    /* 15348 80024B48 1000B08F */  lw         $s0, 0x10($sp)
    /* 1534C 80024B4C 0800E003 */  jr         $ra
    /* 15350 80024B50 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __24tMenuItemLeftRightSliderUiP13tListIterator
