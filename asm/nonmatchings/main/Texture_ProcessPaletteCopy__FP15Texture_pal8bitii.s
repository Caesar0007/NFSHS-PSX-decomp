.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_ProcessPaletteCopy__FP15Texture_pal8bitii, 0xAC

glabel Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* D029C 800DFA9C B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* D02A0 800DFAA0 4400B3AF */  sw         $s3, 0x44($sp)
    /* D02A4 800DFAA4 2198C000 */  addu       $s3, $a2, $zero
    /* D02A8 800DFAA8 4800BFAF */  sw         $ra, 0x48($sp)
    /* D02AC 800DFAAC 4000B2AF */  sw         $s2, 0x40($sp)
    /* D02B0 800DFAB0 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* D02B4 800DFAB4 1D008010 */  beqz       $a0, .L800DFB2C
    /* D02B8 800DFAB8 3800B0AF */   sw        $s0, 0x38($sp)
    /* D02BC 800DFABC 2188A000 */  addu       $s1, $a1, $zero
    /* D02C0 800DFAC0 10000224 */  addiu      $v0, $zero, 0x10
    /* D02C4 800DFAC4 1400A2A7 */  sh         $v0, 0x14($sp)
    /* D02C8 800DFAC8 01000224 */  addiu      $v0, $zero, 0x1
    /* D02CC 800DFACC 1600A2A7 */  sh         $v0, 0x16($sp)
    /* D02D0 800DFAD0 2A103302 */  slt        $v0, $s1, $s3
    /* D02D4 800DFAD4 15004010 */  beqz       $v0, .L800DFB2C
    /* D02D8 800DFAD8 1800B227 */   addiu     $s2, $sp, 0x18
    /* D02DC 800DFADC 80111100 */  sll        $v0, $s1, 6
    /* D02E0 800DFAE0 21105100 */  addu       $v0, $v0, $s1
    /* D02E4 800DFAE4 C0100200 */  sll        $v0, $v0, 3
    /* D02E8 800DFAE8 21804400 */  addu       $s0, $v0, $a0
    /* D02EC 800DFAEC 08000426 */  addiu      $a0, $s0, 0x8
  .L800DFAF0:
    /* D02F0 800DFAF0 21284002 */  addu       $a1, $s2, $zero
    /* D02F4 800DFAF4 817E030C */  jal        Texture_ColorCarPalette__FPcT0i
    /* D02F8 800DFAF8 10000624 */   addiu     $a2, $zero, 0x10
    /* D02FC 800DFAFC 1000A427 */  addiu      $a0, $sp, 0x10
    /* D0300 800DFB00 21284002 */  addu       $a1, $s2, $zero
    /* D0304 800DFB04 00000296 */  lhu        $v0, 0x0($s0)
    /* D0308 800DFB08 01003126 */  addiu      $s1, $s1, 0x1
    /* D030C 800DFB0C 1000A2A7 */  sh         $v0, 0x10($sp)
    /* D0310 800DFB10 04000296 */  lhu        $v0, 0x4($s0)
    /* D0314 800DFB14 08021026 */  addiu      $s0, $s0, 0x208
    /* D0318 800DFB18 A4B6030C */  jal        LoadImage
    /* D031C 800DFB1C 1200A2A7 */   sh        $v0, 0x12($sp)
    /* D0320 800DFB20 2A103302 */  slt        $v0, $s1, $s3
    /* D0324 800DFB24 F2FF4014 */  bnez       $v0, .L800DFAF0
    /* D0328 800DFB28 08000426 */   addiu     $a0, $s0, 0x8
  .L800DFB2C:
    /* D032C 800DFB2C 4800BF8F */  lw         $ra, 0x48($sp)
    /* D0330 800DFB30 4400B38F */  lw         $s3, 0x44($sp)
    /* D0334 800DFB34 4000B28F */  lw         $s2, 0x40($sp)
    /* D0338 800DFB38 3C00B18F */  lw         $s1, 0x3C($sp)
    /* D033C 800DFB3C 3800B08F */  lw         $s0, 0x38($sp)
    /* D0340 800DFB40 0800E003 */  jr         $ra
    /* D0344 800DFB44 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
