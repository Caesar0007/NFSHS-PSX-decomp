.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t, 0x94

glabel __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
    /* 5DA78 8006D278 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DA7C 8006D27C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5DA80 8006D280 21808000 */  addu       $s0, $a0, $zero
    /* 5DA84 8006D284 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5DA88 8006D288 89B3010C */  jal        __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
    /* 5DA8C 8006D28C 21300000 */   addu      $a2, $zero, $zero
    /* 5DA90 8006D290 0580023C */  lui        $v0, %hi(D_8005547C)
    /* 5DA94 8006D294 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5DA98 8006D298 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5DA9C 8006D29C 5000048E */  lw         $a0, 0x50($s0)
    /* 5DAA0 8006D2A0 7C544224 */  addiu      $v0, $v0, %lo(D_8005547C)
    /* 5DAA4 8006D2A4 540002AE */  sw         $v0, 0x54($s0)
    /* 5DAA8 8006D2A8 000003AE */  sw         $v1, 0x0($s0)
    /* 5DAAC 8006D2AC 09008014 */  bnez       $a0, .L8006D2D4
    /* 5DAB0 8006D2B0 040003AE */   sw        $v1, 0x4($s0)
    /* 5DAB4 8006D2B4 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DAB8 8006D2B8 1180023C */  lui        $v0, %hi(D_80116498)
    /* 5DABC 8006D2BC 9864468C */  lw         $a2, %lo(D_80116498)($v0)
    /* 5DAC0 8006D2C0 1180023C */  lui        $v0, %hi(D_80113228)
    /* 5DAC4 8006D2C4 0580053C */  lui        $a1, %hi(D_800553C4)
    /* 5DAC8 8006D2C8 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* 5DACC 8006D2CC BCB40108 */  j          .L8006D2F0
    /* 5DAD0 8006D2D0 C453A524 */   addiu     $a1, $a1, %lo(D_800553C4)
  .L8006D2D4:
    /* 5DAD4 8006D2D4 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DAD8 8006D2D8 1180023C */  lui        $v0, %hi(D_8011649C)
    /* 5DADC 8006D2DC 9C64468C */  lw         $a2, %lo(D_8011649C)($v0)
    /* 5DAE0 8006D2E0 1180023C */  lui        $v0, %hi(D_80113228)
    /* 5DAE4 8006D2E4 0580053C */  lui        $a1, %hi(D_800553D4)
    /* 5DAE8 8006D2E8 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* 5DAEC 8006D2EC D453A524 */  addiu      $a1, $a1, %lo(D_800553D4)
  .L8006D2F0:
    /* 5DAF0 8006D2F0 2F91030C */  jal        sprintf
    /* 5DAF4 8006D2F4 00000000 */   nop
    /* 5DAF8 8006D2F8 21100002 */  addu       $v0, $s0, $zero
    /* 5DAFC 8006D2FC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5DB00 8006D300 1000B08F */  lw         $s0, 0x10($sp)
    /* 5DB04 8006D304 0800E003 */  jr         $ra
    /* 5DB08 8006D308 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
