.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __29tMenuItemLeftRightAudioSliderUiP13tListIteratori, 0x4C

glabel __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* ECFC 8001E4FC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ED00 8001E500 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED04 8001E504 21808000 */  addu       $s0, $a0, $zero
    /* ED08 8001E508 1400B1AF */  sw         $s1, 0x14($sp)
    /* ED0C 8001E50C 1800BFAF */  sw         $ra, 0x18($sp)
    /* ED10 8001E510 BE92000C */  jal        __24tMenuItemLeftRightSliderUiP13tListIterator
    /* ED14 8001E514 2188E000 */   addu      $s1, $a3, $zero
    /* ED18 8001E518 21100002 */  addu       $v0, $s0, $zero
    /* ED1C 8001E51C 0180033C */  lui        $v1, %hi(_vt_29tMenuItemLeftRightAudioSlider)
    /* ED20 8001E520 E00C6324 */  addiu      $v1, $v1, %lo(_vt_29tMenuItemLeftRightAudioSlider)
    /* ED24 8001E524 180043AC */  sw         $v1, 0x18($v0)
    /* ED28 8001E528 300051A4 */  sh         $s1, 0x30($v0)
    /* ED2C 8001E52C 340040AC */  sw         $zero, 0x34($v0)
    /* ED30 8001E530 080040A4 */  sh         $zero, 0x8($v0)
    /* ED34 8001E534 1800BF8F */  lw         $ra, 0x18($sp)
    /* ED38 8001E538 1400B18F */  lw         $s1, 0x14($sp)
    /* ED3C 8001E53C 1000B08F */  lw         $s0, 0x10($sp)
    /* ED40 8001E540 0800E003 */  jr         $ra
    /* ED44 8001E544 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
