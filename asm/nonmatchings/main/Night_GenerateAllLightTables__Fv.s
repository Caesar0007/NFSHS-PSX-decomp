.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_GenerateAllLightTables__Fv, 0x294

glabel Night_GenerateAllLightTables__Fv
    /* CC350 800DBB50 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CC354 800DBB54 21300000 */  addu       $a2, $zero, $zero
    /* CC358 800DBB58 2128C000 */  addu       $a1, $a2, $zero
    /* CC35C 800DBB5C 1480033C */  lui        $v1, %hi(Chunk_numLight)
    /* CC360 800DBB60 ECD4638C */  lw         $v1, %lo(Chunk_numLight)($v1)
    /* CC364 800DBB64 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* CC368 800DBB68 2400BFAF */  sw         $ra, 0x24($sp)
    /* CC36C 800DBB6C 2000B4AF */  sw         $s4, 0x20($sp)
    /* CC370 800DBB70 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CC374 800DBB74 1800B2AF */  sw         $s2, 0x18($sp)
    /* CC378 800DBB78 1400B1AF */  sw         $s1, 0x14($sp)
    /* CC37C 800DBB7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC380 800DBB80 441582AF */  sw         $v0, %gp_rel(gNightInitCache)($gp)
    /* CC384 800DBB84 481582AF */  sw         $v0, %gp_rel(gTableCache)($gp)
    /* CC388 800DBB88 141583AF */  sw         $v1, %gp_rel(Night_gTotalLights)($gp)
  .L800DBB8C:
    /* CC38C 800DBB8C 80200600 */  sll        $a0, $a2, 2
    /* CC390 800DBB90 0100C624 */  addiu      $a2, $a2, 0x1
    /* CC394 800DBB94 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* CC398 800DBB98 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* CC39C 800DBB9C 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CC3A0 800DBBA0 21188300 */  addu       $v1, $a0, $v1
    /* CC3A4 800DBBA4 00006390 */  lbu        $v1, 0x0($v1)
    /* CC3A8 800DBBA8 2110A200 */  addu       $v0, $a1, $v0
    /* CC3AC 800DBBAC 000043A0 */  sb         $v1, 0x0($v0)
    /* CC3B0 800DBBB0 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* CC3B4 800DBBB4 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* CC3B8 800DBBB8 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CC3BC 800DBBBC 21188300 */  addu       $v1, $a0, $v1
    /* CC3C0 800DBBC0 01006390 */  lbu        $v1, 0x1($v1)
    /* CC3C4 800DBBC4 2110A200 */  addu       $v0, $a1, $v0
    /* CC3C8 800DBBC8 010043A0 */  sb         $v1, 0x1($v0)
    /* CC3CC 800DBBCC 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CC3D0 800DBBD0 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* CC3D4 800DBBD4 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* CC3D8 800DBBD8 2110A200 */  addu       $v0, $a1, $v0
    /* CC3DC 800DBBDC 21208300 */  addu       $a0, $a0, $v1
    /* CC3E0 800DBBE0 02008390 */  lbu        $v1, 0x2($a0)
    /* CC3E4 800DBBE4 00000000 */  nop
    /* CC3E8 800DBBE8 020043A0 */  sb         $v1, 0x2($v0)
    /* CC3EC 800DBBEC 0001C228 */  slti       $v0, $a2, 0x100
    /* CC3F0 800DBBF0 E6FF4014 */  bnez       $v0, .L800DBB8C
    /* CC3F4 800DBBF4 0300A524 */   addiu     $a1, $a1, 0x3
    /* CC3F8 800DBBF8 21900000 */  addu       $s2, $zero, $zero
    /* CC3FC 800DBBFC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CC400 800DBC00 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* CC404 800DBC04 1280023C */  lui        $v0, %hi(D_80120DAC)
    /* CC408 800DBC08 AC0D5424 */  addiu      $s4, $v0, %lo(D_80120DAC)
  .L800DBC0C:
    /* CC40C 800DBC0C 1415828F */  lw         $v0, %gp_rel(Night_gTotalLights)($gp)
    /* CC410 800DBC10 00000000 */  nop
    /* CC414 800DBC14 2A104202 */  slt        $v0, $s2, $v0
    /* CC418 800DBC18 1C004010 */  beqz       $v0, .L800DBC8C
    /* CC41C 800DBC1C 01000224 */   addiu     $v0, $zero, 0x1
    /* CC420 800DBC20 4800638E */  lw         $v1, 0x48($s3)
    /* CC424 800DBC24 00000000 */  nop
    /* CC428 800DBC28 04006214 */  bne        $v1, $v0, .L800DBC3C
    /* CC42C 800DBC2C 21800000 */   addu      $s0, $zero, $zero
    /* CC430 800DBC30 B56E030C */  jal        Night_SetWeatherColors__Fi
    /* CC434 800DBC34 21204002 */   addu      $a0, $s2, $zero
    /* CC438 800DBC38 21800000 */  addu       $s0, $zero, $zero
  .L800DBC3C:
    /* CC43C 800DBC3C 1000022A */  slti       $v0, $s0, 0x10
    /* CC440 800DBC40 10004010 */  beqz       $v0, .L800DBC84
    /* CC444 800DBC44 21200000 */   addu      $a0, $zero, $zero
    /* CC448 800DBC48 21101402 */  addu       $v0, $s0, $s4
    /* CC44C 800DBC4C 00005190 */  lbu        $s1, 0x0($v0)
    /* CC450 800DBC50 21284002 */  addu       $a1, $s2, $zero
    /* CC454 800DBC54 4E6E030C */  jal        Night_SetPlayerHeadLightColor__Fiii
    /* CC458 800DBC58 21302002 */   addu      $a2, $s1, $zero
    /* CC45C 800DBC5C 1400628E */  lw         $v0, 0x14($s3)
    /* CC460 800DBC60 00000000 */  nop
    /* CC464 800DBC64 05004010 */  beqz       $v0, .L800DBC7C
    /* CC468 800DBC68 0800022A */   slti      $v0, $s0, 0x8
    /* CC46C 800DBC6C 03004010 */  beqz       $v0, .L800DBC7C
    /* CC470 800DBC70 21204002 */   addu      $a0, $s2, $zero
    /* CC474 800DBC74 746E030C */  jal        Night_SetCopLightColors__Fii
    /* CC478 800DBC78 21282002 */   addu      $a1, $s1, $zero
  .L800DBC7C:
    /* CC47C 800DBC7C 0F6F0308 */  j          .L800DBC3C
    /* CC480 800DBC80 01001026 */   addiu     $s0, $s0, 0x1
  .L800DBC84:
    /* CC484 800DBC84 036F0308 */  j          .L800DBC0C
    /* CC488 800DBC88 01005226 */   addiu     $s2, $s2, 0x1
  .L800DBC8C:
    /* CC48C 800DBC8C 21300000 */  addu       $a2, $zero, $zero
    /* CC490 800DBC90 2128C000 */  addu       $a1, $a2, $zero
  .L800DBC94:
    /* CC494 800DBC94 80200600 */  sll        $a0, $a2, 2
    /* CC498 800DBC98 0100C624 */  addiu      $a2, $a2, 0x1
    /* CC49C 800DBC9C 4815838F */  lw         $v1, %gp_rel(gTableCache)($gp)
    /* CC4A0 800DBCA0 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* CC4A4 800DBCA4 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* CC4A8 800DBCA8 2118A300 */  addu       $v1, $a1, $v1
    /* CC4AC 800DBCAC 00006390 */  lbu        $v1, 0x0($v1)
    /* CC4B0 800DBCB0 21108200 */  addu       $v0, $a0, $v0
    /* CC4B4 800DBCB4 000043A0 */  sb         $v1, 0x0($v0)
    /* CC4B8 800DBCB8 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CC4BC 800DBCBC 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* CC4C0 800DBCC0 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* CC4C4 800DBCC4 2110A200 */  addu       $v0, $a1, $v0
    /* CC4C8 800DBCC8 01004290 */  lbu        $v0, 0x1($v0)
    /* CC4CC 800DBCCC 21188300 */  addu       $v1, $a0, $v1
    /* CC4D0 800DBCD0 010062A0 */  sb         $v0, 0x1($v1)
    /* CC4D4 800DBCD4 4815828F */  lw         $v0, %gp_rel(gTableCache)($gp)
    /* CC4D8 800DBCD8 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* CC4DC 800DBCDC 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* CC4E0 800DBCE0 2110A200 */  addu       $v0, $a1, $v0
    /* CC4E4 800DBCE4 02004290 */  lbu        $v0, 0x2($v0)
    /* CC4E8 800DBCE8 21208300 */  addu       $a0, $a0, $v1
    /* CC4EC 800DBCEC 020082A0 */  sb         $v0, 0x2($a0)
    /* CC4F0 800DBCF0 0001C228 */  slti       $v0, $a2, 0x100
    /* CC4F4 800DBCF4 E7FF4014 */  bnez       $v0, .L800DBC94
    /* CC4F8 800DBCF8 0300A524 */   addiu     $a1, $a1, 0x3
    /* CC4FC 800DBCFC 21200000 */  addu       $a0, $zero, $zero
    /* CC500 800DBD00 1480073C */  lui        $a3, %hi(Night_gPlayerHeadLightColor)
    /* CC504 800DBD04 80DAE724 */  addiu      $a3, $a3, %lo(Night_gPlayerHeadLightColor)
    /* CC508 800DBD08 8888063C */  lui        $a2, (0x88888889 >> 16)
    /* CC50C 800DBD0C 8988C634 */  ori        $a2, $a2, (0x88888889 & 0xFFFF)
    /* CC510 800DBD10 1280023C */  lui        $v0, %hi(Night_gAdditiveHeadlightColor)
    /* CC514 800DBD14 BC0D4524 */  addiu      $a1, $v0, %lo(Night_gAdditiveHeadlightColor)
  .L800DBD18:
    /* CC518 800DBD18 34158293 */  lbu        $v0, %gp_rel(Night_gPlayerHeadLightColor)($gp)
    /* CC51C 800DBD1C 00000000 */  nop
    /* CC520 800DBD20 18004400 */  mult       $v0, $a0
    /* CC524 800DBD24 12100000 */  mflo       $v0
    /* CC528 800DBD28 00000000 */  nop
    /* CC52C 800DBD2C 00000000 */  nop
    /* CC530 800DBD30 18004600 */  mult       $v0, $a2
    /* CC534 800DBD34 10180000 */  mfhi       $v1
    /* CC538 800DBD38 21186200 */  addu       $v1, $v1, $v0
    /* CC53C 800DBD3C C3180300 */  sra        $v1, $v1, 3
    /* CC540 800DBD40 C3170200 */  sra        $v0, $v0, 31
    /* CC544 800DBD44 23186200 */  subu       $v1, $v1, $v0
    /* CC548 800DBD48 0000A3A0 */  sb         $v1, 0x0($a1)
    /* CC54C 800DBD4C 0100E290 */  lbu        $v0, 0x1($a3)
    /* CC550 800DBD50 00000000 */  nop
    /* CC554 800DBD54 18004400 */  mult       $v0, $a0
    /* CC558 800DBD58 12100000 */  mflo       $v0
    /* CC55C 800DBD5C 00000000 */  nop
    /* CC560 800DBD60 00000000 */  nop
    /* CC564 800DBD64 18004600 */  mult       $v0, $a2
    /* CC568 800DBD68 10180000 */  mfhi       $v1
    /* CC56C 800DBD6C 21186200 */  addu       $v1, $v1, $v0
    /* CC570 800DBD70 C3180300 */  sra        $v1, $v1, 3
    /* CC574 800DBD74 C3170200 */  sra        $v0, $v0, 31
    /* CC578 800DBD78 23186200 */  subu       $v1, $v1, $v0
    /* CC57C 800DBD7C 0100A3A0 */  sb         $v1, 0x1($a1)
    /* CC580 800DBD80 0200E290 */  lbu        $v0, 0x2($a3)
    /* CC584 800DBD84 00000000 */  nop
    /* CC588 800DBD88 18004400 */  mult       $v0, $a0
    /* CC58C 800DBD8C 12100000 */  mflo       $v0
    /* CC590 800DBD90 00000000 */  nop
    /* CC594 800DBD94 00000000 */  nop
    /* CC598 800DBD98 18004600 */  mult       $v0, $a2
    /* CC59C 800DBD9C 01008424 */  addiu      $a0, $a0, 0x1
    /* CC5A0 800DBDA0 10180000 */  mfhi       $v1
    /* CC5A4 800DBDA4 21186200 */  addu       $v1, $v1, $v0
    /* CC5A8 800DBDA8 C3180300 */  sra        $v1, $v1, 3
    /* CC5AC 800DBDAC C3170200 */  sra        $v0, $v0, 31
    /* CC5B0 800DBDB0 23186200 */  subu       $v1, $v1, $v0
    /* CC5B4 800DBDB4 0200A3A0 */  sb         $v1, 0x2($a1)
    /* CC5B8 800DBDB8 10008228 */  slti       $v0, $a0, 0x10
    /* CC5BC 800DBDBC D6FF4014 */  bnez       $v0, .L800DBD18
    /* CC5C0 800DBDC0 0400A524 */   addiu     $a1, $a1, 0x4
    /* CC5C4 800DBDC4 2400BF8F */  lw         $ra, 0x24($sp)
    /* CC5C8 800DBDC8 2000B48F */  lw         $s4, 0x20($sp)
    /* CC5CC 800DBDCC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CC5D0 800DBDD0 1800B28F */  lw         $s2, 0x18($sp)
    /* CC5D4 800DBDD4 1400B18F */  lw         $s1, 0x14($sp)
    /* CC5D8 800DBDD8 1000B08F */  lw         $s0, 0x10($sp)
    /* CC5DC 800DBDDC 0800E003 */  jr         $ra
    /* CC5E0 800DBDE0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Night_GenerateAllLightTables__Fv
