.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching restoremdec, 0x54

glabel restoremdec
    /* 41254 80050A54 0580033C */  lui        $v1, %hi(gMDECinfo)
    /* 41258 80050A58 282B628C */  lw         $v0, %lo(gMDECinfo)($v1)
    /* 4125C 80050A5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 41260 80050A60 1000B0AF */  sw         $s0, 0x10($sp)
    /* 41264 80050A64 21808000 */  addu       $s0, $a0, $zero
    /* 41268 80050A68 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4126C 80050A6C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 41270 80050A70 03004014 */  bnez       $v0, .L80050A80
    /* 41274 80050A74 282B62AC */   sw        $v0, %lo(gMDECinfo)($v1)
    /* 41278 80050A78 B5E2030C */  jal        DecDCToutCallback
    /* 4127C 80050A7C 21200000 */   addu      $a0, $zero, $zero
  .L80050A80:
    /* 41280 80050A80 2400048E */  lw         $a0, 0x24($s0)
    /* 41284 80050A84 5095030C */  jal        purgememadr
    /* 41288 80050A88 00000000 */   nop
    /* 4128C 80050A8C 21200002 */  addu       $a0, $s0, $zero
    /* 41290 80050A90 5095030C */  jal        purgememadr
    /* 41294 80050A94 000080AC */   sw        $zero, 0x0($a0)
    /* 41298 80050A98 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4129C 80050A9C 1000B08F */  lw         $s0, 0x10($sp)
    /* 412A0 80050AA0 0800E003 */  jr         $ra
    /* 412A4 80050AA4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel restoremdec
