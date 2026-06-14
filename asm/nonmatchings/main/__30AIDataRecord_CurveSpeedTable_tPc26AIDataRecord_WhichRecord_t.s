.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t, 0x90

glabel __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
    /* 5DBBC 8006D3BC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5DBC0 8006D3C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5DBC4 8006D3C4 21808000 */  addu       $s0, $a0, $zero
    /* 5DBC8 8006D3C8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5DBCC 8006D3CC 2188A000 */  addu       $s1, $a1, $zero
    /* 5DBD0 8006D3D0 2128C000 */  addu       $a1, $a2, $zero
    /* 5DBD4 8006D3D4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5DBD8 8006D3D8 89B3010C */  jal        __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
    /* 5DBDC 8006D3DC 21300000 */   addu      $a2, $zero, $zero
    /* 5DBE0 8006D3E0 0580023C */  lui        $v0, %hi(D_8005544C)
    /* 5DBE4 8006D3E4 5000038E */  lw         $v1, 0x50($s0)
    /* 5DBE8 8006D3E8 4C544224 */  addiu      $v0, $v0, %lo(D_8005544C)
    /* 5DBEC 8006D3EC 540002AE */  sw         $v0, 0x54($s0)
    /* 5DBF0 8006D3F0 00010224 */  addiu      $v0, $zero, 0x100
    /* 5DBF4 8006D3F4 000002AE */  sw         $v0, 0x0($s0)
    /* 5DBF8 8006D3F8 07006014 */  bnez       $v1, .L8006D418
    /* 5DBFC 8006D3FC 040002AE */   sw        $v0, 0x4($s0)
    /* 5DC00 8006D400 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DC04 8006D404 0580053C */  lui        $a1, %hi(D_80055404)
    /* 5DC08 8006D408 1180023C */  lui        $v0, %hi(D_80116478)
    /* 5DC0C 8006D40C 7864468C */  lw         $a2, %lo(D_80116478)($v0)
    /* 5DC10 8006D410 0BB50108 */  j          .L8006D42C
    /* 5DC14 8006D414 0454A524 */   addiu     $a1, $a1, %lo(D_80055404)
  .L8006D418:
    /* 5DC18 8006D418 08000426 */  addiu      $a0, $s0, 0x8
    /* 5DC1C 8006D41C 0580053C */  lui        $a1, %hi(D_80055410)
    /* 5DC20 8006D420 1054A524 */  addiu      $a1, $a1, %lo(D_80055410)
    /* 5DC24 8006D424 1180023C */  lui        $v0, %hi(D_8011647C)
    /* 5DC28 8006D428 7C64468C */  lw         $a2, %lo(D_8011647C)($v0)
  .L8006D42C:
    /* 5DC2C 8006D42C 2F91030C */  jal        sprintf
    /* 5DC30 8006D430 21382002 */   addu      $a3, $s1, $zero
    /* 5DC34 8006D434 21100002 */  addu       $v0, $s0, $zero
    /* 5DC38 8006D438 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5DC3C 8006D43C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5DC40 8006D440 1000B08F */  lw         $s0, 0x10($sp)
    /* 5DC44 8006D444 0800E003 */  jr         $ra
    /* 5DC48 8006D448 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
