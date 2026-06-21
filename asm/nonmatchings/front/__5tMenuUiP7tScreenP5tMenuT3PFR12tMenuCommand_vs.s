.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs, 0x44

glabel __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 15C6C 8002546C 21108000 */  addu       $v0, $a0, $zero
    /* 15C70 80025470 0180033C */  lui        $v1, %hi(_vt_5tMenu)
    /* 15C74 80025474 1000A48F */  lw         $a0, 0x10($sp)
    /* 15C78 80025478 1400A88F */  lw         $t0, 0x14($sp)
    /* 15C7C 8002547C 1800A98F */  lw         $t1, 0x18($sp)
    /* 15C80 80025480 C8106324 */  addiu      $v1, $v1, %lo(_vt_5tMenu)
    /* 15C84 80025484 680043AC */  sw         $v1, 0x68($v0)
    /* 15C88 80025488 000045AC */  sw         $a1, 0x0($v0)
    /* 15C8C 8002548C 080040AC */  sw         $zero, 0x8($v0)
    /* 15C90 80025490 500046AC */  sw         $a2, 0x50($v0)
    /* 15C94 80025494 540047AC */  sw         $a3, 0x54($v0)
    /* 15C98 80025498 0C0040AC */  sw         $zero, 0xC($v0)
    /* 15C9C 8002549C 580040AC */  sw         $zero, 0x58($v0)
    /* 15CA0 800254A0 5C0044AC */  sw         $a0, 0x5C($v0)
    /* 15CA4 800254A4 600048AC */  sw         $t0, 0x60($v0)
    /* 15CA8 800254A8 0800E003 */  jr         $ra
    /* 15CAC 800254AC 040049A4 */   sh        $t1, 0x4($v0)
endlabel __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
