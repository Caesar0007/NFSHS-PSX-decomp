.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs, 0x64

glabel __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* C098 8001B898 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C09C 8001B89C 2000B0AF */  sw         $s0, 0x20($sp)
    /* C0A0 8001B8A0 21808000 */  addu       $s0, $a0, $zero
    /* C0A4 8001B8A4 3800A38F */  lw         $v1, 0x38($sp)
    /* C0A8 8001B8A8 3C00A48F */  lw         $a0, 0x3C($sp)
    /* C0AC 8001B8AC 4000A28F */  lw         $v0, 0x40($sp)
    /* C0B0 8001B8B0 2400BFAF */  sw         $ra, 0x24($sp)
    /* C0B4 8001B8B4 00140200 */  sll        $v0, $v0, 16
    /* C0B8 8001B8B8 03140200 */  sra        $v0, $v0, 16
    /* C0BC 8001B8BC 1400A4AF */  sw         $a0, 0x14($sp)
    /* C0C0 8001B8C0 21200002 */  addu       $a0, $s0, $zero
    /* C0C4 8001B8C4 1000A3AF */  sw         $v1, 0x10($sp)
    /* C0C8 8001B8C8 406C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* C0CC 8001B8CC 1800A2AF */   sw        $v0, 0x18($sp)
    /* C0D0 8001B8D0 21100002 */  addu       $v0, $s0, $zero
    /* C0D4 8001B8D4 0180033C */  lui        $v1, %hi(_vt_10tMenuBlank)
    /* C0D8 8001B8D8 80066324 */  addiu      $v1, $v1, %lo(_vt_10tMenuBlank)
    /* C0DC 8001B8DC 680043AC */  sw         $v1, 0x68($v0)
    /* C0E0 8001B8E0 01000324 */  addiu      $v1, $zero, 0x1
    /* C0E4 8001B8E4 0C0043AC */  sw         $v1, 0xC($v0)
    /* C0E8 8001B8E8 640040A4 */  sh         $zero, 0x64($v0)
    /* C0EC 8001B8EC 2400BF8F */  lw         $ra, 0x24($sp)
    /* C0F0 8001B8F0 2000B08F */  lw         $s0, 0x20($sp)
    /* C0F4 8001B8F4 0800E003 */  jr         $ra
    /* C0F8 8001B8F8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
