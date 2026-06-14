.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v, 0x54

glabel __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
    /* 98574 800A7D74 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98578 800A7D78 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9857C 800A7D7C 21808000 */  addu       $s0, $a0, $zero
    /* 98580 800A7D80 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98584 800A7D84 2188C000 */  addu       $s1, $a2, $zero
    /* 98588 800A7D88 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9858C 800A7D8C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98590 800A7D90 359D020C */  jal        __21tPMenuItemInteractiveUi
    /* 98594 800A7D94 2190E000 */   addu      $s2, $a3, $zero
    /* 98598 800A7D98 21100002 */  addu       $v0, $s0, $zero
    /* 9859C 800A7D9C 0580033C */  lui        $v1, %hi(_vt_24tPMenuItemGoToMenuButton)
    /* 985A0 800A7DA0 7C616324 */  addiu      $v1, $v1, %lo(_vt_24tPMenuItemGoToMenuButton)
    /* 985A4 800A7DA4 080043AC */  sw         $v1, 0x8($v0)
    /* 985A8 800A7DA8 0C0051AC */  sw         $s1, 0xC($v0)
    /* 985AC 800A7DAC 100052AC */  sw         $s2, 0x10($v0)
    /* 985B0 800A7DB0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 985B4 800A7DB4 1800B28F */  lw         $s2, 0x18($sp)
    /* 985B8 800A7DB8 1400B18F */  lw         $s1, 0x14($sp)
    /* 985BC 800A7DBC 1000B08F */  lw         $s0, 0x10($sp)
    /* 985C0 800A7DC0 0800E003 */  jr         $ra
    /* 985C4 800A7DC4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
