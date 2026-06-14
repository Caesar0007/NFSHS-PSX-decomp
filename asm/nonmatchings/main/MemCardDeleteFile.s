.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardDeleteFile, 0x1BC

glabel MemCardDeleteFile
    /* EC620 800FBE20 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* EC624 800FBE24 4000B2AF */  sw         $s2, 0x40($sp)
    /* EC628 800FBE28 21908000 */  addu       $s2, $a0, $zero
    /* EC62C 800FBE2C 3800B0AF */  sw         $s0, 0x38($sp)
    /* EC630 800FBE30 2180A000 */  addu       $s0, $a1, $zero
    /* EC634 800FBE34 4400B3AF */  sw         $s3, 0x44($sp)
    /* EC638 800FBE38 1480133C */  lui        $s3, %hi(D_80147518)
    /* EC63C 800FBE3C 18757326 */  addiu      $s3, $s3, %lo(D_80147518)
    /* EC640 800FBE40 4800BFAF */  sw         $ra, 0x48($sp)
    /* EC644 800FBE44 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* EC648 800FBE48 0000628E */  lw         $v0, 0x0($s3)
    /* EC64C 800FBE4C 00000000 */  nop
    /* EC650 800FBE50 06004010 */  beqz       $v0, .L800FBE6C
    /* EC654 800FBE54 21880000 */   addu      $s1, $zero, $zero
    /* EC658 800FBE58 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EC65C 800FBE5C 2B0A040C */  jal        printf
    /* EC660 800FBE60 C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
    /* EC664 800FBE64 F0EF0308 */  j          .L800FBFC0
    /* EC668 800FBE68 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800FBE6C:
    /* EC66C 800FBE6C 21204002 */  addu       $a0, $s2, $zero
    /* EC670 800FBE70 7DF0030C */  jal        func_800FC1F4
    /* EC674 800FBE74 1000A527 */   addiu     $a1, $sp, 0x10
    /* EC678 800FBE78 1000A427 */  addiu      $a0, $sp, 0x10
    /* EC67C 800FBE7C 3A9E030C */  jal        strcat
    /* EC680 800FBE80 21280002 */   addu      $a1, $s0, $zero
    /* EC684 800FBE84 21806002 */  addu       $s0, $s3, $zero
    /* EC688 800FBE88 02001324 */  addiu      $s3, $zero, 0x2
    /* EC68C 800FBE8C 01000224 */  addiu      $v0, $zero, 0x1
    /* EC690 800FBE90 0C00048E */  lw         $a0, 0xC($s0)
    /* EC694 800FBE94 1480033C */  lui        $v1, %hi(D_80147514)
    /* EC698 800FBE98 1475638C */  lw         $v1, %lo(D_80147514)($v1)
    /* EC69C 800FBE9C 04108200 */  sllv       $v0, $v0, $a0
    /* EC6A0 800FBEA0 25186200 */  or         $v1, $v1, $v0
    /* EC6A4 800FBEA4 1480013C */  lui        $at, %hi(D_80147514)
    /* EC6A8 800FBEA8 147523AC */  sw         $v1, %lo(D_80147514)($at)
  .L800FBEAC:
    /* EC6AC 800FBEAC 1C28040C */  jal        erase
    /* EC6B0 800FBEB0 1000A427 */   addiu     $a0, $sp, 0x10
    /* EC6B4 800FBEB4 41004014 */  bnez       $v0, .L800FBFBC
    /* EC6B8 800FBEB8 3000A2AF */   sw        $v0, 0x30($sp)
    /* EC6BC 800FBEBC BAEE030C */  jal        MemCardCallback
    /* EC6C0 800FBEC0 21200000 */   addu      $a0, $zero, $zero
    /* EC6C4 800FBEC4 0000038E */  lw         $v1, 0x0($s0)
    /* EC6C8 800FBEC8 1480013C */  lui        $at, %hi(D_8014756C)
    /* EC6CC 800FBECC 06006018 */  blez       $v1, .L800FBEE8
    /* EC6D0 800FBED0 6C7522AC */   sw        $v0, %lo(D_8014756C)($at)
    /* EC6D4 800FBED4 0580043C */  lui        $a0, %hi(D_80057370)
    /* EC6D8 800FBED8 2B0A040C */  jal        printf
    /* EC6DC 800FBEDC 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
    /* EC6E0 800FBEE0 C2EF0308 */  j          .L800FBF08
    /* EC6E4 800FBEE4 00000000 */   nop
  .L800FBEE8:
    /* EC6E8 800FBEE8 1080043C */  lui        $a0, %hi(func_800FAE2C)
    /* EC6EC 800FBEEC 2CAE8424 */  addiu      $a0, $a0, %lo(func_800FAE2C)
    /* EC6F0 800FBEF0 000013AE */  sw         $s3, 0x0($s0)
    /* EC6F4 800FBEF4 040000AE */  sw         $zero, 0x4($s0)
    /* EC6F8 800FBEF8 080000AE */  sw         $zero, 0x8($s0)
    /* EC6FC 800FBEFC 1480013C */  lui        $at, %hi(D_80147524)
    /* EC700 800FBF00 0427040C */  jal        UserFuncOpen
    /* EC704 800FBF04 247532AC */   sw        $s2, %lo(D_80147524)($at)
  .L800FBF08:
    /* EC708 800FBF08 0000028E */  lw         $v0, 0x0($s0)
    /* EC70C 800FBF0C 00000000 */  nop
    /* EC710 800FBF10 05004014 */  bnez       $v0, .L800FBF28
    /* EC714 800FBF14 00000000 */   nop
    /* EC718 800FBF18 0800028E */  lw         $v0, 0x8($s0)
    /* EC71C 800FBF1C 00000000 */  nop
    /* EC720 800FBF20 12004010 */  beqz       $v0, .L800FBF6C
    /* EC724 800FBF24 00000000 */   nop
  .L800FBF28:
    /* EC728 800FBF28 0000028E */  lw         $v0, 0x0($s0)
    /* EC72C 800FBF2C 0400028E */  lw         $v0, 0x4($s0)
    /* EC730 800FBF30 0800028E */  lw         $v0, 0x8($s0)
    /* EC734 800FBF34 00000000 */  nop
    /* EC738 800FBF38 07004014 */  bnez       $v0, .L800FBF58
    /* EC73C 800FBF3C 00000000 */   nop
    /* EC740 800FBF40 1480033C */  lui        $v1, %hi(D_80147520)
    /* EC744 800FBF44 20756324 */  addiu      $v1, $v1, %lo(D_80147520)
  .L800FBF48:
    /* EC748 800FBF48 0000628C */  lw         $v0, 0x0($v1)
    /* EC74C 800FBF4C 00000000 */  nop
    /* EC750 800FBF50 FDFF4010 */  beqz       $v0, .L800FBF48
    /* EC754 800FBF54 00000000 */   nop
  .L800FBF58:
    /* EC758 800FBF58 1480023C */  lui        $v0, %hi(D_80147564)
    /* EC75C 800FBF5C 64754224 */  addiu      $v0, $v0, %lo(D_80147564)
    /* EC760 800FBF60 0000428C */  lw         $v0, 0x0($v0)
    /* EC764 800FBF64 080000AE */  sw         $zero, 0x8($s0)
    /* EC768 800FBF68 3000A2AF */  sw         $v0, 0x30($sp)
  .L800FBF6C:
    /* EC76C 800FBF6C 1480043C */  lui        $a0, %hi(D_8014756C)
    /* EC770 800FBF70 6C75848C */  lw         $a0, %lo(D_8014756C)($a0)
    /* EC774 800FBF74 BAEE030C */  jal        MemCardCallback
    /* EC778 800FBF78 00000000 */   nop
    /* EC77C 800FBF7C 3000A38F */  lw         $v1, 0x30($sp)
    /* EC780 800FBF80 03000224 */  addiu      $v0, $zero, 0x3
    /* EC784 800FBF84 C9FF6210 */  beq        $v1, $v0, .L800FBEAC
    /* EC788 800FBF88 00000000 */   nop
    /* EC78C 800FBF8C 05007314 */  bne        $v1, $s3, .L800FBFA4
    /* EC790 800FBF90 00000000 */   nop
    /* EC794 800FBF94 01003126 */  addiu      $s1, $s1, 0x1
    /* EC798 800FBF98 0400222A */  slti       $v0, $s1, 0x4
    /* EC79C 800FBF9C C3FF4014 */  bnez       $v0, .L800FBEAC
    /* EC7A0 800FBFA0 00000000 */   nop
  .L800FBFA4:
    /* EC7A4 800FBFA4 02006014 */  bnez       $v1, .L800FBFB0
    /* EC7A8 800FBFA8 05000224 */   addiu     $v0, $zero, 0x5
    /* EC7AC 800FBFAC 3000A2AF */  sw         $v0, 0x30($sp)
  .L800FBFB0:
    /* EC7B0 800FBFB0 3000A28F */  lw         $v0, 0x30($sp)
    /* EC7B4 800FBFB4 F0EF0308 */  j          .L800FBFC0
    /* EC7B8 800FBFB8 00000000 */   nop
  .L800FBFBC:
    /* EC7BC 800FBFBC 21100000 */  addu       $v0, $zero, $zero
  .L800FBFC0:
    /* EC7C0 800FBFC0 4800BF8F */  lw         $ra, 0x48($sp)
    /* EC7C4 800FBFC4 4400B38F */  lw         $s3, 0x44($sp)
    /* EC7C8 800FBFC8 4000B28F */  lw         $s2, 0x40($sp)
    /* EC7CC 800FBFCC 3C00B18F */  lw         $s1, 0x3C($sp)
    /* EC7D0 800FBFD0 3800B08F */  lw         $s0, 0x38($sp)
    /* EC7D4 800FBFD4 0800E003 */  jr         $ra
    /* EC7D8 800FBFD8 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel MemCardDeleteFile
