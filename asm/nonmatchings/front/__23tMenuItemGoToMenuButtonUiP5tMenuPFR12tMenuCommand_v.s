.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v, 0x54

glabel __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
    /* 15B28 80025328 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15B2C 8002532C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 15B30 80025330 21808000 */  addu       $s0, $a0, $zero
    /* 15B34 80025334 1400B1AF */  sw         $s1, 0x14($sp)
    /* 15B38 80025338 2188C000 */  addu       $s1, $a2, $zero
    /* 15B3C 8002533C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 15B40 80025340 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 15B44 80025344 2A92000C */  jal        __20tMenuItemInteractiveUi
    /* 15B48 80025348 2190E000 */   addu      $s2, $a3, $zero
    /* 15B4C 8002534C 21100002 */  addu       $v0, $s0, $zero
    /* 15B50 80025350 0180033C */  lui        $v1, %hi(_vt_23tMenuItemGoToMenuButton)
    /* 15B54 80025354 20116324 */  addiu      $v1, $v1, %lo(_vt_23tMenuItemGoToMenuButton)
    /* 15B58 80025358 180043AC */  sw         $v1, 0x18($v0)
    /* 15B5C 8002535C 140051AC */  sw         $s1, 0x14($v0)
    /* 15B60 80025360 1C0052AC */  sw         $s2, 0x1C($v0)
    /* 15B64 80025364 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 15B68 80025368 1800B28F */  lw         $s2, 0x18($sp)
    /* 15B6C 8002536C 1400B18F */  lw         $s1, 0x14($sp)
    /* 15B70 80025370 1000B08F */  lw         $s0, 0x10($sp)
    /* 15B74 80025374 0800E003 */  jr         $ra
    /* 15B78 80025378 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
