.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HandleBlockadeSpeech__15AIHigh_BasicCop, 0x124

glabel HandleBlockadeSpeech__15AIHigh_BasicCop
    /* 4D228 8005CA28 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D22C 8005CA2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D230 8005CA30 21808000 */  addu       $s0, $a0, $zero
    /* 4D234 8005CA34 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4D238 8005CA38 50000286 */  lh         $v0, 0x50($s0)
    /* 4D23C 8005CA3C 50000696 */  lhu        $a2, 0x50($s0)
    /* 4D240 8005CA40 3E004010 */  beqz       $v0, .L8005CB3C
    /* 4D244 8005CA44 00000000 */   nop
    /* 4D248 8005CA48 2400028E */  lw         $v0, 0x24($s0)
    /* 4D24C 8005CA4C 00000000 */  nop
    /* 4D250 8005CA50 0000448C */  lw         $a0, 0x0($v0)
    /* 4D254 8005CA54 00000000 */  nop
    /* 4D258 8005CA58 07008010 */  beqz       $a0, .L8005CA78
    /* 4D25C 8005CA5C 21388000 */   addu      $a3, $a0, $zero
    /* 4D260 8005CA60 5803828C */  lw         $v0, 0x358($a0)
    /* 4D264 8005CA64 3400038E */  lw         $v1, 0x34($s0)
    /* 4D268 8005CA68 7402848C */  lw         $a0, 0x274($a0)
    /* 4D26C 8005CA6C 00000000 */  nop
    /* 4D270 8005CA70 03008010 */  beqz       $a0, .L8005CA80
    /* 4D274 8005CA74 23284300 */   subu      $a1, $v0, $v1
  .L8005CA78:
    /* 4D278 8005CA78 CF720108 */  j          .L8005CB3C
    /* 4D27C 8005CA7C 500000A6 */   sh        $zero, 0x50($s0)
  .L8005CA80:
    /* 4D280 8005CA80 0200A104 */  bgez       $a1, .L8005CA8C
    /* 4D284 8005CA84 2110A000 */   addu      $v0, $a1, $zero
    /* 4D288 8005CA88 23100200 */  negu       $v0, $v0
  .L8005CA8C:
    /* 4D28C 8005CA8C 21004228 */  slti       $v0, $v0, 0x21
    /* 4D290 8005CA90 2A004010 */  beqz       $v0, .L8005CB3C
    /* 4D294 8005CA94 1180033C */   lui       $v1, %hi(Cars_topSpeedCap)
    /* 4D298 8005CA98 EB51043C */  lui        $a0, (0x51EB851F >> 16)
    /* 4D29C 8005CA9C BC08E284 */  lh         $v0, 0x8BC($a3)
    /* 4D2A0 8005CAA0 28F86324 */  addiu      $v1, $v1, %lo(Cars_topSpeedCap)
    /* 4D2A4 8005CAA4 80100200 */  sll        $v0, $v0, 2
    /* 4D2A8 8005CAA8 21104300 */  addu       $v0, $v0, $v1
    /* 4D2AC 8005CAAC 0000438C */  lw         $v1, 0x0($v0)
    /* 4D2B0 8005CAB0 1F858434 */  ori        $a0, $a0, (0x51EB851F & 0xFFFF)
    /* 4D2B4 8005CAB4 C0100300 */  sll        $v0, $v1, 3
    /* 4D2B8 8005CAB8 23104300 */  subu       $v0, $v0, $v1
    /* 4D2BC 8005CABC 80100200 */  sll        $v0, $v0, 2
    /* 4D2C0 8005CAC0 18004400 */  mult       $v0, $a0
    /* 4D2C4 8005CAC4 C3170200 */  sra        $v0, $v0, 31
    /* 4D2C8 8005CAC8 10400000 */  mfhi       $t0
    /* 4D2CC 8005CACC 431D0800 */  sra        $v1, $t0, 21
    /* 4D2D0 8005CAD0 23186200 */  subu       $v1, $v1, $v0
    /* 4D2D4 8005CAD4 2A10A300 */  slt        $v0, $a1, $v1
    /* 4D2D8 8005CAD8 04004014 */  bnez       $v0, .L8005CAEC
    /* 4D2DC 8005CADC 0200C234 */   ori       $v0, $a2, 0x2
    /* 4D2E0 8005CAE0 2A106500 */  slt        $v0, $v1, $a1
    /* 4D2E4 8005CAE4 02004010 */  beqz       $v0, .L8005CAF0
    /* 4D2E8 8005CAE8 0400C234 */   ori       $v0, $a2, 0x4
  .L8005CAEC:
    /* 4D2EC 8005CAEC 500002A6 */  sh         $v0, 0x50($s0)
  .L8005CAF0:
    /* 4D2F0 8005CAF0 50000296 */  lhu        $v0, 0x50($s0)
    /* 4D2F4 8005CAF4 06000324 */  addiu      $v1, $zero, 0x6
    /* 4D2F8 8005CAF8 06004230 */  andi       $v0, $v0, 0x6
    /* 4D2FC 8005CAFC 0F004314 */  bne        $v0, $v1, .L8005CB3C
    /* 4D300 8005CB00 00000000 */   nop
    /* 4D304 8005CB04 0000048E */  lw         $a0, 0x0($s0)
    /* 4D308 8005CB08 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4D30C 8005CB0C 00000000 */   nop
    /* 4D310 8005CB10 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4D314 8005CB14 00000000 */  nop
    /* 4D318 8005CB18 38006484 */  lh         $a0, 0x38($v1)
    /* 4D31C 8005CB1C 3C00638C */  lw         $v1, 0x3C($v1)
    /* 4D320 8005CB20 00000000 */  nop
    /* 4D324 8005CB24 09F86000 */  jalr       $v1
    /* 4D328 8005CB28 21204400 */   addu      $a0, $v0, $a0
    /* 4D32C 8005CB2C 02000224 */  addiu      $v0, $zero, 0x2
    /* 4D330 8005CB30 500000A6 */  sh         $zero, 0x50($s0)
    /* 4D334 8005CB34 1480013C */  lui        $at, %hi(AICop_gRoadBlockState)
    /* 4D338 8005CB38 74C522AC */  sw         $v0, %lo(AICop_gRoadBlockState)($at)
  .L8005CB3C:
    /* 4D33C 8005CB3C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4D340 8005CB40 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D344 8005CB44 0800E003 */  jr         $ra
    /* 4D348 8005CB48 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HandleBlockadeSpeech__15AIHigh_BasicCop
