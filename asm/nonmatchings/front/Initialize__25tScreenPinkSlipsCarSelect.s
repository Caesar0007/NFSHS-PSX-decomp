.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__25tScreenPinkSlipsCarSelect, 0x60

glabel Initialize__25tScreenPinkSlipsCarSelect
    /* 2FA4C 8003F24C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FA50 8003F250 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FA54 8003F254 21808000 */  addu       $s0, $a0, $zero
    /* 2FA58 8003F258 01000424 */  addiu      $a0, $zero, 0x1
    /* 2FA5C 8003F25C 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2FA60 8003F260 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2FA64 8003F264 380400AE */  sw         $zero, 0x438($s0)
    /* 2FA68 8003F268 400400AE */  sw         $zero, 0x440($s0)
    /* 2FA6C 8003F26C 440400AE */  sw         $zero, 0x444($s0)
    /* 2FA70 8003F270 342040AC */  sw         $zero, %lo(PinkSlipsScreenState)($v0)
    /* 2FA74 8003F274 34204224 */  addiu      $v0, $v0, %lo(PinkSlipsScreenState)
    /* 2FA78 8003F278 9140010C */  jal        MCRD_getcard
    /* 2FA7C 8003F27C 040040AC */   sw        $zero, 0x4($v0)
    /* 2FA80 8003F280 01000424 */  addiu      $a0, $zero, 0x1
    /* 2FA84 8003F284 21288000 */  addu       $a1, $a0, $zero
    /* 2FA88 8003F288 A9D1000C */  jal        Init_Memcard__FbT0
    /* 2FA8C 8003F28C 3C0402AE */   sw        $v0, 0x43C($s0)
    /* 2FA90 8003F290 21200002 */  addu       $a0, $s0, $zero
    /* 2FA94 8003F294 70FB000C */  jal        Initialize__25tScreenCarSelectTwoPlayer
    /* 2FA98 8003F298 480480AC */   sw        $zero, 0x448($a0)
    /* 2FA9C 8003F29C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2FAA0 8003F2A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FAA4 8003F2A4 0800E003 */  jr         $ra
    /* 2FAA8 8003F2A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__25tScreenPinkSlipsCarSelect
