.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoTitleScreen__Fv, 0x100

glabel DoTitleScreen__Fv
    /* 3E334 8004DB34 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 3E338 8004DB38 6000BFAF */  sw         $ra, 0x60($sp)
    /* 3E33C 8004DB3C 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 3E340 8004DB40 8CA0030C */  jal        elapsedticks
    /* 3E344 8004DB44 5800B0AF */   sw        $s0, 0x58($sp)
    /* 3E348 8004DB48 0580113C */  lui        $s1, %hi(creditShapeFile)
    /* 3E34C 8004DB4C 582A228E */  lw         $v0, %lo(creditShapeFile)($s1)
    /* 3E350 8004DB50 00000000 */  nop
    /* 3E354 8004DB54 16004014 */  bnez       $v0, .L8004DBB0
    /* 3E358 8004DB58 4000B027 */   addiu     $s0, $sp, 0x40
    /* 3E35C 8004DB5C 21200002 */  addu       $a0, $s0, $zero
    /* 3E360 8004DB60 0180053C */  lui        $a1, %hi(D_80012808)
    /* 3E364 8004DB64 2F91030C */  jal        sprintf
    /* 3E368 8004DB68 0828A524 */   addiu     $a1, $a1, %lo(D_80012808)
    /* 3E36C 8004DB6C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3E370 8004DB70 0580023C */  lui        $v0, %hi(D_80052A54)
    /* 3E374 8004DB74 542A458C */  lw         $a1, %lo(D_80052A54)($v0)
    /* 3E378 8004DB78 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 3E37C 8004DB7C E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 3E380 8004DB80 2F91030C */  jal        sprintf
    /* 3E384 8004DB84 21380002 */   addu      $a3, $s0, $zero
    /* 3E388 8004DB88 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3E38C 8004DB8C 0FC7030C */  jal        loadshapeadr
    /* 3E390 8004DB90 21280000 */   addu      $a1, $zero, $zero
    /* 3E394 8004DB94 21200000 */  addu       $a0, $zero, $zero
    /* 3E398 8004DB98 019B030C */  jal        systemtask
    /* 3E39C 8004DB9C 582A22AE */   sw        $v0, %lo(creditShapeFile)($s1)
    /* 3E3A0 8004DBA0 582A228E */  lw         $v0, %lo(creditShapeFile)($s1)
    /* 3E3A4 8004DBA4 00000000 */  nop
    /* 3E3A8 8004DBA8 1D004010 */  beqz       $v0, .L8004DC20
    /* 3E3AC 8004DBAC 00000000 */   nop
  .L8004DBB0:
    /* 3E3B0 8004DBB0 0180053C */  lui        $a1, %hi(D_80012814)
    /* 3E3B4 8004DBB4 582A248E */  lw         $a0, %lo(creditShapeFile)($s1)
    /* 3E3B8 8004DBB8 5CAC030C */  jal        locateshapez
    /* 3E3BC 8004DBBC 1428A524 */   addiu     $a1, $a1, %lo(D_80012814)
    /* 3E3C0 8004DBC0 01000424 */  addiu      $a0, $zero, 0x1
    /* 3E3C4 8004DBC4 21280000 */  addu       $a1, $zero, $zero
    /* 3E3C8 8004DBC8 21308000 */  addu       $a2, $a0, $zero
    /* 3E3CC 8004DBCC DE35010C */  jal        Quick_DD__Fiii
    /* 3E3D0 8004DBD0 21804000 */   addu      $s0, $v0, $zero
    /* 3E3D4 8004DBD4 C3C1030C */  jal        settrans
    /* 3E3D8 8004DBD8 21200000 */   addu      $a0, $zero, $zero
    /* 3E3DC 8004DBDC 21200002 */  addu       $a0, $s0, $zero
    /* 3E3E0 8004DBE0 21280000 */  addu       $a1, $zero, $zero
    /* 3E3E4 8004DBE4 CEC1030C */  jal        movfxya
    /* 3E3E8 8004DBE8 2130A000 */   addu      $a2, $a1, $zero
    /* 3E3EC 8004DBEC C3C1030C */  jal        settrans
    /* 3E3F0 8004DBF0 01000424 */   addiu     $a0, $zero, 0x1
    /* 3E3F4 8004DBF4 21200000 */  addu       $a0, $zero, $zero
    /* 3E3F8 8004DBF8 01000524 */  addiu      $a1, $zero, 0x1
    /* 3E3FC 8004DBFC DE35010C */  jal        Quick_DD__Fiii
    /* 3E400 8004DC00 21308000 */   addu      $a2, $a0, $zero
    /* 3E404 8004DC04 582A248E */  lw         $a0, %lo(creditShapeFile)($s1)
    /* 3E408 8004DC08 5095030C */  jal        purgememadr
    /* 3E40C 8004DC0C 00000000 */   nop
    /* 3E410 8004DC10 0580033C */  lui        $v1, %hi(titleScreenDisplayed)
    /* 3E414 8004DC14 01000224 */  addiu      $v0, $zero, 0x1
    /* 3E418 8004DC18 582A20AE */  sw         $zero, %lo(creditShapeFile)($s1)
    /* 3E41C 8004DC1C 702A62A0 */  sb         $v0, %lo(titleScreenDisplayed)($v1)
  .L8004DC20:
    /* 3E420 8004DC20 6000BF8F */  lw         $ra, 0x60($sp)
    /* 3E424 8004DC24 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 3E428 8004DC28 5800B08F */  lw         $s0, 0x58($sp)
    /* 3E42C 8004DC2C 0800E003 */  jr         $ra
    /* 3E430 8004DC30 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel DoTitleScreen__Fv
