.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme, 0x78

glabel __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* C24C 8001BA4C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C250 8001BA50 4000A88F */  lw         $t0, 0x40($sp)
    /* C254 8001BA54 4400A98F */  lw         $t1, 0x44($sp)
    /* C258 8001BA58 4800A28F */  lw         $v0, 0x48($sp)
    /* C25C 8001BA5C 2000B0AF */  sw         $s0, 0x20($sp)
    /* C260 8001BA60 21808000 */  addu       $s0, $a0, $zero
    /* C264 8001BA64 2400B1AF */  sw         $s1, 0x24($sp)
    /* C268 8001BA68 4C00B18F */  lw         $s1, 0x4C($sp)
    /* C26C 8001BA6C 5000A38F */  lw         $v1, 0x50($sp)
    /* C270 8001BA70 2800BFAF */  sw         $ra, 0x28($sp)
    /* C274 8001BA74 00140200 */  sll        $v0, $v0, 16
    /* C278 8001BA78 03140200 */  sra        $v0, $v0, 16
    /* C27C 8001BA7C 1000A8AF */  sw         $t0, 0x10($sp)
    /* C280 8001BA80 1400A9AF */  sw         $t1, 0x14($sp)
    /* C284 8001BA84 406C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* C288 8001BA88 1800A2AF */   sw        $v0, 0x18($sp)
    /* C28C 8001BA8C 21200002 */  addu       $a0, $s0, $zero
    /* C290 8001BA90 5400A627 */  addiu      $a2, $sp, 0x54
    /* C294 8001BA94 0180023C */  lui        $v0, %hi(_vt_12tMenuOptions)
    /* C298 8001BA98 5000A58F */  lw         $a1, 0x50($sp)
    /* C29C 8001BA9C 20064224 */  addiu      $v0, $v0, %lo(_vt_12tMenuOptions)
    /* C2A0 8001BAA0 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* C2A4 8001BAA4 680002AE */   sw        $v0, 0x68($s0)
    /* C2A8 8001BAA8 21100002 */  addu       $v0, $s0, $zero
    /* C2AC 8001BAAC 800051A4 */  sh         $s1, 0x80($v0)
    /* C2B0 8001BAB0 2800BF8F */  lw         $ra, 0x28($sp)
    /* C2B4 8001BAB4 2400B18F */  lw         $s1, 0x24($sp)
    /* C2B8 8001BAB8 2000B08F */  lw         $s0, 0x20($sp)
    /* C2BC 8001BABC 0800E003 */  jr         $ra
    /* C2C0 8001BAC0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
