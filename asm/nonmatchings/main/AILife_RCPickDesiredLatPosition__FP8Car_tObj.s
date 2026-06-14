.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_RCPickDesiredLatPosition__FP8Car_tObj, 0x134

glabel AILife_RCPickDesiredLatPosition__FP8Car_tObj
    /* 5831C 80067B1C 21308000 */  addu       $a2, $a0, $zero
    /* 58320 80067B20 5405C38C */  lw         $v1, 0x554($a2)
    /* 58324 80067B24 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 58328 80067B28 F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 5832C 80067B2C 0800C484 */  lh         $a0, 0x8($a2)
    /* 58330 80067B30 20006214 */  bne        $v1, $v0, .L80067BB4
    /* 58334 80067B34 00000000 */   nop
    /* 58338 80067B38 1480023C */  lui        $v0, %hi(fastRandom)
    /* 5833C 80067B3C FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 58340 80067B40 1480033C */  lui        $v1, %hi(randSeed)
    /* 58344 80067B44 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 58348 80067B48 00000000 */  nop
    /* 5834C 80067B4C 18004300 */  mult       $v0, $v1
    /* 58350 80067B50 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 58354 80067B54 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 58358 80067B58 40210400 */  sll        $a0, $a0, 5
    /* 5835C 80067B5C 21208300 */  addu       $a0, $a0, $v1
    /* 58360 80067B60 1F008590 */  lbu        $a1, 0x1F($a0)
    /* 58364 80067B64 12100000 */  mflo       $v0
    /* 58368 80067B68 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 5836C 80067B6C 1480013C */  lui        $at, %hi(randtemp)
    /* 58370 80067B70 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 58374 80067B74 02120200 */  srl        $v0, $v0, 8
    /* 58378 80067B78 1480013C */  lui        $at, %hi(fastRandom)
    /* 5837C 80067B7C FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 58380 80067B80 1D008390 */  lbu        $v1, 0x1D($a0)
    /* 58384 80067B84 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 58388 80067B88 0F006330 */  andi       $v1, $v1, 0xF
    /* 5838C 80067B8C 18006200 */  mult       $v1, $v0
    /* 58390 80067B90 C02B0500 */  sll        $a1, $a1, 15
    /* 58394 80067B94 12100000 */  mflo       $v0
    /* 58398 80067B98 02140200 */  srl        $v0, $v0, 16
    /* 5839C 80067B9C 01004324 */  addiu      $v1, $v0, 0x1
    /* 583A0 80067BA0 1800A300 */  mult       $a1, $v1
    /* 583A4 80067BA4 42100500 */  srl        $v0, $a1, 1
    /* 583A8 80067BA8 12180000 */  mflo       $v1
    /* 583AC 80067BAC 0C9F0108 */  j          .L80067C30
    /* 583B0 80067BB0 23106200 */   subu      $v0, $v1, $v0
  .L80067BB4:
    /* 583B4 80067BB4 1480023C */  lui        $v0, %hi(fastRandom)
    /* 583B8 80067BB8 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 583BC 80067BBC 1480033C */  lui        $v1, %hi(randSeed)
    /* 583C0 80067BC0 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 583C4 80067BC4 00000000 */  nop
    /* 583C8 80067BC8 18004300 */  mult       $v0, $v1
    /* 583CC 80067BCC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 583D0 80067BD0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 583D4 80067BD4 40210400 */  sll        $a0, $a0, 5
    /* 583D8 80067BD8 21208300 */  addu       $a0, $a0, $v1
    /* 583DC 80067BDC 1E008590 */  lbu        $a1, 0x1E($a0)
    /* 583E0 80067BE0 12100000 */  mflo       $v0
    /* 583E4 80067BE4 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 583E8 80067BE8 1480013C */  lui        $at, %hi(randtemp)
    /* 583EC 80067BEC 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 583F0 80067BF0 02120200 */  srl        $v0, $v0, 8
    /* 583F4 80067BF4 1480013C */  lui        $at, %hi(fastRandom)
    /* 583F8 80067BF8 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 583FC 80067BFC 1D008390 */  lbu        $v1, 0x1D($a0)
    /* 58400 80067C00 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 58404 80067C04 02190300 */  srl        $v1, $v1, 4
    /* 58408 80067C08 18006200 */  mult       $v1, $v0
    /* 5840C 80067C0C C02B0500 */  sll        $a1, $a1, 15
    /* 58410 80067C10 12100000 */  mflo       $v0
    /* 58414 80067C14 02140200 */  srl        $v0, $v0, 16
    /* 58418 80067C18 01004324 */  addiu      $v1, $v0, 0x1
    /* 5841C 80067C1C 23100500 */  negu       $v0, $a1
    /* 58420 80067C20 18004300 */  mult       $v0, $v1
    /* 58424 80067C24 42100500 */  srl        $v0, $a1, 1
    /* 58428 80067C28 12180000 */  mflo       $v1
    /* 5842C 80067C2C 21106200 */  addu       $v0, $v1, $v0
  .L80067C30:
    /* 58430 80067C30 5805C2AC */  sw         $v0, 0x558($a2)
    /* 58434 80067C34 5805C28C */  lw         $v0, 0x558($a2)
    /* 58438 80067C38 6C05C38C */  lw         $v1, 0x56C($a2)
    /* 5843C 80067C3C 00000000 */  nop
    /* 58440 80067C40 21104300 */  addu       $v0, $v0, $v1
    /* 58444 80067C44 5805C2AC */  sw         $v0, 0x558($a2)
    /* 58448 80067C48 0800E003 */  jr         $ra
    /* 5844C 80067C4C 1807C2AC */   sw        $v0, 0x718($a2)
endlabel AILife_RCPickDesiredLatPosition__FP8Car_tObj
