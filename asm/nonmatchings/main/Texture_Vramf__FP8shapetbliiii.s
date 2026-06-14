.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_Vramf__FP8shapetbliiii, 0x1AC

glabel Texture_Vramf__FP8shapetbliiii
    /* D038C 800DFB8C B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* D0390 800DFB90 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* D0394 800DFB94 6000B58F */  lw         $s5, 0x60($sp)
    /* D0398 800DFB98 2800B0AF */  sw         $s0, 0x28($sp)
    /* D039C 800DFB9C 21808000 */  addu       $s0, $a0, $zero
    /* D03A0 800DFBA0 3400B3AF */  sw         $s3, 0x34($sp)
    /* D03A4 800DFBA4 2198A000 */  addu       $s3, $a1, $zero
    /* D03A8 800DFBA8 3800B4AF */  sw         $s4, 0x38($sp)
    /* D03AC 800DFBAC 21A0C000 */  addu       $s4, $a2, $zero
    /* D03B0 800DFBB0 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* D03B4 800DFBB4 2188E000 */  addu       $s1, $a3, $zero
    /* D03B8 800DFBB8 4800BFAF */  sw         $ra, 0x48($sp)
    /* D03BC 800DFBBC 4400B7AF */  sw         $s7, 0x44($sp)
    /* D03C0 800DFBC0 4000B6AF */  sw         $s6, 0x40($sp)
    /* D03C4 800DFBC4 51000012 */  beqz       $s0, .L800DFD0C
    /* D03C8 800DFBC8 3000B2AF */   sw        $s2, 0x30($sp)
    /* D03CC 800DFBCC 00F01224 */  addiu      $s2, $zero, -0x1000
    /* D03D0 800DFBD0 FF0F8232 */  andi       $v0, $s4, 0xFFF
    /* D03D4 800DFBD4 00BC0200 */  sll        $s7, $v0, 16
    /* D03D8 800DFBD8 FF0FA232 */  andi       $v0, $s5, 0xFFF
    /* D03DC 800DFBDC 00B40200 */  sll        $s6, $v0, 16
  .L800DFBE0:
    /* D03E0 800DFBE0 00000292 */  lbu        $v0, 0x0($s0)
    /* D03E4 800DFBE4 00000000 */  nop
    /* D03E8 800DFBE8 F7004330 */  andi       $v1, $v0, 0xF7
    /* D03EC 800DFBEC 23000224 */  addiu      $v0, $zero, 0x23
    /* D03F0 800DFBF0 24006210 */  beq        $v1, $v0, .L800DFC84
    /* D03F4 800DFBF4 2B106200 */   sltu      $v0, $v1, $v0
    /* D03F8 800DFBF8 39004014 */  bnez       $v0, .L800DFCE0
    /* D03FC 800DFBFC 4400622C */   sltiu     $v0, $v1, 0x44
    /* D0400 800DFC00 37004010 */  beqz       $v0, .L800DFCE0
    /* D0404 800DFC04 4000622C */   sltiu     $v0, $v1, 0x40
    /* D0408 800DFC08 35004014 */  bnez       $v0, .L800DFCE0
    /* D040C 800DFC0C 00F0053C */   lui       $a1, (0xF000FFFF >> 16)
    /* D0410 800DFC10 FFFFA534 */  ori        $a1, $a1, (0xF000FFFF & 0xFFFF)
    /* D0414 800DFC14 21200002 */  addu       $a0, $s0, $zero
    /* D0418 800DFC18 0C00028E */  lw         $v0, 0xC($s0)
    /* D041C 800DFC1C FF0F6332 */  andi       $v1, $s3, 0xFFF
    /* D0420 800DFC20 24105200 */  and        $v0, $v0, $s2
    /* D0424 800DFC24 25104300 */  or         $v0, $v0, $v1
    /* D0428 800DFC28 24104500 */  and        $v0, $v0, $a1
    /* D042C 800DFC2C 00000392 */  lbu        $v1, 0x0($s0)
    /* D0430 800DFC30 25105700 */  or         $v0, $v0, $s7
    /* D0434 800DFC34 0C0002AE */  sw         $v0, 0xC($s0)
    /* D0438 800DFC38 08006334 */  ori        $v1, $v1, 0x8
    /* D043C 800DFC3C 000003A2 */  sb         $v1, 0x0($s0)
    /* D0440 800DFC40 1000B3A7 */  sh         $s3, 0x10($sp)
    /* D0444 800DFC44 F9D0030C */  jal        shapedepth
    /* D0448 800DFC48 1200B4A7 */   sh        $s4, 0x12($sp)
    /* D044C 800DFC4C 04000386 */  lh         $v1, 0x4($s0)
    /* D0450 800DFC50 00000000 */  nop
    /* D0454 800DFC54 18006200 */  mult       $v1, $v0
    /* D0458 800DFC58 12180000 */  mflo       $v1
    /* D045C 800DFC5C 0F006224 */  addiu      $v0, $v1, 0xF
    /* D0460 800DFC60 02004104 */  bgez       $v0, .L800DFC6C
    /* D0464 800DFC64 1000A427 */   addiu     $a0, $sp, 0x10
    /* D0468 800DFC68 1E006224 */  addiu      $v0, $v1, 0x1E
  .L800DFC6C:
    /* D046C 800DFC6C 03110200 */  sra        $v0, $v0, 4
    /* D0470 800DFC70 1400A2A7 */  sh         $v0, 0x14($sp)
    /* D0474 800DFC74 06000296 */  lhu        $v0, 0x6($s0)
    /* D0478 800DFC78 10000526 */  addiu      $a1, $s0, 0x10
    /* D047C 800DFC7C 367F0308 */  j          .L800DFCD8
    /* D0480 800DFC80 1600A2A7 */   sh        $v0, 0x16($sp)
  .L800DFC84:
    /* D0484 800DFC84 16002006 */  bltz       $s1, .L800DFCE0
    /* D0488 800DFC88 00F0063C */   lui       $a2, (0xF000FFFF >> 16)
    /* D048C 800DFC8C FFFFC634 */  ori        $a2, $a2, (0xF000FFFF & 0xFFFF)
    /* D0490 800DFC90 1000A427 */  addiu      $a0, $sp, 0x10
    /* D0494 800DFC94 10000526 */  addiu      $a1, $s0, 0x10
    /* D0498 800DFC98 0C00028E */  lw         $v0, 0xC($s0)
    /* D049C 800DFC9C FF0F2332 */  andi       $v1, $s1, 0xFFF
    /* D04A0 800DFCA0 24105200 */  and        $v0, $v0, $s2
    /* D04A4 800DFCA4 25104300 */  or         $v0, $v0, $v1
    /* D04A8 800DFCA8 24104600 */  and        $v0, $v0, $a2
    /* D04AC 800DFCAC 00000392 */  lbu        $v1, 0x0($s0)
    /* D04B0 800DFCB0 25105600 */  or         $v0, $v0, $s6
    /* D04B4 800DFCB4 0C0002AE */  sw         $v0, 0xC($s0)
    /* D04B8 800DFCB8 08006334 */  ori        $v1, $v1, 0x8
    /* D04BC 800DFCBC 000003A2 */  sb         $v1, 0x0($s0)
    /* D04C0 800DFCC0 1000B1A7 */  sh         $s1, 0x10($sp)
    /* D04C4 800DFCC4 1200B5A7 */  sh         $s5, 0x12($sp)
    /* D04C8 800DFCC8 04000396 */  lhu        $v1, 0x4($s0)
    /* D04CC 800DFCCC 01000224 */  addiu      $v0, $zero, 0x1
    /* D04D0 800DFCD0 1600A2A7 */  sh         $v0, 0x16($sp)
    /* D04D4 800DFCD4 1400A3A7 */  sh         $v1, 0x14($sp)
  .L800DFCD8:
    /* D04D8 800DFCD8 D27E030C */  jal        Texture_LoadImage__FP4RECTPUl
    /* D04DC 800DFCDC 00000000 */   nop
  .L800DFCE0:
    /* D04E0 800DFCE0 0000038E */  lw         $v1, 0x0($s0)
    /* D04E4 800DFCE4 00FF0224 */  addiu      $v0, $zero, -0x100
    /* D04E8 800DFCE8 24106200 */  and        $v0, $v1, $v0
    /* D04EC 800DFCEC 03004010 */  beqz       $v0, .L800DFCFC
    /* D04F0 800DFCF0 03120300 */   sra       $v0, $v1, 8
    /* D04F4 800DFCF4 407F0308 */  j          .L800DFD00
    /* D04F8 800DFCF8 21200202 */   addu      $a0, $s0, $v0
  .L800DFCFC:
    /* D04FC 800DFCFC 21200000 */  addu       $a0, $zero, $zero
  .L800DFD00:
    /* D0500 800DFD00 21808000 */  addu       $s0, $a0, $zero
    /* D0504 800DFD04 B6FF0016 */  bnez       $s0, .L800DFBE0
    /* D0508 800DFD08 00000000 */   nop
  .L800DFD0C:
    /* D050C 800DFD0C 4800BF8F */  lw         $ra, 0x48($sp)
    /* D0510 800DFD10 4400B78F */  lw         $s7, 0x44($sp)
    /* D0514 800DFD14 4000B68F */  lw         $s6, 0x40($sp)
    /* D0518 800DFD18 3C00B58F */  lw         $s5, 0x3C($sp)
    /* D051C 800DFD1C 3800B48F */  lw         $s4, 0x38($sp)
    /* D0520 800DFD20 3400B38F */  lw         $s3, 0x34($sp)
    /* D0524 800DFD24 3000B28F */  lw         $s2, 0x30($sp)
    /* D0528 800DFD28 2C00B18F */  lw         $s1, 0x2C($sp)
    /* D052C 800DFD2C 2800B08F */  lw         $s0, 0x28($sp)
    /* D0530 800DFD30 0800E003 */  jr         $ra
    /* D0534 800DFD34 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Texture_Vramf__FP8shapetbliiii
