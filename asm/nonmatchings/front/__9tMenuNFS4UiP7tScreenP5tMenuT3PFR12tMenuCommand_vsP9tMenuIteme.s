.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme, 0x68

glabel __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* B898 8001B098 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* B89C 8001B09C 2000B0AF */  sw         $s0, 0x20($sp)
    /* B8A0 8001B0A0 21808000 */  addu       $s0, $a0, $zero
    /* B8A4 8001B0A4 3800A88F */  lw         $t0, 0x38($sp)
    /* B8A8 8001B0A8 3C00A98F */  lw         $t1, 0x3C($sp)
    /* B8AC 8001B0AC 4000A28F */  lw         $v0, 0x40($sp)
    /* B8B0 8001B0B0 4400A38F */  lw         $v1, 0x44($sp)
    /* B8B4 8001B0B4 2400BFAF */  sw         $ra, 0x24($sp)
    /* B8B8 8001B0B8 00140200 */  sll        $v0, $v0, 16
    /* B8BC 8001B0BC 03140200 */  sra        $v0, $v0, 16
    /* B8C0 8001B0C0 1000A8AF */  sw         $t0, 0x10($sp)
    /* B8C4 8001B0C4 1400A9AF */  sw         $t1, 0x14($sp)
    /* B8C8 8001B0C8 1B95000C */  jal        __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* B8CC 8001B0CC 1800A2AF */   sw        $v0, 0x18($sp)
    /* B8D0 8001B0D0 21200002 */  addu       $a0, $s0, $zero
    /* B8D4 8001B0D4 4800A627 */  addiu      $a2, $sp, 0x48
    /* B8D8 8001B0D8 0180023C */  lui        $v0, %hi(_vt_9tMenuNFS4)
    /* B8DC 8001B0DC 4400A58F */  lw         $a1, 0x44($sp)
    /* B8E0 8001B0E0 A0074224 */  addiu      $v0, $v0, %lo(_vt_9tMenuNFS4)
    /* B8E4 8001B0E4 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* B8E8 8001B0E8 680002AE */   sw        $v0, 0x68($s0)
    /* B8EC 8001B0EC 21100002 */  addu       $v0, $s0, $zero
    /* B8F0 8001B0F0 2400BF8F */  lw         $ra, 0x24($sp)
    /* B8F4 8001B0F4 2000B08F */  lw         $s0, 0x20($sp)
    /* B8F8 8001B0F8 0800E003 */  jr         $ra
    /* B8FC 8001B0FC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
