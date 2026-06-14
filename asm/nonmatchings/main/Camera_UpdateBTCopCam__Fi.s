.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_UpdateBTCopCam__Fi, 0x128

glabel Camera_UpdateBTCopCam__Fi
    /* 73AB0 800832B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 73AB4 800832B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 73AB8 800832B8 21808000 */  addu       $s0, $a0, $zero
    /* 73ABC 800832BC 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 73AC0 800832C0 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 73AC4 800832C4 00191000 */  sll        $v1, $s0, 4
    /* 73AC8 800832C8 21187000 */  addu       $v1, $v1, $s0
    /* 73ACC 800832CC 00190300 */  sll        $v1, $v1, 4
    /* 73AD0 800832D0 21286200 */  addu       $a1, $v1, $v0
    /* 73AD4 800832D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 73AD8 800832D8 8000A38C */  lw         $v1, 0x80($a1)
    /* 73ADC 800832DC 01000224 */  addiu      $v0, $zero, 0x1
    /* 73AE0 800832E0 15006210 */  beq        $v1, $v0, .L80083338
    /* 73AE4 800832E4 02006228 */   slti      $v0, $v1, 0x2
    /* 73AE8 800832E8 23004014 */  bnez       $v0, .L80083378
    /* 73AEC 800832EC BE000224 */   addiu     $v0, $zero, 0xBE
    /* 73AF0 800832F0 02000224 */  addiu      $v0, $zero, 0x2
    /* 73AF4 800832F4 1F006214 */  bne        $v1, $v0, .L80083374
    /* 73AF8 800832F8 1180033C */   lui       $v1, %hi(Cars_gList)
    /* 73AFC 800832FC DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 73B00 80083300 04105000 */  sllv       $v0, $s0, $v0
    /* 73B04 80083304 21104300 */  addu       $v0, $v0, $v1
    /* 73B08 80083308 0000448C */  lw         $a0, 0x0($v0)
    /* 73B0C 8008330C 8400A280 */  lb         $v0, 0x84($a1)
    /* 73B10 80083310 00000000 */  nop
    /* 73B14 80083314 80100200 */  sll        $v0, $v0, 2
    /* 73B18 80083318 21104300 */  addu       $v0, $v0, $v1
    /* 73B1C 8008331C 0000A4AC */  sw         $a0, 0x0($a1)
    /* 73B20 80083320 0000428C */  lw         $v0, 0x0($v0)
    /* 73B24 80083324 21200002 */  addu       $a0, $s0, $zero
    /* 73B28 80083328 6A0C020C */  jal        Camera_UpdateCopCam2__Fi
    /* 73B2C 8008332C 0400A2AC */   sw        $v0, 0x4($a1)
    /* 73B30 80083330 DE0C0208 */  j          .L80083378
    /* 73B34 80083334 BE000224 */   addiu     $v0, $zero, 0xBE
  .L80083338:
    /* 73B38 80083338 1180033C */  lui        $v1, %hi(Cars_gList)
    /* 73B3C 8008333C 8400A280 */  lb         $v0, 0x84($a1)
    /* 73B40 80083340 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 73B44 80083344 80100200 */  sll        $v0, $v0, 2
    /* 73B48 80083348 21104300 */  addu       $v0, $v0, $v1
    /* 73B4C 8008334C 0000448C */  lw         $a0, 0x0($v0)
    /* 73B50 80083350 8400A280 */  lb         $v0, 0x84($a1)
    /* 73B54 80083354 00000000 */  nop
    /* 73B58 80083358 80100200 */  sll        $v0, $v0, 2
    /* 73B5C 8008335C 21104300 */  addu       $v0, $v0, $v1
    /* 73B60 80083360 0000A4AC */  sw         $a0, 0x0($a1)
    /* 73B64 80083364 0000428C */  lw         $v0, 0x0($v0)
    /* 73B68 80083368 21200002 */  addu       $a0, $s0, $zero
    /* 73B6C 8008336C AE06020C */  jal        Camera_UpdateCircleCam__Fi
    /* 73B70 80083370 0400A2AC */   sw        $v0, 0x4($a1)
  .L80083374:
    /* 73B74 80083374 BE000224 */  addiu      $v0, $zero, 0xBE
  .L80083378:
    /* 73B78 80083378 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 73B7C 8008337C ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 73B80 80083380 00211000 */  sll        $a0, $s0, 4
    /* 73B84 80083384 21209000 */  addu       $a0, $a0, $s0
    /* 73B88 80083388 00210400 */  sll        $a0, $a0, 4
    /* 73B8C 8008338C 900282AF */  sw         $v0, %gp_rel(Camera_gGeomScreen)($gp)
    /* 73B90 80083390 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 73B94 80083394 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 73B98 80083398 21208300 */  addu       $a0, $a0, $v1
    /* 73B9C 8008339C 40014224 */  addiu      $v0, $v0, 0x140
    /* 73BA0 800833A0 880082AC */  sw         $v0, 0x88($a0)
    /* 73BA4 800833A4 7400828C */  lw         $v0, 0x74($a0)
    /* 73BA8 800833A8 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 73BAC 800833AC 24104300 */  and        $v0, $v0, $v1
    /* 73BB0 800833B0 FBFF0324 */  addiu      $v1, $zero, -0x5
    /* 73BB4 800833B4 24104300 */  and        $v0, $v0, $v1
    /* 73BB8 800833B8 38004234 */  ori        $v0, $v0, 0x38
    /* 73BBC 800833BC BFFF0324 */  addiu      $v1, $zero, -0x41
    /* 73BC0 800833C0 24104300 */  and        $v0, $v0, $v1
    /* 73BC4 800833C4 740082AC */  sw         $v0, 0x74($a0)
    /* 73BC8 800833C8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 73BCC 800833CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 73BD0 800833D0 0800E003 */  jr         $ra
    /* 73BD4 800833D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Camera_UpdateBTCopCam__Fi
