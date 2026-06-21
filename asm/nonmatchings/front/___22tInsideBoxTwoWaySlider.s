.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___22tInsideBoxTwoWaySlider, 0x28

glabel ___22tInsideBoxTwoWaySlider
    /* FCC8 8001F4C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FCCC 8001F4CC 0180023C */  lui        $v0, %hi(_vt_22tInsideBoxTwoWaySlider)
    /* FCD0 8001F4D0 700B4224 */  addiu      $v0, $v0, %lo(_vt_22tInsideBoxTwoWaySlider)
    /* FCD4 8001F4D4 1000BFAF */  sw         $ra, 0x10($sp)
    /* FCD8 8001F4D8 D592000C */  jal        ___24tMenuItemLeftRightSlider
    /* FCDC 8001F4DC 180082AC */   sw        $v0, 0x18($a0)
    /* FCE0 8001F4E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* FCE4 8001F4E4 00000000 */  nop
    /* FCE8 8001F4E8 0800E003 */  jr         $ra
    /* FCEC 8001F4EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___22tInsideBoxTwoWaySlider
