.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CheckForGripReduction__FP8Car_tObj, 0x194

glabel AIPhysic_CheckForGripReduction__FP8Car_tObj
    /* 5D2A8 8006CAA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D2AC 8006CAAC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D2B0 8006CAB0 21808000 */  addu       $s0, $a0, $zero
    /* 5D2B4 8006CAB4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5D2B8 8006CAB8 6007048E */  lw         $a0, 0x760($s0)
    /* 5D2BC 8006CABC FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5D2C0 8006CAC0 2A104400 */  slt        $v0, $v0, $a0
    /* 5D2C4 8006CAC4 24004014 */  bnez       $v0, .L8006CB58
    /* 5D2C8 8006CAC8 00000000 */   nop
    /* 5D2CC 8006CACC F004028E */  lw         $v0, 0x4F0($s0)
    /* 5D2D0 8006CAD0 5000838F */  lw         $v1, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5D2D4 8006CAD4 4000428C */  lw         $v0, 0x40($v0)
    /* 5D2D8 8006CAD8 00000000 */  nop
    /* 5D2DC 8006CADC 18006200 */  mult       $v1, $v0
    /* 5D2E0 8006CAE0 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 5D2E4 8006CAE4 B801038E */  lw         $v1, 0x1B8($s0)
    /* 5D2E8 8006CAE8 12300000 */  mflo       $a2
    /* 5D2EC 8006CAEC 21208600 */  addu       $a0, $a0, $a2
    /* 5D2F0 8006CAF0 600704AE */  sw         $a0, 0x760($s0)
    /* 5D2F4 8006CAF4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 5D2F8 8006CAF8 00000000 */  nop
    /* 5D2FC 8006CAFC 23104300 */  subu       $v0, $v0, $v1
    /* 5D300 8006CB00 40004228 */  slti       $v0, $v0, 0x40
    /* 5D304 8006CB04 05004010 */  beqz       $v0, .L8006CB1C
    /* 5D308 8006CB08 00000000 */   nop
    /* 5D30C 8006CB0C B001028E */  lw         $v0, 0x1B0($s0)
    /* 5D310 8006CB10 00000000 */  nop
    /* 5D314 8006CB14 43004010 */  beqz       $v0, .L8006CC24
    /* 5D318 8006CB18 0100023C */   lui       $v0, (0x10000 >> 16)
  .L8006CB1C:
    /* 5D31C 8006CB1C F004028E */  lw         $v0, 0x4F0($s0)
    /* 5D320 8006CB20 00000000 */  nop
    /* 5D324 8006CB24 3C00438C */  lw         $v1, 0x3C($v0)
    /* 5D328 8006CB28 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5D32C 8006CB2C 23104300 */  subu       $v0, $v0, $v1
    /* 5D330 8006CB30 02004104 */  bgez       $v0, .L8006CB3C
    /* 5D334 8006CB34 00000000 */   nop
    /* 5D338 8006CB38 03004224 */  addiu      $v0, $v0, 0x3
  .L8006CB3C:
    /* 5D33C 8006CB3C 83100200 */  sra        $v0, $v0, 2
    /* 5D340 8006CB40 21106200 */  addu       $v0, $v1, $v0
    /* 5D344 8006CB44 2A104400 */  slt        $v0, $v0, $a0
    /* 5D348 8006CB48 38004010 */  beqz       $v0, .L8006CC2C
    /* 5D34C 8006CB4C 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 5D350 8006CB50 0BB30108 */  j          .L8006CC2C
    /* 5D354 8006CB54 600702AE */   sw        $v0, 0x760($s0)
  .L8006CB58:
    /* 5D358 8006CB58 90000292 */  lbu        $v0, 0x90($s0)
    /* 5D35C 8006CB5C 00000000 */  nop
    /* 5D360 8006CB60 32004014 */  bnez       $v0, .L8006CC2C
    /* 5D364 8006CB64 00000000 */   nop
    /* 5D368 8006CB68 6002028E */  lw         $v0, 0x260($s0)
    /* 5D36C 8006CB6C 00000000 */  nop
    /* 5D370 8006CB70 28004230 */  andi       $v0, $v0, 0x28
    /* 5D374 8006CB74 2D004010 */  beqz       $v0, .L8006CC2C
    /* 5D378 8006CB78 21200002 */   addu      $a0, $s0, $zero
    /* 5D37C 8006CB7C B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 5D380 8006CB80 01000524 */   addiu     $a1, $zero, 0x1
    /* 5D384 8006CB84 05004018 */  blez       $v0, .L8006CB9C
    /* 5D388 8006CB88 21200002 */   addu      $a0, $s0, $zero
    /* 5D38C 8006CB8C B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 5D390 8006CB90 01000524 */   addiu     $a1, $zero, 0x1
    /* 5D394 8006CB94 EBB20108 */  j          .L8006CBAC
    /* 5D398 8006CB98 D1074228 */   slti      $v0, $v0, 0x7D1
  .L8006CB9C:
    /* 5D39C 8006CB9C B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 5D3A0 8006CBA0 01000524 */   addiu     $a1, $zero, 0x1
    /* 5D3A4 8006CBA4 23100200 */  negu       $v0, $v0
    /* 5D3A8 8006CBA8 D1074228 */  slti       $v0, $v0, 0x7D1
  .L8006CBAC:
    /* 5D3AC 8006CBAC 01004238 */  xori       $v0, $v0, 0x1
    /* 5D3B0 8006CBB0 1E004010 */  beqz       $v0, .L8006CC2C
    /* 5D3B4 8006CBB4 00000000 */   nop
    /* 5D3B8 8006CBB8 1480023C */  lui        $v0, %hi(fastRandom)
    /* 5D3BC 8006CBBC FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 5D3C0 8006CBC0 1480033C */  lui        $v1, %hi(randSeed)
    /* 5D3C4 8006CBC4 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 5D3C8 8006CBC8 00000000 */  nop
    /* 5D3CC 8006CBCC 18004300 */  mult       $v0, $v1
    /* 5D3D0 8006CBD0 F004058E */  lw         $a1, 0x4F0($s0)
    /* 5D3D4 8006CBD4 5000848F */  lw         $a0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5D3D8 8006CBD8 12100000 */  mflo       $v0
    /* 5D3DC 8006CBDC 3800A38C */  lw         $v1, 0x38($a1)
    /* 5D3E0 8006CBE0 00000000 */  nop
    /* 5D3E4 8006CBE4 18008300 */  mult       $a0, $v1
    /* 5D3E8 8006CBE8 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 5D3EC 8006CBEC 1480013C */  lui        $at, %hi(randtemp)
    /* 5D3F0 8006CBF0 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 5D3F4 8006CBF4 02120200 */  srl        $v0, $v0, 8
    /* 5D3F8 8006CBF8 1480013C */  lui        $at, %hi(fastRandom)
    /* 5D3FC 8006CBFC FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 5D400 8006CC00 12200000 */  mflo       $a0
    /* 5D404 8006CC04 02008104 */  bgez       $a0, .L8006CC10
    /* 5D408 8006CC08 FFFF4330 */   andi      $v1, $v0, 0xFFFF
    /* 5D40C 8006CC0C 1F008424 */  addiu      $a0, $a0, 0x1F
  .L8006CC10:
    /* 5D410 8006CC10 43110400 */  sra        $v0, $a0, 5
    /* 5D414 8006CC14 2A106200 */  slt        $v0, $v1, $v0
    /* 5D418 8006CC18 04004010 */  beqz       $v0, .L8006CC2C
    /* 5D41C 8006CC1C 00000000 */   nop
    /* 5D420 8006CC20 3C00A28C */  lw         $v0, 0x3C($a1)
  .L8006CC24:
    /* 5D424 8006CC24 00000000 */  nop
    /* 5D428 8006CC28 600702AE */  sw         $v0, 0x760($s0)
  .L8006CC2C:
    /* 5D42C 8006CC2C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D430 8006CC30 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D434 8006CC34 0800E003 */  jr         $ra
    /* 5D438 8006CC38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_CheckForGripReduction__FP8Car_tObj
