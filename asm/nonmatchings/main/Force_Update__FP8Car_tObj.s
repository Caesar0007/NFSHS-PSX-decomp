.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_Update__FP8Car_tObj, 0x458

glabel Force_Update__FP8Car_tObj
    /* BB3C0 800CABC0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* BB3C4 800CABC4 21308000 */  addu       $a2, $a0, $zero
    /* BB3C8 800CABC8 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* BB3CC 800CABCC 3800BEAF */  sw         $fp, 0x38($sp)
    /* BB3D0 800CABD0 3400B7AF */  sw         $s7, 0x34($sp)
    /* BB3D4 800CABD4 3000B6AF */  sw         $s6, 0x30($sp)
    /* BB3D8 800CABD8 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* BB3DC 800CABDC 2800B4AF */  sw         $s4, 0x28($sp)
    /* BB3E0 800CABE0 2400B3AF */  sw         $s3, 0x24($sp)
    /* BB3E4 800CABE4 2000B2AF */  sw         $s2, 0x20($sp)
    /* BB3E8 800CABE8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* BB3EC 800CABEC 1800B0AF */  sw         $s0, 0x18($sp)
    /* BB3F0 800CABF0 5402C58C */  lw         $a1, 0x254($a2)
    /* BB3F4 800CABF4 00000000 */  nop
    /* BB3F8 800CABF8 0200A22C */  sltiu      $v0, $a1, 0x2
    /* BB3FC 800CABFC FA004010 */  beqz       $v0, .L800CAFE8
    /* BB400 800CAC00 C0100500 */   sll       $v0, $a1, 3
    /* BB404 800CAC04 1280033C */  lui        $v1, %hi(Force_g)
    /* BB408 800CAC08 60FD6324 */  addiu      $v1, $v1, %lo(Force_g)
    /* BB40C 800CAC0C 1480043C */  lui        $a0, %hi(Replay_ReplayMode)
    /* BB410 800CAC10 F4D3848C */  lw         $a0, %lo(Replay_ReplayMode)($a0)
    /* BB414 800CAC14 00000000 */  nop
    /* BB418 800CAC18 02008428 */  slti       $a0, $a0, 0x2
    /* BB41C 800CAC1C 05008014 */  bnez       $a0, .L800CAC34
    /* BB420 800CAC20 21B04300 */   addu      $s6, $v0, $v1
    /* BB424 800CAC24 0100C0A2 */  sb         $zero, 0x1($s6)
    /* BB428 800CAC28 0200C0A2 */  sb         $zero, 0x2($s6)
    /* BB42C 800CAC2C FA2B0308 */  j          .L800CAFE8
    /* BB430 800CAC30 0400C0A2 */   sb        $zero, 0x4($s6)
  .L800CAC34:
    /* BB434 800CAC34 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* BB438 800CAC38 EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* BB43C 800CAC3C 80100500 */  sll        $v0, $a1, 2
    /* BB440 800CAC40 21104300 */  addu       $v0, $v0, $v1
    /* BB444 800CAC44 A800458C */  lw         $a1, 0xA8($v0)
    /* BB448 800CAC48 B000478C */  lw         $a3, 0xB0($v0)
    /* BB44C 800CAC4C 0C00A010 */  beqz       $a1, .L800CAC80
    /* BB450 800CAC50 1000A424 */   addiu     $a0, $a1, 0x10
    /* BB454 800CAC54 40180400 */  sll        $v1, $a0, 1
    /* BB458 800CAC58 21186400 */  addu       $v1, $v1, $a0
    /* BB45C 800CAC5C C0180300 */  sll        $v1, $v1, 3
    /* BB460 800CAC60 23186400 */  subu       $v1, $v1, $a0
    /* BB464 800CAC64 C0110300 */  sll        $v0, $v1, 7
    /* BB468 800CAC68 23104300 */  subu       $v0, $v0, $v1
    /* BB46C 800CAC6C 80100200 */  sll        $v0, $v0, 2
    /* BB470 800CAC70 21104400 */  addu       $v0, $v0, $a0
    /* BB474 800CAC74 21104400 */  addu       $v0, $v0, $a0
    /* BB478 800CAC78 212B0308 */  j          .L800CAC84
    /* BB47C 800CAC7C 1000A2AF */   sw        $v0, 0x10($sp)
  .L800CAC80:
    /* BB480 800CAC80 1000A0AF */  sw         $zero, 0x10($sp)
  .L800CAC84:
    /* BB484 800CAC84 0C00A010 */  beqz       $a1, .L800CACB8
    /* BB488 800CAC88 1000A324 */   addiu     $v1, $a1, 0x10
    /* BB48C 800CAC8C 00110300 */  sll        $v0, $v1, 4
    /* BB490 800CAC90 23104300 */  subu       $v0, $v0, $v1
    /* BB494 800CAC94 80100200 */  sll        $v0, $v0, 2
    /* BB498 800CAC98 21104300 */  addu       $v0, $v0, $v1
    /* BB49C 800CAC9C C0100200 */  sll        $v0, $v0, 3
    /* BB4A0 800CACA0 23104300 */  subu       $v0, $v0, $v1
    /* BB4A4 800CACA4 C0100200 */  sll        $v0, $v0, 3
    /* BB4A8 800CACA8 23104300 */  subu       $v0, $v0, $v1
    /* BB4AC 800CACAC 40100200 */  sll        $v0, $v0, 1
    /* BB4B0 800CACB0 2F2B0308 */  j          .L800CACBC
    /* BB4B4 800CACB4 1400A2AF */   sw        $v0, 0x14($sp)
  .L800CACB8:
    /* BB4B8 800CACB8 1400A0AF */  sw         $zero, 0x14($sp)
  .L800CACBC:
    /* BB4BC 800CACBC 0C00E010 */  beqz       $a3, .L800CACF0
    /* BB4C0 800CACC0 1000E224 */   addiu     $v0, $a3, 0x10
    /* BB4C4 800CACC4 C0180200 */  sll        $v1, $v0, 3
    /* BB4C8 800CACC8 21186200 */  addu       $v1, $v1, $v0
    /* BB4CC 800CACCC C0180300 */  sll        $v1, $v1, 3
    /* BB4D0 800CACD0 21186200 */  addu       $v1, $v1, $v0
    /* BB4D4 800CACD4 40190300 */  sll        $v1, $v1, 5
    /* BB4D8 800CACD8 21186200 */  addu       $v1, $v1, $v0
    /* BB4DC 800CACDC 80180300 */  sll        $v1, $v1, 2
    /* BB4E0 800CACE0 21186200 */  addu       $v1, $v1, $v0
    /* BB4E4 800CACE4 80100300 */  sll        $v0, $v1, 2
    /* BB4E8 800CACE8 3D2B0308 */  j          .L800CACF4
    /* BB4EC 800CACEC 21B86200 */   addu      $s7, $v1, $v0
  .L800CACF0:
    /* BB4F0 800CACF0 21B80000 */  addu       $s7, $zero, $zero
  .L800CACF4:
    /* BB4F4 800CACF4 21A00000 */  addu       $s4, $zero, $zero
    /* BB4F8 800CACF8 7C01C294 */  lhu        $v0, 0x17C($a2)
    /* BB4FC 800CACFC 00000000 */  nop
    /* BB500 800CAD00 2D004014 */  bnez       $v0, .L800CADB8
    /* BB504 800CAD04 21988002 */   addu      $s3, $s4, $zero
    /* BB508 800CAD08 C001C28C */  lw         $v0, 0x1C0($a2)
    /* BB50C 800CAD0C 00000000 */  nop
    /* BB510 800CAD10 FEFF4324 */  addiu      $v1, $v0, -0x2
    /* BB514 800CAD14 0E00622C */  sltiu      $v0, $v1, 0xE
    /* BB518 800CAD18 26004010 */  beqz       $v0, .L800CADB4
    /* BB51C 800CAD1C 0580023C */   lui       $v0, %hi(jtbl_8005684C)
    /* BB520 800CAD20 4C684224 */  addiu      $v0, $v0, %lo(jtbl_8005684C)
    /* BB524 800CAD24 80180300 */  sll        $v1, $v1, 2
    /* BB528 800CAD28 21186200 */  addu       $v1, $v1, $v0
    /* BB52C 800CAD2C 0000628C */  lw         $v0, 0x0($v1)
    /* BB530 800CAD30 00000000 */  nop
    /* BB534 800CAD34 08004000 */  jr         $v0
    /* BB538 800CAD38 00000000 */   nop
  jlabel .L800CAD3C
    /* BB53C 800CAD3C 21A00000 */  addu       $s4, $zero, $zero
    /* BB540 800CAD40 0700033C */  lui        $v1, (0x78000 >> 16)
    /* BB544 800CAD44 00806334 */  ori        $v1, $v1, (0x78000 & 0xFFFF)
    /* BB548 800CAD48 0700133C */  lui        $s3, (0x78000 >> 16)
    /* BB54C 800CAD4C 2004C28C */  lw         $v0, 0x420($a2)
    /* BB550 800CAD50 00000000 */  nop
    /* BB554 800CAD54 02004104 */  bgez       $v0, .L800CAD60
    /* BB558 800CAD58 00000000 */   nop
    /* BB55C 800CAD5C 23100200 */  negu       $v0, $v0
  .L800CAD60:
    /* BB560 800CAD60 83100200 */  sra        $v0, $v0, 2
    /* BB564 800CAD64 2A186200 */  slt        $v1, $v1, $v0
    /* BB568 800CAD68 13006014 */  bnez       $v1, .L800CADB8
    /* BB56C 800CAD6C 00807336 */   ori       $s3, $s3, (0x78000 & 0xFFFF)
    /* BB570 800CAD70 6E2B0308 */  j          .L800CADB8
    /* BB574 800CAD74 21984000 */   addu      $s3, $v0, $zero
  jlabel .L800CAD78
    /* BB578 800CAD78 0500033C */  lui        $v1, (0x58000 >> 16)
    /* BB57C 800CAD7C 00806334 */  ori        $v1, $v1, (0x58000 & 0xFFFF)
    /* BB580 800CAD80 0500143C */  lui        $s4, (0x58000 >> 16)
    /* BB584 800CAD84 2004C28C */  lw         $v0, 0x420($a2)
    /* BB588 800CAD88 00000000 */  nop
    /* BB58C 800CAD8C 02004104 */  bgez       $v0, .L800CAD98
    /* BB590 800CAD90 00000000 */   nop
    /* BB594 800CAD94 23100200 */  negu       $v0, $v0
  .L800CAD98:
    /* BB598 800CAD98 43100200 */  sra        $v0, $v0, 1
    /* BB59C 800CAD9C 2A186200 */  slt        $v1, $v1, $v0
    /* BB5A0 800CADA0 04006014 */  bnez       $v1, .L800CADB4
    /* BB5A4 800CADA4 00809436 */   ori       $s4, $s4, (0x58000 & 0xFFFF)
    /* BB5A8 800CADA8 6D2B0308 */  j          .L800CADB4
    /* BB5AC 800CADAC 21A04000 */   addu      $s4, $v0, $zero
  jlabel .L800CADB0
    /* BB5B0 800CADB0 21A00000 */  addu       $s4, $zero, $zero
  .L800CADB4:
    /* BB5B4 800CADB4 21980000 */  addu       $s3, $zero, $zero
  .L800CADB8:
    /* BB5B8 800CADB8 9407C28C */  lw         $v0, 0x794($a2)
    /* BB5BC 800CADBC 00000000 */  nop
    /* BB5C0 800CADC0 5F004010 */  beqz       $v0, .L800CAF40
    /* BB5C4 800CADC4 FFFF5524 */   addiu     $s5, $v0, -0x1
    /* BB5C8 800CADC8 FFFF1E34 */  ori        $fp, $zero, 0xFFFF
    /* BB5CC 800CADCC 40101500 */  sll        $v0, $s5, 1
    /* BB5D0 800CADD0 21105500 */  addu       $v0, $v0, $s5
    /* BB5D4 800CADD4 C0100200 */  sll        $v0, $v0, 3
    /* BB5D8 800CADD8 21884600 */  addu       $s1, $v0, $a2
  .L800CADDC:
    /* BB5DC 800CADDC 5800A006 */  bltz       $s5, .L800CAF40
    /* BB5E0 800CADE0 12000224 */   addiu     $v0, $zero, 0x12
    /* BB5E4 800CADE4 9C07238E */  lw         $v1, 0x79C($s1)
    /* BB5E8 800CADE8 00000000 */  nop
    /* BB5EC 800CADEC 0A006214 */  bne        $v1, $v0, .L800CAE18
    /* BB5F0 800CADF0 14000224 */   addiu     $v0, $zero, 0x14
    /* BB5F4 800CADF4 A807228E */  lw         $v0, 0x7A8($s1)
    /* BB5F8 800CADF8 00000000 */  nop
    /* BB5FC 800CADFC 40180200 */  sll        $v1, $v0, 1
    /* BB600 800CAE00 2A107400 */  slt        $v0, $v1, $s4
    /* BB604 800CAE04 02004010 */  beqz       $v0, .L800CAE10
    /* BB608 800CAE08 00000000 */   nop
    /* BB60C 800CAE0C 21188002 */  addu       $v1, $s4, $zero
  .L800CAE10:
    /* BB610 800CAE10 CD2B0308 */  j          .L800CAF34
    /* BB614 800CAE14 21A06000 */   addu      $s4, $v1, $zero
  .L800CAE18:
    /* BB618 800CAE18 0A006214 */  bne        $v1, $v0, .L800CAE44
    /* BB61C 800CAE1C 00000000 */   nop
    /* BB620 800CAE20 A807228E */  lw         $v0, 0x7A8($s1)
    /* BB624 800CAE24 00000000 */  nop
    /* BB628 800CAE28 40180200 */  sll        $v1, $v0, 1
    /* BB62C 800CAE2C 2A107300 */  slt        $v0, $v1, $s3
    /* BB630 800CAE30 02004010 */  beqz       $v0, .L800CAE3C
    /* BB634 800CAE34 00000000 */   nop
    /* BB638 800CAE38 21186002 */  addu       $v1, $s3, $zero
  .L800CAE3C:
    /* BB63C 800CAE3C CD2B0308 */  j          .L800CAF34
    /* BB640 800CAE40 21986000 */   addu      $s3, $v1, $zero
  .L800CAE44:
    /* BB644 800CAE44 3B006104 */  bgez       $v1, .L800CAF34
    /* BB648 800CAE48 00000000 */   nop
    /* BB64C 800CAE4C 3900E012 */  beqz       $s7, .L800CAF34
    /* BB650 800CAE50 0A000224 */   addiu     $v0, $zero, 0xA
    /* BB654 800CAE54 A007238E */  lw         $v1, 0x7A0($s1)
    /* BB658 800CAE58 00000000 */  nop
    /* BB65C 800CAE5C 35006210 */  beq        $v1, $v0, .L800CAF34
    /* BB660 800CAE60 08000224 */   addiu     $v0, $zero, 0x8
    /* BB664 800CAE64 33006210 */  beq        $v1, $v0, .L800CAF34
    /* BB668 800CAE68 0200023C */   lui       $v0, (0x28000 >> 16)
    /* BB66C 800CAE6C A807248E */  lw         $a0, 0x7A8($s1)
    /* BB670 800CAE70 00804234 */  ori        $v0, $v0, (0x28000 & 0xFFFF)
    /* BB674 800CAE74 2A104400 */  slt        $v0, $v0, $a0
    /* BB678 800CAE78 18004010 */  beqz       $v0, .L800CAEDC
    /* BB67C 800CAE7C 0200123C */   lui       $s2, (0x28000 >> 16)
    /* BB680 800CAE80 00805236 */  ori        $s2, $s2, (0x28000 & 0xFFFF)
    /* BB684 800CAE84 0200053C */  lui        $a1, (0x28000 >> 16)
    /* BB688 800CAE88 0191030C */  jal        rdiv
    /* BB68C 800CAE8C 0080A534 */   ori       $a1, $a1, (0x28000 & 0xFFFF)
    /* BB690 800CAE90 40110200 */  sll        $v0, $v0, 5
    /* BB694 800CAE94 02004104 */  bgez       $v0, .L800CAEA0
    /* BB698 800CAE98 00000000 */   nop
    /* BB69C 800CAE9C 21105E00 */  addu       $v0, $v0, $fp
  .L800CAEA0:
    /* BB6A0 800CAEA0 03140200 */  sra        $v0, $v0, 16
    /* BB6A4 800CAEA4 61004228 */  slti       $v0, $v0, 0x61
    /* BB6A8 800CAEA8 0A004010 */  beqz       $v0, .L800CAED4
    /* BB6AC 800CAEAC 0200053C */   lui       $a1, (0x28000 >> 16)
    /* BB6B0 800CAEB0 A807248E */  lw         $a0, 0x7A8($s1)
    /* BB6B4 800CAEB4 0191030C */  jal        rdiv
    /* BB6B8 800CAEB8 0080A534 */   ori       $a1, $a1, (0x28000 & 0xFFFF)
    /* BB6BC 800CAEBC 40110200 */  sll        $v0, $v0, 5
    /* BB6C0 800CAEC0 08004104 */  bgez       $v0, .L800CAEE4
    /* BB6C4 800CAEC4 03840200 */   sra       $s0, $v0, 16
    /* BB6C8 800CAEC8 21105E00 */  addu       $v0, $v0, $fp
    /* BB6CC 800CAECC B92B0308 */  j          .L800CAEE4
    /* BB6D0 800CAED0 03840200 */   sra       $s0, $v0, 16
  .L800CAED4:
    /* BB6D4 800CAED4 B92B0308 */  j          .L800CAEE4
    /* BB6D8 800CAED8 60001024 */   addiu     $s0, $zero, 0x60
  .L800CAEDC:
    /* BB6DC 800CAEDC 21908000 */  addu       $s2, $a0, $zero
    /* BB6E0 800CAEE0 20001024 */  addiu      $s0, $zero, 0x20
  .L800CAEE4:
    /* BB6E4 800CAEE4 21204002 */  addu       $a0, $s2, $zero
    /* BB6E8 800CAEE8 CA90030C */  jal        fixedmult
    /* BB6EC 800CAEEC 2128E002 */   addu      $a1, $s7, $zero
    /* BB6F0 800CAEF0 21184000 */  addu       $v1, $v0, $zero
    /* BB6F4 800CAEF4 02006104 */  bgez       $v1, .L800CAF00
    /* BB6F8 800CAEF8 00000000 */   nop
    /* BB6FC 800CAEFC 21187E00 */  addu       $v1, $v1, $fp
  .L800CAF00:
    /* BB700 800CAF00 0300C292 */  lbu        $v0, 0x3($s6)
    /* BB704 800CAF04 031C0300 */  sra        $v1, $v1, 16
    /* BB708 800CAF08 2A104300 */  slt        $v0, $v0, $v1
    /* BB70C 800CAF0C 06004014 */  bnez       $v0, .L800CAF28
    /* BB710 800CAF10 43101000 */   sra       $v0, $s0, 1
    /* BB714 800CAF14 0400C292 */  lbu        $v0, 0x4($s6)
    /* BB718 800CAF18 00000000 */  nop
    /* BB71C 800CAF1C 2A105000 */  slt        $v0, $v0, $s0
    /* BB720 800CAF20 04004010 */  beqz       $v0, .L800CAF34
    /* BB724 800CAF24 43101000 */   sra       $v0, $s0, 1
  .L800CAF28:
    /* BB728 800CAF28 0500C2A2 */  sb         $v0, 0x5($s6)
    /* BB72C 800CAF2C 0400D0A2 */  sb         $s0, 0x4($s6)
    /* BB730 800CAF30 0300C3A2 */  sb         $v1, 0x3($s6)
  .L800CAF34:
    /* BB734 800CAF34 E8FF3126 */  addiu      $s1, $s1, -0x18
    /* BB738 800CAF38 772B0308 */  j          .L800CADDC
    /* BB73C 800CAF3C FFFFB526 */   addiu     $s5, $s5, -0x1
  .L800CAF40:
    /* BB740 800CAF40 1000A88F */  lw         $t0, 0x10($sp)
    /* BB744 800CAF44 00000000 */  nop
    /* BB748 800CAF48 10000011 */  beqz       $t0, .L800CAF8C
    /* BB74C 800CAF4C 21208002 */   addu      $a0, $s4, $zero
    /* BB750 800CAF50 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* BB754 800CAF54 2A104400 */  slt        $v0, $v0, $a0
    /* BB758 800CAF58 02004010 */  beqz       $v0, .L800CAF64
    /* BB75C 800CAF5C 00000000 */   nop
    /* BB760 800CAF60 0A00043C */  lui        $a0, (0xA0000 >> 16)
  .L800CAF64:
    /* BB764 800CAF64 1000A58F */  lw         $a1, 0x10($sp)
    /* BB768 800CAF68 CA90030C */  jal        fixedmult
    /* BB76C 800CAF6C 00000000 */   nop
    /* BB770 800CAF70 21204000 */  addu       $a0, $v0, $zero
    /* BB774 800CAF74 06008104 */  bgez       $a0, .L800CAF90
    /* BB778 800CAF78 03A40400 */   sra       $s4, $a0, 16
    /* BB77C 800CAF7C FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* BB780 800CAF80 21208200 */  addu       $a0, $a0, $v0
    /* BB784 800CAF84 E42B0308 */  j          .L800CAF90
    /* BB788 800CAF88 03A40400 */   sra       $s4, $a0, 16
  .L800CAF8C:
    /* BB78C 800CAF8C 21A00000 */  addu       $s4, $zero, $zero
  .L800CAF90:
    /* BB790 800CAF90 1400A88F */  lw         $t0, 0x14($sp)
    /* BB794 800CAF94 00000000 */  nop
    /* BB798 800CAF98 10000011 */  beqz       $t0, .L800CAFDC
    /* BB79C 800CAF9C 21206002 */   addu      $a0, $s3, $zero
    /* BB7A0 800CAFA0 0F00023C */  lui        $v0, (0xF0000 >> 16)
    /* BB7A4 800CAFA4 2A104400 */  slt        $v0, $v0, $a0
    /* BB7A8 800CAFA8 02004010 */  beqz       $v0, .L800CAFB4
    /* BB7AC 800CAFAC 00000000 */   nop
    /* BB7B0 800CAFB0 0F00043C */  lui        $a0, (0xF0000 >> 16)
  .L800CAFB4:
    /* BB7B4 800CAFB4 1400A58F */  lw         $a1, 0x14($sp)
    /* BB7B8 800CAFB8 CA90030C */  jal        fixedmult
    /* BB7BC 800CAFBC 00000000 */   nop
    /* BB7C0 800CAFC0 21204000 */  addu       $a0, $v0, $zero
    /* BB7C4 800CAFC4 06008104 */  bgez       $a0, .L800CAFE0
    /* BB7C8 800CAFC8 039C0400 */   sra       $s3, $a0, 16
    /* BB7CC 800CAFCC FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* BB7D0 800CAFD0 21208200 */  addu       $a0, $a0, $v0
    /* BB7D4 800CAFD4 F82B0308 */  j          .L800CAFE0
    /* BB7D8 800CAFD8 039C0400 */   sra       $s3, $a0, 16
  .L800CAFDC:
    /* BB7DC 800CAFDC 21980000 */  addu       $s3, $zero, $zero
  .L800CAFE0:
    /* BB7E0 800CAFE0 0100D4A2 */  sb         $s4, 0x1($s6)
    /* BB7E4 800CAFE4 0200D3A2 */  sb         $s3, 0x2($s6)
  .L800CAFE8:
    /* BB7E8 800CAFE8 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* BB7EC 800CAFEC 3800BE8F */  lw         $fp, 0x38($sp)
    /* BB7F0 800CAFF0 3400B78F */  lw         $s7, 0x34($sp)
    /* BB7F4 800CAFF4 3000B68F */  lw         $s6, 0x30($sp)
    /* BB7F8 800CAFF8 2C00B58F */  lw         $s5, 0x2C($sp)
    /* BB7FC 800CAFFC 2800B48F */  lw         $s4, 0x28($sp)
    /* BB800 800CB000 2400B38F */  lw         $s3, 0x24($sp)
    /* BB804 800CB004 2000B28F */  lw         $s2, 0x20($sp)
    /* BB808 800CB008 1C00B18F */  lw         $s1, 0x1C($sp)
    /* BB80C 800CB00C 1800B08F */  lw         $s0, 0x18($sp)
    /* BB810 800CB010 0800E003 */  jr         $ra
    /* BB814 800CB014 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Force_Update__FP8Car_tObj
