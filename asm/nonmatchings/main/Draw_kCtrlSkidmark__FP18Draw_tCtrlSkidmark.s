.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark, 0x584

glabel Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
    /* B989C 800C909C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* B98A0 800C90A0 4000B4AF */  sw         $s4, 0x40($sp)
    /* B98A4 800C90A4 21A08000 */  addu       $s4, $a0, $zero
    /* B98A8 800C90A8 4800B6AF */  sw         $s6, 0x48($sp)
    /* B98AC 800C90AC 24009626 */  addiu      $s6, $s4, 0x24
    /* B98B0 800C90B0 5000BEAF */  sw         $fp, 0x50($sp)
    /* B98B4 800C90B4 801F1E3C */  lui        $fp, (0x1F800094 >> 16)
    /* B98B8 800C90B8 9400DE37 */  ori        $fp, $fp, (0x1F800094 & 0xFFFF)
    /* B98BC 800C90BC 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* B98C0 800C90C0 4000133C */  lui        $s3, (0x404040 >> 16)
    /* B98C4 800C90C4 40407336 */  ori        $s3, $s3, (0x404040 & 0xFFFF)
    /* B98C8 800C90C8 3400B1AF */  sw         $s1, 0x34($sp)
    /* B98CC 800C90CC 801F113C */  lui        $s1, (0x1F800094 >> 16)
    /* B98D0 800C90D0 5400BFAF */  sw         $ra, 0x54($sp)
    /* B98D4 800C90D4 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* B98D8 800C90D8 4400B5AF */  sw         $s5, 0x44($sp)
    /* B98DC 800C90DC 3800B2AF */  sw         $s2, 0x38($sp)
    /* B98E0 800C90E0 3000B0AF */  sw         $s0, 0x30($sp)
    /* B98E4 800C90E4 5800A4AF */  sw         $a0, 0x58($sp)
    /* B98E8 800C90E8 3000958E */  lw         $s5, 0x30($s4)
    /* B98EC 800C90EC 0000838E */  lw         $v1, 0x0($s4)
    /* B98F0 800C90F0 0C00848E */  lw         $a0, 0xC($s4)
    /* B98F4 800C90F4 1800858E */  lw         $a1, 0x18($s4)
    /* B98F8 800C90F8 03190300 */  sra        $v1, $v1, 4
    /* B98FC 800C90FC 03210400 */  sra        $a0, $a0, 4
    /* B9900 800C9100 03290500 */  sra        $a1, $a1, 4
    /* B9904 800C9104 40101500 */  sll        $v0, $s5, 1
    /* B9908 800C9108 21105500 */  addu       $v0, $v0, $s5
    /* B990C 800C910C 80100200 */  sll        $v0, $v0, 2
    /* B9910 800C9110 23105500 */  subu       $v0, $v0, $s5
    /* B9914 800C9114 80100200 */  sll        $v0, $v0, 2
    /* B9918 800C9118 23105500 */  subu       $v0, $v0, $s5
    /* B991C 800C911C 00B90200 */  sll        $s7, $v0, 4
    /* B9920 800C9120 140023A6 */  sh         $v1, (0x1F800014 & 0xFFFF)($s1)
    /* B9924 800C9124 160024A6 */  sh         $a0, (0x1F800016 & 0xFFFF)($s1)
    /* B9928 800C9128 180025A6 */  sh         $a1, (0x1F800018 & 0xFFFF)($s1)
    /* B992C 800C912C 0400828E */  lw         $v0, 0x4($s4)
    /* B9930 800C9130 1000838E */  lw         $v1, 0x10($s4)
    /* B9934 800C9134 1C00848E */  lw         $a0, 0x1C($s4)
    /* B9938 800C9138 03110200 */  sra        $v0, $v0, 4
    /* B993C 800C913C 03190300 */  sra        $v1, $v1, 4
    /* B9940 800C9140 03210400 */  sra        $a0, $a0, 4
    /* B9944 800C9144 1A0022A6 */  sh         $v0, (0x1F80001A & 0xFFFF)($s1)
    /* B9948 800C9148 1C0023A6 */  sh         $v1, (0x1F80001C & 0xFFFF)($s1)
    /* B994C 800C914C 1E0024A6 */  sh         $a0, (0x1F80001E & 0xFFFF)($s1)
    /* B9950 800C9150 0800828E */  lw         $v0, 0x8($s4)
    /* B9954 800C9154 1400838E */  lw         $v1, 0x14($s4)
    /* B9958 800C9158 2000848E */  lw         $a0, 0x20($s4)
    /* B995C 800C915C 03110200 */  sra        $v0, $v0, 4
    /* B9960 800C9160 03190300 */  sra        $v1, $v1, 4
    /* B9964 800C9164 03210400 */  sra        $a0, $a0, 4
    /* B9968 800C9168 200022A6 */  sh         $v0, (0x1F800020 & 0xFFFF)($s1)
    /* B996C 800C916C 220023A6 */  sh         $v1, (0x1F800022 & 0xFFFF)($s1)
    /* B9970 800C9170 240024A6 */  sh         $a0, (0x1F800024 & 0xFFFF)($s1)
  .L800C9174:
    /* B9974 800C9174 FFFFB526 */  addiu      $s5, $s5, -0x1
  .L800C9178:
    /* B9978 800C9178 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B997C 800C917C 1C01A212 */  beq        $s5, $v0, .L800C95F0
    /* B9980 800C9180 50FDF726 */   addiu     $s7, $s7, -0x2B0
    /* B9984 800C9184 5800B88F */  lw         $t8, 0x58($sp)
    /* B9988 800C9188 00000000 */  nop
    /* B998C 800C918C 3400028F */  lw         $v0, 0x34($t8)
    /* B9990 800C9190 00000000 */  nop
    /* B9994 800C9194 21905700 */  addu       $s2, $v0, $s7
    /* B9998 800C9198 0E004486 */  lh         $a0, 0xE($s2)
    /* B999C 800C919C 28F8010C */  jal        BWorld_IsSliceInBuildList__Fi
    /* B99A0 800C91A0 21800000 */   addu      $s0, $zero, $zero
    /* B99A4 800C91A4 05004010 */  beqz       $v0, .L800C91BC
    /* B99A8 800C91A8 21204002 */   addu      $a0, $s2, $zero
    /* B99AC 800C91AC 2128C002 */  addu       $a1, $s6, $zero
    /* B99B0 800C91B0 0F24030C */  jal        Draw_CircleClip__FP8coorddefT0i
    /* B99B4 800C91B4 3200063C */   lui       $a2, (0x320000 >> 16)
    /* B99B8 800C91B8 2B800200 */  sltu       $s0, $zero, $v0
  .L800C91BC:
    /* B99BC 800C91BC EEFF0012 */  beqz       $s0, .L800C9178
    /* B99C0 800C91C0 FFFFB526 */   addiu     $s5, $s5, -0x1
    /* B99C4 800C91C4 0100B526 */  addiu      $s5, $s5, 0x1
    /* B99C8 800C91C8 0000C38E */  lw         $v1, 0x0($s6)
    /* B99CC 800C91CC 0000428E */  lw         $v0, 0x0($s2)
    /* B99D0 800C91D0 2000A427 */  addiu      $a0, $sp, 0x20
    /* B99D4 800C91D4 23104300 */  subu       $v0, $v0, $v1
    /* B99D8 800C91D8 2000A2AF */  sw         $v0, 0x20($sp)
    /* B99DC 800C91DC 0400C38E */  lw         $v1, 0x4($s6)
    /* B99E0 800C91E0 0400428E */  lw         $v0, 0x4($s2)
    /* B99E4 800C91E4 21288002 */  addu       $a1, $s4, $zero
    /* B99E8 800C91E8 23104300 */  subu       $v0, $v0, $v1
    /* B99EC 800C91EC 2400A2AF */  sw         $v0, 0x24($sp)
    /* B99F0 800C91F0 0800C38E */  lw         $v1, 0x8($s6)
    /* B99F4 800C91F4 0800428E */  lw         $v0, 0x8($s2)
    /* B99F8 800C91F8 1000A627 */  addiu      $a2, $sp, 0x10
    /* B99FC 800C91FC 23104300 */  subu       $v0, $v0, $v1
    /* B9A00 800C9200 B6AB030C */  jal        transform
    /* B9A04 800C9204 2800A2AF */   sw        $v0, 0x28($sp)
    /* B9A08 800C9208 1000A28F */  lw         $v0, 0x10($sp)
    /* B9A0C 800C920C 00000000 */  nop
    /* B9A10 800C9210 83110200 */  sra        $v0, $v0, 6
    /* B9A14 800C9214 280022AE */  sw         $v0, (0x1F800028 & 0xFFFF)($s1)
    /* B9A18 800C9218 1400A28F */  lw         $v0, 0x14($sp)
    /* B9A1C 800C921C 1800A38F */  lw         $v1, 0x18($sp)
    /* B9A20 800C9220 83110200 */  sra        $v0, $v0, 6
    /* B9A24 800C9224 83190300 */  sra        $v1, $v1, 6
    /* B9A28 800C9228 2C0022AE */  sw         $v0, (0x1F80002C & 0xFFFF)($s1)
    /* B9A2C 800C922C 14002226 */  addiu      $v0, $s1, %lo(D_1F800014)
    /* B9A30 800C9230 300023AE */  sw         $v1, (0x1F800030 & 0xFFFF)($s1)
    /* B9A34 800C9234 00004C8C */  lw         $t4, 0x0($v0)
    /* B9A38 800C9238 04004D8C */  lw         $t5, 0x4($v0)
    /* B9A3C 800C923C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B9A40 800C9240 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B9A44 800C9244 08004C8C */  lw         $t4, 0x8($v0)
    /* B9A48 800C9248 0C004D8C */  lw         $t5, 0xC($v0)
    /* B9A4C 800C924C 10004E8C */  lw         $t6, 0x10($v0)
    /* B9A50 800C9250 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B9A54 800C9254 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B9A58 800C9258 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B9A5C 800C925C 14004C8C */  lw         $t4, 0x14($v0)
    /* B9A60 800C9260 18004D8C */  lw         $t5, 0x18($v0)
    /* B9A64 800C9264 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B9A68 800C9268 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B9A6C 800C926C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B9A70 800C9270 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B9A74 800C9274 21780000 */  addu       $t7, $zero, $zero
    /* B9A78 800C9278 21484002 */  addu       $t1, $s2, $zero
    /* B9A7C 800C927C 10000B24 */  addiu      $t3, $zero, 0x10
    /* B9A80 800C9280 0C005086 */  lh         $s0, 0xC($s2)
  .L800C9284:
    /* B9A84 800C9284 00000000 */  nop
    /* B9A88 800C9288 2A10F001 */  slt        $v0, $t7, $s0
    /* B9A8C 800C928C B9FF4010 */  beqz       $v0, .L800C9174
    /* B9A90 800C9290 00000000 */   nop
    /* B9A94 800C9294 0400228E */  lw         $v0, (0x1F800004 & 0xFFFF)($s1)
    /* B9A98 800C9298 0800238E */  lw         $v1, (0x1F800008 & 0xFFFF)($s1)
    /* B9A9C 800C929C 00000000 */  nop
    /* B9AA0 800C92A0 2B104300 */  sltu       $v0, $v0, $v1
    /* B9AA4 800C92A4 CE004010 */  beqz       $v0, .L800C95E0
    /* B9AA8 800C92A8 00000000 */   nop
    /* B9AAC 800C92AC 2800228D */  lw         $v0, 0x28($t1)
    /* B9AB0 800C92B0 00000000 */  nop
    /* B9AB4 800C92B4 CA004010 */  beqz       $v0, .L800C95E0
    /* B9AB8 800C92B8 21184B02 */   addu      $v1, $s2, $t3
    /* B9ABC 800C92BC 000060C8 */  lwc2       $0, 0x0($v1)
    /* B9AC0 800C92C0 040061C8 */  lwc2       $1, 0x4($v1)
    /* B9AC4 800C92C4 00000000 */  nop
    /* B9AC8 800C92C8 00000000 */  nop
    /* B9ACC 800C92CC 0100184A */  .word 0x4A180001  /* rtps */
    /* B9AD0 800C92D0 98002226 */  addiu      $v0, $s1, %lo(D_1F800098)
    /* B9AD4 800C92D4 000059E8 */  swc2       $25, 0x0($v0)
    /* B9AD8 800C92D8 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B9ADC 800C92DC 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B9AE0 800C92E0 801F063C */  lui        $a2, (0x1F800004 >> 16)
    /* B9AE4 800C92E4 0400C68C */  lw         $a2, (0x1F800004 & 0xFFFF)($a2)
    /* B9AE8 800C92E8 00000000 */  nop
    /* B9AEC 800C92EC 0800C224 */  addiu      $v0, $a2, 0x8
    /* B9AF0 800C92F0 00004EE8 */  swc2       $14, 0x0($v0)
    /* B9AF4 800C92F4 08006324 */  addiu      $v1, $v1, 0x8
    /* B9AF8 800C92F8 000060C8 */  lwc2       $0, 0x0($v1)
    /* B9AFC 800C92FC 040061C8 */  lwc2       $1, 0x4($v1)
    /* B9B00 800C9300 00000000 */  nop
    /* B9B04 800C9304 00000000 */  nop
    /* B9B08 800C9308 0100184A */  .word 0x4A180001  /* rtps */
    /* B9B0C 800C930C A8002226 */  addiu      $v0, $s1, %lo(D_1F8000A8)
    /* B9B10 800C9310 000059E8 */  swc2       $25, 0x0($v0)
    /* B9B14 800C9314 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B9B18 800C9318 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B9B1C 800C931C 2800228D */  lw         $v0, 0x28($t1)
    /* B9B20 800C9320 00000000 */  nop
    /* B9B24 800C9324 08004224 */  addiu      $v0, $v0, 0x8
    /* B9B28 800C9328 000040C8 */  lwc2       $0, 0x0($v0)
    /* B9B2C 800C932C 040041C8 */  lwc2       $1, 0x4($v0)
    /* B9B30 800C9330 00000000 */  nop
    /* B9B34 800C9334 00000000 */  nop
    /* B9B38 800C9338 0100184A */  .word 0x4A180001  /* rtps */
    /* B9B3C 800C933C B8002226 */  addiu      $v0, $s1, %lo(D_1F8000B8)
    /* B9B40 800C9340 000059E8 */  swc2       $25, 0x0($v0)
    /* B9B44 800C9344 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B9B48 800C9348 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B9B4C 800C934C 2800388D */  lw         $t8, 0x28($t1)
    /* B9B50 800C9350 00000000 */  nop
    /* B9B54 800C9354 000000CB */  lwc2       $0, 0x0($t8)
    /* B9B58 800C9358 040001CB */  lwc2       $1, 0x4($t8)
    /* B9B5C 800C935C 00000000 */  nop
    /* B9B60 800C9360 00000000 */  nop
    /* B9B64 800C9364 0100184A */  .word 0x4A180001  /* rtps */
    /* B9B68 800C9368 C8002226 */  addiu      $v0, $s1, %lo(D_1F8000C8)
    /* B9B6C 800C936C 000059E8 */  swc2       $25, 0x0($v0)
    /* B9B70 800C9370 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B9B74 800C9374 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B9B78 800C9378 9800228E */  lw         $v0, (0x1F800098 & 0xFFFF)($s1)
    /* B9B7C 800C937C A000238E */  lw         $v1, (0x1F8000A0 & 0xFFFF)($s1)
    /* B9B80 800C9380 00000000 */  nop
    /* B9B84 800C9384 2A104300 */  slt        $v0, $v0, $v1
    /* B9B88 800C9388 13004014 */  bnez       $v0, .L800C93D8
    /* B9B8C 800C938C 00000000 */   nop
    /* B9B90 800C9390 A800228E */  lw         $v0, (0x1F8000A8 & 0xFFFF)($s1)
    /* B9B94 800C9394 B000238E */  lw         $v1, (0x1F8000B0 & 0xFFFF)($s1)
    /* B9B98 800C9398 00000000 */  nop
    /* B9B9C 800C939C 2A104300 */  slt        $v0, $v0, $v1
    /* B9BA0 800C93A0 0D004014 */  bnez       $v0, .L800C93D8
    /* B9BA4 800C93A4 00000000 */   nop
    /* B9BA8 800C93A8 B800228E */  lw         $v0, (0x1F8000B8 & 0xFFFF)($s1)
    /* B9BAC 800C93AC C000238E */  lw         $v1, (0x1F8000C0 & 0xFFFF)($s1)
    /* B9BB0 800C93B0 00000000 */  nop
    /* B9BB4 800C93B4 2A104300 */  slt        $v0, $v0, $v1
    /* B9BB8 800C93B8 07004014 */  bnez       $v0, .L800C93D8
    /* B9BBC 800C93BC 00000000 */   nop
    /* B9BC0 800C93C0 C800228E */  lw         $v0, (0x1F8000C8 & 0xFFFF)($s1)
    /* B9BC4 800C93C4 D000238E */  lw         $v1, (0x1F8000D0 & 0xFFFF)($s1)
    /* B9BC8 800C93C8 00000000 */  nop
    /* B9BCC 800C93CC 2A104300 */  slt        $v0, $v0, $v1
    /* B9BD0 800C93D0 83004010 */  beqz       $v0, .L800C95E0
    /* B9BD4 800C93D4 00000000 */   nop
  .L800C93D8:
    /* B9BD8 800C93D8 9800228E */  lw         $v0, (0x1F800098 & 0xFFFF)($s1)
    /* B9BDC 800C93DC A000238E */  lw         $v1, (0x1F8000A0 & 0xFFFF)($s1)
    /* B9BE0 800C93E0 23100200 */  negu       $v0, $v0
    /* B9BE4 800C93E4 2A104300 */  slt        $v0, $v0, $v1
    /* B9BE8 800C93E8 13004014 */  bnez       $v0, .L800C9438
    /* B9BEC 800C93EC 00000000 */   nop
    /* B9BF0 800C93F0 A800228E */  lw         $v0, (0x1F8000A8 & 0xFFFF)($s1)
    /* B9BF4 800C93F4 B000238E */  lw         $v1, (0x1F8000B0 & 0xFFFF)($s1)
    /* B9BF8 800C93F8 23100200 */  negu       $v0, $v0
    /* B9BFC 800C93FC 2A104300 */  slt        $v0, $v0, $v1
    /* B9C00 800C9400 0D004014 */  bnez       $v0, .L800C9438
    /* B9C04 800C9404 00000000 */   nop
    /* B9C08 800C9408 B800228E */  lw         $v0, (0x1F8000B8 & 0xFFFF)($s1)
    /* B9C0C 800C940C C000238E */  lw         $v1, (0x1F8000C0 & 0xFFFF)($s1)
    /* B9C10 800C9410 23100200 */  negu       $v0, $v0
    /* B9C14 800C9414 2A104300 */  slt        $v0, $v0, $v1
    /* B9C18 800C9418 07004014 */  bnez       $v0, .L800C9438
    /* B9C1C 800C941C 00000000 */   nop
    /* B9C20 800C9420 C800228E */  lw         $v0, (0x1F8000C8 & 0xFFFF)($s1)
    /* B9C24 800C9424 D000238E */  lw         $v1, (0x1F8000D0 & 0xFFFF)($s1)
    /* B9C28 800C9428 23100200 */  negu       $v0, $v0
    /* B9C2C 800C942C 2A104300 */  slt        $v0, $v0, $v1
    /* B9C30 800C9430 6B004010 */  beqz       $v0, .L800C95E0
    /* B9C34 800C9434 00000000 */   nop
  .L800C9438:
    /* B9C38 800C9438 1480023C */  lui        $v0, %hi(gSkidMarkPixmap)
    /* B9C3C 800C943C ECD14224 */  addiu      $v0, $v0, %lo(gSkidMarkPixmap)
    /* B9C40 800C9440 1400C524 */  addiu      $a1, $a2, 0x14
    /* B9C44 800C9444 2400288D */  lw         $t0, 0x24($t1)
    /* B9C48 800C9448 2C00C424 */  addiu      $a0, $a2, 0x2C
    /* B9C4C 800C944C 01000331 */  andi       $v1, $t0, 0x1
    /* B9C50 800C9450 80180300 */  sll        $v1, $v1, 2
    /* B9C54 800C9454 21186200 */  addu       $v1, $v1, $v0
    /* B9C58 800C9458 2000C224 */  addiu      $v0, $a2, 0x20
    /* B9C5C 800C945C 0000678C */  lw         $a3, 0x0($v1)
    /* B9C60 800C9460 0000ACE8 */  swc2       $12, 0x0($a1)
    /* B9C64 800C9464 00008DE8 */  swc2       $13, 0x0($a0)
    /* B9C68 800C9468 00004EE8 */  swc2       $14, 0x0($v0)
    /* B9C6C 800C946C 00000000 */  nop
    /* B9C70 800C9470 00000000 */  nop
    /* B9C74 800C9474 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* B9C78 800C9478 0000C7EB */  swc2       $7, 0x0($fp)
    /* B9C7C 800C947C 9400228E */  lw         $v0, (0x1F800094 & 0xFFFF)($s1)
    /* B9C80 800C9480 00000000 */  nop
    /* B9C84 800C9484 43510200 */  sra        $t2, $v0, 5
    /* B9C88 800C9488 32004325 */  addiu      $v1, $t2, 0x32
    /* B9C8C 800C948C 58006018 */  blez       $v1, .L800C95F0
    /* B9C90 800C9490 940023AE */   sw        $v1, (0x1F800094 & 0xFFFF)($s1)
    /* B9C94 800C9494 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* B9C98 800C9498 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* B9C9C 800C949C 00000000 */  nop
    /* B9CA0 800C94A0 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* B9CA4 800C94A4 2A104300 */  slt        $v0, $v0, $v1
    /* B9CA8 800C94A8 51004014 */  bnez       $v0, .L800C95F0
    /* B9CAC 800C94AC 00000000 */   nop
    /* B9CB0 800C94B0 06000011 */  beqz       $t0, .L800C94CC
    /* B9CB4 800C94B4 00000000 */   nop
    /* B9CB8 800C94B8 0400D3AC */  sw         $s3, 0x4($a2)
    /* B9CBC 800C94BC 1000D3AC */  sw         $s3, 0x10($a2)
    /* B9CC0 800C94C0 2800D3AC */  sw         $s3, 0x28($a2)
    /* B9CC4 800C94C4 43250308 */  j          .L800C950C
    /* B9CC8 800C94C8 1C00D3AC */   sw        $s3, 0x1C($a2)
  .L800C94CC:
    /* B9CCC 800C94CC 2000228D */  lw         $v0, 0x20($t1)
    /* B9CD0 800C94D0 00000000 */  nop
    /* B9CD4 800C94D4 0400C2AC */  sw         $v0, 0x4($a2)
    /* B9CD8 800C94D8 2000228D */  lw         $v0, 0x20($t1)
    /* B9CDC 800C94DC 00000000 */  nop
    /* B9CE0 800C94E0 1000C2AC */  sw         $v0, 0x10($a2)
    /* B9CE4 800C94E4 2800228D */  lw         $v0, 0x28($t1)
    /* B9CE8 800C94E8 00000000 */  nop
    /* B9CEC 800C94EC 1000428C */  lw         $v0, 0x10($v0)
    /* B9CF0 800C94F0 00000000 */  nop
    /* B9CF4 800C94F4 2800C2AC */  sw         $v0, 0x28($a2)
    /* B9CF8 800C94F8 2800228D */  lw         $v0, 0x28($t1)
    /* B9CFC 800C94FC 00000000 */  nop
    /* B9D00 800C9500 1000428C */  lw         $v0, 0x10($v0)
    /* B9D04 800C9504 00000000 */  nop
    /* B9D08 800C9508 1C00C2AC */  sw         $v0, 0x1C($a2)
  .L800C950C:
    /* B9D0C 800C950C 3E000224 */  addiu      $v0, $zero, 0x3E
    /* B9D10 800C9510 0700C2A0 */  sb         $v0, 0x7($a2)
    /* B9D14 800C9514 0C000224 */  addiu      $v0, $zero, 0xC
    /* B9D18 800C9518 0300C2A0 */  sb         $v0, 0x3($a2)
    /* B9D1C 800C951C 0000E28C */  lw         $v0, 0x0($a3)
    /* B9D20 800C9520 0400E38C */  lw         $v1, 0x4($a3)
    /* B9D24 800C9524 0800E48C */  lw         $a0, 0x8($a3)
    /* B9D28 800C9528 0C00E58C */  lw         $a1, 0xC($a3)
    /* B9D2C 800C952C 0C00C2AC */  sw         $v0, 0xC($a2)
    /* B9D30 800C9530 1800C3AC */  sw         $v1, 0x18($a2)
    /* B9D34 800C9534 0E00C394 */  lhu        $v1, 0xE($a2)
    /* B9D38 800C9538 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* B9D3C 800C953C 2400C4AC */  sw         $a0, 0x24($a2)
    /* B9D40 800C9540 19006214 */  bne        $v1, $v0, .L800C95A8
    /* B9D44 800C9544 3000C5AC */   sw        $a1, 0x30($a2)
    /* B9D48 800C9548 DC002296 */  lhu        $v0, (0x1F8000DC & 0xFFFF)($s1)
    /* B9D4C 800C954C DE002396 */  lhu        $v1, (0x1F8000DE & 0xFFFF)($s1)
    /* B9D50 800C9550 00140200 */  sll        $v0, $v0, 16
    /* B9D54 800C9554 03140200 */  sra        $v0, $v0, 16
    /* B9D58 800C9558 23104201 */  subu       $v0, $t2, $v0
    /* B9D5C 800C955C 00110200 */  sll        $v0, $v0, 4
    /* B9D60 800C9560 07186200 */  srav       $v1, $v0, $v1
    /* B9D64 800C9564 03006104 */  bgez       $v1, .L800C9574
    /* B9D68 800C9568 10006228 */   slti      $v0, $v1, 0x10
    /* B9D6C 800C956C 60250308 */  j          .L800C9580
    /* B9D70 800C9570 21180000 */   addu      $v1, $zero, $zero
  .L800C9574:
    /* B9D74 800C9574 03004014 */  bnez       $v0, .L800C9584
    /* B9D78 800C9578 40180300 */   sll       $v1, $v1, 1
    /* B9D7C 800C957C 0F000324 */  addiu      $v1, $zero, 0xF
  .L800C9580:
    /* B9D80 800C9580 40180300 */  sll        $v1, $v1, 1
  .L800C9584:
    /* B9D84 800C9584 1280183C */  lui        $t8, %hi(gClutDepth)
    /* B9D88 800C9588 0A00E294 */  lhu        $v0, 0xA($a3)
    /* B9D8C 800C958C 7C101827 */  addiu      $t8, $t8, %lo(gClutDepth)
    /* B9D90 800C9590 40110200 */  sll        $v0, $v0, 5
    /* B9D94 800C9594 21186200 */  addu       $v1, $v1, $v0
    /* B9D98 800C9598 21187800 */  addu       $v1, $v1, $t8
    /* B9D9C 800C959C 00006294 */  lhu        $v0, 0x0($v1)
    /* B9DA0 800C95A0 00000000 */  nop
    /* B9DA4 800C95A4 0E00C2A4 */  sh         $v0, 0xE($a2)
  .L800C95A8:
    /* B9DA8 800C95A8 0400268E */  lw         $a2, (0x1F800004 & 0xFFFF)($s1)
    /* B9DAC 800C95AC 0000CC8F */  lw         $t4, 0x0($fp)
    /* B9DB0 800C95B0 00002D8E */  lw         $t5, (0x1F800000 & 0xFFFF)($s1)
    /* B9DB4 800C95B4 3400CE24 */  addiu      $t6, $a2, 0x34
    /* B9DB8 800C95B8 80600C00 */  sll        $t4, $t4, 2
    /* B9DBC 800C95BC 2168AC01 */  addu       $t5, $t5, $t4
    /* B9DC0 800C95C0 04002EAE */  sw         $t6, (0x1F800004 & 0xFFFF)($s1)
    /* B9DC4 800C95C4 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B9DC8 800C95C8 000C0C3C */  lui        $t4, (0xC000000 >> 16)
    /* B9DCC 800C95CC 02720E00 */  srl        $t6, $t6, 8
    /* B9DD0 800C95D0 2570CC01 */  or         $t6, $t6, $t4
    /* B9DD4 800C95D4 00620600 */  sll        $t4, $a2, 8
    /* B9DD8 800C95D8 0000CEAC */  sw         $t6, 0x0($a2)
    /* B9DDC 800C95DC 0200ACA9 */  swl        $t4, 0x2($t5)
  .L800C95E0:
    /* B9DE0 800C95E0 1C002925 */  addiu      $t1, $t1, 0x1C
    /* B9DE4 800C95E4 1C006B25 */  addiu      $t3, $t3, 0x1C
    /* B9DE8 800C95E8 A1240308 */  j          .L800C9284
    /* B9DEC 800C95EC 0100EF25 */   addiu     $t7, $t7, 0x1
  .L800C95F0:
    /* B9DF0 800C95F0 5400BF8F */  lw         $ra, 0x54($sp)
    /* B9DF4 800C95F4 5000BE8F */  lw         $fp, 0x50($sp)
    /* B9DF8 800C95F8 4C00B78F */  lw         $s7, 0x4C($sp)
    /* B9DFC 800C95FC 4800B68F */  lw         $s6, 0x48($sp)
    /* B9E00 800C9600 4400B58F */  lw         $s5, 0x44($sp)
    /* B9E04 800C9604 4000B48F */  lw         $s4, 0x40($sp)
    /* B9E08 800C9608 3C00B38F */  lw         $s3, 0x3C($sp)
    /* B9E0C 800C960C 3800B28F */  lw         $s2, 0x38($sp)
    /* B9E10 800C9610 3400B18F */  lw         $s1, 0x34($sp)
    /* B9E14 800C9614 3000B08F */  lw         $s0, 0x30($sp)
    /* B9E18 800C9618 0800E003 */  jr         $ra
    /* B9E1C 800C961C 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
