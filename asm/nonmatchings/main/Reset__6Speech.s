.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Reset__6Speech, 0x19C

glabel Reset__6Speech
    /* 86194 80095994 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 86198 80095998 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8619C 8009599C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 861A0 800959A0 5F004010 */  beqz       $v0, .L80095B20
    /* 861A4 800959A4 1000B0AF */   sw        $s0, 0x10($sp)
    /* 861A8 800959A8 21200000 */  addu       $a0, $zero, $zero
    /* 861AC 800959AC 21184000 */  addu       $v1, $v0, $zero
  .L800959B0:
    /* 861B0 800959B0 04008228 */  slti       $v0, $a0, 0x4
    /* 861B4 800959B4 05004010 */  beqz       $v0, .L800959CC
    /* 861B8 800959B8 01008424 */   addiu     $a0, $a0, 0x1
    /* 861BC 800959BC 9003628C */  lw         $v0, 0x390($v1)
    /* 861C0 800959C0 04006324 */  addiu      $v1, $v1, 0x4
    /* 861C4 800959C4 6C560208 */  j          .L800959B0
    /* 861C8 800959C8 600040AC */   sw        $zero, 0x60($v0)
  .L800959CC:
    /* 861CC 800959CC 389D030C */  jal        SPCH_ClearEventQueue
    /* 861D0 800959D0 FF00103C */   lui       $s0, (0xFFFF00 >> 16)
    /* 861D4 800959D4 1480023C */  lui        $v0, %hi(fastRandom)
    /* 861D8 800959D8 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 861DC 800959DC 1480033C */  lui        $v1, %hi(randSeed)
    /* 861E0 800959E0 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 861E4 800959E4 00000000 */  nop
    /* 861E8 800959E8 18004300 */  mult       $v0, $v1
    /* 861EC 800959EC 00FF1036 */  ori        $s0, $s0, (0xFFFF00 & 0xFFFF)
    /* 861F0 800959F0 12100000 */  mflo       $v0
    /* 861F4 800959F4 24205000 */  and        $a0, $v0, $s0
    /* 861F8 800959F8 1480013C */  lui        $at, %hi(randtemp)
    /* 861FC 800959FC 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 86200 80095A00 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 86204 80095A04 1480013C */  lui        $at, %hi(fastRandom)
    /* 86208 80095A08 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 8620C 80095A0C B1AE030C */  jal        iSPCH_EACseedrandom
    /* 86210 80095A10 02220400 */   srl       $a0, $a0, 8
    /* 86214 80095A14 1480063C */  lui        $a2, %hi(fastRandom)
    /* 86218 80095A18 FCD0C68C */  lw         $a2, %lo(fastRandom)($a2)
    /* 8621C 80095A1C 1480053C */  lui        $a1, %hi(randSeed)
    /* 86220 80095A20 04D1A58C */  lw         $a1, %lo(randSeed)($a1)
    /* 86224 80095A24 00000000 */  nop
    /* 86228 80095A28 1800C500 */  mult       $a2, $a1
    /* 8622C 80095A2C 12300000 */  mflo       $a2
    /* 86230 80095A30 FFFFCB30 */  andi       $t3, $a2, 0xFFFF
    /* 86234 80095A34 00000000 */  nop
    /* 86238 80095A38 18006501 */  mult       $t3, $a1
    /* 8623C 80095A3C E338023C */  lui        $v0, (0x38E38E39 >> 16)
    /* 86240 80095A40 398E4234 */  ori        $v0, $v0, (0x38E38E39 & 0xFFFF)
    /* 86244 80095A44 12500000 */  mflo       $t2
    /* 86248 80095A48 2438D000 */  and        $a3, $a2, $s0
    /* 8624C 80095A4C 023A0700 */  srl        $a3, $a3, 8
    /* 86250 80095A50 1900E200 */  multu      $a3, $v0
    /* 86254 80095A54 10780000 */  mfhi       $t7
    /* 86258 80095A58 FFFF4C31 */  andi       $t4, $t2, 0xFFFF
    /* 8625C 80095A5C 00000000 */  nop
    /* 86260 80095A60 18008501 */  mult       $t4, $a1
    /* 86264 80095A64 24405001 */  and        $t0, $t2, $s0
    /* 86268 80095A68 12280000 */  mflo       $a1
    /* 8626C 80095A6C 02420800 */  srl        $t0, $t0, 8
    /* 86270 80095A70 AAAA023C */  lui        $v0, (0xAAAAAAAB >> 16)
    /* 86274 80095A74 ABAA4234 */  ori        $v0, $v0, (0xAAAAAAAB & 0xFFFF)
    /* 86278 80095A78 19000201 */  multu      $t0, $v0
    /* 8627C 80095A7C 3808898F */  lw         $t1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 86280 80095A80 9224033C */  lui        $v1, (0x24924925 >> 16)
    /* 86284 80095A84 A003248D */  lw         $a0, 0x3A0($t1)
    /* 86288 80095A88 25496334 */  ori        $v1, $v1, (0x24924925 & 0xFFFF)
    /* 8628C 80095A8C 1480013C */  lui        $at, %hi(randtemp)
    /* 86290 80095A90 00D126AC */  sw         $a2, %lo(randtemp)($at)
    /* 86294 80095A94 1480013C */  lui        $at, %hi(fastRandom)
    /* 86298 80095A98 FCD02BAC */  sw         $t3, %lo(fastRandom)($at)
    /* 8629C 80095A9C 1480013C */  lui        $at, %hi(randtemp)
    /* 862A0 80095AA0 00D12AAC */  sw         $t2, %lo(randtemp)($at)
    /* 862A4 80095AA4 1480013C */  lui        $at, %hi(fastRandom)
    /* 862A8 80095AA8 FCD02CAC */  sw         $t4, %lo(fastRandom)($at)
    /* 862AC 80095AAC 42300F00 */  srl        $a2, $t7, 1
    /* 862B0 80095AB0 C0100600 */  sll        $v0, $a2, 3
    /* 862B4 80095AB4 21104600 */  addu       $v0, $v0, $a2
    /* 862B8 80095AB8 10680000 */  mfhi       $t5
    /* 862BC 80095ABC 2480B000 */  and        $s0, $a1, $s0
    /* 862C0 80095AC0 02821000 */  srl        $s0, $s0, 8
    /* 862C4 80095AC4 19000302 */  multu      $s0, $v1
    /* 862C8 80095AC8 2330E200 */  subu       $a2, $a3, $v0
    /* 862CC 80095ACC 1480013C */  lui        $at, %hi(randtemp)
    /* 862D0 80095AD0 00D125AC */  sw         $a1, %lo(randtemp)($at)
    /* 862D4 80095AD4 FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* 862D8 80095AD8 800326AD */  sw         $a2, 0x380($t1)
    /* 862DC 80095ADC 1480013C */  lui        $at, %hi(fastRandom)
    /* 862E0 80095AE0 FCD025AC */  sw         $a1, %lo(fastRandom)($at)
    /* 862E4 80095AE4 82300D00 */  srl        $a2, $t5, 2
    /* 862E8 80095AE8 40100600 */  sll        $v0, $a2, 1
    /* 862EC 80095AEC 21104600 */  addu       $v0, $v0, $a2
    /* 862F0 80095AF0 40100200 */  sll        $v0, $v0, 1
    /* 862F4 80095AF4 23300201 */  subu       $a2, $t0, $v0
    /* 862F8 80095AF8 840326AD */  sw         $a2, 0x384($t1)
    /* 862FC 80095AFC 10180000 */  mfhi       $v1
    /* 86300 80095B00 23100302 */  subu       $v0, $s0, $v1
    /* 86304 80095B04 42100200 */  srl        $v0, $v0, 1
    /* 86308 80095B08 21186200 */  addu       $v1, $v1, $v0
    /* 8630C 80095B0C 82180300 */  srl        $v1, $v1, 2
    /* 86310 80095B10 C0280300 */  sll        $a1, $v1, 3
    /* 86314 80095B14 2328A300 */  subu       $a1, $a1, $v1
    /* 86318 80095B18 9557020C */  jal        Activate__Q26Speech15DispatchSpeakeri
    /* 8631C 80095B1C 23280502 */   subu      $a1, $s0, $a1
  .L80095B20:
    /* 86320 80095B20 1400BF8F */  lw         $ra, 0x14($sp)
    /* 86324 80095B24 1000B08F */  lw         $s0, 0x10($sp)
    /* 86328 80095B28 0800E003 */  jr         $ra
    /* 8632C 80095B2C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Reset__6Speech
