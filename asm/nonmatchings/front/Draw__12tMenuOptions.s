.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__12tMenuOptions, 0x2D8

glabel Draw__12tMenuOptions
    /* C2EC 8001BAEC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C2F0 8001BAF0 2000B2AF */  sw         $s2, 0x20($sp)
    /* C2F4 8001BAF4 21908000 */  addu       $s2, $a0, $zero
    /* C2F8 8001BAF8 3400BFAF */  sw         $ra, 0x34($sp)
    /* C2FC 8001BAFC 3000B6AF */  sw         $s6, 0x30($sp)
    /* C300 8001BB00 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* C304 8001BB04 2800B4AF */  sw         $s4, 0x28($sp)
    /* C308 8001BB08 2400B3AF */  sw         $s3, 0x24($sp)
    /* C30C 8001BB0C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* C310 8001BB10 2596000C */  jal        GetNumberEnabledItems__5tMenu
    /* C314 8001BB14 1800B0AF */   sw        $s0, 0x18($sp)
    /* C318 8001BB18 40011624 */  addiu      $s6, $zero, 0x140
    /* C31C 8001BB1C 6800438E */  lw         $v1, 0x68($s2)
    /* C320 8001BB20 21804000 */  addu       $s0, $v0, $zero
    /* C324 8001BB24 38006484 */  lh         $a0, 0x38($v1)
    /* C328 8001BB28 3C00638C */  lw         $v1, 0x3C($v1)
    /* C32C 8001BB2C 00000000 */  nop
    /* C330 8001BB30 09F86000 */  jalr       $v1
    /* C334 8001BB34 21204402 */   addu      $a0, $s2, $a0
    /* C338 8001BB38 00841000 */  sll        $s0, $s0, 16
    /* C33C 8001BB3C 03841000 */  sra        $s0, $s0, 16
    /* C340 8001BB40 C0101000 */  sll        $v0, $s0, 3
    /* C344 8001BB44 21105000 */  addu       $v0, $v0, $s0
    /* C348 8001BB48 7000438E */  lw         $v1, 0x70($s2)
    /* C34C 8001BB4C 00000000 */  nop
    /* C350 8001BB50 23006010 */  beqz       $v1, .L8001BBE0
    /* C354 8001BB54 40A80200 */   sll       $s5, $v0, 1
    /* C358 8001BB58 1480023C */  lui        $v0, %hi(ticks)
    /* C35C 8001BB5C ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* C360 8001BB60 7C00428E */  lw         $v0, 0x7C($s2)
    /* C364 8001BB64 00000000 */  nop
    /* C368 8001BB68 23186200 */  subu       $v1, $v1, $v0
    /* C36C 8001BB6C 2100622C */  sltiu      $v0, $v1, 0x21
    /* C370 8001BB70 05004014 */  bnez       $v0, .L8001BB88
    /* C374 8001BB74 00000000 */   nop
    /* C378 8001BB78 76004282 */  lb         $v0, 0x76($s2)
    /* C37C 8001BB7C 20000324 */  addiu      $v1, $zero, 0x20
    /* C380 8001BB80 86004004 */  bltz       $v0, .L8001BD9C
    /* C384 8001BB84 700040AE */   sw        $zero, 0x70($s2)
  .L8001BB88:
    /* C388 8001BB88 76004282 */  lb         $v0, 0x76($s2)
    /* C38C 8001BB8C 00000000 */  nop
    /* C390 8001BB90 09004004 */  bltz       $v0, .L8001BBB8
    /* C394 8001BB94 18007600 */   mult      $v1, $s6
    /* C398 8001BB98 12480000 */  mflo       $t1
    /* C39C 8001BB9C 00000000 */  nop
    /* C3A0 8001BBA0 00000000 */  nop
    /* C3A4 8001BBA4 1800A302 */  mult       $s5, $v1
    /* C3A8 8001BBA8 42B10900 */  srl        $s6, $t1, 5
    /* C3AC 8001BBAC 12100000 */  mflo       $v0
    /* C3B0 8001BBB0 FC6E0008 */  j          .L8001BBF0
    /* C3B4 8001BBB4 42A90200 */   srl       $s5, $v0, 5
  .L8001BBB8:
    /* C3B8 8001BBB8 12480000 */  mflo       $t1
    /* C3BC 8001BBBC 00000000 */  nop
    /* C3C0 8001BBC0 00000000 */  nop
    /* C3C4 8001BBC4 1800A302 */  mult       $s5, $v1
    /* C3C8 8001BBC8 42110900 */  srl        $v0, $t1, 5
    /* C3CC 8001BBCC 23B0C202 */  subu       $s6, $s6, $v0
    /* C3D0 8001BBD0 12180000 */  mflo       $v1
    /* C3D4 8001BBD4 42110300 */  srl        $v0, $v1, 5
    /* C3D8 8001BBD8 FC6E0008 */  j          .L8001BBF0
    /* C3DC 8001BBDC 23A8A202 */   subu      $s5, $s5, $v0
  .L8001BBE0:
    /* C3E0 8001BBE0 76004282 */  lb         $v0, 0x76($s2)
    /* C3E4 8001BBE4 00000000 */  nop
    /* C3E8 8001BBE8 6C004004 */  bltz       $v0, .L8001BD9C
    /* C3EC 8001BBEC 00000000 */   nop
  .L8001BBF0:
    /* C3F0 8001BBF0 1200B526 */  addiu      $s5, $s5, 0x12
    /* C3F4 8001BBF4 1480023C */  lui        $v0, %hi(screenwidth)
    /* C3F8 8001BBF8 F0000324 */  addiu      $v1, $zero, 0xF0
    /* C3FC 8001BBFC 23187500 */  subu       $v1, $v1, $s5
    /* C400 8001BC00 43980300 */  sra        $s3, $v1, 1
    /* C404 8001BC04 88DC428C */  lw         $v0, %lo(screenwidth)($v0)
    /* C408 8001BC08 80004486 */  lh         $a0, 0x80($s2)
    /* C40C 8001BC0C 23105600 */  subu       $v0, $v0, $s6
    /* C410 8001BC10 04008014 */  bnez       $a0, .L8001BC24
    /* C414 8001BC14 43A00200 */   sra       $s4, $v0, 1
    /* C418 8001BC18 83100300 */  sra        $v0, $v1, 2
    /* C41C 8001BC1C 0D6F0008 */  j          .L8001BC34
    /* C420 8001BC20 23986202 */   subu      $s3, $s3, $v0
  .L8001BC24:
    /* C424 8001BC24 01000224 */  addiu      $v0, $zero, 0x1
    /* C428 8001BC28 02008214 */  bne        $a0, $v0, .L8001BC34
    /* C42C 8001BC2C 83100300 */   sra       $v0, $v1, 2
    /* C430 8001BC30 21986202 */  addu       $s3, $s3, $v0
  .L8001BC34:
    /* C434 8001BC34 7000428E */  lw         $v0, 0x70($s2)
    /* C438 8001BC38 00000000 */  nop
    /* C43C 8001BC3C 2F004014 */  bnez       $v0, .L8001BCFC
    /* C440 8001BC40 21200000 */   addu      $a0, $zero, $zero
    /* C444 8001BC44 04004486 */  lh         $a0, 0x4($s2)
    /* C448 8001BC48 00000000 */  nop
    /* C44C 8001BC4C 0D008004 */  bltz       $a0, .L8001BC84
    /* C450 8001BC50 43281600 */   sra       $a1, $s6, 1
    /* C454 8001BC54 21288502 */  addu       $a1, $s4, $a1
    /* C458 8001BC58 002C0500 */  sll        $a1, $a1, 16
    /* C45C 8001BC5C 032C0500 */  sra        $a1, $a1, 16
    /* C460 8001BC60 02006626 */  addiu      $a2, $s3, 0x2
    /* C464 8001BC64 00340600 */  sll        $a2, $a2, 16
    /* C468 8001BC68 03340600 */  sra        $a2, $a2, 16
    /* C46C 8001BC6C 02000724 */  addiu      $a3, $zero, 0x2
    /* C470 8001BC70 2110E000 */  addu       $v0, $a3, $zero
    /* C474 8001BC74 1000A2AF */  sw         $v0, 0x10($sp)
    /* C478 8001BC78 09000224 */  addiu      $v0, $zero, 0x9
    /* C47C 8001BC7C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* C480 8001BC80 1400A2AF */   sw        $v0, 0x14($sp)
  .L8001BC84:
    /* C484 8001BC84 12007126 */  addiu      $s1, $s3, 0x12
    /* C488 8001BC88 21800000 */  addu       $s0, $zero, $zero
  .L8001BC8C:
    /* C48C 8001BC8C 00141000 */  sll        $v0, $s0, 16
    /* C490 8001BC90 03240200 */  sra        $a0, $v0, 16
    /* C494 8001BC94 80100400 */  sll        $v0, $a0, 2
    /* C498 8001BC98 21104202 */  addu       $v0, $s2, $v0
    /* C49C 8001BC9C 1000438C */  lw         $v1, 0x10($v0)
    /* C4A0 8001BCA0 00000000 */  nop
    /* C4A4 8001BCA4 14006010 */  beqz       $v1, .L8001BCF8
    /* C4A8 8001BCA8 00000000 */   nop
    /* C4AC 8001BCAC 0000628C */  lw         $v0, 0x0($v1)
    /* C4B0 8001BCB0 00000000 */  nop
    /* C4B4 8001BCB4 01004238 */  xori       $v0, $v0, 0x1
    /* C4B8 8001BCB8 01004230 */  andi       $v0, $v0, 0x1
    /* C4BC 8001BCBC 0C004010 */  beqz       $v0, .L8001BCF0
    /* C4C0 8001BCC0 0A008526 */   addiu     $a1, $s4, 0xA
    /* C4C4 8001BCC4 21302002 */  addu       $a2, $s1, $zero
    /* C4C8 8001BCC8 12003126 */  addiu      $s1, $s1, 0x12
    /* C4CC 8001BCCC 0800478E */  lw         $a3, 0x8($s2)
    /* C4D0 8001BCD0 1800628C */  lw         $v0, 0x18($v1)
    /* C4D4 8001BCD4 26388700 */  xor        $a3, $a0, $a3
    /* C4D8 8001BCD8 0100E72C */  sltiu      $a3, $a3, 0x1
    /* C4DC 8001BCDC 28004484 */  lh         $a0, 0x28($v0)
    /* C4E0 8001BCE0 2C00428C */  lw         $v0, 0x2C($v0)
    /* C4E4 8001BCE4 00000000 */  nop
    /* C4E8 8001BCE8 09F84000 */  jalr       $v0
    /* C4EC 8001BCEC 21206400 */   addu      $a0, $v1, $a0
  .L8001BCF0:
    /* C4F0 8001BCF0 236F0008 */  j          .L8001BC8C
    /* C4F4 8001BCF4 01001026 */   addiu     $s0, $s0, 0x1
  .L8001BCF8:
    /* C4F8 8001BCF8 21200000 */  addu       $a0, $zero, $zero
  .L8001BCFC:
    /* C4FC 8001BCFC 21288002 */  addu       $a1, $s4, $zero
    /* C500 8001BD00 21306002 */  addu       $a2, $s3, $zero
    /* C504 8001BD04 2138C002 */  addu       $a3, $s6, $zero
    /* C508 8001BD08 0C000224 */  addiu      $v0, $zero, 0xC
    /* C50C 8001BD0C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* C510 8001BD10 1000A2AF */   sw        $v0, 0x10($sp)
    /* C514 8001BD14 21200000 */  addu       $a0, $zero, $zero
    /* C518 8001BD18 21288002 */  addu       $a1, $s4, $zero
    /* C51C 8001BD1C 21307502 */  addu       $a2, $s3, $s5
    /* C520 8001BD20 2138C002 */  addu       $a3, $s6, $zero
    /* C524 8001BD24 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* C528 8001BD28 01001024 */  addiu      $s0, $zero, 0x1
    /* C52C 8001BD2C 1000A2AF */  sw         $v0, 0x10($sp)
    /* C530 8001BD30 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* C534 8001BD34 1400B0AF */   sw        $s0, 0x14($sp)
    /* C538 8001BD38 21200000 */  addu       $a0, $zero, $zero
    /* C53C 8001BD3C 21288002 */  addu       $a1, $s4, $zero
    /* C540 8001BD40 0C007226 */  addiu      $s2, $s3, 0xC
    /* C544 8001BD44 21304002 */  addu       $a2, $s2, $zero
    /* C548 8001BD48 04000724 */  addiu      $a3, $zero, 0x4
    /* C54C 8001BD4C F2FFB126 */  addiu      $s1, $s5, -0xE
    /* C550 8001BD50 1000B1AF */  sw         $s1, 0x10($sp)
    /* C554 8001BD54 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* C558 8001BD58 1400B0AF */   sw        $s0, 0x14($sp)
    /* C55C 8001BD5C 21200000 */  addu       $a0, $zero, $zero
    /* C560 8001BD60 21289602 */  addu       $a1, $s4, $s6
    /* C564 8001BD64 21304002 */  addu       $a2, $s2, $zero
    /* C568 8001BD68 FCFF0724 */  addiu      $a3, $zero, -0x4
    /* C56C 8001BD6C 1000B1AF */  sw         $s1, 0x10($sp)
    /* C570 8001BD70 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* C574 8001BD74 1400B0AF */   sw        $s0, 0x14($sp)
    /* C578 8001BD78 21200000 */  addu       $a0, $zero, $zero
    /* C57C 8001BD7C 21288002 */  addu       $a1, $s4, $zero
    /* C580 8001BD80 21306002 */  addu       $a2, $s3, $zero
    /* C584 8001BD84 2138C002 */  addu       $a3, $s6, $zero
    /* C588 8001BD88 1000B5AF */  sw         $s5, 0x10($sp)
    /* C58C 8001BD8C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* C590 8001BD90 1400B0AF */   sw        $s0, 0x14($sp)
    /* C594 8001BD94 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* C598 8001BD98 21200000 */   addu      $a0, $zero, $zero
  .L8001BD9C:
    /* C59C 8001BD9C 3400BF8F */  lw         $ra, 0x34($sp)
    /* C5A0 8001BDA0 3000B68F */  lw         $s6, 0x30($sp)
    /* C5A4 8001BDA4 2C00B58F */  lw         $s5, 0x2C($sp)
    /* C5A8 8001BDA8 2800B48F */  lw         $s4, 0x28($sp)
    /* C5AC 8001BDAC 2400B38F */  lw         $s3, 0x24($sp)
    /* C5B0 8001BDB0 2000B28F */  lw         $s2, 0x20($sp)
    /* C5B4 8001BDB4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* C5B8 8001BDB8 1800B08F */  lw         $s0, 0x18($sp)
    /* C5BC 8001BDBC 0800E003 */  jr         $ra
    /* C5C0 8001BDC0 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Draw__12tMenuOptions
