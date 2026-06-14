.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14AIHigh_BTC_CopP8Car_tObji, 0x40

glabel __14AIHigh_BTC_CopP8Car_tObji
    /* 4D36C 8005CB6C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D370 8005CB70 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D374 8005CB74 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4D378 8005CB78 5970010C */  jal        __15AIHigh_BasicCopP8Car_tObji
    /* 4D37C 8005CB7C 21808000 */   addu      $s0, $a0, $zero
    /* 4D380 8005CB80 21100002 */  addu       $v0, $s0, $zero
    /* 4D384 8005CB84 0580033C */  lui        $v1, %hi(_vt_14AIHigh_BTC_Cop)
    /* 4D388 8005CB88 044F6324 */  addiu      $v1, $v1, %lo(_vt_14AIHigh_BTC_Cop)
    /* 4D38C 8005CB8C 140043AC */  sw         $v1, 0x14($v0)
    /* 4D390 8005CB90 580040AC */  sw         $zero, 0x58($v0)
    /* 4D394 8005CB94 5C0040AC */  sw         $zero, 0x5C($v0)
    /* 4D398 8005CB98 600040AC */  sw         $zero, 0x60($v0)
    /* 4D39C 8005CB9C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4D3A0 8005CBA0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D3A4 8005CBA4 0800E003 */  jr         $ra
    /* 4D3A8 8005CBA8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __14AIHigh_BTC_CopP8Car_tObji
