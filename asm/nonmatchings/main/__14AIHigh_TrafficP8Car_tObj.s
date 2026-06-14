.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14AIHigh_TrafficP8Car_tObj, 0x40

glabel __14AIHigh_TrafficP8Car_tObj
    /* 56EF8 800666F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 56EFC 800666FC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 56F00 80066700 1400BFAF */  sw         $ra, 0x14($sp)
    /* 56F04 80066704 C66C010C */  jal        __11AIHigh_BaseP8Car_tObj
    /* 56F08 80066708 21808000 */   addu      $s0, $a0, $zero
    /* 56F0C 8006670C 21100002 */  addu       $v0, $s0, $zero
    /* 56F10 80066710 0580033C */  lui        $v1, %hi(_vt_14AIHigh_Traffic)
    /* 56F14 80066714 B0516324 */  addiu      $v1, $v1, %lo(_vt_14AIHigh_Traffic)
    /* 56F18 80066718 140043AC */  sw         $v1, 0x14($v0)
    /* 56F1C 8006671C 180040AC */  sw         $zero, 0x18($v0)
    /* 56F20 80066720 1C0040AC */  sw         $zero, 0x1C($v0)
    /* 56F24 80066724 200040AC */  sw         $zero, 0x20($v0)
    /* 56F28 80066728 1400BF8F */  lw         $ra, 0x14($sp)
    /* 56F2C 8006672C 1000B08F */  lw         $s0, 0x10($sp)
    /* 56F30 80066730 0800E003 */  jr         $ra
    /* 56F34 80066734 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __14AIHigh_TrafficP8Car_tObj
