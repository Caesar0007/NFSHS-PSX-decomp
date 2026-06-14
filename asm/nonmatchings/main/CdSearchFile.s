.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdSearchFile, 0x2D8

glabel CdSearchFile
    /* E9888 800F9088 1380033C */  lui        $v1, %hi(D_80136C6C)
    /* E988C 800F908C 6C6C638C */  lw         $v1, %lo(D_80136C6C)($v1)
    /* E9890 800F9090 1480023C */  lui        $v0, %hi(CD_nopen)
    /* E9894 800F9094 5CBF428C */  lw         $v0, %lo(CD_nopen)($v0)
    /* E9898 800F9098 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* E989C 800F909C 4800B6AF */  sw         $s6, 0x48($sp)
    /* E98A0 800F90A0 21B08000 */  addu       $s6, $a0, $zero
    /* E98A4 800F90A4 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* E98A8 800F90A8 2198A000 */  addu       $s3, $a1, $zero
    /* E98AC 800F90AC 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* E98B0 800F90B0 4400B5AF */  sw         $s5, 0x44($sp)
    /* E98B4 800F90B4 4000B4AF */  sw         $s4, 0x40($sp)
    /* E98B8 800F90B8 3800B2AF */  sw         $s2, 0x38($sp)
    /* E98BC 800F90BC 3400B1AF */  sw         $s1, 0x34($sp)
    /* E98C0 800F90C0 09006210 */  beq        $v1, $v0, .L800F90E8
    /* E98C4 800F90C4 3000B0AF */   sw        $s0, 0x30($sp)
    /* E98C8 800F90C8 E0E4030C */  jal        func_800F9380
    /* E98CC 800F90CC 00000000 */   nop
    /* E98D0 800F90D0 99004010 */  beqz       $v0, .L800F9338
    /* E98D4 800F90D4 21100000 */   addu      $v0, $zero, $zero
    /* E98D8 800F90D8 1480023C */  lui        $v0, %hi(CD_nopen)
    /* E98DC 800F90DC 5CBF428C */  lw         $v0, %lo(CD_nopen)($v0)
    /* E98E0 800F90E0 1380013C */  lui        $at, %hi(D_80136C6C)
    /* E98E4 800F90E4 6C6C22AC */  sw         $v0, %lo(D_80136C6C)($at)
  .L800F90E8:
    /* E98E8 800F90E8 00006382 */  lb         $v1, 0x0($s3)
    /* E98EC 800F90EC 5C000224 */  addiu      $v0, $zero, 0x5C
    /* E98F0 800F90F0 05006210 */  beq        $v1, $v0, .L800F9108
    /* E98F4 800F90F4 21100000 */   addu      $v0, $zero, $zero
    /* E98F8 800F90F8 CEE40308 */  j          .L800F9338
    /* E98FC 800F90FC 00000000 */   nop
  .L800F9100:
    /* E9900 800F9100 64E40308 */  j          .L800F9190
    /* E9904 800F9104 1000A0A3 */   sb        $zero, 0x10($sp)
  .L800F9108:
    /* E9908 800F9108 1000A0A3 */  sb         $zero, 0x10($sp)
    /* E990C 800F910C 01000424 */  addiu      $a0, $zero, 0x1
    /* E9910 800F9110 21806002 */  addu       $s0, $s3, $zero
    /* E9914 800F9114 21900000 */  addu       $s2, $zero, $zero
    /* E9918 800F9118 5C001524 */  addiu      $s5, $zero, 0x5C
    /* E991C 800F911C FFFF1424 */  addiu      $s4, $zero, -0x1
  .L800F9120:
    /* E9920 800F9120 00000282 */  lb         $v0, 0x0($s0)
    /* E9924 800F9124 00000392 */  lbu        $v1, 0x0($s0)
    /* E9928 800F9128 0C005510 */  beq        $v0, $s5, .L800F915C
    /* E992C 800F912C 1000B127 */   addiu     $s1, $sp, 0x10
    /* E9930 800F9130 5C000524 */  addiu      $a1, $zero, 0x5C
  .L800F9134:
    /* E9934 800F9134 17006010 */  beqz       $v1, .L800F9194
    /* E9938 800F9138 0800422A */   slti      $v0, $s2, 0x8
    /* E993C 800F913C 01001026 */  addiu      $s0, $s0, 0x1
    /* E9940 800F9140 000023A2 */  sb         $v1, 0x0($s1)
    /* E9944 800F9144 00000282 */  lb         $v0, 0x0($s0)
    /* E9948 800F9148 00000392 */  lbu        $v1, 0x0($s0)
    /* E994C 800F914C F9FF4514 */  bne        $v0, $a1, .L800F9134
    /* E9950 800F9150 01003126 */   addiu     $s1, $s1, 0x1
    /* E9954 800F9154 00000282 */  lb         $v0, 0x0($s0)
    /* E9958 800F9158 00000000 */  nop
  .L800F915C:
    /* E995C 800F915C 0D004010 */  beqz       $v0, .L800F9194
    /* E9960 800F9160 0800422A */   slti      $v0, $s2, 0x8
    /* E9964 800F9164 01001026 */  addiu      $s0, $s0, 0x1
    /* E9968 800F9168 000020A2 */  sb         $zero, 0x0($s1)
    /* E996C 800F916C 91E5030C */  jal        func_800F9644
    /* E9970 800F9170 1000A527 */   addiu     $a1, $sp, 0x10
    /* E9974 800F9174 21204000 */  addu       $a0, $v0, $zero
    /* E9978 800F9178 E1FF9410 */  beq        $a0, $s4, .L800F9100
    /* E997C 800F917C 00000000 */   nop
    /* E9980 800F9180 01005226 */  addiu      $s2, $s2, 0x1
    /* E9984 800F9184 0800422A */  slti       $v0, $s2, 0x8
    /* E9988 800F9188 E5FF4014 */  bnez       $v0, .L800F9120
    /* E998C 800F918C 00000000 */   nop
  .L800F9190:
    /* E9990 800F9190 0800422A */  slti       $v0, $s2, 0x8
  .L800F9194:
    /* E9994 800F9194 0C004014 */  bnez       $v0, .L800F91C8
    /* E9998 800F9198 00000000 */   nop
    /* E999C 800F919C 1480023C */  lui        $v0, %hi(CD_debug)
    /* E99A0 800F91A0 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E99A4 800F91A4 00000000 */  nop
    /* E99A8 800F91A8 62004018 */  blez       $v0, .L800F9334
    /* E99AC 800F91AC 21286002 */   addu      $a1, $s3, $zero
    /* E99B0 800F91B0 0580043C */  lui        $a0, %hi(D_80057180)
    /* E99B4 800F91B4 80718424 */  addiu      $a0, $a0, %lo(D_80057180)
    /* E99B8 800F91B8 2B0A040C */  jal        printf
    /* E99BC 800F91BC 21304002 */   addu      $a2, $s2, $zero
    /* E99C0 800F91C0 CEE40308 */  j          .L800F9338
    /* E99C4 800F91C4 21100000 */   addu      $v0, $zero, $zero
  .L800F91C8:
    /* E99C8 800F91C8 1000A283 */  lb         $v0, 0x10($sp)
    /* E99CC 800F91CC 00000000 */  nop
    /* E99D0 800F91D0 09004014 */  bnez       $v0, .L800F91F8
    /* E99D4 800F91D4 00000000 */   nop
    /* E99D8 800F91D8 1480023C */  lui        $v0, %hi(CD_debug)
    /* E99DC 800F91DC 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E99E0 800F91E0 00000000 */  nop
    /* E99E4 800F91E4 53004018 */  blez       $v0, .L800F9334
    /* E99E8 800F91E8 21286002 */   addu      $a1, $s3, $zero
    /* E99EC 800F91EC 0580043C */  lui        $a0, %hi(D_8005719C)
    /* E99F0 800F91F0 CBE40308 */  j          .L800F932C
    /* E99F4 800F91F4 9C718424 */   addiu     $a0, $a0, %lo(D_8005719C)
  .L800F91F8:
    /* E99F8 800F91F8 BAE5030C */  jal        func_800F96E8
    /* E99FC 800F91FC 000020A2 */   sb        $zero, 0x0($s1)
    /* E9A00 800F9200 0B004014 */  bnez       $v0, .L800F9230
    /* E9A04 800F9204 00000000 */   nop
    /* E9A08 800F9208 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9A0C 800F920C 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9A10 800F9210 00000000 */  nop
    /* E9A14 800F9214 48004018 */  blez       $v0, .L800F9338
    /* E9A18 800F9218 21100000 */   addu      $v0, $zero, $zero
    /* E9A1C 800F921C 0580043C */  lui        $a0, %hi(D_800571B4)
    /* E9A20 800F9220 2B0A040C */  jal        printf
    /* E9A24 800F9224 B4718424 */   addiu     $a0, $a0, %lo(D_800571B4)
    /* E9A28 800F9228 CEE40308 */  j          .L800F9338
    /* E9A2C 800F922C 21100000 */   addu      $v0, $zero, $zero
  .L800F9230:
    /* E9A30 800F9230 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9A34 800F9234 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9A38 800F9238 00000000 */  nop
    /* E9A3C 800F923C 02004228 */  slti       $v0, $v0, 0x2
    /* E9A40 800F9240 06004014 */  bnez       $v0, .L800F925C
    /* E9A44 800F9244 21900000 */   addu      $s2, $zero, $zero
    /* E9A48 800F9248 0580043C */  lui        $a0, %hi(D_800571D0)
    /* E9A4C 800F924C D0718424 */  addiu      $a0, $a0, %lo(D_800571D0)
    /* E9A50 800F9250 2B0A040C */  jal        printf
    /* E9A54 800F9254 1000A527 */   addiu     $a1, $sp, 0x10
    /* E9A58 800F9258 21900000 */  addu       $s2, $zero, $zero
  .L800F925C:
    /* E9A5C 800F925C 1480023C */  lui        $v0, %hi(D_80144884)
    /* E9A60 800F9260 84484224 */  addiu      $v0, $v0, %lo(D_80144884)
    /* E9A64 800F9264 F8FF5024 */  addiu      $s0, $v0, -0x8
    /* E9A68 800F9268 21984000 */  addu       $s3, $v0, $zero
    /* E9A6C 800F926C 21880000 */  addu       $s1, $zero, $zero
  .L800F9270:
    /* E9A70 800F9270 1480023C */  lui        $v0, %hi(D_80144884)
    /* E9A74 800F9274 21105100 */  addu       $v0, $v0, $s1
    /* E9A78 800F9278 84484280 */  lb         $v0, %lo(D_80144884)($v0)
    /* E9A7C 800F927C 00000000 */  nop
    /* E9A80 800F9280 23004010 */  beqz       $v0, .L800F9310
    /* E9A84 800F9284 21206002 */   addu      $a0, $s3, $zero
    /* E9A88 800F9288 D8E4030C */  jal        func_800F9360
    /* E9A8C 800F928C 1000A527 */   addiu     $a1, $sp, 0x10
    /* E9A90 800F9290 19004010 */  beqz       $v0, .L800F92F8
    /* E9A94 800F9294 00000000 */   nop
    /* E9A98 800F9298 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9A9C 800F929C 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9AA0 800F92A0 00000000 */  nop
    /* E9AA4 800F92A4 02004228 */  slti       $v0, $v0, 0x2
    /* E9AA8 800F92A8 05004014 */  bnez       $v0, .L800F92C0
    /* E9AAC 800F92AC 00000000 */   nop
    /* E9AB0 800F92B0 0580043C */  lui        $a0, %hi(D_800571F0)
    /* E9AB4 800F92B4 F0718424 */  addiu      $a0, $a0, %lo(D_800571F0)
    /* E9AB8 800F92B8 2B0A040C */  jal        printf
    /* E9ABC 800F92BC 1000A527 */   addiu     $a1, $sp, 0x10
  .L800F92C0:
    /* E9AC0 800F92C0 0000028E */  lw         $v0, 0x0($s0)
    /* E9AC4 800F92C4 0400038E */  lw         $v1, 0x4($s0)
    /* E9AC8 800F92C8 0800048E */  lw         $a0, 0x8($s0)
    /* E9ACC 800F92CC 0C00058E */  lw         $a1, 0xC($s0)
    /* E9AD0 800F92D0 0000C2AE */  sw         $v0, 0x0($s6)
    /* E9AD4 800F92D4 0400C3AE */  sw         $v1, 0x4($s6)
    /* E9AD8 800F92D8 0800C4AE */  sw         $a0, 0x8($s6)
    /* E9ADC 800F92DC 0C00C5AE */  sw         $a1, 0xC($s6)
    /* E9AE0 800F92E0 1000028E */  lw         $v0, 0x10($s0)
    /* E9AE4 800F92E4 1400038E */  lw         $v1, 0x14($s0)
    /* E9AE8 800F92E8 1000C2AE */  sw         $v0, 0x10($s6)
    /* E9AEC 800F92EC 1400C3AE */  sw         $v1, 0x14($s6)
    /* E9AF0 800F92F0 CEE40308 */  j          .L800F9338
    /* E9AF4 800F92F4 21100002 */   addu      $v0, $s0, $zero
  .L800F92F8:
    /* E9AF8 800F92F8 18001026 */  addiu      $s0, $s0, 0x18
    /* E9AFC 800F92FC 18007326 */  addiu      $s3, $s3, 0x18
    /* E9B00 800F9300 01005226 */  addiu      $s2, $s2, 0x1
    /* E9B04 800F9304 4000422A */  slti       $v0, $s2, 0x40
    /* E9B08 800F9308 D9FF4014 */  bnez       $v0, .L800F9270
    /* E9B0C 800F930C 18003126 */   addiu     $s1, $s1, 0x18
  .L800F9310:
    /* E9B10 800F9310 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9B14 800F9314 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9B18 800F9318 00000000 */  nop
    /* E9B1C 800F931C 05004018 */  blez       $v0, .L800F9334
    /* E9B20 800F9320 1000A527 */   addiu     $a1, $sp, 0x10
    /* E9B24 800F9324 0580043C */  lui        $a0, %hi(D_800571FC)
    /* E9B28 800F9328 FC718424 */  addiu      $a0, $a0, %lo(D_800571FC)
  .L800F932C:
    /* E9B2C 800F932C 2B0A040C */  jal        printf
    /* E9B30 800F9330 00000000 */   nop
  .L800F9334:
    /* E9B34 800F9334 21100000 */  addu       $v0, $zero, $zero
  .L800F9338:
    /* E9B38 800F9338 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* E9B3C 800F933C 4800B68F */  lw         $s6, 0x48($sp)
    /* E9B40 800F9340 4400B58F */  lw         $s5, 0x44($sp)
    /* E9B44 800F9344 4000B48F */  lw         $s4, 0x40($sp)
    /* E9B48 800F9348 3C00B38F */  lw         $s3, 0x3C($sp)
    /* E9B4C 800F934C 3800B28F */  lw         $s2, 0x38($sp)
    /* E9B50 800F9350 3400B18F */  lw         $s1, 0x34($sp)
    /* E9B54 800F9354 3000B08F */  lw         $s0, 0x30($sp)
    /* E9B58 800F9358 0800E003 */  jr         $ra
    /* E9B5C 800F935C 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel CdSearchFile
