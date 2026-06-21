.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__14tScreenMemcard, 0x9C

glabel DrawForeground__14tScreenMemcard
    /* 382D8 80047AD8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 382DC 80047ADC 2800BFAF */  sw         $ra, 0x28($sp)
    /* 382E0 80047AE0 2400B1AF */  sw         $s1, 0x24($sp)
    /* 382E4 80047AE4 2000B0AF */  sw         $s0, 0x20($sp)
    /* 382E8 80047AE8 5C008294 */  lhu        $v0, 0x5C($a0)
    /* 382EC 80047AEC 00000000 */  nop
    /* 382F0 80047AF0 40100200 */  sll        $v0, $v0, 1
    /* 382F4 80047AF4 80FF4424 */  addiu      $a0, $v0, -0x80
    /* 382F8 80047AF8 00140400 */  sll        $v0, $a0, 16
    /* 382FC 80047AFC 031C0200 */  sra        $v1, $v0, 16
    /* 38300 80047B00 80006228 */  slti       $v0, $v1, 0x80
    /* 38304 80047B04 03004010 */  beqz       $v0, .L80047B14
    /* 38308 80047B08 81006228 */   slti      $v0, $v1, 0x81
    /* 3830C 80047B0C 05006018 */  blez       $v1, .L80047B24
    /* 38310 80047B10 21800000 */   addu      $s0, $zero, $zero
  .L80047B14:
    /* 38314 80047B14 04004014 */  bnez       $v0, .L80047B28
    /* 38318 80047B18 21800000 */   addu      $s0, $zero, $zero
    /* 3831C 80047B1C CA1E0108 */  j          .L80047B28
    /* 38320 80047B20 80000424 */   addiu     $a0, $zero, 0x80
  .L80047B24:
    /* 38324 80047B24 21200000 */  addu       $a0, $zero, $zero
  .L80047B28:
    /* 38328 80047B28 00140400 */  sll        $v0, $a0, 16
    /* 3832C 80047B2C 038C0200 */  sra        $s1, $v0, 16
    /* 38330 80047B30 38000426 */  addiu      $a0, $s0, 0x38
  .L80047B34:
    /* 38334 80047B34 21280000 */  addu       $a1, $zero, $zero
    /* 38338 80047B38 2130A000 */  addu       $a2, $a1, $zero
    /* 3833C 80047B3C 2138A000 */  addu       $a3, $a1, $zero
    /* 38340 80047B40 1000B1AF */  sw         $s1, 0x10($sp)
    /* 38344 80047B44 1400A0AF */  sw         $zero, 0x14($sp)
    /* 38348 80047B48 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3834C 80047B4C 1800A0AF */   sw        $zero, 0x18($sp)
    /* 38350 80047B50 01001026 */  addiu      $s0, $s0, 0x1
    /* 38354 80047B54 0400022A */  slti       $v0, $s0, 0x4
    /* 38358 80047B58 F6FF4014 */  bnez       $v0, .L80047B34
    /* 3835C 80047B5C 38000426 */   addiu     $a0, $s0, 0x38
    /* 38360 80047B60 2800BF8F */  lw         $ra, 0x28($sp)
    /* 38364 80047B64 2400B18F */  lw         $s1, 0x24($sp)
    /* 38368 80047B68 2000B08F */  lw         $s0, 0x20($sp)
    /* 3836C 80047B6C 0800E003 */  jr         $ra
    /* 38370 80047B70 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawForeground__14tScreenMemcard
