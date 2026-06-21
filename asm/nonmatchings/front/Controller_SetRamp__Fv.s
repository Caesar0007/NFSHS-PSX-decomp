.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Controller_SetRamp__Fv, 0x14C

glabel Controller_SetRamp__Fv
    /* 33A50 80043250 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 33A54 80043254 1800B2AF */  sw         $s2, 0x18($sp)
    /* 33A58 80043258 21900000 */  addu       $s2, $zero, $zero
    /* 33A5C 8004325C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 33A60 80043260 2000B4AF */  sw         $s4, 0x20($sp)
    /* 33A64 80043264 00465424 */  addiu      $s4, $v0, %lo(frontEnd)
    /* 33A68 80043268 1280023C */  lui        $v0, %hi(mappings)
    /* 33A6C 8004326C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 33A70 80043270 FC0D5524 */  addiu      $s5, $v0, %lo(mappings)
    /* 33A74 80043274 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 33A78 80043278 01001324 */  addiu      $s3, $zero, 0x1
    /* 33A7C 8004327C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 33A80 80043280 1400B1AF */  sw         $s1, 0x14($sp)
    /* 33A84 80043284 1000B0AF */  sw         $s0, 0x10($sp)
  .L80043288:
    /* 33A88 80043288 00141200 */  sll        $v0, $s2, 16
    /* 33A8C 8004328C 031C0200 */  sra        $v1, $v0, 16
    /* 33A90 80043290 02006228 */  slti       $v0, $v1, 0x2
    /* 33A94 80043294 38004010 */  beqz       $v0, .L80043378
    /* 33A98 80043298 40100300 */   sll       $v0, $v1, 1
    /* 33A9C 8004329C 21105400 */  addu       $v0, $v0, $s4
    /* 33AA0 800432A0 5E034384 */  lh         $v1, 0x35E($v0)
    /* 33AA4 800432A4 23000224 */  addiu      $v0, $zero, 0x23
    /* 33AA8 800432A8 09006210 */  beq        $v1, $v0, .L800432D0
    /* 33AAC 800432AC 53000224 */   addiu     $v0, $zero, 0x53
    /* 33AB0 800432B0 03006210 */  beq        $v1, $v0, .L800432C0
    /* 33AB4 800432B4 73000224 */   addiu     $v0, $zero, 0x73
    /* 33AB8 800432B8 03006214 */  bne        $v1, $v0, .L800432C8
    /* 33ABC 800432BC 00000000 */   nop
  .L800432C0:
    /* 33AC0 800432C0 B50C0108 */  j          .L800432D4
    /* 33AC4 800432C4 01000424 */   addiu     $a0, $zero, 0x1
  .L800432C8:
    /* 33AC8 800432C8 B50C0108 */  j          .L800432D4
    /* 33ACC 800432CC 02000424 */   addiu     $a0, $zero, 0x2
  .L800432D0:
    /* 33AD0 800432D0 21200000 */  addu       $a0, $zero, $zero
  .L800432D4:
    /* 33AD4 800432D4 00141200 */  sll        $v0, $s2, 16
    /* 33AD8 800432D8 03140200 */  sra        $v0, $v0, 16
    /* 33ADC 800432DC 21805400 */  addu       $s0, $v0, $s4
    /* 33AE0 800432E0 62030392 */  lbu        $v1, 0x362($s0)
    /* 33AE4 800432E4 01000224 */  addiu      $v0, $zero, 0x1
    /* 33AE8 800432E8 190302A2 */  sb         $v0, 0x319($s0)
    /* 33AEC 800432EC 1B0302A2 */  sb         $v0, 0x31B($s0)
    /* 33AF0 800432F0 170302A2 */  sb         $v0, 0x317($s0)
    /* 33AF4 800432F4 80100300 */  sll        $v0, $v1, 2
    /* 33AF8 800432F8 21104300 */  addu       $v0, $v0, $v1
    /* 33AFC 800432FC C0100200 */  sll        $v0, $v0, 3
    /* 33B00 80043300 23104300 */  subu       $v0, $v0, $v1
    /* 33B04 80043304 21104400 */  addu       $v0, $v0, $a0
    /* 33B08 80043308 80100200 */  sll        $v0, $v0, 2
    /* 33B0C 8004330C 21885500 */  addu       $s1, $v0, $s5
    /* 33B10 80043310 0000248E */  lw         $a0, 0x0($s1)
    /* 33B14 80043314 659C000C */  jal        GetPSXPadValue__Fii
    /* 33B18 80043318 21280000 */   addu      $a1, $zero, $zero
    /* 33B1C 8004331C 4D73030C */  jal        InGame_GetDevice__Fi
    /* 33B20 80043320 21204000 */   addu      $a0, $v0, $zero
    /* 33B24 80043324 02005314 */  bne        $v0, $s3, .L80043330
    /* 33B28 80043328 00000000 */   nop
    /* 33B2C 8004332C 170300A2 */  sb         $zero, 0x317($s0)
  .L80043330:
    /* 33B30 80043330 1800248E */  lw         $a0, 0x18($s1)
    /* 33B34 80043334 659C000C */  jal        GetPSXPadValue__Fii
    /* 33B38 80043338 21280000 */   addu      $a1, $zero, $zero
    /* 33B3C 8004333C 4D73030C */  jal        InGame_GetDevice__Fi
    /* 33B40 80043340 21204000 */   addu      $a0, $v0, $zero
    /* 33B44 80043344 02005314 */  bne        $v0, $s3, .L80043350
    /* 33B48 80043348 00000000 */   nop
    /* 33B4C 8004334C 190300A2 */  sb         $zero, 0x319($s0)
  .L80043350:
    /* 33B50 80043350 2400248E */  lw         $a0, 0x24($s1)
    /* 33B54 80043354 659C000C */  jal        GetPSXPadValue__Fii
    /* 33B58 80043358 21280000 */   addu      $a1, $zero, $zero
    /* 33B5C 8004335C 4D73030C */  jal        InGame_GetDevice__Fi
    /* 33B60 80043360 21204000 */   addu      $a0, $v0, $zero
    /* 33B64 80043364 02005314 */  bne        $v0, $s3, .L80043370
    /* 33B68 80043368 00000000 */   nop
    /* 33B6C 8004336C 1B0300A2 */  sb         $zero, 0x31B($s0)
  .L80043370:
    /* 33B70 80043370 A20C0108 */  j          .L80043288
    /* 33B74 80043374 01005226 */   addiu     $s2, $s2, 0x1
  .L80043378:
    /* 33B78 80043378 2800BF8F */  lw         $ra, 0x28($sp)
    /* 33B7C 8004337C 2400B58F */  lw         $s5, 0x24($sp)
    /* 33B80 80043380 2000B48F */  lw         $s4, 0x20($sp)
    /* 33B84 80043384 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 33B88 80043388 1800B28F */  lw         $s2, 0x18($sp)
    /* 33B8C 8004338C 1400B18F */  lw         $s1, 0x14($sp)
    /* 33B90 80043390 1000B08F */  lw         $s0, 0x10($sp)
    /* 33B94 80043394 0800E003 */  jr         $ra
    /* 33B98 80043398 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Controller_SetRamp__Fv
