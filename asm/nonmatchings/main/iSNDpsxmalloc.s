.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxmalloc, 0x1FC

glabel iSNDpsxmalloc
    /* FADCC 8010A5CC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FADD0 8010A5D0 2000B2AF */  sw         $s2, 0x20($sp)
    /* FADD4 8010A5D4 21908000 */  addu       $s2, $a0, $zero
    /* FADD8 8010A5D8 1480023C */  lui        $v0, %hi(sndpd)
    /* FADDC 8010A5DC 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* FADE0 8010A5E0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* FADE4 8010A5E4 2800B4AF */  sw         $s4, 0x28($sp)
    /* FADE8 8010A5E8 2400B3AF */  sw         $s3, 0x24($sp)
    /* FADEC 8010A5EC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* FADF0 8010A5F0 1800B0AF */  sw         $s0, 0x18($sp)
    /* FADF4 8010A5F4 18056494 */  lhu        $a0, 0x518($v1)
    /* FADF8 8010A5F8 00000000 */  nop
    /* FADFC 8010A5FC 8000822C */  sltiu      $v0, $a0, 0x80
    /* FAE00 8010A600 13004010 */  beqz       $v0, .L8010A650
    /* FAE04 8010A604 21800000 */   addu      $s0, $zero, $zero
    /* FAE08 8010A608 3F005226 */  addiu      $s2, $s2, 0x3F
    /* FAE0C 8010A60C 12008014 */  bnez       $a0, .L8010A658
    /* FAE10 8010A610 83911200 */   sra       $s2, $s2, 6
    /* FAE14 8010A614 1000A427 */  addiu      $a0, $sp, 0x10
    /* FAE18 8010A618 1400A527 */  addiu      $a1, $sp, 0x14
    /* FAE1C 8010A61C 1A056694 */  lhu        $a2, 0x51A($v1)
    /* FAE20 8010A620 1C056294 */  lhu        $v0, 0x51C($v1)
    /* FAE24 8010A624 2118C000 */  addu       $v1, $a2, $zero
    /* FAE28 8010A628 23104300 */  subu       $v0, $v0, $v1
    /* FAE2C 8010A62C 1000A6AF */  sw         $a2, 0x10($sp)
    /* FAE30 8010A630 1400A2AF */  sw         $v0, 0x14($sp)
  .L8010A634:
    /* FAE34 8010A634 5429040C */  jal        iSNDpsxmemconstrain
    /* FAE38 8010A638 00000000 */   nop
    /* FAE3C 8010A63C 1400A28F */  lw         $v0, 0x14($sp)
    /* FAE40 8010A640 00000000 */  nop
    /* FAE44 8010A644 2A105200 */  slt        $v0, $v0, $s2
    /* FAE48 8010A648 4B004010 */  beqz       $v0, .L8010A778
    /* FAE4C 8010A64C 80181000 */   sll       $v1, $s0, 2
  .L8010A650:
    /* FAE50 8010A650 EA290408 */  j          .L8010A7A8
    /* FAE54 8010A654 21100000 */   addu      $v0, $zero, $zero
  .L8010A658:
    /* FAE58 8010A658 18056294 */  lhu        $v0, 0x518($v1)
    /* FAE5C 8010A65C 00000000 */  nop
    /* FAE60 8010A660 2A100202 */  slt        $v0, $s0, $v0
    /* FAE64 8010A664 36004010 */  beqz       $v0, .L8010A740
    /* FAE68 8010A668 20057424 */   addiu     $s4, $v1, 0x520
    /* FAE6C 8010A66C 21886000 */  addu       $s1, $v1, $zero
    /* FAE70 8010A670 1C053326 */  addiu      $s3, $s1, 0x51C
    /* FAE74 8010A674 80101000 */  sll        $v0, $s0, 2
  .L8010A678:
    /* FAE78 8010A678 08000016 */  bnez       $s0, .L8010A69C
    /* FAE7C 8010A67C 21285400 */   addu      $a1, $v0, $s4
    /* FAE80 8010A680 1A052396 */  lhu        $v1, 0x51A($s1)
    /* FAE84 8010A684 0000A294 */  lhu        $v0, 0x0($a1)
    /* FAE88 8010A688 00000000 */  nop
    /* FAE8C 8010A68C 23104300 */  subu       $v0, $v0, $v1
    /* FAE90 8010A690 1000A3AF */  sw         $v1, 0x10($sp)
    /* FAE94 8010A694 AF290408 */  j          .L8010A6BC
    /* FAE98 8010A698 1400A2AF */   sw        $v0, 0x14($sp)
  .L8010A69C:
    /* FAE9C 8010A69C 21305300 */  addu       $a2, $v0, $s3
    /* FAEA0 8010A6A0 0000C294 */  lhu        $v0, 0x0($a2)
    /* FAEA4 8010A6A4 0200C494 */  lhu        $a0, 0x2($a2)
    /* FAEA8 8010A6A8 0000A394 */  lhu        $v1, 0x0($a1)
    /* FAEAC 8010A6AC 21104400 */  addu       $v0, $v0, $a0
    /* FAEB0 8010A6B0 23186200 */  subu       $v1, $v1, $v0
    /* FAEB4 8010A6B4 1000A2AF */  sw         $v0, 0x10($sp)
    /* FAEB8 8010A6B8 1400A3AF */  sw         $v1, 0x14($sp)
  .L8010A6BC:
    /* FAEBC 8010A6BC 1000A427 */  addiu      $a0, $sp, 0x10
    /* FAEC0 8010A6C0 5429040C */  jal        iSNDpsxmemconstrain
    /* FAEC4 8010A6C4 1400A527 */   addiu     $a1, $sp, 0x14
    /* FAEC8 8010A6C8 1400A28F */  lw         $v0, 0x14($sp)
    /* FAECC 8010A6CC 00000000 */  nop
    /* FAED0 8010A6D0 2A105200 */  slt        $v0, $v0, $s2
    /* FAED4 8010A6D4 15004014 */  bnez       $v0, .L8010A72C
    /* FAED8 8010A6D8 00000000 */   nop
    /* FAEDC 8010A6DC 18052496 */  lhu        $a0, 0x518($s1)
    /* FAEE0 8010A6E0 00000000 */  nop
    /* FAEE4 8010A6E4 2A100402 */  slt        $v0, $s0, $a0
    /* FAEE8 8010A6E8 23004010 */  beqz       $v0, .L8010A778
    /* FAEEC 8010A6EC 80181000 */   sll       $v1, $s0, 2
    /* FAEF0 8010A6F0 80180400 */  sll        $v1, $a0, 2
  .L8010A6F4:
    /* FAEF4 8010A6F4 21187100 */  addu       $v1, $v1, $s1
    /* FAEF8 8010A6F8 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* FAEFC 8010A6FC 80100400 */  sll        $v0, $a0, 2
    /* FAF00 8010A700 21105100 */  addu       $v0, $v0, $s1
    /* FAF04 8010A704 23054788 */  lwl        $a3, 0x523($v0)
    /* FAF08 8010A708 20054798 */  lwr        $a3, 0x520($v0)
    /* FAF0C 8010A70C 00000000 */  nop
    /* FAF10 8010A710 230567A8 */  swl        $a3, 0x523($v1)
    /* FAF14 8010A714 200567B8 */  swr        $a3, 0x520($v1)
    /* FAF18 8010A718 2A100402 */  slt        $v0, $s0, $a0
    /* FAF1C 8010A71C F5FF4014 */  bnez       $v0, .L8010A6F4
    /* FAF20 8010A720 80180400 */   sll       $v1, $a0, 2
    /* FAF24 8010A724 DE290408 */  j          .L8010A778
    /* FAF28 8010A728 80181000 */   sll       $v1, $s0, 2
  .L8010A72C:
    /* FAF2C 8010A72C 18052296 */  lhu        $v0, 0x518($s1)
    /* FAF30 8010A730 01001026 */  addiu      $s0, $s0, 0x1
    /* FAF34 8010A734 2A100202 */  slt        $v0, $s0, $v0
    /* FAF38 8010A738 CFFF4014 */  bnez       $v0, .L8010A678
    /* FAF3C 8010A73C 80101000 */   sll       $v0, $s0, 2
  .L8010A740:
    /* FAF40 8010A740 80101000 */  sll        $v0, $s0, 2
    /* FAF44 8010A744 1480033C */  lui        $v1, %hi(D_80147E34)
    /* FAF48 8010A748 347E6324 */  addiu      $v1, $v1, %lo(D_80147E34)
    /* FAF4C 8010A74C 21304300 */  addu       $a2, $v0, $v1
    /* FAF50 8010A750 1000A427 */  addiu      $a0, $sp, 0x10
    /* FAF54 8010A754 1400A527 */  addiu      $a1, $sp, 0x14
    /* FAF58 8010A758 0000C294 */  lhu        $v0, 0x0($a2)
    /* FAF5C 8010A75C 0200C694 */  lhu        $a2, 0x2($a2)
    /* FAF60 8010A760 00006394 */  lhu        $v1, 0x0($v1)
    /* FAF64 8010A764 21104600 */  addu       $v0, $v0, $a2
    /* FAF68 8010A768 23186200 */  subu       $v1, $v1, $v0
    /* FAF6C 8010A76C 1000A2AF */  sw         $v0, 0x10($sp)
    /* FAF70 8010A770 8D290408 */  j          .L8010A634
    /* FAF74 8010A774 1400A3AF */   sw        $v1, 0x14($sp)
  .L8010A778:
    /* FAF78 8010A778 1480043C */  lui        $a0, %hi(D_80147E38)
    /* FAF7C 8010A77C 387E8424 */  addiu      $a0, $a0, %lo(D_80147E38)
    /* FAF80 8010A780 21286400 */  addu       $a1, $v1, $a0
    /* FAF84 8010A784 1000A297 */  lhu        $v0, 0x10($sp)
    /* FAF88 8010A788 E0FA8424 */  addiu      $a0, $a0, -0x520
    /* FAF8C 8010A78C 0200B2A4 */  sh         $s2, 0x2($a1)
    /* FAF90 8010A790 0000A2A4 */  sh         $v0, 0x0($a1)
    /* FAF94 8010A794 1000A28F */  lw         $v0, 0x10($sp)
    /* FAF98 8010A798 18058394 */  lhu        $v1, 0x518($a0)
    /* FAF9C 8010A79C 80110200 */  sll        $v0, $v0, 6
    /* FAFA0 8010A7A0 01006324 */  addiu      $v1, $v1, 0x1
    /* FAFA4 8010A7A4 180583A4 */  sh         $v1, 0x518($a0)
  .L8010A7A8:
    /* FAFA8 8010A7A8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* FAFAC 8010A7AC 2800B48F */  lw         $s4, 0x28($sp)
    /* FAFB0 8010A7B0 2400B38F */  lw         $s3, 0x24($sp)
    /* FAFB4 8010A7B4 2000B28F */  lw         $s2, 0x20($sp)
    /* FAFB8 8010A7B8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* FAFBC 8010A7BC 1800B08F */  lw         $s0, 0x18($sp)
    /* FAFC0 8010A7C0 0800E003 */  jr         $ra
    /* FAFC4 8010A7C4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDpsxmalloc
