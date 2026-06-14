.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FntFlush, 0x31C

glabel FntFlush
    /* E7518 800F6D18 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* E751C 800F6D1C 80000624 */  addiu      $a2, $zero, 0x80
    /* E7520 800F6D20 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* E7524 800F6D24 2000A6AF */  sw         $a2, 0x20($sp)
    /* E7528 800F6D28 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* E752C 800F6D2C 4800BEAF */  sw         $fp, 0x48($sp)
    /* E7530 800F6D30 4400B7AF */  sw         $s7, 0x44($sp)
    /* E7534 800F6D34 4000B6AF */  sw         $s6, 0x40($sp)
    /* E7538 800F6D38 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* E753C 800F6D3C 3800B4AF */  sw         $s4, 0x38($sp)
    /* E7540 800F6D40 3400B3AF */  sw         $s3, 0x34($sp)
    /* E7544 800F6D44 3000B2AF */  sw         $s2, 0x30($sp)
    /* E7548 800F6D48 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* E754C 800F6D4C 2800B0AF */  sw         $s0, 0x28($sp)
    /* E7550 800F6D50 1400A0AF */  sw         $zero, 0x14($sp)
    /* E7554 800F6D54 07008004 */  bltz       $a0, .L800F6D74
    /* E7558 800F6D58 2400A6AF */   sw        $a2, 0x24($sp)
    /* E755C 800F6D5C 1380023C */  lui        $v0, %hi(D_80135FD8)
    /* E7560 800F6D60 D85F428C */  lw         $v0, %lo(D_80135FD8)($v0)
    /* E7564 800F6D64 00000000 */  nop
    /* E7568 800F6D68 2A108200 */  slt        $v0, $a0, $v0
    /* E756C 800F6D6C 0F004014 */  bnez       $v0, .L800F6DAC
    /* E7570 800F6D70 40100400 */   sll       $v0, $a0, 1
  .L800F6D74:
    /* E7574 800F6D74 1380043C */  lui        $a0, %hi(D_80135FDC)
    /* E7578 800F6D78 DC5F848C */  lw         $a0, %lo(D_80135FDC)($a0)
    /* E757C 800F6D7C 00000000 */  nop
    /* E7580 800F6D80 40100400 */  sll        $v0, $a0, 1
    /* E7584 800F6D84 21104400 */  addu       $v0, $v0, $a0
    /* E7588 800F6D88 00110200 */  sll        $v0, $v0, 4
    /* E758C 800F6D8C 1380013C */  lui        $at, %hi(D_80135E7C)
    /* E7590 800F6D90 21082200 */  addu       $at, $at, $v0
    /* E7594 800F6D94 7C5E228C */  lw         $v0, %lo(D_80135E7C)($at)
    /* E7598 800F6D98 00000000 */  nop
    /* E759C 800F6D9C 03004014 */  bnez       $v0, .L800F6DAC
    /* E75A0 800F6DA0 40100400 */   sll       $v0, $a0, 1
    /* E75A4 800F6DA4 01DC0308 */  j          .L800F7004
    /* E75A8 800F6DA8 21100000 */   addu      $v0, $zero, $zero
  .L800F6DAC:
    /* E75AC 800F6DAC 21104400 */  addu       $v0, $v0, $a0
    /* E75B0 800F6DB0 00110200 */  sll        $v0, $v0, 4
    /* E75B4 800F6DB4 1380033C */  lui        $v1, %hi(Font)
    /* E75B8 800F6DB8 585E6324 */  addiu      $v1, $v1, %lo(Font)
    /* E75BC 800F6DBC 21984300 */  addu       $s3, $v0, $v1
    /* E75C0 800F6DC0 10006626 */  addiu      $a2, $s3, 0x10
    /* E75C4 800F6DC4 1000A6AF */  sw         $a2, 0x10($sp)
    /* E75C8 800F6DC8 1000A48F */  lw         $a0, 0x10($sp)
    /* E75CC 800F6DCC 2400708E */  lw         $s0, 0x24($s3)
    /* E75D0 800F6DD0 1C007E8E */  lw         $fp, 0x1C($s3)
    /* E75D4 800F6DD4 08007186 */  lh         $s1, 0x8($s3)
    /* E75D8 800F6DD8 0A007586 */  lh         $s5, 0xA($s3)
    /* E75DC 800F6DDC 0C006286 */  lh         $v0, 0xC($s3)
    /* E75E0 800F6DE0 0E006386 */  lh         $v1, 0xE($s3)
    /* E75E4 800F6DE4 00000000 */  nop
    /* E75E8 800F6DE8 2118A302 */  addu       $v1, $s5, $v1
    /* E75EC 800F6DEC 1800A3AF */  sw         $v1, 0x18($sp)
    /* E75F0 800F6DF0 2000728E */  lw         $s2, 0x20($s3)
    /* E75F4 800F6DF4 2C00768E */  lw         $s6, 0x2C($s3)
    /* E75F8 800F6DF8 081C040C */  jal        TermPrim
    /* E75FC 800F6DFC 21B82202 */   addu      $s7, $s1, $v0
    /* E7600 800F6E00 E5DB0308 */  j          .L800F6F94
    /* E7604 800F6E04 00000000 */   nop
  .L800F6E08:
    /* E7608 800F6E08 6600C013 */  beqz       $fp, .L800F6FA4
    /* E760C 800F6E0C 00160300 */   sll       $v0, $v1, 24
    /* E7610 800F6E10 031E0200 */  sra        $v1, $v0, 24
    /* E7614 800F6E14 20000224 */  addiu      $v0, $zero, 0x20
    /* E7618 800F6E18 47006210 */  beq        $v1, $v0, .L800F6F38
    /* E761C 800F6E1C 21A00000 */   addu      $s4, $zero, $zero
    /* E7620 800F6E20 21006228 */  slti       $v0, $v1, 0x21
    /* E7624 800F6E24 07004010 */  beqz       $v0, .L800F6E44
    /* E7628 800F6E28 09000224 */   addiu     $v0, $zero, 0x9
    /* E762C 800F6E2C 1D006210 */  beq        $v1, $v0, .L800F6EA4
    /* E7630 800F6E30 0A000224 */   addiu     $v0, $zero, 0xA
    /* E7634 800F6E34 46006210 */  beq        $v1, $v0, .L800F6F50
    /* E7638 800F6E38 00000000 */   nop
    /* E763C 800F6E3C ABDB0308 */  j          .L800F6EAC
    /* E7640 800F6E40 00000000 */   nop
  .L800F6E44:
    /* E7644 800F6E44 7E000224 */  addiu      $v0, $zero, 0x7E
    /* E7648 800F6E48 18006214 */  bne        $v1, $v0, .L800F6EAC
    /* E764C 800F6E4C 63000224 */   addiu     $v0, $zero, 0x63
    /* E7650 800F6E50 01001026 */  addiu      $s0, $s0, 0x1
    /* E7654 800F6E54 00000382 */  lb         $v1, 0x0($s0)
    /* E7658 800F6E58 00000000 */  nop
    /* E765C 800F6E5C 3D006214 */  bne        $v1, $v0, .L800F6F54
    /* E7660 800F6E60 00000000 */   nop
    /* E7664 800F6E64 01001026 */  addiu      $s0, $s0, 0x1
    /* E7668 800F6E68 00000282 */  lb         $v0, 0x0($s0)
    /* E766C 800F6E6C 01001026 */  addiu      $s0, $s0, 0x1
    /* E7670 800F6E70 00000382 */  lb         $v1, 0x0($s0)
    /* E7674 800F6E74 01001026 */  addiu      $s0, $s0, 0x1
    /* E7678 800F6E78 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* E767C 800F6E7C 00110200 */  sll        $v0, $v0, 4
    /* E7680 800F6E80 D0FF6324 */  addiu      $v1, $v1, -0x30
    /* E7684 800F6E84 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E7688 800F6E88 00000282 */  lb         $v0, 0x0($s0)
    /* E768C 800F6E8C 00190300 */  sll        $v1, $v1, 4
    /* E7690 800F6E90 2000A3AF */  sw         $v1, 0x20($sp)
    /* E7694 800F6E94 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* E7698 800F6E98 00110200 */  sll        $v0, $v0, 4
    /* E769C 800F6E9C D5DB0308 */  j          .L800F6F54
    /* E76A0 800F6EA0 2400A2AF */   sw        $v0, 0x24($sp)
  .L800F6EA4:
    /* E76A4 800F6EA4 CFDB0308 */  j          .L800F6F3C
    /* E76A8 800F6EA8 20003126 */   addiu     $s1, $s1, 0x20
  .L800F6EAC:
    /* E76AC 800F6EAC 00000392 */  lbu        $v1, 0x0($s0)
    /* E76B0 800F6EB0 00000000 */  nop
    /* E76B4 800F6EB4 9FFF6224 */  addiu      $v0, $v1, -0x61
    /* E76B8 800F6EB8 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* E76BC 800F6EBC 04004010 */  beqz       $v0, .L800F6ED0
    /* E76C0 800F6EC0 00160300 */   sll       $v0, $v1, 24
    /* E76C4 800F6EC4 03160200 */  sra        $v0, $v0, 24
    /* E76C8 800F6EC8 B6DB0308 */  j          .L800F6ED8
    /* E76CC 800F6ECC C0FF4324 */   addiu     $v1, $v0, -0x40
  .L800F6ED0:
    /* E76D0 800F6ED0 03160200 */  sra        $v0, $v0, 24
    /* E76D4 800F6ED4 E0FF4324 */  addiu      $v1, $v0, -0x20
  .L800F6ED8:
    /* E76D8 800F6ED8 02006104 */  bgez       $v1, .L800F6EE4
    /* E76DC 800F6EDC 21106000 */   addu      $v0, $v1, $zero
    /* E76E0 800F6EE0 0F006224 */  addiu      $v0, $v1, 0xF
  .L800F6EE4:
    /* E76E4 800F6EE4 03210200 */  sra        $a0, $v0, 4
    /* E76E8 800F6EE8 00110400 */  sll        $v0, $a0, 4
    /* E76EC 800F6EEC 23106200 */  subu       $v0, $v1, $v0
    /* E76F0 800F6EF0 C0100200 */  sll        $v0, $v0, 3
    /* E76F4 800F6EF4 0C0042A2 */  sb         $v0, 0xC($s2)
    /* E76F8 800F6EF8 C0100400 */  sll        $v0, $a0, 3
    /* E76FC 800F6EFC 0D0042A2 */  sb         $v0, 0xD($s2)
    /* E7700 800F6F00 080051A6 */  sh         $s1, 0x8($s2)
    /* E7704 800F6F04 0A0055A6 */  sh         $s5, 0xA($s2)
    /* E7708 800F6F08 1C00A693 */  lbu        $a2, 0x1C($sp)
    /* E770C 800F6F0C 21284002 */  addu       $a1, $s2, $zero
    /* E7710 800F6F10 040046A2 */  sb         $a2, 0x4($s2)
    /* E7714 800F6F14 2000A693 */  lbu        $a2, 0x20($sp)
    /* E7718 800F6F18 00000000 */  nop
    /* E771C 800F6F1C 050046A2 */  sb         $a2, 0x5($s2)
    /* E7720 800F6F20 2400A693 */  lbu        $a2, 0x24($sp)
    /* E7724 800F6F24 00000000 */  nop
    /* E7728 800F6F28 060046A2 */  sb         $a2, 0x6($s2)
    /* E772C 800F6F2C 1000A48F */  lw         $a0, 0x10($sp)
    /* E7730 800F6F30 101C040C */  jal        AddPrim
    /* E7734 800F6F34 10005226 */   addiu     $s2, $s2, 0x10
  .L800F6F38:
    /* E7738 800F6F38 08003126 */  addiu      $s1, $s1, 0x8
  .L800F6F3C:
    /* E773C 800F6F3C 2A103702 */  slt        $v0, $s1, $s7
    /* E7740 800F6F40 04004014 */  bnez       $v0, .L800F6F54
    /* E7744 800F6F44 00000000 */   nop
    /* E7748 800F6F48 0200C016 */  bnez       $s6, .L800F6F54
    /* E774C 800F6F4C 00000000 */   nop
  .L800F6F50:
    /* E7750 800F6F50 01001424 */  addiu      $s4, $zero, 0x1
  .L800F6F54:
    /* E7754 800F6F54 0D008012 */  beqz       $s4, .L800F6F8C
    /* E7758 800F6F58 00000000 */   nop
    /* E775C 800F6F5C 1400A68F */  lw         $a2, 0x14($sp)
    /* E7760 800F6F60 00000000 */  nop
    /* E7764 800F6F64 2A10D100 */  slt        $v0, $a2, $s1
    /* E7768 800F6F68 02004010 */  beqz       $v0, .L800F6F74
    /* E776C 800F6F6C 00000000 */   nop
    /* E7770 800F6F70 1400B1AF */  sw         $s1, 0x14($sp)
  .L800F6F74:
    /* E7774 800F6F74 0800B526 */  addiu      $s5, $s5, 0x8
    /* E7778 800F6F78 1800A68F */  lw         $a2, 0x18($sp)
    /* E777C 800F6F7C 08007186 */  lh         $s1, 0x8($s3)
    /* E7780 800F6F80 2A10A602 */  slt        $v0, $s5, $a2
    /* E7784 800F6F84 07004010 */  beqz       $v0, .L800F6FA4
    /* E7788 800F6F88 00000000 */   nop
  .L800F6F8C:
    /* E778C 800F6F8C 01001026 */  addiu      $s0, $s0, 0x1
    /* E7790 800F6F90 FFFFDE27 */  addiu      $fp, $fp, -0x1
  .L800F6F94:
    /* E7794 800F6F94 00000282 */  lb         $v0, 0x0($s0)
    /* E7798 800F6F98 00000392 */  lbu        $v1, 0x0($s0)
    /* E779C 800F6F9C 9AFF4014 */  bnez       $v0, .L800F6E08
    /* E77A0 800F6FA0 00000000 */   nop
  .L800F6FA4:
    /* E77A4 800F6FA4 07006292 */  lbu        $v0, 0x7($s3)
    /* E77A8 800F6FA8 00000000 */  nop
    /* E77AC 800F6FAC 0E004010 */  beqz       $v0, .L800F6FE8
    /* E77B0 800F6FB0 00000000 */   nop
    /* E77B4 800F6FB4 1000A48F */  lw         $a0, 0x10($sp)
    /* E77B8 800F6FB8 101C040C */  jal        AddPrim
    /* E77BC 800F6FBC 21286002 */   addu      $a1, $s3, $zero
    /* E77C0 800F6FC0 0900C012 */  beqz       $s6, .L800F6FE8
    /* E77C4 800F6FC4 00000000 */   nop
    /* E77C8 800F6FC8 08006296 */  lhu        $v0, 0x8($s3)
    /* E77CC 800F6FCC 1400A68F */  lw         $a2, 0x14($sp)
    /* E77D0 800F6FD0 0A006396 */  lhu        $v1, 0xA($s3)
    /* E77D4 800F6FD4 2310C200 */  subu       $v0, $a2, $v0
    /* E77D8 800F6FD8 F8FF6324 */  addiu      $v1, $v1, -0x8
    /* E77DC 800F6FDC 2318A302 */  subu       $v1, $s5, $v1
    /* E77E0 800F6FE0 0C0062A6 */  sh         $v0, 0xC($s3)
    /* E77E4 800F6FE4 0E0063A6 */  sh         $v1, 0xE($s3)
  .L800F6FE8:
    /* E77E8 800F6FE8 1000A48F */  lw         $a0, 0x10($sp)
    /* E77EC 800F6FEC 2DB7030C */  jal        DrawOTag
    /* E77F0 800F6FF0 00000000 */   nop
    /* E77F4 800F6FF4 2400638E */  lw         $v1, 0x24($s3)
    /* E77F8 800F6FF8 1000A28F */  lw         $v0, 0x10($sp)
    /* E77FC 800F6FFC 280060AE */  sw         $zero, 0x28($s3)
    /* E7800 800F7000 000060A0 */  sb         $zero, 0x0($v1)
  .L800F7004:
    /* E7804 800F7004 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* E7808 800F7008 4800BE8F */  lw         $fp, 0x48($sp)
    /* E780C 800F700C 4400B78F */  lw         $s7, 0x44($sp)
    /* E7810 800F7010 4000B68F */  lw         $s6, 0x40($sp)
    /* E7814 800F7014 3C00B58F */  lw         $s5, 0x3C($sp)
    /* E7818 800F7018 3800B48F */  lw         $s4, 0x38($sp)
    /* E781C 800F701C 3400B38F */  lw         $s3, 0x34($sp)
    /* E7820 800F7020 3000B28F */  lw         $s2, 0x30($sp)
    /* E7824 800F7024 2C00B18F */  lw         $s1, 0x2C($sp)
    /* E7828 800F7028 2800B08F */  lw         $s0, 0x28($sp)
    /* E782C 800F702C 0800E003 */  jr         $ra
    /* E7830 800F7030 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel FntFlush
