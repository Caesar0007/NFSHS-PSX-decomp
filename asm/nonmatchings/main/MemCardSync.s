.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardSync, 0x11C

glabel MemCardSync
    /* EC2FC 800FBAFC 1480033C */  lui        $v1, %hi(D_80147518)
    /* EC300 800FBB00 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EC304 800FBB04 0000628C */  lw         $v0, 0x0($v1)
    /* EC308 800FBB08 00000000 */  nop
    /* EC30C 800FBB0C 05004014 */  bnez       $v0, .L800FBB24
    /* EC310 800FBB10 00000000 */   nop
    /* EC314 800FBB14 0800628C */  lw         $v0, 0x8($v1)
    /* EC318 800FBB18 00000000 */  nop
    /* EC31C 800FBB1C 3C004010 */  beqz       $v0, .L800FBC10
    /* EC320 800FBB20 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800FBB24:
    /* EC324 800FBB24 0000688C */  lw         $t0, 0x0($v1)
    /* EC328 800FBB28 0400678C */  lw         $a3, 0x4($v1)
    /* EC32C 800FBB2C 1D008014 */  bnez       $a0, .L800FBBA4
    /* EC330 800FBB30 00000000 */   nop
    /* EC334 800FBB34 0800628C */  lw         $v0, 0x8($v1)
    /* EC338 800FBB38 00000000 */  nop
    /* EC33C 800FBB3C 06004014 */  bnez       $v0, .L800FBB58
    /* EC340 800FBB40 00000000 */   nop
    /* EC344 800FBB44 08006324 */  addiu      $v1, $v1, 0x8
  .L800FBB48:
    /* EC348 800FBB48 0000628C */  lw         $v0, 0x0($v1)
    /* EC34C 800FBB4C 00000000 */  nop
    /* EC350 800FBB50 FDFF4010 */  beqz       $v0, .L800FBB48
    /* EC354 800FBB54 00000000 */   nop
  .L800FBB58:
    /* EC358 800FBB58 0600C010 */  beqz       $a2, .L800FBB74
    /* EC35C 800FBB5C 00000000 */   nop
    /* EC360 800FBB60 1480023C */  lui        $v0, %hi(D_80147564)
    /* EC364 800FBB64 64754224 */  addiu      $v0, $v0, %lo(D_80147564)
    /* EC368 800FBB68 0000428C */  lw         $v0, 0x0($v0)
    /* EC36C 800FBB6C 00000000 */  nop
    /* EC370 800FBB70 0000C2AC */  sw         $v0, 0x0($a2)
  .L800FBB74:
    /* EC374 800FBB74 0600A010 */  beqz       $a1, .L800FBB90
    /* EC378 800FBB78 00000000 */   nop
    /* EC37C 800FBB7C 1480023C */  lui        $v0, %hi(D_80147560)
    /* EC380 800FBB80 60754224 */  addiu      $v0, $v0, %lo(D_80147560)
    /* EC384 800FBB84 0000428C */  lw         $v0, 0x0($v0)
    /* EC388 800FBB88 00000000 */  nop
    /* EC38C 800FBB8C 0000A2AC */  sw         $v0, 0x0($a1)
  .L800FBB90:
    /* EC390 800FBB90 1480023C */  lui        $v0, %hi(D_80147518)
    /* EC394 800FBB94 18754224 */  addiu      $v0, $v0, %lo(D_80147518)
    /* EC398 800FBB98 080040AC */  sw         $zero, 0x8($v0)
    /* EC39C 800FBB9C 04EF0308 */  j          .L800FBC10
    /* EC3A0 800FBBA0 01000224 */   addiu     $v0, $zero, 0x1
  .L800FBBA4:
    /* EC3A4 800FBBA4 0800628C */  lw         $v0, 0x8($v1)
    /* EC3A8 800FBBA8 00000000 */  nop
    /* EC3AC 800FBBAC 08004014 */  bnez       $v0, .L800FBBD0
    /* EC3B0 800FBBB0 00000000 */   nop
    /* EC3B4 800FBBB4 0200C010 */  beqz       $a2, .L800FBBC0
    /* EC3B8 800FBBB8 00000000 */   nop
    /* EC3BC 800FBBBC 0000C7AC */  sw         $a3, 0x0($a2)
  .L800FBBC0:
    /* EC3C0 800FBBC0 1300A010 */  beqz       $a1, .L800FBC10
    /* EC3C4 800FBBC4 21100000 */   addu      $v0, $zero, $zero
    /* EC3C8 800FBBC8 04EF0308 */  j          .L800FBC10
    /* EC3CC 800FBBCC 0000A8AC */   sw        $t0, 0x0($a1)
  .L800FBBD0:
    /* EC3D0 800FBBD0 0600C010 */  beqz       $a2, .L800FBBEC
    /* EC3D4 800FBBD4 00000000 */   nop
    /* EC3D8 800FBBD8 1480023C */  lui        $v0, %hi(D_80147564)
    /* EC3DC 800FBBDC 64754224 */  addiu      $v0, $v0, %lo(D_80147564)
    /* EC3E0 800FBBE0 0000428C */  lw         $v0, 0x0($v0)
    /* EC3E4 800FBBE4 00000000 */  nop
    /* EC3E8 800FBBE8 0000C2AC */  sw         $v0, 0x0($a2)
  .L800FBBEC:
    /* EC3EC 800FBBEC 0600A010 */  beqz       $a1, .L800FBC08
    /* EC3F0 800FBBF0 00000000 */   nop
    /* EC3F4 800FBBF4 1480023C */  lui        $v0, %hi(D_80147560)
    /* EC3F8 800FBBF8 60754224 */  addiu      $v0, $v0, %lo(D_80147560)
    /* EC3FC 800FBBFC 0000428C */  lw         $v0, 0x0($v0)
    /* EC400 800FBC00 00000000 */  nop
    /* EC404 800FBC04 0000A2AC */  sw         $v0, 0x0($a1)
  .L800FBC08:
    /* EC408 800FBC08 080060AC */  sw         $zero, 0x8($v1)
    /* EC40C 800FBC0C 01000224 */  addiu      $v0, $zero, 0x1
  .L800FBC10:
    /* EC410 800FBC10 0800E003 */  jr         $ra
    /* EC414 800FBC14 00000000 */   nop
endlabel MemCardSync
