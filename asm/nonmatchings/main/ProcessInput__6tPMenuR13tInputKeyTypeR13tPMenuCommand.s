.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand, 0x274

glabel ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand
    /* 98A9C 800A829C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98AA0 800A82A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98AA4 800A82A4 21808000 */  addu       $s0, $a0, $zero
    /* 98AA8 800A82A8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98AAC 800A82AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 98AB0 800A82B0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98AB4 800A82B4 0000028E */  lw         $v0, 0x0($s0)
    /* 98AB8 800A82B8 2190A000 */  addu       $s2, $a1, $zero
    /* 98ABC 800A82BC 80100200 */  sll        $v0, $v0, 2
    /* 98AC0 800A82C0 21100202 */  addu       $v0, $s0, $v0
    /* 98AC4 800A82C4 0800438C */  lw         $v1, 0x8($v0)
    /* 98AC8 800A82C8 00000000 */  nop
    /* 98ACC 800A82CC 08006010 */  beqz       $v1, .L800A82F0
    /* 98AD0 800A82D0 2188C000 */   addu      $s1, $a2, $zero
    /* 98AD4 800A82D4 0800628C */  lw         $v0, 0x8($v1)
    /* 98AD8 800A82D8 00000000 */  nop
    /* 98ADC 800A82DC 20004484 */  lh         $a0, 0x20($v0)
    /* 98AE0 800A82E0 2400428C */  lw         $v0, 0x24($v0)
    /* 98AE4 800A82E4 00000000 */  nop
    /* 98AE8 800A82E8 09F84000 */  jalr       $v0
    /* 98AEC 800A82EC 21206400 */   addu      $a0, $v1, $a0
  .L800A82F0:
    /* 98AF0 800A82F0 0000438E */  lw         $v1, 0x0($s2)
    /* 98AF4 800A82F4 00020224 */  addiu      $v0, $zero, 0x200
    /* 98AF8 800A82F8 0E006210 */  beq        $v1, $v0, .L800A8334
    /* 98AFC 800A82FC 01026228 */   slti      $v0, $v1, 0x201
    /* 98B00 800A8300 05004010 */  beqz       $v0, .L800A8318
    /* 98B04 800A8304 10000224 */   addiu     $v0, $zero, 0x10
    /* 98B08 800A8308 75006210 */  beq        $v1, $v0, .L800A84E0
    /* 98B0C 800A830C 00000000 */   nop
    /* 98B10 800A8310 3EA10208 */  j          .L800A84F8
    /* 98B14 800A8314 00000000 */   nop
  .L800A8318:
    /* 98B18 800A8318 00040224 */  addiu      $v0, $zero, 0x400
    /* 98B1C 800A831C 3F006210 */  beq        $v1, $v0, .L800A841C
    /* 98B20 800A8320 00200224 */   addiu     $v0, $zero, 0x2000
    /* 98B24 800A8324 69006210 */  beq        $v1, $v0, .L800A84CC
    /* 98B28 800A8328 00000000 */   nop
    /* 98B2C 800A832C 3EA10208 */  j          .L800A84F8
    /* 98B30 800A8330 00000000 */   nop
  .L800A8334:
    /* 98B34 800A8334 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 98B38 800A8338 03000424 */   addiu     $a0, $zero, 0x3
  .L800A833C:
    /* 98B3C 800A833C 0000028E */  lw         $v0, 0x0($s0)
    /* 98B40 800A8340 00000000 */  nop
    /* 98B44 800A8344 04004018 */  blez       $v0, .L800A8358
    /* 98B48 800A8348 00000000 */   nop
    /* 98B4C 800A834C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 98B50 800A8350 E8A00208 */  j          .L800A83A0
    /* 98B54 800A8354 000002AE */   sw        $v0, 0x0($s0)
  .L800A8358:
    /* 98B58 800A8358 01004224 */  addiu      $v0, $v0, 0x1
    /* 98B5C 800A835C 80100200 */  sll        $v0, $v0, 2
    /* 98B60 800A8360 21100202 */  addu       $v0, $s0, $v0
    /* 98B64 800A8364 0800428C */  lw         $v0, 0x8($v0)
    /* 98B68 800A8368 00000000 */  nop
    /* 98B6C 800A836C 0C004010 */  beqz       $v0, .L800A83A0
    /* 98B70 800A8370 00000000 */   nop
  .L800A8374:
    /* 98B74 800A8374 0000028E */  lw         $v0, 0x0($s0)
    /* 98B78 800A8378 00000000 */  nop
    /* 98B7C 800A837C 01004324 */  addiu      $v1, $v0, 0x1
    /* 98B80 800A8380 02004224 */  addiu      $v0, $v0, 0x2
    /* 98B84 800A8384 80100200 */  sll        $v0, $v0, 2
    /* 98B88 800A8388 21100202 */  addu       $v0, $s0, $v0
    /* 98B8C 800A838C 000003AE */  sw         $v1, 0x0($s0)
    /* 98B90 800A8390 0800428C */  lw         $v0, 0x8($v0)
    /* 98B94 800A8394 00000000 */  nop
    /* 98B98 800A8398 F6FF4014 */  bnez       $v0, .L800A8374
    /* 98B9C 800A839C 00000000 */   nop
  .L800A83A0:
    /* 98BA0 800A83A0 0000028E */  lw         $v0, 0x0($s0)
    /* 98BA4 800A83A4 00000000 */  nop
    /* 98BA8 800A83A8 80100200 */  sll        $v0, $v0, 2
    /* 98BAC 800A83AC 21100202 */  addu       $v0, $s0, $v0
    /* 98BB0 800A83B0 0800438C */  lw         $v1, 0x8($v0)
    /* 98BB4 800A83B4 00000000 */  nop
    /* 98BB8 800A83B8 0800628C */  lw         $v0, 0x8($v1)
    /* 98BBC 800A83BC 21880000 */  addu       $s1, $zero, $zero
    /* 98BC0 800A83C0 28004484 */  lh         $a0, 0x28($v0)
    /* 98BC4 800A83C4 2C00428C */  lw         $v0, 0x2C($v0)
    /* 98BC8 800A83C8 00000000 */  nop
    /* 98BCC 800A83CC 09F84000 */  jalr       $v0
    /* 98BD0 800A83D0 21206400 */   addu      $a0, $v1, $a0
    /* 98BD4 800A83D4 0C004010 */  beqz       $v0, .L800A8408
    /* 98BD8 800A83D8 00000000 */   nop
    /* 98BDC 800A83DC 0000028E */  lw         $v0, 0x0($s0)
    /* 98BE0 800A83E0 00000000 */  nop
    /* 98BE4 800A83E4 80100200 */  sll        $v0, $v0, 2
    /* 98BE8 800A83E8 21100202 */  addu       $v0, $s0, $v0
    /* 98BEC 800A83EC 0800428C */  lw         $v0, 0x8($v0)
    /* 98BF0 800A83F0 00000000 */  nop
    /* 98BF4 800A83F4 0000428C */  lw         $v0, 0x0($v0)
    /* 98BF8 800A83F8 00000000 */  nop
    /* 98BFC 800A83FC 01004230 */  andi       $v0, $v0, 0x1
    /* 98C00 800A8400 02004010 */  beqz       $v0, .L800A840C
    /* 98C04 800A8404 00000000 */   nop
  .L800A8408:
    /* 98C08 800A8408 01001124 */  addiu      $s1, $zero, 0x1
  .L800A840C:
    /* 98C0C 800A840C CBFF2016 */  bnez       $s1, .L800A833C
    /* 98C10 800A8410 01000224 */   addiu     $v0, $zero, 0x1
    /* 98C14 800A8414 3EA10208 */  j          .L800A84F8
    /* 98C18 800A8418 000042AE */   sw        $v0, 0x0($s2)
  .L800A841C:
    /* 98C1C 800A841C B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 98C20 800A8420 03000424 */   addiu     $a0, $zero, 0x3
  .L800A8424:
    /* 98C24 800A8424 0000028E */  lw         $v0, 0x0($s0)
    /* 98C28 800A8428 00000000 */  nop
    /* 98C2C 800A842C 01004224 */  addiu      $v0, $v0, 0x1
    /* 98C30 800A8430 000002AE */  sw         $v0, 0x0($s0)
    /* 98C34 800A8434 80100200 */  sll        $v0, $v0, 2
    /* 98C38 800A8438 21100202 */  addu       $v0, $s0, $v0
    /* 98C3C 800A843C 0800428C */  lw         $v0, 0x8($v0)
    /* 98C40 800A8440 00000000 */  nop
    /* 98C44 800A8444 02004014 */  bnez       $v0, .L800A8450
    /* 98C48 800A8448 00000000 */   nop
    /* 98C4C 800A844C 000000AE */  sw         $zero, 0x0($s0)
  .L800A8450:
    /* 98C50 800A8450 0000028E */  lw         $v0, 0x0($s0)
    /* 98C54 800A8454 00000000 */  nop
    /* 98C58 800A8458 80100200 */  sll        $v0, $v0, 2
    /* 98C5C 800A845C 21100202 */  addu       $v0, $s0, $v0
    /* 98C60 800A8460 0800438C */  lw         $v1, 0x8($v0)
    /* 98C64 800A8464 00000000 */  nop
    /* 98C68 800A8468 0800628C */  lw         $v0, 0x8($v1)
    /* 98C6C 800A846C 21880000 */  addu       $s1, $zero, $zero
    /* 98C70 800A8470 28004484 */  lh         $a0, 0x28($v0)
    /* 98C74 800A8474 2C00428C */  lw         $v0, 0x2C($v0)
    /* 98C78 800A8478 00000000 */  nop
    /* 98C7C 800A847C 09F84000 */  jalr       $v0
    /* 98C80 800A8480 21206400 */   addu      $a0, $v1, $a0
    /* 98C84 800A8484 0C004010 */  beqz       $v0, .L800A84B8
    /* 98C88 800A8488 00000000 */   nop
    /* 98C8C 800A848C 0000028E */  lw         $v0, 0x0($s0)
    /* 98C90 800A8490 00000000 */  nop
    /* 98C94 800A8494 80100200 */  sll        $v0, $v0, 2
    /* 98C98 800A8498 21100202 */  addu       $v0, $s0, $v0
    /* 98C9C 800A849C 0800428C */  lw         $v0, 0x8($v0)
    /* 98CA0 800A84A0 00000000 */  nop
    /* 98CA4 800A84A4 0000428C */  lw         $v0, 0x0($v0)
    /* 98CA8 800A84A8 00000000 */  nop
    /* 98CAC 800A84AC 01004230 */  andi       $v0, $v0, 0x1
    /* 98CB0 800A84B0 02004010 */  beqz       $v0, .L800A84BC
    /* 98CB4 800A84B4 00000000 */   nop
  .L800A84B8:
    /* 98CB8 800A84B8 01001124 */  addiu      $s1, $zero, 0x1
  .L800A84BC:
    /* 98CBC 800A84BC D9FF2016 */  bnez       $s1, .L800A8424
    /* 98CC0 800A84C0 01000224 */   addiu     $v0, $zero, 0x1
    /* 98CC4 800A84C4 3EA10208 */  j          .L800A84F8
    /* 98CC8 800A84C8 000042AE */   sw        $v0, 0x0($s2)
  .L800A84CC:
    /* 98CCC 800A84CC B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 98CD0 800A84D0 04000424 */   addiu     $a0, $zero, 0x4
    /* 98CD4 800A84D4 01000224 */  addiu      $v0, $zero, 0x1
    /* 98CD8 800A84D8 3DA10208 */  j          .L800A84F4
    /* 98CDC 800A84DC 000022AE */   sw        $v0, 0x0($s1)
  .L800A84E0:
    /* 98CE0 800A84E0 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 98CE4 800A84E4 04000424 */   addiu     $a0, $zero, 0x4
    /* 98CE8 800A84E8 07000224 */  addiu      $v0, $zero, 0x7
    /* 98CEC 800A84EC 000022AE */  sw         $v0, 0x0($s1)
    /* 98CF0 800A84F0 01000224 */  addiu      $v0, $zero, 0x1
  .L800A84F4:
    /* 98CF4 800A84F4 000042AE */  sw         $v0, 0x0($s2)
  .L800A84F8:
    /* 98CF8 800A84F8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 98CFC 800A84FC 1800B28F */  lw         $s2, 0x18($sp)
    /* 98D00 800A8500 1400B18F */  lw         $s1, 0x14($sp)
    /* 98D04 800A8504 1000B08F */  lw         $s0, 0x10($sp)
    /* 98D08 800A8508 0800E003 */  jr         $ra
    /* 98D0C 800A850C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand
