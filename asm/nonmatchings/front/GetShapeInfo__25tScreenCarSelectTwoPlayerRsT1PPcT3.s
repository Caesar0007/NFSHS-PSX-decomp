.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3, 0x98

glabel GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3
    /* 2EB30 8003E330 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 2EB34 8003E334 21188000 */  addu       $v1, $a0, $zero
    /* 2EB38 8003E338 1180043C */  lui        $a0, %hi(carManager)
    /* 2EB3C 8003E33C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2EB40 8003E340 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 2EB44 8003E344 0001B28F */  lw         $s2, 0x100($sp)
    /* 2EB48 8003E348 34000224 */  addiu      $v0, $zero, 0x34
    /* 2EB4C 8003E34C EC00BFAF */  sw         $ra, 0xEC($sp)
    /* 2EB50 8003E350 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 2EB54 8003E354 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2EB58 8003E358 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2EB5C 8003E35C 21280000 */  addu       $a1, $zero, $zero
    /* 2EB60 8003E360 05000224 */  addiu      $v0, $zero, 0x5
    /* 2EB64 8003E364 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 2EB68 8003E368 1000A627 */  addiu      $a2, $sp, 0x10
    /* 2EB6C 8003E36C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2EB70 8003E370 2188E000 */  addu       $s1, $a3, $zero
    /* 2EB74 8003E374 1E0162A4 */  sh         $v0, 0x11E($v1)
    /* 2EB78 8003E378 200162A4 */  sh         $v0, 0x120($v1)
    /* 2EB7C 8003E37C A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2EB80 8003E380 220162A4 */   sh        $v0, 0x122($v1)
    /* 2EB84 8003E384 0580103C */  lui        $s0, %hi(D_80052C28)
    /* 2EB88 8003E388 282C1026 */  addiu      $s0, $s0, %lo(D_80052C28)
    /* 2EB8C 8003E38C 21200002 */  addu       $a0, $s0, $zero
    /* 2EB90 8003E390 0180053C */  lui        $a1, %hi(D_80011ADC)
    /* 2EB94 8003E394 DC1AA524 */  addiu      $a1, $a1, %lo(D_80011ADC)
    /* 2EB98 8003E398 2000A627 */  addiu      $a2, $sp, 0x20
    /* 2EB9C 8003E39C 0180023C */  lui        $v0, %hi(D_80011B30)
    /* 2EBA0 8003E3A0 301B4224 */  addiu      $v0, $v0, %lo(D_80011B30)
    /* 2EBA4 8003E3A4 2F91030C */  jal        sprintf
    /* 2EBA8 8003E3A8 000022AE */   sw        $v0, 0x0($s1)
    /* 2EBAC 8003E3AC 000050AE */  sw         $s0, 0x0($s2)
    /* 2EBB0 8003E3B0 EC00BF8F */  lw         $ra, 0xEC($sp)
    /* 2EBB4 8003E3B4 E800B28F */  lw         $s2, 0xE8($sp)
    /* 2EBB8 8003E3B8 E400B18F */  lw         $s1, 0xE4($sp)
    /* 2EBBC 8003E3BC E000B08F */  lw         $s0, 0xE0($sp)
    /* 2EBC0 8003E3C0 0800E003 */  jr         $ra
    /* 2EBC4 8003E3C4 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3
