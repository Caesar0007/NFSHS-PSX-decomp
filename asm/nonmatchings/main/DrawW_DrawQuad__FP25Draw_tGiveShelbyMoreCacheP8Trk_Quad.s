.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad, 0x940

glabel DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
    /* B6CF8 800C64F8 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* B6CFC 800C64FC 6800B0AF */  sw         $s0, 0x68($sp)
    /* B6D00 800C6500 21808000 */  addu       $s0, $a0, $zero
    /* B6D04 800C6504 2160A000 */  addu       $t4, $a1, $zero
    /* B6D08 800C6508 8400BFAF */  sw         $ra, 0x84($sp)
    /* B6D0C 800C650C 8000B6AF */  sw         $s6, 0x80($sp)
    /* B6D10 800C6510 7C00B5AF */  sw         $s5, 0x7C($sp)
    /* B6D14 800C6514 7800B4AF */  sw         $s4, 0x78($sp)
    /* B6D18 800C6518 7400B3AF */  sw         $s3, 0x74($sp)
    /* B6D1C 800C651C 7000B2AF */  sw         $s2, 0x70($sp)
    /* B6D20 800C6520 6C00B1AF */  sw         $s1, 0x6C($sp)
    /* B6D24 800C6524 03008291 */  lbu        $v0, 0x3($t4)
    /* B6D28 800C6528 E000098E */  lw         $t1, 0xE0($s0)
    /* B6D2C 800C652C F4000696 */  lhu        $a2, 0xF4($s0)
    /* B6D30 800C6530 F6000596 */  lhu        $a1, 0xF6($s0)
    /* B6D34 800C6534 02008391 */  lbu        $v1, 0x2($t4)
    /* B6D38 800C6538 04008891 */  lbu        $t0, 0x4($t4)
    /* B6D3C 800C653C 05008791 */  lbu        $a3, 0x5($t4)
    /* B6D40 800C6540 F8000496 */  lhu        $a0, 0xF8($s0)
    /* B6D44 800C6544 C0100200 */  sll        $v0, $v0, 3
    /* B6D48 800C6548 21102201 */  addu       $v0, $t1, $v0
    /* B6D4C 800C654C 00340600 */  sll        $a2, $a2, 16
    /* B6D50 800C6550 03340600 */  sra        $a2, $a2, 16
    /* B6D54 800C6554 002C0500 */  sll        $a1, $a1, 16
    /* B6D58 800C6558 032C0500 */  sra        $a1, $a1, 16
    /* B6D5C 800C655C 00240400 */  sll        $a0, $a0, 16
    /* B6D60 800C6560 03240400 */  sra        $a0, $a0, 16
    /* B6D64 800C6564 00004A8C */  lw         $t2, 0x0($v0)
    /* B6D68 800C6568 0400428C */  lw         $v0, 0x4($v0)
    /* B6D6C 800C656C 035C0A00 */  sra        $t3, $t2, 16
    /* B6D70 800C6570 21504601 */  addu       $t2, $t2, $a2
    /* B6D74 800C6574 21586501 */  addu       $t3, $t3, $a1
    /* B6D78 800C6578 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* B6D7C 800C657C 21104400 */  addu       $v0, $v0, $a0
    /* B6D80 800C6580 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* B6D84 800C6584 1800A227 */  addiu      $v0, $sp, 0x18
    /* B6D88 800C6588 1800AAA7 */  sh         $t2, 0x18($sp)
    /* B6D8C 800C658C 1A00ABA7 */  sh         $t3, 0x1A($sp)
    /* B6D90 800C6590 000040C8 */  lwc2       $0, 0x0($v0)
    /* B6D94 800C6594 040041C8 */  lwc2       $1, 0x4($v0)
    /* B6D98 800C6598 FF006330 */  andi       $v1, $v1, 0xFF
    /* B6D9C 800C659C C0180300 */  sll        $v1, $v1, 3
    /* B6DA0 800C65A0 21102301 */  addu       $v0, $t1, $v1
    /* B6DA4 800C65A4 0100184A */  .word 0x4A180001  /* rtps */
    /* B6DA8 800C65A8 00004A8C */  lw         $t2, 0x0($v0)
    /* B6DAC 800C65AC 0400428C */  lw         $v0, 0x4($v0)
    /* B6DB0 800C65B0 035C0A00 */  sra        $t3, $t2, 16
    /* B6DB4 800C65B4 21504601 */  addu       $t2, $t2, $a2
    /* B6DB8 800C65B8 21586501 */  addu       $t3, $t3, $a1
    /* B6DBC 800C65BC 2400A2AF */  sw         $v0, 0x24($sp)
    /* B6DC0 800C65C0 21104400 */  addu       $v0, $v0, $a0
    /* B6DC4 800C65C4 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B6DC8 800C65C8 98000226 */  addiu      $v0, $s0, 0x98
    /* B6DCC 800C65CC 2000AAA7 */  sh         $t2, 0x20($sp)
    /* B6DD0 800C65D0 2200ABA7 */  sh         $t3, 0x22($sp)
    /* B6DD4 800C65D4 000059E8 */  swc2       $25, 0x0($v0)
    /* B6DD8 800C65D8 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B6DDC 800C65DC 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B6DE0 800C65E0 4000A227 */  addiu      $v0, $sp, 0x40
    /* B6DE4 800C65E4 00004EE8 */  swc2       $14, 0x0($v0)
    /* B6DE8 800C65E8 2000A227 */  addiu      $v0, $sp, 0x20
    /* B6DEC 800C65EC 000040C8 */  lwc2       $0, 0x0($v0)
    /* B6DF0 800C65F0 040041C8 */  lwc2       $1, 0x4($v0)
    /* B6DF4 800C65F4 FF00E730 */  andi       $a3, $a3, 0xFF
    /* B6DF8 800C65F8 C0380700 */  sll        $a3, $a3, 3
    /* B6DFC 800C65FC 21102701 */  addu       $v0, $t1, $a3
    /* B6E00 800C6600 0100184A */  .word 0x4A180001  /* rtps */
    /* B6E04 800C6604 00004A8C */  lw         $t2, 0x0($v0)
    /* B6E08 800C6608 0400428C */  lw         $v0, 0x4($v0)
    /* B6E0C 800C660C 035C0A00 */  sra        $t3, $t2, 16
    /* B6E10 800C6610 21504601 */  addu       $t2, $t2, $a2
    /* B6E14 800C6614 21586501 */  addu       $t3, $t3, $a1
    /* B6E18 800C6618 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* B6E1C 800C661C 21104400 */  addu       $v0, $v0, $a0
    /* B6E20 800C6620 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* B6E24 800C6624 A8000226 */  addiu      $v0, $s0, 0xA8
    /* B6E28 800C6628 2800AAA7 */  sh         $t2, 0x28($sp)
    /* B6E2C 800C662C 2A00ABA7 */  sh         $t3, 0x2A($sp)
    /* B6E30 800C6630 000059E8 */  swc2       $25, 0x0($v0)
    /* B6E34 800C6634 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B6E38 800C6638 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B6E3C 800C663C 2800A227 */  addiu      $v0, $sp, 0x28
    /* B6E40 800C6640 000040C8 */  lwc2       $0, 0x0($v0)
    /* B6E44 800C6644 040041C8 */  lwc2       $1, 0x4($v0)
    /* B6E48 800C6648 FF000831 */  andi       $t0, $t0, 0xFF
    /* B6E4C 800C664C C0400800 */  sll        $t0, $t0, 3
    /* B6E50 800C6650 21102801 */  addu       $v0, $t1, $t0
    /* B6E54 800C6654 0100184A */  .word 0x4A180001  /* rtps */
    /* B6E58 800C6658 00004A8C */  lw         $t2, 0x0($v0)
    /* B6E5C 800C665C 0400428C */  lw         $v0, 0x4($v0)
    /* B6E60 800C6660 035C0A00 */  sra        $t3, $t2, 16
    /* B6E64 800C6664 21504601 */  addu       $t2, $t2, $a2
    /* B6E68 800C6668 21586501 */  addu       $t3, $t3, $a1
    /* B6E6C 800C666C 3400A2AF */  sw         $v0, 0x34($sp)
    /* B6E70 800C6670 21104400 */  addu       $v0, $v0, $a0
    /* B6E74 800C6674 3400A2A7 */  sh         $v0, 0x34($sp)
    /* B6E78 800C6678 B8000226 */  addiu      $v0, $s0, 0xB8
    /* B6E7C 800C667C 3000AAA7 */  sh         $t2, 0x30($sp)
    /* B6E80 800C6680 3200ABA7 */  sh         $t3, 0x32($sp)
    /* B6E84 800C6684 000059E8 */  swc2       $25, 0x0($v0)
    /* B6E88 800C6688 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B6E8C 800C668C 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B6E90 800C6690 3000A227 */  addiu      $v0, $sp, 0x30
    /* B6E94 800C6694 000040C8 */  lwc2       $0, 0x0($v0)
    /* B6E98 800C6698 040041C8 */  lwc2       $1, 0x4($v0)
    /* B6E9C 800C669C 00000000 */  nop
    /* B6EA0 800C66A0 00000000 */  nop
    /* B6EA4 800C66A4 0100184A */  .word 0x4A180001  /* rtps */
    /* B6EA8 800C66A8 C8000226 */  addiu      $v0, $s0, 0xC8
    /* B6EAC 800C66AC 000059E8 */  swc2       $25, 0x0($v0)
    /* B6EB0 800C66B0 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* B6EB4 800C66B4 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* B6EB8 800C66B8 C800038E */  lw         $v1, 0xC8($s0)
    /* B6EBC 800C66BC D000028E */  lw         $v0, 0xD0($s0)
    /* B6EC0 800C66C0 00000000 */  nop
    /* B6EC4 800C66C4 2A104300 */  slt        $v0, $v0, $v1
    /* B6EC8 800C66C8 13004010 */  beqz       $v0, .L800C6718
    /* B6ECC 800C66CC 00000000 */   nop
    /* B6ED0 800C66D0 9800038E */  lw         $v1, 0x98($s0)
    /* B6ED4 800C66D4 A000028E */  lw         $v0, 0xA0($s0)
    /* B6ED8 800C66D8 00000000 */  nop
    /* B6EDC 800C66DC 2A104300 */  slt        $v0, $v0, $v1
    /* B6EE0 800C66E0 0D004010 */  beqz       $v0, .L800C6718
    /* B6EE4 800C66E4 00000000 */   nop
    /* B6EE8 800C66E8 A800038E */  lw         $v1, 0xA8($s0)
    /* B6EEC 800C66EC B000028E */  lw         $v0, 0xB0($s0)
    /* B6EF0 800C66F0 00000000 */  nop
    /* B6EF4 800C66F4 2A104300 */  slt        $v0, $v0, $v1
    /* B6EF8 800C66F8 07004010 */  beqz       $v0, .L800C6718
    /* B6EFC 800C66FC 00000000 */   nop
    /* B6F00 800C6700 B800038E */  lw         $v1, 0xB8($s0)
    /* B6F04 800C6704 C000028E */  lw         $v0, 0xC0($s0)
    /* B6F08 800C6708 00000000 */  nop
    /* B6F0C 800C670C 2A104300 */  slt        $v0, $v0, $v1
    /* B6F10 800C6710 BF014014 */  bnez       $v0, .L800C6E10
    /* B6F14 800C6714 00000000 */   nop
  .L800C6718:
    /* B6F18 800C6718 C800028E */  lw         $v0, 0xC8($s0)
    /* B6F1C 800C671C D000038E */  lw         $v1, 0xD0($s0)
    /* B6F20 800C6720 23100200 */  negu       $v0, $v0
    /* B6F24 800C6724 2A186200 */  slt        $v1, $v1, $v0
    /* B6F28 800C6728 13006010 */  beqz       $v1, .L800C6778
    /* B6F2C 800C672C 00000000 */   nop
    /* B6F30 800C6730 9800028E */  lw         $v0, 0x98($s0)
    /* B6F34 800C6734 A000038E */  lw         $v1, 0xA0($s0)
    /* B6F38 800C6738 23100200 */  negu       $v0, $v0
    /* B6F3C 800C673C 2A186200 */  slt        $v1, $v1, $v0
    /* B6F40 800C6740 0D006010 */  beqz       $v1, .L800C6778
    /* B6F44 800C6744 00000000 */   nop
    /* B6F48 800C6748 A800028E */  lw         $v0, 0xA8($s0)
    /* B6F4C 800C674C B000038E */  lw         $v1, 0xB0($s0)
    /* B6F50 800C6750 23100200 */  negu       $v0, $v0
    /* B6F54 800C6754 2A186200 */  slt        $v1, $v1, $v0
    /* B6F58 800C6758 07006010 */  beqz       $v1, .L800C6778
    /* B6F5C 800C675C 00000000 */   nop
    /* B6F60 800C6760 B800028E */  lw         $v0, 0xB8($s0)
    /* B6F64 800C6764 C000038E */  lw         $v1, 0xC0($s0)
    /* B6F68 800C6768 23100200 */  negu       $v0, $v0
    /* B6F6C 800C676C 2A186200 */  slt        $v1, $v1, $v0
    /* B6F70 800C6770 A7016014 */  bnez       $v1, .L800C6E10
    /* B6F74 800C6774 00000000 */   nop
  .L800C6778:
    /* B6F78 800C6778 A000028E */  lw         $v0, 0xA0($s0)
    /* B6F7C 800C677C 00000000 */  nop
    /* B6F80 800C6780 0D004104 */  bgez       $v0, .L800C67B8
    /* B6F84 800C6784 00000000 */   nop
    /* B6F88 800C6788 B000028E */  lw         $v0, 0xB0($s0)
    /* B6F8C 800C678C 00000000 */  nop
    /* B6F90 800C6790 09004104 */  bgez       $v0, .L800C67B8
    /* B6F94 800C6794 00000000 */   nop
    /* B6F98 800C6798 C000028E */  lw         $v0, 0xC0($s0)
    /* B6F9C 800C679C 00000000 */  nop
    /* B6FA0 800C67A0 05004104 */  bgez       $v0, .L800C67B8
    /* B6FA4 800C67A4 00000000 */   nop
    /* B6FA8 800C67A8 D000028E */  lw         $v0, 0xD0($s0)
    /* B6FAC 800C67AC 00000000 */  nop
    /* B6FB0 800C67B0 97014004 */  bltz       $v0, .L800C6E10
    /* B6FB4 800C67B4 00000000 */   nop
  .L800C67B8:
    /* B6FB8 800C67B8 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* B6FBC 800C67BC 00008285 */  lh         $v0, 0x0($t4)
    /* B6FC0 800C67C0 F000038E */  lw         $v1, 0xF0($s0)
    /* B6FC4 800C67C4 80100200 */  sll        $v0, $v0, 2
    /* B6FC8 800C67C8 21306200 */  addu       $a2, $v1, $v0
    /* B6FCC 800C67CC 94000226 */  addiu      $v0, $s0, 0x94
    /* B6FD0 800C67D0 0000D490 */  lbu        $s4, 0x0($a2)
    /* B6FD4 800C67D4 000047E8 */  swc2       $7, 0x0($v0)
    /* B6FD8 800C67D8 4400A427 */  addiu      $a0, $sp, 0x44
    /* B6FDC 800C67DC 4800A327 */  addiu      $v1, $sp, 0x48
    /* B6FE0 800C67E0 C2101400 */  srl        $v0, $s4, 3
    /* B6FE4 800C67E4 02005630 */  andi       $s6, $v0, 0x2
    /* B6FE8 800C67E8 4C00A227 */  addiu      $v0, $sp, 0x4C
    /* B6FEC 800C67EC 00008CE8 */  swc2       $12, 0x0($a0)
    /* B6FF0 800C67F0 00006DE8 */  swc2       $13, 0x0($v1)
    /* B6FF4 800C67F4 00004EE8 */  swc2       $14, 0x0($v0)
    /* B6FF8 800C67F8 9400028E */  lw         $v0, 0x94($s0)
    /* B6FFC 800C67FC 2800C016 */  bnez       $s6, .L800C68A0
    /* B7000 800C6800 C8005528 */   slti      $s5, $v0, 0xC8
    /* B7004 800C6804 2700A016 */  bnez       $s5, .L800C68A4
    /* B7008 800C6808 5400A227 */   addiu     $v0, $sp, 0x54
    /* B700C 800C680C 0600404B */  .word 0x4B400006  /* nclip */
    /* B7010 800C6810 5000A327 */  addiu      $v1, $sp, 0x50
    /* B7014 800C6814 000078E8 */  swc2       $24, 0x0($v1)
    /* B7018 800C6818 0C00028E */  lw         $v0, 0xC($s0)
    /* B701C 800C681C 01000424 */  addiu      $a0, $zero, 0x1
    /* B7020 800C6820 05004414 */  bne        $v0, $a0, .L800C6838
    /* B7024 800C6824 00000000 */   nop
    /* B7028 800C6828 5000A28F */  lw         $v0, 0x50($sp)
    /* B702C 800C682C 00000000 */  nop
    /* B7030 800C6830 23100200 */  negu       $v0, $v0
    /* B7034 800C6834 5000A2AF */  sw         $v0, 0x50($sp)
  .L800C6838:
    /* B7038 800C6838 5000A28F */  lw         $v0, 0x50($sp)
    /* B703C 800C683C 00000000 */  nop
    /* B7040 800C6840 18004104 */  bgez       $v0, .L800C68A4
    /* B7044 800C6844 5400A227 */   addiu     $v0, $sp, 0x54
    /* B7048 800C6848 4000AF8F */  lw         $t7, 0x40($sp)
    /* B704C 800C684C 4400B88F */  lw         $t8, 0x44($sp)
    /* B7050 800C6850 4C00B98F */  lw         $t9, 0x4C($sp)
    /* B7054 800C6854 00608F48 */  mtc2       $t7, $12 /* handwritten instruction */
    /* B7058 800C6858 00709948 */  mtc2       $t9, $14 /* handwritten instruction */
    /* B705C 800C685C 00689848 */  mtc2       $t8, $13 /* handwritten instruction */
    /* B7060 800C6860 00000000 */  nop
    /* B7064 800C6864 00000000 */  nop
    /* B7068 800C6868 0600404B */  .word 0x4B400006  /* nclip */
    /* B706C 800C686C 000078E8 */  swc2       $24, 0x0($v1)
    /* B7070 800C6870 0C00028E */  lw         $v0, 0xC($s0)
    /* B7074 800C6874 00000000 */  nop
    /* B7078 800C6878 05004414 */  bne        $v0, $a0, .L800C6890
    /* B707C 800C687C 00000000 */   nop
    /* B7080 800C6880 5000A28F */  lw         $v0, 0x50($sp)
    /* B7084 800C6884 00000000 */  nop
    /* B7088 800C6888 23100200 */  negu       $v0, $v0
    /* B708C 800C688C 5000A2AF */  sw         $v0, 0x50($sp)
  .L800C6890:
    /* B7090 800C6890 5000A28F */  lw         $v0, 0x50($sp)
    /* B7094 800C6894 00000000 */  nop
    /* B7098 800C6898 5D014004 */  bltz       $v0, .L800C6E10
    /* B709C 800C689C 00000000 */   nop
  .L800C68A0:
    /* B70A0 800C68A0 5400A227 */  addiu      $v0, $sp, 0x54
  .L800C68A4:
    /* B70A4 800C68A4 000048E8 */  swc2       $8, 0x0($v0)
    /* B70A8 800C68A8 FC00028E */  lw         $v0, 0xFC($s0)
    /* B70AC 800C68AC 0200C484 */  lh         $a0, 0x2($a2)
    /* B70B0 800C68B0 0C00458C */  lw         $a1, 0xC($v0)
    /* B70B4 800C68B4 00110400 */  sll        $v0, $a0, 4
    /* B70B8 800C68B8 2190A200 */  addu       $s2, $a1, $v0
    /* B70BC 800C68BC 08008232 */  andi       $v0, $s4, 0x8
    /* B70C0 800C68C0 10004010 */  beqz       $v0, .L800C6904
    /* B70C4 800C68C4 00000000 */   nop
    /* B70C8 800C68C8 0E010292 */  lbu        $v0, 0x10E($s0)
    /* B70CC 800C68CC 00000000 */  nop
    /* B70D0 800C68D0 0C004010 */  beqz       $v0, .L800C6904
    /* B70D4 800C68D4 00000000 */   nop
    /* B70D8 800C68D8 DC000386 */  lh         $v1, 0xDC($s0)
    /* B70DC 800C68DC 9400028E */  lw         $v0, 0x94($s0)
    /* B70E0 800C68E0 00000000 */  nop
    /* B70E4 800C68E4 2A104300 */  slt        $v0, $v0, $v1
    /* B70E8 800C68E8 06004014 */  bnez       $v0, .L800C6904
    /* B70EC 800C68EC 00000000 */   nop
    /* B70F0 800C68F0 0100C290 */  lbu        $v0, 0x1($a2)
    /* B70F4 800C68F4 00000000 */  nop
    /* B70F8 800C68F8 21108200 */  addu       $v0, $a0, $v0
    /* B70FC 800C68FC 00110200 */  sll        $v0, $v0, 4
    /* B7100 800C6900 2190A200 */  addu       $s2, $a1, $v0
  .L800C6904:
    /* B7104 800C6904 9400058E */  lw         $a1, 0x94($s0)
    /* B7108 800C6908 EC00048E */  lw         $a0, 0xEC($s0)
    /* B710C 800C690C 1480033C */  lui        $v1, %hi(Draw_gMidGroundOtz)
    /* B7110 800C6910 BCD7638C */  lw         $v1, %lo(Draw_gMidGroundOtz)($v1)
    /* B7114 800C6914 43100500 */  sra        $v0, $a1, 1
    /* B7118 800C6918 21984000 */  addu       $s3, $v0, $zero
    /* B711C 800C691C 05008314 */  bne        $a0, $v1, .L800C6934
    /* B7120 800C6920 940013AE */   sw        $s3, 0x94($s0)
    /* B7124 800C6924 80981300 */  sll        $s3, $s3, 2
    /* B7128 800C6928 03110500 */  sra        $v0, $a1, 4
    /* B712C 800C692C 4E1A0308 */  j          .L800C6938
    /* B7130 800C6930 21104400 */   addu      $v0, $v0, $a0
  .L800C6934:
    /* B7134 800C6934 21106402 */  addu       $v0, $s3, $a0
  .L800C6938:
    /* B7138 800C6938 940002AE */  sw         $v0, 0x94($s0)
    /* B713C 800C693C 9400038E */  lw         $v1, 0x94($s0)
    /* B7140 800C6940 00000000 */  nop
    /* B7144 800C6944 32016018 */  blez       $v1, .L800C6E10
    /* B7148 800C6948 00000000 */   nop
    /* B714C 800C694C 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* B7150 800C6950 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* B7154 800C6954 00000000 */  nop
    /* B7158 800C6958 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* B715C 800C695C 2A104300 */  slt        $v0, $v0, $v1
    /* B7160 800C6960 2B014014 */  bnez       $v0, .L800C6E10
    /* B7164 800C6964 80008232 */   andi      $v0, $s4, 0x80
    /* B7168 800C6968 21004010 */  beqz       $v0, .L800C69F0
    /* B716C 800C696C 801F0A3C */   lui       $t2, (0x1F800004 >> 16)
    /* B7170 800C6970 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* B7174 800C6974 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* B7178 800C6978 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* B717C 800C697C 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* B7180 800C6980 3C00A0A7 */  sh         $zero, 0x3C($sp)
    /* B7184 800C6984 3E00A0A7 */  sh         $zero, 0x3E($sp)
    /* B7188 800C6988 3800A0A7 */  sh         $zero, 0x38($sp)
    /* B718C 800C698C 3A00A0A7 */  sh         $zero, 0x3A($sp)
    /* B7190 800C6990 9400028E */  lw         $v0, 0x94($s0)
    /* B7194 800C6994 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* B7198 800C6998 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* B719C 800C699C 0000448D */  lw         $a0, 0x0($t2)
    /* B71A0 800C69A0 80100200 */  sll        $v0, $v0, 2
    /* B71A4 800C69A4 21104800 */  addu       $v0, $v0, $t0
    /* B71A8 800C69A8 0000838C */  lw         $v1, 0x0($a0)
    /* B71AC 800C69AC 0000428C */  lw         $v0, 0x0($v0)
    /* B71B0 800C69B0 24186900 */  and        $v1, $v1, $t1
    /* B71B4 800C69B4 24104700 */  and        $v0, $v0, $a3
    /* B71B8 800C69B8 25186200 */  or         $v1, $v1, $v0
    /* B71BC 800C69BC 000083AC */  sw         $v1, 0x0($a0)
    /* B71C0 800C69C0 9400068E */  lw         $a2, 0x94($s0)
    /* B71C4 800C69C4 3800A527 */  addiu      $a1, $sp, 0x38
    /* B71C8 800C69C8 80300600 */  sll        $a2, $a2, 2
    /* B71CC 800C69CC 2130C800 */  addu       $a2, $a2, $t0
    /* B71D0 800C69D0 0000C28C */  lw         $v0, 0x0($a2)
    /* B71D4 800C69D4 0C008324 */  addiu      $v1, $a0, 0xC
    /* B71D8 800C69D8 000043AD */  sw         $v1, 0x0($t2)
    /* B71DC 800C69DC 24188700 */  and        $v1, $a0, $a3
    /* B71E0 800C69E0 24104900 */  and        $v0, $v0, $t1
    /* B71E4 800C69E4 25104300 */  or         $v0, $v0, $v1
    /* B71E8 800C69E8 B7B8030C */  jal        SetTexWindow
    /* B71EC 800C69EC 0000C2AC */   sw        $v0, 0x0($a2)
  .L800C69F0:
    /* B71F0 800C69F0 0300A012 */  beqz       $s5, .L800C6A00
    /* B71F4 800C69F4 94000226 */   addiu     $v0, $s0, 0x94
    /* B71F8 800C69F8 8E1A0308 */  j          .L800C6A38
    /* B71FC 800C69FC 10011126 */   addiu     $s1, $s0, 0x110
  .L800C6A00:
    /* B7200 800C6A00 0400118E */  lw         $s1, 0x4($s0)
    /* B7204 800C6A04 00004C8C */  lw         $t4, 0x0($v0)
    /* B7208 800C6A08 00000D8E */  lw         $t5, 0x0($s0)
    /* B720C 800C6A0C 34002E26 */  addiu      $t6, $s1, 0x34
    /* B7210 800C6A10 80600C00 */  sll        $t4, $t4, 2
    /* B7214 800C6A14 2168AC01 */  addu       $t5, $t5, $t4
    /* B7218 800C6A18 04000EAE */  sw         $t6, 0x4($s0)
    /* B721C 800C6A1C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B7220 800C6A20 000C0C3C */  lui        $t4, (0xC000000 >> 16)
    /* B7224 800C6A24 02720E00 */  srl        $t6, $t6, 8
    /* B7228 800C6A28 2570CC01 */  or         $t6, $t6, $t4
    /* B722C 800C6A2C 00621100 */  sll        $t4, $s1, 8
    /* B7230 800C6A30 00002EAE */  sw         $t6, 0x0($s1)
    /* B7234 800C6A34 0200ACA9 */  swl        $t4, 0x2($t5)
  .L800C6A38:
    /* B7238 800C6A38 4000A28F */  lw         $v0, 0x40($sp)
    /* B723C 800C6A3C 4400A38F */  lw         $v1, 0x44($sp)
    /* B7240 800C6A40 4C00A48F */  lw         $a0, 0x4C($sp)
    /* B7244 800C6A44 4800A58F */  lw         $a1, 0x48($sp)
    /* B7248 800C6A48 080022AE */  sw         $v0, 0x8($s1)
    /* B724C 800C6A4C 140023AE */  sw         $v1, 0x14($s1)
    /* B7250 800C6A50 200024AE */  sw         $a0, 0x20($s1)
    /* B7254 800C6A54 2C0025AE */  sw         $a1, 0x2C($s1)
    /* B7258 800C6A58 06010292 */  lbu        $v0, 0x106($s0)
    /* B725C 800C6A5C 00000000 */  nop
    /* B7260 800C6A60 0B004010 */  beqz       $v0, .L800C6A90
    /* B7264 800C6A64 21200002 */   addu      $a0, $s0, $zero
    /* B7268 800C6A68 21282002 */  addu       $a1, $s1, $zero
    /* B726C 800C6A6C 2800A227 */  addiu      $v0, $sp, 0x28
    /* B7270 800C6A70 1000A2AF */  sw         $v0, 0x10($sp)
    /* B7274 800C6A74 3000A227 */  addiu      $v0, $sp, 0x30
    /* B7278 800C6A78 1800A627 */  addiu      $a2, $sp, 0x18
    /* B727C 800C6A7C 2000A727 */  addiu      $a3, $sp, 0x20
    /* B7280 800C6A80 2718030C */  jal        DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
    /* B7284 800C6A84 1400A2AF */   sw        $v0, 0x14($sp)
    /* B7288 800C6A88 ED1A0308 */  j          .L800C6BB4
    /* B728C 800C6A8C 0C000224 */   addiu     $v0, $zero, 0xC
  .L800C6A90:
    /* B7290 800C6A90 5400AF8F */  lw         $t7, 0x54($sp)
    /* B7294 800C6A94 00000000 */  nop
    /* B7298 800C6A98 00408F48 */  mtc2       $t7, $8 /* handwritten instruction */
    /* B729C 800C6A9C D8000486 */  lh         $a0, 0xD8($s0)
    /* B72A0 800C6AA0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B72A4 800C6AA4 2F008214 */  bne        $a0, $v0, .L800C6B64
    /* B72A8 800C6AA8 80100400 */   sll       $v0, $a0, 2
    /* B72AC 800C6AAC 2E00A287 */  lh         $v0, 0x2E($sp)
    /* B72B0 800C6AB0 1480053C */  lui        $a1, %hi(Chunk_lightTable)
    /* B72B4 800C6AB4 18C8A58C */  lw         $a1, %lo(Chunk_lightTable)($a1)
    /* B72B8 800C6AB8 80100200 */  sll        $v0, $v0, 2
    /* B72BC 800C6ABC 21104500 */  addu       $v0, $v0, $a1
    /* B72C0 800C6AC0 0000428C */  lw         $v0, 0x0($v0)
    /* B72C4 800C6AC4 5800A627 */  addiu      $a2, $sp, 0x58
    /* B72C8 800C6AC8 5800A2AF */  sw         $v0, 0x58($sp)
    /* B72CC 800C6ACC 0000C6C8 */  lwc2       $6, 0x0($a2)
    /* B72D0 800C6AD0 00000000 */  nop
    /* B72D4 800C6AD4 00000000 */  nop
    /* B72D8 800C6AD8 1000784A */  .word 0x4A780010  /* dpcs */
    /* B72DC 800C6ADC 1E00A487 */  lh         $a0, 0x1E($sp)
    /* B72E0 800C6AE0 2600A387 */  lh         $v1, 0x26($sp)
    /* B72E4 800C6AE4 3600A287 */  lh         $v0, 0x36($sp)
    /* B72E8 800C6AE8 80200400 */  sll        $a0, $a0, 2
    /* B72EC 800C6AEC 21208500 */  addu       $a0, $a0, $a1
    /* B72F0 800C6AF0 80180300 */  sll        $v1, $v1, 2
    /* B72F4 800C6AF4 21186500 */  addu       $v1, $v1, $a1
    /* B72F8 800C6AF8 80100200 */  sll        $v0, $v0, 2
    /* B72FC 800C6AFC 21104500 */  addu       $v0, $v0, $a1
    /* B7300 800C6B00 0000428C */  lw         $v0, 0x0($v0)
    /* B7304 800C6B04 0000848C */  lw         $a0, 0x0($a0)
    /* B7308 800C6B08 0000638C */  lw         $v1, 0x0($v1)
    /* B730C 800C6B0C 6000A2AF */  sw         $v0, 0x60($sp)
    /* B7310 800C6B10 28002226 */  addiu      $v0, $s1, 0x28
    /* B7314 800C6B14 5800A4AF */  sw         $a0, 0x58($sp)
    /* B7318 800C6B18 5C00A3AF */  sw         $v1, 0x5C($sp)
    /* B731C 800C6B1C 000056E8 */  swc2       $22, 0x0($v0)
    /* B7320 800C6B20 5C00A327 */  addiu      $v1, $sp, 0x5C
    /* B7324 800C6B24 6000A227 */  addiu      $v0, $sp, 0x60
    /* B7328 800C6B28 0000D4C8 */  lwc2       $20, 0x0($a2)
    /* B732C 800C6B2C 000075C8 */  lwc2       $21, 0x0($v1)
    /* B7330 800C6B30 000056C8 */  lwc2       $22, 0x0($v0)
    /* B7334 800C6B34 000046C8 */  lwc2       $6, 0x0($v0)
    /* B7338 800C6B38 00000000 */  nop
    /* B733C 800C6B3C 00000000 */  nop
    /* B7340 800C6B40 2A00F84A */  .word 0x4AF8002A  /* dpct */
    /* B7344 800C6B44 04002426 */  addiu      $a0, $s1, 0x4
    /* B7348 800C6B48 10002326 */  addiu      $v1, $s1, 0x10
    /* B734C 800C6B4C 1C002226 */  addiu      $v0, $s1, 0x1C
    /* B7350 800C6B50 000094E8 */  swc2       $20, 0x0($a0)
    /* B7354 800C6B54 000075E8 */  swc2       $21, 0x0($v1)
    /* B7358 800C6B58 000056E8 */  swc2       $22, 0x0($v0)
    /* B735C 800C6B5C ED1A0308 */  j          .L800C6BB4
    /* B7360 800C6B60 0C000224 */   addiu     $v0, $zero, 0xC
  .L800C6B64:
    /* B7364 800C6B64 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* B7368 800C6B68 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* B736C 800C6B6C 00000000 */  nop
    /* B7370 800C6B70 21104300 */  addu       $v0, $v0, $v1
    /* B7374 800C6B74 0000428C */  lw         $v0, 0x0($v0)
    /* B7378 800C6B78 00000000 */  nop
    /* B737C 800C6B7C 6400A2AF */  sw         $v0, 0x64($sp)
    /* B7380 800C6B80 6400A227 */  addiu      $v0, $sp, 0x64
    /* B7384 800C6B84 000046C8 */  lwc2       $6, 0x0($v0)
    /* B7388 800C6B88 00000000 */  nop
    /* B738C 800C6B8C 00000000 */  nop
    /* B7390 800C6B90 1000784A */  .word 0x4A780010  /* dpcs */
    /* B7394 800C6B94 000056E8 */  swc2       $22, 0x0($v0)
    /* B7398 800C6B98 6400A28F */  lw         $v0, 0x64($sp)
    /* B739C 800C6B9C 00000000 */  nop
    /* B73A0 800C6BA0 040022AE */  sw         $v0, 0x4($s1)
    /* B73A4 800C6BA4 100022AE */  sw         $v0, 0x10($s1)
    /* B73A8 800C6BA8 1C0022AE */  sw         $v0, 0x1C($s1)
    /* B73AC 800C6BAC 280022AE */  sw         $v0, 0x28($s1)
    /* B73B0 800C6BB0 0C000224 */  addiu      $v0, $zero, 0xC
  .L800C6BB4:
    /* B73B4 800C6BB4 030022A2 */  sb         $v0, 0x3($s1)
    /* B73B8 800C6BB8 0E004292 */  lbu        $v0, 0xE($s2)
    /* B73BC 800C6BBC 00000000 */  nop
    /* B73C0 800C6BC0 3C004234 */  ori        $v0, $v0, 0x3C
    /* B73C4 800C6BC4 070022A2 */  sb         $v0, 0x7($s1)
    /* B73C8 800C6BC8 0000428E */  lw         $v0, 0x0($s2)
    /* B73CC 800C6BCC 0400438E */  lw         $v1, 0x4($s2)
    /* B73D0 800C6BD0 0800448E */  lw         $a0, 0x8($s2)
    /* B73D4 800C6BD4 0C00458E */  lw         $a1, 0xC($s2)
    /* B73D8 800C6BD8 0C0022AE */  sw         $v0, 0xC($s1)
    /* B73DC 800C6BDC 180023AE */  sw         $v1, 0x18($s1)
    /* B73E0 800C6BE0 0E002396 */  lhu        $v1, 0xE($s1)
    /* B73E4 800C6BE4 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* B73E8 800C6BE8 240024AE */  sw         $a0, 0x24($s1)
    /* B73EC 800C6BEC 17006214 */  bne        $v1, $v0, .L800C6C4C
    /* B73F0 800C6BF0 300025AE */   sw        $a1, 0x30($s1)
    /* B73F4 800C6BF4 DC000286 */  lh         $v0, 0xDC($s0)
    /* B73F8 800C6BF8 DE000386 */  lh         $v1, 0xDE($s0)
    /* B73FC 800C6BFC 23106202 */  subu       $v0, $s3, $v0
    /* B7400 800C6C00 00110200 */  sll        $v0, $v0, 4
    /* B7404 800C6C04 07286200 */  srav       $a1, $v0, $v1
    /* B7408 800C6C08 0300A104 */  bgez       $a1, .L800C6C18
    /* B740C 800C6C0C 1000A228 */   slti      $v0, $a1, 0x10
    /* B7410 800C6C10 091B0308 */  j          .L800C6C24
    /* B7414 800C6C14 21280000 */   addu      $a1, $zero, $zero
  .L800C6C18:
    /* B7418 800C6C18 03004014 */  bnez       $v0, .L800C6C28
    /* B741C 800C6C1C 1280043C */   lui       $a0, %hi(gClutDepth)
    /* B7420 800C6C20 0F000524 */  addiu      $a1, $zero, 0xF
  .L800C6C24:
    /* B7424 800C6C24 1280043C */  lui        $a0, %hi(gClutDepth)
  .L800C6C28:
    /* B7428 800C6C28 7C108424 */  addiu      $a0, $a0, %lo(gClutDepth)
    /* B742C 800C6C2C 0A004396 */  lhu        $v1, 0xA($s2)
    /* B7430 800C6C30 40100500 */  sll        $v0, $a1, 1
    /* B7434 800C6C34 40190300 */  sll        $v1, $v1, 5
    /* B7438 800C6C38 21104300 */  addu       $v0, $v0, $v1
    /* B743C 800C6C3C 21104400 */  addu       $v0, $v0, $a0
    /* B7440 800C6C40 00004294 */  lhu        $v0, 0x0($v0)
    /* B7444 800C6C44 00000000 */  nop
    /* B7448 800C6C48 0E0022A6 */  sh         $v0, 0xE($s1)
  .L800C6C4C:
    /* B744C 800C6C4C 3D00A012 */  beqz       $s5, .L800C6D44
    /* B7450 800C6C50 74000226 */   addiu     $v0, $s0, 0x74
    /* B7454 800C6C54 07011192 */  lbu        $s1, 0x107($s0)
    /* B7458 800C6C58 00004C8C */  lw         $t4, 0x0($v0)
    /* B745C 800C6C5C 04004D8C */  lw         $t5, 0x4($v0)
    /* B7460 800C6C60 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B7464 800C6C64 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B7468 800C6C68 08004C8C */  lw         $t4, 0x8($v0)
    /* B746C 800C6C6C 0C004D8C */  lw         $t5, 0xC($v0)
    /* B7470 800C6C70 10004E8C */  lw         $t6, 0x10($v0)
    /* B7474 800C6C74 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B7478 800C6C78 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B747C 800C6C7C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B7480 800C6C80 07002016 */  bnez       $s1, .L800C6CA0
    /* B7484 800C6C84 00000000 */   nop
    /* B7488 800C6C88 14004C8C */  lw         $t4, 0x14($v0)
    /* B748C 800C6C8C 18004D8C */  lw         $t5, 0x18($v0)
    /* B7490 800C6C90 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B7494 800C6C94 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B7498 800C6C98 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B749C 800C6C9C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800C6CA0:
    /* B74A0 800C6CA0 D012828F */  lw         $v0, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B74A4 800C6CA4 00000000 */  nop
    /* B74A8 800C6CA8 11004010 */  beqz       $v0, .L800C6CF0
    /* B74AC 800C6CAC 2120C002 */   addu      $a0, $s6, $zero
    /* B74B0 800C6CB0 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* B74B4 800C6CB4 2B91030C */  jal        SetSp
    /* B74B8 800C6CB8 00000000 */   nop
    /* B74BC 800C6CBC 2120C002 */  addu       $a0, $s6, $zero
    /* B74C0 800C6CC0 E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B74C4 800C6CC4 D01280AF */  sw         $zero, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B74C8 800C6CC8 F816030C */  jal        DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
    /* B74CC 800C6CCC 21280002 */   addu      $a1, $s0, $zero
    /* B74D0 800C6CD0 E412848F */  lw         $a0, %gp_rel(gWSavePtr)($gp)
    /* B74D4 800C6CD4 2B91030C */  jal        SetSp
    /* B74D8 800C6CD8 00000000 */   nop
    /* B74DC 800C6CDC E41282AF */  sw         $v0, %gp_rel(gWSavePtr)($gp)
    /* B74E0 800C6CE0 01000224 */  addiu      $v0, $zero, 0x1
    /* B74E4 800C6CE4 D01282AF */  sw         $v0, %gp_rel(stackSpeedUpEnbabledFlag)($gp)
    /* B74E8 800C6CE8 3F1B0308 */  j          .L800C6CFC
    /* B74EC 800C6CEC 14000226 */   addiu     $v0, $s0, 0x14
  .L800C6CF0:
    /* B74F0 800C6CF0 F816030C */  jal        DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
    /* B74F4 800C6CF4 21280002 */   addu      $a1, $s0, $zero
    /* B74F8 800C6CF8 14000226 */  addiu      $v0, $s0, 0x14
  .L800C6CFC:
    /* B74FC 800C6CFC 00004C8C */  lw         $t4, 0x0($v0)
    /* B7500 800C6D00 04004D8C */  lw         $t5, 0x4($v0)
    /* B7504 800C6D04 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B7508 800C6D08 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B750C 800C6D0C 08004C8C */  lw         $t4, 0x8($v0)
    /* B7510 800C6D10 0C004D8C */  lw         $t5, 0xC($v0)
    /* B7514 800C6D14 10004E8C */  lw         $t6, 0x10($v0)
    /* B7518 800C6D18 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B751C 800C6D1C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B7520 800C6D20 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B7524 800C6D24 07002016 */  bnez       $s1, .L800C6D44
    /* B7528 800C6D28 00000000 */   nop
    /* B752C 800C6D2C 14004C8C */  lw         $t4, 0x14($v0)
    /* B7530 800C6D30 18004D8C */  lw         $t5, 0x18($v0)
    /* B7534 800C6D34 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B7538 800C6D38 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B753C 800C6D3C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B7540 800C6D40 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800C6D44:
    /* B7544 800C6D44 80008232 */  andi       $v0, $s4, 0x80
    /* B7548 800C6D48 31004010 */  beqz       $v0, .L800C6E10
    /* B754C 800C6D4C 00000000 */   nop
    /* B7550 800C6D50 0C004392 */  lbu        $v1, 0xC($s2)
    /* B7554 800C6D54 00004292 */  lbu        $v0, 0x0($s2)
    /* B7558 800C6D58 00000000 */  nop
    /* B755C 800C6D5C 23206200 */  subu       $a0, $v1, $v0
    /* B7560 800C6D60 02008104 */  bgez       $a0, .L800C6D6C
    /* B7564 800C6D64 00000000 */   nop
    /* B7568 800C6D68 23200400 */  negu       $a0, $a0
  .L800C6D6C:
    /* B756C 800C6D6C 0D004392 */  lbu        $v1, 0xD($s2)
    /* B7570 800C6D70 01004292 */  lbu        $v0, 0x1($s2)
    /* B7574 800C6D74 00000000 */  nop
    /* B7578 800C6D78 23186200 */  subu       $v1, $v1, $v0
    /* B757C 800C6D7C 02006104 */  bgez       $v1, .L800C6D88
    /* B7580 800C6D80 801F0A3C */   lui       $t2, (0x1F800004 >> 16)
    /* B7584 800C6D84 23180300 */  negu       $v1, $v1
  .L800C6D88:
    /* B7588 800C6D88 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* B758C 800C6D8C FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* B7590 800C6D90 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* B7594 800C6D94 01008224 */  addiu      $v0, $a0, 0x1
    /* B7598 800C6D98 3C00A2A7 */  sh         $v0, 0x3C($sp)
    /* B759C 800C6D9C 01006224 */  addiu      $v0, $v1, 0x1
    /* B75A0 800C6DA0 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* B75A4 800C6DA4 3E00A2A7 */  sh         $v0, 0x3E($sp)
    /* B75A8 800C6DA8 3800A0A7 */  sh         $zero, 0x38($sp)
    /* B75AC 800C6DAC 3A00A0A7 */  sh         $zero, 0x3A($sp)
    /* B75B0 800C6DB0 9400028E */  lw         $v0, 0x94($s0)
    /* B75B4 800C6DB4 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* B75B8 800C6DB8 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* B75BC 800C6DBC 0000448D */  lw         $a0, 0x0($t2)
    /* B75C0 800C6DC0 80100200 */  sll        $v0, $v0, 2
    /* B75C4 800C6DC4 21104800 */  addu       $v0, $v0, $t0
    /* B75C8 800C6DC8 0000838C */  lw         $v1, 0x0($a0)
    /* B75CC 800C6DCC 0000428C */  lw         $v0, 0x0($v0)
    /* B75D0 800C6DD0 24186900 */  and        $v1, $v1, $t1
    /* B75D4 800C6DD4 24104700 */  and        $v0, $v0, $a3
    /* B75D8 800C6DD8 25186200 */  or         $v1, $v1, $v0
    /* B75DC 800C6DDC 000083AC */  sw         $v1, 0x0($a0)
    /* B75E0 800C6DE0 9400068E */  lw         $a2, 0x94($s0)
    /* B75E4 800C6DE4 3800A527 */  addiu      $a1, $sp, 0x38
    /* B75E8 800C6DE8 80300600 */  sll        $a2, $a2, 2
    /* B75EC 800C6DEC 2130C800 */  addu       $a2, $a2, $t0
    /* B75F0 800C6DF0 0000C28C */  lw         $v0, 0x0($a2)
    /* B75F4 800C6DF4 0C008324 */  addiu      $v1, $a0, 0xC
    /* B75F8 800C6DF8 000043AD */  sw         $v1, 0x0($t2)
    /* B75FC 800C6DFC 24188700 */  and        $v1, $a0, $a3
    /* B7600 800C6E00 24104900 */  and        $v0, $v0, $t1
    /* B7604 800C6E04 25104300 */  or         $v0, $v0, $v1
    /* B7608 800C6E08 B7B8030C */  jal        SetTexWindow
    /* B760C 800C6E0C 0000C2AC */   sw        $v0, 0x0($a2)
  .L800C6E10:
    /* B7610 800C6E10 8400BF8F */  lw         $ra, 0x84($sp)
    /* B7614 800C6E14 8000B68F */  lw         $s6, 0x80($sp)
    /* B7618 800C6E18 7C00B58F */  lw         $s5, 0x7C($sp)
    /* B761C 800C6E1C 7800B48F */  lw         $s4, 0x78($sp)
    /* B7620 800C6E20 7400B38F */  lw         $s3, 0x74($sp)
    /* B7624 800C6E24 7000B28F */  lw         $s2, 0x70($sp)
    /* B7628 800C6E28 6C00B18F */  lw         $s1, 0x6C($sp)
    /* B762C 800C6E2C 6800B08F */  lw         $s0, 0x68($sp)
    /* B7630 800C6E30 0800E003 */  jr         $ra
    /* B7634 800C6E34 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
