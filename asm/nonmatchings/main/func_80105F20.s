.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105F20, 0x14

glabel func_80105F20
    /* F6720 80105F20 4B000224 */  addiu      $v0, $zero, 0x4B
    /* F6724 80105F24 360082A0 */  sb         $v0, 0x36($a0)
    /* F6728 80105F28 2C0080AC */  sw         $zero, 0x2C($a0)
    /* F672C 80105F2C 0800E003 */  jr         $ra
    /* F6730 80105F30 350080A0 */   sb        $zero, 0x35($a0)
endlabel func_80105F20
    /* F6734 80105F34 00000000 */  nop
    /* F6738 80105F38 00000000 */  nop
    /* F673C 80105F3C 00000000 */  nop
