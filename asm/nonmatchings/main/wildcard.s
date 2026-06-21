.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching wildcard, 0x258

glabel wildcard
    /* D91BC 800E89BC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D91C0 800E89C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* D91C4 800E89C4 21888000 */  addu       $s1, $a0, $zero
    /* D91C8 800E89C8 1800B2AF */  sw         $s2, 0x18($sp)
    /* D91CC 800E89CC 2190A000 */  addu       $s2, $a1, $zero
    /* D91D0 800E89D0 21204002 */  addu       $a0, $s2, $zero
    /* D91D4 800E89D4 1480053C */  lui        $a1, %hi(D_8013DC48)
    /* D91D8 800E89D8 48DCA524 */  addiu      $a1, $a1, %lo(D_8013DC48)
    /* D91DC 800E89DC 2400BFAF */  sw         $ra, 0x24($sp)
    /* D91E0 800E89E0 2000B4AF */  sw         $s4, 0x20($sp)
    /* D91E4 800E89E4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D91E8 800E89E8 50A2030C */  jal        strrstr
    /* D91EC 800E89EC 1000B0AF */   sw        $s0, 0x10($sp)
    /* D91F0 800E89F0 21984000 */  addu       $s3, $v0, $zero
    /* D91F4 800E89F4 47006012 */  beqz       $s3, .L800E8B14
    /* D91F8 800E89F8 26000224 */   addiu     $v0, $zero, 0x26
    /* D91FC 800E89FC 00007492 */  lbu        $s4, 0x0($s3)
    /* D9200 800E8A00 00000000 */  nop
    /* D9204 800E8A04 0E008216 */  bne        $s4, $v0, .L800E8A40
    /* D9208 800E8A08 7C000224 */   addiu     $v0, $zero, 0x7C
    /* D920C 800E8A0C 000060A2 */  sb         $zero, 0x0($s3)
    /* D9210 800E8A10 21800000 */  addu       $s0, $zero, $zero
    /* D9214 800E8A14 21202002 */  addu       $a0, $s1, $zero
    /* D9218 800E8A18 6FA2030C */  jal        wildcard
    /* D921C 800E8A1C 21284002 */   addu      $a1, $s2, $zero
    /* D9220 800E8A20 04004010 */  beqz       $v0, .L800E8A34
    /* D9224 800E8A24 21202002 */   addu      $a0, $s1, $zero
    /* D9228 800E8A28 6FA2030C */  jal        wildcard
    /* D922C 800E8A2C 01006526 */   addiu     $a1, $s3, 0x1
    /* D9230 800E8A30 2B800200 */  sltu       $s0, $zero, $v0
  .L800E8A34:
    /* D9234 800E8A34 000074A2 */  sb         $s4, 0x0($s3)
    /* D9238 800E8A38 FDA20308 */  j          .L800E8BF4
    /* D923C 800E8A3C 21100002 */   addu      $v0, $s0, $zero
  .L800E8A40:
    /* D9240 800E8A40 0F008216 */  bne        $s4, $v0, .L800E8A80
    /* D9244 800E8A44 21000224 */   addiu     $v0, $zero, 0x21
    /* D9248 800E8A48 000060A2 */  sb         $zero, 0x0($s3)
    /* D924C 800E8A4C 21800000 */  addu       $s0, $zero, $zero
    /* D9250 800E8A50 21202002 */  addu       $a0, $s1, $zero
    /* D9254 800E8A54 6FA2030C */  jal        wildcard
    /* D9258 800E8A58 21284002 */   addu      $a1, $s2, $zero
    /* D925C 800E8A5C 05004014 */  bnez       $v0, .L800E8A74
    /* D9260 800E8A60 21202002 */   addu      $a0, $s1, $zero
    /* D9264 800E8A64 6FA2030C */  jal        wildcard
    /* D9268 800E8A68 01006526 */   addiu     $a1, $s3, 0x1
    /* D926C 800E8A6C 02004010 */  beqz       $v0, .L800E8A78
    /* D9270 800E8A70 00000000 */   nop
  .L800E8A74:
    /* D9274 800E8A74 01001024 */  addiu      $s0, $zero, 0x1
  .L800E8A78:
    /* D9278 800E8A78 B1A20308 */  j          .L800E8AC4
    /* D927C 800E8A7C 7C000224 */   addiu     $v0, $zero, 0x7C
  .L800E8A80:
    /* D9280 800E8A80 03008212 */  beq        $s4, $v0, .L800E8A90
    /* D9284 800E8A84 7E000224 */   addiu     $v0, $zero, 0x7E
    /* D9288 800E8A88 11008216 */  bne        $s4, $v0, .L800E8AD0
    /* D928C 800E8A8C 5E000224 */   addiu     $v0, $zero, 0x5E
  .L800E8A90:
    /* D9290 800E8A90 000060A2 */  sb         $zero, 0x0($s3)
    /* D9294 800E8A94 21800000 */  addu       $s0, $zero, $zero
    /* D9298 800E8A98 21202002 */  addu       $a0, $s1, $zero
    /* D929C 800E8A9C 6FA2030C */  jal        wildcard
    /* D92A0 800E8AA0 21284002 */   addu      $a1, $s2, $zero
    /* D92A4 800E8AA4 05004014 */  bnez       $v0, .L800E8ABC
    /* D92A8 800E8AA8 21202002 */   addu      $a0, $s1, $zero
    /* D92AC 800E8AAC 6FA2030C */  jal        wildcard
    /* D92B0 800E8AB0 01006526 */   addiu     $a1, $s3, 0x1
    /* D92B4 800E8AB4 02004010 */  beqz       $v0, .L800E8AC0
    /* D92B8 800E8AB8 00000000 */   nop
  .L800E8ABC:
    /* D92BC 800E8ABC 01001024 */  addiu      $s0, $zero, 0x1
  .L800E8AC0:
    /* D92C0 800E8AC0 21000224 */  addiu      $v0, $zero, 0x21
  .L800E8AC4:
    /* D92C4 800E8AC4 000062A2 */  sb         $v0, 0x0($s3)
    /* D92C8 800E8AC8 FDA20308 */  j          .L800E8BF4
    /* D92CC 800E8ACC 21100002 */   addu      $v0, $s0, $zero
  .L800E8AD0:
    /* D92D0 800E8AD0 11008216 */  bne        $s4, $v0, .L800E8B18
    /* D92D4 800E8AD4 1380023C */   lui       $v0, %hi(_ctype_ + 0x1)
    /* D92D8 800E8AD8 21202002 */  addu       $a0, $s1, $zero
    /* D92DC 800E8ADC 21284002 */  addu       $a1, $s2, $zero
    /* D92E0 800E8AE0 6FA2030C */  jal        wildcard
    /* D92E4 800E8AE4 000060A2 */   sb        $zero, 0x0($s3)
    /* D92E8 800E8AE8 21202002 */  addu       $a0, $s1, $zero
    /* D92EC 800E8AEC 01006526 */  addiu      $a1, $s3, 0x1
    /* D92F0 800E8AF0 6FA2030C */  jal        wildcard
    /* D92F4 800E8AF4 21804000 */   addu      $s0, $v0, $zero
    /* D92F8 800E8AF8 26100202 */  xor        $v0, $s0, $v0
    /* D92FC 800E8AFC FDA20308 */  j          .L800E8BF4
    /* D9300 800E8B00 000074A2 */   sb        $s4, 0x0($s3)
  .L800E8B04:
    /* D9304 800E8B04 6FA2030C */  jal        wildcard
    /* D9308 800E8B08 01004526 */   addiu     $a1, $s2, 0x1
    /* D930C 800E8B0C FDA20308 */  j          .L800E8BF4
    /* D9310 800E8B10 0100422C */   sltiu     $v0, $v0, 0x1
  .L800E8B14:
    /* D9314 800E8B14 1380023C */  lui        $v0, %hi(_ctype_ + 0x1)
  .L800E8B18:
    /* D9318 800E8B18 D1715324 */  addiu      $s3, $v0, %lo(_ctype_ + 0x1)
  .L800E8B1C:
    /* D931C 800E8B1C 00004392 */  lbu        $v1, 0x0($s2)
    /* D9320 800E8B20 2A000224 */  addiu      $v0, $zero, 0x2A
    /* D9324 800E8B24 0D006214 */  bne        $v1, $v0, .L800E8B5C
    /* D9328 800E8B28 3F000224 */   addiu     $v0, $zero, 0x3F
    /* D932C 800E8B2C 01005226 */  addiu      $s2, $s2, 0x1
  .L800E8B30:
    /* D9330 800E8B30 21202002 */  addu       $a0, $s1, $zero
    /* D9334 800E8B34 6FA2030C */  jal        wildcard
    /* D9338 800E8B38 21284002 */   addu      $a1, $s2, $zero
    /* D933C 800E8B3C 2D004014 */  bnez       $v0, .L800E8BF4
    /* D9340 800E8B40 01000224 */   addiu     $v0, $zero, 0x1
    /* D9344 800E8B44 00002292 */  lbu        $v0, 0x0($s1)
    /* D9348 800E8B48 00000000 */  nop
    /* D934C 800E8B4C F8FF4014 */  bnez       $v0, .L800E8B30
    /* D9350 800E8B50 01003126 */   addiu     $s1, $s1, 0x1
    /* D9354 800E8B54 FDA20308 */  j          .L800E8BF4
    /* D9358 800E8B58 21100000 */   addu      $v0, $zero, $zero
  .L800E8B5C:
    /* D935C 800E8B5C 04006214 */  bne        $v1, $v0, .L800E8B70
    /* D9360 800E8B60 23000224 */   addiu     $v0, $zero, 0x23
    /* D9364 800E8B64 00002292 */  lbu        $v0, 0x0($s1)
    /* D9368 800E8B68 E4A20308 */  j          .L800E8B90
    /* D936C 800E8B6C 01005226 */   addiu     $s2, $s2, 0x1
  .L800E8B70:
    /* D9370 800E8B70 0B006214 */  bne        $v1, $v0, .L800E8BA0
    /* D9374 800E8B74 7E000224 */   addiu     $v0, $zero, 0x7E
    /* D9378 800E8B78 00002292 */  lbu        $v0, 0x0($s1)
    /* D937C 800E8B7C 00000000 */  nop
    /* D9380 800E8B80 21105300 */  addu       $v0, $v0, $s3
    /* D9384 800E8B84 00004290 */  lbu        $v0, 0x0($v0)
    /* D9388 800E8B88 01005226 */  addiu      $s2, $s2, 0x1
    /* D938C 800E8B8C 04004230 */  andi       $v0, $v0, 0x4
  .L800E8B90:
    /* D9390 800E8B90 17004010 */  beqz       $v0, .L800E8BF0
    /* D9394 800E8B94 01003126 */   addiu     $s1, $s1, 0x1
    /* D9398 800E8B98 C7A20308 */  j          .L800E8B1C
    /* D939C 800E8B9C 00000000 */   nop
  .L800E8BA0:
    /* D93A0 800E8BA0 D8FF6210 */  beq        $v1, $v0, .L800E8B04
    /* D93A4 800E8BA4 21202002 */   addu      $a0, $s1, $zero
    /* D93A8 800E8BA8 00004492 */  lbu        $a0, 0x0($s2)
    /* D93AC 800E8BAC 680D040C */  jal        tolower
    /* D93B0 800E8BB0 00000000 */   nop
    /* D93B4 800E8BB4 00002492 */  lbu        $a0, 0x0($s1)
    /* D93B8 800E8BB8 680D040C */  jal        tolower
    /* D93BC 800E8BBC 21804000 */   addu      $s0, $v0, $zero
    /* D93C0 800E8BC0 FF001032 */  andi       $s0, $s0, 0xFF
    /* D93C4 800E8BC4 FF004230 */  andi       $v0, $v0, 0xFF
    /* D93C8 800E8BC8 0A000216 */  bne        $s0, $v0, .L800E8BF4
    /* D93CC 800E8BCC 21100000 */   addu      $v0, $zero, $zero
    /* D93D0 800E8BD0 00004292 */  lbu        $v0, 0x0($s2)
    /* D93D4 800E8BD4 00000000 */  nop
    /* D93D8 800E8BD8 03004010 */  beqz       $v0, .L800E8BE8
    /* D93DC 800E8BDC 01005226 */   addiu     $s2, $s2, 0x1
    /* D93E0 800E8BE0 C7A20308 */  j          .L800E8B1C
    /* D93E4 800E8BE4 01003126 */   addiu     $s1, $s1, 0x1
  .L800E8BE8:
    /* D93E8 800E8BE8 FDA20308 */  j          .L800E8BF4
    /* D93EC 800E8BEC 01000224 */   addiu     $v0, $zero, 0x1
  .L800E8BF0:
    /* D93F0 800E8BF0 21100000 */  addu       $v0, $zero, $zero
  .L800E8BF4:
    /* D93F4 800E8BF4 2400BF8F */  lw         $ra, 0x24($sp)
    /* D93F8 800E8BF8 2000B48F */  lw         $s4, 0x20($sp)
    /* D93FC 800E8BFC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D9400 800E8C00 1800B28F */  lw         $s2, 0x18($sp)
    /* D9404 800E8C04 1400B18F */  lw         $s1, 0x14($sp)
    /* D9408 800E8C08 1000B08F */  lw         $s0, 0x10($sp)
    /* D940C 800E8C0C 0800E003 */  jr         $ra
    /* D9410 800E8C10 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel wildcard
