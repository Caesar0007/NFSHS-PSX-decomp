.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __28tPMenuItemNonInteractiveTextUi, 0x34

glabel __28tPMenuItemNonInteractiveTextUi
    /* 97C50 800A7450 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97C54 800A7454 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97C58 800A7458 1400BFAF */  sw         $ra, 0x14($sp)
    /* 97C5C 800A745C FA9C020C */  jal        __10tPMenuItemUi
    /* 97C60 800A7460 21808000 */   addu      $s0, $a0, $zero
    /* 97C64 800A7464 0580023C */  lui        $v0, %hi(_vt_28tPMenuItemNonInteractiveText)
    /* 97C68 800A7468 94624224 */  addiu      $v0, $v0, %lo(_vt_28tPMenuItemNonInteractiveText)
    /* 97C6C 800A746C 080002AE */  sw         $v0, 0x8($s0)
    /* 97C70 800A7470 21100002 */  addu       $v0, $s0, $zero
    /* 97C74 800A7474 1400BF8F */  lw         $ra, 0x14($sp)
    /* 97C78 800A7478 1000B08F */  lw         $s0, 0x10($sp)
    /* 97C7C 800A747C 0800E003 */  jr         $ra
    /* 97C80 800A7480 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __28tPMenuItemNonInteractiveTextUi
