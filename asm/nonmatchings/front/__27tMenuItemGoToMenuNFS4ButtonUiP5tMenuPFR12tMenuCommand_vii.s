.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii, 0x68

glabel __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* ACAC 8001A4AC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ACB0 8001A4B0 1800B2AF */  sw         $s2, 0x18($sp)
    /* ACB4 8001A4B4 3000B28F */  lw         $s2, 0x30($sp)
    /* ACB8 8001A4B8 1000B0AF */  sw         $s0, 0x10($sp)
    /* ACBC 8001A4BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* ACC0 8001A4C0 3400B18F */  lw         $s1, 0x34($sp)
    /* ACC4 8001A4C4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* ACC8 8001A4C8 CA94000C */  jal        __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
    /* ACCC 8001A4CC 21808000 */   addu      $s0, $a0, $zero
    /* ACD0 8001A4D0 21100002 */  addu       $v0, $s0, $zero
    /* ACD4 8001A4D4 0180033C */  lui        $v1, %hi(_vt_27tMenuItemGoToMenuNFS4Button)
    /* ACD8 8001A4D8 08096324 */  addiu      $v1, $v1, %lo(_vt_27tMenuItemGoToMenuNFS4Button)
    /* ACDC 8001A4DC 180043AC */  sw         $v1, 0x18($v0)
    /* ACE0 8001A4E0 0E000324 */  addiu      $v1, $zero, 0xE
    /* ACE4 8001A4E4 240043A4 */  sh         $v1, 0x24($v0)
    /* ACE8 8001A4E8 260040A4 */  sh         $zero, 0x26($v0)
    /* ACEC 8001A4EC 280040A4 */  sh         $zero, 0x28($v0)
    /* ACF0 8001A4F0 2A0040A4 */  sh         $zero, 0x2A($v0)
    /* ACF4 8001A4F4 100051AC */  sw         $s1, 0x10($v0)
    /* ACF8 8001A4F8 0C0052AC */  sw         $s2, 0xC($v0)
    /* ACFC 8001A4FC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* AD00 8001A500 1800B28F */  lw         $s2, 0x18($sp)
    /* AD04 8001A504 1400B18F */  lw         $s1, 0x14($sp)
    /* AD08 8001A508 1000B08F */  lw         $s0, 0x10($sp)
    /* AD0C 8001A50C 0800E003 */  jr         $ra
    /* AD10 8001A510 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
