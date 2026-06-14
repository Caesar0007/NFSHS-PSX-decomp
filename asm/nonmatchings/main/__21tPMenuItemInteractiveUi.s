.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __21tPMenuItemInteractiveUi, 0x34

glabel __21tPMenuItemInteractiveUi
    /* 97CD4 800A74D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97CD8 800A74D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97CDC 800A74DC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 97CE0 800A74E0 FA9C020C */  jal        __10tPMenuItemUi
    /* 97CE4 800A74E4 21808000 */   addu      $s0, $a0, $zero
    /* 97CE8 800A74E8 0580023C */  lui        $v0, %hi(_vt_21tPMenuItemInteractive)
    /* 97CEC 800A74EC 5C624224 */  addiu      $v0, $v0, %lo(_vt_21tPMenuItemInteractive)
    /* 97CF0 800A74F0 080002AE */  sw         $v0, 0x8($s0)
    /* 97CF4 800A74F4 21100002 */  addu       $v0, $s0, $zero
    /* 97CF8 800A74F8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 97CFC 800A74FC 1000B08F */  lw         $s0, 0x10($sp)
    /* 97D00 800A7500 0800E003 */  jr         $ra
    /* 97D04 800A7504 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __21tPMenuItemInteractiveUi
