.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __20tMenuItemInteractiveUi, 0x34

glabel __20tMenuItemInteractiveUi
    /* 150A8 800248A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 150AC 800248AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 150B0 800248B0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 150B4 800248B4 CD91000C */  jal        __9tMenuItemUi
    /* 150B8 800248B8 21808000 */   addu      $s0, $a0, $zero
    /* 150BC 800248BC 0180023C */  lui        $v0, %hi(_vt_20tMenuItemInteractive)
    /* 150C0 800248C0 28124224 */  addiu      $v0, $v0, %lo(_vt_20tMenuItemInteractive)
    /* 150C4 800248C4 180002AE */  sw         $v0, 0x18($s0)
    /* 150C8 800248C8 21100002 */  addu       $v0, $s0, $zero
    /* 150CC 800248CC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 150D0 800248D0 1000B08F */  lw         $s0, 0x10($sp)
    /* 150D4 800248D4 0800E003 */  jr         $ra
    /* 150D8 800248D8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __20tMenuItemInteractiveUi
