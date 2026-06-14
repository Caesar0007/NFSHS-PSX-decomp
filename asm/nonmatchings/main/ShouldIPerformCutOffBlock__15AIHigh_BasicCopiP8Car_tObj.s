.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj, 0x160

glabel ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
    /* 4CAB4 8005C2B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4CAB8 8005C2B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4CABC 8005C2BC 21888000 */  addu       $s1, $a0, $zero
    /* 4CAC0 8005C2C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4CAC4 8005C2C4 2180C000 */  addu       $s0, $a2, $zero
    /* 4CAC8 8005C2C8 0200A104 */  bgez       $a1, .L8005C2D4
    /* 4CACC 8005C2CC 1800BFAF */   sw        $ra, 0x18($sp)
    /* 4CAD0 8005C2D0 1F00A524 */  addiu      $a1, $a1, 0x1F
  .L8005C2D4:
    /* 4CAD4 8005C2D4 1480023C */  lui        $v0, %hi(AI_elapsedTime)
    /* 4CAD8 8005C2D8 54C5428C */  lw         $v0, %lo(AI_elapsedTime)($v0)
    /* 4CADC 8005C2DC 43190500 */  sra        $v1, $a1, 5
    /* 4CAE0 8005C2E0 18006200 */  mult       $v1, $v0
    /* 4CAE4 8005C2E4 12180000 */  mflo       $v1
    /* 4CAE8 8005C2E8 40110300 */  sll        $v0, $v1, 5
    /* 4CAEC 8005C2EC 23104300 */  subu       $v0, $v0, $v1
    /* 4CAF0 8005C2F0 80100200 */  sll        $v0, $v0, 2
    /* 4CAF4 8005C2F4 21104300 */  addu       $v0, $v0, $v1
    /* 4CAF8 8005C2F8 C0200200 */  sll        $a0, $v0, 3
    /* 4CAFC 8005C2FC 02008104 */  bgez       $a0, .L8005C308
    /* 4CB00 8005C300 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 4CB04 8005C304 21208200 */  addu       $a0, $a0, $v0
  .L8005C308:
    /* 4CB08 8005C308 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4CB0C 8005C30C FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4CB10 8005C310 1480023C */  lui        $v0, %hi(randSeed)
    /* 4CB14 8005C314 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4CB18 8005C318 00000000 */  nop
    /* 4CB1C 8005C31C 18006200 */  mult       $v1, $v0
    /* 4CB20 8005C320 03240400 */  sra        $a0, $a0, 16
    /* 4CB24 8005C324 12180000 */  mflo       $v1
    /* 4CB28 8005C328 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4CB2C 8005C32C 1480013C */  lui        $at, %hi(randtemp)
    /* 4CB30 8005C330 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4CB34 8005C334 021A0300 */  srl        $v1, $v1, 8
    /* 4CB38 8005C338 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4CB3C 8005C33C 1480013C */  lui        $at, %hi(fastRandom)
    /* 4CB40 8005C340 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4CB44 8005C344 40110300 */  sll        $v0, $v1, 5
    /* 4CB48 8005C348 23104300 */  subu       $v0, $v0, $v1
    /* 4CB4C 8005C34C 80100200 */  sll        $v0, $v0, 2
    /* 4CB50 8005C350 21104300 */  addu       $v0, $v0, $v1
    /* 4CB54 8005C354 C0100200 */  sll        $v0, $v0, 3
    /* 4CB58 8005C358 02140200 */  srl        $v0, $v0, 16
    /* 4CB5C 8005C35C 2A104400 */  slt        $v0, $v0, $a0
    /* 4CB60 8005C360 27004010 */  beqz       $v0, .L8005C400
    /* 4CB64 8005C364 21100000 */   addu      $v0, $zero, $zero
    /* 4CB68 8005C368 0000248E */  lw         $a0, 0x0($s1)
    /* 4CB6C 8005C36C 7405038E */  lw         $v1, 0x574($s0)
    /* 4CB70 8005C370 7405828C */  lw         $v0, 0x574($a0)
    /* 4CB74 8005C374 00000000 */  nop
    /* 4CB78 8005C378 23104300 */  subu       $v0, $v0, $v1
    /* 4CB7C 8005C37C 02004104 */  bgez       $v0, .L8005C388
    /* 4CB80 8005C380 21284000 */   addu      $a1, $v0, $zero
    /* 4CB84 8005C384 23280500 */  negu       $a1, $a1
  .L8005C388:
    /* 4CB88 8005C388 3401028E */  lw         $v0, 0x134($s0)
    /* 4CB8C 8005C38C 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 4CB90 8005C390 21104300 */  addu       $v0, $v0, $v1
    /* 4CB94 8005C394 2A104500 */  slt        $v0, $v0, $a1
    /* 4CB98 8005C398 18004010 */  beqz       $v0, .L8005C3FC
    /* 4CB9C 8005C39C 0300023C */   lui       $v0, (0x3FFFF >> 16)
    /* 4CBA0 8005C3A0 FFFF4234 */  ori        $v0, $v0, (0x3FFFF & 0xFFFF)
    /* 4CBA4 8005C3A4 2A104500 */  slt        $v0, $v0, $a1
    /* 4CBA8 8005C3A8 15004014 */  bnez       $v0, .L8005C400
    /* 4CBAC 8005C3AC 21100000 */   addu      $v0, $zero, $zero
    /* 4CBB0 8005C3B0 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4CBB4 8005C3B4 21280002 */   addu      $a1, $s0, $zero
    /* 4CBB8 8005C3B8 0000238E */  lw         $v1, 0x0($s1)
    /* 4CBBC 8005C3BC 00000000 */  nop
    /* 4CBC0 8005C3C0 5405638C */  lw         $v1, 0x554($v1)
    /* 4CBC4 8005C3C4 00000000 */  nop
    /* 4CBC8 8005C3C8 18004300 */  mult       $v0, $v1
    /* 4CBCC 8005C3CC 3C01028E */  lw         $v0, 0x13C($s0)
    /* 4CBD0 8005C3D0 0200033C */  lui        $v1, (0x20000 >> 16)
    /* 4CBD4 8005C3D4 40100200 */  sll        $v0, $v0, 1
    /* 4CBD8 8005C3D8 21104300 */  addu       $v0, $v0, $v1
    /* 4CBDC 8005C3DC 12200000 */  mflo       $a0
    /* 4CBE0 8005C3E0 2A104400 */  slt        $v0, $v0, $a0
    /* 4CBE4 8005C3E4 05004010 */  beqz       $v0, .L8005C3FC
    /* 4CBE8 8005C3E8 0B00033C */   lui       $v1, (0xBFFFF >> 16)
    /* 4CBEC 8005C3EC FFFF6334 */  ori        $v1, $v1, (0xBFFFF & 0xFFFF)
    /* 4CBF0 8005C3F0 2A186400 */  slt        $v1, $v1, $a0
    /* 4CBF4 8005C3F4 02006010 */  beqz       $v1, .L8005C400
    /* 4CBF8 8005C3F8 01000224 */   addiu     $v0, $zero, 0x1
  .L8005C3FC:
    /* 4CBFC 8005C3FC 21100000 */  addu       $v0, $zero, $zero
  .L8005C400:
    /* 4CC00 8005C400 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4CC04 8005C404 1400B18F */  lw         $s1, 0x14($sp)
    /* 4CC08 8005C408 1000B08F */  lw         $s0, 0x10($sp)
    /* 4CC0C 8005C40C 0800E003 */  jr         $ra
    /* 4CC10 8005C410 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
