.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t, 0x84

glabel __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
    /* 5D970 8006D170 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5D974 8006D174 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D978 8006D178 21808000 */  addu       $s0, $a0, $zero
    /* 5D97C 8006D17C 2110A000 */  addu       $v0, $a1, $zero
    /* 5D980 8006D180 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5D984 8006D184 2188C000 */  addu       $s1, $a2, $zero
    /* 5D988 8006D188 2128E000 */  addu       $a1, $a3, $zero
    /* 5D98C 8006D18C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5D990 8006D190 89B3010C */  jal        __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
    /* 5D994 8006D194 21304000 */   addu      $a2, $v0, $zero
    /* 5D998 8006D198 08000426 */  addiu      $a0, $s0, 0x8
    /* 5D99C 8006D19C 0580053C */  lui        $a1, %hi(D_800553B8)
    /* 5D9A0 8006D1A0 B853A524 */  addiu      $a1, $a1, %lo(D_800553B8)
    /* 5D9A4 8006D1A4 0580023C */  lui        $v0, %hi(_vt_23AIDataRecord_AccTable_t)
    /* 5D9A8 8006D1A8 94544224 */  addiu      $v0, $v0, %lo(_vt_23AIDataRecord_AccTable_t)
    /* 5D9AC 8006D1AC 540002AE */  sw         $v0, 0x54($s0)
    /* 5D9B0 8006D1B0 70000224 */  addiu      $v0, $zero, 0x70
    /* 5D9B4 8006D1B4 000002AE */  sw         $v0, 0x0($s0)
    /* 5D9B8 8006D1B8 E0000224 */  addiu      $v0, $zero, 0xE0
    /* 5D9BC 8006D1BC 1180033C */  lui        $v1, %hi(D_8011647C)
    /* 5D9C0 8006D1C0 040002AE */  sw         $v0, 0x4($s0)
    /* 5D9C4 8006D1C4 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 5D9C8 8006D1C8 580011AE */  sw         $s1, 0x58($s0)
    /* 5D9CC 8006D1CC 48FA478C */  lw         $a3, %lo(Cars_gHumanRaceCarList)($v0)
    /* 5D9D0 8006D1D0 7C64668C */  lw         $a2, %lo(D_8011647C)($v1)
    /* 5D9D4 8006D1D4 2F91030C */  jal        sprintf
    /* 5D9D8 8006D1D8 4002E724 */   addiu     $a3, $a3, 0x240
    /* 5D9DC 8006D1DC 21100002 */  addu       $v0, $s0, $zero
    /* 5D9E0 8006D1E0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5D9E4 8006D1E4 1400B18F */  lw         $s1, 0x14($sp)
    /* 5D9E8 8006D1E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D9EC 8006D1EC 0800E003 */  jr         $ra
    /* 5D9F0 8006D1F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
