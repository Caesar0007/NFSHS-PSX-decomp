.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme, 0x68

glabel __15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* BF48 8001B748 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BF4C 8001B74C 2000B0AF */  sw         $s0, 0x20($sp)
    /* BF50 8001B750 21808000 */  addu       $s0, $a0, $zero
    /* BF54 8001B754 3800A88F */  lw         $t0, 0x38($sp)
    /* BF58 8001B758 3C00A98F */  lw         $t1, 0x3C($sp)
    /* BF5C 8001B75C 4000A28F */  lw         $v0, 0x40($sp)
    /* BF60 8001B760 4400A38F */  lw         $v1, 0x44($sp)
    /* BF64 8001B764 2400BFAF */  sw         $ra, 0x24($sp)
    /* BF68 8001B768 00140200 */  sll        $v0, $v0, 16
    /* BF6C 8001B76C 03140200 */  sra        $v0, $v0, 16
    /* BF70 8001B770 1000A8AF */  sw         $t0, 0x10($sp)
    /* BF74 8001B774 1400A9AF */  sw         $t1, 0x14($sp)
    /* BF78 8001B778 406C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* BF7C 8001B77C 1800A2AF */   sw        $v0, 0x18($sp)
    /* BF80 8001B780 21200002 */  addu       $a0, $s0, $zero
    /* BF84 8001B784 4800A627 */  addiu      $a2, $sp, 0x48
    /* BF88 8001B788 0180023C */  lui        $v0, %hi(_vt_15tMenuNFS4Bottom)
    /* BF8C 8001B78C 4400A58F */  lw         $a1, 0x44($sp)
    /* BF90 8001B790 E0064224 */  addiu      $v0, $v0, %lo(_vt_15tMenuNFS4Bottom)
    /* BF94 8001B794 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* BF98 8001B798 680002AE */   sw        $v0, 0x68($s0)
    /* BF9C 8001B79C 21100002 */  addu       $v0, $s0, $zero
    /* BFA0 8001B7A0 2400BF8F */  lw         $ra, 0x24($sp)
    /* BFA4 8001B7A4 2000B08F */  lw         $s0, 0x20($sp)
    /* BFA8 8001B7A8 0800E003 */  jr         $ra
    /* BFAC 8001B7AC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
