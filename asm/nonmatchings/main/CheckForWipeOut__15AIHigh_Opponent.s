.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForWipeOut__15AIHigh_Opponent, 0x1E0

glabel CheckForWipeOut__15AIHigh_Opponent
    /* 53B08 80063308 21408000 */  addu       $t0, $a0, $zero
    /* 53B0C 8006330C 94000F8D */  lw         $t7, 0x94($t0)
    /* 53B10 80063310 0000038D */  lw         $v1, 0x0($t0)
    /* 53B14 80063314 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 53B18 80063318 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 53B1C 8006331C A4036E8C */  lw         $t6, 0x3A4($v1)
    /* 53B20 80063320 6F004010 */  beqz       $v0, .L800634E0
    /* 53B24 80063324 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 53B28 80063328 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 53B2C 8006332C 4807638C */  lw         $v1, 0x748($v1)
    /* 53B30 80063330 00000000 */  nop
    /* 53B34 80063334 2A104300 */  slt        $v0, $v0, $v1
    /* 53B38 80063338 69004014 */  bnez       $v0, .L800634E0
    /* 53B3C 8006333C 00000000 */   nop
    /* 53B40 80063340 7800028D */  lw         $v0, 0x78($t0)
    /* 53B44 80063344 00000000 */  nop
    /* 53B48 80063348 07004010 */  beqz       $v0, .L80063368
    /* 53B4C 8006334C 21200000 */   addu      $a0, $zero, $zero
    /* 53B50 80063350 7000028D */  lw         $v0, 0x70($t0)
    /* 53B54 80063354 7400038D */  lw         $v1, 0x74($t0)
    /* 53B58 80063358 00000000 */  nop
    /* 53B5C 8006335C 21104300 */  addu       $v0, $v0, $v1
    /* 53B60 80063360 02004014 */  bnez       $v0, .L8006336C
    /* 53B64 80063364 00000000 */   nop
  .L80063368:
    /* 53B68 80063368 01000424 */  addiu      $a0, $zero, 0x1
  .L8006336C:
    /* 53B6C 8006336C 5C008014 */  bnez       $a0, .L800634E0
    /* 53B70 80063370 1280023C */   lui       $v0, %hi(simGlobal)
    /* 53B74 80063374 ACE04624 */  addiu      $a2, $v0, %lo(simGlobal)
    /* 53B78 80063378 0000028D */  lw         $v0, 0x0($t0)
    /* 53B7C 8006337C 0400C58C */  lw         $a1, 0x4($a2)
    /* 53B80 80063380 4807428C */  lw         $v0, 0x748($v0)
    /* 53B84 80063384 00000000 */  nop
    /* 53B88 80063388 2310A200 */  subu       $v0, $a1, $v0
    /* 53B8C 8006338C 80024228 */  slti       $v0, $v0, 0x280
    /* 53B90 80063390 53004014 */  bnez       $v0, .L800634E0
    /* 53B94 80063394 00000000 */   nop
    /* 53B98 80063398 1480023C */  lui        $v0, %hi(fastRandom)
    /* 53B9C 8006339C FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 53BA0 800633A0 1480033C */  lui        $v1, %hi(randSeed)
    /* 53BA4 800633A4 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 53BA8 800633A8 00000000 */  nop
    /* 53BAC 800633AC 18004300 */  mult       $v0, $v1
    /* 53BB0 800633B0 1480043C */  lui        $a0, %hi(AI_elapsedTime)
    /* 53BB4 800633B4 54C5848C */  lw         $a0, %lo(AI_elapsedTime)($a0)
    /* 53BB8 800633B8 00000000 */  nop
    /* 53BBC 800633BC 40180400 */  sll        $v1, $a0, 1
    /* 53BC0 800633C0 21206400 */  addu       $a0, $v1, $a0
    /* 53BC4 800633C4 12100000 */  mflo       $v0
    /* 53BC8 800633C8 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 53BCC 800633CC 1480013C */  lui        $at, %hi(randtemp)
    /* 53BD0 800633D0 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 53BD4 800633D4 02120200 */  srl        $v0, $v0, 8
    /* 53BD8 800633D8 FFFF4930 */  andi       $t1, $v0, 0xFFFF
    /* 53BDC 800633DC 2A102401 */  slt        $v0, $t1, $a0
    /* 53BE0 800633E0 1480013C */  lui        $at, %hi(fastRandom)
    /* 53BE4 800633E4 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 53BE8 800633E8 04004010 */  beqz       $v0, .L800633FC
    /* 53BEC 800633EC C000A224 */   addiu     $v0, $a1, 0xC0
    /* 53BF0 800633F0 0000038D */  lw         $v1, 0x0($t0)
    /* 53BF4 800633F4 00000000 */  nop
    /* 53BF8 800633F8 480762AC */  sw         $v0, 0x748($v1)
  .L800633FC:
    /* 53BFC 800633FC 8C000325 */  addiu      $v1, $t0, 0x8C
    /* 53C00 80063400 0400628C */  lw         $v0, 0x4($v1)
    /* 53C04 80063404 00000000 */  nop
    /* 53C08 80063408 0000428C */  lw         $v0, 0x0($v0)
    /* 53C0C 8006340C 0C00638C */  lw         $v1, 0xC($v1)
    /* 53C10 80063410 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 53C14 80063414 32006210 */  beq        $v1, $v0, .L800634E0
    /* 53C18 80063418 21380000 */   addu      $a3, $zero, $zero
    /* 53C1C 8006341C 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 53C20 80063420 38CD4D24 */  addiu      $t5, $v0, %lo(highLevelAIObjs)
    /* 53C24 80063424 2160C000 */  addu       $t4, $a2, $zero
    /* 53C28 80063428 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 53C2C 8006342C 48FA4624 */  addiu      $a2, $v0, %lo(Cars_gHumanRaceCarList)
    /* 53C30 80063430 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 53C34 80063434 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 53C38 80063438 14800B3C */  lui        $t3, %hi(Cars_gNumHumanRaceCars)
    /* 53C3C 8006343C 00C86B8D */  lw         $t3, %lo(Cars_gNumHumanRaceCars)($t3)
    /* 53C40 80063440 C0100300 */  sll        $v0, $v1, 3
    /* 53C44 80063444 23104300 */  subu       $v0, $v0, $v1
    /* 53C48 80063448 80100200 */  sll        $v0, $v0, 2
    /* 53C4C 8006344C 21504300 */  addu       $t2, $v0, $v1
  .L80063450:
    /* 53C50 80063450 2A10EB00 */  slt        $v0, $a3, $t3
    /* 53C54 80063454 22004010 */  beqz       $v0, .L800634E0
    /* 53C58 80063458 0D00053C */   lui       $a1, (0xD5554 >> 16)
    /* 53C5C 8006345C 0000C48C */  lw         $a0, 0x0($a2)
    /* 53C60 80063460 5455A534 */  ori        $a1, $a1, (0xD5554 & 0xFFFF)
    /* 53C64 80063464 5402828C */  lw         $v0, 0x254($a0)
    /* 53C68 80063468 6405838C */  lw         $v1, 0x564($a0)
    /* 53C6C 8006346C 80100200 */  sll        $v0, $v0, 2
    /* 53C70 80063470 21104D00 */  addu       $v0, $v0, $t5
    /* 53C74 80063474 02006104 */  bgez       $v1, .L80063480
    /* 53C78 80063478 00000000 */   nop
    /* 53C7C 8006347C 23180300 */  negu       $v1, $v1
  .L80063480:
    /* 53C80 80063480 2A28A300 */  slt        $a1, $a1, $v1
    /* 53C84 80063484 0000428C */  lw         $v0, 0x0($v0)
    /* 53C88 80063488 A403838C */  lw         $v1, 0x3A4($a0)
    /* 53C8C 8006348C 9400428C */  lw         $v0, 0x94($v0)
    /* 53C90 80063490 1000A010 */  beqz       $a1, .L800634D4
    /* 53C94 80063494 02004228 */   slti      $v0, $v0, 0x2
    /* 53C98 80063498 03004010 */  beqz       $v0, .L800634A8
    /* 53C9C 8006349C 0300E229 */   slti      $v0, $t7, 0x3
    /* 53CA0 800634A0 05004010 */  beqz       $v0, .L800634B8
    /* 53CA4 800634A4 80200A00 */   sll       $a0, $t2, 2
  .L800634A8:
    /* 53CA8 800634A8 23106E00 */  subu       $v0, $v1, $t6
    /* 53CAC 800634AC 02004228 */  slti       $v0, $v0, 0x2
    /* 53CB0 800634B0 08004014 */  bnez       $v0, .L800634D4
    /* 53CB4 800634B4 80200A00 */   sll       $a0, $t2, 2
  .L800634B8:
    /* 53CB8 800634B8 2A102401 */  slt        $v0, $t1, $a0
    /* 53CBC 800634BC 05004010 */  beqz       $v0, .L800634D4
    /* 53CC0 800634C0 00000000 */   nop
    /* 53CC4 800634C4 0400828D */  lw         $v0, 0x4($t4)
    /* 53CC8 800634C8 0000038D */  lw         $v1, 0x0($t0)
    /* 53CCC 800634CC C0004224 */  addiu      $v0, $v0, 0xC0
    /* 53CD0 800634D0 480762AC */  sw         $v0, 0x748($v1)
  .L800634D4:
    /* 53CD4 800634D4 0400C624 */  addiu      $a2, $a2, 0x4
    /* 53CD8 800634D8 148D0108 */  j          .L80063450
    /* 53CDC 800634DC 0100E724 */   addiu     $a3, $a3, 0x1
  .L800634E0:
    /* 53CE0 800634E0 0800E003 */  jr         $ra
    /* 53CE4 800634E4 00000000 */   nop
endlabel CheckForWipeOut__15AIHigh_Opponent
