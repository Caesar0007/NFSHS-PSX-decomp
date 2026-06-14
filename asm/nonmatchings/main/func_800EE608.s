.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EE608, 0x270

glabel func_800EE608
    /* DEE08 800EE608 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DEE0C 800EE60C 1800B0AF */  sw         $s0, 0x18($sp)
    /* DEE10 800EE610 2180A000 */  addu       $s0, $a1, $zero
    /* DEE14 800EE614 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* DEE18 800EE618 21888000 */  addu       $s1, $a0, $zero
    /* DEE1C 800EE61C 2000BFAF */  sw         $ra, 0x20($sp)
    /* DEE20 800EE620 00000486 */  lh         $a0, 0x0($s0)
    /* DEE24 800EE624 02000586 */  lh         $a1, 0x2($s0)
    /* DEE28 800EE628 26BA030C */  jal        func_800EE898
    /* DEE2C 800EE62C 00000000 */   nop
    /* DEE30 800EE630 040022AE */  sw         $v0, 0x4($s1)
    /* DEE34 800EE634 04000496 */  lhu        $a0, 0x4($s0)
    /* DEE38 800EE638 00000296 */  lhu        $v0, 0x0($s0)
    /* DEE3C 800EE63C 02000596 */  lhu        $a1, 0x2($s0)
    /* DEE40 800EE640 21208200 */  addu       $a0, $a0, $v0
    /* DEE44 800EE644 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* DEE48 800EE648 00240400 */  sll        $a0, $a0, 16
    /* DEE4C 800EE64C 06000296 */  lhu        $v0, 0x6($s0)
    /* DEE50 800EE650 03240400 */  sra        $a0, $a0, 16
    /* DEE54 800EE654 2128A200 */  addu       $a1, $a1, $v0
    /* DEE58 800EE658 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* DEE5C 800EE65C 002C0500 */  sll        $a1, $a1, 16
    /* DEE60 800EE660 4CBA030C */  jal        func_800EE930
    /* DEE64 800EE664 032C0500 */   sra       $a1, $a1, 16
    /* DEE68 800EE668 080022AE */  sw         $v0, 0x8($s1)
    /* DEE6C 800EE66C 08000486 */  lh         $a0, 0x8($s0)
    /* DEE70 800EE670 0A000586 */  lh         $a1, 0xA($s0)
    /* DEE74 800EE674 72BA030C */  jal        func_800EE9C8
    /* DEE78 800EE678 00000000 */   nop
    /* DEE7C 800EE67C 0C0022AE */  sw         $v0, 0xC($s1)
    /* DEE80 800EE680 17000492 */  lbu        $a0, 0x17($s0)
    /* DEE84 800EE684 16000592 */  lbu        $a1, 0x16($s0)
    /* DEE88 800EE688 14000696 */  lhu        $a2, 0x14($s0)
    /* DEE8C 800EE68C 1EBA030C */  jal        func_800EE878
    /* DEE90 800EE690 00000000 */   nop
    /* DEE94 800EE694 0C000426 */  addiu      $a0, $s0, 0xC
    /* DEE98 800EE698 79BA030C */  jal        func_800EE9E4
    /* DEE9C 800EE69C 100022AE */   sw        $v0, 0x10($s1)
    /* DEEA0 800EE6A0 140022AE */  sw         $v0, 0x14($s1)
    /* DEEA4 800EE6A4 00E6023C */  lui        $v0, (0xE6000000 >> 16)
    /* DEEA8 800EE6A8 180022AE */  sw         $v0, 0x18($s1)
    /* DEEAC 800EE6AC 18000292 */  lbu        $v0, 0x18($s0)
    /* DEEB0 800EE6B0 00000000 */  nop
    /* DEEB4 800EE6B4 69004010 */  beqz       $v0, .L800EE85C
    /* DEEB8 800EE6B8 07000824 */   addiu     $t0, $zero, 0x7
    /* DEEBC 800EE6BC 00000296 */  lhu        $v0, 0x0($s0)
    /* DEEC0 800EE6C0 00000000 */  nop
    /* DEEC4 800EE6C4 1000A2A7 */  sh         $v0, 0x10($sp)
    /* DEEC8 800EE6C8 02000296 */  lhu        $v0, 0x2($s0)
    /* DEECC 800EE6CC 00000000 */  nop
    /* DEED0 800EE6D0 1200A2A7 */  sh         $v0, 0x12($sp)
    /* DEED4 800EE6D4 04000496 */  lhu        $a0, 0x4($s0)
    /* DEED8 800EE6D8 00000000 */  nop
    /* DEEDC 800EE6DC 1400A4A7 */  sh         $a0, 0x14($sp)
    /* DEEE0 800EE6E0 06000296 */  lhu        $v0, 0x6($s0)
    /* DEEE4 800EE6E4 00000000 */  nop
    /* DEEE8 800EE6E8 1600A2A7 */  sh         $v0, 0x16($sp)
    /* DEEEC 800EE6EC 00140400 */  sll        $v0, $a0, 16
    /* DEEF0 800EE6F0 031C0200 */  sra        $v1, $v0, 16
    /* DEEF4 800EE6F4 0B006004 */  bltz       $v1, .L800EE724
    /* DEEF8 800EE6F8 21100000 */   addu      $v0, $zero, $zero
    /* DEEFC 800EE6FC 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DEF00 800EE700 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DEF04 800EE704 00000000 */  nop
    /* DEF08 800EE708 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DEF0C 800EE70C 2A104300 */  slt        $v0, $v0, $v1
    /* DEF10 800EE710 1280033C */  lui        $v1, %hi(D_801236A0)
    /* DEF14 800EE714 A0366394 */  lhu        $v1, %lo(D_801236A0)($v1)
    /* DEF18 800EE718 02004014 */  bnez       $v0, .L800EE724
    /* DEF1C 800EE71C FFFF6224 */   addiu     $v0, $v1, -0x1
    /* DEF20 800EE720 21108000 */  addu       $v0, $a0, $zero
  .L800EE724:
    /* DEF24 800EE724 1600A387 */  lh         $v1, 0x16($sp)
    /* DEF28 800EE728 1600A497 */  lhu        $a0, 0x16($sp)
    /* DEF2C 800EE72C 0C006004 */  bltz       $v1, .L800EE760
    /* DEF30 800EE730 1400A2A7 */   sh        $v0, 0x14($sp)
    /* DEF34 800EE734 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DEF38 800EE738 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DEF3C 800EE73C 00000000 */  nop
    /* DEF40 800EE740 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DEF44 800EE744 2A104300 */  slt        $v0, $v0, $v1
    /* DEF48 800EE748 1280033C */  lui        $v1, %hi(D_801236A2)
    /* DEF4C 800EE74C A2366394 */  lhu        $v1, %lo(D_801236A2)($v1)
    /* DEF50 800EE750 04004014 */  bnez       $v0, .L800EE764
    /* DEF54 800EE754 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* DEF58 800EE758 D9B90308 */  j          .L800EE764
    /* DEF5C 800EE75C 21108000 */   addu      $v0, $a0, $zero
  .L800EE760:
    /* DEF60 800EE760 21100000 */  addu       $v0, $zero, $zero
  .L800EE764:
    /* DEF64 800EE764 1000A397 */  lhu        $v1, 0x10($sp)
    /* DEF68 800EE768 1600A2A7 */  sh         $v0, 0x16($sp)
    /* DEF6C 800EE76C 3F006230 */  andi       $v0, $v1, 0x3F
    /* DEF70 800EE770 06004014 */  bnez       $v0, .L800EE78C
    /* DEF74 800EE774 80300800 */   sll       $a2, $t0, 2
    /* DEF78 800EE778 1400A297 */  lhu        $v0, 0x14($sp)
    /* DEF7C 800EE77C 00000000 */  nop
    /* DEF80 800EE780 3F004230 */  andi       $v0, $v0, 0x3F
    /* DEF84 800EE784 1F004010 */  beqz       $v0, .L800EE804
    /* DEF88 800EE788 80280800 */   sll       $a1, $t0, 2
  .L800EE78C:
    /* DEF8C 800EE78C 01000825 */  addiu      $t0, $t0, 0x1
    /* DEF90 800EE790 80380800 */  sll        $a3, $t0, 2
    /* DEF94 800EE794 01000825 */  addiu      $t0, $t0, 0x1
    /* DEF98 800EE798 80280800 */  sll        $a1, $t0, 2
    /* DEF9C 800EE79C 01000825 */  addiu      $t0, $t0, 0x1
    /* DEFA0 800EE7A0 08000296 */  lhu        $v0, 0x8($s0)
    /* DEFA4 800EE7A4 2130D100 */  addu       $a2, $a2, $s1
    /* DEFA8 800EE7A8 23106200 */  subu       $v0, $v1, $v0
    /* DEFAC 800EE7AC 1000A2A7 */  sh         $v0, 0x10($sp)
    /* DEFB0 800EE7B0 1200A297 */  lhu        $v0, 0x12($sp)
    /* DEFB4 800EE7B4 0A000396 */  lhu        $v1, 0xA($s0)
    /* DEFB8 800EE7B8 0060043C */  lui        $a0, (0x60000000 >> 16)
    /* DEFBC 800EE7BC 23104300 */  subu       $v0, $v0, $v1
    /* DEFC0 800EE7C0 1200A2A7 */  sh         $v0, 0x12($sp)
    /* DEFC4 800EE7C4 1B000292 */  lbu        $v0, 0x1B($s0)
    /* DEFC8 800EE7C8 1A000392 */  lbu        $v1, 0x1A($s0)
    /* DEFCC 800EE7CC 00140200 */  sll        $v0, $v0, 16
    /* DEFD0 800EE7D0 001A0300 */  sll        $v1, $v1, 8
    /* DEFD4 800EE7D4 25186400 */  or         $v1, $v1, $a0
    /* DEFD8 800EE7D8 19000492 */  lbu        $a0, 0x19($s0)
    /* DEFDC 800EE7DC 25104300 */  or         $v0, $v0, $v1
    /* DEFE0 800EE7E0 25104400 */  or         $v0, $v0, $a0
    /* DEFE4 800EE7E4 0000C2AC */  sw         $v0, 0x0($a2)
    /* DEFE8 800EE7E8 1000A28F */  lw         $v0, 0x10($sp)
    /* DEFEC 800EE7EC 2138F100 */  addu       $a3, $a3, $s1
    /* DEFF0 800EE7F0 0000E2AC */  sw         $v0, 0x0($a3)
    /* DEFF4 800EE7F4 1400A28F */  lw         $v0, 0x14($sp)
    /* DEFF8 800EE7F8 2128B100 */  addu       $a1, $a1, $s1
    /* DEFFC 800EE7FC 17BA0308 */  j          .L800EE85C
    /* DF000 800EE800 0000A2AC */   sw        $v0, 0x0($a1)
  .L800EE804:
    /* DF004 800EE804 01000825 */  addiu      $t0, $t0, 0x1
    /* DF008 800EE808 80300800 */  sll        $a2, $t0, 2
    /* DF00C 800EE80C 01000825 */  addiu      $t0, $t0, 0x1
    /* DF010 800EE810 80380800 */  sll        $a3, $t0, 2
    /* DF014 800EE814 01000825 */  addiu      $t0, $t0, 0x1
    /* DF018 800EE818 2128B100 */  addu       $a1, $a1, $s1
    /* DF01C 800EE81C 0002043C */  lui        $a0, (0x2000000 >> 16)
    /* DF020 800EE820 1B000292 */  lbu        $v0, 0x1B($s0)
    /* DF024 800EE824 1A000392 */  lbu        $v1, 0x1A($s0)
    /* DF028 800EE828 00140200 */  sll        $v0, $v0, 16
    /* DF02C 800EE82C 001A0300 */  sll        $v1, $v1, 8
    /* DF030 800EE830 25186400 */  or         $v1, $v1, $a0
    /* DF034 800EE834 19000492 */  lbu        $a0, 0x19($s0)
    /* DF038 800EE838 25104300 */  or         $v0, $v0, $v1
    /* DF03C 800EE83C 25104400 */  or         $v0, $v0, $a0
    /* DF040 800EE840 0000A2AC */  sw         $v0, 0x0($a1)
    /* DF044 800EE844 1000A28F */  lw         $v0, 0x10($sp)
    /* DF048 800EE848 2130D100 */  addu       $a2, $a2, $s1
    /* DF04C 800EE84C 0000C2AC */  sw         $v0, 0x0($a2)
    /* DF050 800EE850 1400A28F */  lw         $v0, 0x14($sp)
    /* DF054 800EE854 2138F100 */  addu       $a3, $a3, $s1
    /* DF058 800EE858 0000E2AC */  sw         $v0, 0x0($a3)
  .L800EE85C:
    /* DF05C 800EE85C FFFF0225 */  addiu      $v0, $t0, -0x1
    /* DF060 800EE860 030022A2 */  sb         $v0, 0x3($s1)
    /* DF064 800EE864 2000BF8F */  lw         $ra, 0x20($sp)
    /* DF068 800EE868 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DF06C 800EE86C 1800B08F */  lw         $s0, 0x18($sp)
    /* DF070 800EE870 0800E003 */  jr         $ra
    /* DF074 800EE874 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800EE608
