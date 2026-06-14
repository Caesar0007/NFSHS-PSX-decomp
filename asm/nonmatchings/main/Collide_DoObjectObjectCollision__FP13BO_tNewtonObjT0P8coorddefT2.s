.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2, 0xF7C

glabel Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
    /* 7EDD4 8008E5D4 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 7EDD8 8008E5D8 B400BFAF */  sw         $ra, 0xB4($sp)
    /* 7EDDC 8008E5DC B000BEAF */  sw         $fp, 0xB0($sp)
    /* 7EDE0 8008E5E0 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* 7EDE4 8008E5E4 A800B6AF */  sw         $s6, 0xA8($sp)
    /* 7EDE8 8008E5E8 A400B5AF */  sw         $s5, 0xA4($sp)
    /* 7EDEC 8008E5EC A000B4AF */  sw         $s4, 0xA0($sp)
    /* 7EDF0 8008E5F0 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* 7EDF4 8008E5F4 9800B2AF */  sw         $s2, 0x98($sp)
    /* 7EDF8 8008E5F8 9400B1AF */  sw         $s1, 0x94($sp)
    /* 7EDFC 8008E5FC 9000B0AF */  sw         $s0, 0x90($sp)
    /* 7EE00 8008E600 B800A4AF */  sw         $a0, 0xB8($sp)
    /* 7EE04 8008E604 C400A7AF */  sw         $a3, 0xC4($sp)
    /* 7EE08 8008E608 0000C28C */  lw         $v0, 0x0($a2)
    /* 7EE0C 8008E60C A000838C */  lw         $v1, 0xA0($a0)
    /* 7EE10 8008E610 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7EE14 8008E614 23104300 */  subu       $v0, $v0, $v1
    /* 7EE18 8008E618 4000A2AF */  sw         $v0, 0x40($sp)
    /* 7EE1C 8008E61C 0400C48C */  lw         $a0, 0x4($a2)
    /* 7EE20 8008E620 A400028D */  lw         $v0, 0xA4($t0)
    /* 7EE24 8008E624 00000000 */  nop
    /* 7EE28 8008E628 23208200 */  subu       $a0, $a0, $v0
    /* 7EE2C 8008E62C 4400A4AF */  sw         $a0, 0x44($sp)
    /* 7EE30 8008E630 0800C28C */  lw         $v0, 0x8($a2)
    /* 7EE34 8008E634 A800038D */  lw         $v1, 0xA8($t0)
    /* 7EE38 8008E638 21F0A000 */  addu       $fp, $a1, $zero
    /* 7EE3C 8008E63C 23104300 */  subu       $v0, $v0, $v1
    /* 7EE40 8008E640 4800A2AF */  sw         $v0, 0x48($sp)
    /* 7EE44 8008E644 0000C28C */  lw         $v0, 0x0($a2)
    /* 7EE48 8008E648 A000C38F */  lw         $v1, 0xA0($fp)
    /* 7EE4C 8008E64C 00000000 */  nop
    /* 7EE50 8008E650 23104300 */  subu       $v0, $v0, $v1
    /* 7EE54 8008E654 5000A2AF */  sw         $v0, 0x50($sp)
    /* 7EE58 8008E658 0400C28C */  lw         $v0, 0x4($a2)
    /* 7EE5C 8008E65C A400C38F */  lw         $v1, 0xA4($fp)
    /* 7EE60 8008E660 00000000 */  nop
    /* 7EE64 8008E664 23104300 */  subu       $v0, $v0, $v1
    /* 7EE68 8008E668 5400A2AF */  sw         $v0, 0x54($sp)
    /* 7EE6C 8008E66C 0800C28C */  lw         $v0, 0x8($a2)
    /* 7EE70 8008E670 A800C38F */  lw         $v1, 0xA8($fp)
    /* 7EE74 8008E674 2140E000 */  addu       $t0, $a3, $zero
    /* 7EE78 8008E678 23104300 */  subu       $v0, $v0, $v1
    /* 7EE7C 8008E67C 5800A2AF */  sw         $v0, 0x58($sp)
    /* 7EE80 8008E680 0800058D */  lw         $a1, 0x8($t0)
    /* 7EE84 8008E684 CA90030C */  jal        fixedmult
    /* 7EE88 8008E688 00000000 */   nop
    /* 7EE8C 8008E68C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EE90 8008E690 4800A48F */  lw         $a0, 0x48($sp)
    /* 7EE94 8008E694 0400058D */  lw         $a1, 0x4($t0)
    /* 7EE98 8008E698 CA90030C */  jal        fixedmult
    /* 7EE9C 8008E69C 21804000 */   addu      $s0, $v0, $zero
    /* 7EEA0 8008E6A0 4800A48F */  lw         $a0, 0x48($sp)
    /* 7EEA4 8008E6A4 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EEA8 8008E6A8 23800202 */  subu       $s0, $s0, $v0
    /* 7EEAC 8008E6AC 2000B0AF */  sw         $s0, 0x20($sp)
    /* 7EEB0 8008E6B0 0000058D */  lw         $a1, 0x0($t0)
    /* 7EEB4 8008E6B4 CA90030C */  jal        fixedmult
    /* 7EEB8 8008E6B8 00000000 */   nop
    /* 7EEBC 8008E6BC C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EEC0 8008E6C0 4000A48F */  lw         $a0, 0x40($sp)
    /* 7EEC4 8008E6C4 0800058D */  lw         $a1, 0x8($t0)
    /* 7EEC8 8008E6C8 CA90030C */  jal        fixedmult
    /* 7EECC 8008E6CC 21804000 */   addu      $s0, $v0, $zero
    /* 7EED0 8008E6D0 4000A48F */  lw         $a0, 0x40($sp)
    /* 7EED4 8008E6D4 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EED8 8008E6D8 23800202 */  subu       $s0, $s0, $v0
    /* 7EEDC 8008E6DC 2400B0AF */  sw         $s0, 0x24($sp)
    /* 7EEE0 8008E6E0 0400058D */  lw         $a1, 0x4($t0)
    /* 7EEE4 8008E6E4 CA90030C */  jal        fixedmult
    /* 7EEE8 8008E6E8 00000000 */   nop
    /* 7EEEC 8008E6EC C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EEF0 8008E6F0 4400A48F */  lw         $a0, 0x44($sp)
    /* 7EEF4 8008E6F4 0000058D */  lw         $a1, 0x0($t0)
    /* 7EEF8 8008E6F8 CA90030C */  jal        fixedmult
    /* 7EEFC 8008E6FC 21804000 */   addu      $s0, $v0, $zero
    /* 7EF00 8008E700 5400A48F */  lw         $a0, 0x54($sp)
    /* 7EF04 8008E704 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF08 8008E708 23800202 */  subu       $s0, $s0, $v0
    /* 7EF0C 8008E70C 2800B0AF */  sw         $s0, 0x28($sp)
    /* 7EF10 8008E710 0800058D */  lw         $a1, 0x8($t0)
    /* 7EF14 8008E714 CA90030C */  jal        fixedmult
    /* 7EF18 8008E718 00000000 */   nop
    /* 7EF1C 8008E71C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF20 8008E720 5800A48F */  lw         $a0, 0x58($sp)
    /* 7EF24 8008E724 0400058D */  lw         $a1, 0x4($t0)
    /* 7EF28 8008E728 CA90030C */  jal        fixedmult
    /* 7EF2C 8008E72C 21804000 */   addu      $s0, $v0, $zero
    /* 7EF30 8008E730 5800A48F */  lw         $a0, 0x58($sp)
    /* 7EF34 8008E734 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF38 8008E738 23800202 */  subu       $s0, $s0, $v0
    /* 7EF3C 8008E73C 3000B0AF */  sw         $s0, 0x30($sp)
    /* 7EF40 8008E740 0000058D */  lw         $a1, 0x0($t0)
    /* 7EF44 8008E744 CA90030C */  jal        fixedmult
    /* 7EF48 8008E748 00000000 */   nop
    /* 7EF4C 8008E74C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF50 8008E750 5000A48F */  lw         $a0, 0x50($sp)
    /* 7EF54 8008E754 0800058D */  lw         $a1, 0x8($t0)
    /* 7EF58 8008E758 CA90030C */  jal        fixedmult
    /* 7EF5C 8008E75C 21804000 */   addu      $s0, $v0, $zero
    /* 7EF60 8008E760 5000A48F */  lw         $a0, 0x50($sp)
    /* 7EF64 8008E764 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF68 8008E768 23800202 */  subu       $s0, $s0, $v0
    /* 7EF6C 8008E76C 3400B0AF */  sw         $s0, 0x34($sp)
    /* 7EF70 8008E770 0400058D */  lw         $a1, 0x4($t0)
    /* 7EF74 8008E774 CA90030C */  jal        fixedmult
    /* 7EF78 8008E778 00000000 */   nop
    /* 7EF7C 8008E77C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EF80 8008E780 5400A48F */  lw         $a0, 0x54($sp)
    /* 7EF84 8008E784 0000058D */  lw         $a1, 0x0($t0)
    /* 7EF88 8008E788 CA90030C */  jal        fixedmult
    /* 7EF8C 8008E78C 21804000 */   addu      $s0, $v0, $zero
    /* 7EF90 8008E790 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7EF94 8008E794 23800202 */  subu       $s0, $s0, $v0
    /* 7EF98 8008E798 3800B0AF */  sw         $s0, 0x38($sp)
    /* 7EF9C 8008E79C AC00048D */  lw         $a0, 0xAC($t0)
    /* 7EFA0 8008E7A0 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EFA4 8008E7A4 00000000 */  nop
    /* 7EFA8 8008E7A8 0000058D */  lw         $a1, 0x0($t0)
    /* 7EFAC 8008E7AC CA90030C */  jal        fixedmult
    /* 7EFB0 8008E7B0 00000000 */   nop
    /* 7EFB4 8008E7B4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7EFB8 8008E7B8 00000000 */  nop
    /* 7EFBC 8008E7BC B000048D */  lw         $a0, 0xB0($t0)
    /* 7EFC0 8008E7C0 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EFC4 8008E7C4 00000000 */  nop
    /* 7EFC8 8008E7C8 0400058D */  lw         $a1, 0x4($t0)
    /* 7EFCC 8008E7CC CA90030C */  jal        fixedmult
    /* 7EFD0 8008E7D0 21984000 */   addu      $s3, $v0, $zero
    /* 7EFD4 8008E7D4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7EFD8 8008E7D8 00000000 */  nop
    /* 7EFDC 8008E7DC B400048D */  lw         $a0, 0xB4($t0)
    /* 7EFE0 8008E7E0 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EFE4 8008E7E4 00000000 */  nop
    /* 7EFE8 8008E7E8 0800058D */  lw         $a1, 0x8($t0)
    /* 7EFEC 8008E7EC CA90030C */  jal        fixedmult
    /* 7EFF0 8008E7F0 8000A2AF */   sw        $v0, 0x80($sp)
    /* 7EFF4 8008E7F4 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7EFF8 8008E7F8 AC00C48F */  lw         $a0, 0xAC($fp)
    /* 7EFFC 8008E7FC 0000058D */  lw         $a1, 0x0($t0)
    /* 7F000 8008E800 CA90030C */  jal        fixedmult
    /* 7F004 8008E804 8400A2AF */   sw        $v0, 0x84($sp)
    /* 7F008 8008E808 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F00C 8008E80C B000C48F */  lw         $a0, 0xB0($fp)
    /* 7F010 8008E810 0400058D */  lw         $a1, 0x4($t0)
    /* 7F014 8008E814 CA90030C */  jal        fixedmult
    /* 7F018 8008E818 21904000 */   addu      $s2, $v0, $zero
    /* 7F01C 8008E81C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F020 8008E820 B400C48F */  lw         $a0, 0xB4($fp)
    /* 7F024 8008E824 0800058D */  lw         $a1, 0x8($t0)
    /* 7F028 8008E828 CA90030C */  jal        fixedmult
    /* 7F02C 8008E82C 8800A2AF */   sw        $v0, 0x88($sp)
    /* 7F030 8008E830 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F034 8008E834 2000A58F */  lw         $a1, 0x20($sp)
    /* 7F038 8008E838 1401048D */  lw         $a0, 0x114($t0)
    /* 7F03C 8008E83C CA90030C */  jal        fixedmult
    /* 7F040 8008E840 21B84000 */   addu      $s7, $v0, $zero
    /* 7F044 8008E844 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F048 8008E848 2400A58F */  lw         $a1, 0x24($sp)
    /* 7F04C 8008E84C 1801048D */  lw         $a0, 0x118($t0)
    /* 7F050 8008E850 CA90030C */  jal        fixedmult
    /* 7F054 8008E854 21884000 */   addu      $s1, $v0, $zero
    /* 7F058 8008E858 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F05C 8008E85C 2800A58F */  lw         $a1, 0x28($sp)
    /* 7F060 8008E860 1C01048D */  lw         $a0, 0x11C($t0)
    /* 7F064 8008E864 CA90030C */  jal        fixedmult
    /* 7F068 8008E868 21B04000 */   addu      $s6, $v0, $zero
    /* 7F06C 8008E86C 1401C48F */  lw         $a0, 0x114($fp)
    /* 7F070 8008E870 3000A58F */  lw         $a1, 0x30($sp)
    /* 7F074 8008E874 CA90030C */  jal        fixedmult
    /* 7F078 8008E878 21A84000 */   addu      $s5, $v0, $zero
    /* 7F07C 8008E87C 1801C48F */  lw         $a0, 0x118($fp)
    /* 7F080 8008E880 3400A58F */  lw         $a1, 0x34($sp)
    /* 7F084 8008E884 CA90030C */  jal        fixedmult
    /* 7F088 8008E888 21804000 */   addu      $s0, $v0, $zero
    /* 7F08C 8008E88C 1C01C48F */  lw         $a0, 0x11C($fp)
    /* 7F090 8008E890 3800A58F */  lw         $a1, 0x38($sp)
    /* 7F094 8008E894 CA90030C */  jal        fixedmult
    /* 7F098 8008E898 21A04000 */   addu      $s4, $v0, $zero
    /* 7F09C 8008E89C 21883602 */  addu       $s1, $s1, $s6
    /* 7F0A0 8008E8A0 21883502 */  addu       $s1, $s1, $s5
    /* 7F0A4 8008E8A4 21801402 */  addu       $s0, $s0, $s4
    /* 7F0A8 8008E8A8 8000A88F */  lw         $t0, 0x80($sp)
    /* 7F0AC 8008E8AC 21800202 */  addu       $s0, $s0, $v0
    /* 7F0B0 8008E8B0 21986802 */  addu       $s3, $s3, $t0
    /* 7F0B4 8008E8B4 8400A88F */  lw         $t0, 0x84($sp)
    /* 7F0B8 8008E8B8 2000A48F */  lw         $a0, 0x20($sp)
    /* 7F0BC 8008E8BC 21986802 */  addu       $s3, $s3, $t0
    /* 7F0C0 8008E8C0 8800A88F */  lw         $t0, 0x88($sp)
    /* 7F0C4 8008E8C4 21288000 */  addu       $a1, $a0, $zero
    /* 7F0C8 8008E8C8 21904802 */  addu       $s2, $s2, $t0
    /* 7F0CC 8008E8CC 21905702 */  addu       $s2, $s2, $s7
    /* 7F0D0 8008E8D0 23905302 */  subu       $s2, $s2, $s3
    /* 7F0D4 8008E8D4 23905102 */  subu       $s2, $s2, $s1
    /* 7F0D8 8008E8D8 CA90030C */  jal        fixedmult
    /* 7F0DC 8008E8DC 21905002 */   addu      $s2, $s2, $s0
    /* 7F0E0 8008E8E0 2400A48F */  lw         $a0, 0x24($sp)
    /* 7F0E4 8008E8E4 21804000 */  addu       $s0, $v0, $zero
    /* 7F0E8 8008E8E8 CA90030C */  jal        fixedmult
    /* 7F0EC 8008E8EC 21288000 */   addu      $a1, $a0, $zero
    /* 7F0F0 8008E8F0 2800A48F */  lw         $a0, 0x28($sp)
    /* 7F0F4 8008E8F4 21884000 */  addu       $s1, $v0, $zero
    /* 7F0F8 8008E8F8 CA90030C */  jal        fixedmult
    /* 7F0FC 8008E8FC 21288000 */   addu      $a1, $a0, $zero
    /* 7F100 8008E900 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F104 8008E904 21801102 */  addu       $s0, $s0, $s1
    /* 7F108 8008E908 2401058D */  lw         $a1, 0x124($t0)
    /* 7F10C 8008E90C CA90030C */  jal        fixedmult
    /* 7F110 8008E910 21200202 */   addu      $a0, $s0, $v0
    /* 7F114 8008E914 3000A48F */  lw         $a0, 0x30($sp)
    /* 7F118 8008E918 21984000 */  addu       $s3, $v0, $zero
    /* 7F11C 8008E91C CA90030C */  jal        fixedmult
    /* 7F120 8008E920 21288000 */   addu      $a1, $a0, $zero
    /* 7F124 8008E924 3400A48F */  lw         $a0, 0x34($sp)
    /* 7F128 8008E928 21804000 */  addu       $s0, $v0, $zero
    /* 7F12C 8008E92C CA90030C */  jal        fixedmult
    /* 7F130 8008E930 21288000 */   addu      $a1, $a0, $zero
    /* 7F134 8008E934 3800A48F */  lw         $a0, 0x38($sp)
    /* 7F138 8008E938 21884000 */  addu       $s1, $v0, $zero
    /* 7F13C 8008E93C CA90030C */  jal        fixedmult
    /* 7F140 8008E940 21288000 */   addu      $a1, $a0, $zero
    /* 7F144 8008E944 21801102 */  addu       $s0, $s0, $s1
    /* 7F148 8008E948 2401C58F */  lw         $a1, 0x124($fp)
    /* 7F14C 8008E94C CA90030C */  jal        fixedmult
    /* 7F150 8008E950 21200202 */   addu      $a0, $s0, $v0
    /* 7F154 8008E954 21204002 */  addu       $a0, $s2, $zero
    /* 7F158 8008E958 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F15C 8008E95C 43981300 */  sra        $s3, $s3, 1
    /* 7F160 8008E960 BC00058D */  lw         $a1, 0xBC($t0)
    /* 7F164 8008E964 43100200 */  sra        $v0, $v0, 1
    /* 7F168 8008E968 C21F0500 */  srl        $v1, $a1, 31
    /* 7F16C 8008E96C 2128A300 */  addu       $a1, $a1, $v1
    /* 7F170 8008E970 BC00C38F */  lw         $v1, 0xBC($fp)
    /* 7F174 8008E974 43280500 */  sra        $a1, $a1, 1
    /* 7F178 8008E978 C2370300 */  srl        $a2, $v1, 31
    /* 7F17C 8008E97C 21186600 */  addu       $v1, $v1, $a2
    /* 7F180 8008E980 43180300 */  sra        $v1, $v1, 1
    /* 7F184 8008E984 2128A300 */  addu       $a1, $a1, $v1
    /* 7F188 8008E988 2128B300 */  addu       $a1, $a1, $s3
    /* 7F18C 8008E98C 0191030C */  jal        rdiv
    /* 7F190 8008E990 2128A200 */   addu      $a1, $a1, $v0
    /* 7F194 8008E994 21B04000 */  addu       $s6, $v0, $zero
    /* 7F198 8008E998 E102C006 */  bltz       $s6, .L8008F520
    /* 7F19C 8008E99C 21100000 */   addu      $v0, $zero, $zero
    /* 7F1A0 8008E9A0 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F1A4 8008E9A4 00000000 */  nop
    /* 7F1A8 8008E9A8 6002028D */  lw         $v0, 0x260($t0)
    /* 7F1AC 8008E9AC 00000000 */  nop
    /* 7F1B0 8008E9B0 04004230 */  andi       $v0, $v0, 0x4
    /* 7F1B4 8008E9B4 06004010 */  beqz       $v0, .L8008E9D0
    /* 7F1B8 8008E9B8 00000000 */   nop
    /* 7F1BC 8008E9BC 8C01028D */  lw         $v0, 0x18C($t0)
    /* 7F1C0 8008E9C0 00000000 */  nop
    /* 7F1C4 8008E9C4 02004014 */  bnez       $v0, .L8008E9D0
    /* 7F1C8 8008E9C8 02000224 */   addiu     $v0, $zero, 0x2
    /* 7F1CC 8008E9CC 8C0102AD */  sw         $v0, 0x18C($t0)
  .L8008E9D0:
    /* 7F1D0 8008E9D0 6002C28F */  lw         $v0, 0x260($fp)
    /* 7F1D4 8008E9D4 00000000 */  nop
    /* 7F1D8 8008E9D8 04004230 */  andi       $v0, $v0, 0x4
    /* 7F1DC 8008E9DC 06004010 */  beqz       $v0, .L8008E9F8
    /* 7F1E0 8008E9E0 00000000 */   nop
    /* 7F1E4 8008E9E4 8C01C28F */  lw         $v0, 0x18C($fp)
    /* 7F1E8 8008E9E8 00000000 */  nop
    /* 7F1EC 8008E9EC 02004014 */  bnez       $v0, .L8008E9F8
    /* 7F1F0 8008E9F0 02000224 */   addiu     $v0, $zero, 0x2
    /* 7F1F4 8008E9F4 8C01C2AF */  sw         $v0, 0x18C($fp)
  .L8008E9F8:
    /* 7F1F8 8008E9F8 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F1FC 8008E9FC 00000000 */  nop
    /* 7F200 8008EA00 6002028D */  lw         $v0, 0x260($t0)
    /* 7F204 8008EA04 00000000 */  nop
    /* 7F208 8008EA08 04004230 */  andi       $v0, $v0, 0x4
    /* 7F20C 8008EA0C 07004010 */  beqz       $v0, .L8008EA2C
    /* 7F210 8008EA10 33330424 */   addiu     $a0, $zero, 0x3333
    /* 7F214 8008EA14 6002C28F */  lw         $v0, 0x260($fp)
    /* 7F218 8008EA18 00000000 */  nop
    /* 7F21C 8008EA1C 04004230 */  andi       $v0, $v0, 0x4
    /* 7F220 8008EA20 02004010 */  beqz       $v0, .L8008EA2C
    /* 7F224 8008EA24 00000000 */   nop
    /* 7F228 8008EA28 00400424 */  addiu      $a0, $zero, 0x4000
  .L8008EA2C:
    /* 7F22C 8008EA2C CA90030C */  jal        fixedmult
    /* 7F230 8008EA30 2128C002 */   addu      $a1, $s6, $zero
    /* 7F234 8008EA34 21B04000 */  addu       $s6, $v0, $zero
    /* 7F238 8008EA38 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F23C 8008EA3C 00000000 */  nop
    /* 7F240 8008EA40 0000058D */  lw         $a1, 0x0($t0)
    /* 7F244 8008EA44 CA90030C */  jal        fixedmult
    /* 7F248 8008EA48 2120C002 */   addu      $a0, $s6, $zero
    /* 7F24C 8008EA4C C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F250 8008EA50 1000A2AF */  sw         $v0, 0x10($sp)
    /* 7F254 8008EA54 0400058D */  lw         $a1, 0x4($t0)
    /* 7F258 8008EA58 CA90030C */  jal        fixedmult
    /* 7F25C 8008EA5C 2120C002 */   addu      $a0, $s6, $zero
    /* 7F260 8008EA60 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F264 8008EA64 1400A2AF */  sw         $v0, 0x14($sp)
    /* 7F268 8008EA68 0800058D */  lw         $a1, 0x8($t0)
    /* 7F26C 8008EA6C CA90030C */  jal        fixedmult
    /* 7F270 8008EA70 2120C002 */   addu      $a0, $s6, $zero
    /* 7F274 8008EA74 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F278 8008EA78 1800A2AF */  sw         $v0, 0x18($sp)
    /* 7F27C 8008EA7C AC00048D */  lw         $a0, 0xAC($t0)
    /* 7F280 8008EA80 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F284 8008EA84 00000000 */  nop
    /* 7F288 8008EA88 0000058D */  lw         $a1, 0x0($t0)
    /* 7F28C 8008EA8C CA90030C */  jal        fixedmult
    /* 7F290 8008EA90 00000000 */   nop
    /* 7F294 8008EA94 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F298 8008EA98 00000000 */  nop
    /* 7F29C 8008EA9C B000048D */  lw         $a0, 0xB0($t0)
    /* 7F2A0 8008EAA0 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F2A4 8008EAA4 00000000 */  nop
    /* 7F2A8 8008EAA8 0400058D */  lw         $a1, 0x4($t0)
    /* 7F2AC 8008EAAC CA90030C */  jal        fixedmult
    /* 7F2B0 8008EAB0 21884000 */   addu      $s1, $v0, $zero
    /* 7F2B4 8008EAB4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F2B8 8008EAB8 00000000 */  nop
    /* 7F2BC 8008EABC B400048D */  lw         $a0, 0xB4($t0)
    /* 7F2C0 8008EAC0 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F2C4 8008EAC4 00000000 */  nop
    /* 7F2C8 8008EAC8 0800058D */  lw         $a1, 0x8($t0)
    /* 7F2CC 8008EACC CA90030C */  jal        fixedmult
    /* 7F2D0 8008EAD0 21A04000 */   addu      $s4, $v0, $zero
    /* 7F2D4 8008EAD4 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F2D8 8008EAD8 AC00C48F */  lw         $a0, 0xAC($fp)
    /* 7F2DC 8008EADC 0000058D */  lw         $a1, 0x0($t0)
    /* 7F2E0 8008EAE0 CA90030C */  jal        fixedmult
    /* 7F2E4 8008EAE4 21984000 */   addu      $s3, $v0, $zero
    /* 7F2E8 8008EAE8 C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F2EC 8008EAEC B000C48F */  lw         $a0, 0xB0($fp)
    /* 7F2F0 8008EAF0 0400058D */  lw         $a1, 0x4($t0)
    /* 7F2F4 8008EAF4 CA90030C */  jal        fixedmult
    /* 7F2F8 8008EAF8 21804000 */   addu      $s0, $v0, $zero
    /* 7F2FC 8008EAFC C400A88F */  lw         $t0, 0xC4($sp)
    /* 7F300 8008EB00 B400C48F */  lw         $a0, 0xB4($fp)
    /* 7F304 8008EB04 0800058D */  lw         $a1, 0x8($t0)
    /* 7F308 8008EB08 CA90030C */  jal        fixedmult
    /* 7F30C 8008EB0C 21904000 */   addu      $s2, $v0, $zero
    /* 7F310 8008EB10 21883402 */  addu       $s1, $s1, $s4
    /* 7F314 8008EB14 21883302 */  addu       $s1, $s1, $s3
    /* 7F318 8008EB18 21801202 */  addu       $s0, $s0, $s2
    /* 7F31C 8008EB1C 21800202 */  addu       $s0, $s0, $v0
    /* 7F320 8008EB20 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F324 8008EB24 B800C58F */  lw         $a1, 0xB8($fp)
    /* 7F328 8008EB28 B800028D */  lw         $v0, 0xB8($t0)
    /* 7F32C 8008EB2C 23203002 */  subu       $a0, $s1, $s0
    /* 7F330 8008EB30 CA90030C */  jal        fixedmult
    /* 7F334 8008EB34 21284500 */   addu      $a1, $v0, $a1
    /* 7F338 8008EB38 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F33C 8008EB3C 21804000 */  addu       $s0, $v0, $zero
    /* 7F340 8008EB40 BC00058D */  lw         $a1, 0xBC($t0)
    /* 7F344 8008EB44 CA90030C */  jal        fixedmult
    /* 7F348 8008EB48 21200002 */   addu      $a0, $s0, $zero
    /* 7F34C 8008EB4C 08004018 */  blez       $v0, .L8008EB70
    /* 7F350 8008EB50 00000000 */   nop
    /* 7F354 8008EB54 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F358 8008EB58 00000000 */  nop
    /* 7F35C 8008EB5C BC00058D */  lw         $a1, 0xBC($t0)
    /* 7F360 8008EB60 CA90030C */  jal        fixedmult
    /* 7F364 8008EB64 21200002 */   addu      $a0, $s0, $zero
    /* 7F368 8008EB68 E23A0208 */  j          .L8008EB88
    /* 7F36C 8008EB6C 00000000 */   nop
  .L8008EB70:
    /* 7F370 8008EB70 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F374 8008EB74 00000000 */  nop
    /* 7F378 8008EB78 BC00058D */  lw         $a1, 0xBC($t0)
    /* 7F37C 8008EB7C CA90030C */  jal        fixedmult
    /* 7F380 8008EB80 21200002 */   addu      $a0, $s0, $zero
    /* 7F384 8008EB84 23100200 */  negu       $v0, $v0
  .L8008EB88:
    /* 7F388 8008EB88 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F38C 8008EB8C 00000000 */  nop
    /* 7F390 8008EB90 900102AD */  sw         $v0, 0x190($t0)
    /* 7F394 8008EB94 BC00C58F */  lw         $a1, 0xBC($fp)
    /* 7F398 8008EB98 CA90030C */  jal        fixedmult
    /* 7F39C 8008EB9C 21200002 */   addu      $a0, $s0, $zero
    /* 7F3A0 8008EBA0 06004018 */  blez       $v0, .L8008EBBC
    /* 7F3A4 8008EBA4 00000000 */   nop
    /* 7F3A8 8008EBA8 BC00C58F */  lw         $a1, 0xBC($fp)
    /* 7F3AC 8008EBAC CA90030C */  jal        fixedmult
    /* 7F3B0 8008EBB0 21200002 */   addu      $a0, $s0, $zero
    /* 7F3B4 8008EBB4 F43A0208 */  j          .L8008EBD0
    /* 7F3B8 8008EBB8 9001C2AF */   sw        $v0, 0x190($fp)
  .L8008EBBC:
    /* 7F3BC 8008EBBC BC00C58F */  lw         $a1, 0xBC($fp)
    /* 7F3C0 8008EBC0 CA90030C */  jal        fixedmult
    /* 7F3C4 8008EBC4 21200002 */   addu      $a0, $s0, $zero
    /* 7F3C8 8008EBC8 23100200 */  negu       $v0, $v0
    /* 7F3CC 8008EBCC 9001C2AF */  sw         $v0, 0x190($fp)
  .L8008EBD0:
    /* 7F3D0 8008EBD0 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F3D4 8008EBD4 00000000 */  nop
    /* 7F3D8 8008EBD8 0000028D */  lw         $v0, 0x0($t0)
    /* 7F3DC 8008EBDC 00000000 */  nop
    /* 7F3E0 8008EBE0 00024228 */  slti       $v0, $v0, 0x200
    /* 7F3E4 8008EBE4 06004010 */  beqz       $v0, .L8008EC00
    /* 7F3E8 8008EBE8 5555033C */   lui       $v1, (0x55555556 >> 16)
    /* 7F3EC 8008EBEC 0000C28F */  lw         $v0, 0x0($fp)
    /* 7F3F0 8008EBF0 00000000 */  nop
    /* 7F3F4 8008EBF4 00024228 */  slti       $v0, $v0, 0x200
    /* 7F3F8 8008EBF8 12004014 */  bnez       $v0, .L8008EC44
    /* 7F3FC 8008EBFC 00000000 */   nop
  .L8008EC00:
    /* 7F400 8008EC00 9001028D */  lw         $v0, 0x190($t0)
    /* 7F404 8008EC04 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* 7F408 8008EC08 18004300 */  mult       $v0, $v1
    /* 7F40C 8008EC0C C3170200 */  sra        $v0, $v0, 31
    /* 7F410 8008EC10 10400000 */  mfhi       $t0
    /* 7F414 8008EC14 23100201 */  subu       $v0, $t0, $v0
    /* 7F418 8008EC18 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F41C 8008EC1C 00000000 */  nop
    /* 7F420 8008EC20 900102AD */  sw         $v0, 0x190($t0)
    /* 7F424 8008EC24 9001C28F */  lw         $v0, 0x190($fp)
    /* 7F428 8008EC28 00000000 */  nop
    /* 7F42C 8008EC2C 18004300 */  mult       $v0, $v1
    /* 7F430 8008EC30 C3170200 */  sra        $v0, $v0, 31
    /* 7F434 8008EC34 10400000 */  mfhi       $t0
    /* 7F438 8008EC38 23100201 */  subu       $v0, $t0, $v0
    /* 7F43C 8008EC3C 9001C2AF */  sw         $v0, 0x190($fp)
    /* 7F440 8008EC40 B800A88F */  lw         $t0, 0xB8($sp)
  .L8008EC44:
    /* 7F444 8008EC44 1000A58F */  lw         $a1, 0x10($sp)
    /* 7F448 8008EC48 BC00048D */  lw         $a0, 0xBC($t0)
    /* 7F44C 8008EC4C CA90030C */  jal        fixedmult
    /* 7F450 8008EC50 00000000 */   nop
    /* 7F454 8008EC54 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F458 8008EC58 1400A58F */  lw         $a1, 0x14($sp)
    /* 7F45C 8008EC5C 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7F460 8008EC60 BC00048D */  lw         $a0, 0xBC($t0)
    /* 7F464 8008EC64 CA90030C */  jal        fixedmult
    /* 7F468 8008EC68 00000000 */   nop
    /* 7F46C 8008EC6C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F470 8008EC70 1800A58F */  lw         $a1, 0x18($sp)
    /* 7F474 8008EC74 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7F478 8008EC78 BC00048D */  lw         $a0, 0xBC($t0)
    /* 7F47C 8008EC7C CA90030C */  jal        fixedmult
    /* 7F480 8008EC80 00000000 */   nop
    /* 7F484 8008EC84 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F488 8008EC88 6000A38F */  lw         $v1, 0x60($sp)
    /* 7F48C 8008EC8C 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7F490 8008EC90 AC00028D */  lw         $v0, 0xAC($t0)
    /* 7F494 8008EC94 00000000 */  nop
    /* 7F498 8008EC98 21104300 */  addu       $v0, $v0, $v1
    /* 7F49C 8008EC9C AC0002AD */  sw         $v0, 0xAC($t0)
    /* 7F4A0 8008ECA0 B000028D */  lw         $v0, 0xB0($t0)
    /* 7F4A4 8008ECA4 6400A38F */  lw         $v1, 0x64($sp)
    /* 7F4A8 8008ECA8 0500043C */  lui        $a0, (0x50001 >> 16)
    /* 7F4AC 8008ECAC 21104300 */  addu       $v0, $v0, $v1
    /* 7F4B0 8008ECB0 B00002AD */  sw         $v0, 0xB0($t0)
    /* 7F4B4 8008ECB4 6800A58F */  lw         $a1, 0x68($sp)
    /* 7F4B8 8008ECB8 B400028D */  lw         $v0, 0xB4($t0)
    /* 7F4BC 8008ECBC 0000038D */  lw         $v1, 0x0($t0)
    /* 7F4C0 8008ECC0 01008434 */  ori        $a0, $a0, (0x50001 & 0xFFFF)
    /* 7F4C4 8008ECC4 980104AD */  sw         $a0, 0x198($t0)
    /* 7F4C8 8008ECC8 94011EAD */  sw         $fp, 0x194($t0)
    /* 7F4CC 8008ECCC 21104500 */  addu       $v0, $v0, $a1
    /* 7F4D0 8008ECD0 00026328 */  slti       $v1, $v1, 0x200
    /* 7F4D4 8008ECD4 87006010 */  beqz       $v1, .L8008EEF4
    /* 7F4D8 8008ECD8 B40002AD */   sw        $v0, 0xB4($t0)
    /* 7F4DC 8008ECDC A000028D */  lw         $v0, 0xA0($t0)
    /* 7F4E0 8008ECE0 A000C38F */  lw         $v1, 0xA0($fp)
    /* 7F4E4 8008ECE4 9001158D */  lw         $s5, 0x190($t0)
    /* 7F4E8 8008ECE8 23104300 */  subu       $v0, $v0, $v1
    /* 7F4EC 8008ECEC 7000A2AF */  sw         $v0, 0x70($sp)
    /* 7F4F0 8008ECF0 A400028D */  lw         $v0, 0xA4($t0)
    /* 7F4F4 8008ECF4 A400C38F */  lw         $v1, 0xA4($fp)
    /* 7F4F8 8008ECF8 09001424 */  addiu      $s4, $zero, 0x9
    /* 7F4FC 8008ECFC 23104300 */  subu       $v0, $v0, $v1
    /* 7F500 8008ED00 7400A2AF */  sw         $v0, 0x74($sp)
    /* 7F504 8008ED04 A800028D */  lw         $v0, 0xA8($t0)
    /* 7F508 8008ED08 A800C38F */  lw         $v1, 0xA8($fp)
    /* 7F50C 8008ED0C 7000A427 */  addiu      $a0, $sp, 0x70
    /* 7F510 8008ED10 23104300 */  subu       $v0, $v0, $v1
    /* 7F514 8008ED14 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 7F518 8008ED18 7800A2AF */   sw        $v0, 0x78($sp)
    /* 7F51C 8008ED1C 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 7F520 8008ED20 2A105500 */  slt        $v0, $v0, $s5
    /* 7F524 8008ED24 73004010 */  beqz       $v0, .L8008EEF4
    /* 7F528 8008ED28 00000000 */   nop
    /* 7F52C 8008ED2C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F530 8008ED30 7000A48F */  lw         $a0, 0x70($sp)
    /* 7F534 8008ED34 F000058D */  lw         $a1, 0xF0($t0)
    /* 7F538 8008ED38 CA90030C */  jal        fixedmult
    /* 7F53C 8008ED3C 00000000 */   nop
    /* 7F540 8008ED40 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F544 8008ED44 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F548 8008ED48 F400058D */  lw         $a1, 0xF4($t0)
    /* 7F54C 8008ED4C CA90030C */  jal        fixedmult
    /* 7F550 8008ED50 21804000 */   addu      $s0, $v0, $zero
    /* 7F554 8008ED54 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F558 8008ED58 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F55C 8008ED5C F800058D */  lw         $a1, 0xF8($t0)
    /* 7F560 8008ED60 CA90030C */  jal        fixedmult
    /* 7F564 8008ED64 21884000 */   addu      $s1, $v0, $zero
    /* 7F568 8008ED68 21801102 */  addu       $s0, $s0, $s1
    /* 7F56C 8008ED6C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F570 8008ED70 7000A48F */  lw         $a0, 0x70($sp)
    /* 7F574 8008ED74 FC00058D */  lw         $a1, 0xFC($t0)
    /* 7F578 8008ED78 CA90030C */  jal        fixedmult
    /* 7F57C 8008ED7C 21980202 */   addu      $s3, $s0, $v0
    /* 7F580 8008ED80 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F584 8008ED84 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F588 8008ED88 0001058D */  lw         $a1, 0x100($t0)
    /* 7F58C 8008ED8C CA90030C */  jal        fixedmult
    /* 7F590 8008ED90 21884000 */   addu      $s1, $v0, $zero
    /* 7F594 8008ED94 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F598 8008ED98 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F59C 8008ED9C 0401058D */  lw         $a1, 0x104($t0)
    /* 7F5A0 8008EDA0 CA90030C */  jal        fixedmult
    /* 7F5A4 8008EDA4 21804000 */   addu      $s0, $v0, $zero
    /* 7F5A8 8008EDA8 21883002 */  addu       $s1, $s1, $s0
    /* 7F5AC 8008EDAC B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F5B0 8008EDB0 7000A48F */  lw         $a0, 0x70($sp)
    /* 7F5B4 8008EDB4 0801058D */  lw         $a1, 0x108($t0)
    /* 7F5B8 8008EDB8 CA90030C */  jal        fixedmult
    /* 7F5BC 8008EDBC 21882202 */   addu      $s1, $s1, $v0
    /* 7F5C0 8008EDC0 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F5C4 8008EDC4 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F5C8 8008EDC8 0C01058D */  lw         $a1, 0x10C($t0)
    /* 7F5CC 8008EDCC CA90030C */  jal        fixedmult
    /* 7F5D0 8008EDD0 21804000 */   addu      $s0, $v0, $zero
    /* 7F5D4 8008EDD4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F5D8 8008EDD8 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F5DC 8008EDDC 1001058D */  lw         $a1, 0x110($t0)
    /* 7F5E0 8008EDE0 CA90030C */  jal        fixedmult
    /* 7F5E4 8008EDE4 21904000 */   addu      $s2, $v0, $zero
    /* 7F5E8 8008EDE8 21801202 */  addu       $s0, $s0, $s2
    /* 7F5EC 8008EDEC 0080312A */  slti       $s1, $s1, -0x8000
    /* 7F5F0 8008EDF0 07002012 */  beqz       $s1, .L8008EE10
    /* 7F5F4 8008EDF4 21800202 */   addu      $s0, $s0, $v0
    /* 7F5F8 8008EDF8 08001424 */  addiu      $s4, $zero, 0x8
    /* 7F5FC 8008EDFC B800A48F */  lw         $a0, 0xB8($sp)
    /* 7F600 8008EE00 2128A002 */  addu       $a1, $s5, $zero
    /* 7F604 8008EE04 21308002 */  addu       $a2, $s4, $zero
    /* 7F608 8008EE08 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7F60C 8008EE0C 02000724 */   addiu     $a3, $zero, 0x2
  .L8008EE10:
    /* 7F610 8008EE10 02006106 */  bgez       $s3, .L8008EE1C
    /* 7F614 8008EE14 21106002 */   addu      $v0, $s3, $zero
    /* 7F618 8008EE18 23100200 */  negu       $v0, $v0
  .L8008EE1C:
    /* 7F61C 8008EE1C 99194228 */  slti       $v0, $v0, 0x1999
    /* 7F620 8008EE20 09004010 */  beqz       $v0, .L8008EE48
    /* 7F624 8008EE24 67E6022A */   slti      $v0, $s0, -0x1999
    /* 7F628 8008EE28 03004010 */  beqz       $v0, .L8008EE38
    /* 7F62C 8008EE2C 9A19022A */   slti      $v0, $s0, 0x199A
    /* 7F630 8008EE30 B63B0208 */  j          .L8008EED8
    /* 7F634 8008EE34 01001424 */   addiu     $s4, $zero, 0x1
  .L8008EE38:
    /* 7F638 8008EE38 03004014 */  bnez       $v0, .L8008EE48
    /* 7F63C 8008EE3C 00000000 */   nop
    /* 7F640 8008EE40 B63B0208 */  j          .L8008EED8
    /* 7F644 8008EE44 05001424 */   addiu     $s4, $zero, 0x5
  .L8008EE48:
    /* 7F648 8008EE48 02000106 */  bgez       $s0, .L8008EE54
    /* 7F64C 8008EE4C 21100002 */   addu      $v0, $s0, $zero
    /* 7F650 8008EE50 23100200 */  negu       $v0, $v0
  .L8008EE54:
    /* 7F654 8008EE54 99194228 */  slti       $v0, $v0, 0x1999
    /* 7F658 8008EE58 09004010 */  beqz       $v0, .L8008EE80
    /* 7F65C 8008EE5C 9A19622A */   slti      $v0, $s3, 0x199A
    /* 7F660 8008EE60 03004014 */  bnez       $v0, .L8008EE70
    /* 7F664 8008EE64 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F668 8008EE68 B63B0208 */  j          .L8008EED8
    /* 7F66C 8008EE6C 07001424 */   addiu     $s4, $zero, 0x7
  .L8008EE70:
    /* 7F670 8008EE70 04004010 */  beqz       $v0, .L8008EE84
    /* 7F674 8008EE74 67E6022A */   slti      $v0, $s0, -0x1999
    /* 7F678 8008EE78 B63B0208 */  j          .L8008EED8
    /* 7F67C 8008EE7C 03001424 */   addiu     $s4, $zero, 0x3
  .L8008EE80:
    /* 7F680 8008EE80 67E6022A */  slti       $v0, $s0, -0x1999
  .L8008EE84:
    /* 7F684 8008EE84 09004010 */  beqz       $v0, .L8008EEAC
    /* 7F688 8008EE88 9A19622A */   slti      $v0, $s3, 0x199A
    /* 7F68C 8008EE8C 03004014 */  bnez       $v0, .L8008EE9C
    /* 7F690 8008EE90 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F694 8008EE94 B63B0208 */  j          .L8008EED8
    /* 7F698 8008EE98 21A00000 */   addu      $s4, $zero, $zero
  .L8008EE9C:
    /* 7F69C 8008EE9C 04004010 */  beqz       $v0, .L8008EEB0
    /* 7F6A0 8008EEA0 9A19022A */   slti      $v0, $s0, 0x199A
    /* 7F6A4 8008EEA4 B63B0208 */  j          .L8008EED8
    /* 7F6A8 8008EEA8 02001424 */   addiu     $s4, $zero, 0x2
  .L8008EEAC:
    /* 7F6AC 8008EEAC 9A19022A */  slti       $v0, $s0, 0x199A
  .L8008EEB0:
    /* 7F6B0 8008EEB0 0A004014 */  bnez       $v0, .L8008EEDC
    /* 7F6B4 8008EEB4 0800822A */   slti      $v0, $s4, 0x8
    /* 7F6B8 8008EEB8 9A19622A */  slti       $v0, $s3, 0x199A
    /* 7F6BC 8008EEBC 03004014 */  bnez       $v0, .L8008EECC
    /* 7F6C0 8008EEC0 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F6C4 8008EEC4 B63B0208 */  j          .L8008EED8
    /* 7F6C8 8008EEC8 06001424 */   addiu     $s4, $zero, 0x6
  .L8008EECC:
    /* 7F6CC 8008EECC 03004010 */  beqz       $v0, .L8008EEDC
    /* 7F6D0 8008EED0 0800822A */   slti      $v0, $s4, 0x8
    /* 7F6D4 8008EED4 04001424 */  addiu      $s4, $zero, 0x4
  .L8008EED8:
    /* 7F6D8 8008EED8 0800822A */  slti       $v0, $s4, 0x8
  .L8008EEDC:
    /* 7F6DC 8008EEDC 05004010 */  beqz       $v0, .L8008EEF4
    /* 7F6E0 8008EEE0 2128A002 */   addu      $a1, $s5, $zero
    /* 7F6E4 8008EEE4 B800A48F */  lw         $a0, 0xB8($sp)
    /* 7F6E8 8008EEE8 21308002 */  addu       $a2, $s4, $zero
    /* 7F6EC 8008EEEC CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7F6F0 8008EEF0 02000724 */   addiu     $a3, $zero, 0x2
  .L8008EEF4:
    /* 7F6F4 8008EEF4 BC00C48F */  lw         $a0, 0xBC($fp)
    /* 7F6F8 8008EEF8 1000A58F */  lw         $a1, 0x10($sp)
    /* 7F6FC 8008EEFC CA90030C */  jal        fixedmult
    /* 7F700 8008EF00 00000000 */   nop
    /* 7F704 8008EF04 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7F708 8008EF08 BC00C48F */  lw         $a0, 0xBC($fp)
    /* 7F70C 8008EF0C 1400A58F */  lw         $a1, 0x14($sp)
    /* 7F710 8008EF10 CA90030C */  jal        fixedmult
    /* 7F714 8008EF14 00000000 */   nop
    /* 7F718 8008EF18 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7F71C 8008EF1C BC00C48F */  lw         $a0, 0xBC($fp)
    /* 7F720 8008EF20 1800A58F */  lw         $a1, 0x18($sp)
    /* 7F724 8008EF24 CA90030C */  jal        fixedmult
    /* 7F728 8008EF28 00000000 */   nop
    /* 7F72C 8008EF2C 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7F730 8008EF30 AC00C28F */  lw         $v0, 0xAC($fp)
    /* 7F734 8008EF34 6000A38F */  lw         $v1, 0x60($sp)
    /* 7F738 8008EF38 00000000 */  nop
    /* 7F73C 8008EF3C 23104300 */  subu       $v0, $v0, $v1
    /* 7F740 8008EF40 AC00C2AF */  sw         $v0, 0xAC($fp)
    /* 7F744 8008EF44 B000C28F */  lw         $v0, 0xB0($fp)
    /* 7F748 8008EF48 6400A38F */  lw         $v1, 0x64($sp)
    /* 7F74C 8008EF4C 0500043C */  lui        $a0, (0x50001 >> 16)
    /* 7F750 8008EF50 23104300 */  subu       $v0, $v0, $v1
    /* 7F754 8008EF54 B000C2AF */  sw         $v0, 0xB0($fp)
    /* 7F758 8008EF58 6800A58F */  lw         $a1, 0x68($sp)
    /* 7F75C 8008EF5C 01008434 */  ori        $a0, $a0, (0x50001 & 0xFFFF)
    /* 7F760 8008EF60 9801C4AF */  sw         $a0, 0x198($fp)
    /* 7F764 8008EF64 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F768 8008EF68 B400C28F */  lw         $v0, 0xB4($fp)
    /* 7F76C 8008EF6C 0000C38F */  lw         $v1, 0x0($fp)
    /* 7F770 8008EF70 23104500 */  subu       $v0, $v0, $a1
    /* 7F774 8008EF74 00026328 */  slti       $v1, $v1, 0x200
    /* 7F778 8008EF78 9401C8AF */  sw         $t0, 0x194($fp)
    /* 7F77C 8008EF7C 77006010 */  beqz       $v1, .L8008F15C
    /* 7F780 8008EF80 B400C2AF */   sw        $v0, 0xB4($fp)
    /* 7F784 8008EF84 7000A28F */  lw         $v0, 0x70($sp)
    /* 7F788 8008EF88 9001D58F */  lw         $s5, 0x190($fp)
    /* 7F78C 8008EF8C 7800A38F */  lw         $v1, 0x78($sp)
    /* 7F790 8008EF90 23200200 */  negu       $a0, $v0
    /* 7F794 8008EF94 7400A28F */  lw         $v0, 0x74($sp)
    /* 7F798 8008EF98 23180300 */  negu       $v1, $v1
    /* 7F79C 8008EF9C 7000A4AF */  sw         $a0, 0x70($sp)
    /* 7F7A0 8008EFA0 7800A3AF */  sw         $v1, 0x78($sp)
    /* 7F7A4 8008EFA4 23100200 */  negu       $v0, $v0
    /* 7F7A8 8008EFA8 7400A2AF */  sw         $v0, 0x74($sp)
    /* 7F7AC 8008EFAC 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 7F7B0 8008EFB0 2A105500 */  slt        $v0, $v0, $s5
    /* 7F7B4 8008EFB4 69004010 */  beqz       $v0, .L8008F15C
    /* 7F7B8 8008EFB8 09001424 */   addiu     $s4, $zero, 0x9
    /* 7F7BC 8008EFBC F000C58F */  lw         $a1, 0xF0($fp)
    /* 7F7C0 8008EFC0 CA90030C */  jal        fixedmult
    /* 7F7C4 8008EFC4 00000000 */   nop
    /* 7F7C8 8008EFC8 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F7CC 8008EFCC F400C58F */  lw         $a1, 0xF4($fp)
    /* 7F7D0 8008EFD0 CA90030C */  jal        fixedmult
    /* 7F7D4 8008EFD4 21804000 */   addu      $s0, $v0, $zero
    /* 7F7D8 8008EFD8 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F7DC 8008EFDC F800C58F */  lw         $a1, 0xF8($fp)
    /* 7F7E0 8008EFE0 CA90030C */  jal        fixedmult
    /* 7F7E4 8008EFE4 21884000 */   addu      $s1, $v0, $zero
    /* 7F7E8 8008EFE8 21801102 */  addu       $s0, $s0, $s1
    /* 7F7EC 8008EFEC 7000A48F */  lw         $a0, 0x70($sp)
    /* 7F7F0 8008EFF0 FC00C58F */  lw         $a1, 0xFC($fp)
    /* 7F7F4 8008EFF4 CA90030C */  jal        fixedmult
    /* 7F7F8 8008EFF8 21980202 */   addu      $s3, $s0, $v0
    /* 7F7FC 8008EFFC 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F800 8008F000 0001C58F */  lw         $a1, 0x100($fp)
    /* 7F804 8008F004 CA90030C */  jal        fixedmult
    /* 7F808 8008F008 21884000 */   addu      $s1, $v0, $zero
    /* 7F80C 8008F00C 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F810 8008F010 0401C58F */  lw         $a1, 0x104($fp)
    /* 7F814 8008F014 CA90030C */  jal        fixedmult
    /* 7F818 8008F018 21804000 */   addu      $s0, $v0, $zero
    /* 7F81C 8008F01C 21883002 */  addu       $s1, $s1, $s0
    /* 7F820 8008F020 7000A48F */  lw         $a0, 0x70($sp)
    /* 7F824 8008F024 0801C58F */  lw         $a1, 0x108($fp)
    /* 7F828 8008F028 CA90030C */  jal        fixedmult
    /* 7F82C 8008F02C 21882202 */   addu      $s1, $s1, $v0
    /* 7F830 8008F030 7400A48F */  lw         $a0, 0x74($sp)
    /* 7F834 8008F034 0C01C58F */  lw         $a1, 0x10C($fp)
    /* 7F838 8008F038 CA90030C */  jal        fixedmult
    /* 7F83C 8008F03C 21804000 */   addu      $s0, $v0, $zero
    /* 7F840 8008F040 7800A48F */  lw         $a0, 0x78($sp)
    /* 7F844 8008F044 1001C58F */  lw         $a1, 0x110($fp)
    /* 7F848 8008F048 CA90030C */  jal        fixedmult
    /* 7F84C 8008F04C 21904000 */   addu      $s2, $v0, $zero
    /* 7F850 8008F050 21801202 */  addu       $s0, $s0, $s2
    /* 7F854 8008F054 0080312A */  slti       $s1, $s1, -0x8000
    /* 7F858 8008F058 07002012 */  beqz       $s1, .L8008F078
    /* 7F85C 8008F05C 21800202 */   addu      $s0, $s0, $v0
    /* 7F860 8008F060 08001424 */  addiu      $s4, $zero, 0x8
    /* 7F864 8008F064 2120C003 */  addu       $a0, $fp, $zero
    /* 7F868 8008F068 2128A002 */  addu       $a1, $s5, $zero
    /* 7F86C 8008F06C 21308002 */  addu       $a2, $s4, $zero
    /* 7F870 8008F070 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7F874 8008F074 02000724 */   addiu     $a3, $zero, 0x2
  .L8008F078:
    /* 7F878 8008F078 02006106 */  bgez       $s3, .L8008F084
    /* 7F87C 8008F07C 21106002 */   addu      $v0, $s3, $zero
    /* 7F880 8008F080 23100200 */  negu       $v0, $v0
  .L8008F084:
    /* 7F884 8008F084 99194228 */  slti       $v0, $v0, 0x1999
    /* 7F888 8008F088 09004010 */  beqz       $v0, .L8008F0B0
    /* 7F88C 8008F08C 67E6022A */   slti      $v0, $s0, -0x1999
    /* 7F890 8008F090 03004010 */  beqz       $v0, .L8008F0A0
    /* 7F894 8008F094 9A19022A */   slti      $v0, $s0, 0x199A
    /* 7F898 8008F098 503C0208 */  j          .L8008F140
    /* 7F89C 8008F09C 01001424 */   addiu     $s4, $zero, 0x1
  .L8008F0A0:
    /* 7F8A0 8008F0A0 03004014 */  bnez       $v0, .L8008F0B0
    /* 7F8A4 8008F0A4 00000000 */   nop
    /* 7F8A8 8008F0A8 503C0208 */  j          .L8008F140
    /* 7F8AC 8008F0AC 05001424 */   addiu     $s4, $zero, 0x5
  .L8008F0B0:
    /* 7F8B0 8008F0B0 02000106 */  bgez       $s0, .L8008F0BC
    /* 7F8B4 8008F0B4 21100002 */   addu      $v0, $s0, $zero
    /* 7F8B8 8008F0B8 23100200 */  negu       $v0, $v0
  .L8008F0BC:
    /* 7F8BC 8008F0BC 99194228 */  slti       $v0, $v0, 0x1999
    /* 7F8C0 8008F0C0 09004010 */  beqz       $v0, .L8008F0E8
    /* 7F8C4 8008F0C4 9A19622A */   slti      $v0, $s3, 0x199A
    /* 7F8C8 8008F0C8 03004014 */  bnez       $v0, .L8008F0D8
    /* 7F8CC 8008F0CC 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F8D0 8008F0D0 503C0208 */  j          .L8008F140
    /* 7F8D4 8008F0D4 07001424 */   addiu     $s4, $zero, 0x7
  .L8008F0D8:
    /* 7F8D8 8008F0D8 04004010 */  beqz       $v0, .L8008F0EC
    /* 7F8DC 8008F0DC 67E6022A */   slti      $v0, $s0, -0x1999
    /* 7F8E0 8008F0E0 503C0208 */  j          .L8008F140
    /* 7F8E4 8008F0E4 03001424 */   addiu     $s4, $zero, 0x3
  .L8008F0E8:
    /* 7F8E8 8008F0E8 67E6022A */  slti       $v0, $s0, -0x1999
  .L8008F0EC:
    /* 7F8EC 8008F0EC 09004010 */  beqz       $v0, .L8008F114
    /* 7F8F0 8008F0F0 9A19622A */   slti      $v0, $s3, 0x199A
    /* 7F8F4 8008F0F4 03004014 */  bnez       $v0, .L8008F104
    /* 7F8F8 8008F0F8 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F8FC 8008F0FC 503C0208 */  j          .L8008F140
    /* 7F900 8008F100 21A00000 */   addu      $s4, $zero, $zero
  .L8008F104:
    /* 7F904 8008F104 04004010 */  beqz       $v0, .L8008F118
    /* 7F908 8008F108 9A19022A */   slti      $v0, $s0, 0x199A
    /* 7F90C 8008F10C 503C0208 */  j          .L8008F140
    /* 7F910 8008F110 02001424 */   addiu     $s4, $zero, 0x2
  .L8008F114:
    /* 7F914 8008F114 9A19022A */  slti       $v0, $s0, 0x199A
  .L8008F118:
    /* 7F918 8008F118 0A004014 */  bnez       $v0, .L8008F144
    /* 7F91C 8008F11C 0800822A */   slti      $v0, $s4, 0x8
    /* 7F920 8008F120 9A19622A */  slti       $v0, $s3, 0x199A
    /* 7F924 8008F124 03004014 */  bnez       $v0, .L8008F134
    /* 7F928 8008F128 67E6622A */   slti      $v0, $s3, -0x1999
    /* 7F92C 8008F12C 503C0208 */  j          .L8008F140
    /* 7F930 8008F130 06001424 */   addiu     $s4, $zero, 0x6
  .L8008F134:
    /* 7F934 8008F134 03004010 */  beqz       $v0, .L8008F144
    /* 7F938 8008F138 0800822A */   slti      $v0, $s4, 0x8
    /* 7F93C 8008F13C 04001424 */  addiu      $s4, $zero, 0x4
  .L8008F140:
    /* 7F940 8008F140 0800822A */  slti       $v0, $s4, 0x8
  .L8008F144:
    /* 7F944 8008F144 05004010 */  beqz       $v0, .L8008F15C
    /* 7F948 8008F148 2120C003 */   addu      $a0, $fp, $zero
    /* 7F94C 8008F14C 2128A002 */  addu       $a1, $s5, $zero
    /* 7F950 8008F150 21308002 */  addu       $a2, $s4, $zero
    /* 7F954 8008F154 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7F958 8008F158 02000724 */   addiu     $a3, $zero, 0x2
  .L8008F15C:
    /* 7F95C 8008F15C 4400A48F */  lw         $a0, 0x44($sp)
    /* 7F960 8008F160 1800A58F */  lw         $a1, 0x18($sp)
    /* 7F964 8008F164 CA90030C */  jal        fixedmult
    /* 7F968 8008F168 00000000 */   nop
    /* 7F96C 8008F16C 4800A48F */  lw         $a0, 0x48($sp)
    /* 7F970 8008F170 1400A58F */  lw         $a1, 0x14($sp)
    /* 7F974 8008F174 CA90030C */  jal        fixedmult
    /* 7F978 8008F178 21804000 */   addu      $s0, $v0, $zero
    /* 7F97C 8008F17C 4800A48F */  lw         $a0, 0x48($sp)
    /* 7F980 8008F180 1000A58F */  lw         $a1, 0x10($sp)
    /* 7F984 8008F184 23800202 */  subu       $s0, $s0, $v0
    /* 7F988 8008F188 CA90030C */  jal        fixedmult
    /* 7F98C 8008F18C 6000B0AF */   sw        $s0, 0x60($sp)
    /* 7F990 8008F190 4000A48F */  lw         $a0, 0x40($sp)
    /* 7F994 8008F194 1800A58F */  lw         $a1, 0x18($sp)
    /* 7F998 8008F198 CA90030C */  jal        fixedmult
    /* 7F99C 8008F19C 21804000 */   addu      $s0, $v0, $zero
    /* 7F9A0 8008F1A0 4000A48F */  lw         $a0, 0x40($sp)
    /* 7F9A4 8008F1A4 1400A58F */  lw         $a1, 0x14($sp)
    /* 7F9A8 8008F1A8 23800202 */  subu       $s0, $s0, $v0
    /* 7F9AC 8008F1AC CA90030C */  jal        fixedmult
    /* 7F9B0 8008F1B0 6400B0AF */   sw        $s0, 0x64($sp)
    /* 7F9B4 8008F1B4 4400A48F */  lw         $a0, 0x44($sp)
    /* 7F9B8 8008F1B8 1000A58F */  lw         $a1, 0x10($sp)
    /* 7F9BC 8008F1BC CA90030C */  jal        fixedmult
    /* 7F9C0 8008F1C0 21804000 */   addu      $s0, $v0, $zero
    /* 7F9C4 8008F1C4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7F9C8 8008F1C8 23800202 */  subu       $s0, $s0, $v0
    /* 7F9CC 8008F1CC 6800B0AF */  sw         $s0, 0x68($sp)
    /* 7F9D0 8008F1D0 6002028D */  lw         $v0, 0x260($t0)
    /* 7F9D4 8008F1D4 00000000 */  nop
    /* 7F9D8 8008F1D8 04004230 */  andi       $v0, $v0, 0x4
    /* 7F9DC 8008F1DC 27004010 */  beqz       $v0, .L8008F27C
    /* 7F9E0 8008F1E0 3F00023C */   lui       $v0, (0x3FFFFF >> 16)
    /* 7F9E4 8008F1E4 FFFF4234 */  ori        $v0, $v0, (0x3FFFFF & 0xFFFF)
    /* 7F9E8 8008F1E8 2A105600 */  slt        $v0, $v0, $s6
    /* 7F9EC 8008F1EC 23004014 */  bnez       $v0, .L8008F27C
    /* 7F9F0 8008F1F0 00000000 */   nop
    /* 7F9F4 8008F1F4 2401038D */  lw         $v1, 0x124($t0)
    /* 7F9F8 8008F1F8 00000000 */  nop
    /* 7F9FC 8008F1FC 40100300 */  sll        $v0, $v1, 1
    /* 7FA00 8008F200 21104300 */  addu       $v0, $v0, $v1
    /* 7FA04 8008F204 02004104 */  bgez       $v0, .L8008F210
    /* 7FA08 8008F208 00000000 */   nop
    /* 7FA0C 8008F20C 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F210:
    /* 7FA10 8008F210 6000A58F */  lw         $a1, 0x60($sp)
    /* 7FA14 8008F214 CA90030C */  jal        fixedmult
    /* 7FA18 8008F218 83200200 */   sra       $a0, $v0, 2
    /* 7FA1C 8008F21C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FA20 8008F220 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7FA24 8008F224 2401038D */  lw         $v1, 0x124($t0)
    /* 7FA28 8008F228 00000000 */  nop
    /* 7FA2C 8008F22C 40100300 */  sll        $v0, $v1, 1
    /* 7FA30 8008F230 21104300 */  addu       $v0, $v0, $v1
    /* 7FA34 8008F234 02004104 */  bgez       $v0, .L8008F240
    /* 7FA38 8008F238 00000000 */   nop
    /* 7FA3C 8008F23C 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F240:
    /* 7FA40 8008F240 6400A58F */  lw         $a1, 0x64($sp)
    /* 7FA44 8008F244 CA90030C */  jal        fixedmult
    /* 7FA48 8008F248 83200200 */   sra       $a0, $v0, 2
    /* 7FA4C 8008F24C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FA50 8008F250 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7FA54 8008F254 2401038D */  lw         $v1, 0x124($t0)
    /* 7FA58 8008F258 00000000 */  nop
    /* 7FA5C 8008F25C 40100300 */  sll        $v0, $v1, 1
    /* 7FA60 8008F260 21104300 */  addu       $v0, $v0, $v1
    /* 7FA64 8008F264 02004104 */  bgez       $v0, .L8008F270
    /* 7FA68 8008F268 00000000 */   nop
    /* 7FA6C 8008F26C 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F270:
    /* 7FA70 8008F270 6800A58F */  lw         $a1, 0x68($sp)
    /* 7FA74 8008F274 AE3C0208 */  j          .L8008F2B8
    /* 7FA78 8008F278 83200200 */   sra       $a0, $v0, 2
  .L8008F27C:
    /* 7FA7C 8008F27C B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FA80 8008F280 6000A58F */  lw         $a1, 0x60($sp)
    /* 7FA84 8008F284 2401048D */  lw         $a0, 0x124($t0)
    /* 7FA88 8008F288 CA90030C */  jal        fixedmult
    /* 7FA8C 8008F28C 00000000 */   nop
    /* 7FA90 8008F290 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FA94 8008F294 6400A58F */  lw         $a1, 0x64($sp)
    /* 7FA98 8008F298 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7FA9C 8008F29C 2401048D */  lw         $a0, 0x124($t0)
    /* 7FAA0 8008F2A0 CA90030C */  jal        fixedmult
    /* 7FAA4 8008F2A4 00000000 */   nop
    /* 7FAA8 8008F2A8 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FAAC 8008F2AC 6800A58F */  lw         $a1, 0x68($sp)
    /* 7FAB0 8008F2B0 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7FAB4 8008F2B4 2401048D */  lw         $a0, 0x124($t0)
  .L8008F2B8:
    /* 7FAB8 8008F2B8 CA90030C */  jal        fixedmult
    /* 7FABC 8008F2BC 00000000 */   nop
    /* 7FAC0 8008F2C0 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7FAC4 8008F2C4 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FAC8 8008F2C8 6000A38F */  lw         $v1, 0x60($sp)
    /* 7FACC 8008F2CC 1401028D */  lw         $v0, 0x114($t0)
    /* 7FAD0 8008F2D0 00000000 */  nop
    /* 7FAD4 8008F2D4 21104300 */  addu       $v0, $v0, $v1
    /* 7FAD8 8008F2D8 140102AD */  sw         $v0, 0x114($t0)
    /* 7FADC 8008F2DC 1801028D */  lw         $v0, 0x118($t0)
    /* 7FAE0 8008F2E0 6400A38F */  lw         $v1, 0x64($sp)
    /* 7FAE4 8008F2E4 00000000 */  nop
    /* 7FAE8 8008F2E8 21104300 */  addu       $v0, $v0, $v1
    /* 7FAEC 8008F2EC 180102AD */  sw         $v0, 0x118($t0)
    /* 7FAF0 8008F2F0 1C01028D */  lw         $v0, 0x11C($t0)
    /* 7FAF4 8008F2F4 6800A38F */  lw         $v1, 0x68($sp)
    /* 7FAF8 8008F2F8 00000000 */  nop
    /* 7FAFC 8008F2FC 21104300 */  addu       $v0, $v0, $v1
    /* 7FB00 8008F300 1C0102AD */  sw         $v0, 0x11C($t0)
    /* 7FB04 8008F304 5400A48F */  lw         $a0, 0x54($sp)
    /* 7FB08 8008F308 1800A58F */  lw         $a1, 0x18($sp)
    /* 7FB0C 8008F30C CA90030C */  jal        fixedmult
    /* 7FB10 8008F310 00000000 */   nop
    /* 7FB14 8008F314 5800A48F */  lw         $a0, 0x58($sp)
    /* 7FB18 8008F318 1400A58F */  lw         $a1, 0x14($sp)
    /* 7FB1C 8008F31C CA90030C */  jal        fixedmult
    /* 7FB20 8008F320 21804000 */   addu      $s0, $v0, $zero
    /* 7FB24 8008F324 5800A48F */  lw         $a0, 0x58($sp)
    /* 7FB28 8008F328 1000A58F */  lw         $a1, 0x10($sp)
    /* 7FB2C 8008F32C 23800202 */  subu       $s0, $s0, $v0
    /* 7FB30 8008F330 CA90030C */  jal        fixedmult
    /* 7FB34 8008F334 6000B0AF */   sw        $s0, 0x60($sp)
    /* 7FB38 8008F338 5000A48F */  lw         $a0, 0x50($sp)
    /* 7FB3C 8008F33C 1800A58F */  lw         $a1, 0x18($sp)
    /* 7FB40 8008F340 CA90030C */  jal        fixedmult
    /* 7FB44 8008F344 21804000 */   addu      $s0, $v0, $zero
    /* 7FB48 8008F348 5000A48F */  lw         $a0, 0x50($sp)
    /* 7FB4C 8008F34C 1400A58F */  lw         $a1, 0x14($sp)
    /* 7FB50 8008F350 23800202 */  subu       $s0, $s0, $v0
    /* 7FB54 8008F354 CA90030C */  jal        fixedmult
    /* 7FB58 8008F358 6400B0AF */   sw        $s0, 0x64($sp)
    /* 7FB5C 8008F35C 5400A48F */  lw         $a0, 0x54($sp)
    /* 7FB60 8008F360 1000A58F */  lw         $a1, 0x10($sp)
    /* 7FB64 8008F364 CA90030C */  jal        fixedmult
    /* 7FB68 8008F368 21804000 */   addu      $s0, $v0, $zero
    /* 7FB6C 8008F36C 23800202 */  subu       $s0, $s0, $v0
    /* 7FB70 8008F370 6800B0AF */  sw         $s0, 0x68($sp)
    /* 7FB74 8008F374 6002C28F */  lw         $v0, 0x260($fp)
    /* 7FB78 8008F378 00000000 */  nop
    /* 7FB7C 8008F37C 04004230 */  andi       $v0, $v0, 0x4
    /* 7FB80 8008F380 25004010 */  beqz       $v0, .L8008F418
    /* 7FB84 8008F384 3F00023C */   lui       $v0, (0x3FFFFF >> 16)
    /* 7FB88 8008F388 FFFF4234 */  ori        $v0, $v0, (0x3FFFFF & 0xFFFF)
    /* 7FB8C 8008F38C 2A105600 */  slt        $v0, $v0, $s6
    /* 7FB90 8008F390 21004014 */  bnez       $v0, .L8008F418
    /* 7FB94 8008F394 00000000 */   nop
    /* 7FB98 8008F398 2401C38F */  lw         $v1, 0x124($fp)
    /* 7FB9C 8008F39C 00000000 */  nop
    /* 7FBA0 8008F3A0 40100300 */  sll        $v0, $v1, 1
    /* 7FBA4 8008F3A4 21104300 */  addu       $v0, $v0, $v1
    /* 7FBA8 8008F3A8 02004104 */  bgez       $v0, .L8008F3B4
    /* 7FBAC 8008F3AC 00000000 */   nop
    /* 7FBB0 8008F3B0 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F3B4:
    /* 7FBB4 8008F3B4 6000A58F */  lw         $a1, 0x60($sp)
    /* 7FBB8 8008F3B8 CA90030C */  jal        fixedmult
    /* 7FBBC 8008F3BC 83200200 */   sra       $a0, $v0, 2
    /* 7FBC0 8008F3C0 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7FBC4 8008F3C4 2401C38F */  lw         $v1, 0x124($fp)
    /* 7FBC8 8008F3C8 00000000 */  nop
    /* 7FBCC 8008F3CC 40100300 */  sll        $v0, $v1, 1
    /* 7FBD0 8008F3D0 21104300 */  addu       $v0, $v0, $v1
    /* 7FBD4 8008F3D4 02004104 */  bgez       $v0, .L8008F3E0
    /* 7FBD8 8008F3D8 00000000 */   nop
    /* 7FBDC 8008F3DC 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F3E0:
    /* 7FBE0 8008F3E0 6400A58F */  lw         $a1, 0x64($sp)
    /* 7FBE4 8008F3E4 CA90030C */  jal        fixedmult
    /* 7FBE8 8008F3E8 83200200 */   sra       $a0, $v0, 2
    /* 7FBEC 8008F3EC 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7FBF0 8008F3F0 2401C38F */  lw         $v1, 0x124($fp)
    /* 7FBF4 8008F3F4 00000000 */  nop
    /* 7FBF8 8008F3F8 40100300 */  sll        $v0, $v1, 1
    /* 7FBFC 8008F3FC 21104300 */  addu       $v0, $v0, $v1
    /* 7FC00 8008F400 02004104 */  bgez       $v0, .L8008F40C
    /* 7FC04 8008F404 00000000 */   nop
    /* 7FC08 8008F408 03004224 */  addiu      $v0, $v0, 0x3
  .L8008F40C:
    /* 7FC0C 8008F40C 6800A58F */  lw         $a1, 0x68($sp)
    /* 7FC10 8008F410 123D0208 */  j          .L8008F448
    /* 7FC14 8008F414 83200200 */   sra       $a0, $v0, 2
  .L8008F418:
    /* 7FC18 8008F418 2401C48F */  lw         $a0, 0x124($fp)
    /* 7FC1C 8008F41C 6000A58F */  lw         $a1, 0x60($sp)
    /* 7FC20 8008F420 CA90030C */  jal        fixedmult
    /* 7FC24 8008F424 00000000 */   nop
    /* 7FC28 8008F428 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7FC2C 8008F42C 2401C48F */  lw         $a0, 0x124($fp)
    /* 7FC30 8008F430 6400A58F */  lw         $a1, 0x64($sp)
    /* 7FC34 8008F434 CA90030C */  jal        fixedmult
    /* 7FC38 8008F438 00000000 */   nop
    /* 7FC3C 8008F43C 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7FC40 8008F440 2401C48F */  lw         $a0, 0x124($fp)
    /* 7FC44 8008F444 6800A58F */  lw         $a1, 0x68($sp)
  .L8008F448:
    /* 7FC48 8008F448 CA90030C */  jal        fixedmult
    /* 7FC4C 8008F44C 00000000 */   nop
    /* 7FC50 8008F450 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7FC54 8008F454 1401C28F */  lw         $v0, 0x114($fp)
    /* 7FC58 8008F458 6000A38F */  lw         $v1, 0x60($sp)
    /* 7FC5C 8008F45C 00000000 */  nop
    /* 7FC60 8008F460 23104300 */  subu       $v0, $v0, $v1
    /* 7FC64 8008F464 1401C2AF */  sw         $v0, 0x114($fp)
    /* 7FC68 8008F468 1801C28F */  lw         $v0, 0x118($fp)
    /* 7FC6C 8008F46C 6400A38F */  lw         $v1, 0x64($sp)
    /* 7FC70 8008F470 00000000 */  nop
    /* 7FC74 8008F474 23104300 */  subu       $v0, $v0, $v1
    /* 7FC78 8008F478 1801C2AF */  sw         $v0, 0x118($fp)
    /* 7FC7C 8008F47C 1C01C28F */  lw         $v0, 0x11C($fp)
    /* 7FC80 8008F480 6800A38F */  lw         $v1, 0x68($sp)
    /* 7FC84 8008F484 00000000 */  nop
    /* 7FC88 8008F488 23104300 */  subu       $v0, $v0, $v1
    /* 7FC8C 8008F48C 1C01C2AF */  sw         $v0, 0x11C($fp)
    /* 7FC90 8008F490 B800A88F */  lw         $t0, 0xB8($sp)
    /* 7FC94 8008F494 00000000 */  nop
    /* 7FC98 8008F498 7C010295 */  lhu        $v0, 0x17C($t0)
    /* 7FC9C 8008F49C 00000000 */  nop
    /* 7FCA0 8008F4A0 01004224 */  addiu      $v0, $v0, 0x1
    /* 7FCA4 8008F4A4 7C0102A5 */  sh         $v0, 0x17C($t0)
    /* 7FCA8 8008F4A8 7C01C297 */  lhu        $v0, 0x17C($fp)
    /* 7FCAC 8008F4AC A000C38F */  lw         $v1, 0xA0($fp)
    /* 7FCB0 8008F4B0 01004224 */  addiu      $v0, $v0, 0x1
    /* 7FCB4 8008F4B4 7C01C2A7 */  sh         $v0, 0x17C($fp)
    /* 7FCB8 8008F4B8 A000028D */  lw         $v0, 0xA0($t0)
    /* 7FCBC 8008F4BC 00000000 */  nop
    /* 7FCC0 8008F4C0 21104300 */  addu       $v0, $v0, $v1
    /* 7FCC4 8008F4C4 C21F0200 */  srl        $v1, $v0, 31
    /* 7FCC8 8008F4C8 21104300 */  addu       $v0, $v0, $v1
    /* 7FCCC 8008F4CC 43100200 */  sra        $v0, $v0, 1
    /* 7FCD0 8008F4D0 A001C2AF */  sw         $v0, 0x1A0($fp)
    /* 7FCD4 8008F4D4 A00102AD */  sw         $v0, 0x1A0($t0)
    /* 7FCD8 8008F4D8 A400028D */  lw         $v0, 0xA4($t0)
    /* 7FCDC 8008F4DC A400C38F */  lw         $v1, 0xA4($fp)
    /* 7FCE0 8008F4E0 00000000 */  nop
    /* 7FCE4 8008F4E4 21104300 */  addu       $v0, $v0, $v1
    /* 7FCE8 8008F4E8 C21F0200 */  srl        $v1, $v0, 31
    /* 7FCEC 8008F4EC 21104300 */  addu       $v0, $v0, $v1
    /* 7FCF0 8008F4F0 43100200 */  sra        $v0, $v0, 1
    /* 7FCF4 8008F4F4 A401C2AF */  sw         $v0, 0x1A4($fp)
    /* 7FCF8 8008F4F8 A800038D */  lw         $v1, 0xA8($t0)
    /* 7FCFC 8008F4FC A40102AD */  sw         $v0, 0x1A4($t0)
    /* 7FD00 8008F500 A800C48F */  lw         $a0, 0xA8($fp)
    /* 7FD04 8008F504 01000224 */  addiu      $v0, $zero, 0x1
    /* 7FD08 8008F508 21186400 */  addu       $v1, $v1, $a0
    /* 7FD0C 8008F50C C2270300 */  srl        $a0, $v1, 31
    /* 7FD10 8008F510 21186400 */  addu       $v1, $v1, $a0
    /* 7FD14 8008F514 07184300 */  srav       $v1, $v1, $v0
    /* 7FD18 8008F518 A801C3AF */  sw         $v1, 0x1A8($fp)
    /* 7FD1C 8008F51C A80103AD */  sw         $v1, 0x1A8($t0)
  .L8008F520:
    /* 7FD20 8008F520 B400BF8F */  lw         $ra, 0xB4($sp)
    /* 7FD24 8008F524 B000BE8F */  lw         $fp, 0xB0($sp)
    /* 7FD28 8008F528 AC00B78F */  lw         $s7, 0xAC($sp)
    /* 7FD2C 8008F52C A800B68F */  lw         $s6, 0xA8($sp)
    /* 7FD30 8008F530 A400B58F */  lw         $s5, 0xA4($sp)
    /* 7FD34 8008F534 A000B48F */  lw         $s4, 0xA0($sp)
    /* 7FD38 8008F538 9C00B38F */  lw         $s3, 0x9C($sp)
    /* 7FD3C 8008F53C 9800B28F */  lw         $s2, 0x98($sp)
    /* 7FD40 8008F540 9400B18F */  lw         $s1, 0x94($sp)
    /* 7FD44 8008F544 9000B08F */  lw         $s0, 0x90($sp)
    /* 7FD48 8008F548 0800E003 */  jr         $ra
    /* 7FD4C 8008F54C B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
