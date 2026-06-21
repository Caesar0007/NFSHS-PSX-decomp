.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme, 0x6C

glabel __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* BE3C 8001B63C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BE40 8001B640 2000B0AF */  sw         $s0, 0x20($sp)
    /* BE44 8001B644 21808000 */  addu       $s0, $a0, $zero
    /* BE48 8001B648 3800A88F */  lw         $t0, 0x38($sp)
    /* BE4C 8001B64C 3C00A98F */  lw         $t1, 0x3C($sp)
    /* BE50 8001B650 4000A28F */  lw         $v0, 0x40($sp)
    /* BE54 8001B654 4400A38F */  lw         $v1, 0x44($sp)
    /* BE58 8001B658 2400BFAF */  sw         $ra, 0x24($sp)
    /* BE5C 8001B65C 00140200 */  sll        $v0, $v0, 16
    /* BE60 8001B660 03140200 */  sra        $v0, $v0, 16
    /* BE64 8001B664 1000A8AF */  sw         $t0, 0x10($sp)
    /* BE68 8001B668 1400A9AF */  sw         $t1, 0x14($sp)
    /* BE6C 8001B66C 406C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* BE70 8001B670 1800A2AF */   sw        $v0, 0x18($sp)
    /* BE74 8001B674 21200002 */  addu       $a0, $s0, $zero
    /* BE78 8001B678 4800A627 */  addiu      $a2, $sp, 0x48
    /* BE7C 8001B67C 0180023C */  lui        $v0, %hi(_vt_18tMenuNFS4TwoPlayer)
    /* BE80 8001B680 4400A58F */  lw         $a1, 0x44($sp)
    /* BE84 8001B684 40074224 */  addiu      $v0, $v0, %lo(_vt_18tMenuNFS4TwoPlayer)
    /* BE88 8001B688 680002AE */  sw         $v0, 0x68($s0)
    /* BE8C 8001B68C 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* BE90 8001B690 580000AE */   sw        $zero, 0x58($s0)
    /* BE94 8001B694 21100002 */  addu       $v0, $s0, $zero
    /* BE98 8001B698 2400BF8F */  lw         $ra, 0x24($sp)
    /* BE9C 8001B69C 2000B08F */  lw         $s0, 0x20($sp)
    /* BEA0 8001B6A0 0800E003 */  jr         $ra
    /* BEA4 8001B6A4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
