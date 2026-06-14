.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __25tPMenuItemLeftRightSliderUiPic, 0x54

glabel __25tPMenuItemLeftRightSliderUiPic
    /* 98028 800A7828 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9802C 800A782C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98030 800A7830 21808000 */  addu       $s0, $a0, $zero
    /* 98034 800A7834 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98038 800A7838 2188C000 */  addu       $s1, $a2, $zero
    /* 9803C 800A783C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 98040 800A7840 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98044 800A7844 359D020C */  jal        __21tPMenuItemInteractiveUi
    /* 98048 800A7848 2190E000 */   addu      $s2, $a3, $zero
    /* 9804C 800A784C 21100002 */  addu       $v0, $s0, $zero
    /* 98050 800A7850 0580033C */  lui        $v1, %hi(_vt_25tPMenuItemLeftRightSlider)
    /* 98054 800A7854 EC616324 */  addiu      $v1, $v1, %lo(_vt_25tPMenuItemLeftRightSlider)
    /* 98058 800A7858 080043AC */  sw         $v1, 0x8($v0)
    /* 9805C 800A785C 0C0051AC */  sw         $s1, 0xC($v0)
    /* 98060 800A7860 100052A0 */  sb         $s2, 0x10($v0)
    /* 98064 800A7864 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 98068 800A7868 1800B28F */  lw         $s2, 0x18($sp)
    /* 9806C 800A786C 1400B18F */  lw         $s1, 0x14($sp)
    /* 98070 800A7870 1000B08F */  lw         $s0, 0x10($sp)
    /* 98074 800A7874 0800E003 */  jr         $ra
    /* 98078 800A7878 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __25tPMenuItemLeftRightSliderUiPic
