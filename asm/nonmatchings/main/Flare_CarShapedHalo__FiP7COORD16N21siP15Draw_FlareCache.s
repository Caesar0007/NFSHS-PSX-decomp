.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache, 0x9D8

glabel Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
    /* BD358 800CCB58 18FFBD27 */  addiu      $sp, $sp, -0xE8
    /* BD35C 800CCB5C DC00B7AF */  sw         $s7, 0xDC($sp)
    /* BD360 800CCB60 21B88000 */  addu       $s7, $a0, $zero
    /* BD364 800CCB64 2148A000 */  addu       $t1, $a1, $zero
    /* BD368 800CCB68 F800AF8F */  lw         $t7, 0xF8($sp)
    /* BD36C 800CCB6C 0001A28F */  lw         $v0, 0x100($sp)
    /* BD370 800CCB70 2168C000 */  addu       $t5, $a2, $zero
    /* BD374 800CCB74 E000BEAF */  sw         $fp, 0xE0($sp)
    /* BD378 800CCB78 FC00BE8F */  lw         $fp, 0xFC($sp)
    /* BD37C 800CCB7C E400BFAF */  sw         $ra, 0xE4($sp)
    /* BD380 800CCB80 D800B6AF */  sw         $s6, 0xD8($sp)
    /* BD384 800CCB84 D400B5AF */  sw         $s5, 0xD4($sp)
    /* BD388 800CCB88 D000B4AF */  sw         $s4, 0xD0($sp)
    /* BD38C 800CCB8C CC00B3AF */  sw         $s3, 0xCC($sp)
    /* BD390 800CCB90 C800B2AF */  sw         $s2, 0xC8($sp)
    /* BD394 800CCB94 C400B1AF */  sw         $s1, 0xC4($sp)
    /* BD398 800CCB98 C000B0AF */  sw         $s0, 0xC0($sp)
    /* BD39C 800CCB9C B800AFA7 */  sh         $t7, 0xB8($sp)
    /* BD3A0 800CCBA0 0800438C */  lw         $v1, 0x8($v0)
    /* BD3A4 800CCBA4 0400428C */  lw         $v0, 0x4($v0)
    /* BD3A8 800CCBA8 00FC6324 */  addiu      $v1, $v1, -0x400
    /* BD3AC 800CCBAC 2B104300 */  sltu       $v0, $v0, $v1
    /* BD3B0 800CCBB0 53024010 */  beqz       $v0, .L800CD500
    /* BD3B4 800CCBB4 2170E000 */   addu      $t6, $a3, $zero
    /* BD3B8 800CCBB8 0000A895 */  lhu        $t0, 0x0($t5)
    /* BD3BC 800CCBBC 00002295 */  lhu        $v0, 0x0($t1)
    /* BD3C0 800CCBC0 00000000 */  nop
    /* BD3C4 800CCBC4 23400201 */  subu       $t0, $t0, $v0
    /* BD3C8 800CCBC8 3800A8A7 */  sh         $t0, 0x38($sp)
    /* BD3CC 800CCBCC 0200A795 */  lhu        $a3, 0x2($t5)
    /* BD3D0 800CCBD0 02002295 */  lhu        $v0, 0x2($t1)
    /* BD3D4 800CCBD4 00000000 */  nop
    /* BD3D8 800CCBD8 2338E200 */  subu       $a3, $a3, $v0
    /* BD3DC 800CCBDC 3A00A7A7 */  sh         $a3, 0x3A($sp)
    /* BD3E0 800CCBE0 0400A695 */  lhu        $a2, 0x4($t5)
    /* BD3E4 800CCBE4 04002295 */  lhu        $v0, 0x4($t1)
    /* BD3E8 800CCBE8 00000000 */  nop
    /* BD3EC 800CCBEC 2330C200 */  subu       $a2, $a2, $v0
    /* BD3F0 800CCBF0 3C00A6A7 */  sh         $a2, 0x3C($sp)
    /* BD3F4 800CCBF4 0000C595 */  lhu        $a1, 0x0($t6)
    /* BD3F8 800CCBF8 00002295 */  lhu        $v0, 0x0($t1)
    /* BD3FC 800CCBFC 00000000 */  nop
    /* BD400 800CCC00 2328A200 */  subu       $a1, $a1, $v0
    /* BD404 800CCC04 4000A5A7 */  sh         $a1, 0x40($sp)
    /* BD408 800CCC08 0200C495 */  lhu        $a0, 0x2($t6)
    /* BD40C 800CCC0C 02002295 */  lhu        $v0, 0x2($t1)
    /* BD410 800CCC10 00000000 */  nop
    /* BD414 800CCC14 23208200 */  subu       $a0, $a0, $v0
    /* BD418 800CCC18 18008600 */  mult       $a0, $a2
    /* BD41C 800CCC1C 4200A4A7 */  sh         $a0, 0x42($sp)
    /* BD420 800CCC20 0400C395 */  lhu        $v1, 0x4($t6)
    /* BD424 800CCC24 04002295 */  lhu        $v0, 0x4($t1)
    /* BD428 800CCC28 12600000 */  mflo       $t4
    /* BD42C 800CCC2C 23186200 */  subu       $v1, $v1, $v0
    /* BD430 800CCC30 00000000 */  nop
    /* BD434 800CCC34 18006700 */  mult       $v1, $a3
    /* BD438 800CCC38 12800000 */  mflo       $s0
    /* BD43C 800CCC3C 00000000 */  nop
    /* BD440 800CCC40 00000000 */  nop
    /* BD444 800CCC44 18006800 */  mult       $v1, $t0
    /* BD448 800CCC48 12880000 */  mflo       $s1
    /* BD44C 800CCC4C 00000000 */  nop
    /* BD450 800CCC50 00000000 */  nop
    /* BD454 800CCC54 1800A700 */  mult       $a1, $a3
    /* BD458 800CCC58 12100000 */  mflo       $v0
    /* BD45C 800CCC5C 00000000 */  nop
    /* BD460 800CCC60 00000000 */  nop
    /* BD464 800CCC64 18008800 */  mult       $a0, $t0
    /* BD468 800CCC68 12900000 */  mflo       $s2
    /* BD46C 800CCC6C 00000000 */  nop
    /* BD470 800CCC70 00000000 */  nop
    /* BD474 800CCC74 1800A600 */  mult       $a1, $a2
    /* BD478 800CCC78 4400A3A7 */  sh         $v1, 0x44($sp)
    /* BD47C 800CCC7C 23105200 */  subu       $v0, $v0, $s2
    /* BD480 800CCC80 4C00A2A7 */  sh         $v0, 0x4C($sp)
    /* BD484 800CCC84 23109001 */  subu       $v0, $t4, $s0
    /* BD488 800CCC88 4800A2A7 */  sh         $v0, 0x48($sp)
    /* BD48C 800CCC8C 12200000 */  mflo       $a0
    /* BD490 800CCC90 23102402 */  subu       $v0, $s1, $a0
    /* BD494 800CCC94 4A00A2A7 */  sh         $v0, 0x4A($sp)
    /* BD498 800CCC98 00140F00 */  sll        $v0, $t7, 16
    /* BD49C 800CCC9C 02004004 */  bltz       $v0, .L800CCCA8
    /* BD4A0 800CCCA0 2130A001 */   addu      $a2, $t5, $zero
    /* BD4A4 800CCCA4 2130C001 */  addu       $a2, $t6, $zero
  .L800CCCA8:
    /* BD4A8 800CCCA8 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* BD4AC 800CCCAC 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* BD4B0 800CCCB0 00000000 */  nop
    /* BD4B4 800CCCB4 03004010 */  beqz       $v0, .L800CCCC4
    /* BD4B8 800CCCB8 7F00E332 */   andi      $v1, $s7, 0x7F
    /* BD4BC 800CCCBC 32330308 */  j          .L800CCCC8
    /* BD4C0 800CCCC0 01006424 */   addiu     $a0, $v1, 0x1
  .L800CCCC4:
    /* BD4C4 800CCCC4 0B006424 */  addiu      $a0, $v1, 0xB
  .L800CCCC8:
    /* BD4C8 800CCCC8 0001E232 */  andi       $v0, $s7, 0x100
    /* BD4CC 800CCCCC 07004010 */  beqz       $v0, .L800CCCEC
    /* BD4D0 800CCCD0 00000000 */   nop
    /* BD4D4 800CCCD4 1480023C */  lui        $v0, %hi(DrawC_gReflectOffset)
    /* BD4D8 800CCCD8 14D84294 */  lhu        $v0, %lo(DrawC_gReflectOffset)($v0)
    /* BD4DC 800CCCDC 02002395 */  lhu        $v1, 0x2($t1)
    /* BD4E0 800CCCE0 23100200 */  negu       $v0, $v0
    /* BD4E4 800CCCE4 23104300 */  subu       $v0, $v0, $v1
    /* BD4E8 800CCCE8 020022A5 */  sh         $v0, 0x2($t1)
  .L800CCCEC:
    /* BD4EC 800CCCEC 000020C9 */  lwc2       $0, 0x0($t1)
    /* BD4F0 800CCCF0 040021C9 */  lwc2       $1, 0x4($t1)
    /* BD4F4 800CCCF4 00000000 */  nop
    /* BD4F8 800CCCF8 00000000 */  nop
    /* BD4FC 800CCCFC 0100184A */  .word 0x4A180001  /* rtps */
    /* BD500 800CCD00 1280023C */  lui        $v0, %hi(Flare_gType)
    /* BD504 800CCD04 68FF4224 */  addiu      $v0, $v0, %lo(Flare_gType)
    /* BD508 800CCD08 00190400 */  sll        $v1, $a0, 4
    /* BD50C 800CCD0C 21186200 */  addu       $v1, $v1, $v0
    /* BD510 800CCD10 0000628C */  lw         $v0, 0x0($v1)
    /* BD514 800CCD14 00000000 */  nop
    /* BD518 800CCD18 2800A2AF */  sw         $v0, 0x28($sp)
    /* BD51C 800CCD1C 0400628C */  lw         $v0, 0x4($v1)
    /* BD520 800CCD20 00000000 */  nop
    /* BD524 800CCD24 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* BD528 800CCD28 8000E232 */  andi       $v0, $s7, 0x80
    /* BD52C 800CCD2C 0800738C */  lw         $s3, 0x8($v1)
    /* BD530 800CCD30 0C00748C */  lw         $s4, 0xC($v1)
    /* BD534 800CCD34 14004010 */  beqz       $v0, .L800CCD88
    /* BD538 800CCD38 1800A227 */   addiu     $v0, $sp, 0x18
    /* BD53C 800CCD3C 2800A293 */  lbu        $v0, 0x28($sp)
    /* BD540 800CCD40 2900A393 */  lbu        $v1, 0x29($sp)
    /* BD544 800CCD44 42100200 */  srl        $v0, $v0, 1
    /* BD548 800CCD48 2800A2A3 */  sb         $v0, 0x28($sp)
    /* BD54C 800CCD4C 2A00A293 */  lbu        $v0, 0x2A($sp)
    /* BD550 800CCD50 42180300 */  srl        $v1, $v1, 1
    /* BD554 800CCD54 2900A3A3 */  sb         $v1, 0x29($sp)
    /* BD558 800CCD58 2C00A393 */  lbu        $v1, 0x2C($sp)
    /* BD55C 800CCD5C 42100200 */  srl        $v0, $v0, 1
    /* BD560 800CCD60 2A00A2A3 */  sb         $v0, 0x2A($sp)
    /* BD564 800CCD64 2D00A293 */  lbu        $v0, 0x2D($sp)
    /* BD568 800CCD68 42180300 */  srl        $v1, $v1, 1
    /* BD56C 800CCD6C 2C00A3A3 */  sb         $v1, 0x2C($sp)
    /* BD570 800CCD70 2E00A393 */  lbu        $v1, 0x2E($sp)
    /* BD574 800CCD74 42100200 */  srl        $v0, $v0, 1
    /* BD578 800CCD78 42180300 */  srl        $v1, $v1, 1
    /* BD57C 800CCD7C 2D00A2A3 */  sb         $v0, 0x2D($sp)
    /* BD580 800CCD80 2E00A3A3 */  sb         $v1, 0x2E($sp)
    /* BD584 800CCD84 1800A227 */  addiu      $v0, $sp, 0x18
  .L800CCD88:
    /* BD588 800CCD88 000059E8 */  swc2       $25, 0x0($v0)
    /* BD58C 800CCD8C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BD590 800CCD90 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BD594 800CCD94 1800A48F */  lw         $a0, 0x18($sp)
    /* BD598 800CCD98 2000A38F */  lw         $v1, 0x20($sp)
    /* BD59C 800CCD9C 00000000 */  nop
    /* BD5A0 800CCDA0 2A106400 */  slt        $v0, $v1, $a0
    /* BD5A4 800CCDA4 D6014014 */  bnez       $v0, .L800CD500
    /* BD5A8 800CCDA8 23100400 */   negu      $v0, $a0
    /* BD5AC 800CCDAC 2A106200 */  slt        $v0, $v1, $v0
    /* BD5B0 800CCDB0 D3014014 */  bnez       $v0, .L800CD500
    /* BD5B4 800CCDB4 80006228 */   slti      $v0, $v1, 0x80
    /* BD5B8 800CCDB8 D1014014 */  bnez       $v0, .L800CD500
    /* BD5BC 800CCDBC 3000A227 */   addiu     $v0, $sp, 0x30
    /* BD5C0 800CCDC0 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD5C4 800CCDC4 08008232 */  andi       $v0, $s4, 0x8
    /* BD5C8 800CCDC8 06004010 */  beqz       $v0, .L800CCDE4
    /* BD5CC 800CCDCC 21B00000 */   addu      $s6, $zero, $zero
    /* BD5D0 800CCDD0 3000A287 */  lh         $v0, 0x30($sp)
    /* BD5D4 800CCDD4 3200A387 */  lh         $v1, 0x32($sp)
    /* BD5D8 800CCDD8 00000000 */  nop
    /* BD5DC 800CCDDC 21104300 */  addu       $v0, $v0, $v1
    /* BD5E0 800CCDE0 80B00200 */  sll        $s6, $v0, 2
  .L800CCDE4:
    /* BD5E4 800CCDE4 04008232 */  andi       $v0, $s4, 0x4
    /* BD5E8 800CCDE8 24004010 */  beqz       $v0, .L800CCE7C
    /* BD5EC 800CCDEC 21A80000 */   addu      $s5, $zero, $zero
    /* BD5F0 800CCDF0 0000C0C8 */  lwc2       $0, 0x0($a2)
    /* BD5F4 800CCDF4 0400C1C8 */  lwc2       $1, 0x4($a2)
    /* BD5F8 800CCDF8 00000000 */  nop
    /* BD5FC 800CCDFC 00000000 */  nop
    /* BD600 800CCE00 0100184A */  .word 0x4A180001  /* rtps */
    /* BD604 800CCE04 5000A227 */  addiu      $v0, $sp, 0x50
    /* BD608 800CCE08 000059E8 */  swc2       $25, 0x0($v0)
    /* BD60C 800CCE0C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BD610 800CCE10 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BD614 800CCE14 6000A227 */  addiu      $v0, $sp, 0x60
    /* BD618 800CCE18 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD61C 800CCE1C 6200B187 */  lh         $s1, 0x62($sp)
    /* BD620 800CCE20 3200A287 */  lh         $v0, 0x32($sp)
    /* BD624 800CCE24 6000B087 */  lh         $s0, 0x60($sp)
    /* BD628 800CCE28 23882202 */  subu       $s1, $s1, $v0
    /* BD62C 800CCE2C 3000A287 */  lh         $v0, 0x30($sp)
    /* BD630 800CCE30 21202002 */  addu       $a0, $s1, $zero
    /* BD634 800CCE34 23800202 */  subu       $s0, $s0, $v0
    /* BD638 800CCE38 4AB5030C */  jal        fixedatan
    /* BD63C 800CCE3C 21280002 */   addu      $a1, $s0, $zero
    /* BD640 800CCE40 18001002 */  mult       $s0, $s0
    /* BD644 800CCE44 12180000 */  mflo       $v1
    /* BD648 800CCE48 00000000 */  nop
    /* BD64C 800CCE4C 00000000 */  nop
    /* BD650 800CCE50 18003102 */  mult       $s1, $s1
    /* BD654 800CCE54 03A90200 */  sra        $s5, $v0, 4
    /* BD658 800CCE58 12400000 */  mflo       $t0
    /* BD65C 800CCE5C B3CC030C */  jal        isqrt
    /* BD660 800CCE60 21206800 */   addu      $a0, $v1, $t0
    /* BD664 800CCE64 2000A38F */  lw         $v1, 0x20($sp)
    /* BD668 800CCE68 00000000 */  nop
    /* BD66C 800CCE6C 18004300 */  mult       $v0, $v1
    /* BD670 800CCE70 12900000 */  mflo       $s2
    /* BD674 800CCE74 A0330308 */  j          .L800CCE80
    /* BD678 800CCE78 00000000 */   nop
  .L800CCE7C:
    /* BD67C 800CCE7C 2190A002 */  addu       $s2, $s5, $zero
  .L800CCE80:
    /* BD680 800CCE80 1480193C */  lui        $t9, %hi(gfrgb)
    /* BD684 800CCE84 6CD83927 */  addiu      $t9, $t9, %lo(gfrgb)
    /* BD688 800CCE88 2B00AA8B */  lwl        $t2, 0x2B($sp)
    /* BD68C 800CCE8C 2800AA9B */  lwr        $t2, 0x28($sp)
    /* BD690 800CCE90 00000000 */  nop
    /* BD694 800CCE94 03002AAB */  swl        $t2, 0x3($t9)
    /* BD698 800CCE98 00002ABB */  swr        $t2, 0x0($t9)
    /* BD69C 800CCE9C 1480193C */  lui        $t9, %hi(gfrgb2)
    /* BD6A0 800CCEA0 70D83927 */  addiu      $t9, $t9, %lo(gfrgb2)
    /* BD6A4 800CCEA4 2F00AA8B */  lwl        $t2, 0x2F($sp)
    /* BD6A8 800CCEA8 2C00AA9B */  lwr        $t2, 0x2C($sp)
    /* BD6AC 800CCEAC 00000000 */  nop
    /* BD6B0 800CCEB0 03002AAB */  swl        $t2, 0x3($t9)
    /* BD6B4 800CCEB4 00002ABB */  swr        $t2, 0x0($t9)
    /* BD6B8 800CCEB8 B800AA97 */  lhu        $t2, 0xB8($sp)
    /* BD6BC 800CCEBC 00000000 */  nop
    /* BD6C0 800CCEC0 00140A00 */  sll        $v0, $t2, 16
    /* BD6C4 800CCEC4 0C004004 */  bltz       $v0, .L800CCEF8
    /* BD6C8 800CCEC8 00000000 */   nop
    /* BD6CC 800CCECC 3800A287 */  lh         $v0, 0x38($sp)
    /* BD6D0 800CCED0 00000000 */  nop
    /* BD6D4 800CCED4 18004200 */  mult       $v0, $v0
    /* BD6D8 800CCED8 12200000 */  mflo       $a0
    /* BD6DC 800CCEDC 3A00A287 */  lh         $v0, 0x3A($sp)
    /* BD6E0 800CCEE0 00000000 */  nop
    /* BD6E4 800CCEE4 18004200 */  mult       $v0, $v0
    /* BD6E8 800CCEE8 12180000 */  mflo       $v1
    /* BD6EC 800CCEEC 3C00A287 */  lh         $v0, 0x3C($sp)
    /* BD6F0 800CCEF0 C9330308 */  j          .L800CCF24
    /* BD6F4 800CCEF4 18004200 */   mult      $v0, $v0
  .L800CCEF8:
    /* BD6F8 800CCEF8 4000A287 */  lh         $v0, 0x40($sp)
    /* BD6FC 800CCEFC 00000000 */  nop
    /* BD700 800CCF00 18004200 */  mult       $v0, $v0
    /* BD704 800CCF04 12200000 */  mflo       $a0
    /* BD708 800CCF08 4200A287 */  lh         $v0, 0x42($sp)
    /* BD70C 800CCF0C 00000000 */  nop
    /* BD710 800CCF10 18004200 */  mult       $v0, $v0
    /* BD714 800CCF14 12180000 */  mflo       $v1
    /* BD718 800CCF18 4400A287 */  lh         $v0, 0x44($sp)
    /* BD71C 800CCF1C 00000000 */  nop
    /* BD720 800CCF20 18004200 */  mult       $v0, $v0
  .L800CCF24:
    /* BD724 800CCF24 21108300 */  addu       $v0, $a0, $v1
    /* BD728 800CCF28 12400000 */  mflo       $t0
    /* BD72C 800CCF2C 21104800 */  addu       $v0, $v0, $t0
    /* BD730 800CCF30 43100200 */  sra        $v0, $v0, 1
    /* BD734 800CCF34 281382AF */  sw         $v0, %gp_rel(gscale)($gp)
    /* BD738 800CCF38 2813828F */  lw         $v0, %gp_rel(gscale)($gp)
    /* BD73C 800CCF3C 00000000 */  nop
    /* BD740 800CCF40 04106202 */  sllv       $v0, $v0, $s3
    /* BD744 800CCF44 21984000 */  addu       $s3, $v0, $zero
    /* BD748 800CCF48 01008232 */  andi       $v0, $s4, 0x1
    /* BD74C 800CCF4C 281393AF */  sw         $s3, %gp_rel(gscale)($gp)
    /* BD750 800CCF50 28004010 */  beqz       $v0, .L800CCFF4
    /* BD754 800CCF54 0001E232 */   andi      $v0, $s7, 0x100
    /* BD758 800CCF58 0028C048 */  ctc2       $zero, $5 /* handwritten instruction */
    /* BD75C 800CCF5C 0030C048 */  ctc2       $zero, $6 /* handwritten instruction */
    /* BD760 800CCF60 0038C048 */  ctc2       $zero, $7 /* handwritten instruction */
    /* BD764 800CCF64 4800A227 */  addiu      $v0, $sp, 0x48
    /* BD768 800CCF68 000040C8 */  lwc2       $0, 0x0($v0)
    /* BD76C 800CCF6C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BD770 800CCF70 00000000 */  nop
    /* BD774 800CCF74 00000000 */  nop
    /* BD778 800CCF78 0100184A */  .word 0x4A180001  /* rtps */
    /* BD77C 800CCF7C 5000A427 */  addiu      $a0, $sp, 0x50
    /* BD780 800CCF80 000099E8 */  swc2       $25, 0x0($a0)
    /* BD784 800CCF84 04009AE8 */  swc2       $26, 0x4($a0) /* handwritten instruction */
    /* BD788 800CCF88 08009BE8 */  swc2       $27, 0x8($a0) /* handwritten instruction */
    /* BD78C 800CCF8C B7C6030C */  jal        VectorNormal
    /* BD790 800CCF90 6800A527 */   addiu     $a1, $sp, 0x68
    /* BD794 800CCF94 02008232 */  andi       $v0, $s4, 0x2
    /* BD798 800CCF98 08004010 */  beqz       $v0, .L800CCFBC
    /* BD79C 800CCF9C 00000000 */   nop
    /* BD7A0 800CCFA0 7000A38F */  lw         $v1, 0x70($sp)
    /* BD7A4 800CCFA4 00000000 */  nop
    /* BD7A8 800CCFA8 CDF06324 */  addiu      $v1, $v1, -0xF33
    /* BD7AC 800CCFAC 80100300 */  sll        $v0, $v1, 2
    /* BD7B0 800CCFB0 21104300 */  addu       $v0, $v0, $v1
    /* BD7B4 800CCFB4 80100200 */  sll        $v0, $v0, 2
    /* BD7B8 800CCFB8 7000A2AF */  sw         $v0, 0x70($sp)
  .L800CCFBC:
    /* BD7BC 800CCFBC 7000A28F */  lw         $v0, 0x70($sp)
    /* BD7C0 800CCFC0 00000000 */  nop
    /* BD7C4 800CCFC4 A8FD4324 */  addiu      $v1, $v0, -0x258
    /* BD7C8 800CCFC8 02006104 */  bgez       $v1, .L800CCFD4
    /* BD7CC 800CCFCC 00000000 */   nop
    /* BD7D0 800CCFD0 21180000 */  addu       $v1, $zero, $zero
  .L800CCFD4:
    /* BD7D4 800CCFD4 2813828F */  lw         $v0, %gp_rel(gscale)($gp)
    /* BD7D8 800CCFD8 00000000 */  nop
    /* BD7DC 800CCFDC 18004300 */  mult       $v0, $v1
    /* BD7E0 800CCFE0 7000A3AF */  sw         $v1, 0x70($sp)
    /* BD7E4 800CCFE4 12500000 */  mflo       $t2
    /* BD7E8 800CCFE8 C3120A00 */  sra        $v0, $t2, 11
    /* BD7EC 800CCFEC 281382AF */  sw         $v0, %gp_rel(gscale)($gp)
    /* BD7F0 800CCFF0 0001E232 */  andi       $v0, $s7, 0x100
  .L800CCFF4:
    /* BD7F4 800CCFF4 76004010 */  beqz       $v0, .L800CD1D0
    /* BD7F8 800CCFF8 9800B027 */   addiu     $s0, $sp, 0x98
    /* BD7FC 800CCFFC C3111200 */  sra        $v0, $s2, 7
    /* BD800 800CD000 20138393 */  lbu        $v1, %gp_rel(gfrgb)($gp)
    /* BD804 800CD004 21106202 */  addu       $v0, $s3, $v0
    /* BD808 800CD008 14800A3C */  lui        $t2, %hi(gfrgb)
    /* BD80C 800CD00C 6CD84A25 */  addiu      $t2, $t2, %lo(gfrgb)
    /* BD810 800CD010 03004B89 */  lwl        $t3, 0x3($t2)
    /* BD814 800CD014 00004B99 */  lwr        $t3, 0x0($t2)
    /* BD818 800CD018 00000000 */  nop
    /* BD81C 800CD01C 5300ABAB */  swl        $t3, 0x53($sp)
    /* BD820 800CD020 5000ABBB */  swr        $t3, 0x50($sp)
    /* BD824 800CD024 7800A2AF */  sw         $v0, 0x78($sp)
    /* BD828 800CD028 8000A2AF */  sw         $v0, 0x80($sp)
    /* BD82C 800CD02C 21138293 */  lbu        $v0, %gp_rel(gfrgb + 0x1)($gp)
    /* BD830 800CD030 8800A0AF */  sw         $zero, 0x88($sp)
    /* BD834 800CD034 7C00A0AF */  sw         $zero, 0x7C($sp)
    /* BD838 800CD038 8400A0AF */  sw         $zero, 0x84($sp)
    /* BD83C 800CD03C 42180300 */  srl        $v1, $v1, 1
    /* BD840 800CD040 201383A3 */  sb         $v1, %gp_rel(gfrgb)($gp)
    /* BD844 800CD044 22138393 */  lbu        $v1, %gp_rel(gfrgb + 0x2)($gp)
    /* BD848 800CD048 42100200 */  srl        $v0, $v0, 1
    /* BD84C 800CD04C 211382A3 */  sb         $v0, %gp_rel(gfrgb + 0x1)($gp)
    /* BD850 800CD050 42180300 */  srl        $v1, $v1, 1
    /* BD854 800CD054 221383A3 */  sb         $v1, %gp_rel(gfrgb + 0x2)($gp)
    /* BD858 800CD058 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BD85C 800CD05C 21200002 */   addu      $a0, $s0, $zero
    /* BD860 800CD060 1800A227 */  addiu      $v0, $sp, 0x18
    /* BD864 800CD064 00004C8C */  lw         $t4, 0x0($v0)
    /* BD868 800CD068 04004D8C */  lw         $t5, 0x4($v0)
    /* BD86C 800CD06C 08004E8C */  lw         $t6, 0x8($v0)
    /* BD870 800CD070 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BD874 800CD074 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BD878 800CD078 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BD87C 800CD07C 00080424 */  addiu      $a0, $zero, 0x800
    /* BD880 800CD080 4BCC030C */  jal        RotMatrixZ
    /* BD884 800CD084 21280002 */   addu      $a1, $s0, $zero
    /* BD888 800CD088 00000C8E */  lw         $t4, 0x0($s0)
    /* BD88C 800CD08C 04000D8E */  lw         $t5, 0x4($s0)
    /* BD890 800CD090 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BD894 800CD094 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BD898 800CD098 08000C8E */  lw         $t4, 0x8($s0)
    /* BD89C 800CD09C 0C000D8E */  lw         $t5, 0xC($s0)
    /* BD8A0 800CD0A0 10000E8E */  lw         $t6, 0x10($s0)
    /* BD8A4 800CD0A4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BD8A8 800CD0A8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BD8AC 800CD0AC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BD8B0 800CD0B0 7800A227 */  addiu      $v0, $sp, 0x78
    /* BD8B4 800CD0B4 00004C94 */  lhu        $t4, 0x0($v0)
    /* BD8B8 800CD0B8 06004D94 */  lhu        $t5, 0x6($v0)
    /* BD8BC 800CD0BC 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BD8C0 800CD0C0 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BD8C4 800CD0C4 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BD8C8 800CD0C8 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BD8CC 800CD0CC 00000000 */  nop
    /* BD8D0 800CD0D0 00000000 */  nop
    /* BD8D4 800CD0D4 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BD8D8 800CD0D8 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BD8DC 800CD0DC 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BD8E0 800CD0E0 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BD8E4 800CD0E4 00000CA6 */  sh         $t4, 0x0($s0)
    /* BD8E8 800CD0E8 06000DA6 */  sh         $t5, 0x6($s0)
    /* BD8EC 800CD0EC 0C000EA6 */  sh         $t6, 0xC($s0)
    /* BD8F0 800CD0F0 7A00A227 */  addiu      $v0, $sp, 0x7A
    /* BD8F4 800CD0F4 00004C94 */  lhu        $t4, 0x0($v0)
    /* BD8F8 800CD0F8 06004D94 */  lhu        $t5, 0x6($v0)
    /* BD8FC 800CD0FC 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BD900 800CD100 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BD904 800CD104 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BD908 800CD108 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BD90C 800CD10C 00000000 */  nop
    /* BD910 800CD110 00000000 */  nop
    /* BD914 800CD114 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BD918 800CD118 9A00A227 */  addiu      $v0, $sp, 0x9A
    /* BD91C 800CD11C 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BD920 800CD120 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BD924 800CD124 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BD928 800CD128 00004CA4 */  sh         $t4, 0x0($v0)
    /* BD92C 800CD12C 06004DA4 */  sh         $t5, 0x6($v0)
    /* BD930 800CD130 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BD934 800CD134 7C00A227 */  addiu      $v0, $sp, 0x7C
    /* BD938 800CD138 00004C94 */  lhu        $t4, 0x0($v0)
    /* BD93C 800CD13C 06004D94 */  lhu        $t5, 0x6($v0)
    /* BD940 800CD140 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BD944 800CD144 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BD948 800CD148 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BD94C 800CD14C 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BD950 800CD150 00000000 */  nop
    /* BD954 800CD154 00000000 */  nop
    /* BD958 800CD158 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BD95C 800CD15C 9C00A227 */  addiu      $v0, $sp, 0x9C
    /* BD960 800CD160 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BD964 800CD164 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BD968 800CD168 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BD96C 800CD16C 00004CA4 */  sh         $t4, 0x0($v0)
    /* BD970 800CD170 06004DA4 */  sh         $t5, 0x6($v0)
    /* BD974 800CD174 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BD978 800CD178 00000C8E */  lw         $t4, 0x0($s0)
    /* BD97C 800CD17C 04000D8E */  lw         $t5, 0x4($s0)
    /* BD980 800CD180 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BD984 800CD184 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BD988 800CD188 08000C8E */  lw         $t4, 0x8($s0)
    /* BD98C 800CD18C 0C000D8E */  lw         $t5, 0xC($s0)
    /* BD990 800CD190 10000E8E */  lw         $t6, 0x10($s0)
    /* BD994 800CD194 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BD998 800CD198 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BD99C 800CD19C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BD9A0 800CD1A0 3000A427 */  addiu      $a0, $sp, 0x30
    /* BD9A4 800CD1A4 1A32030C */  jal        Flare_ReflectHexFlare__FPli
    /* BD9A8 800CD1A8 2128C003 */   addu      $a1, $fp, $zero
    /* BD9AC 800CD1AC 14800A3C */  lui        $t2, %hi(gfrgb)
    /* BD9B0 800CD1B0 6CD84A25 */  addiu      $t2, $t2, %lo(gfrgb)
    /* BD9B4 800CD1B4 5300AB8B */  lwl        $t3, 0x53($sp)
    /* BD9B8 800CD1B8 5000AB9B */  lwr        $t3, 0x50($sp)
    /* BD9BC 800CD1BC 00000000 */  nop
    /* BD9C0 800CD1C0 03004BA9 */  swl        $t3, 0x3($t2)
    /* BD9C4 800CD1C4 00004BB9 */  swr        $t3, 0x0($t2)
    /* BD9C8 800CD1C8 24350308 */  j          .L800CD490
    /* BD9CC 800CD1CC 801F093C */   lui       $t1, (0x1F800004 >> 16)
  .L800CD1D0:
    /* BD9D0 800CD1D0 5000B127 */  addiu      $s1, $sp, 0x50
    /* BD9D4 800CD1D4 21202002 */  addu       $a0, $s1, $zero
    /* BD9D8 800CD1D8 2813838F */  lw         $v1, %gp_rel(gscale)($gp)
    /* BD9DC 800CD1DC 43111200 */  sra        $v0, $s2, 5
    /* BD9E0 800CD1E0 A000A0AF */  sw         $zero, 0xA0($sp)
    /* BD9E4 800CD1E4 9400A0AF */  sw         $zero, 0x94($sp)
    /* BD9E8 800CD1E8 9C00A0AF */  sw         $zero, 0x9C($sp)
    /* BD9EC 800CD1EC 21106200 */  addu       $v0, $v1, $v0
    /* BD9F0 800CD1F0 9000A2AF */  sw         $v0, 0x90($sp)
    /* BD9F4 800CD1F4 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BD9F8 800CD1F8 9800A3AF */   sw        $v1, 0x98($sp)
    /* BD9FC 800CD1FC 7000B027 */  addiu      $s0, $sp, 0x70
    /* BDA00 800CD200 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BDA04 800CD204 21200002 */   addu      $a0, $s0, $zero
    /* BDA08 800CD208 1800A227 */  addiu      $v0, $sp, 0x18
    /* BDA0C 800CD20C 00004C8C */  lw         $t4, 0x0($v0)
    /* BDA10 800CD210 04004D8C */  lw         $t5, 0x4($v0)
    /* BDA14 800CD214 08004E8C */  lw         $t6, 0x8($v0)
    /* BDA18 800CD218 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BDA1C 800CD21C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BDA20 800CD220 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BDA24 800CD224 2120C002 */  addu       $a0, $s6, $zero
    /* BDA28 800CD228 4BCC030C */  jal        RotMatrixZ
    /* BDA2C 800CD22C 21282002 */   addu      $a1, $s1, $zero
    /* BDA30 800CD230 2120A002 */  addu       $a0, $s5, $zero
    /* BDA34 800CD234 4BCC030C */  jal        RotMatrixZ
    /* BDA38 800CD238 21280002 */   addu      $a1, $s0, $zero
    /* BDA3C 800CD23C 00000C8E */  lw         $t4, 0x0($s0)
    /* BDA40 800CD240 04000D8E */  lw         $t5, 0x4($s0)
    /* BDA44 800CD244 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BDA48 800CD248 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BDA4C 800CD24C 08000C8E */  lw         $t4, 0x8($s0)
    /* BDA50 800CD250 0C000D8E */  lw         $t5, 0xC($s0)
    /* BDA54 800CD254 10000E8E */  lw         $t6, 0x10($s0)
    /* BDA58 800CD258 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BDA5C 800CD25C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BDA60 800CD260 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BDA64 800CD264 9000A327 */  addiu      $v1, $sp, 0x90
    /* BDA68 800CD268 00006C94 */  lhu        $t4, 0x0($v1)
    /* BDA6C 800CD26C 06006D94 */  lhu        $t5, 0x6($v1)
    /* BDA70 800CD270 0C006E94 */  lhu        $t6, 0xC($v1)
    /* BDA74 800CD274 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDA78 800CD278 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDA7C 800CD27C 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDA80 800CD280 00000000 */  nop
    /* BDA84 800CD284 00000000 */  nop
    /* BDA88 800CD288 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDA8C 800CD28C 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDA90 800CD290 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDA94 800CD294 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDA98 800CD298 00006CA4 */  sh         $t4, 0x0($v1)
    /* BDA9C 800CD29C 06006DA4 */  sh         $t5, 0x6($v1)
    /* BDAA0 800CD2A0 0C006EA4 */  sh         $t6, 0xC($v1)
    /* BDAA4 800CD2A4 9200A227 */  addiu      $v0, $sp, 0x92
    /* BDAA8 800CD2A8 00004C94 */  lhu        $t4, 0x0($v0)
    /* BDAAC 800CD2AC 06004D94 */  lhu        $t5, 0x6($v0)
    /* BDAB0 800CD2B0 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BDAB4 800CD2B4 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDAB8 800CD2B8 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDABC 800CD2BC 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDAC0 800CD2C0 00000000 */  nop
    /* BDAC4 800CD2C4 00000000 */  nop
    /* BDAC8 800CD2C8 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDACC 800CD2CC 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDAD0 800CD2D0 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDAD4 800CD2D4 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDAD8 800CD2D8 00004CA4 */  sh         $t4, 0x0($v0)
    /* BDADC 800CD2DC 06004DA4 */  sh         $t5, 0x6($v0)
    /* BDAE0 800CD2E0 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BDAE4 800CD2E4 9400A227 */  addiu      $v0, $sp, 0x94
    /* BDAE8 800CD2E8 00004C94 */  lhu        $t4, 0x0($v0)
    /* BDAEC 800CD2EC 06004D94 */  lhu        $t5, 0x6($v0)
    /* BDAF0 800CD2F0 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BDAF4 800CD2F4 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDAF8 800CD2F8 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDAFC 800CD2FC 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDB00 800CD300 00000000 */  nop
    /* BDB04 800CD304 00000000 */  nop
    /* BDB08 800CD308 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDB0C 800CD30C 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDB10 800CD310 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDB14 800CD314 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDB18 800CD318 00004CA4 */  sh         $t4, 0x0($v0)
    /* BDB1C 800CD31C 06004DA4 */  sh         $t5, 0x6($v0)
    /* BDB20 800CD320 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BDB24 800CD324 00006C8C */  lw         $t4, 0x0($v1)
    /* BDB28 800CD328 04006D8C */  lw         $t5, 0x4($v1)
    /* BDB2C 800CD32C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BDB30 800CD330 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BDB34 800CD334 08006C8C */  lw         $t4, 0x8($v1)
    /* BDB38 800CD338 0C006D8C */  lw         $t5, 0xC($v1)
    /* BDB3C 800CD33C 10006E8C */  lw         $t6, 0x10($v1)
    /* BDB40 800CD340 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BDB44 800CD344 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BDB48 800CD348 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BDB4C 800CD34C 00002C96 */  lhu        $t4, 0x0($s1)
    /* BDB50 800CD350 06002D96 */  lhu        $t5, 0x6($s1)
    /* BDB54 800CD354 0C002E96 */  lhu        $t6, 0xC($s1)
    /* BDB58 800CD358 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDB5C 800CD35C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDB60 800CD360 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDB64 800CD364 00000000 */  nop
    /* BDB68 800CD368 00000000 */  nop
    /* BDB6C 800CD36C 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDB70 800CD370 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDB74 800CD374 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDB78 800CD378 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDB7C 800CD37C 00002CA6 */  sh         $t4, 0x0($s1)
    /* BDB80 800CD380 06002DA6 */  sh         $t5, 0x6($s1)
    /* BDB84 800CD384 0C002EA6 */  sh         $t6, 0xC($s1)
    /* BDB88 800CD388 5200A227 */  addiu      $v0, $sp, 0x52
    /* BDB8C 800CD38C 00004C94 */  lhu        $t4, 0x0($v0)
    /* BDB90 800CD390 06004D94 */  lhu        $t5, 0x6($v0)
    /* BDB94 800CD394 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BDB98 800CD398 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDB9C 800CD39C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDBA0 800CD3A0 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDBA4 800CD3A4 00000000 */  nop
    /* BDBA8 800CD3A8 00000000 */  nop
    /* BDBAC 800CD3AC 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDBB0 800CD3B0 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDBB4 800CD3B4 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDBB8 800CD3B8 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDBBC 800CD3BC 00004CA4 */  sh         $t4, 0x0($v0)
    /* BDBC0 800CD3C0 06004DA4 */  sh         $t5, 0x6($v0)
    /* BDBC4 800CD3C4 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BDBC8 800CD3C8 5400A227 */  addiu      $v0, $sp, 0x54
    /* BDBCC 800CD3CC 00004C94 */  lhu        $t4, 0x0($v0)
    /* BDBD0 800CD3D0 06004D94 */  lhu        $t5, 0x6($v0)
    /* BDBD4 800CD3D4 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BDBD8 800CD3D8 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BDBDC 800CD3DC 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BDBE0 800CD3E0 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BDBE4 800CD3E4 00000000 */  nop
    /* BDBE8 800CD3E8 00000000 */  nop
    /* BDBEC 800CD3EC 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BDBF0 800CD3F0 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BDBF4 800CD3F4 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BDBF8 800CD3F8 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BDBFC 800CD3FC 00004CA4 */  sh         $t4, 0x0($v0)
    /* BDC00 800CD400 06004DA4 */  sh         $t5, 0x6($v0)
    /* BDC04 800CD404 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BDC08 800CD408 00002C8E */  lw         $t4, 0x0($s1)
    /* BDC0C 800CD40C 04002D8E */  lw         $t5, 0x4($s1)
    /* BDC10 800CD410 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BDC14 800CD414 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BDC18 800CD418 08002C8E */  lw         $t4, 0x8($s1)
    /* BDC1C 800CD41C 0C002D8E */  lw         $t5, 0xC($s1)
    /* BDC20 800CD420 10002E8E */  lw         $t6, 0x10($s1)
    /* BDC24 800CD424 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BDC28 800CD428 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BDC2C 800CD42C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BDC30 800CD430 2000A38F */  lw         $v1, 0x20($sp)
    /* BDC34 800CD434 00000000 */  nop
    /* BDC38 800CD438 800C6228 */  slti       $v0, $v1, 0xC80
    /* BDC3C 800CD43C 05004010 */  beqz       $v0, .L800CD454
    /* BDC40 800CD440 3000A427 */   addiu     $a0, $sp, 0x30
    /* BDC44 800CD444 0D30030C */  jal        Flare_OctFlareSpikes__FPli
    /* BDC48 800CD448 2128C003 */   addu      $a1, $fp, $zero
    /* BDC4C 800CD44C 24350308 */  j          .L800CD490
    /* BDC50 800CD450 801F093C */   lui       $t1, (0x1F800004 >> 16)
  .L800CD454:
    /* BDC54 800CD454 801B6228 */  slti       $v0, $v1, 0x1B80
    /* BDC58 800CD458 09004010 */  beqz       $v0, .L800CD480
    /* BDC5C 800CD45C 3000B027 */   addiu     $s0, $sp, 0x30
    /* BDC60 800CD460 21200002 */  addu       $a0, $s0, $zero
    /* BDC64 800CD464 A531030C */  jal        Flare_HexFlare__FPli
    /* BDC68 800CD468 2128C003 */   addu      $a1, $fp, $zero
    /* BDC6C 800CD46C 21200002 */  addu       $a0, $s0, $zero
    /* BDC70 800CD470 D338030C */  jal        Flare_PreCalcHexLightBeam__FPli
    /* BDC74 800CD474 2128C003 */   addu      $a1, $fp, $zero
    /* BDC78 800CD478 24350308 */  j          .L800CD490
    /* BDC7C 800CD47C 801F093C */   lui       $t1, (0x1F800004 >> 16)
  .L800CD480:
    /* BDC80 800CD480 3000A427 */  addiu      $a0, $sp, 0x30
    /* BDC84 800CD484 8F32030C */  jal        Flare_QuadFlare__FPli
    /* BDC88 800CD488 2128C003 */   addu      $a1, $fp, $zero
    /* BDC8C 800CD48C 801F093C */  lui        $t1, (0x1F800004 >> 16)
  .L800CD490:
    /* BDC90 800CD490 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* BDC94 800CD494 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* BDC98 800CD498 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* BDC9C 800CD49C 21280000 */  addu       $a1, $zero, $zero
    /* BDCA0 800CD4A0 80301E00 */  sll        $a2, $fp, 2
    /* BDCA4 800CD4A4 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* BDCA8 800CD4A8 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BDCAC 800CD4AC 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BDCB0 800CD4B0 0000248D */  lw         $a0, 0x0($t1)
    /* BDCB4 800CD4B4 2130C200 */  addu       $a2, $a2, $v0
    /* BDCB8 800CD4B8 0000838C */  lw         $v1, 0x0($a0)
    /* BDCBC 800CD4BC 0000C28C */  lw         $v0, 0x0($a2)
    /* BDCC0 800CD4C0 24186800 */  and        $v1, $v1, $t0
    /* BDCC4 800CD4C4 24104700 */  and        $v0, $v0, $a3
    /* BDCC8 800CD4C8 25186200 */  or         $v1, $v1, $v0
    /* BDCCC 800CD4CC 000083AC */  sw         $v1, 0x0($a0)
    /* BDCD0 800CD4D0 0000C28C */  lw         $v0, 0x0($a2)
    /* BDCD4 800CD4D4 0C008324 */  addiu      $v1, $a0, 0xC
    /* BDCD8 800CD4D8 000023AD */  sw         $v1, 0x0($t1)
    /* BDCDC 800CD4DC 24188700 */  and        $v1, $a0, $a3
    /* BDCE0 800CD4E0 20010724 */  addiu      $a3, $zero, 0x120
    /* BDCE4 800CD4E4 24104800 */  and        $v0, $v0, $t0
    /* BDCE8 800CD4E8 25104300 */  or         $v0, $v0, $v1
    /* BDCEC 800CD4EC 0000C2AC */  sw         $v0, 0x0($a2)
    /* BDCF0 800CD4F0 40008632 */  andi       $a2, $s4, 0x40
    /* BDCF4 800CD4F4 2B300600 */  sltu       $a2, $zero, $a2
    /* BDCF8 800CD4F8 EFB8030C */  jal        SetDrawMode
    /* BDCFC 800CD4FC 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CD500:
    /* BDD00 800CD500 E400BF8F */  lw         $ra, 0xE4($sp)
    /* BDD04 800CD504 E000BE8F */  lw         $fp, 0xE0($sp)
    /* BDD08 800CD508 DC00B78F */  lw         $s7, 0xDC($sp)
    /* BDD0C 800CD50C D800B68F */  lw         $s6, 0xD8($sp)
    /* BDD10 800CD510 D400B58F */  lw         $s5, 0xD4($sp)
    /* BDD14 800CD514 D000B48F */  lw         $s4, 0xD0($sp)
    /* BDD18 800CD518 CC00B38F */  lw         $s3, 0xCC($sp)
    /* BDD1C 800CD51C C800B28F */  lw         $s2, 0xC8($sp)
    /* BDD20 800CD520 C400B18F */  lw         $s1, 0xC4($sp)
    /* BDD24 800CD524 C000B08F */  lw         $s0, 0xC0($sp)
    /* BDD28 800CD528 0800E003 */  jr         $ra
    /* BDD2C 800CD52C E800BD27 */   addiu     $sp, $sp, 0xE8
endlabel Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
