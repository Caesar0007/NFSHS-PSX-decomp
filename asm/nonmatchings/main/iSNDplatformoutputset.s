.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformoutputset, 0x100

glabel iSNDplatformoutputset
    /* EFE00 800FF600 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EFE04 800FF604 1480023C */  lui        $v0, %hi(sndgs)
    /* EFE08 800FF608 60784424 */  addiu      $a0, $v0, %lo(sndgs)
    /* EFE0C 800FF60C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* EFE10 800FF610 1800B2AF */  sw         $s2, 0x18($sp)
    /* EFE14 800FF614 1400B1AF */  sw         $s1, 0x14($sp)
    /* EFE18 800FF618 1000B0AF */  sw         $s0, 0x10($sp)
    /* EFE1C 800FF61C 04008590 */  lbu        $a1, 0x4($a0)
    /* EFE20 800FF620 10008290 */  lbu        $v0, 0x10($a0)
    /* EFE24 800FF624 18000324 */  addiu      $v1, $zero, 0x18
    /* EFE28 800FF628 2B104500 */  sltu       $v0, $v0, $a1
    /* EFE2C 800FF62C 02004010 */  beqz       $v0, .L800FF638
    /* EFE30 800FF630 110083A0 */   sb        $v1, 0x11($a0)
    /* EFE34 800FF634 100085A0 */  sb         $a1, 0x10($a0)
  .L800FF638:
    /* EFE38 800FF638 05008390 */  lbu        $v1, 0x5($a0)
    /* EFE3C 800FF63C 10008290 */  lbu        $v0, 0x10($a0)
    /* EFE40 800FF640 00000000 */  nop
    /* EFE44 800FF644 2B106200 */  sltu       $v0, $v1, $v0
    /* EFE48 800FF648 02004010 */  beqz       $v0, .L800FF654
    /* EFE4C 800FF64C 00000000 */   nop
    /* EFE50 800FF650 100083A0 */  sb         $v1, 0x10($a0)
  .L800FF654:
    /* EFE54 800FF654 3C008280 */  lb         $v0, 0x3C($a0)
    /* EFE58 800FF658 00000000 */  nop
    /* EFE5C 800FF65C 1D004010 */  beqz       $v0, .L800FF6D4
    /* EFE60 800FF660 1480023C */   lui       $v0, %hi(sndpd)
    /* EFE64 800FF664 18794524 */  addiu      $a1, $v0, %lo(sndpd)
    /* EFE68 800FF668 0200A390 */  lbu        $v1, 0x2($a1)
    /* EFE6C 800FF66C 10008290 */  lbu        $v0, 0x10($a0)
    /* EFE70 800FF670 00000000 */  nop
    /* EFE74 800FF674 17006210 */  beq        $v1, $v0, .L800FF6D4
    /* EFE78 800FF678 21880000 */   addu      $s1, $zero, $zero
    /* EFE7C 800FF67C 21908000 */  addu       $s2, $a0, $zero
    /* EFE80 800FF680 D800B024 */  addiu      $s0, $a1, 0xD8
  .L800FF684:
    /* EFE84 800FF684 1C000392 */  lbu        $v1, 0x1C($s0)
    /* EFE88 800FF688 02000224 */  addiu      $v0, $zero, 0x2
    /* EFE8C 800FF68C 0C006214 */  bne        $v1, $v0, .L800FF6C0
    /* EFE90 800FF690 00000000 */   nop
    /* EFE94 800FF694 21000292 */  lbu        $v0, 0x21($s0)
    /* EFE98 800FF698 00000000 */  nop
    /* EFE9C 800FF69C 08004014 */  bnez       $v0, .L800FF6C0
    /* EFEA0 800FF6A0 21202002 */   addu      $a0, $s1, $zero
    /* EFEA4 800FF6A4 24000592 */  lbu        $a1, 0x24($s0)
    /* EFEA8 800FF6A8 25000692 */  lbu        $a2, 0x25($s0)
    /* EFEAC 800FF6AC 002E0500 */  sll        $a1, $a1, 24
    /* EFEB0 800FF6B0 00360600 */  sll        $a2, $a2, 24
    /* EFEB4 800FF6B4 032E0500 */  sra        $a1, $a1, 24
    /* EFEB8 800FF6B8 8EFC030C */  jal        iSNDsetvol
    /* EFEBC 800FF6BC 03360600 */   sra       $a2, $a2, 24
  .L800FF6C0:
    /* EFEC0 800FF6C0 11004292 */  lbu        $v0, 0x11($s2)
    /* EFEC4 800FF6C4 01003126 */  addiu      $s1, $s1, 0x1
    /* EFEC8 800FF6C8 2A102202 */  slt        $v0, $s1, $v0
    /* EFECC 800FF6CC EDFF4014 */  bnez       $v0, .L800FF684
    /* EFED0 800FF6D0 2C001026 */   addiu     $s0, $s0, 0x2C
  .L800FF6D4:
    /* EFED4 800FF6D4 1480023C */  lui        $v0, %hi(D_80147870)
    /* EFED8 800FF6D8 70784390 */  lbu        $v1, %lo(D_80147870)($v0)
    /* EFEDC 800FF6DC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* EFEE0 800FF6E0 1800B28F */  lw         $s2, 0x18($sp)
    /* EFEE4 800FF6E4 1400B18F */  lw         $s1, 0x14($sp)
    /* EFEE8 800FF6E8 1000B08F */  lw         $s0, 0x10($sp)
    /* EFEEC 800FF6EC 1480023C */  lui        $v0, %hi(D_8014791A)
    /* EFEF0 800FF6F0 1A7943A0 */  sb         $v1, %lo(D_8014791A)($v0)
    /* EFEF4 800FF6F4 21100000 */  addu       $v0, $zero, $zero
    /* EFEF8 800FF6F8 0800E003 */  jr         $ra
    /* EFEFC 800FF6FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDplatformoutputset
