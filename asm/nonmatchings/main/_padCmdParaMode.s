.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padCmdParaMode, 0x20

glabel _padCmdParaMode
    /* F668C 80105E8C 43000224 */  addiu      $v0, $zero, 0x43
    /* F6690 80105E90 360082A0 */  sb         $v0, 0x36($a0)
    /* F6694 80105E94 24008224 */  addiu      $v0, $a0, 0x24
    /* F6698 80105E98 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F669C 80105E9C 01000224 */  addiu      $v0, $zero, 0x1
    /* F66A0 80105EA0 240085A0 */  sb         $a1, 0x24($a0)
    /* F66A4 80105EA4 0800E003 */  jr         $ra
    /* F66A8 80105EA8 350082A0 */   sb        $v0, 0x35($a0)
endlabel _padCmdParaMode
