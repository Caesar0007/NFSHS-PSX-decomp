.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache, 0x7EC

glabel DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
    /* BA0B8 800C98B8 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* BA0BC 800C98BC 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* BA0C0 800C98C0 21988000 */  addu       $s3, $a0, $zero
    /* BA0C4 800C98C4 6800B6AF */  sw         $s6, 0x68($sp)
    /* BA0C8 800C98C8 21B0A000 */  addu       $s6, $a1, $zero
    /* BA0CC 800C98CC 5400B1AF */  sw         $s1, 0x54($sp)
    /* BA0D0 800C98D0 2188E000 */  addu       $s1, $a3, $zero
    /* BA0D4 800C98D4 7000BEAF */  sw         $fp, 0x70($sp)
    /* BA0D8 800C98D8 21F00000 */  addu       $fp, $zero, $zero
    /* BA0DC 800C98DC 00020224 */  addiu      $v0, $zero, 0x200
    /* BA0E0 800C98E0 94002826 */  addiu      $t0, $s1, 0x94
    /* BA0E4 800C98E4 5800B2AF */  sw         $s2, 0x58($sp)
    /* BA0E8 800C98E8 3000B227 */  addiu      $s2, $sp, 0x30
    /* BA0EC 800C98EC 7400BFAF */  sw         $ra, 0x74($sp)
    /* BA0F0 800C98F0 6C00B7AF */  sw         $s7, 0x6C($sp)
    /* BA0F4 800C98F4 6400B5AF */  sw         $s5, 0x64($sp)
    /* BA0F8 800C98F8 6000B4AF */  sw         $s4, 0x60($sp)
    /* BA0FC 800C98FC 5000B0AF */  sw         $s0, 0x50($sp)
    /* BA100 800C9900 8000A6AF */  sw         $a2, 0x80($sp)
    /* BA104 800C9904 480122A6 */  sh         $v0, 0x148($s1)
    /* BA108 800C9908 4800A8AF */  sw         $t0, 0x48($sp)
  .L800C990C:
    /* BA10C 800C990C 8000A98F */  lw         $t1, 0x80($sp)
    /* BA110 800C9910 00000000 */  nop
    /* BA114 800C9914 FFFF2225 */  addiu      $v0, $t1, -0x1
    /* BA118 800C9918 2A10C203 */  slt        $v0, $fp, $v0
    /* BA11C 800C991C D5014010 */  beqz       $v0, .L800CA074
    /* BA120 800C9920 10007526 */   addiu     $s5, $s3, 0x10
  .L800C9924:
    /* BA124 800C9924 8000AA8F */  lw         $t2, 0x80($sp)
    /* BA128 800C9928 00000000 */  nop
    /* BA12C 800C992C FFFF4225 */  addiu      $v0, $t2, -0x1
    /* BA130 800C9930 2A10C203 */  slt        $v0, $fp, $v0
    /* BA134 800C9934 CB014010 */  beqz       $v0, .L800CA064
    /* BA138 800C9938 FF000224 */   addiu     $v0, $zero, 0xFF
    /* BA13C 800C993C 0200C392 */  lbu        $v1, 0x2($s6)
    /* BA140 800C9940 00000000 */  nop
    /* BA144 800C9944 C7016210 */  beq        $v1, $v0, .L800CA064
    /* BA148 800C9948 1180033C */   lui       $v1, %hi(gDLPixmap)
    /* BA14C 800C994C 2C2B6324 */  addiu      $v1, $v1, %lo(gDLPixmap)
    /* BA150 800C9950 0800A48E */  lw         $a0, 0x8($s5)
    /* BA154 800C9954 0200C292 */  lbu        $v0, 0x2($s6)
    /* BA158 800C9958 1C00658E */  lw         $a1, 0x1C($s3)
    /* BA15C 800C995C 80100200 */  sll        $v0, $v0, 2
    /* BA160 800C9960 21104300 */  addu       $v0, $v0, $v1
    /* BA164 800C9964 0000548C */  lw         $s4, 0x0($v0)
    /* BA168 800C9968 1000A4AF */  sw         $a0, 0x10($sp)
    /* BA16C 800C996C 1400A5AF */  sw         $a1, 0x14($sp)
    /* BA170 800C9970 F8FFA48E */  lw         $a0, -0x8($s5)
    /* BA174 800C9974 0C00658E */  lw         $a1, 0xC($s3)
    /* BA178 800C9978 1800A4AF */  sw         $a0, 0x18($sp)
    /* BA17C 800C997C 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* BA180 800C9980 0000648E */  lw         $a0, 0x0($s3)
    /* BA184 800C9984 F4FFA58E */  lw         $a1, -0xC($s5)
    /* BA188 800C9988 2000A4AF */  sw         $a0, 0x20($sp)
    /* BA18C 800C998C 2400A5AF */  sw         $a1, 0x24($sp)
    /* BA190 800C9990 0000A48E */  lw         $a0, 0x0($s5)
    /* BA194 800C9994 1400658E */  lw         $a1, 0x14($s3)
    /* BA198 800C9998 1000A227 */  addiu      $v0, $sp, 0x10
    /* BA19C 800C999C 2800A4AF */  sw         $a0, 0x28($sp)
    /* BA1A0 800C99A0 2C00A5AF */  sw         $a1, 0x2C($sp)
    /* BA1A4 800C99A4 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA1A8 800C99A8 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA1AC 800C99AC 00000000 */  nop
    /* BA1B0 800C99B0 00000000 */  nop
    /* BA1B4 800C99B4 0100184A */  .word 0x4A180001  /* rtps */
    /* BA1B8 800C99B8 98002226 */  addiu      $v0, $s1, 0x98
    /* BA1BC 800C99BC 000059E8 */  swc2       $25, 0x0($v0)
    /* BA1C0 800C99C0 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BA1C4 800C99C4 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BA1C8 800C99C8 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* BA1CC 800C99CC 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* BA1D0 800C99D0 00000000 */  nop
    /* BA1D4 800C99D4 08000226 */  addiu      $v0, $s0, 0x8
    /* BA1D8 800C99D8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BA1DC 800C99DC 1800A227 */  addiu      $v0, $sp, 0x18
    /* BA1E0 800C99E0 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA1E4 800C99E4 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA1E8 800C99E8 00000000 */  nop
    /* BA1EC 800C99EC 00000000 */  nop
    /* BA1F0 800C99F0 0100184A */  .word 0x4A180001  /* rtps */
    /* BA1F4 800C99F4 A8002226 */  addiu      $v0, $s1, 0xA8
    /* BA1F8 800C99F8 000059E8 */  swc2       $25, 0x0($v0)
    /* BA1FC 800C99FC 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BA200 800C9A00 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BA204 800C9A04 2000A227 */  addiu      $v0, $sp, 0x20
    /* BA208 800C9A08 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA20C 800C9A0C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA210 800C9A10 00000000 */  nop
    /* BA214 800C9A14 00000000 */  nop
    /* BA218 800C9A18 0100184A */  .word 0x4A180001  /* rtps */
    /* BA21C 800C9A1C B8002226 */  addiu      $v0, $s1, 0xB8
    /* BA220 800C9A20 000059E8 */  swc2       $25, 0x0($v0)
    /* BA224 800C9A24 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BA228 800C9A28 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BA22C 800C9A2C 2800A227 */  addiu      $v0, $sp, 0x28
    /* BA230 800C9A30 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA234 800C9A34 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA238 800C9A38 00000000 */  nop
    /* BA23C 800C9A3C 00000000 */  nop
    /* BA240 800C9A40 0100184A */  .word 0x4A180001  /* rtps */
    /* BA244 800C9A44 C8002226 */  addiu      $v0, $s1, 0xC8
    /* BA248 800C9A48 000059E8 */  swc2       $25, 0x0($v0)
    /* BA24C 800C9A4C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BA250 800C9A50 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BA254 800C9A54 9800228E */  lw         $v0, 0x98($s1)
    /* BA258 800C9A58 A000238E */  lw         $v1, 0xA0($s1)
    /* BA25C 800C9A5C 00000000 */  nop
    /* BA260 800C9A60 2A104300 */  slt        $v0, $v0, $v1
    /* BA264 800C9A64 13004014 */  bnez       $v0, .L800C9AB4
    /* BA268 800C9A68 00000000 */   nop
    /* BA26C 800C9A6C A800228E */  lw         $v0, 0xA8($s1)
    /* BA270 800C9A70 B000238E */  lw         $v1, 0xB0($s1)
    /* BA274 800C9A74 00000000 */  nop
    /* BA278 800C9A78 2A104300 */  slt        $v0, $v0, $v1
    /* BA27C 800C9A7C 0D004014 */  bnez       $v0, .L800C9AB4
    /* BA280 800C9A80 00000000 */   nop
    /* BA284 800C9A84 B800228E */  lw         $v0, 0xB8($s1)
    /* BA288 800C9A88 C000238E */  lw         $v1, 0xC0($s1)
    /* BA28C 800C9A8C 00000000 */  nop
    /* BA290 800C9A90 2A104300 */  slt        $v0, $v0, $v1
    /* BA294 800C9A94 07004014 */  bnez       $v0, .L800C9AB4
    /* BA298 800C9A98 00000000 */   nop
    /* BA29C 800C9A9C C800228E */  lw         $v0, 0xC8($s1)
    /* BA2A0 800C9AA0 D000238E */  lw         $v1, 0xD0($s1)
    /* BA2A4 800C9AA4 00000000 */  nop
    /* BA2A8 800C9AA8 2A104300 */  slt        $v0, $v0, $v1
    /* BA2AC 800C9AAC 68014010 */  beqz       $v0, .L800CA050
    /* BA2B0 800C9AB0 00000000 */   nop
  .L800C9AB4:
    /* BA2B4 800C9AB4 9800228E */  lw         $v0, 0x98($s1)
    /* BA2B8 800C9AB8 A000238E */  lw         $v1, 0xA0($s1)
    /* BA2BC 800C9ABC 23100200 */  negu       $v0, $v0
    /* BA2C0 800C9AC0 2A104300 */  slt        $v0, $v0, $v1
    /* BA2C4 800C9AC4 13004014 */  bnez       $v0, .L800C9B14
    /* BA2C8 800C9AC8 14000426 */   addiu     $a0, $s0, 0x14
    /* BA2CC 800C9ACC A800228E */  lw         $v0, 0xA8($s1)
    /* BA2D0 800C9AD0 B000238E */  lw         $v1, 0xB0($s1)
    /* BA2D4 800C9AD4 23100200 */  negu       $v0, $v0
    /* BA2D8 800C9AD8 2A104300 */  slt        $v0, $v0, $v1
    /* BA2DC 800C9ADC 0E004014 */  bnez       $v0, .L800C9B18
    /* BA2E0 800C9AE0 2C000326 */   addiu     $v1, $s0, 0x2C
    /* BA2E4 800C9AE4 B800228E */  lw         $v0, 0xB8($s1)
    /* BA2E8 800C9AE8 C000238E */  lw         $v1, 0xC0($s1)
    /* BA2EC 800C9AEC 23100200 */  negu       $v0, $v0
    /* BA2F0 800C9AF0 2A104300 */  slt        $v0, $v0, $v1
    /* BA2F4 800C9AF4 08004014 */  bnez       $v0, .L800C9B18
    /* BA2F8 800C9AF8 2C000326 */   addiu     $v1, $s0, 0x2C
    /* BA2FC 800C9AFC C800228E */  lw         $v0, 0xC8($s1)
    /* BA300 800C9B00 D000238E */  lw         $v1, 0xD0($s1)
    /* BA304 800C9B04 23100200 */  negu       $v0, $v0
    /* BA308 800C9B08 2A104300 */  slt        $v0, $v0, $v1
    /* BA30C 800C9B0C 50014010 */  beqz       $v0, .L800CA050
    /* BA310 800C9B10 00000000 */   nop
  .L800C9B14:
    /* BA314 800C9B14 2C000326 */  addiu      $v1, $s0, 0x2C
  .L800C9B18:
    /* BA318 800C9B18 20000226 */  addiu      $v0, $s0, 0x20
    /* BA31C 800C9B1C 00008CE8 */  swc2       $12, 0x0($a0)
    /* BA320 800C9B20 00006DE8 */  swc2       $13, 0x0($v1)
    /* BA324 800C9B24 00004EE8 */  swc2       $14, 0x0($v0)
    /* BA328 800C9B28 00000000 */  nop
    /* BA32C 800C9B2C 00000000 */  nop
    /* BA330 800C9B30 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* BA334 800C9B34 4800AB8F */  lw         $t3, 0x48($sp)
    /* BA338 800C9B38 00000000 */  nop
    /* BA33C 800C9B3C 000067E9 */  swc2       $7, 0x0($t3)
    /* BA340 800C9B40 00000000 */  nop
    /* BA344 800C9B44 00000000 */  nop
    /* BA348 800C9B48 0600404B */  .word 0x4B400006  /* nclip */
    /* BA34C 800C9B4C 4000A227 */  addiu      $v0, $sp, 0x40
    /* BA350 800C9B50 000058E8 */  swc2       $24, 0x0($v0)
    /* BA354 800C9B54 0C00238E */  lw         $v1, 0xC($s1)
    /* BA358 800C9B58 01000224 */  addiu      $v0, $zero, 0x1
    /* BA35C 800C9B5C 05006214 */  bne        $v1, $v0, .L800C9B74
    /* BA360 800C9B60 00000000 */   nop
    /* BA364 800C9B64 4000A28F */  lw         $v0, 0x40($sp)
    /* BA368 800C9B68 00000000 */  nop
    /* BA36C 800C9B6C 23100200 */  negu       $v0, $v0
    /* BA370 800C9B70 4000A2AF */  sw         $v0, 0x40($sp)
  .L800C9B74:
    /* BA374 800C9B74 4000A28F */  lw         $v0, 0x40($sp)
    /* BA378 800C9B78 00000000 */  nop
    /* BA37C 800C9B7C 34014004 */  bltz       $v0, .L800CA050
    /* BA380 800C9B80 00000000 */   nop
    /* BA384 800C9B84 9400228E */  lw         $v0, 0x94($s1)
    /* BA388 800C9B88 00000000 */  nop
    /* BA38C 800C9B8C 43B80200 */  sra        $s7, $v0, 1
    /* BA390 800C9B90 4B00E326 */  addiu      $v1, $s7, 0x4B
    /* BA394 800C9B94 C8004228 */  slti       $v0, $v0, 0xC8
    /* BA398 800C9B98 940023AE */  sw         $v1, 0x94($s1)
    /* BA39C 800C9B9C 2C016018 */  blez       $v1, .L800CA050
    /* BA3A0 800C9BA0 4C00A2AF */   sw        $v0, 0x4C($sp)
    /* BA3A4 800C9BA4 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* BA3A8 800C9BA8 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* BA3AC 800C9BAC 00000000 */  nop
    /* BA3B0 800C9BB0 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* BA3B4 800C9BB4 2A104300 */  slt        $v0, $v0, $v1
    /* BA3B8 800C9BB8 25014014 */  bnez       $v0, .L800CA050
    /* BA3BC 800C9BBC 00000000 */   nop
    /* BA3C0 800C9BC0 4C00A88F */  lw         $t0, 0x4C($sp)
    /* BA3C4 800C9BC4 00000000 */  nop
    /* BA3C8 800C9BC8 03000011 */  beqz       $t0, .L800C9BD8
    /* BA3CC 800C9BCC 00000000 */   nop
    /* BA3D0 800C9BD0 05270308 */  j          .L800C9C14
    /* BA3D4 800C9BD4 10013026 */   addiu     $s0, $s1, 0x110
  .L800C9BD8:
    /* BA3D8 800C9BD8 4800A98F */  lw         $t1, 0x48($sp)
    /* BA3DC 800C9BDC 0400308E */  lw         $s0, 0x4($s1)
    /* BA3E0 800C9BE0 00002C8D */  lw         $t4, 0x0($t1)
    /* BA3E4 800C9BE4 00002D8E */  lw         $t5, 0x0($s1)
    /* BA3E8 800C9BE8 34000E26 */  addiu      $t6, $s0, 0x34
    /* BA3EC 800C9BEC 80600C00 */  sll        $t4, $t4, 2
    /* BA3F0 800C9BF0 2168AC01 */  addu       $t5, $t5, $t4
    /* BA3F4 800C9BF4 04002EAE */  sw         $t6, 0x4($s1)
    /* BA3F8 800C9BF8 0200AE89 */  lwl        $t6, 0x2($t5)
    /* BA3FC 800C9BFC 000C0C3C */  lui        $t4, (0xC000000 >> 16)
    /* BA400 800C9C00 02720E00 */  srl        $t6, $t6, 8
    /* BA404 800C9C04 2570CC01 */  or         $t6, $t6, $t4
    /* BA408 800C9C08 00621000 */  sll        $t4, $s0, 8
    /* BA40C 800C9C0C 00000EAE */  sw         $t6, 0x0($s0)
    /* BA410 800C9C10 0200ACA9 */  swl        $t4, 0x2($t5)
  .L800C9C14:
    /* BA414 800C9C14 4400A227 */  addiu      $v0, $sp, 0x44
    /* BA418 800C9C18 000048E8 */  swc2       $8, 0x0($v0)
    /* BA41C 800C9C1C 06012292 */  lbu        $v0, 0x106($s1)
    /* BA420 800C9C20 00000000 */  nop
    /* BA424 800C9C24 7B004010 */  beqz       $v0, .L800C9E14
    /* BA428 800C9C28 01004230 */   andi      $v0, $v0, 0x1
    /* BA42C 800C9C2C 2B004010 */  beqz       $v0, .L800C9CDC
    /* BA430 800C9C30 34002226 */   addiu     $v0, $s1, 0x34
    /* BA434 800C9C34 00004C8C */  lw         $t4, 0x0($v0)
    /* BA438 800C9C38 04004D8C */  lw         $t5, 0x4($v0)
    /* BA43C 800C9C3C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BA440 800C9C40 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BA444 800C9C44 08004C8C */  lw         $t4, 0x8($v0)
    /* BA448 800C9C48 0C004D8C */  lw         $t5, 0xC($v0)
    /* BA44C 800C9C4C 10004E8C */  lw         $t6, 0x10($v0)
    /* BA450 800C9C50 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BA454 800C9C54 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BA458 800C9C58 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BA45C 800C9C5C 14004C8C */  lw         $t4, 0x14($v0)
    /* BA460 800C9C60 18004D8C */  lw         $t5, 0x18($v0)
    /* BA464 800C9C64 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BA468 800C9C68 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BA46C 800C9C6C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BA470 800C9C70 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BA474 800C9C74 2000A227 */  addiu      $v0, $sp, 0x20
    /* BA478 800C9C78 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA47C 800C9C7C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA480 800C9C80 00000000 */  nop
    /* BA484 800C9C84 00000000 */  nop
    /* BA488 800C9C88 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* BA48C 800C9C8C 000059EA */  swc2       $25, 0x0($s2)
    /* BA490 800C9C90 04005AEA */  swc2       $26, 0x4($s2) /* handwritten instruction */
    /* BA494 800C9C94 08005BEA */  swc2       $27, 0x8($s2) /* handwritten instruction */
    /* BA498 800C9C98 2800A227 */  addiu      $v0, $sp, 0x28
    /* BA49C 800C9C9C 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA4A0 800C9CA0 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA4A4 800C9CA4 00000000 */  nop
    /* BA4A8 800C9CA8 00000000 */  nop
    /* BA4AC 800C9CAC 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* BA4B0 800C9CB0 21204002 */  addu       $a0, $s2, $zero
    /* BA4B4 800C9CB4 2600A527 */  addiu      $a1, $sp, 0x26
    /* BA4B8 800C9CB8 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* BA4BC 800C9CBC 21302002 */   addu      $a2, $s1, $zero
    /* BA4C0 800C9CC0 000059EA */  swc2       $25, 0x0($s2)
    /* BA4C4 800C9CC4 04005AEA */  swc2       $26, 0x4($s2) /* handwritten instruction */
    /* BA4C8 800C9CC8 08005BEA */  swc2       $27, 0x8($s2) /* handwritten instruction */
    /* BA4CC 800C9CCC 21204002 */  addu       $a0, $s2, $zero
    /* BA4D0 800C9CD0 2E00A527 */  addiu      $a1, $sp, 0x2E
    /* BA4D4 800C9CD4 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* BA4D8 800C9CD8 21302002 */   addu      $a2, $s1, $zero
  .L800C9CDC:
    /* BA4DC 800C9CDC 1480023C */  lui        $v0, %hi(BW_gCopCarObj)
    /* BA4E0 800C9CE0 B4C7428C */  lw         $v0, %lo(BW_gCopCarObj)($v0)
    /* BA4E4 800C9CE4 00000000 */  nop
    /* BA4E8 800C9CE8 29004010 */  beqz       $v0, .L800C9D90
    /* BA4EC 800C9CEC 54002226 */   addiu     $v0, $s1, 0x54
    /* BA4F0 800C9CF0 00004C8C */  lw         $t4, 0x0($v0)
    /* BA4F4 800C9CF4 04004D8C */  lw         $t5, 0x4($v0)
    /* BA4F8 800C9CF8 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BA4FC 800C9CFC 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BA500 800C9D00 08004C8C */  lw         $t4, 0x8($v0)
    /* BA504 800C9D04 0C004D8C */  lw         $t5, 0xC($v0)
    /* BA508 800C9D08 10004E8C */  lw         $t6, 0x10($v0)
    /* BA50C 800C9D0C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BA510 800C9D10 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BA514 800C9D14 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BA518 800C9D18 14004C8C */  lw         $t4, 0x14($v0)
    /* BA51C 800C9D1C 18004D8C */  lw         $t5, 0x18($v0)
    /* BA520 800C9D20 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BA524 800C9D24 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BA528 800C9D28 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BA52C 800C9D2C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BA530 800C9D30 2000A227 */  addiu      $v0, $sp, 0x20
    /* BA534 800C9D34 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA538 800C9D38 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA53C 800C9D3C 00000000 */  nop
    /* BA540 800C9D40 00000000 */  nop
    /* BA544 800C9D44 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* BA548 800C9D48 000059EA */  swc2       $25, 0x0($s2)
    /* BA54C 800C9D4C 04005AEA */  swc2       $26, 0x4($s2) /* handwritten instruction */
    /* BA550 800C9D50 08005BEA */  swc2       $27, 0x8($s2) /* handwritten instruction */
    /* BA554 800C9D54 2800A227 */  addiu      $v0, $sp, 0x28
    /* BA558 800C9D58 000040C8 */  lwc2       $0, 0x0($v0)
    /* BA55C 800C9D5C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BA560 800C9D60 00000000 */  nop
    /* BA564 800C9D64 00000000 */  nop
    /* BA568 800C9D68 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* BA56C 800C9D6C 21204002 */  addu       $a0, $s2, $zero
    /* BA570 800C9D70 C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* BA574 800C9D74 2600A527 */   addiu     $a1, $sp, 0x26
    /* BA578 800C9D78 000059EA */  swc2       $25, 0x0($s2)
    /* BA57C 800C9D7C 04005AEA */  swc2       $26, 0x4($s2) /* handwritten instruction */
    /* BA580 800C9D80 08005BEA */  swc2       $27, 0x8($s2) /* handwritten instruction */
    /* BA584 800C9D84 21204002 */  addu       $a0, $s2, $zero
    /* BA588 800C9D88 C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* BA58C 800C9D8C 2E00A527 */   addiu     $a1, $sp, 0x2E
  .L800C9D90:
    /* BA590 800C9D90 2E00A387 */  lh         $v1, 0x2E($sp)
    /* BA594 800C9D94 1480043C */  lui        $a0, %hi(Chunk_lightTable)
    /* BA598 800C9D98 18C8848C */  lw         $a0, %lo(Chunk_lightTable)($a0)
    /* BA59C 800C9D9C 2600A287 */  lh         $v0, 0x26($sp)
    /* BA5A0 800C9DA0 80180300 */  sll        $v1, $v1, 2
    /* BA5A4 800C9DA4 21186400 */  addu       $v1, $v1, $a0
    /* BA5A8 800C9DA8 80100200 */  sll        $v0, $v0, 2
    /* BA5AC 800C9DAC 21104400 */  addu       $v0, $v0, $a0
    /* BA5B0 800C9DB0 0000428C */  lw         $v0, 0x0($v0)
    /* BA5B4 800C9DB4 0000638C */  lw         $v1, 0x0($v1)
    /* BA5B8 800C9DB8 280002AE */  sw         $v0, 0x28($s0)
    /* BA5BC 800C9DBC 100002AE */  sw         $v0, 0x10($s0)
    /* BA5C0 800C9DC0 14002226 */  addiu      $v0, $s1, 0x14
    /* BA5C4 800C9DC4 1C0003AE */  sw         $v1, 0x1C($s0)
    /* BA5C8 800C9DC8 040003AE */  sw         $v1, 0x4($s0)
    /* BA5CC 800C9DCC 00004C8C */  lw         $t4, 0x0($v0)
    /* BA5D0 800C9DD0 04004D8C */  lw         $t5, 0x4($v0)
    /* BA5D4 800C9DD4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BA5D8 800C9DD8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BA5DC 800C9DDC 08004C8C */  lw         $t4, 0x8($v0)
    /* BA5E0 800C9DE0 0C004D8C */  lw         $t5, 0xC($v0)
    /* BA5E4 800C9DE4 10004E8C */  lw         $t6, 0x10($v0)
    /* BA5E8 800C9DE8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BA5EC 800C9DEC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BA5F0 800C9DF0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BA5F4 800C9DF4 14004C8C */  lw         $t4, 0x14($v0)
    /* BA5F8 800C9DF8 18004D8C */  lw         $t5, 0x18($v0)
    /* BA5FC 800C9DFC 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BA600 800C9E00 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BA604 800C9E04 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BA608 800C9E08 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BA60C 800C9E0C B6270308 */  j          .L800C9ED8
    /* BA610 800C9E10 3E000224 */   addiu     $v0, $zero, 0x3E
  .L800C9E14:
    /* BA614 800C9E14 2E00A287 */  lh         $v0, 0x2E($sp)
    /* BA618 800C9E18 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* BA61C 800C9E1C 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* BA620 800C9E20 80100200 */  sll        $v0, $v0, 2
    /* BA624 800C9E24 21104300 */  addu       $v0, $v0, $v1
    /* BA628 800C9E28 03004A88 */  lwl        $t2, 0x3($v0)
    /* BA62C 800C9E2C 00004A98 */  lwr        $t2, 0x0($v0)
    /* BA630 800C9E30 00000000 */  nop
    /* BA634 800C9E34 3300AAAB */  swl        $t2, 0x33($sp)
    /* BA638 800C9E38 3000AABB */  swr        $t2, 0x30($sp)
    /* BA63C 800C9E3C 000046CA */  lwc2       $6, 0x0($s2)
    /* BA640 800C9E40 4400AA8F */  lw         $t2, 0x44($sp)
    /* BA644 800C9E44 00000000 */  nop
    /* BA648 800C9E48 00408A48 */  mtc2       $t2, $8 /* handwritten instruction */
    /* BA64C 800C9E4C 00000000 */  nop
    /* BA650 800C9E50 00000000 */  nop
    /* BA654 800C9E54 1000784A */  .word 0x4A780010  /* dpcs */
    /* BA658 800C9E58 1C000226 */  addiu      $v0, $s0, 0x1C
    /* BA65C 800C9E5C 000056E8 */  swc2       $22, 0x0($v0)
    /* BA660 800C9E60 1F000B8A */  lwl        $t3, 0x1F($s0)
    /* BA664 800C9E64 1C000B9A */  lwr        $t3, 0x1C($s0)
    /* BA668 800C9E68 00000000 */  nop
    /* BA66C 800C9E6C 07000BAA */  swl        $t3, 0x7($s0)
    /* BA670 800C9E70 04000BBA */  swr        $t3, 0x4($s0)
    /* BA674 800C9E74 2600A287 */  lh         $v0, 0x26($sp)
    /* BA678 800C9E78 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* BA67C 800C9E7C 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* BA680 800C9E80 80100200 */  sll        $v0, $v0, 2
    /* BA684 800C9E84 21104300 */  addu       $v0, $v0, $v1
    /* BA688 800C9E88 03004B88 */  lwl        $t3, 0x3($v0)
    /* BA68C 800C9E8C 00004B98 */  lwr        $t3, 0x0($v0)
    /* BA690 800C9E90 00000000 */  nop
    /* BA694 800C9E94 3300ABAB */  swl        $t3, 0x33($sp)
    /* BA698 800C9E98 3000ABBB */  swr        $t3, 0x30($sp)
    /* BA69C 800C9E9C 000046CA */  lwc2       $6, 0x0($s2)
    /* BA6A0 800C9EA0 4400AB8F */  lw         $t3, 0x44($sp)
    /* BA6A4 800C9EA4 00000000 */  nop
    /* BA6A8 800C9EA8 00408B48 */  mtc2       $t3, $8 /* handwritten instruction */
    /* BA6AC 800C9EAC 00000000 */  nop
    /* BA6B0 800C9EB0 00000000 */  nop
    /* BA6B4 800C9EB4 1000784A */  .word 0x4A780010  /* dpcs */
    /* BA6B8 800C9EB8 28000226 */  addiu      $v0, $s0, 0x28
    /* BA6BC 800C9EBC 000056E8 */  swc2       $22, 0x0($v0)
    /* BA6C0 800C9EC0 2B00088A */  lwl        $t0, 0x2B($s0)
    /* BA6C4 800C9EC4 2800089A */  lwr        $t0, 0x28($s0)
    /* BA6C8 800C9EC8 00000000 */  nop
    /* BA6CC 800C9ECC 130008AA */  swl        $t0, 0x13($s0)
    /* BA6D0 800C9ED0 100008BA */  swr        $t0, 0x10($s0)
    /* BA6D4 800C9ED4 3E000224 */  addiu      $v0, $zero, 0x3E
  .L800C9ED8:
    /* BA6D8 800C9ED8 070002A2 */  sb         $v0, 0x7($s0)
    /* BA6DC 800C9EDC 0C000224 */  addiu      $v0, $zero, 0xC
    /* BA6E0 800C9EE0 030002A2 */  sb         $v0, 0x3($s0)
    /* BA6E4 800C9EE4 0000828E */  lw         $v0, 0x0($s4)
    /* BA6E8 800C9EE8 0400838E */  lw         $v1, 0x4($s4)
    /* BA6EC 800C9EEC 0800848E */  lw         $a0, 0x8($s4)
    /* BA6F0 800C9EF0 0C00858E */  lw         $a1, 0xC($s4)
    /* BA6F4 800C9EF4 0C0002AE */  sw         $v0, 0xC($s0)
    /* BA6F8 800C9EF8 180003AE */  sw         $v1, 0x18($s0)
    /* BA6FC 800C9EFC 0E000396 */  lhu        $v1, 0xE($s0)
    /* BA700 800C9F00 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* BA704 800C9F04 240004AE */  sw         $a0, 0x24($s0)
    /* BA708 800C9F08 17006214 */  bne        $v1, $v0, .L800C9F68
    /* BA70C 800C9F0C 300005AE */   sw        $a1, 0x30($s0)
    /* BA710 800C9F10 DC002286 */  lh         $v0, 0xDC($s1)
    /* BA714 800C9F14 DE002386 */  lh         $v1, 0xDE($s1)
    /* BA718 800C9F18 2310E202 */  subu       $v0, $s7, $v0
    /* BA71C 800C9F1C 00110200 */  sll        $v0, $v0, 4
    /* BA720 800C9F20 07286200 */  srav       $a1, $v0, $v1
    /* BA724 800C9F24 0300A104 */  bgez       $a1, .L800C9F34
    /* BA728 800C9F28 1000A228 */   slti      $v0, $a1, 0x10
    /* BA72C 800C9F2C D0270308 */  j          .L800C9F40
    /* BA730 800C9F30 21280000 */   addu      $a1, $zero, $zero
  .L800C9F34:
    /* BA734 800C9F34 03004014 */  bnez       $v0, .L800C9F44
    /* BA738 800C9F38 1280043C */   lui       $a0, %hi(gClutDepth)
    /* BA73C 800C9F3C 0F000524 */  addiu      $a1, $zero, 0xF
  .L800C9F40:
    /* BA740 800C9F40 1280043C */  lui        $a0, %hi(gClutDepth)
  .L800C9F44:
    /* BA744 800C9F44 7C108424 */  addiu      $a0, $a0, %lo(gClutDepth)
    /* BA748 800C9F48 0A008396 */  lhu        $v1, 0xA($s4)
    /* BA74C 800C9F4C 40100500 */  sll        $v0, $a1, 1
    /* BA750 800C9F50 40190300 */  sll        $v1, $v1, 5
    /* BA754 800C9F54 21104300 */  addu       $v0, $v0, $v1
    /* BA758 800C9F58 21104400 */  addu       $v0, $v0, $a0
    /* BA75C 800C9F5C 00004294 */  lhu        $v0, 0x0($v0)
    /* BA760 800C9F60 00000000 */  nop
    /* BA764 800C9F64 0E0002A6 */  sh         $v0, 0xE($s0)
  .L800C9F68:
    /* BA768 800C9F68 4C00A88F */  lw         $t0, 0x4C($sp)
    /* BA76C 800C9F6C 00000000 */  nop
    /* BA770 800C9F70 37000011 */  beqz       $t0, .L800CA050
    /* BA774 800C9F74 74002226 */   addiu     $v0, $s1, 0x74
    /* BA778 800C9F78 00004C8C */  lw         $t4, 0x0($v0)
    /* BA77C 800C9F7C 04004D8C */  lw         $t5, 0x4($v0)
    /* BA780 800C9F80 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BA784 800C9F84 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BA788 800C9F88 08004C8C */  lw         $t4, 0x8($v0)
    /* BA78C 800C9F8C 0C004D8C */  lw         $t5, 0xC($v0)
    /* BA790 800C9F90 10004E8C */  lw         $t6, 0x10($v0)
    /* BA794 800C9F94 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BA798 800C9F98 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BA79C 800C9F9C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BA7A0 800C9FA0 14004C8C */  lw         $t4, 0x14($v0)
    /* BA7A4 800C9FA4 18004D8C */  lw         $t5, 0x18($v0)
    /* BA7A8 800C9FA8 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BA7AC 800C9FAC 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BA7B0 800C9FB0 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BA7B4 800C9FB4 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BA7B8 800C9FB8 D012828F */  lw         $v0, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* BA7BC 800C9FBC 00000000 */  nop
    /* BA7C0 800C9FC0 10004010 */  beqz       $v0, .L800CA004
    /* BA7C4 800C9FC4 00000000 */   nop
    /* BA7C8 800C9FC8 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* BA7CC 800C9FCC 2B91030C */  jal        SetSp
    /* BA7D0 800C9FD0 00000000 */   nop
    /* BA7D4 800C9FD4 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* BA7D8 800C9FD8 D01280AF */  sw         $zero, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* BA7DC 800C9FDC 8825030C */  jal        DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
    /* BA7E0 800C9FE0 21202002 */   addu      $a0, $s1, $zero
    /* BA7E4 800C9FE4 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* BA7E8 800C9FE8 2B91030C */  jal        SetSp
    /* BA7EC 800C9FEC 00000000 */   nop
    /* BA7F0 800C9FF0 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* BA7F4 800C9FF4 01000224 */  addiu      $v0, $zero, 0x1
    /* BA7F8 800C9FF8 D01282AF */  sw         $v0, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* BA7FC 800C9FFC 04280308 */  j          .L800CA010
    /* BA800 800CA000 14002226 */   addiu     $v0, $s1, 0x14
  .L800CA004:
    /* BA804 800CA004 8825030C */  jal        DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
    /* BA808 800CA008 21202002 */   addu      $a0, $s1, $zero
    /* BA80C 800CA00C 14002226 */  addiu      $v0, $s1, 0x14
  .L800CA010:
    /* BA810 800CA010 00004C8C */  lw         $t4, 0x0($v0)
    /* BA814 800CA014 04004D8C */  lw         $t5, 0x4($v0)
    /* BA818 800CA018 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BA81C 800CA01C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BA820 800CA020 08004C8C */  lw         $t4, 0x8($v0)
    /* BA824 800CA024 0C004D8C */  lw         $t5, 0xC($v0)
    /* BA828 800CA028 10004E8C */  lw         $t6, 0x10($v0)
    /* BA82C 800CA02C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BA830 800CA030 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BA834 800CA034 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BA838 800CA038 14004C8C */  lw         $t4, 0x14($v0)
    /* BA83C 800CA03C 18004D8C */  lw         $t5, 0x18($v0)
    /* BA840 800CA040 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BA844 800CA044 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BA848 800CA048 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BA84C 800CA04C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800CA050:
    /* BA850 800CA050 0100DE27 */  addiu      $fp, $fp, 0x1
    /* BA854 800CA054 0400D626 */  addiu      $s6, $s6, 0x4
    /* BA858 800CA058 1000B526 */  addiu      $s5, $s5, 0x10
    /* BA85C 800CA05C 49260308 */  j          .L800C9924
    /* BA860 800CA060 10007326 */   addiu     $s3, $s3, 0x10
  .L800CA064:
    /* BA864 800CA064 0100DE27 */  addiu      $fp, $fp, 0x1
    /* BA868 800CA068 0400D626 */  addiu      $s6, $s6, 0x4
    /* BA86C 800CA06C 43260308 */  j          .L800C990C
    /* BA870 800CA070 10007326 */   addiu     $s3, $s3, 0x10
  .L800CA074:
    /* BA874 800CA074 7400BF8F */  lw         $ra, 0x74($sp)
    /* BA878 800CA078 7000BE8F */  lw         $fp, 0x70($sp)
    /* BA87C 800CA07C 6C00B78F */  lw         $s7, 0x6C($sp)
    /* BA880 800CA080 6800B68F */  lw         $s6, 0x68($sp)
    /* BA884 800CA084 6400B58F */  lw         $s5, 0x64($sp)
    /* BA888 800CA088 6000B48F */  lw         $s4, 0x60($sp)
    /* BA88C 800CA08C 5C00B38F */  lw         $s3, 0x5C($sp)
    /* BA890 800CA090 5800B28F */  lw         $s2, 0x58($sp)
    /* BA894 800CA094 5400B18F */  lw         $s1, 0x54($sp)
    /* BA898 800CA098 5000B08F */  lw         $s0, 0x50($sp)
    /* BA89C 800CA09C 0800E003 */  jr         $ra
    /* BA8A0 800CA0A0 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
