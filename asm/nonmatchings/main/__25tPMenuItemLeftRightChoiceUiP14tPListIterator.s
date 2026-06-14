.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __25tPMenuItemLeftRightChoiceUiP14tPListIterator, 0x44

glabel __25tPMenuItemLeftRightChoiceUiP14tPListIterator
    /* 97D58 800A7558 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 97D5C 800A755C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97D60 800A7560 21808000 */  addu       $s0, $a0, $zero
    /* 97D64 800A7564 1400B1AF */  sw         $s1, 0x14($sp)
    /* 97D68 800A7568 1800BFAF */  sw         $ra, 0x18($sp)
    /* 97D6C 800A756C 359D020C */  jal        __21tPMenuItemInteractiveUi
    /* 97D70 800A7570 2188C000 */   addu      $s1, $a2, $zero
    /* 97D74 800A7574 21100002 */  addu       $v0, $s0, $zero
    /* 97D78 800A7578 0580033C */  lui        $v1, %hi(_vt_25tPMenuItemLeftRightChoice)
    /* 97D7C 800A757C 24626324 */  addiu      $v1, $v1, %lo(_vt_25tPMenuItemLeftRightChoice)
    /* 97D80 800A7580 080043AC */  sw         $v1, 0x8($v0)
    /* 97D84 800A7584 0C0051AC */  sw         $s1, 0xC($v0)
    /* 97D88 800A7588 1800BF8F */  lw         $ra, 0x18($sp)
    /* 97D8C 800A758C 1400B18F */  lw         $s1, 0x14($sp)
    /* 97D90 800A7590 1000B08F */  lw         $s0, 0x10($sp)
    /* 97D94 800A7594 0800E003 */  jr         $ra
    /* 97D98 800A7598 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __25tPMenuItemLeftRightChoiceUiP14tPListIterator
