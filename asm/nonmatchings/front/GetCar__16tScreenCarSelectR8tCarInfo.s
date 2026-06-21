.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__16tScreenCarSelectR8tCarInfo, 0x280

glabel GetCar__16tScreenCarSelectR8tCarInfo
    /* 2CA24 8003C224 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2CA28 8003C228 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2CA2C 8003C22C 21808000 */  addu       $s0, $a0, $zero
    /* 2CA30 8003C230 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 2CA34 8003C234 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2CA38 8003C238 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2CA3C 8003C23C 1C010386 */  lh         $v1, 0x11C($s0)
    /* 2CA40 8003C240 00000000 */  nop
    /* 2CA44 8003C244 0800622C */  sltiu      $v0, $v1, 0x8
    /* 2CA48 8003C248 5B004010 */  beqz       $v0, .L8003C3B8
    /* 2CA4C 8003C24C 2190A000 */   addu      $s2, $a1, $zero
    /* 2CA50 8003C250 0180023C */  lui        $v0, %hi(jtbl_80011AF8)
    /* 2CA54 8003C254 F81A4224 */  addiu      $v0, $v0, %lo(jtbl_80011AF8)
    /* 2CA58 8003C258 80180300 */  sll        $v1, $v1, 2
    /* 2CA5C 8003C25C 21186200 */  addu       $v1, $v1, $v0
    /* 2CA60 8003C260 0000628C */  lw         $v0, 0x0($v1)
    /* 2CA64 8003C264 00000000 */  nop
    /* 2CA68 8003C268 08004000 */  jr         $v0
    /* 2CA6C 8003C26C 00000000 */   nop
  jlabel .L8003C270
    /* 2CA70 8003C270 1180103C */  lui        $s0, %hi(carManager)
    /* 2CA74 8003C274 74420426 */  addiu      $a0, $s0, %lo(carManager)
    /* 2CA78 8003C278 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2CA7C 8003C27C 00465124 */  addiu      $s1, $v0, %lo(frontEnd)
    /* 2CA80 8003C280 5C002592 */  lbu        $a1, 0x5C($s1)
    /* 2CA84 8003C284 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2CA88 8003C288 21304002 */   addu      $a2, $s2, $zero
    /* 2CA8C 8003C28C 5C002292 */  lbu        $v0, 0x5C($s1)
    /* 2CA90 8003C290 7442038E */  lw         $v1, %lo(carManager)($s0)
    /* 2CA94 8003C294 00000000 */  nop
    /* 2CA98 8003C298 2A104300 */  slt        $v0, $v0, $v1
    /* 2CA9C 8003C29C 07004010 */  beqz       $v0, .L8003C2BC
    /* 2CAA0 8003C2A0 00000000 */   nop
    /* 2CAA4 8003C2A4 00004282 */  lb         $v0, 0x0($s2)
    /* 2CAA8 8003C2A8 00000000 */  nop
    /* 2CAAC 8003C2AC 21105100 */  addu       $v0, $v0, $s1
    /* 2CAB0 8003C2B0 60004290 */  lbu        $v0, 0x60($v0)
    /* 2CAB4 8003C2B4 00000000 */  nop
    /* 2CAB8 8003C2B8 C50042A2 */  sb         $v0, 0xC5($s2)
  .L8003C2BC:
    /* 2CABC 8003C2BC 00004282 */  lb         $v0, 0x0($s2)
    /* 2CAC0 8003C2C0 00000000 */  nop
    /* 2CAC4 8003C2C4 21105100 */  addu       $v0, $v0, $s1
    /* 2CAC8 8003C2C8 C0004290 */  lbu        $v0, 0xC0($v0)
    /* 2CACC 8003C2CC 1DF10008 */  j          .L8003C474
    /* 2CAD0 8003C2D0 C70042A2 */   sb        $v0, 0xC7($s2)
  jlabel .L8003C2D4
    /* 2CAD4 8003C2D4 1180043C */  lui        $a0, %hi(carManager)
    /* 2CAD8 8003C2D8 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2CADC 8003C2DC 1180103C */  lui        $s0, %hi(frontEnd)
    /* 2CAE0 8003C2E0 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 2CAE4 8003C2E4 28010592 */  lbu        $a1, 0x128($s0)
    /* 2CAE8 8003C2E8 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2CAEC 8003C2EC 21304002 */   addu      $a2, $s2, $zero
    /* 2CAF0 8003C2F0 00004282 */  lb         $v0, 0x0($s2)
    /* 2CAF4 8003C2F4 00000000 */  nop
    /* 2CAF8 8003C2F8 21105000 */  addu       $v0, $v0, $s0
    /* 2CAFC 8003C2FC 60004390 */  lbu        $v1, 0x60($v0)
    /* 2CB00 8003C300 01000224 */  addiu      $v0, $zero, 0x1
    /* 2CB04 8003C304 070042A2 */  sb         $v0, 0x7($s2)
    /* 2CB08 8003C308 1DF10008 */  j          .L8003C474
    /* 2CB0C 8003C30C C50043A2 */   sb        $v1, 0xC5($s2)
  jlabel .L8003C310
    /* 2CB10 8003C310 1180023C */  lui        $v0, %hi(D_8011472A)
    /* 2CB14 8003C314 2A474390 */  lbu        $v1, %lo(D_8011472A)($v0)
    /* 2CB18 8003C318 01000224 */  addiu      $v0, $zero, 0x1
    /* 2CB1C 8003C31C 08006214 */  bne        $v1, $v0, .L8003C340
    /* 2CB20 8003C320 1180023C */   lui       $v0, %hi(carManager)
    /* 2CB24 8003C324 1180043C */  lui        $a0, %hi(carManager)
    /* 2CB28 8003C328 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2CB2C 8003C32C CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 2CB30 8003C330 21280000 */   addu      $a1, $zero, $zero
    /* 2CB34 8003C334 00140200 */  sll        $v0, $v0, 16
    /* 2CB38 8003C338 2A004018 */  blez       $v0, .L8003C3E4
    /* 2CB3C 8003C33C 1180023C */   lui       $v0, %hi(carManager)
  .L8003C340:
    /* 2CB40 8003C340 1180033C */  lui        $v1, %hi(frontEnd)
    /* 2CB44 8003C344 00466524 */  addiu      $a1, $v1, %lo(frontEnd)
    /* 2CB48 8003C348 2A01A390 */  lbu        $v1, 0x12A($a1)
    /* 2CB4C 8003C34C 00000000 */  nop
    /* 2CB50 8003C350 04006014 */  bnez       $v1, .L8003C364
    /* 2CB54 8003C354 74424424 */   addiu     $a0, $v0, %lo(carManager)
    /* 2CB58 8003C358 5C00A590 */  lbu        $a1, 0x5C($a1)
    /* 2CB5C 8003C35C DAF00008 */  j          .L8003C368
    /* 2CB60 8003C360 00000000 */   nop
  .L8003C364:
    /* 2CB64 8003C364 2301A590 */  lbu        $a1, 0x123($a1)
  .L8003C368:
    /* 2CB68 8003C368 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2CB6C 8003C36C 21304002 */   addu      $a2, $s2, $zero
    /* 2CB70 8003C370 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2CB74 8003C374 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 2CB78 8003C378 2A016290 */  lbu        $v0, 0x12A($v1)
    /* 2CB7C 8003C37C 00000000 */  nop
    /* 2CB80 8003C380 07004014 */  bnez       $v0, .L8003C3A0
    /* 2CB84 8003C384 00000000 */   nop
    /* 2CB88 8003C388 00004282 */  lb         $v0, 0x0($s2)
    /* 2CB8C 8003C38C 00000000 */  nop
    /* 2CB90 8003C390 21104300 */  addu       $v0, $v0, $v1
    /* 2CB94 8003C394 60004290 */  lbu        $v0, 0x60($v0)
    /* 2CB98 8003C398 00000000 */  nop
    /* 2CB9C 8003C39C C50042A2 */  sb         $v0, 0xC5($s2)
  .L8003C3A0:
    /* 2CBA0 8003C3A0 00004282 */  lb         $v0, 0x0($s2)
    /* 2CBA4 8003C3A4 00000000 */  nop
    /* 2CBA8 8003C3A8 21104300 */  addu       $v0, $v0, $v1
    /* 2CBAC 8003C3AC C0004290 */  lbu        $v0, 0xC0($v0)
    /* 2CBB0 8003C3B0 1DF10008 */  j          .L8003C474
    /* 2CBB4 8003C3B4 C70042A2 */   sb        $v0, 0xC7($s2)
  jlabel .L8003C3B8
    /* 2CBB8 8003C3B8 1180043C */  lui        $a0, %hi(carManager)
    /* 2CBBC 8003C3BC 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2CBC0 8003C3C0 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 2CBC4 8003C3C4 21280000 */   addu      $a1, $zero, $zero
    /* 2CBC8 8003C3C8 00140200 */  sll        $v0, $v0, 16
    /* 2CBCC 8003C3CC 0700401C */  bgtz       $v0, .L8003C3EC
    /* 2CBD0 8003C3D0 1180023C */   lui       $v0, %hi(D_80114604)
    /* 2CBD4 8003C3D4 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 2CBD8 8003C3D8 01000224 */  addiu      $v0, $zero, 0x1
    /* 2CBDC 8003C3DC 03006210 */  beq        $v1, $v0, .L8003C3EC
    /* 2CBE0 8003C3E0 1180023C */   lui       $v0, %hi(D_80114604)
  .L8003C3E4:
    /* 2CBE4 8003C3E4 23F10008 */  j          .L8003C48C
    /* 2CBE8 8003C3E8 21100000 */   addu      $v0, $zero, $zero
  .L8003C3EC:
    /* 2CBEC 8003C3EC 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 2CBF0 8003C3F0 02000224 */  addiu      $v0, $zero, 0x2
    /* 2CBF4 8003C3F4 0C006214 */  bne        $v1, $v0, .L8003C428
    /* 2CBF8 8003C3F8 1180023C */   lui       $v0, %hi(carManager)
    /* 2CBFC 8003C3FC 1C010386 */  lh         $v1, 0x11C($s0)
    /* 2CC00 8003C400 03000224 */  addiu      $v0, $zero, 0x3
    /* 2CC04 8003C404 07006210 */  beq        $v1, $v0, .L8003C424
    /* 2CC08 8003C408 1180043C */   lui       $a0, %hi(carManager)
    /* 2CC0C 8003C40C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2CC10 8003C410 DE5C000C */  jal        GetNumTourneyCars__11tCarManagers
    /* 2CC14 8003C414 21280000 */   addu      $a1, $zero, $zero
    /* 2CC18 8003C418 00140200 */  sll        $v0, $v0, 16
    /* 2CC1C 8003C41C 1B004018 */  blez       $v0, .L8003C48C
    /* 2CC20 8003C420 21100000 */   addu      $v0, $zero, $zero
  .L8003C424:
    /* 2CC24 8003C424 1180023C */  lui        $v0, %hi(carManager)
  .L8003C428:
    /* 2CC28 8003C428 74424424 */  addiu      $a0, $v0, %lo(carManager)
    /* 2CC2C 8003C42C 1C010386 */  lh         $v1, 0x11C($s0)
    /* 2CC30 8003C430 03000224 */  addiu      $v0, $zero, 0x3
    /* 2CC34 8003C434 05006214 */  bne        $v1, $v0, .L8003C44C
    /* 2CC38 8003C438 1180023C */   lui       $v0, %hi(D_80114723)
    /* 2CC3C 8003C43C 1180023C */  lui        $v0, %hi(D_80114729)
    /* 2CC40 8003C440 29474590 */  lbu        $a1, %lo(D_80114729)($v0)
    /* 2CC44 8003C444 14F10008 */  j          .L8003C450
    /* 2CC48 8003C448 00000000 */   nop
  .L8003C44C:
    /* 2CC4C 8003C44C 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
  .L8003C450:
    /* 2CC50 8003C450 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2CC54 8003C454 21304002 */   addu      $a2, $s2, $zero
    /* 2CC58 8003C458 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2CC5C 8003C45C 00004382 */  lb         $v1, 0x0($s2)
    /* 2CC60 8003C460 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 2CC64 8003C464 21186200 */  addu       $v1, $v1, $v0
    /* 2CC68 8003C468 C0006290 */  lbu        $v0, 0xC0($v1)
    /* 2CC6C 8003C46C 00000000 */  nop
    /* 2CC70 8003C470 C70042A2 */  sb         $v0, 0xC7($s2)
  .L8003C474:
    /* 2CC74 8003C474 C5004292 */  lbu        $v0, 0xC5($s2)
    /* 2CC78 8003C478 00000000 */  nop
    /* 2CC7C 8003C47C 21104202 */  addu       $v0, $s2, $v0
    /* 2CC80 8003C480 AF004390 */  lbu        $v1, 0xAF($v0)
    /* 2CC84 8003C484 01000224 */  addiu      $v0, $zero, 0x1
    /* 2CC88 8003C488 C50043A2 */  sb         $v1, 0xC5($s2)
  .L8003C48C:
    /* 2CC8C 8003C48C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 2CC90 8003C490 1800B28F */  lw         $s2, 0x18($sp)
    /* 2CC94 8003C494 1400B18F */  lw         $s1, 0x14($sp)
    /* 2CC98 8003C498 1000B08F */  lw         $s0, 0x10($sp)
    /* 2CC9C 8003C49C 0800E003 */  jr         $ra
    /* 2CCA0 8003C4A0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetCar__16tScreenCarSelectR8tCarInfo
