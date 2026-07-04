.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_priorityop, 0x13C

glabel FILE_priorityop
    /* DC6CC 800EBECC F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* DC6D0 800EBED0 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DC6D4 800EBED4 88EA4724 */  addiu      $a3, $v0, %lo(gFileDevice)
    /* DC6D8 800EBED8 021E0400 */  srl        $v1, $a0, 24
    /* DC6DC 800EBEDC 40100300 */  sll        $v0, $v1, 1
    /* DC6E0 800EBEE0 21104300 */  addu       $v0, $v0, $v1
    /* DC6E4 800EBEE4 1800E38C */  lw         $v1, 0x18($a3)
    /* DC6E8 800EBEE8 00110200 */  sll        $v0, $v0, 4
    /* DC6EC 800EBEEC 21306200 */  addu       $a2, $v1, $v0
    /* DC6F0 800EBEF0 00600940 */  mfc0       $t1, $12 /* handwritten instruction */
    /* DC6F4 800EBEF4 00000000 */  nop
    /* DC6F8 800EBEF8 FEFB0124 */  addiu      $at, $zero, -0x402
    /* DC6FC 800EBEFC 24402101 */  and        $t0, $t1, $at
    /* DC700 800EBF00 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DC704 800EBF04 00000000 */  nop
    /* DC708 800EBF08 00000000 */  nop
    /* DC70C 800EBF0C 00000000 */  nop
    /* DC710 800EBF10 1000C38C */  lw         $v1, 0x10($a2)
    /* DC714 800EBF14 1000C5AC */  sw         $a1, 0x10($a2)
    /* DC718 800EBF18 0C00E28C */  lw         $v0, 0xC($a3)
    /* DC71C 800EBF1C 00000000 */  nop
    /* DC720 800EBF20 02004228 */  slti       $v0, $v0, 0x2
    /* DC724 800EBF24 35004014 */  bnez       $v0, .L800EBFFC
    /* DC728 800EBF28 00000000 */   nop
    /* DC72C 800EBF2C 1400E28C */  lw         $v0, 0x14($a3)
    /* DC730 800EBF30 00000000 */  nop
    /* DC734 800EBF34 3100C210 */  beq        $a2, $v0, .L800EBFFC
    /* DC738 800EBF38 00000000 */   nop
    /* DC73C 800EBF3C 0800C28C */  lw         $v0, 0x8($a2)
    /* DC740 800EBF40 00000000 */  nop
    /* DC744 800EBF44 2D004014 */  bnez       $v0, .L800EBFFC
    /* DC748 800EBF48 00000000 */   nop
    /* DC74C 800EBF4C 2B006510 */  beq        $v1, $a1, .L800EBFFC
    /* DC750 800EBF50 00000000 */   nop
    /* DC754 800EBF54 2000E28C */  lw         $v0, 0x20($a3)
    /* DC758 800EBF58 00000000 */  nop
    /* DC75C 800EBF5C 08004010 */  beqz       $v0, .L800EBF80
    /* DC760 800EBF60 21200000 */   addu      $a0, $zero, $zero
  .L800EBF64:
    /* DC764 800EBF64 06004610 */  beq        $v0, $a2, .L800EBF80
    /* DC768 800EBF68 00000000 */   nop
    /* DC76C 800EBF6C 21204000 */  addu       $a0, $v0, $zero
    /* DC770 800EBF70 2C00828C */  lw         $v0, 0x2C($a0)
    /* DC774 800EBF74 00000000 */  nop
    /* DC778 800EBF78 FAFF4014 */  bnez       $v0, .L800EBF64
    /* DC77C 800EBF7C 00000000 */   nop
  .L800EBF80:
    /* DC780 800EBF80 04008010 */  beqz       $a0, .L800EBF94
    /* DC784 800EBF84 1480023C */   lui       $v0, %hi(D_8013EAA8)
    /* DC788 800EBF88 2C00C28C */  lw         $v0, 0x2C($a2)
    /* DC78C 800EBF8C E8AF0308 */  j          .L800EBFA0
    /* DC790 800EBF90 2C0082AC */   sw        $v0, 0x2C($a0)
  .L800EBF94:
    /* DC794 800EBF94 2C00C38C */  lw         $v1, 0x2C($a2)
    /* DC798 800EBF98 00000000 */  nop
    /* DC79C 800EBF9C A8EA43AC */  sw         $v1, %lo(D_8013EAA8)($v0)
  .L800EBFA0:
    /* DC7A0 800EBFA0 1480023C */  lui        $v0, %hi(D_8013EAA8)
    /* DC7A4 800EBFA4 A8EA428C */  lw         $v0, %lo(D_8013EAA8)($v0)
    /* DC7A8 800EBFA8 21200000 */  addu       $a0, $zero, $zero
    /* DC7AC 800EBFAC 0E004010 */  beqz       $v0, .L800EBFE8
    /* DC7B0 800EBFB0 2C00C2AC */   sw        $v0, 0x2C($a2)
    /* DC7B4 800EBFB4 1000C58C */  lw         $a1, 0x10($a2)
  .L800EBFB8:
    /* DC7B8 800EBFB8 2C00C38C */  lw         $v1, 0x2C($a2)
    /* DC7BC 800EBFBC 00000000 */  nop
    /* DC7C0 800EBFC0 1000628C */  lw         $v0, 0x10($v1)
    /* DC7C4 800EBFC4 00000000 */  nop
    /* DC7C8 800EBFC8 2A10A200 */  slt        $v0, $a1, $v0
    /* DC7CC 800EBFCC 06004014 */  bnez       $v0, .L800EBFE8
    /* DC7D0 800EBFD0 00000000 */   nop
    /* DC7D4 800EBFD4 21206000 */  addu       $a0, $v1, $zero
    /* DC7D8 800EBFD8 2C00628C */  lw         $v0, 0x2C($v1)
    /* DC7DC 800EBFDC 00000000 */  nop
    /* DC7E0 800EBFE0 F5FF4014 */  bnez       $v0, .L800EBFB8
    /* DC7E4 800EBFE4 2C00C2AC */   sw        $v0, 0x2C($a2)
  .L800EBFE8:
    /* DC7E8 800EBFE8 03008010 */  beqz       $a0, .L800EBFF8
    /* DC7EC 800EBFEC 1480023C */   lui       $v0, %hi(D_8013EAA8)
    /* DC7F0 800EBFF0 FFAF0308 */  j          .L800EBFFC
    /* DC7F4 800EBFF4 2C0086AC */   sw        $a2, 0x2C($a0)
  .L800EBFF8:
    /* DC7F8 800EBFF8 A8EA46AC */  sw         $a2, %lo(D_8013EAA8)($v0)
  .L800EBFFC:
    /* DC7FC 800EBFFC 00608940 */  mtc0       $t1, $12 /* handwritten instruction */
    /* DC800 800EC000 0800E003 */  jr         $ra
    /* DC804 800EC004 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel FILE_priorityop
