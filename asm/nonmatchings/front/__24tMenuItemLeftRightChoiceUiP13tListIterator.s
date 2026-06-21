.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __24tMenuItemLeftRightChoiceUiP13tListIterator, 0x50

glabel __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 15104 80024904 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15108 80024908 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1510C 8002490C 21808000 */  addu       $s0, $a0, $zero
    /* 15110 80024910 1400B1AF */  sw         $s1, 0x14($sp)
    /* 15114 80024914 1800BFAF */  sw         $ra, 0x18($sp)
    /* 15118 80024918 2A92000C */  jal        __20tMenuItemInteractiveUi
    /* 1511C 8002491C 2188C000 */   addu      $s1, $a2, $zero
    /* 15120 80024920 21100002 */  addu       $v0, $s0, $zero
    /* 15124 80024924 0180033C */  lui        $v1, %hi(_vt_24tMenuItemLeftRightChoice)
    /* 15128 80024928 0000448C */  lw         $a0, 0x0($v0)
    /* 1512C 8002492C D0116324 */  addiu      $v1, $v1, %lo(_vt_24tMenuItemLeftRightChoice)
    /* 15130 80024930 180043AC */  sw         $v1, 0x18($v0)
    /* 15134 80024934 1C0051AC */  sw         $s1, 0x1C($v0)
    /* 15138 80024938 00048434 */  ori        $a0, $a0, 0x400
    /* 1513C 8002493C 000044AC */  sw         $a0, 0x0($v0)
    /* 15140 80024940 1800BF8F */  lw         $ra, 0x18($sp)
    /* 15144 80024944 1400B18F */  lw         $s1, 0x14($sp)
    /* 15148 80024948 1000B08F */  lw         $s0, 0x10($sp)
    /* 1514C 8002494C 0800E003 */  jr         $ra
    /* 15150 80024950 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __24tMenuItemLeftRightChoiceUiP13tListIterator
