.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__25tScreenCarSelectTwoPlayer, 0x558

glabel DrawBackground__25tScreenCarSelectTwoPlayer
    /* 2ECBC 8003E4BC D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* 2ECC0 8003E4C0 0801B0AF */  sw         $s0, 0x108($sp)
    /* 2ECC4 8003E4C4 21808000 */  addu       $s0, $a0, $zero
    /* 2ECC8 8003E4C8 1480023C */  lui        $v0, %hi(Draw_gPlayer1View)
    /* 2ECCC 8003E4CC CCD3448C */  lw         $a0, %lo(Draw_gPlayer1View)($v0)
    /* 2ECD0 8003E4D0 1480023C */  lui        $v0, %hi(gFlip)
    /* 2ECD4 8003E4D4 B4D7458C */  lw         $a1, %lo(gFlip)($v0)
    /* 2ECD8 8003E4D8 1801B4AF */  sw         $s4, 0x118($sp)
    /* 2ECDC 8003E4DC 4F001424 */  addiu      $s4, $zero, 0x4F
    /* 2ECE0 8003E4E0 2001BFAF */  sw         $ra, 0x120($sp)
    /* 2ECE4 8003E4E4 1C01B5AF */  sw         $s5, 0x11C($sp)
    /* 2ECE8 8003E4E8 1401B3AF */  sw         $s3, 0x114($sp)
    /* 2ECEC 8003E4EC 1001B2AF */  sw         $s2, 0x110($sp)
    /* 2ECF0 8003E4F0 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* 2ECF4 8003E4F4 0C01B1AF */   sw        $s1, 0x10C($sp)
    /* 2ECF8 8003E4F8 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* 2ECFC 8003E4FC 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* 2ED00 8003E500 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* 2ED04 8003E504 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* 2ED08 8003E508 0001A527 */  addiu      $a1, $sp, 0x100
    /* 2ED0C 8003E50C 0000248D */  lw         $a0, 0x0($t1)
    /* 2ED10 8003E510 21A84000 */  addu       $s5, $v0, $zero
    /* 2ED14 8003E514 0001A0A7 */  sh         $zero, 0x100($sp)
    /* 2ED18 8003E518 0200A396 */  lhu        $v1, 0x2($s5)
    /* 2ED1C 8003E51C 00020224 */  addiu      $v0, $zero, 0x200
    /* 2ED20 8003E520 0401A2A7 */  sh         $v0, 0x104($sp)
    /* 2ED24 8003E524 1480023C */  lui        $v0, %hi(screenheight)
    /* 2ED28 8003E528 8CDC4294 */  lhu        $v0, %lo(screenheight)($v0)
    /* 2ED2C 8003E52C 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* 2ED30 8003E530 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* 2ED34 8003E534 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* 2ED38 8003E538 0201A3A7 */  sh         $v1, 0x102($sp)
    /* 2ED3C 8003E53C 0601A2A7 */  sh         $v0, 0x106($sp)
    /* 2ED40 8003E540 0000838C */  lw         $v1, 0x0($a0)
    /* 2ED44 8003E544 0000C28C */  lw         $v0, 0x0($a2)
    /* 2ED48 8003E548 24186800 */  and        $v1, $v1, $t0
    /* 2ED4C 8003E54C 24104700 */  and        $v0, $v0, $a3
    /* 2ED50 8003E550 25186200 */  or         $v1, $v1, $v0
    /* 2ED54 8003E554 000083AC */  sw         $v1, 0x0($a0)
    /* 2ED58 8003E558 0000C28C */  lw         $v0, 0x0($a2)
    /* 2ED5C 8003E55C 0C008324 */  addiu      $v1, $a0, 0xC
    /* 2ED60 8003E560 000023AD */  sw         $v1, 0x0($t1)
    /* 2ED64 8003E564 24188700 */  and        $v1, $a0, $a3
    /* 2ED68 8003E568 24104800 */  and        $v0, $v0, $t0
    /* 2ED6C 8003E56C 25104300 */  or         $v0, $v0, $v1
    /* 2ED70 8003E570 C5B8030C */  jal        SetDrawArea
    /* 2ED74 8003E574 0000C2AC */   sw        $v0, 0x0($a2)
    /* 2ED78 8003E578 0580123C */  lui        $s2, %hi(FEApp)
    /* 2ED7C 8003E57C C014438E */  lw         $v1, %lo(FEApp)($s2)
    /* 2ED80 8003E580 22010224 */  addiu      $v0, $zero, 0x122
    /* 2ED84 8003E584 2800A2A7 */  sh         $v0, 0x28($sp)
    /* 2ED88 8003E588 19000224 */  addiu      $v0, $zero, 0x19
    /* 2ED8C 8003E58C 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* 2ED90 8003E590 2C026290 */  lbu        $v0, 0x22C($v1)
    /* 2ED94 8003E594 01001324 */  addiu      $s3, $zero, 0x1
    /* 2ED98 8003E598 04005314 */  bne        $v0, $s3, .L8003E5AC
    /* 2ED9C 8003E59C C8000224 */   addiu     $v0, $zero, 0xC8
    /* 2EDA0 8003E5A0 82000224 */  addiu      $v0, $zero, 0x82
    /* 2EDA4 8003E5A4 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* 2EDA8 8003E5A8 C8000224 */  addiu      $v0, $zero, 0xC8
  .L8003E5AC:
    /* 2EDAC 8003E5AC 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* 2EDB0 8003E5B0 0C000224 */  addiu      $v0, $zero, 0xC
    /* 2EDB4 8003E5B4 3000B127 */  addiu      $s1, $sp, 0x30
    /* 2EDB8 8003E5B8 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* 2EDBC 8003E5BC 6000028E */  lw         $v0, 0x60($s0)
    /* 2EDC0 8003E5C0 21282002 */  addu       $a1, $s1, $zero
    /* 2EDC4 8003E5C4 68004484 */  lh         $a0, 0x68($v0)
    /* 2EDC8 8003E5C8 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2EDCC 8003E5CC 00000000 */  nop
    /* 2EDD0 8003E5D0 09F84000 */  jalr       $v0
    /* 2EDD4 8003E5D4 21200402 */   addu      $a0, $s0, $a0
    /* 2EDD8 8003E5D8 68004010 */  beqz       $v0, .L8003E77C
    /* 2EDDC 8003E5DC 14000324 */   addiu     $v1, $zero, 0x14
    /* 2EDE0 8003E5E0 C014428E */  lw         $v0, %lo(FEApp)($s2)
    /* 2EDE4 8003E5E4 2A00A3A7 */  sh         $v1, 0x2A($sp)
    /* 2EDE8 8003E5E8 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2EDEC 8003E5EC 00000000 */  nop
    /* 2EDF0 8003E5F0 03005314 */  bne        $v0, $s3, .L8003E600
    /* 2EDF4 8003E5F4 80000224 */   addiu     $v0, $zero, 0x80
    /* 2EDF8 8003E5F8 B8001424 */  addiu      $s4, $zero, 0xB8
    /* 2EDFC 8003E5FC 2A00A2A7 */  sh         $v0, 0x2A($sp)
  .L8003E600:
    /* 2EE00 8003E600 9C03028E */  lw         $v0, 0x39C($s0)
    /* 2EE04 8003E604 2800A527 */  addiu      $a1, $sp, 0x28
    /* 2EE08 8003E608 03004224 */  addiu      $v0, $v0, 0x3
    /* 2EE0C 8003E60C 9C0302AE */  sw         $v0, 0x39C($s0)
    /* 2EE10 8003E610 3000A483 */  lb         $a0, 0x30($sp)
    /* 2EE14 8003E614 21300000 */  addu       $a2, $zero, $zero
    /* 2EE18 8003E618 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 2EE1C 8003E61C 21018424 */   addiu     $a0, $a0, 0x121
    /* 2EE20 8003E620 6000028E */  lw         $v0, 0x60($s0)
    /* 2EE24 8003E624 21282002 */  addu       $a1, $s1, $zero
    /* 2EE28 8003E628 60004484 */  lh         $a0, 0x60($v0)
    /* 2EE2C 8003E62C 6400428C */  lw         $v0, 0x64($v0)
    /* 2EE30 8003E630 00000000 */  nop
    /* 2EE34 8003E634 09F84000 */  jalr       $v0
    /* 2EE38 8003E638 21200402 */   addu      $a0, $s0, $a0
    /* 2EE3C 8003E63C C014428E */  lw         $v0, %lo(FEApp)($s2)
    /* 2EE40 8003E640 0580033C */  lui        $v1, %hi(gCarObj)
    /* 2EE44 8003E644 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2EE48 8003E648 682A7124 */  addiu      $s1, $v1, %lo(gCarObj)
    /* 2EE4C 8003E64C 80100200 */  sll        $v0, $v0, 2
    /* 2EE50 8003E650 21105100 */  addu       $v0, $v0, $s1
    /* 2EE54 8003E654 0000428C */  lw         $v0, 0x0($v0)
    /* 2EE58 8003E658 00000000 */  nop
    /* 2EE5C 8003E65C D808428C */  lw         $v0, 0x8D8($v0)
    /* 2EE60 8003E660 00000000 */  nop
    /* 2EE64 8003E664 08004010 */  beqz       $v0, .L8003E688
    /* 2EE68 8003E668 21200002 */   addu      $a0, $s0, $zero
    /* 2EE6C 8003E66C 21280000 */  addu       $a1, $zero, $zero
    /* 2EE70 8003E670 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2EE74 8003E674 2130A000 */   addu      $a2, $a1, $zero
    /* 2EE78 8003E678 1480023C */  lui        $v0, %hi(ticks)
    /* 2EE7C 8003E67C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2EE80 8003E680 00000000 */  nop
    /* 2EE84 8003E684 7C0302AE */  sw         $v0, 0x37C($s0)
  .L8003E688:
    /* 2EE88 8003E688 C014428E */  lw         $v0, %lo(FEApp)($s2)
    /* 2EE8C 8003E68C 00000000 */  nop
    /* 2EE90 8003E690 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2EE94 8003E694 00000000 */  nop
    /* 2EE98 8003E698 80100200 */  sll        $v0, $v0, 2
    /* 2EE9C 8003E69C 21105100 */  addu       $v0, $v0, $s1
    /* 2EEA0 8003E6A0 0000428C */  lw         $v0, 0x0($v0)
    /* 2EEA4 8003E6A4 00000000 */  nop
    /* 2EEA8 8003E6A8 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2EEAC 8003E6AC 00000000 */  nop
    /* 2EEB0 8003E6B0 1A004014 */  bnez       $v0, .L8003E71C
    /* 2EEB4 8003E6B4 21200002 */   addu      $a0, $s0, $zero
    /* 2EEB8 8003E6B8 74030386 */  lh         $v1, 0x374($s0)
    /* 2EEBC 8003E6BC 78030286 */  lh         $v0, 0x378($s0)
    /* 2EEC0 8003E6C0 00000000 */  nop
    /* 2EEC4 8003E6C4 15006214 */  bne        $v1, $v0, .L8003E71C
    /* 2EEC8 8003E6C8 00000000 */   nop
    /* 2EECC 8003E6CC 13006014 */  bnez       $v1, .L8003E71C
    /* 2EED0 8003E6D0 1480023C */   lui       $v0, %hi(ticks)
    /* 2EED4 8003E6D4 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2EED8 8003E6D8 7C03038E */  lw         $v1, 0x37C($s0)
    /* 2EEDC 8003E6DC 00000000 */  nop
    /* 2EEE0 8003E6E0 23104300 */  subu       $v0, $v0, $v1
    /* 2EEE4 8003E6E4 81004228 */  slti       $v0, $v0, 0x81
    /* 2EEE8 8003E6E8 0C004014 */  bnez       $v0, .L8003E71C
    /* 2EEEC 8003E6EC 00000000 */   nop
    /* 2EEF0 8003E6F0 3700A293 */  lbu        $v0, 0x37($sp)
    /* 2EEF4 8003E6F4 00000000 */  nop
    /* 2EEF8 8003E6F8 03004010 */  beqz       $v0, .L8003E708
    /* 2EEFC 8003E6FC 20000524 */   addiu     $a1, $zero, 0x20
    /* 2EF00 8003E700 80000524 */  addiu      $a1, $zero, 0x80
    /* 2EF04 8003E704 21200002 */  addu       $a0, $s0, $zero
  .L8003E708:
    /* 2EF08 8003E708 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2EF0C 8003E70C 21300000 */   addu      $a2, $zero, $zero
    /* 2EF10 8003E710 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2EF14 8003E714 04030426 */   addiu     $a0, $s0, 0x304
    /* 2EF18 8003E718 21200002 */  addu       $a0, $s0, $zero
  .L8003E71C:
    /* 2EF1C 8003E71C 2EF1000C */  jal        UpdateBrightness__16tScreenCarSelects
    /* 2EF20 8003E720 21280000 */   addu      $a1, $zero, $zero
    /* 2EF24 8003E724 0580023C */  lui        $v0, %hi(FEApp)
    /* 2EF28 8003E728 D93F073C */  lui        $a3, (0x3FD9999A >> 16)
    /* 2EF2C 8003E72C 9A99E734 */  ori        $a3, $a3, (0x3FD9999A & 0xFFFF)
    /* 2EF30 8003E730 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 2EF34 8003E734 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2EF38 8003E738 601240AC */  sw         $zero, %lo(_front_data_org)($v0)
    /* 2EF3C 8003E73C 1EC1023C */  lui        $v0, (0xC11E6666 >> 16)
    /* 2EF40 8003E740 66664234 */  ori        $v0, $v0, (0xC11E6666 & 0xFFFF)
    /* 2EF44 8003E744 2C026390 */  lbu        $v1, 0x22C($v1)
    /* 2EF48 8003E748 3000A427 */  addiu      $a0, $sp, 0x30
    /* 2EF4C 8003E74C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2EF50 8003E750 74030292 */  lbu        $v0, 0x374($s0)
    /* 2EF54 8003E754 16010524 */  addiu      $a1, $zero, 0x116
    /* 2EF58 8003E758 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2EF5C 8003E75C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2EF60 8003E760 9C03028E */  lw         $v0, 0x39C($s0)
    /* 2EF64 8003E764 21308002 */  addu       $a2, $s4, $zero
    /* 2EF68 8003E768 2000A3AF */  sw         $v1, 0x20($sp)
    /* 2EF6C 8003E76C 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2EF70 8003E770 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 2EF74 8003E774 03FA0008 */  j          .L8003E80C
    /* 2EF78 8003E778 21200002 */   addu      $a0, $s0, $zero
  .L8003E77C:
    /* 2EF7C 8003E77C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2EF80 8003E780 3000A2A3 */  sb         $v0, 0x30($sp)
    /* 2EF84 8003E784 6000028E */  lw         $v0, 0x60($s0)
    /* 2EF88 8003E788 21282002 */  addu       $a1, $s1, $zero
    /* 2EF8C 8003E78C 60004484 */  lh         $a0, 0x60($v0)
    /* 2EF90 8003E790 6400428C */  lw         $v0, 0x64($v0)
    /* 2EF94 8003E794 00000000 */  nop
    /* 2EF98 8003E798 09F84000 */  jalr       $v0
    /* 2EF9C 8003E79C 21200402 */   addu      $a0, $s0, $a0
    /* 2EFA0 8003E7A0 D93F073C */  lui        $a3, (0x3FD9999A >> 16)
    /* 2EFA4 8003E7A4 9A99E734 */  ori        $a3, $a3, (0x3FD9999A & 0xFFFF)
    /* 2EFA8 8003E7A8 C014438E */  lw         $v1, %lo(FEApp)($s2)
    /* 2EFAC 8003E7AC 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2EFB0 8003E7B0 601240AC */  sw         $zero, %lo(_front_data_org)($v0)
    /* 2EFB4 8003E7B4 1EC1023C */  lui        $v0, (0xC11E6666 >> 16)
    /* 2EFB8 8003E7B8 66664234 */  ori        $v0, $v0, (0xC11E6666 & 0xFFFF)
    /* 2EFBC 8003E7BC 2C026390 */  lbu        $v1, 0x22C($v1)
    /* 2EFC0 8003E7C0 21202002 */  addu       $a0, $s1, $zero
    /* 2EFC4 8003E7C4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2EFC8 8003E7C8 74030292 */  lbu        $v0, 0x374($s0)
    /* 2EFCC 8003E7CC 16010524 */  addiu      $a1, $zero, 0x116
    /* 2EFD0 8003E7D0 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2EFD4 8003E7D4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2EFD8 8003E7D8 9C03028E */  lw         $v0, 0x39C($s0)
    /* 2EFDC 8003E7DC 4F000624 */  addiu      $a2, $zero, 0x4F
    /* 2EFE0 8003E7E0 2000A3AF */  sw         $v1, 0x20($sp)
    /* 2EFE4 8003E7E4 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2EFE8 8003E7E8 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 2EFEC 8003E7EC 6000028E */  lw         $v0, 0x60($s0)
    /* 2EFF0 8003E7F0 00000000 */  nop
    /* 2EFF4 8003E7F4 80004484 */  lh         $a0, 0x80($v0)
    /* 2EFF8 8003E7F8 8400428C */  lw         $v0, 0x84($v0)
    /* 2EFFC 8003E7FC 00000000 */  nop
    /* 2F000 8003E800 09F84000 */  jalr       $v0
    /* 2F004 8003E804 21200402 */   addu      $a0, $s0, $a0
    /* 2F008 8003E808 21200002 */  addu       $a0, $s0, $zero
  .L8003E80C:
    /* 2F00C 8003E80C 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2F010 8003E810 28000526 */   addiu     $a1, $s0, 0x28
    /* 2F014 8003E814 2C00028E */  lw         $v0, 0x2C($s0)
    /* 2F018 8003E818 00000000 */  nop
    /* 2F01C 8003E81C 17004010 */  beqz       $v0, .L8003E87C
    /* 2F020 8003E820 21200000 */   addu      $a0, $zero, $zero
    /* 2F024 8003E824 18030386 */  lh         $v1, 0x318($s0)
    /* 2F028 8003E828 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2F02C 8003E82C 13006210 */  beq        $v1, $v0, .L8003E87C
    /* 2F030 8003E830 0580023C */   lui       $v0, %hi(FEApp)
    /* 2F034 8003E834 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2F038 8003E838 0580033C */  lui        $v1, %hi(gCarObj)
    /* 2F03C 8003E83C 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2F040 8003E840 682A6324 */  addiu      $v1, $v1, %lo(gCarObj)
    /* 2F044 8003E844 80100200 */  sll        $v0, $v0, 2
    /* 2F048 8003E848 21104300 */  addu       $v0, $v0, $v1
    /* 2F04C 8003E84C 0000428C */  lw         $v0, 0x0($v0)
    /* 2F050 8003E850 00000000 */  nop
    /* 2F054 8003E854 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2F058 8003E858 00000000 */  nop
    /* 2F05C 8003E85C 07004014 */  bnez       $v0, .L8003E87C
    /* 2F060 8003E860 1480023C */   lui       $v0, %hi(ticks)
    /* 2F064 8003E864 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2F068 8003E868 7C03038E */  lw         $v1, 0x37C($s0)
    /* 2F06C 8003E86C 00000000 */  nop
    /* 2F070 8003E870 23104300 */  subu       $v0, $v0, $v1
    /* 2F074 8003E874 81004228 */  slti       $v0, $v0, 0x81
    /* 2F078 8003E878 01004438 */  xori       $a0, $v0, 0x1
  .L8003E87C:
    /* 2F07C 8003E87C 1E008010 */  beqz       $a0, .L8003E8F8
    /* 2F080 8003E880 0580023C */   lui       $v0, %hi(FEApp)
    /* 2F084 8003E884 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2F088 8003E888 00000000 */  nop
    /* 2F08C 8003E88C 2C024390 */  lbu        $v1, 0x22C($v0)
    /* 2F090 8003E890 01000224 */  addiu      $v0, $zero, 0x1
    /* 2F094 8003E894 02006214 */  bne        $v1, $v0, .L8003E8A0
    /* 2F098 8003E898 21380000 */   addu      $a3, $zero, $zero
    /* 2F09C 8003E89C 41000724 */  addiu      $a3, $zero, 0x41
  .L8003E8A0:
    /* 2F0A0 8003E8A0 21200002 */  addu       $a0, $s0, $zero
    /* 2F0A4 8003E8A4 28000526 */  addiu      $a1, $s0, 0x28
    /* 2F0A8 8003E8A8 21300000 */  addu       $a2, $zero, $zero
    /* 2F0AC 8003E8AC 05000224 */  addiu      $v0, $zero, 0x5
    /* 2F0B0 8003E8B0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2F0B4 8003E8B4 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 2F0B8 8003E8B8 1400A0AF */   sw        $zero, 0x14($sp)
    /* 2F0BC 8003E8BC BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2F0C0 8003E8C0 04030426 */   addiu     $a0, $s0, 0x304
    /* 2F0C4 8003E8C4 78030386 */  lh         $v1, 0x378($s0)
    /* 2F0C8 8003E8C8 74030286 */  lh         $v0, 0x374($s0)
    /* 2F0CC 8003E8CC 00000000 */  nop
    /* 2F0D0 8003E8D0 0A006214 */  bne        $v1, $v0, .L8003E8FC
    /* 2F0D4 8003E8D4 0580113C */   lui       $s1, %hi(FEApp)
    /* 2F0D8 8003E8D8 3700A293 */  lbu        $v0, 0x37($sp)
    /* 2F0DC 8003E8DC 00000000 */  nop
    /* 2F0E0 8003E8E0 02004010 */  beqz       $v0, .L8003E8EC
    /* 2F0E4 8003E8E4 20000524 */   addiu     $a1, $zero, 0x20
    /* 2F0E8 8003E8E8 80000524 */  addiu      $a1, $zero, 0x80
  .L8003E8EC:
    /* 2F0EC 8003E8EC 21200002 */  addu       $a0, $s0, $zero
    /* 2F0F0 8003E8F0 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2F0F4 8003E8F4 21300000 */   addu      $a2, $zero, $zero
  .L8003E8F8:
    /* 2F0F8 8003E8F8 0580113C */  lui        $s1, %hi(FEApp)
  .L8003E8FC:
    /* 2F0FC 8003E8FC C014228E */  lw         $v0, %lo(FEApp)($s1)
    /* 2F100 8003E900 2A00A0A7 */  sh         $zero, 0x2A($sp)
    /* 2F104 8003E904 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2F108 8003E908 01001224 */  addiu      $s2, $zero, 0x1
    /* 2F10C 8003E90C 02005214 */  bne        $v0, $s2, .L8003E918
    /* 2F110 8003E910 69000224 */   addiu     $v0, $zero, 0x69
    /* 2F114 8003E914 2A00A2A7 */  sh         $v0, 0x2A($sp)
  .L8003E918:
    /* 2F118 8003E918 6000028E */  lw         $v0, 0x60($s0)
    /* 2F11C 8003E91C 2A00A587 */  lh         $a1, 0x2A($sp)
    /* 2F120 8003E920 50004484 */  lh         $a0, 0x50($v0)
    /* 2F124 8003E924 5400428C */  lw         $v0, 0x54($v0)
    /* 2F128 8003E928 00000000 */  nop
    /* 2F12C 8003E92C 09F84000 */  jalr       $v0
    /* 2F130 8003E930 21200402 */   addu      $a0, $s0, $a0
    /* 2F134 8003E934 6000028E */  lw         $v0, 0x60($s0)
    /* 2F138 8003E938 00000000 */  nop
    /* 2F13C 8003E93C 88004484 */  lh         $a0, 0x88($v0)
    /* 2F140 8003E940 8C00428C */  lw         $v0, 0x8C($v0)
    /* 2F144 8003E944 00000000 */  nop
    /* 2F148 8003E948 09F84000 */  jalr       $v0
    /* 2F14C 8003E94C 21200402 */   addu      $a0, $s0, $a0
    /* 2F150 8003E950 1480023C */  lui        $v0, %hi(screenheight)
    /* 2F154 8003E954 0001A0A7 */  sh         $zero, 0x100($sp)
    /* 2F158 8003E958 0200A496 */  lhu        $a0, 0x2($s5)
    /* 2F15C 8003E95C 8CDC438C */  lw         $v1, %lo(screenheight)($v0)
    /* 2F160 8003E960 00020224 */  addiu      $v0, $zero, 0x200
    /* 2F164 8003E964 0401A2A7 */  sh         $v0, 0x104($sp)
    /* 2F168 8003E968 C2170300 */  srl        $v0, $v1, 31
    /* 2F16C 8003E96C 21186200 */  addu       $v1, $v1, $v0
    /* 2F170 8003E970 C014228E */  lw         $v0, %lo(FEApp)($s1)
    /* 2F174 8003E974 43180300 */  sra        $v1, $v1, 1
    /* 2F178 8003E978 0201A4A7 */  sh         $a0, 0x102($sp)
    /* 2F17C 8003E97C 0601A3A7 */  sh         $v1, 0x106($sp)
    /* 2F180 8003E980 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2F184 8003E984 00000000 */  nop
    /* 2F188 8003E988 03005214 */  bne        $v0, $s2, .L8003E998
    /* 2F18C 8003E98C 801F093C */   lui       $t1, (0x1F800004 >> 16)
    /* 2F190 8003E990 21108300 */  addu       $v0, $a0, $v1
    /* 2F194 8003E994 0201A2A7 */  sh         $v0, 0x102($sp)
  .L8003E998:
    /* 2F198 8003E998 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* 2F19C 8003E99C FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* 2F1A0 8003E9A0 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* 2F1A4 8003E9A4 0001A527 */  addiu      $a1, $sp, 0x100
    /* 2F1A8 8003E9A8 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* 2F1AC 8003E9AC 0000248D */  lw         $a0, 0x0($t1)
    /* 2F1B0 8003E9B0 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* 2F1B4 8003E9B4 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* 2F1B8 8003E9B8 0000838C */  lw         $v1, 0x0($a0)
    /* 2F1BC 8003E9BC 0000C28C */  lw         $v0, 0x0($a2)
    /* 2F1C0 8003E9C0 24186800 */  and        $v1, $v1, $t0
    /* 2F1C4 8003E9C4 24104700 */  and        $v0, $v0, $a3
    /* 2F1C8 8003E9C8 25186200 */  or         $v1, $v1, $v0
    /* 2F1CC 8003E9CC 000083AC */  sw         $v1, 0x0($a0)
    /* 2F1D0 8003E9D0 0000C28C */  lw         $v0, 0x0($a2)
    /* 2F1D4 8003E9D4 0C008324 */  addiu      $v1, $a0, 0xC
    /* 2F1D8 8003E9D8 000023AD */  sw         $v1, 0x0($t1)
    /* 2F1DC 8003E9DC 24188700 */  and        $v1, $a0, $a3
    /* 2F1E0 8003E9E0 24104800 */  and        $v0, $v0, $t0
    /* 2F1E4 8003E9E4 25104300 */  or         $v0, $v0, $v1
    /* 2F1E8 8003E9E8 C5B8030C */  jal        SetDrawArea
    /* 2F1EC 8003E9EC 0000C2AC */   sw        $v0, 0x0($a2)
    /* 2F1F0 8003E9F0 2001BF8F */  lw         $ra, 0x120($sp)
    /* 2F1F4 8003E9F4 1C01B58F */  lw         $s5, 0x11C($sp)
    /* 2F1F8 8003E9F8 1801B48F */  lw         $s4, 0x118($sp)
    /* 2F1FC 8003E9FC 1401B38F */  lw         $s3, 0x114($sp)
    /* 2F200 8003EA00 1001B28F */  lw         $s2, 0x110($sp)
    /* 2F204 8003EA04 0C01B18F */  lw         $s1, 0x10C($sp)
    /* 2F208 8003EA08 0801B08F */  lw         $s0, 0x108($sp)
    /* 2F20C 8003EA0C 0800E003 */  jr         $ra
    /* 2F210 8003EA10 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel DrawBackground__25tScreenCarSelectTwoPlayer
