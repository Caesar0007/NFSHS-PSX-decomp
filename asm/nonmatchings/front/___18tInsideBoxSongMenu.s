.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tInsideBoxSongMenu, 0x28

glabel ___18tInsideBoxSongMenu
    /* F1B0 8001E9B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F1B4 8001E9B4 0180023C */  lui        $v0, %hi(_vt_18tInsideBoxSongMenu)
    /* F1B8 8001E9B8 780C4224 */  addiu      $v0, $v0, %lo(_vt_18tInsideBoxSongMenu)
    /* F1BC 8001E9BC 1000BFAF */  sw         $ra, 0x10($sp)
    /* F1C0 8001E9C0 8173000C */  jal        ___14tInsideBoxMenu
    /* F1C4 8001E9C4 680082AC */   sw        $v0, 0x68($a0)
    /* F1C8 8001E9C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F1CC 8001E9CC 00000000 */  nop
    /* F1D0 8001E9D0 0800E003 */  jr         $ra
    /* F1D4 8001E9D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tInsideBoxSongMenu
