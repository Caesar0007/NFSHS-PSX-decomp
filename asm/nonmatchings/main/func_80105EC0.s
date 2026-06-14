.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105EC0, 0x20

glabel func_80105EC0
    /* F66C0 80105EC0 4C000224 */  addiu      $v0, $zero, 0x4C
    /* F66C4 80105EC4 360082A0 */  sb         $v0, 0x36($a0)
    /* F66C8 80105EC8 24008224 */  addiu      $v0, $a0, 0x24
    /* F66CC 80105ECC 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F66D0 80105ED0 01000224 */  addiu      $v0, $zero, 0x1
    /* F66D4 80105ED4 240085A0 */  sb         $a1, 0x24($a0)
    /* F66D8 80105ED8 0800E003 */  jr         $ra
    /* F66DC 80105EDC 350082A0 */   sb        $v0, 0x35($a0)
endlabel func_80105EC0
