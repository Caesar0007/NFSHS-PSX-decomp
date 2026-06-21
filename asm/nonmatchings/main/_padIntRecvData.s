.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padIntRecvData, 0x37C

glabel _padIntRecvData
    /* FCB14 8010C314 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FCB18 8010C318 1400B1AF */  sw         $s1, 0x14($sp)
    /* FCB1C 8010C31C 21888000 */  addu       $s1, $a0, $zero
    /* FCB20 8010C320 1380023C */  lui        $v0, %hi(_padFuncCurrLimit)
    /* FCB24 8010C324 847C428C */  lw         $v0, %lo(_padFuncCurrLimit)($v0)
    /* FCB28 8010C328 2800BFAF */  sw         $ra, 0x28($sp)
    /* FCB2C 8010C32C 2400B5AF */  sw         $s5, 0x24($sp)
    /* FCB30 8010C330 2000B4AF */  sw         $s4, 0x20($sp)
    /* FCB34 8010C334 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FCB38 8010C338 1800B2AF */  sw         $s2, 0x18($sp)
    /* FCB3C 8010C33C 09F84000 */  jalr       $v0
    /* FCB40 8010C340 1000B0AF */   sw        $s0, 0x10($sp)
    /* FCB44 8010C344 1380023C */  lui        $v0, %hi(_padModeMtap)
    /* FCB48 8010C348 C47C428C */  lw         $v0, %lo(_padModeMtap)($v0)
    /* FCB4C 8010C34C 00000000 */  nop
    /* FCB50 8010C350 0B004010 */  beqz       $v0, .L8010C380
    /* FCB54 8010C354 21A00000 */   addu      $s4, $zero, $zero
    /* FCB58 8010C358 3C00228E */  lw         $v0, 0x3C($s1)
    /* FCB5C 8010C35C 00000000 */  nop
    /* FCB60 8010C360 00004290 */  lbu        $v0, 0x0($v0)
    /* FCB64 8010C364 08000324 */  addiu      $v1, $zero, 0x8
    /* FCB68 8010C368 03110200 */  sra        $v0, $v0, 4
    /* FCB6C 8010C36C 04004314 */  bne        $v0, $v1, .L8010C380
    /* FCB70 8010C370 00000000 */   nop
    /* FCB74 8010C374 36002292 */  lbu        $v0, 0x36($s1)
    /* FCB78 8010C378 00000000 */  nop
    /* FCB7C 8010C37C 0100542C */  sltiu      $s4, $v0, 0x1
  .L8010C380:
    /* FCB80 8010C380 26008012 */  beqz       $s4, .L8010C41C
    /* FCB84 8010C384 00000000 */   nop
    /* FCB88 8010C388 FFFF1024 */  addiu      $s0, $zero, -0x1
    /* FCB8C 8010C38C 10FF1224 */  addiu      $s2, $zero, -0xF0
  .L8010C390:
    /* FCB90 8010C390 1480023C */  lui        $v0, %hi(D_8013C308)
    /* FCB94 8010C394 08C3428C */  lw         $v0, %lo(D_8013C308)($v0)
    /* FCB98 8010C398 00000000 */  nop
    /* FCB9C 8010C39C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FCBA0 8010C3A0 1480013C */  lui        $at, %hi(D_8013C308)
    /* FCBA4 8010C3A4 1D004018 */  blez       $v0, .L8010C41C
    /* FCBA8 8010C3A8 08C322AC */   sw        $v0, %lo(D_8013C308)($at)
    /* FCBAC 8010C3AC 07000006 */  bltz       $s0, .L8010C3CC
    /* FCBB0 8010C3B0 00000000 */   nop
    /* FCBB4 8010C3B4 0C00248E */  lw         $a0, 0xC($s1)
    /* FCBB8 8010C3B8 1380023C */  lui        $v0, %hi(_padFuncCurrLimit)
    /* FCBBC 8010C3BC 847C428C */  lw         $v0, %lo(_padFuncCurrLimit)($v0)
    /* FCBC0 8010C3C0 00000000 */  nop
    /* FCBC4 8010C3C4 09F84000 */  jalr       $v0
    /* FCBC8 8010C3C8 21209200 */   addu      $a0, $a0, $s2
  .L8010C3CC:
    /* FCBCC 8010C3CC 21202002 */  addu       $a0, $s1, $zero
    /* FCBD0 8010C3D0 1380023C */  lui        $v0, %hi(_padFuncGetTxd)
    /* FCBD4 8010C3D4 807C428C */  lw         $v0, %lo(_padFuncGetTxd)($v0)
    /* FCBD8 8010C3D8 00000000 */  nop
    /* FCBDC 8010C3DC 09F84000 */  jalr       $v0
    /* FCBE0 8010C3E0 01000524 */   addiu     $a1, $zero, 0x1
    /* FCBE4 8010C3E4 21202002 */  addu       $a0, $s1, $zero
    /* FCBE8 8010C3E8 C014040C */  jal        _padSioRW2
    /* FCBEC 8010C3EC FF004530 */   andi      $a1, $v0, 0xFF
    /* FCBF0 8010C3F0 9E004004 */  bltz       $v0, .L8010C66C
    /* FCBF4 8010C3F4 00000000 */   nop
    /* FCBF8 8010C3F8 FA2F040C */  jal        setRC2wait
    /* FCBFC 8010C3FC 3C000424 */   addiu     $a0, $zero, 0x3C
    /* FCC00 8010C400 4E15040C */  jal        _padClrIntSio0
    /* FCC04 8010C404 00000000 */   nop
    /* FCC08 8010C408 61004010 */  beqz       $v0, .L8010C590
    /* FCC0C 8010C40C 01001026 */   addiu     $s0, $s0, 0x1
    /* FCC10 8010C410 0400022A */  slti       $v0, $s0, 0x4
    /* FCC14 8010C414 DEFF4014 */  bnez       $v0, .L8010C390
    /* FCC18 8010C418 F0005226 */   addiu     $s2, $s2, 0xF0
  .L8010C41C:
    /* FCC1C 8010C41C 1380033C */  lui        $v1, %hi(_padSioChan)
    /* FCC20 8010C420 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* FCC24 8010C424 1480023C */  lui        $v0, %hi(D_8013C308)
    /* FCC28 8010C428 08C3428C */  lw         $v0, %lo(D_8013C308)($v0)
    /* FCC2C 8010C42C 00000000 */  nop
    /* FCC30 8010C430 02004228 */  slti       $v0, $v0, 0x2
    /* FCC34 8010C434 74004014 */  bnez       $v0, .L8010C608
    /* FCC38 8010C438 0100642C */   sltiu     $a0, $v1, 0x1
    /* FCC3C 8010C43C 1380033C */  lui        $v1, %hi(_padFixResult)
    /* FCC40 8010C440 D07C6324 */  addiu      $v1, $v1, %lo(_padFixResult)
    /* FCC44 8010C444 80100400 */  sll        $v0, $a0, 2
    /* FCC48 8010C448 21804300 */  addu       $s0, $v0, $v1
    /* FCC4C 8010C44C 00110400 */  sll        $v0, $a0, 4
    /* FCC50 8010C450 23104400 */  subu       $v0, $v0, $a0
    /* FCC54 8010C454 00910200 */  sll        $s2, $v0, 4
    /* FCC58 8010C458 03001524 */  addiu      $s5, $zero, 0x3
  .L8010C45C:
    /* FCC5C 8010C45C 0000048E */  lw         $a0, 0x0($s0)
    /* FCC60 8010C460 00000000 */  nop
    /* FCC64 8010C464 68008004 */  bltz       $a0, .L8010C608
    /* FCC68 8010C468 00000000 */   nop
    /* FCC6C 8010C46C 0E008018 */  blez       $a0, .L8010C4A8
    /* FCC70 8010C470 00110400 */   sll       $v0, $a0, 4
    /* FCC74 8010C474 1380033C */  lui        $v1, %hi(_padInfoDir)
    /* FCC78 8010C478 AC7C638C */  lw         $v1, %lo(_padInfoDir)($v1)
    /* FCC7C 8010C47C 23104400 */  subu       $v0, $v0, $a0
    /* FCC80 8010C480 21184302 */  addu       $v1, $s2, $v1
    /* FCC84 8010C484 0C00638C */  lw         $v1, 0xC($v1)
    /* FCC88 8010C488 00110200 */  sll        $v0, $v0, 4
    /* FCC8C 8010C48C 21186200 */  addu       $v1, $v1, $v0
    /* FCC90 8010C490 10FF7324 */  addiu      $s3, $v1, -0xF0
    /* FCC94 8010C494 1380023C */  lui        $v0, %hi(_padFuncRecvAuto)
    /* FCC98 8010C498 987C428C */  lw         $v0, %lo(_padFuncRecvAuto)($v0)
    /* FCC9C 8010C49C 00000000 */  nop
    /* FCCA0 8010C4A0 09F84000 */  jalr       $v0
    /* FCCA4 8010C4A4 21206002 */   addu      $a0, $s3, $zero
  .L8010C4A8:
    /* FCCA8 8010C4A8 0000038E */  lw         $v1, 0x0($s0)
    /* FCCAC 8010C4AC 00000000 */  nop
    /* FCCB0 8010C4B0 0F007510 */  beq        $v1, $s5, .L8010C4F0
    /* FCCB4 8010C4B4 00000000 */   nop
    /* FCCB8 8010C4B8 04006228 */  slti       $v0, $v1, 0x4
    /* FCCBC 8010C4BC 07004010 */  beqz       $v0, .L8010C4DC
    /* FCCC0 8010C4C0 02006228 */   slti      $v0, $v1, 0x2
    /* FCCC4 8010C4C4 22004010 */  beqz       $v0, .L8010C550
    /* FCCC8 8010C4C8 21202002 */   addu      $a0, $s1, $zero
    /* FCCCC 8010C4CC 20006004 */  bltz       $v1, .L8010C550
    /* FCCD0 8010C4D0 00000000 */   nop
    /* FCCD4 8010C4D4 43310408 */  j          .L8010C50C
    /* FCCD8 8010C4D8 00000000 */   nop
  .L8010C4DC:
    /* FCCDC 8010C4DC 04000224 */  addiu      $v0, $zero, 0x4
    /* FCCE0 8010C4E0 1B006214 */  bne        $v1, $v0, .L8010C550
    /* FCCE4 8010C4E4 21202002 */   addu      $a0, $s1, $zero
    /* FCCE8 8010C4E8 54310408 */  j          .L8010C550
    /* FCCEC 8010C4EC 000015AE */   sw        $s5, 0x0($s0)
  .L8010C4F0:
    /* FCCF0 8010C4F0 1380023C */  lui        $v0, %hi(_padFuncRecvAuto)
    /* FCCF4 8010C4F4 987C428C */  lw         $v0, %lo(_padFuncRecvAuto)($v0)
    /* FCCF8 8010C4F8 00000000 */  nop
    /* FCCFC 8010C4FC 09F84000 */  jalr       $v0
    /* FCD00 8010C500 10FF6426 */   addiu     $a0, $s3, -0xF0
    /* FCD04 8010C504 52310408 */  j          .L8010C548
    /* FCD08 8010C508 01000224 */   addiu     $v0, $zero, 0x1
  .L8010C50C:
    /* FCD0C 8010C50C 1380023C */  lui        $v0, %hi(_padInfoDir)
    /* FCD10 8010C510 AC7C428C */  lw         $v0, %lo(_padInfoDir)($v0)
    /* FCD14 8010C514 00000000 */  nop
    /* FCD18 8010C518 21985200 */  addu       $s3, $v0, $s2
    /* FCD1C 8010C51C 1380023C */  lui        $v0, %hi(_padFuncRecvAuto)
    /* FCD20 8010C520 987C428C */  lw         $v0, %lo(_padFuncRecvAuto)($v0)
    /* FCD24 8010C524 00000000 */  nop
    /* FCD28 8010C528 09F84000 */  jalr       $v0
    /* FCD2C 8010C52C 21206002 */   addu      $a0, $s3, $zero
    /* FCD30 8010C530 1380023C */  lui        $v0, %hi(_padFuncClrCmdNo)
    /* FCD34 8010C534 9C7C428C */  lw         $v0, %lo(_padFuncClrCmdNo)($v0)
    /* FCD38 8010C538 00000000 */  nop
    /* FCD3C 8010C53C 09F84000 */  jalr       $v0
    /* FCD40 8010C540 21206002 */   addu      $a0, $s3, $zero
    /* FCD44 8010C544 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8010C548:
    /* FCD48 8010C548 000002AE */  sw         $v0, 0x0($s0)
    /* FCD4C 8010C54C 21202002 */  addu       $a0, $s1, $zero
  .L8010C550:
    /* FCD50 8010C550 1380023C */  lui        $v0, %hi(_padFuncGetTxd)
    /* FCD54 8010C554 807C428C */  lw         $v0, %lo(_padFuncGetTxd)($v0)
    /* FCD58 8010C558 00000000 */  nop
    /* FCD5C 8010C55C 09F84000 */  jalr       $v0
    /* FCD60 8010C560 21288002 */   addu      $a1, $s4, $zero
    /* FCD64 8010C564 21202002 */  addu       $a0, $s1, $zero
    /* FCD68 8010C568 4A14040C */  jal        _padSioRW
    /* FCD6C 8010C56C FF004530 */   andi      $a1, $v0, 0xFF
    /* FCD70 8010C570 3E004004 */  bltz       $v0, .L8010C66C
    /* FCD74 8010C574 00000000 */   nop
    /* FCD78 8010C578 FA2F040C */  jal        setRC2wait
    /* FCD7C 8010C57C 3C000424 */   addiu     $a0, $zero, 0x3C
    /* FCD80 8010C580 4E15040C */  jal        _padClrIntSio0
    /* FCD84 8010C584 00000000 */   nop
    /* FCD88 8010C588 03004014 */  bnez       $v0, .L8010C598
    /* FCD8C 8010C58C 00000000 */   nop
  .L8010C590:
    /* FCD90 8010C590 9B310408 */  j          .L8010C66C
    /* FCD94 8010C594 FDFF0224 */   addiu     $v0, $zero, -0x3
  .L8010C598:
    /* FCD98 8010C598 1480023C */  lui        $v0, %hi(D_8013C308)
    /* FCD9C 8010C59C 08C3428C */  lw         $v0, %lo(D_8013C308)($v0)
    /* FCDA0 8010C5A0 00000000 */  nop
    /* FCDA4 8010C5A4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FCDA8 8010C5A8 1480013C */  lui        $at, %hi(D_8013C308)
    /* FCDAC 8010C5AC 08C322AC */  sw         $v0, %lo(D_8013C308)($at)
    /* FCDB0 8010C5B0 02004228 */  slti       $v0, $v0, 0x2
    /* FCDB4 8010C5B4 A9FF4010 */  beqz       $v0, .L8010C45C
    /* FCDB8 8010C5B8 00000000 */   nop
    /* FCDBC 8010C5BC 82310408 */  j          .L8010C608
    /* FCDC0 8010C5C0 00000000 */   nop
  .L8010C5C4:
    /* FCDC4 8010C5C4 21202002 */  addu       $a0, $s1, $zero
    /* FCDC8 8010C5C8 1380023C */  lui        $v0, %hi(_padFuncGetTxd)
    /* FCDCC 8010C5CC 807C428C */  lw         $v0, %lo(_padFuncGetTxd)($v0)
    /* FCDD0 8010C5D0 00000000 */  nop
    /* FCDD4 8010C5D4 09F84000 */  jalr       $v0
    /* FCDD8 8010C5D8 21288002 */   addu      $a1, $s4, $zero
    /* FCDDC 8010C5DC 21202002 */  addu       $a0, $s1, $zero
    /* FCDE0 8010C5E0 4A14040C */  jal        _padSioRW
    /* FCDE4 8010C5E4 FF004530 */   andi      $a1, $v0, 0xFF
    /* FCDE8 8010C5E8 20004004 */  bltz       $v0, .L8010C66C
    /* FCDEC 8010C5EC 00000000 */   nop
    /* FCDF0 8010C5F0 FA2F040C */  jal        setRC2wait
    /* FCDF4 8010C5F4 3C000424 */   addiu     $a0, $zero, 0x3C
    /* FCDF8 8010C5F8 4E15040C */  jal        _padClrIntSio0
    /* FCDFC 8010C5FC 00000000 */   nop
    /* FCE00 8010C600 1A004010 */  beqz       $v0, .L8010C66C
    /* FCE04 8010C604 FDFF0224 */   addiu     $v0, $zero, -0x3
  .L8010C608:
    /* FCE08 8010C608 1480023C */  lui        $v0, %hi(D_8013C308)
    /* FCE0C 8010C60C 08C3428C */  lw         $v0, %lo(D_8013C308)($v0)
    /* FCE10 8010C610 00000000 */  nop
    /* FCE14 8010C614 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FCE18 8010C618 1480013C */  lui        $at, %hi(D_8013C308)
    /* FCE1C 8010C61C E9FF401C */  bgtz       $v0, .L8010C5C4
    /* FCE20 8010C620 08C322AC */   sw        $v0, %lo(D_8013C308)($at)
    /* FCE24 8010C624 7215040C */  jal        _padWaitRXready
    /* FCE28 8010C628 00000000 */   nop
    /* FCE2C 8010C62C 44002392 */  lbu        $v1, 0x44($s1)
    /* FCE30 8010C630 00000000 */  nop
    /* FCE34 8010C634 01006224 */  addiu      $v0, $v1, 0x1
    /* FCE38 8010C638 440022A2 */  sb         $v0, 0x44($s1)
    /* FCE3C 8010C63C 1480023C */  lui        $v0, %hi(D_8013C30C)
    /* FCE40 8010C640 0CC3428C */  lw         $v0, %lo(D_8013C30C)($v0)
    /* FCE44 8010C644 3C00248E */  lw         $a0, 0x3C($s1)
    /* FCE48 8010C648 00004290 */  lbu        $v0, 0x0($v0)
    /* FCE4C 8010C64C 21186400 */  addu       $v1, $v1, $a0
    /* FCE50 8010C650 000062A0 */  sb         $v0, 0x0($v1)
    /* FCE54 8010C654 1380023C */  lui        $v0, %hi(_padFuncNextPort)
    /* FCE58 8010C658 787C428C */  lw         $v0, %lo(_padFuncNextPort)($v0)
    /* FCE5C 8010C65C 00000000 */  nop
    /* FCE60 8010C660 09F84000 */  jalr       $v0
    /* FCE64 8010C664 21200000 */   addu      $a0, $zero, $zero
    /* FCE68 8010C668 21100000 */  addu       $v0, $zero, $zero
  .L8010C66C:
    /* FCE6C 8010C66C 2800BF8F */  lw         $ra, 0x28($sp)
    /* FCE70 8010C670 2400B58F */  lw         $s5, 0x24($sp)
    /* FCE74 8010C674 2000B48F */  lw         $s4, 0x20($sp)
    /* FCE78 8010C678 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FCE7C 8010C67C 1800B28F */  lw         $s2, 0x18($sp)
    /* FCE80 8010C680 1400B18F */  lw         $s1, 0x14($sp)
    /* FCE84 8010C684 1000B08F */  lw         $s0, 0x10($sp)
    /* FCE88 8010C688 0800E003 */  jr         $ra
    /* FCE8C 8010C68C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel _padIntRecvData
    /* FCE90 8010C690 00000000 */  nop
    /* FCE94 8010C694 00000000 */  nop
