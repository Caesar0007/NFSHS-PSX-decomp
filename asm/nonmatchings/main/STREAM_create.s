.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_create, 0x240

glabel STREAM_create
    /* ED614 800FCE14 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* ED618 800FCE18 1400B1AF */  sw         $s1, 0x14($sp)
    /* ED61C 800FCE1C 21888000 */  addu       $s1, $a0, $zero
    /* ED620 800FCE20 1800B2AF */  sw         $s2, 0x18($sp)
    /* ED624 800FCE24 2190A000 */  addu       $s2, $a1, $zero
    /* ED628 800FCE28 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* ED62C 800FCE2C 2198C000 */  addu       $s3, $a2, $zero
    /* ED630 800FCE30 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED634 800FCE34 2000B4AF */  sw         $s4, 0x20($sp)
    /* ED638 800FCE38 3800B48F */  lw         $s4, 0x38($sp)
    /* ED63C 800FCE3C 2400BFAF */  sw         $ra, 0x24($sp)
    /* ED640 800FCE40 78F3030C */  jal        STREAM_overhead
    /* ED644 800FCE44 2180E000 */   addu      $s0, $a3, $zero
    /* ED648 800FCE48 23108202 */  subu       $v0, $s4, $v0
    /* ED64C 800FCE4C 00604228 */  slti       $v0, $v0, 0x6000
    /* ED650 800FCE50 78004014 */  bnez       $v0, .L800FD034
    /* ED654 800FCE54 21100000 */   addu      $v0, $zero, $zero
    /* ED658 800FCE58 0200222A */  slti       $v0, $s1, 0x2
    /* ED65C 800FCE5C 03004010 */  beqz       $v0, .L800FCE6C
    /* ED660 800FCE60 0101222A */   slti      $v0, $s1, 0x101
  .L800FCE64:
    /* ED664 800FCE64 0DF40308 */  j          .L800FD034
    /* ED668 800FCE68 21100000 */   addu      $v0, $zero, $zero
  .L800FCE6C:
    /* ED66C 800FCE6C FDFF4010 */  beqz       $v0, .L800FCE64
    /* ED670 800FCE70 FFFF4226 */   addiu     $v0, $s2, -0x1
    /* ED674 800FCE74 1000422C */  sltiu      $v0, $v0, 0x10
    /* ED678 800FCE78 6E004010 */  beqz       $v0, .L800FD034
    /* ED67C 800FCE7C 21100000 */   addu      $v0, $zero, $zero
    /* ED680 800FCE80 F8FF601A */  blez       $s3, .L800FCE64
    /* ED684 800FCE84 2A105302 */   slt       $v0, $s2, $s3
    /* ED688 800FCE88 6A004014 */  bnez       $v0, .L800FD034
    /* ED68C 800FCE8C 21100000 */   addu      $v0, $zero, $zero
    /* ED690 800FCE90 524D023C */  lui        $v0, (0x4D525453 >> 16)
    /* ED694 800FCE94 53544234 */  ori        $v0, $v0, (0x4D525453 & 0xFFFF)
    /* ED698 800FCE98 09F9030C */  jal        allocmutex
    /* ED69C 800FCE9C 000002AE */   sw        $v0, 0x0($s0)
    /* ED6A0 800FCEA0 5C000426 */  addiu      $a0, $s0, 0x5C
    /* ED6A4 800FCEA4 21280000 */  addu       $a1, $zero, $zero
    /* ED6A8 800FCEA8 40000624 */  addiu      $a2, $zero, 0x40
    /* ED6AC 800FCEAC 040002AE */  sw         $v0, 0x4($s0)
    /* ED6B0 800FCEB0 AC000226 */  addiu      $v0, $s0, 0xAC
    /* ED6B4 800FCEB4 080002AE */  sw         $v0, 0x8($s0)
    /* ED6B8 800FCEB8 21101402 */  addu       $v0, $s0, $s4
    /* ED6BC 800FCEBC 240002AE */  sw         $v0, 0x24($s0)
    /* ED6C0 800FCEC0 96000224 */  addiu      $v0, $zero, 0x96
    /* ED6C4 800FCEC4 2C0002AE */  sw         $v0, 0x2C($s0)
    /* ED6C8 800FCEC8 40101100 */  sll        $v0, $s1, 1
    /* ED6CC 800FCECC 21105100 */  addu       $v0, $v0, $s1
    /* ED6D0 800FCED0 C0100200 */  sll        $v0, $v0, 3
    /* ED6D4 800FCED4 21105100 */  addu       $v0, $v0, $s1
    /* ED6D8 800FCED8 0800038E */  lw         $v1, 0x8($s0)
    /* ED6DC 800FCEDC 80100200 */  sll        $v0, $v0, 2
    /* ED6E0 800FCEE0 0C0011AE */  sw         $s1, 0xC($s0)
    /* ED6E4 800FCEE4 140012AE */  sw         $s2, 0x14($s0)
    /* ED6E8 800FCEE8 1C0013AE */  sw         $s3, 0x1C($s0)
    /* ED6EC 800FCEEC 280000AE */  sw         $zero, 0x28($s0)
    /* ED6F0 800FCEF0 340000AE */  sw         $zero, 0x34($s0)
    /* ED6F4 800FCEF4 380000AE */  sw         $zero, 0x38($s0)
    /* ED6F8 800FCEF8 3C0000AE */  sw         $zero, 0x3C($s0)
    /* ED6FC 800FCEFC 4C0000AE */  sw         $zero, 0x4C($s0)
    /* ED700 800FCF00 500000AE */  sw         $zero, 0x50($s0)
    /* ED704 800FCF04 540000AE */  sw         $zero, 0x54($s0)
    /* ED708 800FCF08 21186200 */  addu       $v1, $v1, $v0
    /* ED70C 800FCF0C 40101200 */  sll        $v0, $s2, 1
    /* ED710 800FCF10 21105200 */  addu       $v0, $v0, $s2
    /* ED714 800FCF14 80100200 */  sll        $v0, $v0, 2
    /* ED718 800FCF18 100003AE */  sw         $v1, 0x10($s0)
    /* ED71C 800FCF1C 21186200 */  addu       $v1, $v1, $v0
    /* ED720 800FCF20 180003AE */  sw         $v1, 0x18($s0)
    /* ED724 800FCF24 21106000 */  addu       $v0, $v1, $zero
    /* ED728 800FCF28 00191300 */  sll        $v1, $s3, 4
    /* ED72C 800FCF2C 21104300 */  addu       $v0, $v0, $v1
    /* ED730 800FCF30 200002AE */  sw         $v0, 0x20($s0)
    /* ED734 800FCF34 21384000 */  addu       $a3, $v0, $zero
    /* ED738 800FCF38 21404000 */  addu       $t0, $v0, $zero
    /* ED73C 800FCF3C 21484000 */  addu       $t1, $v0, $zero
    /* ED740 800FCF40 0800038E */  lw         $v1, 0x8($s0)
    /* ED744 800FCF44 32000224 */  addiu      $v0, $zero, 0x32
    /* ED748 800FCF48 300002AE */  sw         $v0, 0x30($s0)
    /* ED74C 800FCF4C 400007AE */  sw         $a3, 0x40($s0)
    /* ED750 800FCF50 440008AE */  sw         $t0, 0x44($s0)
    /* ED754 800FCF54 480009AE */  sw         $t1, 0x48($s0)
    /* ED758 800FCF58 C690030C */  jal        memset
    /* ED75C 800FCF5C 580003AE */   sw        $v1, 0x58($s0)
    /* ED760 800FCF60 21280000 */  addu       $a1, $zero, $zero
    /* ED764 800FCF64 1100201A */  blez       $s1, .L800FCFAC
    /* ED768 800FCF68 9C0000AE */   sw        $zero, 0x9C($s0)
    /* ED76C 800FCF6C 64000624 */  addiu      $a2, $zero, 0x64
    /* ED770 800FCF70 2120A000 */  addu       $a0, $a1, $zero
  .L800FCF74:
    /* ED774 800FCF74 0800038E */  lw         $v1, 0x8($s0)
    /* ED778 800FCF78 00000000 */  nop
    /* ED77C 800FCF7C 21186400 */  addu       $v1, $v1, $a0
    /* ED780 800FCF80 64008424 */  addiu      $a0, $a0, 0x64
    /* ED784 800FCF84 000065AC */  sw         $a1, 0x0($v1)
    /* ED788 800FCF88 040060AC */  sw         $zero, 0x4($v1)
    /* ED78C 800FCF8C 0800028E */  lw         $v0, 0x8($s0)
    /* ED790 800FCF90 0100A524 */  addiu      $a1, $a1, 0x1
    /* ED794 800FCF94 21104600 */  addu       $v0, $v0, $a2
    /* ED798 800FCF98 0C0062AC */  sw         $v0, 0xC($v1)
    /* ED79C 800FCF9C 2A10B100 */  slt        $v0, $a1, $s1
    /* ED7A0 800FCFA0 F4FF4014 */  bnez       $v0, .L800FCF74
    /* ED7A4 800FCFA4 6400C624 */   addiu     $a2, $a2, 0x64
    /* ED7A8 800FCFA8 21280000 */  addu       $a1, $zero, $zero
  .L800FCFAC:
    /* ED7AC 800FCFAC 40101100 */  sll        $v0, $s1, 1
    /* ED7B0 800FCFB0 21105100 */  addu       $v0, $v0, $s1
    /* ED7B4 800FCFB4 C0100200 */  sll        $v0, $v0, 3
    /* ED7B8 800FCFB8 21105100 */  addu       $v0, $v0, $s1
    /* ED7BC 800FCFBC 0800038E */  lw         $v1, 0x8($s0)
    /* ED7C0 800FCFC0 80100200 */  sll        $v0, $v0, 2
    /* ED7C4 800FCFC4 21104300 */  addu       $v0, $v0, $v1
    /* ED7C8 800FCFC8 0C00401A */  blez       $s2, .L800FCFFC
    /* ED7CC 800FCFCC A8FF40AC */   sw        $zero, -0x58($v0)
    /* ED7D0 800FCFD0 01000424 */  addiu      $a0, $zero, 0x1
    /* ED7D4 800FCFD4 2118A000 */  addu       $v1, $a1, $zero
  .L800FCFD8:
    /* ED7D8 800FCFD8 1000028E */  lw         $v0, 0x10($s0)
    /* ED7DC 800FCFDC 0100A524 */  addiu      $a1, $a1, 0x1
    /* ED7E0 800FCFE0 21104300 */  addu       $v0, $v0, $v1
    /* ED7E4 800FCFE4 000040AC */  sw         $zero, 0x0($v0)
    /* ED7E8 800FCFE8 040040AC */  sw         $zero, 0x4($v0)
    /* ED7EC 800FCFEC 080044AC */  sw         $a0, 0x8($v0)
    /* ED7F0 800FCFF0 2A10B200 */  slt        $v0, $a1, $s2
    /* ED7F4 800FCFF4 F8FF4014 */  bnez       $v0, .L800FCFD8
    /* ED7F8 800FCFF8 0C006324 */   addiu     $v1, $v1, 0xC
  .L800FCFFC:
    /* ED7FC 800FCFFC 0C00601A */  blez       $s3, .L800FD030
    /* ED800 800FD000 21280000 */   addu      $a1, $zero, $zero
    /* ED804 800FD004 00210500 */  sll        $a0, $a1, 4
  .L800FD008:
    /* ED808 800FD008 0100A324 */  addiu      $v1, $a1, 0x1
    /* ED80C 800FD00C 1800028E */  lw         $v0, 0x18($s0)
    /* ED810 800FD010 21286000 */  addu       $a1, $v1, $zero
    /* ED814 800FD014 21104400 */  addu       $v0, $v0, $a0
    /* ED818 800FD018 000050AC */  sw         $s0, 0x0($v0)
    /* ED81C 800FD01C 040045AC */  sw         $a1, 0x4($v0)
    /* ED820 800FD020 080040AC */  sw         $zero, 0x8($v0)
    /* ED824 800FD024 2A10B300 */  slt        $v0, $a1, $s3
    /* ED828 800FD028 F7FF4014 */  bnez       $v0, .L800FD008
    /* ED82C 800FD02C 00210500 */   sll       $a0, $a1, 4
  .L800FD030:
    /* ED830 800FD030 1800028E */  lw         $v0, 0x18($s0)
  .L800FD034:
    /* ED834 800FD034 2400BF8F */  lw         $ra, 0x24($sp)
    /* ED838 800FD038 2000B48F */  lw         $s4, 0x20($sp)
    /* ED83C 800FD03C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* ED840 800FD040 1800B28F */  lw         $s2, 0x18($sp)
    /* ED844 800FD044 1400B18F */  lw         $s1, 0x14($sp)
    /* ED848 800FD048 1000B08F */  lw         $s0, 0x10($sp)
    /* ED84C 800FD04C 0800E003 */  jr         $ra
    /* ED850 800FD050 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel STREAM_create
