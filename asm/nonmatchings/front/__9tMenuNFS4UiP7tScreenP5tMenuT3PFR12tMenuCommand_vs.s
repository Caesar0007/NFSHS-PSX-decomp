.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs, 0x58

glabel __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* B900 8001B100 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* B904 8001B104 2000B0AF */  sw         $s0, 0x20($sp)
    /* B908 8001B108 21808000 */  addu       $s0, $a0, $zero
    /* B90C 8001B10C 3800A38F */  lw         $v1, 0x38($sp)
    /* B910 8001B110 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B914 8001B114 4000A28F */  lw         $v0, 0x40($sp)
    /* B918 8001B118 2400BFAF */  sw         $ra, 0x24($sp)
    /* B91C 8001B11C 00140200 */  sll        $v0, $v0, 16
    /* B920 8001B120 03140200 */  sra        $v0, $v0, 16
    /* B924 8001B124 1400A4AF */  sw         $a0, 0x14($sp)
    /* B928 8001B128 21200002 */  addu       $a0, $s0, $zero
    /* B92C 8001B12C 1000A3AF */  sw         $v1, 0x10($sp)
    /* B930 8001B130 1B95000C */  jal        __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* B934 8001B134 1800A2AF */   sw        $v0, 0x18($sp)
    /* B938 8001B138 21100002 */  addu       $v0, $s0, $zero
    /* B93C 8001B13C 0180033C */  lui        $v1, %hi(_vt_9tMenuNFS4)
    /* B940 8001B140 A0076324 */  addiu      $v1, $v1, %lo(_vt_9tMenuNFS4)
    /* B944 8001B144 680043AC */  sw         $v1, 0x68($v0)
    /* B948 8001B148 2400BF8F */  lw         $ra, 0x24($sp)
    /* B94C 8001B14C 2000B08F */  lw         $s0, 0x20($sp)
    /* B950 8001B150 0800E003 */  jr         $ra
    /* B954 8001B154 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
