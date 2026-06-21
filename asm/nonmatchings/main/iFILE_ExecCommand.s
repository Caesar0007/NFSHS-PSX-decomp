.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching iFILE_ExecCommand, 0x488

glabel iFILE_ExecCommand
    /* DD398 800ECB98 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* DD39C 800ECB9C A400B1AF */  sw         $s1, 0xA4($sp)
    /* DD3A0 800ECBA0 21888000 */  addu       $s1, $a0, $zero
    /* DD3A4 800ECBA4 B000BFAF */  sw         $ra, 0xB0($sp)
    /* DD3A8 800ECBA8 AC00B3AF */  sw         $s3, 0xAC($sp)
    /* DD3AC 800ECBAC A800B2AF */  sw         $s2, 0xA8($sp)
    /* DD3B0 800ECBB0 A000B0AF */  sw         $s0, 0xA0($sp)
    /* DD3B4 800ECBB4 00600640 */  mfc0       $a2, $12 /* handwritten instruction */
    /* DD3B8 800ECBB8 00000000 */  nop
    /* DD3BC 800ECBBC FEFB0124 */  addiu      $at, $zero, -0x402
    /* DD3C0 800ECBC0 2440C100 */  and        $t0, $a2, $at
    /* DD3C4 800ECBC4 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DD3C8 800ECBC8 00000000 */  nop
    /* DD3CC 800ECBCC 00000000 */  nop
    /* DD3D0 800ECBD0 00000000 */  nop
    /* DD3D4 800ECBD4 1D002012 */  beqz       $s1, .L800ECC4C
    /* DD3D8 800ECBD8 1480023C */   lui       $v0, %hi(D_8013EAA8)
    /* DD3DC 800ECBDC A8EA428C */  lw         $v0, %lo(D_8013EAA8)($v0)
    /* DD3E0 800ECBE0 21200000 */  addu       $a0, $zero, $zero
    /* DD3E4 800ECBE4 0E004010 */  beqz       $v0, .L800ECC20
    /* DD3E8 800ECBE8 2C0022AE */   sw        $v0, 0x2C($s1)
    /* DD3EC 800ECBEC 1000258E */  lw         $a1, 0x10($s1)
  .L800ECBF0:
    /* DD3F0 800ECBF0 2C00238E */  lw         $v1, 0x2C($s1)
    /* DD3F4 800ECBF4 00000000 */  nop
    /* DD3F8 800ECBF8 1000628C */  lw         $v0, 0x10($v1)
    /* DD3FC 800ECBFC 00000000 */  nop
    /* DD400 800ECC00 2A10A200 */  slt        $v0, $a1, $v0
    /* DD404 800ECC04 06004014 */  bnez       $v0, .L800ECC20
    /* DD408 800ECC08 00000000 */   nop
    /* DD40C 800ECC0C 21206000 */  addu       $a0, $v1, $zero
    /* DD410 800ECC10 2C00628C */  lw         $v0, 0x2C($v1)
    /* DD414 800ECC14 00000000 */  nop
    /* DD418 800ECC18 F5FF4014 */  bnez       $v0, .L800ECBF0
    /* DD41C 800ECC1C 2C0022AE */   sw        $v0, 0x2C($s1)
  .L800ECC20:
    /* DD420 800ECC20 03008010 */  beqz       $a0, .L800ECC30
    /* DD424 800ECC24 1480023C */   lui       $v0, %hi(D_8013EAA8)
    /* DD428 800ECC28 0DB30308 */  j          .L800ECC34
    /* DD42C 800ECC2C 2C0091AC */   sw        $s1, 0x2C($a0)
  .L800ECC30:
    /* DD430 800ECC30 A8EA51AC */  sw         $s1, %lo(D_8013EAA8)($v0)
  .L800ECC34:
    /* DD434 800ECC34 1480033C */  lui        $v1, %hi(gFileDevice)
    /* DD438 800ECC38 88EA6324 */  addiu      $v1, $v1, %lo(gFileDevice)
    /* DD43C 800ECC3C 0C00628C */  lw         $v0, 0xC($v1)
    /* DD440 800ECC40 00000000 */  nop
    /* DD444 800ECC44 01004224 */  addiu      $v0, $v0, 0x1
    /* DD448 800ECC48 0C0062AC */  sw         $v0, 0xC($v1)
  .L800ECC4C:
    /* DD44C 800ECC4C 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DD450 800ECC50 88EA4424 */  addiu      $a0, $v0, %lo(gFileDevice)
    /* DD454 800ECC54 1400828C */  lw         $v0, 0x14($a0)
    /* DD458 800ECC58 00000000 */  nop
    /* DD45C 800ECC5C 04004010 */  beqz       $v0, .L800ECC70
    /* DD460 800ECC60 00000000 */   nop
    /* DD464 800ECC64 00608640 */  mtc0       $a2, $12 /* handwritten instruction */
    /* DD468 800ECC68 01B40308 */  j          .L800ED004
    /* DD46C 800ECC6C 00000000 */   nop
  .L800ECC70:
    /* DD470 800ECC70 2000918C */  lw         $s1, 0x20($a0)
    /* DD474 800ECC74 00000000 */  nop
    /* DD478 800ECC78 0D002012 */  beqz       $s1, .L800ECCB0
    /* DD47C 800ECC7C 00000000 */   nop
    /* DD480 800ECC80 1000238E */  lw         $v1, 0x10($s1)
    /* DD484 800ECC84 0800828C */  lw         $v0, 0x8($a0)
    /* DD488 800ECC88 00000000 */  nop
    /* DD48C 800ECC8C 2A104300 */  slt        $v0, $v0, $v1
    /* DD490 800ECC90 07004014 */  bnez       $v0, .L800ECCB0
    /* DD494 800ECC94 00000000 */   nop
    /* DD498 800ECC98 0C00828C */  lw         $v0, 0xC($a0)
    /* DD49C 800ECC9C 2C00238E */  lw         $v1, 0x2C($s1)
    /* DD4A0 800ECCA0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DD4A4 800ECCA4 200083AC */  sw         $v1, 0x20($a0)
    /* DD4A8 800ECCA8 2DB30308 */  j          .L800ECCB4
    /* DD4AC 800ECCAC 0C0082AC */   sw        $v0, 0xC($a0)
  .L800ECCB0:
    /* DD4B0 800ECCB0 21880000 */  addu       $s1, $zero, $zero
  .L800ECCB4:
    /* DD4B4 800ECCB4 1480023C */  lui        $v0, %hi(D_8013EA9C)
    /* DD4B8 800ECCB8 9CEA51AC */  sw         $s1, %lo(D_8013EA9C)($v0)
    /* DD4BC 800ECCBC 00608640 */  mtc0       $a2, $12 /* handwritten instruction */
    /* DD4C0 800ECCC0 D0002012 */  beqz       $s1, .L800ED004
    /* DD4C4 800ECCC4 00000000 */   nop
    /* DD4C8 800ECCC8 0000228E */  lw         $v0, 0x0($s1)
    /* DD4CC 800ECCCC 00000000 */  nop
    /* DD4D0 800ECCD0 02150200 */  srl        $v0, $v0, 20
    /* DD4D4 800ECCD4 0F004230 */  andi       $v0, $v0, 0xF
    /* DD4D8 800ECCD8 FEFF4324 */  addiu      $v1, $v0, -0x2
    /* DD4DC 800ECCDC 0900622C */  sltiu      $v0, $v1, 0x9
    /* DD4E0 800ECCE0 C8004010 */  beqz       $v0, .L800ED004
    /* DD4E4 800ECCE4 0580023C */   lui       $v0, %hi(jtbl_80056C94)
    /* DD4E8 800ECCE8 946C4224 */  addiu      $v0, $v0, %lo(jtbl_80056C94)
    /* DD4EC 800ECCEC 80180300 */  sll        $v1, $v1, 2
    /* DD4F0 800ECCF0 21186200 */  addu       $v1, $v1, $v0
    /* DD4F4 800ECCF4 0000628C */  lw         $v0, 0x0($v1)
    /* DD4F8 800ECCF8 00000000 */  nop
    /* DD4FC 800ECCFC 08004000 */  jr         $v0
    /* DD500 800ECD00 00000000 */   nop
  jlabel .L800ECD04
    /* DD504 800ECD04 5800A0A3 */  sb         $zero, 0x58($sp)
    /* DD508 800ECD08 2400248E */  lw         $a0, 0x24($s1)
    /* DD50C 800ECD0C 7C000524 */  addiu      $a1, $zero, 0x7C
    /* DD510 800ECD10 85D8030C */  jal        strchr
    /* DD514 800ECD14 0C008424 */   addiu     $a0, $a0, 0xC
    /* DD518 800ECD18 1D004010 */  beqz       $v0, .L800ECD90
    /* DD51C 800ECD1C 7C000224 */   addiu     $v0, $zero, 0x7C
    /* DD520 800ECD20 2400248E */  lw         $a0, 0x24($s1)
    /* DD524 800ECD24 00000000 */  nop
    /* DD528 800ECD28 0C008390 */  lbu        $v1, 0xC($a0)
    /* DD52C 800ECD2C 00000000 */  nop
    /* DD530 800ECD30 11006210 */  beq        $v1, $v0, .L800ECD78
    /* DD534 800ECD34 02001324 */   addiu     $s3, $zero, 0x2
    /* DD538 800ECD38 0C008424 */  addiu      $a0, $a0, 0xC
    /* DD53C 800ECD3C 85D8030C */  jal        strchr
    /* DD540 800ECD40 7C000524 */   addiu     $a1, $zero, 0x7C
    /* DD544 800ECD44 1800A427 */  addiu      $a0, $sp, 0x18
    /* DD548 800ECD48 2400238E */  lw         $v1, 0x24($s1)
    /* DD54C 800ECD4C 04001324 */  addiu      $s3, $zero, 0x4
    /* DD550 800ECD50 1800A0A3 */  sb         $zero, 0x18($sp)
    /* DD554 800ECD54 2400258E */  lw         $a1, 0x24($s1)
    /* DD558 800ECD58 F4FF5024 */  addiu      $s0, $v0, -0xC
    /* DD55C 800ECD5C 0C00A524 */  addiu      $a1, $a1, 0xC
    /* DD560 800ECD60 23800302 */  subu       $s0, $s0, $v1
    /* DD564 800ECD64 41D8030C */  jal        strncpy
    /* DD568 800ECD68 21300002 */   addu      $a2, $s0, $zero
    /* DD56C 800ECD6C 2110B003 */  addu       $v0, $sp, $s0
    /* DD570 800ECD70 180040A0 */  sb         $zero, 0x18($v0)
    /* DD574 800ECD74 2400248E */  lw         $a0, 0x24($s1)
  .L800ECD78:
    /* DD578 800ECD78 7C000524 */  addiu      $a1, $zero, 0x7C
    /* DD57C 800ECD7C 85D8030C */  jal        strchr
    /* DD580 800ECD80 0C008424 */   addiu     $a0, $a0, 0xC
    /* DD584 800ECD84 5800A427 */  addiu      $a0, $sp, 0x58
    /* DD588 800ECD88 6DB30308 */  j          .L800ECDB4
    /* DD58C 800ECD8C 01004524 */   addiu     $a1, $v0, 0x1
  .L800ECD90:
    /* DD590 800ECD90 1800228E */  lw         $v0, 0x18($s1)
    /* DD594 800ECD94 01001324 */  addiu      $s3, $zero, 0x1
    /* DD598 800ECD98 24105300 */  and        $v0, $v0, $s3
    /* DD59C 800ECD9C 07004010 */  beqz       $v0, .L800ECDBC
    /* DD5A0 800ECDA0 5800A427 */   addiu     $a0, $sp, 0x58
    /* DD5A4 800ECDA4 03001324 */  addiu      $s3, $zero, 0x3
    /* DD5A8 800ECDA8 2400258E */  lw         $a1, 0x24($s1)
    /* DD5AC 800ECDAC 00000000 */  nop
    /* DD5B0 800ECDB0 0C00A524 */  addiu      $a1, $a1, 0xC
  .L800ECDB4:
    /* DD5B4 800ECDB4 CA96030C */  jal        strcpy
    /* DD5B8 800ECDB8 00000000 */   nop
  .L800ECDBC:
    /* DD5BC 800ECDBC 01006232 */  andi       $v0, $s3, 0x1
    /* DD5C0 800ECDC0 1C004010 */  beqz       $v0, .L800ECE34
    /* DD5C4 800ECDC4 21900000 */   addu      $s2, $zero, $zero
    /* DD5C8 800ECDC8 2400268E */  lw         $a2, 0x24($s1)
    /* DD5CC 800ECDCC 1800258E */  lw         $a1, 0x18($s1)
    /* DD5D0 800ECDD0 F8CE030C */  jal        openfile
    /* DD5D4 800ECDD4 0C00C424 */   addiu     $a0, $a2, 0xC
    /* DD5D8 800ECDD8 16004010 */  beqz       $v0, .L800ECE34
    /* DD5DC 800ECDDC 08000324 */   addiu     $v1, $zero, 0x8
    /* DD5E0 800ECDE0 0000228E */  lw         $v0, 0x0($s1)
    /* DD5E4 800ECDE4 00000000 */  nop
    /* DD5E8 800ECDE8 02150200 */  srl        $v0, $v0, 20
    /* DD5EC 800ECDEC 0F004230 */  andi       $v0, $v0, 0xF
    /* DD5F0 800ECDF0 08004314 */  bne        $v0, $v1, .L800ECE14
    /* DD5F4 800ECDF4 01001224 */   addiu     $s2, $zero, 0x1
    /* DD5F8 800ECDF8 2400228E */  lw         $v0, 0x24($s1)
    /* DD5FC 800ECDFC 00000000 */  nop
    /* DD600 800ECE00 0000448C */  lw         $a0, 0x0($v0)
    /* DD604 800ECE04 A1CF030C */  jal        closefile
    /* DD608 800ECE08 00000000 */   nop
    /* DD60C 800ECE0C 8DB30308 */  j          .L800ECE34
    /* DD610 800ECE10 00000000 */   nop
  .L800ECE14:
    /* DD614 800ECE14 2400228E */  lw         $v0, 0x24($s1)
    /* DD618 800ECE18 00000000 */  nop
    /* DD61C 800ECE1C 0000448C */  lw         $a0, 0x0($v0)
    /* DD620 800ECE20 27D0030C */  jal        getfilesize
    /* DD624 800ECE24 00000000 */   nop
    /* DD628 800ECE28 2400238E */  lw         $v1, 0x24($s1)
    /* DD62C 800ECE2C 00000000 */  nop
    /* DD630 800ECE30 040062AC */  sw         $v0, 0x4($v1)
  .L800ECE34:
    /* DD634 800ECE34 28004016 */  bnez       $s2, .L800ECED8
    /* DD638 800ECE38 06006232 */   andi      $v0, $s3, 0x6
    /* DD63C 800ECE3C 26004010 */  beqz       $v0, .L800ECED8
    /* DD640 800ECE40 1480023C */   lui       $v0, %hi(D_8013EAAC)
    /* DD644 800ECE44 ACEA508C */  lw         $s0, %lo(D_8013EAAC)($v0)
    /* DD648 800ECE48 00000000 */  nop
    /* DD64C 800ECE4C 22000012 */  beqz       $s0, .L800ECED8
    /* DD650 800ECE50 04006232 */   andi      $v0, $s3, 0x4
  .L800ECE54:
    /* DD654 800ECE54 06004010 */  beqz       $v0, .L800ECE70
    /* DD658 800ECE58 1800A527 */   addiu     $a1, $sp, 0x18
    /* DD65C 800ECE5C 0400048E */  lw         $a0, 0x4($s0)
    /* DD660 800ECE60 5F97030C */  jal        strcmp
    /* DD664 800ECE64 0C008424 */   addiu     $a0, $a0, 0xC
    /* DD668 800ECE68 15004014 */  bnez       $v0, .L800ECEC0
    /* DD66C 800ECE6C 00000000 */   nop
  .L800ECE70:
    /* DD670 800ECE70 5800A527 */  addiu      $a1, $sp, 0x58
    /* DD674 800ECE74 21300000 */  addu       $a2, $zero, $zero
    /* DD678 800ECE78 9C00A227 */  addiu      $v0, $sp, 0x9C
    /* DD67C 800ECE7C 1000A2AF */  sw         $v0, 0x10($sp)
    /* DD680 800ECE80 0000048E */  lw         $a0, 0x0($s0)
    /* DD684 800ECE84 FF97030C */  jal        locatebigentryz
    /* DD688 800ECE88 9800A727 */   addiu     $a3, $sp, 0x98
    /* DD68C 800ECE8C 0C004010 */  beqz       $v0, .L800ECEC0
    /* DD690 800ECE90 00000000 */   nop
    /* DD694 800ECE94 2400228E */  lw         $v0, 0x24($s1)
    /* DD698 800ECE98 00000000 */  nop
    /* DD69C 800ECE9C 000050AC */  sw         $s0, 0x0($v0)
    /* DD6A0 800ECEA0 2400238E */  lw         $v1, 0x24($s1)
    /* DD6A4 800ECEA4 9C00A28F */  lw         $v0, 0x9C($sp)
    /* DD6A8 800ECEA8 00000000 */  nop
    /* DD6AC 800ECEAC 040062AC */  sw         $v0, 0x4($v1)
    /* DD6B0 800ECEB0 2400238E */  lw         $v1, 0x24($s1)
    /* DD6B4 800ECEB4 9800A28F */  lw         $v0, 0x98($sp)
    /* DD6B8 800ECEB8 01001224 */  addiu      $s2, $zero, 0x1
    /* DD6BC 800ECEBC 080062AC */  sw         $v0, 0x8($v1)
  .L800ECEC0:
    /* DD6C0 800ECEC0 0C00108E */  lw         $s0, 0xC($s0)
    /* DD6C4 800ECEC4 00000000 */  nop
    /* DD6C8 800ECEC8 03000012 */  beqz       $s0, .L800ECED8
    /* DD6CC 800ECECC 00000000 */   nop
    /* DD6D0 800ECED0 E0FF4012 */  beqz       $s2, .L800ECE54
    /* DD6D4 800ECED4 04006232 */   andi      $v0, $s3, 0x4
  .L800ECED8:
    /* DD6D8 800ECED8 0000228E */  lw         $v0, 0x0($s1)
    /* DD6DC 800ECEDC 08000324 */  addiu      $v1, $zero, 0x8
    /* DD6E0 800ECEE0 02150200 */  srl        $v0, $v0, 20
    /* DD6E4 800ECEE4 0F004230 */  andi       $v0, $v0, 0xF
    /* DD6E8 800ECEE8 05004314 */  bne        $v0, $v1, .L800ECF00
    /* DD6EC 800ECEEC 00000000 */   nop
    /* DD6F0 800ECEF0 2400248E */  lw         $a0, 0x24($s1)
    /* DD6F4 800ECEF4 BCB4030C */  jal        freehandle
    /* DD6F8 800ECEF8 00000000 */   nop
    /* DD6FC 800ECEFC 180032AE */  sw         $s2, 0x18($s1)
  .L800ECF00:
    /* DD700 800ECF00 FFB30308 */  j          .L800ECFFC
    /* DD704 800ECF04 21204002 */   addu      $a0, $s2, $zero
  jlabel .L800ECF08
    /* DD708 800ECF08 2400248E */  lw         $a0, 0x24($s1)
    /* DD70C 800ECF0C 00000000 */  nop
    /* DD710 800ECF10 37008010 */  beqz       $a0, .L800ECFF0
    /* DD714 800ECF14 0C0020AE */   sw        $zero, 0xC($s1)
    /* DD718 800ECF18 0800828C */  lw         $v0, 0x8($a0)
    /* DD71C 800ECF1C 00000000 */  nop
    /* DD720 800ECF20 05004014 */  bnez       $v0, .L800ECF38
    /* DD724 800ECF24 00000000 */   nop
    /* DD728 800ECF28 0000848C */  lw         $a0, 0x0($a0)
    /* DD72C 800ECF2C A1CF030C */  jal        closefile
    /* DD730 800ECF30 00000000 */   nop
    /* DD734 800ECF34 0C0022AE */  sw         $v0, 0xC($s1)
  .L800ECF38:
    /* DD738 800ECF38 2400248E */  lw         $a0, 0x24($s1)
    /* DD73C 800ECF3C BCB4030C */  jal        freehandle
    /* DD740 800ECF40 00000000 */   nop
    /* DD744 800ECF44 FCB30308 */  j          .L800ECFF0
    /* DD748 800ECF48 240020AE */   sw        $zero, 0x24($s1)
  jlabel .L800ECF4C
    /* DD74C 800ECF4C 1C00278E */  lw         $a3, 0x1C($s1)
    /* DD750 800ECF50 00000000 */  nop
    /* DD754 800ECF54 2900E018 */  blez       $a3, .L800ECFFC
    /* DD758 800ECF58 01000424 */   addiu     $a0, $zero, 0x1
    /* DD75C 800ECF5C 2400228E */  lw         $v0, 0x24($s1)
    /* DD760 800ECF60 00000000 */  nop
    /* DD764 800ECF64 0800438C */  lw         $v1, 0x8($v0)
    /* DD768 800ECF68 00000000 */  nop
    /* DD76C 800ECF6C 0A006010 */  beqz       $v1, .L800ECF98
    /* DD770 800ECF70 00000000 */   nop
    /* DD774 800ECF74 0000428C */  lw         $v0, 0x0($v0)
    /* DD778 800ECF78 2000258E */  lw         $a1, 0x20($s1)
    /* DD77C 800ECF7C 0400428C */  lw         $v0, 0x4($v0)
    /* DD780 800ECF80 1800268E */  lw         $a2, 0x18($s1)
    /* DD784 800ECF84 0000448C */  lw         $a0, 0x0($v0)
    /* DD788 800ECF88 B8CF030C */  jal        readfile
    /* DD78C 800ECF8C 21306600 */   addu      $a2, $v1, $a2
    /* DD790 800ECF90 01B40308 */  j          .L800ED004
    /* DD794 800ECF94 00000000 */   nop
  .L800ECF98:
    /* DD798 800ECF98 0000448C */  lw         $a0, 0x0($v0)
    /* DD79C 800ECF9C 2000258E */  lw         $a1, 0x20($s1)
    /* DD7A0 800ECFA0 1800268E */  lw         $a2, 0x18($s1)
    /* DD7A4 800ECFA4 B8CF030C */  jal        readfile
    /* DD7A8 800ECFA8 00000000 */   nop
    /* DD7AC 800ECFAC 01B40308 */  j          .L800ED004
    /* DD7B0 800ECFB0 00000000 */   nop
  jlabel .L800ECFB4
    /* DD7B4 800ECFB4 2000258E */  lw         $a1, 0x20($s1)
    /* DD7B8 800ECFB8 1800268E */  lw         $a2, 0x18($s1)
    /* DD7BC 800ECFBC 2400228E */  lw         $v0, 0x24($s1)
    /* DD7C0 800ECFC0 1C00278E */  lw         $a3, 0x1C($s1)
    /* DD7C4 800ECFC4 0000448C */  lw         $a0, 0x0($v0)
    /* DD7C8 800ECFC8 08D0030C */  jal        writefile
    /* DD7CC 800ECFCC 00000000 */   nop
    /* DD7D0 800ECFD0 01B40308 */  j          .L800ED004
    /* DD7D4 800ECFD4 00000000 */   nop
  jlabel .L800ECFD8
    /* DD7D8 800ECFD8 2400228E */  lw         $v0, 0x24($s1)
    /* DD7DC 800ECFDC 00000000 */  nop
    /* DD7E0 800ECFE0 0400428C */  lw         $v0, 0x4($v0)
    /* DD7E4 800ECFE4 01000424 */  addiu      $a0, $zero, 0x1
    /* DD7E8 800ECFE8 FFB30308 */  j          .L800ECFFC
    /* DD7EC 800ECFEC 180022AE */   sw        $v0, 0x18($s1)
  jlabel .L800ECFF0
    /* DD7F0 800ECFF0 0C00248E */  lw         $a0, 0xC($s1)
    /* DD7F4 800ECFF4 00000000 */  nop
    /* DD7F8 800ECFF8 0100842C */  sltiu      $a0, $a0, 0x1
  .L800ECFFC:
    /* DD7FC 800ECFFC 08B4030C */  jal        iFILE_CommandCompleteCallback
    /* DD800 800ED000 00000000 */   nop
  .L800ED004:
    /* DD804 800ED004 B000BF8F */  lw         $ra, 0xB0($sp)
    /* DD808 800ED008 AC00B38F */  lw         $s3, 0xAC($sp)
    /* DD80C 800ED00C A800B28F */  lw         $s2, 0xA8($sp)
    /* DD810 800ED010 A400B18F */  lw         $s1, 0xA4($sp)
    /* DD814 800ED014 A000B08F */  lw         $s0, 0xA0($sp)
    /* DD818 800ED018 0800E003 */  jr         $ra
    /* DD81C 800ED01C B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel iFILE_ExecCommand
