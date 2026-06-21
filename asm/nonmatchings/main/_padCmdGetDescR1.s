.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padCmdGetDescR1, 0x20

glabel _padCmdGetDescR1
    /* F6700 80105F00 47000224 */  addiu      $v0, $zero, 0x47
    /* F6704 80105F04 360082A0 */  sb         $v0, 0x36($a0)
    /* F6708 80105F08 24008224 */  addiu      $v0, $a0, 0x24
    /* F670C 80105F0C 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F6710 80105F10 01000224 */  addiu      $v0, $zero, 0x1
    /* F6714 80105F14 240085A0 */  sb         $a1, 0x24($a0)
    /* F6718 80105F18 0800E003 */  jr         $ra
    /* F671C 80105F1C 350082A0 */   sb        $v0, 0x35($a0)
endlabel _padCmdGetDescR1
