.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef, 0x198

glabel Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
    /* 99B20 800A9320 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 99B24 800A9324 1800B2AF */  sw         $s2, 0x18($sp)
    /* 99B28 800A9328 21908000 */  addu       $s2, $a0, $zero
    /* 99B2C 800A932C 0E00043C */  lui        $a0, (0xEFFFF >> 16)
    /* 99B30 800A9330 FFFF8434 */  ori        $a0, $a0, (0xEFFFF & 0xFFFF)
    /* 99B34 800A9334 40100500 */  sll        $v0, $a1, 1
    /* 99B38 800A9338 21104500 */  addu       $v0, $v0, $a1
    /* 99B3C 800A933C 40100200 */  sll        $v0, $v0, 1
    /* 99B40 800A9340 0400033C */  lui        $v1, (0x40000 >> 16)
    /* 99B44 800A9344 2000BFAF */  sw         $ra, 0x20($sp)
    /* 99B48 800A9348 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 99B4C 800A934C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 99B50 800A9350 1000B0AF */  sw         $s0, 0x10($sp)
    /* 99B54 800A9354 3000A6AF */  sw         $a2, 0x30($sp)
    /* 99B58 800A9358 3400A7AF */  sw         $a3, 0x34($sp)
    /* 99B5C 800A935C 900142AE */  sw         $v0, 0x190($s2)
    /* 99B60 800A9360 B00D828F */  lw         $v0, %gp_rel(D_8013D2FC)($gp)
    /* 99B64 800A9364 2A208500 */  slt        $a0, $a0, $a1
    /* 99B68 800A9368 940140AE */  sw         $zero, 0x194($s2)
    /* 99B6C 800A936C 25104300 */  or         $v0, $v0, $v1
    /* 99B70 800A9370 07008010 */  beqz       $a0, .L800A9390
    /* 99B74 800A9374 980142AE */   sw        $v0, 0x198($s2)
    /* 99B78 800A9378 1300023C */  lui        $v0, (0x13FFFF >> 16)
    /* 99B7C 800A937C 2004438E */  lw         $v1, 0x420($s2)
    /* 99B80 800A9380 FFFF4234 */  ori        $v0, $v0, (0x13FFFF & 0xFFFF)
    /* 99B84 800A9384 2A104300 */  slt        $v0, $v0, $v1
    /* 99B88 800A9388 44004014 */  bnez       $v0, .L800A949C
    /* 99B8C 800A938C 00000000 */   nop
  .L800A9390:
    /* 99B90 800A9390 3000A48F */  lw         $a0, 0x30($sp)
    /* 99B94 800A9394 DC01458E */  lw         $a1, 0x1DC($s2)
    /* 99B98 800A9398 CA90030C */  jal        fixedmult
    /* 99B9C 800A939C 00000000 */   nop
    /* 99BA0 800A93A0 3400A48F */  lw         $a0, 0x34($sp)
    /* 99BA4 800A93A4 E001458E */  lw         $a1, 0x1E0($s2)
    /* 99BA8 800A93A8 CA90030C */  jal        fixedmult
    /* 99BAC 800A93AC 21804000 */   addu      $s0, $v0, $zero
    /* 99BB0 800A93B0 3800A48F */  lw         $a0, 0x38($sp)
    /* 99BB4 800A93B4 E401458E */  lw         $a1, 0x1E4($s2)
    /* 99BB8 800A93B8 CA90030C */  jal        fixedmult
    /* 99BBC 800A93BC 21884000 */   addu      $s1, $v0, $zero
    /* 99BC0 800A93C0 21801102 */  addu       $s0, $s0, $s1
    /* 99BC4 800A93C4 3000A48F */  lw         $a0, 0x30($sp)
    /* 99BC8 800A93C8 C401458E */  lw         $a1, 0x1C4($s2)
    /* 99BCC 800A93CC CA90030C */  jal        fixedmult
    /* 99BD0 800A93D0 21980202 */   addu      $s3, $s0, $v0
    /* 99BD4 800A93D4 3400A48F */  lw         $a0, 0x34($sp)
    /* 99BD8 800A93D8 C801458E */  lw         $a1, 0x1C8($s2)
    /* 99BDC 800A93DC CA90030C */  jal        fixedmult
    /* 99BE0 800A93E0 21804000 */   addu      $s0, $v0, $zero
    /* 99BE4 800A93E4 3800A48F */  lw         $a0, 0x38($sp)
    /* 99BE8 800A93E8 CC01458E */  lw         $a1, 0x1CC($s2)
    /* 99BEC 800A93EC CA90030C */  jal        fixedmult
    /* 99BF0 800A93F0 21884000 */   addu      $s1, $v0, $zero
    /* 99BF4 800A93F4 21801102 */  addu       $s0, $s0, $s1
    /* 99BF8 800A93F8 21800202 */  addu       $s0, $s0, $v0
    /* 99BFC 800A93FC 02006106 */  bgez       $s3, .L800A9408
    /* 99C00 800A9400 21206002 */   addu      $a0, $s3, $zero
    /* 99C04 800A9404 23200400 */  negu       $a0, $a0
  .L800A9408:
    /* 99C08 800A9408 02000106 */  bgez       $s0, .L800A9414
    /* 99C0C 800A940C 21180002 */   addu      $v1, $s0, $zero
    /* 99C10 800A9410 23180300 */  negu       $v1, $v1
  .L800A9414:
    /* 99C14 800A9414 2A106400 */  slt        $v0, $v1, $a0
    /* 99C18 800A9418 02004010 */  beqz       $v0, .L800A9424
    /* 99C1C 800A941C 43200400 */   sra       $a0, $a0, 1
    /* 99C20 800A9420 43200300 */  sra        $a0, $v1, 1
  .L800A9424:
    /* 99C24 800A9424 05006106 */  bgez       $s3, .L800A943C
    /* 99C28 800A9428 00000000 */   nop
    /* 99C2C 800A942C 08000106 */  bgez       $s0, .L800A9450
    /* 99C30 800A9430 0D00023C */   lui       $v0, (0xD6666 >> 16)
    /* 99C34 800A9434 14A50208 */  j          .L800A9450
    /* 99C38 800A9438 23200400 */   negu      $a0, $a0
  .L800A943C:
    /* 99C3C 800A943C 0200001A */  blez       $s0, .L800A9448
    /* 99C40 800A9440 00000000 */   nop
    /* 99C44 800A9444 23200400 */  negu       $a0, $a0
  .L800A9448:
    /* 99C48 800A9448 43200400 */  sra        $a0, $a0, 1
    /* 99C4C 800A944C 0D00023C */  lui        $v0, (0xD6666 >> 16)
  .L800A9450:
    /* 99C50 800A9450 2004438E */  lw         $v1, 0x420($s2)
    /* 99C54 800A9454 66664234 */  ori        $v0, $v0, (0xD6666 & 0xFFFF)
    /* 99C58 800A9458 2A104300 */  slt        $v0, $v0, $v1
    /* 99C5C 800A945C 0E004010 */  beqz       $v0, .L800A9498
    /* 99C60 800A9460 00000000 */   nop
    /* 99C64 800A9464 05008018 */  blez       $a0, .L800A947C
    /* 99C68 800A9468 00000000 */   nop
    /* 99C6C 800A946C 5004428E */  lw         $v0, 0x450($s2)
    /* 99C70 800A9470 00000000 */  nop
    /* 99C74 800A9474 0700401C */  bgtz       $v0, .L800A9494
    /* 99C78 800A9478 00000000 */   nop
  .L800A947C:
    /* 99C7C 800A947C 06008104 */  bgez       $a0, .L800A9498
    /* 99C80 800A9480 00000000 */   nop
    /* 99C84 800A9484 5004428E */  lw         $v0, 0x450($s2)
    /* 99C88 800A9488 00000000 */  nop
    /* 99C8C 800A948C 02004104 */  bgez       $v0, .L800A9498
    /* 99C90 800A9490 00000000 */   nop
  .L800A9494:
    /* 99C94 800A9494 83200400 */  sra        $a0, $a0, 2
  .L800A9498:
    /* 99C98 800A9498 180144AE */  sw         $a0, 0x118($s2)
  .L800A949C:
    /* 99C9C 800A949C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 99CA0 800A94A0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 99CA4 800A94A4 1800B28F */  lw         $s2, 0x18($sp)
    /* 99CA8 800A94A8 1400B18F */  lw         $s1, 0x14($sp)
    /* 99CAC 800A94AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 99CB0 800A94B0 0800E003 */  jr         $ra
    /* 99CB4 800A94B4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
