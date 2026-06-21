.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__25tScreenPinkSlipsCarSelect, 0x20

glabel DrawForeground__25tScreenPinkSlipsCarSelect
    /* 2FA2C 8003F22C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FA30 8003F230 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2FA34 8003F234 85FA000C */  jal        DrawForeground__25tScreenCarSelectTwoPlayer
    /* 2FA38 8003F238 00000000 */   nop
    /* 2FA3C 8003F23C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2FA40 8003F240 00000000 */  nop
    /* 2FA44 8003F244 0800E003 */  jr         $ra
    /* 2FA48 8003F248 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawForeground__25tScreenPinkSlipsCarSelect
