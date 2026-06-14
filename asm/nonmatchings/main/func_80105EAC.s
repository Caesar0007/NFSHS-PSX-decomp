.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105EAC, 0x14

glabel func_80105EAC
    /* F66AC 80105EAC 45000224 */  addiu      $v0, $zero, 0x45
    /* F66B0 80105EB0 360082A0 */  sb         $v0, 0x36($a0)
    /* F66B4 80105EB4 2C0080AC */  sw         $zero, 0x2C($a0)
    /* F66B8 80105EB8 0800E003 */  jr         $ra
    /* F66BC 80105EBC 350080A0 */   sb        $zero, 0x35($a0)
endlabel func_80105EAC
