.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_HandleWipeoutTimer__FP8Car_tObj, 0x94

glabel AIPhysic_HandleWipeoutTimer__FP8Car_tObj
    /* 5A2F0 80069AF0 21388000 */  addu       $a3, $a0, $zero
    /* 5A2F4 80069AF4 6002E28C */  lw         $v0, 0x260($a3)
    /* 5A2F8 80069AF8 00000000 */  nop
    /* 5A2FC 80069AFC 08004230 */  andi       $v0, $v0, 0x8
    /* 5A300 80069B00 1E004010 */  beqz       $v0, .L80069B7C
    /* 5A304 80069B04 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 5A308 80069B08 B0E0468C */  lw         $a2, %lo(D_8011E0B0)($v0)
    /* 5A30C 80069B0C 4407E28C */  lw         $v0, 0x744($a3)
    /* 5A310 80069B10 00000000 */  nop
    /* 5A314 80069B14 2A104600 */  slt        $v0, $v0, $a2
    /* 5A318 80069B18 18004010 */  beqz       $v0, .L80069B7C
    /* 5A31C 80069B1C 00000000 */   nop
    /* 5A320 80069B20 1480023C */  lui        $v0, %hi(fastRandom)
    /* 5A324 80069B24 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 5A328 80069B28 1480033C */  lui        $v1, %hi(randSeed)
    /* 5A32C 80069B2C 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 5A330 80069B30 00000000 */  nop
    /* 5A334 80069B34 18004300 */  mult       $v0, $v1
    /* 5A338 80069B38 F004E58C */  lw         $a1, 0x4F0($a3)
    /* 5A33C 80069B3C 00000000 */  nop
    /* 5A340 80069B40 3000A48C */  lw         $a0, 0x30($a1)
    /* 5A344 80069B44 00000000 */  nop
    /* 5A348 80069B48 2120C400 */  addu       $a0, $a2, $a0
    /* 5A34C 80069B4C 12100000 */  mflo       $v0
    /* 5A350 80069B50 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 5A354 80069B54 1480013C */  lui        $at, %hi(randtemp)
    /* 5A358 80069B58 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 5A35C 80069B5C 02120200 */  srl        $v0, $v0, 8
    /* 5A360 80069B60 1480013C */  lui        $at, %hi(fastRandom)
    /* 5A364 80069B64 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 5A368 80069B68 3400A38C */  lw         $v1, 0x34($a1)
    /* 5A36C 80069B6C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 5A370 80069B70 24104300 */  and        $v0, $v0, $v1
    /* 5A374 80069B74 21208200 */  addu       $a0, $a0, $v0
    /* 5A378 80069B78 4407E4AC */  sw         $a0, 0x744($a3)
  .L80069B7C:
    /* 5A37C 80069B7C 0800E003 */  jr         $ra
    /* 5A380 80069B80 00000000 */   nop
endlabel AIPhysic_HandleWipeoutTimer__FP8Car_tObj
