.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105C5C, 0x1C

glabel func_80105C5C
    /* F645C 80105C5C 2000838C */  lw         $v1, 0x20($a0)
    /* F6460 80105C60 4D000224 */  addiu      $v0, $zero, 0x4D
    /* F6464 80105C64 360082A0 */  sb         $v0, 0x36($a0)
    /* F6468 80105C68 06000224 */  addiu      $v0, $zero, 0x6
    /* F646C 80105C6C 350082A0 */  sb         $v0, 0x35($a0)
    /* F6470 80105C70 0800E003 */  jr         $ra
    /* F6474 80105C74 2C0083AC */   sw        $v1, 0x2C($a0)
endlabel func_80105C5C
