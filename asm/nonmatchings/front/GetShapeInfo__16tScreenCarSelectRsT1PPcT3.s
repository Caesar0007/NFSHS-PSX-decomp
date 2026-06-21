.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__16tScreenCarSelectRsT1PPcT3, 0xC4

glabel GetShapeInfo__16tScreenCarSelectRsT1PPcT3
    /* 2C2E0 8003BAE0 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 2C2E4 8003BAE4 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 2C2E8 8003BAE8 21888000 */  addu       $s1, $a0, $zero
    /* 2C2EC 8003BAEC 8E000224 */  addiu      $v0, $zero, 0x8E
    /* 2C2F0 8003BAF0 E800BFAF */  sw         $ra, 0xE8($sp)
    /* 2C2F4 8003BAF4 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2C2F8 8003BAF8 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2C2FC 8003BAFC 0B000224 */  addiu      $v0, $zero, 0xB
    /* 2C300 8003BB00 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 2C304 8003BB04 0180023C */  lui        $v0, %hi(D_80011AD4)
    /* 2C308 8003BB08 D41A4224 */  addiu      $v0, $v0, %lo(D_80011AD4)
    /* 2C30C 8003BB0C 0000E2AC */  sw         $v0, 0x0($a3)
    /* 2C310 8003BB10 6000228E */  lw         $v0, 0x60($s1)
    /* 2C314 8003BB14 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2C318 8003BB18 68004484 */  lh         $a0, 0x68($v0)
    /* 2C31C 8003BB1C 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2C320 8003BB20 00000000 */  nop
    /* 2C324 8003BB24 09F84000 */  jalr       $v0
    /* 2C328 8003BB28 21202402 */   addu      $a0, $s1, $a0
    /* 2C32C 8003BB2C 01004238 */  xori       $v0, $v0, 0x1
    /* 2C330 8003BB30 05004010 */  beqz       $v0, .L8003BB48
    /* 2C334 8003BB34 1180043C */   lui       $a0, %hi(carManager)
    /* 2C338 8003BB38 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2C33C 8003BB3C 21280000 */  addu       $a1, $zero, $zero
    /* 2C340 8003BB40 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2C344 8003BB44 1000A627 */   addiu     $a2, $sp, 0x10
  .L8003BB48:
    /* 2C348 8003BB48 0580103C */  lui        $s0, %hi(D_80052C28)
    /* 2C34C 8003BB4C 282C1026 */  addiu      $s0, $s0, %lo(D_80052C28)
    /* 2C350 8003BB50 21200002 */  addu       $a0, $s0, $zero
    /* 2C354 8003BB54 D800A293 */  lbu        $v0, 0xD8($sp)
    /* 2C358 8003BB58 0180053C */  lui        $a1, %hi(D_80011ADC)
    /* 2C35C 8003BB5C 1E0122A6 */  sh         $v0, 0x11E($s1)
    /* 2C360 8003BB60 1000A293 */  lbu        $v0, 0x10($sp)
    /* 2C364 8003BB64 DC1AA524 */  addiu      $a1, $a1, %lo(D_80011ADC)
    /* 2C368 8003BB68 00160200 */  sll        $v0, $v0, 24
    /* 2C36C 8003BB6C 03160200 */  sra        $v0, $v0, 24
    /* 2C370 8003BB70 200122A6 */  sh         $v0, 0x120($s1)
    /* 2C374 8003BB74 D700A293 */  lbu        $v0, 0xD7($sp)
    /* 2C378 8003BB78 1800A627 */  addiu      $a2, $sp, 0x18
    /* 2C37C 8003BB7C 2F91030C */  jal        sprintf
    /* 2C380 8003BB80 220122A6 */   sh        $v0, 0x122($s1)
    /* 2C384 8003BB84 0001A28F */  lw         $v0, 0x100($sp)
    /* 2C388 8003BB88 00000000 */  nop
    /* 2C38C 8003BB8C 000050AC */  sw         $s0, 0x0($v0)
    /* 2C390 8003BB90 E800BF8F */  lw         $ra, 0xE8($sp)
    /* 2C394 8003BB94 E400B18F */  lw         $s1, 0xE4($sp)
    /* 2C398 8003BB98 E000B08F */  lw         $s0, 0xE0($sp)
    /* 2C39C 8003BB9C 0800E003 */  jr         $ra
    /* 2C3A0 8003BBA0 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel GetShapeInfo__16tScreenCarSelectRsT1PPcT3
