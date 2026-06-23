.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strNextVlc__FP6DECENV, 0xA0

glabel strNextVlc__FP6DECENV
    /* 3DB34 8004D334 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3DB38 8004D338 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3DB3C 8004D33C 21908000 */  addu       $s2, $a0, $zero
    /* 3DB40 8004D340 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3DB44 8004D344 0A001024 */  addiu      $s0, $zero, 0xA
    /* 3DB48 8004D348 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3DB4C 8004D34C 1400B1AF */  sw         $s1, 0x14($sp)
  .L8004D350:
    /* 3DB50 8004D350 F534010C */  jal        strNext__FP6DECENV
    /* 3DB54 8004D354 21204002 */   addu      $a0, $s2, $zero
    /* 3DB58 8004D358 21884000 */  addu       $s1, $v0, $zero
    /* 3DB5C 8004D35C 05002016 */  bnez       $s1, .L8004D374
    /* 3DB60 8004D360 FFFF1026 */   addiu     $s0, $s0, -0x1
    /* 3DB64 8004D364 FAFF0016 */  bnez       $s0, .L8004D350
    /* 3DB68 8004D368 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 3DB6C 8004D36C EF340108 */  j          .L8004D3BC
    /* 3DB70 8004D370 00000000 */   nop
  .L8004D374:
    /* 3DB74 8004D374 0800428E */  lw         $v0, 0x8($s2)
    /* 3DB78 8004D378 00000000 */  nop
    /* 3DB7C 8004D37C 0100422C */  sltiu      $v0, $v0, 0x1
    /* 3DB80 8004D380 080042AE */  sw         $v0, 0x8($s2)
    /* 3DB84 8004D384 80100200 */  sll        $v0, $v0, 2
    /* 3DB88 8004D388 21104202 */  addu       $v0, $s2, $v0
    /* 3DB8C 8004D38C 0000458C */  lw         $a1, 0x0($v0)
    /* 3DB90 8004D390 0CDD030C */  jal        DecDCTvlc
    /* 3DB94 8004D394 21202002 */   addu      $a0, $s1, $zero
    /* 3DB98 8004D398 05004010 */  beqz       $v0, .L8004D3B0
    /* 3DB9C 8004D39C 21200000 */   addu      $a0, $zero, $zero
  .L8004D3A0:
    /* 3DBA0 8004D3A0 0CDD030C */  jal        DecDCTvlc
    /* 3DBA4 8004D3A4 21288000 */   addu      $a1, $a0, $zero
    /* 3DBA8 8004D3A8 FDFF4014 */  bnez       $v0, .L8004D3A0
    /* 3DBAC 8004D3AC 21200000 */   addu      $a0, $zero, $zero
  .L8004D3B0:
    /* 3DBB0 8004D3B0 65EA030C */  jal        StFreeRing
    /* 3DBB4 8004D3B4 21202002 */   addu      $a0, $s1, $zero
    /* 3DBB8 8004D3B8 21100000 */  addu       $v0, $zero, $zero
  .L8004D3BC:
    /* 3DBBC 8004D3BC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3DBC0 8004D3C0 1800B28F */  lw         $s2, 0x18($sp)
    /* 3DBC4 8004D3C4 1400B18F */  lw         $s1, 0x14($sp)
    /* 3DBC8 8004D3C8 1000B08F */  lw         $s0, 0x10($sp)
    /* 3DBCC 8004D3CC 0800E003 */  jr         $ra
    /* 3DBD0 8004D3D0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel strNextVlc__FP6DECENV
