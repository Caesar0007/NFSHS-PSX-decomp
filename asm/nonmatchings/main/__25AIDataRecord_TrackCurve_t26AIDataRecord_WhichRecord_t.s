.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t, 0x98

glabel __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
    /* 5DB0C 8006D30C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DB10 8006D310 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5DB14 8006D314 21808000 */  addu       $s0, $a0, $zero
    /* 5DB18 8006D318 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5DB1C 8006D31C 89B3010C */  jal        __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
    /* 5DB20 8006D320 21300000 */   addu      $a2, $zero, $zero
    /* 5DB24 8006D324 0580023C */  lui        $v0, %hi(D_80055464)
    /* 5DB28 8006D328 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5DB2C 8006D32C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5DB30 8006D330 64544224 */  addiu      $v0, $v0, %lo(D_80055464)
    /* 5DB34 8006D334 540002AE */  sw         $v0, 0x54($s0)
    /* 5DB38 8006D338 5000028E */  lw         $v0, 0x50($s0)
    /* 5DB3C 8006D33C 000003AE */  sw         $v1, 0x0($s0)
    /* 5DB40 8006D340 01006324 */  addiu      $v1, $v1, 0x1
    /* 5DB44 8006D344 09004014 */  bnez       $v0, .L8006D36C
    /* 5DB48 8006D348 040003AE */   sw        $v1, 0x4($s0)
    /* 5DB4C 8006D34C 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DB50 8006D350 1180023C */  lui        $v0, %hi(D_80116490)
    /* 5DB54 8006D354 9064468C */  lw         $a2, %lo(D_80116490)($v0)
    /* 5DB58 8006D358 1180023C */  lui        $v0, %hi(D_80113228)
    /* 5DB5C 8006D35C 0580053C */  lui        $a1, %hi(D_800553E4)
    /* 5DB60 8006D360 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* 5DB64 8006D364 E2B40108 */  j          .L8006D388
    /* 5DB68 8006D368 E453A524 */   addiu     $a1, $a1, %lo(D_800553E4)
  .L8006D36C:
    /* 5DB6C 8006D36C 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DB70 8006D370 1180023C */  lui        $v0, %hi(D_80116494)
    /* 5DB74 8006D374 9464468C */  lw         $a2, %lo(D_80116494)($v0)
    /* 5DB78 8006D378 1180023C */  lui        $v0, %hi(D_80113228)
    /* 5DB7C 8006D37C 0580053C */  lui        $a1, %hi(D_800553F4)
    /* 5DB80 8006D380 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* 5DB84 8006D384 F453A524 */  addiu      $a1, $a1, %lo(D_800553F4)
  .L8006D388:
    /* 5DB88 8006D388 2F91030C */  jal        sprintf
    /* 5DB8C 8006D38C 00000000 */   nop
    /* 5DB90 8006D390 21100002 */  addu       $v0, $s0, $zero
    /* 5DB94 8006D394 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5DB98 8006D398 1000B08F */  lw         $s0, 0x10($sp)
    /* 5DB9C 8006D39C 0800E003 */  jr         $ra
    /* 5DBA0 8006D3A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
