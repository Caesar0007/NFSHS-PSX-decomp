.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18tScreenTournSelect, 0x34

glabel __18tScreenTournSelect
    /* 2FF78 8003F778 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FF7C 8003F77C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FF80 8003F780 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2FF84 8003F784 0898000C */  jal        __7tScreen
    /* 2FF88 8003F788 21808000 */   addu      $s0, $a0, $zero
    /* 2FF8C 8003F78C 0180023C */  lui        $v0, %hi(_vt_18tScreenTournSelect)
    /* 2FF90 8003F790 B01D4224 */  addiu      $v0, $v0, %lo(_vt_18tScreenTournSelect)
    /* 2FF94 8003F794 600002AE */  sw         $v0, 0x60($s0)
    /* 2FF98 8003F798 21100002 */  addu       $v0, $s0, $zero
    /* 2FF9C 8003F79C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2FFA0 8003F7A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FFA4 8003F7A4 0800E003 */  jr         $ra
    /* 2FFA8 8003F7A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __18tScreenTournSelect
