.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___27tMenuItemGoToMenuNFS4Button, 0x28

glabel ___27tMenuItemGoToMenuNFS4Button
    /* AD14 8001A514 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AD18 8001A518 0180023C */  lui        $v0, %hi(_vt_27tMenuItemGoToMenuNFS4Button)
    /* AD1C 8001A51C 08094224 */  addiu      $v0, $v0, %lo(_vt_27tMenuItemGoToMenuNFS4Button)
    /* AD20 8001A520 1000BFAF */  sw         $ra, 0x10($sp)
    /* AD24 8001A524 DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* AD28 8001A528 180082AC */   sw        $v0, 0x18($a0)
    /* AD2C 8001A52C 1000BF8F */  lw         $ra, 0x10($sp)
    /* AD30 8001A530 00000000 */  nop
    /* AD34 8001A534 0800E003 */  jr         $ra
    /* AD38 8001A538 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___27tMenuItemGoToMenuNFS4Button
