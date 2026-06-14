.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __17AIHigh_BTC_AIPerpP8Car_tObj, 0x88

glabel __17AIHigh_BTC_AIPerpP8Car_tObj
    /* 50AF4 800602F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 50AF8 800602F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50AFC 800602FC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 50B00 80060300 3D70010C */  jal        __16AIHigh_BasicPerpP8Car_tObj
    /* 50B04 80060304 21808000 */   addu      $s0, $a0, $zero
    /* 50B08 80060308 0580023C */  lui        $v0, %hi(D_80054FE0)
    /* 50B0C 8006030C E04F4224 */  addiu      $v0, $v0, %lo(D_80054FE0)
    /* 50B10 80060310 140002AE */  sw         $v0, 0x14($s0)
    /* 50B14 80060314 01000224 */  addiu      $v0, $zero, 0x1
    /* 50B18 80060318 7C0002AE */  sw         $v0, 0x7C($s0)
    /* 50B1C 8006031C 0580023C */  lui        $v0, %hi(_vt_17AIHigh_BTC_AIPerp)
    /* 50B20 80060320 0000038E */  lw         $v1, 0x0($s0)
    /* 50B24 80060324 A04F4224 */  addiu      $v0, $v0, %lo(_vt_17AIHigh_BTC_AIPerp)
    /* 50B28 80060328 140002AE */  sw         $v0, 0x14($s0)
    /* 50B2C 8006032C 00FA0234 */  ori        $v0, $zero, 0xFA00
    /* 50B30 80060330 800000AE */  sw         $zero, 0x80($s0)
    /* 50B34 80060334 840000AE */  sw         $zero, 0x84($s0)
    /* 50B38 80060338 880000AE */  sw         $zero, 0x88($s0)
    /* 50B3C 8006033C 8C0000AE */  sw         $zero, 0x8C($s0)
    /* 50B40 80060340 900000AE */  sw         $zero, 0x90($s0)
    /* 50B44 80060344 940002AE */  sw         $v0, 0x94($s0)
    /* 50B48 80060348 980000AE */  sw         $zero, 0x98($s0)
    /* 50B4C 8006034C B800628C */  lw         $v0, 0xB8($v1)
    /* 50B50 80060350 00000000 */  nop
    /* 50B54 80060354 9C0002AE */  sw         $v0, 0x9C($s0)
    /* 50B58 80060358 BC00638C */  lw         $v1, 0xBC($v1)
    /* 50B5C 8006035C 21100002 */  addu       $v0, $s0, $zero
    /* 50B60 80060360 A40040AC */  sw         $zero, 0xA4($v0)
    /* 50B64 80060364 A80040AC */  sw         $zero, 0xA8($v0)
    /* 50B68 80060368 A00043AC */  sw         $v1, 0xA0($v0)
    /* 50B6C 8006036C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 50B70 80060370 1000B08F */  lw         $s0, 0x10($sp)
    /* 50B74 80060374 0800E003 */  jr         $ra
    /* 50B78 80060378 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __17AIHigh_BTC_AIPerpP8Car_tObj
