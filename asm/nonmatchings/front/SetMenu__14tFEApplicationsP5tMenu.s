.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetMenu__14tFEApplicationsP5tMenu, 0x104

glabel SetMenu__14tFEApplicationsP5tMenu
    /* 4620 80013E20 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4624 80013E24 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4628 80013E28 21888000 */  addu       $s1, $a0, $zero
    /* 462C 80013E2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4630 80013E30 2180C000 */  addu       $s0, $a2, $zero
    /* 4634 80013E34 00140500 */  sll        $v0, $a1, 16
    /* 4638 80013E38 031C0200 */  sra        $v1, $v0, 16
    /* 463C 80013E3C 80100300 */  sll        $v0, $v1, 2
    /* 4640 80013E40 21102202 */  addu       $v0, $s1, $v0
    /* 4644 80013E44 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4648 80013E48 1800B2AF */  sw         $s2, 0x18($sp)
    /* 464C 80013E4C 0400428C */  lw         $v0, 0x4($v0)
    /* 4650 80013E50 00000000 */  nop
    /* 4654 80013E54 2D000212 */  beq        $s0, $v0, .L80013F0C
    /* 4658 80013E58 2190A000 */   addu      $s2, $a1, $zero
    /* 465C 80013E5C 08006014 */  bnez       $v1, .L80013E80
    /* 4660 80013E60 00000000 */   nop
    /* 4664 80013E64 0000028E */  lw         $v0, 0x0($s0)
    /* 4668 80013E68 0000238E */  lw         $v1, 0x0($s1)
    /* 466C 80013E6C 00F04230 */  andi       $v0, $v0, 0xF000
    /* 4670 80013E70 03004310 */  beq        $v0, $v1, .L80013E80
    /* 4674 80013E74 00000000 */   nop
    /* 4678 80013E78 584F000C */  jal        UpdateMusic__14tFEApplication
    /* 467C 80013E7C 000022AE */   sw        $v0, 0x0($s1)
  .L80013E80:
    /* 4680 80013E80 6800028E */  lw         $v0, 0x68($s0)
    /* 4684 80013E84 00000000 */  nop
    /* 4688 80013E88 40004484 */  lh         $a0, 0x40($v0)
    /* 468C 80013E8C 4400428C */  lw         $v0, 0x44($v0)
    /* 4690 80013E90 00000000 */  nop
    /* 4694 80013E94 09F84000 */  jalr       $v0
    /* 4698 80013E98 21200402 */   addu      $a0, $s0, $a0
    /* 469C 80013E9C 01004238 */  xori       $v0, $v0, 0x1
    /* 46A0 80013EA0 12004010 */  beqz       $v0, .L80013EEC
    /* 46A4 80013EA4 00141200 */   sll       $v0, $s2, 16
    /* 46A8 80013EA8 83130200 */  sra        $v0, $v0, 14
    /* 46AC 80013EAC 21102202 */  addu       $v0, $s1, $v0
    /* 46B0 80013EB0 0400438C */  lw         $v1, 0x4($v0)
    /* 46B4 80013EB4 00000000 */  nop
    /* 46B8 80013EB8 0F006010 */  beqz       $v1, .L80013EF8
    /* 46BC 80013EBC 140050AC */   sw        $s0, 0x14($v0)
    /* 46C0 80013EC0 0D000012 */  beqz       $s0, .L80013EF8
    /* 46C4 80013EC4 00000000 */   nop
    /* 46C8 80013EC8 6800628C */  lw         $v0, 0x68($v1)
    /* 46CC 80013ECC 00000000 */  nop
    /* 46D0 80013ED0 28004484 */  lh         $a0, 0x28($v0)
    /* 46D4 80013ED4 2C00428C */  lw         $v0, 0x2C($v0)
    /* 46D8 80013ED8 00000000 */  nop
    /* 46DC 80013EDC 09F84000 */  jalr       $v0
    /* 46E0 80013EE0 21206400 */   addu      $a0, $v1, $a0
    /* 46E4 80013EE4 BF4F0008 */  j          .L80013EFC
    /* 46E8 80013EE8 21202002 */   addu      $a0, $s1, $zero
  .L80013EEC:
    /* 46EC 80013EEC 83130200 */  sra        $v0, $v0, 14
    /* 46F0 80013EF0 21102202 */  addu       $v0, $s1, $v0
    /* 46F4 80013EF4 140050AC */  sw         $s0, 0x14($v0)
  .L80013EF8:
    /* 46F8 80013EF8 21202002 */  addu       $a0, $s1, $zero
  .L80013EFC:
    /* 46FC 80013EFC 002C1200 */  sll        $a1, $s2, 16
    /* 4700 80013F00 5000068E */  lw         $a2, 0x50($s0)
    /* 4704 80013F04 C94F000C */  jal        SetScreen__14tFEApplicationsP7tScreen
    /* 4708 80013F08 032C0500 */   sra       $a1, $a1, 16
  .L80013F0C:
    /* 470C 80013F0C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4710 80013F10 1800B28F */  lw         $s2, 0x18($sp)
    /* 4714 80013F14 1400B18F */  lw         $s1, 0x14($sp)
    /* 4718 80013F18 1000B08F */  lw         $s0, 0x10($sp)
    /* 471C 80013F1C 0800E003 */  jr         $ra
    /* 4720 80013F20 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetMenu__14tFEApplicationsP5tMenu
