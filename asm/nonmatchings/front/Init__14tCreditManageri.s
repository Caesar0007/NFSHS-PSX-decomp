.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init__14tCreditManageri, 0xE0

glabel Init__14tCreditManageri
    /* 262F8 80035AF8 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 262FC 80035AFC 6000B0AF */  sw         $s0, 0x60($sp)
    /* 26300 80035B00 21808000 */  addu       $s0, $a0, $zero
    /* 26304 80035B04 6400BFAF */  sw         $ra, 0x64($sp)
    /* 26308 80035B08 1000028E */  lw         $v0, 0x10($s0)
    /* 2630C 80035B0C 00000000 */  nop
    /* 26310 80035B10 2D004014 */  bnez       $v0, .L80035BC8
    /* 26314 80035B14 00000000 */   nop
    /* 26318 80035B18 1400028E */  lw         $v0, 0x14($s0)
    /* 2631C 80035B1C 00000000 */  nop
    /* 26320 80035B20 02004010 */  beqz       $v0, .L80035B2C
    /* 26324 80035B24 00000000 */   nop
    /* 26328 80035B28 140000AE */  sw         $zero, 0x14($s0)
  .L80035B2C:
    /* 2632C 80035B2C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 26330 80035B30 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 26334 80035B34 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 26338 80035B38 80000224 */  addiu      $v0, $zero, 0x80
    /* 2633C 80035B3C 080002AE */  sw         $v0, 0x8($s0)
    /* 26340 80035B40 1180023C */  lui        $v0, %hi(D_801164FC)
    /* 26344 80035B44 0180053C */  lui        $a1, %hi(D_80011864)
    /* 26348 80035B48 340000AE */  sw         $zero, 0x34($s0)
    /* 2634C 80035B4C 240000AE */  sw         $zero, 0x24($s0)
    /* 26350 80035B50 280000AE */  sw         $zero, 0x28($s0)
    /* 26354 80035B54 2C0000AE */  sw         $zero, 0x2C($s0)
    /* 26358 80035B58 140000AE */  sw         $zero, 0x14($s0)
    /* 2635C 80035B5C 200000AE */  sw         $zero, 0x20($s0)
    /* 26360 80035B60 FC64468C */  lw         $a2, %lo(D_801164FC)($v0)
    /* 26364 80035B64 1180023C */  lui        $v0, %hi(D_80114940)
    /* 26368 80035B68 40494790 */  lbu        $a3, %lo(D_80114940)($v0)
    /* 2636C 80035B6C 2F91030C */  jal        sprintf
    /* 26370 80035B70 6418A524 */   addiu     $a1, $a1, %lo(D_80011864)
    /* 26374 80035B74 9B95030C */  jal        filesize
    /* 26378 80035B78 1000A427 */   addiu     $a0, $sp, 0x10
    /* 2637C 80035B7C 0180043C */  lui        $a0, %hi(D_80011874)
    /* 26380 80035B80 74188424 */  addiu      $a0, $a0, %lo(D_80011874)
    /* 26384 80035B84 21284000 */  addu       $a1, $v0, $zero
    /* 26388 80035B88 CF94030C */  jal        reservememadr
    /* 2638C 80035B8C 21300000 */   addu      $a2, $zero, $zero
    /* 26390 80035B90 1000A427 */  addiu      $a0, $sp, 0x10
    /* 26394 80035B94 21284000 */  addu       $a1, $v0, $zero
    /* 26398 80035B98 2C96030C */  jal        loadfileatadrz
    /* 2639C 80035B9C 000005AE */   sw        $a1, 0x0($s0)
    /* 263A0 80035BA0 9B95030C */  jal        filesize
    /* 263A4 80035BA4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 263A8 80035BA8 45CA033C */  lui        $v1, (0xCA4587E7 >> 16)
    /* 263AC 80035BAC E7876334 */  ori        $v1, $v1, (0xCA4587E7 & 0xFFFF)
    /* 263B0 80035BB0 19004300 */  multu      $v0, $v1
    /* 263B4 80035BB4 01000224 */  addiu      $v0, $zero, 0x1
    /* 263B8 80035BB8 100002AE */  sw         $v0, 0x10($s0)
    /* 263BC 80035BBC 10400000 */  mfhi       $t0
    /* 263C0 80035BC0 02120800 */  srl        $v0, $t0, 8
    /* 263C4 80035BC4 180002AE */  sw         $v0, 0x18($s0)
  .L80035BC8:
    /* 263C8 80035BC8 6400BF8F */  lw         $ra, 0x64($sp)
    /* 263CC 80035BCC 6000B08F */  lw         $s0, 0x60($sp)
    /* 263D0 80035BD0 0800E003 */  jr         $ra
    /* 263D4 80035BD4 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Init__14tCreditManageri
