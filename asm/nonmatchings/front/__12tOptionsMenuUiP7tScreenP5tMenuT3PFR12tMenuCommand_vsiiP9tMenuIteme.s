.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme, 0x90

glabel __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* CCB4 8001C4B4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CCB8 8001C4B8 4000A88F */  lw         $t0, 0x40($sp)
    /* CCBC 8001C4BC 4400A98F */  lw         $t1, 0x44($sp)
    /* CCC0 8001C4C0 4800A28F */  lw         $v0, 0x48($sp)
    /* CCC4 8001C4C4 2400B1AF */  sw         $s1, 0x24($sp)
    /* CCC8 8001C4C8 4C00B18F */  lw         $s1, 0x4C($sp)
    /* CCCC 8001C4CC 2000B0AF */  sw         $s0, 0x20($sp)
    /* CCD0 8001C4D0 21808000 */  addu       $s0, $a0, $zero
    /* CCD4 8001C4D4 2800B2AF */  sw         $s2, 0x28($sp)
    /* CCD8 8001C4D8 5000B28F */  lw         $s2, 0x50($sp)
    /* CCDC 8001C4DC 5400A38F */  lw         $v1, 0x54($sp)
    /* CCE0 8001C4E0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* CCE4 8001C4E4 00140200 */  sll        $v0, $v0, 16
    /* CCE8 8001C4E8 03140200 */  sra        $v0, $v0, 16
    /* CCEC 8001C4EC 1000A8AF */  sw         $t0, 0x10($sp)
    /* CCF0 8001C4F0 1400A9AF */  sw         $t1, 0x14($sp)
    /* CCF4 8001C4F4 1B95000C */  jal        __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* CCF8 8001C4F8 1800A2AF */   sw        $v0, 0x18($sp)
    /* CCFC 8001C4FC 21200002 */  addu       $a0, $s0, $zero
    /* CD00 8001C500 5800A627 */  addiu      $a2, $sp, 0x58
    /* CD04 8001C504 0180023C */  lui        $v0, %hi(_vt_12tOptionsMenu)
    /* CD08 8001C508 5400A58F */  lw         $a1, 0x54($sp)
    /* CD0C 8001C50C 080F4224 */  addiu      $v0, $v0, %lo(_vt_12tOptionsMenu)
    /* CD10 8001C510 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* CD14 8001C514 680002AE */   sw        $v0, 0x68($s0)
    /* CD18 8001C518 21100002 */  addu       $v0, $s0, $zero
    /* CD1C 8001C51C 740040AC */  sw         $zero, 0x74($v0)
    /* CD20 8001C520 720040A4 */  sh         $zero, 0x72($v0)
    /* CD24 8001C524 780051AC */  sw         $s1, 0x78($v0)
    /* CD28 8001C528 7C0052AC */  sw         $s2, 0x7C($v0)
    /* CD2C 8001C52C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* CD30 8001C530 2800B28F */  lw         $s2, 0x28($sp)
    /* CD34 8001C534 2400B18F */  lw         $s1, 0x24($sp)
    /* CD38 8001C538 2000B08F */  lw         $s0, 0x20($sp)
    /* CD3C 8001C53C 0800E003 */  jr         $ra
    /* CD40 8001C540 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
