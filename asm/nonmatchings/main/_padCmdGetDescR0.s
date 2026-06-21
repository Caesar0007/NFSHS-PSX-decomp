.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padCmdGetDescR0, 0x20

glabel _padCmdGetDescR0
    /* F66E0 80105EE0 46000224 */  addiu      $v0, $zero, 0x46
    /* F66E4 80105EE4 360082A0 */  sb         $v0, 0x36($a0)
    /* F66E8 80105EE8 24008224 */  addiu      $v0, $a0, 0x24
    /* F66EC 80105EEC 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F66F0 80105EF0 01000224 */  addiu      $v0, $zero, 0x1
    /* F66F4 80105EF4 240085A0 */  sb         $a1, 0x24($a0)
    /* F66F8 80105EF8 0800E003 */  jr         $ra
    /* F66FC 80105EFC 350082A0 */   sb        $v0, 0x35($a0)
endlabel _padCmdGetDescR0
