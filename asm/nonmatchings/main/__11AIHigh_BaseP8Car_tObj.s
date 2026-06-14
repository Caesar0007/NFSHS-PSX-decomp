.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __11AIHigh_BaseP8Car_tObj, 0xAC

glabel __11AIHigh_BaseP8Car_tObj
    /* 4BB18 8005B318 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4BB1C 8005B31C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4BB20 8005B320 21808000 */  addu       $s0, $a0, $zero
    /* 4BB24 8005B324 08000424 */  addiu      $a0, $zero, 0x8
    /* 4BB28 8005B328 0580023C */  lui        $v0, %hi(_vt_11AIHigh_Base)
    /* 4BB2C 8005B32C 044E4224 */  addiu      $v0, $v0, %lo(_vt_11AIHigh_Base)
    /* 4BB30 8005B330 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4BB34 8005B334 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4BB38 8005B338 140002AE */  sw         $v0, 0x14($s0)
    /* 4BB3C 8005B33C 000005AE */  sw         $a1, 0x0($s0)
    /* 4BB40 8005B340 040000AE */  sw         $zero, 0x4($s0)
    /* 4BB44 8005B344 578F020C */  jal        __builtin_new
    /* 4BB48 8005B348 080000AE */   sw        $zero, 0x8($s0)
    /* 4BB4C 8005B34C 21884000 */  addu       $s1, $v0, $zero
    /* 4BB50 8005B350 0000058E */  lw         $a1, 0x0($s0)
    /* 4BB54 8005B354 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4BB58 8005B358 21202002 */   addu      $a0, $s1, $zero
    /* 4BB5C 8005B35C 0580023C */  lui        $v0, %hi(D_80054E1C)
    /* 4BB60 8005B360 1C4E4224 */  addiu      $v0, $v0, %lo(D_80054E1C)
    /* 4BB64 8005B364 040022AE */  sw         $v0, 0x4($s1)
    /* 4BB68 8005B368 0400038E */  lw         $v1, 0x4($s0)
    /* 4BB6C 8005B36C 00000000 */  nop
    /* 4BB70 8005B370 08006010 */  beqz       $v1, .L8005B394
    /* 4BB74 8005B374 03000524 */   addiu     $a1, $zero, 0x3
    /* 4BB78 8005B378 0400628C */  lw         $v0, 0x4($v1)
    /* 4BB7C 8005B37C 00000000 */  nop
    /* 4BB80 8005B380 10004484 */  lh         $a0, 0x10($v0)
    /* 4BB84 8005B384 1400428C */  lw         $v0, 0x14($v0)
    /* 4BB88 8005B388 00000000 */  nop
    /* 4BB8C 8005B38C 09F84000 */  jalr       $v0
    /* 4BB90 8005B390 21206400 */   addu      $a0, $v1, $a0
  .L8005B394:
    /* 4BB94 8005B394 0000028E */  lw         $v0, 0x0($s0)
    /* 4BB98 8005B398 040011AE */  sw         $s1, 0x4($s0)
    /* 4BB9C 8005B39C 080000AE */  sw         $zero, 0x8($s0)
    /* 4BBA0 8005B3A0 0C0000AE */  sw         $zero, 0xC($s0)
    /* 4BBA4 8005B3A4 08004384 */  lh         $v1, 0x8($v0)
    /* 4BBA8 8005B3A8 21100002 */  addu       $v0, $s0, $zero
    /* 4BBAC 8005B3AC 100043AC */  sw         $v1, 0x10($v0)
    /* 4BBB0 8005B3B0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4BBB4 8005B3B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 4BBB8 8005B3B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 4BBBC 8005B3BC 0800E003 */  jr         $ra
    /* 4BBC0 8005B3C0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __11AIHigh_BaseP8Car_tObj
