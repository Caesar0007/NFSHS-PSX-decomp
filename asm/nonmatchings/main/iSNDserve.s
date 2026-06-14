.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDserve, 0x39C

glabel iSNDserve
    /* F02F4 800FFAF4 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* F02F8 800FFAF8 1480023C */  lui        $v0, %hi(sndpd)
    /* F02FC 800FFAFC 1800B0AF */  sw         $s0, 0x18($sp)
    /* F0300 800FFB00 18795024 */  addiu      $s0, $v0, %lo(sndpd)
    /* F0304 800FFB04 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* F0308 800FFB08 3800BEAF */  sw         $fp, 0x38($sp)
    /* F030C 800FFB0C 3400B7AF */  sw         $s7, 0x34($sp)
    /* F0310 800FFB10 3000B6AF */  sw         $s6, 0x30($sp)
    /* F0314 800FFB14 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* F0318 800FFB18 2800B4AF */  sw         $s4, 0x28($sp)
    /* F031C 800FFB1C 2400B3AF */  sw         $s3, 0x24($sp)
    /* F0320 800FFB20 2000B2AF */  sw         $s2, 0x20($sp)
    /* F0324 800FFB24 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F0328 800FFB28 1000A0AF */  sw         $zero, 0x10($sp)
    /* F032C 800FFB2C 2007028E */  lw         $v0, 0x720($s0)
    /* F0330 800FFB30 00000000 */  nop
    /* F0334 800FFB34 03004010 */  beqz       $v0, .L800FFB44
    /* F0338 800FFB38 21980000 */   addu      $s3, $zero, $zero
    /* F033C 800FFB3C 09F84000 */  jalr       $v0
    /* F0340 800FFB40 00000000 */   nop
  .L800FFB44:
    /* F0344 800FFB44 1480023C */  lui        $v0, %hi(D_80147871)
    /* F0348 800FFB48 71784290 */  lbu        $v0, %lo(D_80147871)($v0)
    /* F034C 800FFB4C 00000000 */  nop
    /* F0350 800FFB50 2A106202 */  slt        $v0, $s3, $v0
    /* F0354 800FFB54 B8004010 */  beqz       $v0, .L800FFE38
    /* F0358 800FFB58 21A80000 */   addu      $s5, $zero, $zero
    /* F035C 800FFB5C 21F00002 */  addu       $fp, $s0, $zero
    /* F0360 800FFB60 21B8A002 */  addu       $s7, $s5, $zero
  .L800FFB64:
    /* F0364 800FFB64 1480053C */  lui        $a1, %hi(D_801479F0)
    /* F0368 800FFB68 F079A524 */  addiu      $a1, $a1, %lo(D_801479F0)
    /* F036C 800FFB6C 2180E502 */  addu       $s0, $s7, $a1
    /* F0370 800FFB70 1005C38F */  lw         $v1, 0x510($fp)
    /* F0374 800FFB74 00111500 */  sll        $v0, $s5, 4
    /* F0378 800FFB78 21A06200 */  addu       $s4, $v1, $v0
    /* F037C 800FFB7C 1D000392 */  lbu        $v1, 0x1D($s0)
    /* F0380 800FFB80 02000224 */  addiu      $v0, $zero, 0x2
    /* F0384 800FFB84 74006214 */  bne        $v1, $v0, .L800FFD58
    /* F0388 800FFB88 00000000 */   nop
    /* F038C 800FFB8C 0C008296 */  lhu        $v0, 0xC($s4)
    /* F0390 800FFB90 00000000 */  nop
    /* F0394 800FFB94 04004010 */  beqz       $v0, .L800FFBA8
    /* F0398 800FFB98 01000224 */   addiu     $v0, $zero, 0x1
    /* F039C 800FFB9C 260002A2 */  sb         $v0, 0x26($s0)
    /* F03A0 800FFBA0 24FF0308 */  j          .L800FFC90
    /* F03A4 800FFBA4 00000000 */   nop
  .L800FFBA8:
    /* F03A8 800FFBA8 26000292 */  lbu        $v0, 0x26($s0)
    /* F03AC 800FFBAC 00000000 */  nop
    /* F03B0 800FFBB0 37004010 */  beqz       $v0, .L800FFC90
    /* F03B4 800FFBB4 00000000 */   nop
    /* F03B8 800FFBB8 21000292 */  lbu        $v0, 0x21($s0)
    /* F03BC 800FFBBC 00000000 */  nop
    /* F03C0 800FFBC0 33004014 */  bnez       $v0, .L800FFC90
    /* F03C4 800FFBC4 00000000 */   nop
    /* F03C8 800FFBC8 27000292 */  lbu        $v0, 0x27($s0)
    /* F03CC 800FFBCC 00000000 */  nop
    /* F03D0 800FFBD0 00160200 */  sll        $v0, $v0, 24
    /* F03D4 800FFBD4 2E004104 */  bgez       $v0, .L800FFC90
    /* F03D8 800FFBD8 00000000 */   nop
    /* F03DC 800FFBDC 1F000292 */  lbu        $v0, 0x1F($s0)
    /* F03E0 800FFBE0 21B0E002 */  addu       $s6, $s7, $zero
    /* F03E4 800FFBE4 FF005230 */  andi       $s2, $v0, 0xFF
  .L800FFBE8:
    /* F03E8 800FFBE8 02000224 */  addiu      $v0, $zero, 0x2
    /* F03EC 800FFBEC 10004216 */  bne        $s2, $v0, .L800FFC30
    /* F03F0 800FFBF0 2188A002 */   addu      $s1, $s5, $zero
    /* F03F4 800FFBF4 1480053C */  lui        $a1, %hi(D_801479F0)
    /* F03F8 800FFBF8 F079A524 */  addiu      $a1, $a1, %lo(D_801479F0)
    /* F03FC 800FFBFC 20000292 */  lbu        $v0, 0x20($s0)
    /* F0400 800FFC00 20000392 */  lbu        $v1, 0x20($s0)
    /* F0404 800FFC04 00160200 */  sll        $v0, $v0, 24
    /* F0408 800FFC08 038E0200 */  sra        $s1, $v0, 24
    /* F040C 800FFC0C 001E0300 */  sll        $v1, $v1, 24
    /* F0410 800FFC10 031E0300 */  sra        $v1, $v1, 24
    /* F0414 800FFC14 40100300 */  sll        $v0, $v1, 1
    /* F0418 800FFC18 21104300 */  addu       $v0, $v0, $v1
    /* F041C 800FFC1C 80100200 */  sll        $v0, $v0, 2
    /* F0420 800FFC20 23104300 */  subu       $v0, $v0, $v1
    /* F0424 800FFC24 80100200 */  sll        $v0, $v0, 2
    /* F0428 800FFC28 0FFF0308 */  j          .L800FFC3C
    /* F042C 800FFC2C 21804500 */   addu      $s0, $v0, $a1
  .L800FFC30:
    /* F0430 800FFC30 1480053C */  lui        $a1, %hi(D_801479F0)
    /* F0434 800FFC34 F079A524 */  addiu      $a1, $a1, %lo(D_801479F0)
    /* F0438 800FFC38 2180C502 */  addu       $s0, $s6, $a1
  .L800FFC3C:
    /* F043C 800FFC3C 21202002 */  addu       $a0, $s1, $zero
    /* F0440 800FFC40 1D0000A2 */  sb         $zero, 0x1D($s0)
    /* F0444 800FFC44 1C0000A2 */  sb         $zero, 0x1C($s0)
    /* F0448 800FFC48 03FB030C */  jal        iSNDfreechan
    /* F044C 800FFC4C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* F0450 800FFC50 00211100 */  sll        $a0, $s1, 4
    /* F0454 800FFC54 1005C38F */  lw         $v1, 0x510($fp)
    /* F0458 800FFC58 00020224 */  addiu      $v0, $zero, 0x200
    /* F045C 800FFC5C 21188300 */  addu       $v1, $a0, $v1
    /* F0460 800FFC60 060062A4 */  sh         $v0, 0x6($v1)
    /* F0464 800FFC64 01000224 */  addiu      $v0, $zero, 0x1
    /* F0468 800FFC68 04102202 */  sllv       $v0, $v0, $s1
    /* F046C 800FFC6C 1005C38F */  lw         $v1, 0x510($fp)
    /* F0470 800FFC70 25986202 */  or         $s3, $s3, $v0
    /* F0474 800FFC74 21188300 */  addu       $v1, $a0, $v1
    /* F0478 800FFC78 000060A4 */  sh         $zero, 0x0($v1)
    /* F047C 800FFC7C 1005C28F */  lw         $v0, 0x510($fp)
    /* F0480 800FFC80 00000000 */  nop
    /* F0484 800FFC84 21208200 */  addu       $a0, $a0, $v0
    /* F0488 800FFC88 D7FF401E */  bgtz       $s2, .L800FFBE8
    /* F048C 800FFC8C 020080A4 */   sh        $zero, 0x2($a0)
  .L800FFC90:
    /* F0490 800FFC90 28000292 */  lbu        $v0, 0x28($s0)
    /* F0494 800FFC94 00000000 */  nop
    /* F0498 800FFC98 08004010 */  beqz       $v0, .L800FFCBC
    /* F049C 800FFC9C 4D4A033C */   lui       $v1, (0x4A4DC96F >> 16)
    /* F04A0 800FFCA0 0800028E */  lw         $v0, 0x8($s0)
    /* F04A4 800FFCA4 6FC96334 */  ori        $v1, $v1, (0x4A4DC96F & 0xFFFF)
    /* F04A8 800FFCA8 19004300 */  multu      $v0, $v1
    /* F04AC 800FFCAC 10280000 */  mfhi       $a1
    /* F04B0 800FFCB0 C2110500 */  srl        $v0, $a1, 7
    /* F04B4 800FFCB4 040082A6 */  sh         $v0, 0x4($s4)
    /* F04B8 800FFCB8 280000A2 */  sb         $zero, 0x28($s0)
  .L800FFCBC:
    /* F04BC 800FFCBC 1000028E */  lw         $v0, 0x10($s0)
    /* F04C0 800FFCC0 00000000 */  nop
    /* F04C4 800FFCC4 08004018 */  blez       $v0, .L800FFCE8
    /* F04C8 800FFCC8 00000000 */   nop
    /* F04CC 800FFCCC 1000028E */  lw         $v0, 0x10($s0)
    /* F04D0 800FFCD0 0800038E */  lw         $v1, 0x8($s0)
    /* F04D4 800FFCD4 00000000 */  nop
    /* F04D8 800FFCD8 23104300 */  subu       $v0, $v0, $v1
    /* F04DC 800FFCDC 100002AE */  sw         $v0, 0x10($s0)
    /* F04E0 800FFCE0 6AFF0308 */  j          .L800FFDA8
    /* F04E4 800FFCE4 00000000 */   nop
  .L800FFCE8:
    /* F04E8 800FFCE8 0C00028E */  lw         $v0, 0xC($s0)
    /* F04EC 800FFCEC 0800038E */  lw         $v1, 0x8($s0)
    /* F04F0 800FFCF0 00000000 */  nop
    /* F04F4 800FFCF4 21104300 */  addu       $v0, $v0, $v1
    /* F04F8 800FFCF8 0C0002AE */  sw         $v0, 0xC($s0)
    /* F04FC 800FFCFC 0C00028E */  lw         $v0, 0xC($s0)
    /* F0500 800FFD00 1400038E */  lw         $v1, 0x14($s0)
    /* F0504 800FFD04 00000000 */  nop
    /* F0508 800FFD08 2B104300 */  sltu       $v0, $v0, $v1
    /* F050C 800FFD0C 26004014 */  bnez       $v0, .L800FFDA8
    /* F0510 800FFD10 00000000 */   nop
    /* F0514 800FFD14 27000292 */  lbu        $v0, 0x27($s0)
    /* F0518 800FFD18 00000000 */  nop
    /* F051C 800FFD1C 00160200 */  sll        $v0, $v0, 24
    /* F0520 800FFD20 08004004 */  bltz       $v0, .L800FFD44
    /* F0524 800FFD24 00000000 */   nop
    /* F0528 800FFD28 0C00028E */  lw         $v0, 0xC($s0)
    /* F052C 800FFD2C 1400038E */  lw         $v1, 0x14($s0)
    /* F0530 800FFD30 00000000 */  nop
    /* F0534 800FFD34 23104300 */  subu       $v0, $v0, $v1
    /* F0538 800FFD38 0C0002AE */  sw         $v0, 0xC($s0)
    /* F053C 800FFD3C 6AFF0308 */  j          .L800FFDA8
    /* F0540 800FFD40 00000000 */   nop
  .L800FFD44:
    /* F0544 800FFD44 1400028E */  lw         $v0, 0x14($s0)
    /* F0548 800FFD48 00000000 */  nop
    /* F054C 800FFD4C 0C0002AE */  sw         $v0, 0xC($s0)
    /* F0550 800FFD50 6AFF0308 */  j          .L800FFDA8
    /* F0554 800FFD54 00000000 */   nop
  .L800FFD58:
    /* F0558 800FFD58 1D000392 */  lbu        $v1, 0x1D($s0)
    /* F055C 800FFD5C 03000224 */  addiu      $v0, $zero, 0x3
    /* F0560 800FFD60 11006214 */  bne        $v1, $v0, .L800FFDA8
    /* F0564 800FFD64 00000000 */   nop
    /* F0568 800FFD68 0C008296 */  lhu        $v0, 0xC($s4)
    /* F056C 800FFD6C 00000000 */  nop
    /* F0570 800FFD70 09004014 */  bnez       $v0, .L800FFD98
    /* F0574 800FFD74 01000224 */   addiu     $v0, $zero, 0x1
    /* F0578 800FFD78 0410A202 */  sllv       $v0, $v0, $s5
    /* F057C 800FFD7C 25986202 */  or         $s3, $s3, $v0
    /* F0580 800FFD80 00020224 */  addiu      $v0, $zero, 0x200
    /* F0584 800FFD84 1D0000A2 */  sb         $zero, 0x1D($s0)
    /* F0588 800FFD88 060082A6 */  sh         $v0, 0x6($s4)
    /* F058C 800FFD8C 000080A6 */  sh         $zero, 0x0($s4)
    /* F0590 800FFD90 6AFF0308 */  j          .L800FFDA8
    /* F0594 800FFD94 020080A6 */   sh        $zero, 0x2($s4)
  .L800FFD98:
    /* F0598 800FFD98 1000A58F */  lw         $a1, 0x10($sp)
    /* F059C 800FFD9C 0410A202 */  sllv       $v0, $v0, $s5
    /* F05A0 800FFDA0 2528A200 */  or         $a1, $a1, $v0
    /* F05A4 800FFDA4 1000A5AF */  sw         $a1, 0x10($sp)
  .L800FFDA8:
    /* F05A8 800FFDA8 1C000392 */  lbu        $v1, 0x1C($s0)
    /* F05AC 800FFDAC 01000224 */  addiu      $v0, $zero, 0x1
    /* F05B0 800FFDB0 1C006214 */  bne        $v1, $v0, .L800FFE24
    /* F05B4 800FFDB4 1480023C */   lui       $v0, %hi(D_80147871)
    /* F05B8 800FFDB8 1D000292 */  lbu        $v0, 0x1D($s0)
    /* F05BC 800FFDBC 00000000 */  nop
    /* F05C0 800FFDC0 18004014 */  bnez       $v0, .L800FFE24
    /* F05C4 800FFDC4 1480023C */   lui       $v0, %hi(D_80147871)
    /* F05C8 800FFDC8 1F000292 */  lbu        $v0, 0x1F($s0)
    /* F05CC 800FFDCC 00000000 */  nop
    /* F05D0 800FFDD0 0200422C */  sltiu      $v0, $v0, 0x2
    /* F05D4 800FFDD4 0F004014 */  bnez       $v0, .L800FFE14
    /* F05D8 800FFDD8 00000000 */   nop
    /* F05DC 800FFDDC 20000292 */  lbu        $v0, 0x20($s0)
    /* F05E0 800FFDE0 00000000 */  nop
    /* F05E4 800FFDE4 00160200 */  sll        $v0, $v0, 24
    /* F05E8 800FFDE8 03160200 */  sra        $v0, $v0, 24
    /* F05EC 800FFDEC 40180200 */  sll        $v1, $v0, 1
    /* F05F0 800FFDF0 21186200 */  addu       $v1, $v1, $v0
    /* F05F4 800FFDF4 80180300 */  sll        $v1, $v1, 2
    /* F05F8 800FFDF8 23186200 */  subu       $v1, $v1, $v0
    /* F05FC 800FFDFC 80180300 */  sll        $v1, $v1, 2
    /* F0600 800FFE00 21187E00 */  addu       $v1, $v1, $fp
    /* F0604 800FFE04 F5006290 */  lbu        $v0, 0xF5($v1)
    /* F0608 800FFE08 00000000 */  nop
    /* F060C 800FFE0C 05004014 */  bnez       $v0, .L800FFE24
    /* F0610 800FFE10 1480023C */   lui       $v0, %hi(D_80147871)
  .L800FFE14:
    /* F0614 800FFE14 F3FC030C */  jal        iSNDstartvoice
    /* F0618 800FFE18 2120A002 */   addu      $a0, $s5, $zero
    /* F061C 800FFE1C 25986202 */  or         $s3, $s3, $v0
    /* F0620 800FFE20 1480023C */  lui        $v0, %hi(D_80147871)
  .L800FFE24:
    /* F0624 800FFE24 71784290 */  lbu        $v0, %lo(D_80147871)($v0)
    /* F0628 800FFE28 0100B526 */  addiu      $s5, $s5, 0x1
    /* F062C 800FFE2C 2A10A202 */  slt        $v0, $s5, $v0
    /* F0630 800FFE30 4CFF4014 */  bnez       $v0, .L800FFB64
    /* F0634 800FFE34 2C00F726 */   addiu     $s7, $s7, 0x2C
  .L800FFE38:
    /* F0638 800FFE38 1000A58F */  lw         $a1, 0x10($sp)
    /* F063C 800FFE3C 00000000 */  nop
    /* F0640 800FFE40 0300A010 */  beqz       $a1, .L800FFE50
    /* F0644 800FFE44 00000000 */   nop
    /* F0648 800FFE48 5AFC030C */  jal        iSNDpsxkeyoff
    /* F064C 800FFE4C 2120A000 */   addu      $a0, $a1, $zero
  .L800FFE50:
    /* F0650 800FFE50 03006012 */  beqz       $s3, .L800FFE60
    /* F0654 800FFE54 00000000 */   nop
    /* F0658 800FFE58 50FC030C */  jal        iSNDpsxkeyon
    /* F065C 800FFE5C 21206002 */   addu      $a0, $s3, $zero
  .L800FFE60:
    /* F0660 800FFE60 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* F0664 800FFE64 3800BE8F */  lw         $fp, 0x38($sp)
    /* F0668 800FFE68 3400B78F */  lw         $s7, 0x34($sp)
    /* F066C 800FFE6C 3000B68F */  lw         $s6, 0x30($sp)
    /* F0670 800FFE70 2C00B58F */  lw         $s5, 0x2C($sp)
    /* F0674 800FFE74 2800B48F */  lw         $s4, 0x28($sp)
    /* F0678 800FFE78 2400B38F */  lw         $s3, 0x24($sp)
    /* F067C 800FFE7C 2000B28F */  lw         $s2, 0x20($sp)
    /* F0680 800FFE80 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F0684 800FFE84 1800B08F */  lw         $s0, 0x18($sp)
    /* F0688 800FFE88 0800E003 */  jr         $ra
    /* F068C 800FFE8C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel iSNDserve
