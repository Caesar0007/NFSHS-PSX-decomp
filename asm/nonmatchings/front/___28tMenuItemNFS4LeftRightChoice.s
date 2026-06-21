.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___28tMenuItemNFS4LeftRightChoice, 0x28

glabel ___28tMenuItemNFS4LeftRightChoice
    /* B0A0 8001A8A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* B0A4 8001A8A4 0180023C */  lui        $v0, %hi(_vt_28tMenuItemNFS4LeftRightChoice)
    /* B0A8 8001A8A8 B0084224 */  addiu      $v0, $v0, %lo(_vt_28tMenuItemNFS4LeftRightChoice)
    /* B0AC 8001A8AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* B0B0 8001A8B0 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* B0B4 8001A8B4 180082AC */   sw        $v0, 0x18($a0)
    /* B0B8 8001A8B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* B0BC 8001A8BC 00000000 */  nop
    /* B0C0 8001A8C0 0800E003 */  jr         $ra
    /* B0C4 8001A8C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___28tMenuItemNFS4LeftRightChoice
