.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_AddCustomObject__FP9SceneElemi, 0x354

glabel Object_AddCustomObject__FP9SceneElemi
    /* 96204 800A5A04 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 96208 800A5A08 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 9620C 800A5A0C 21888000 */  addu       $s1, $a0, $zero
    /* 96210 800A5A10 2000B2AF */  sw         $s2, 0x20($sp)
    /* 96214 800A5A14 2400BFAF */  sw         $ra, 0x24($sp)
    /* 96218 800A5A18 1800B0AF */  sw         $s0, 0x18($sp)
    /* 9621C 800A5A1C 0000238E */  lw         $v1, 0x0($s1)
    /* 96220 800A5A20 01000224 */  addiu      $v0, $zero, 0x1
    /* 96224 800A5A24 96006210 */  beq        $v1, $v0, .L800A5C80
    /* 96228 800A5A28 2190A000 */   addu      $s2, $a1, $zero
    /* 9622C 800A5A2C 02006228 */  slti       $v0, $v1, 0x2
    /* 96230 800A5A30 05004010 */  beqz       $v0, .L800A5A48
    /* 96234 800A5A34 02000224 */   addiu     $v0, $zero, 0x2
    /* 96238 800A5A38 07006010 */  beqz       $v1, .L800A5A58
    /* 9623C 800A5A3C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 96240 800A5A40 50970208 */  j          .L800A5D40
    /* 96244 800A5A44 00000000 */   nop
  .L800A5A48:
    /* 96248 800A5A48 78006210 */  beq        $v1, $v0, .L800A5C2C
    /* 9624C 800A5A4C 00000000 */   nop
    /* 96250 800A5A50 50970208 */  j          .L800A5D40
    /* 96254 800A5A54 00000000 */   nop
  .L800A5A58:
    /* 96258 800A5A58 7C0D848F */  lw         $a0, %gp_rel(Object_customObjInst)($gp)
    /* 9625C 800A5A5C 00000000 */  nop
    /* 96260 800A5A60 0000838C */  lw         $v1, 0x0($a0)
    /* 96264 800A5A64 00000000 */  nop
    /* 96268 800A5A68 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 9626C 800A5A6C 06006210 */  beq        $v1, $v0, .L800A5A88
    /* 96270 800A5A70 04009024 */   addiu     $s0, $a0, 0x4
    /* 96274 800A5A74 04008284 */  lh         $v0, 0x4($a0)
    /* 96278 800A5A78 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L800A5A7C:
    /* 9627C 800A5A7C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 96280 800A5A80 FEFF6414 */  bne        $v1, $a0, .L800A5A7C
    /* 96284 800A5A84 21800202 */   addu      $s0, $s0, $v0
  .L800A5A88:
    /* 96288 800A5A88 24000224 */  addiu      $v0, $zero, 0x24
    /* 9628C 800A5A8C 000002A6 */  sh         $v0, 0x0($s0)
    /* 96290 800A5A90 4C00228E */  lw         $v0, 0x4C($s1)
    /* 96294 800A5A94 00000000 */  nop
    /* 96298 800A5A98 09004228 */  slti       $v0, $v0, 0x9
    /* 9629C 800A5A9C 02004014 */  bnez       $v0, .L800A5AA8
    /* 962A0 800A5AA0 05000224 */   addiu     $v0, $zero, 0x5
    /* 962A4 800A5AA4 02000224 */  addiu      $v0, $zero, 0x2
  .L800A5AA8:
    /* 962A8 800A5AA8 020002A2 */  sb         $v0, 0x2($s0)
    /* 962AC 800A5AAC 03000224 */  addiu      $v0, $zero, 0x3
    /* 962B0 800A5AB0 040002A2 */  sb         $v0, 0x4($s0)
    /* 962B4 800A5AB4 050000A2 */  sb         $zero, 0x5($s0)
    /* 962B8 800A5AB8 1000228E */  lw         $v0, 0x10($s1)
    /* 962BC 800A5ABC 00000000 */  nop
    /* 962C0 800A5AC0 080002AE */  sw         $v0, 0x8($s0)
    /* 962C4 800A5AC4 1400228E */  lw         $v0, 0x14($s1)
    /* 962C8 800A5AC8 00000000 */  nop
    /* 962CC 800A5ACC 0C0002AE */  sw         $v0, 0xC($s0)
    /* 962D0 800A5AD0 1800228E */  lw         $v0, 0x18($s1)
    /* 962D4 800A5AD4 030000A2 */  sb         $zero, 0x3($s0)
    /* 962D8 800A5AD8 1480033C */  lui        $v1, %hi(gPersistObjDef)
    /* 962DC 800A5ADC BCD4638C */  lw         $v1, %lo(gPersistObjDef)($v1)
    /* 962E0 800A5AE0 100002AE */  sw         $v0, 0x10($s0)
    /* 962E4 800A5AE4 48002296 */  lhu        $v0, 0x48($s1)
    /* 962E8 800A5AE8 00000000 */  nop
    /* 962EC 800A5AEC 060002A6 */  sh         $v0, 0x6($s0)
    /* 962F0 800A5AF0 00140200 */  sll        $v0, $v0, 16
    /* 962F4 800A5AF4 0000638C */  lw         $v1, 0x0($v1)
    /* 962F8 800A5AF8 03140200 */  sra        $v0, $v0, 16
    /* 962FC 800A5AFC 2A104300 */  slt        $v0, $v0, $v1
    /* 96300 800A5B00 02004014 */  bnez       $v0, .L800A5B0C
    /* 96304 800A5B04 00000000 */   nop
    /* 96308 800A5B08 060000A6 */  sh         $zero, 0x6($s0)
  .L800A5B0C:
    /* 9630C 800A5B0C 0800228E */  lw         $v0, 0x8($s1)
    /* 96310 800A5B10 00000000 */  nop
    /* 96314 800A5B14 20004010 */  beqz       $v0, .L800A5B98
    /* 96318 800A5B18 20002426 */   addiu     $a0, $s1, 0x20
    /* 9631C 800A5B1C 0C00228E */  lw         $v0, 0xC($s1)
    /* 96320 800A5B20 00000000 */  nop
    /* 96324 800A5B24 1C004010 */  beqz       $v0, .L800A5B98
    /* 96328 800A5B28 00000000 */   nop
    /* 9632C 800A5B2C 06000486 */  lh         $a0, 0x6($s0)
    /* 96330 800A5B30 5696020C */  jal        Object_GetObjDefID__Fi
    /* 96334 800A5B34 00000000 */   nop
    /* 96338 800A5B38 4C00248E */  lw         $a0, 0x4C($s1)
    /* 9633C 800A5B3C 00000000 */  nop
    /* 96340 800A5B40 14004410 */  beq        $v0, $a0, .L800A5B94
    /* 96344 800A5B44 00000000 */   nop
    /* 96348 800A5B48 6B96020C */  jal        Object_FindDefWithThisID__Fi
    /* 9634C 800A5B4C 00000000 */   nop
    /* 96350 800A5B50 4C00248E */  lw         $a0, 0x4C($s1)
    /* 96354 800A5B54 6B96020C */  jal        Object_FindDefWithThisID__Fi
    /* 96358 800A5B58 00000000 */   nop
    /* 9635C 800A5B5C 21184000 */  addu       $v1, $v0, $zero
    /* 96360 800A5B60 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 96364 800A5B64 07006210 */  beq        $v1, $v0, .L800A5B84
    /* 96368 800A5B68 00000000 */   nop
    /* 9636C 800A5B6C 060003A6 */  sh         $v1, 0x6($s0)
    /* 96370 800A5B70 4C00248E */  lw         $a0, 0x4C($s1)
    /* 96374 800A5B74 6B96020C */  jal        Object_FindDefWithThisID__Fi
    /* 96378 800A5B78 480023AE */   sw        $v1, 0x48($s1)
    /* 9637C 800A5B7C E6960208 */  j          .L800A5B98
    /* 96380 800A5B80 20002426 */   addiu     $a0, $s1, 0x20
  .L800A5B84:
    /* 96384 800A5B84 06000486 */  lh         $a0, 0x6($s0)
    /* 96388 800A5B88 5696020C */  jal        Object_GetObjDefID__Fi
    /* 9638C 800A5B8C 00000000 */   nop
    /* 96390 800A5B90 4C0022AE */  sw         $v0, 0x4C($s1)
  .L800A5B94:
    /* 96394 800A5B94 20002426 */  addiu      $a0, $s1, 0x20
  .L800A5B98:
    /* 96398 800A5B98 24B6020C */  jal        Quatern_MatToQuat__FP10matrixtdefP5tQuat
    /* 9639C 800A5B9C 1000A527 */   addiu     $a1, $sp, 0x10
    /* 963A0 800A5BA0 1600A297 */  lhu        $v0, 0x16($sp)
    /* 963A4 800A5BA4 00000000 */  nop
    /* 963A8 800A5BA8 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* 963AC 800A5BAC 1000A297 */  lhu        $v0, 0x10($sp)
    /* 963B0 800A5BB0 00000000 */  nop
    /* 963B4 800A5BB4 140002A6 */  sh         $v0, 0x14($s0)
    /* 963B8 800A5BB8 1200A297 */  lhu        $v0, 0x12($sp)
    /* 963BC 800A5BBC 00000000 */  nop
    /* 963C0 800A5BC0 160002A6 */  sh         $v0, 0x16($s0)
    /* 963C4 800A5BC4 1400A397 */  lhu        $v1, 0x14($sp)
    /* 963C8 800A5BC8 00010224 */  addiu      $v0, $zero, 0x100
    /* 963CC 800A5BCC 1C0002A6 */  sh         $v0, 0x1C($s0)
    /* 963D0 800A5BD0 1E0002A6 */  sh         $v0, 0x1E($s0)
    /* 963D4 800A5BD4 200002A6 */  sh         $v0, 0x20($s0)
    /* 963D8 800A5BD8 0B004012 */  beqz       $s2, .L800A5C08
    /* 963DC 800A5BDC 180003A6 */   sh        $v1, 0x18($s0)
    /* 963E0 800A5BE0 7C0D828F */  lw         $v0, %gp_rel(Object_customObjInst)($gp)
    /* 963E4 800A5BE4 00000000 */  nop
    /* 963E8 800A5BE8 0000458C */  lw         $a1, 0x0($v0)
    /* 963EC 800A5BEC 21202002 */  addu       $a0, $s1, $zero
    /* 963F0 800A5BF0 EC95020C */  jal        Object_AddCustomSimObject__FP9SceneElemii
    /* 963F4 800A5BF4 2130A000 */   addu      $a2, $a1, $zero
    /* 963F8 800A5BF8 220002A2 */  sb         $v0, 0x22($s0)
    /* 963FC 800A5BFC 4C002292 */  lbu        $v0, 0x4C($s1)
    /* 96400 800A5C00 04970208 */  j          .L800A5C10
    /* 96404 800A5C04 230002A2 */   sb        $v0, 0x23($s0)
  .L800A5C08:
    /* 96408 800A5C08 220000A2 */  sb         $zero, 0x22($s0)
    /* 9640C 800A5C0C 230000A2 */  sb         $zero, 0x23($s0)
  .L800A5C10:
    /* 96410 800A5C10 7C0D838F */  lw         $v1, %gp_rel(Object_customObjInst)($gp)
    /* 96414 800A5C14 00000000 */  nop
    /* 96418 800A5C18 0000628C */  lw         $v0, 0x0($v1)
    /* 9641C 800A5C1C 00000000 */  nop
    /* 96420 800A5C20 01004224 */  addiu      $v0, $v0, 0x1
    /* 96424 800A5C24 50970208 */  j          .L800A5D40
    /* 96428 800A5C28 000062AC */   sw        $v0, 0x0($v1)
  .L800A5C2C:
    /* 9642C 800A5C2C 840D858F */  lw         $a1, %gp_rel(Object_customSFXInst)($gp)
    /* 96430 800A5C30 1000248E */  lw         $a0, 0x10($s1)
    /* 96434 800A5C34 0000A38C */  lw         $v1, 0x0($a1)
    /* 96438 800A5C38 0400A224 */  addiu      $v0, $a1, 0x4
    /* 9643C 800A5C3C 00190300 */  sll        $v1, $v1, 4
    /* 96440 800A5C40 21104300 */  addu       $v0, $v0, $v1
    /* 96444 800A5C44 000044AC */  sw         $a0, 0x0($v0)
    /* 96448 800A5C48 1400238E */  lw         $v1, 0x14($s1)
    /* 9644C 800A5C4C 00000000 */  nop
    /* 96450 800A5C50 040043AC */  sw         $v1, 0x4($v0)
    /* 96454 800A5C54 1800238E */  lw         $v1, 0x18($s1)
    /* 96458 800A5C58 00000000 */  nop
    /* 9645C 800A5C5C 080043AC */  sw         $v1, 0x8($v0)
    /* 96460 800A5C60 44002396 */  lhu        $v1, 0x44($s1)
    /* 96464 800A5C64 0E0040A4 */  sh         $zero, 0xE($v0)
    /* 96468 800A5C68 0C0043A4 */  sh         $v1, 0xC($v0)
    /* 9646C 800A5C6C 0000A28C */  lw         $v0, 0x0($a1)
    /* 96470 800A5C70 00000000 */  nop
    /* 96474 800A5C74 01004224 */  addiu      $v0, $v0, 0x1
    /* 96478 800A5C78 50970208 */  j          .L800A5D40
    /* 9647C 800A5C7C 0000A2AC */   sw        $v0, 0x0($a1)
  .L800A5C80:
    /* 96480 800A5C80 21280000 */  addu       $a1, $zero, $zero
    /* 96484 800A5C84 4400228E */  lw         $v0, 0x44($s1)
    /* 96488 800A5C88 00000000 */  nop
    /* 9648C 800A5C8C 2C004014 */  bnez       $v0, .L800A5D40
    /* 96490 800A5C90 2120A000 */   addu      $a0, $a1, $zero
    /* 96494 800A5C94 1480033C */  lui        $v1, %hi(Cars_gNumTrafficCars)
    /* 96498 800A5C98 08C8638C */  lw         $v1, %lo(Cars_gNumTrafficCars)($v1)
    /* 9649C 800A5C9C 00000000 */  nop
    /* 964A0 800A5CA0 27006010 */  beqz       $v1, .L800A5D40
    /* 964A4 800A5CA4 2A108300 */   slt       $v0, $a0, $v1
    /* 964A8 800A5CA8 25004010 */  beqz       $v0, .L800A5D40
    /* 964AC 800A5CAC 1180023C */   lui       $v0, %hi(Cars_gTrafficCarList)
    /* 964B0 800A5CB0 21306000 */  addu       $a2, $v1, $zero
    /* 964B4 800A5CB4 90FA4424 */  addiu      $a0, $v0, %lo(Cars_gTrafficCarList)
  .L800A5CB8:
    /* 964B8 800A5CB8 0000838C */  lw         $v1, 0x0($a0)
    /* 964BC 800A5CBC 00000000 */  nop
    /* 964C0 800A5CC0 6002628C */  lw         $v0, 0x260($v1)
    /* 964C4 800A5CC4 00000000 */  nop
    /* 964C8 800A5CC8 00044230 */  andi       $v0, $v0, 0x400
    /* 964CC 800A5CCC 06004014 */  bnez       $v0, .L800A5CE8
    /* 964D0 800A5CD0 00000000 */   nop
    /* 964D4 800A5CD4 BC086384 */  lh         $v1, 0x8BC($v1)
    /* 964D8 800A5CD8 5400228E */  lw         $v0, 0x54($s1)
    /* 964DC 800A5CDC 00000000 */  nop
    /* 964E0 800A5CE0 05006210 */  beq        $v1, $v0, .L800A5CF8
    /* 964E4 800A5CE4 00000000 */   nop
  .L800A5CE8:
    /* 964E8 800A5CE8 0100A524 */  addiu      $a1, $a1, 0x1
    /* 964EC 800A5CEC 2A10A600 */  slt        $v0, $a1, $a2
    /* 964F0 800A5CF0 F1FF4014 */  bnez       $v0, .L800A5CB8
    /* 964F4 800A5CF4 04008424 */   addiu     $a0, $a0, 0x4
  .L800A5CF8:
    /* 964F8 800A5CF8 1480023C */  lui        $v0, %hi(Cars_gNumTrafficCars)
    /* 964FC 800A5CFC 08C8428C */  lw         $v0, %lo(Cars_gNumTrafficCars)($v0)
    /* 96500 800A5D00 00000000 */  nop
    /* 96504 800A5D04 2A10A200 */  slt        $v0, $a1, $v0
    /* 96508 800A5D08 0D004010 */  beqz       $v0, .L800A5D40
    /* 9650C 800A5D0C 1180033C */   lui       $v1, %hi(Cars_gTrafficCarList)
    /* 96510 800A5D10 90FA6324 */  addiu      $v1, $v1, %lo(Cars_gTrafficCarList)
    /* 96514 800A5D14 80100500 */  sll        $v0, $a1, 2
    /* 96518 800A5D18 21104300 */  addu       $v0, $v0, $v1
    /* 9651C 800A5D1C 0000448C */  lw         $a0, 0x0($v0)
    /* 96520 800A5D20 1180033C */  lui        $v1, %hi(highLevelAIObjs)
    /* 96524 800A5D24 5402828C */  lw         $v0, 0x254($a0)
    /* 96528 800A5D28 38CD6324 */  addiu      $v1, $v1, %lo(highLevelAIObjs)
    /* 9652C 800A5D2C 80100200 */  sll        $v0, $v0, 2
    /* 96530 800A5D30 21104300 */  addu       $v0, $v0, $v1
    /* 96534 800A5D34 0000428C */  lw         $v0, 0x0($v0)
    /* 96538 800A5D38 00000000 */  nop
    /* 9653C 800A5D3C 200051AC */  sw         $s1, 0x20($v0)
  .L800A5D40:
    /* 96540 800A5D40 2400BF8F */  lw         $ra, 0x24($sp)
    /* 96544 800A5D44 2000B28F */  lw         $s2, 0x20($sp)
    /* 96548 800A5D48 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 9654C 800A5D4C 1800B08F */  lw         $s0, 0x18($sp)
    /* 96550 800A5D50 0800E003 */  jr         $ra
    /* 96554 800A5D54 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Object_AddCustomObject__FP9SceneElemi
