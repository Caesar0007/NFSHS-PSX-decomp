.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_GetHorizonPixMap__FP12Draw_tPixMap, 0xB4

glabel Hrz_GetHorizonPixMap__FP12Draw_tPixMap
    /* C0864 800D0064 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C0868 800D0068 1400B1AF */  sw         $s1, 0x14($sp)
    /* C086C 800D006C 0B001124 */  addiu      $s1, $zero, 0xB
    /* C0870 800D0070 1280023C */  lui        $v0, %hi(gHorizonPixmap)
    /* C0874 800D0074 F8024224 */  addiu      $v0, $v0, %lo(gHorizonPixmap)
    /* C0878 800D0078 2C004224 */  addiu      $v0, $v0, 0x2C
    /* C087C 800D007C B0008424 */  addiu      $a0, $a0, 0xB0
    /* C0880 800D0080 2400BFAF */  sw         $ra, 0x24($sp)
    /* C0884 800D0084 2000B4AF */  sw         $s4, 0x20($sp)
    /* C0888 800D0088 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C088C 800D008C 1800B2AF */  sw         $s2, 0x18($sp)
    /* C0890 800D0090 1000B0AF */  sw         $s0, 0x10($sp)
  .L800D0094:
    /* C0894 800D0094 000044AC */  sw         $a0, 0x0($v0)
    /* C0898 800D0098 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* C089C 800D009C FFFF3126 */  addiu      $s1, $s1, -0x1
    /* C08A0 800D00A0 FCFF2106 */  bgez       $s1, .L800D0094
    /* C08A4 800D00A4 F0FF8424 */   addiu     $a0, $a0, -0x10
    /* C08A8 800D00A8 21880000 */  addu       $s1, $zero, $zero
    /* C08AC 800D00AC 1280023C */  lui        $v0, %hi(gHorizonPixmap)
    /* C08B0 800D00B0 F8025424 */  addiu      $s4, $v0, %lo(gHorizonPixmap)
    /* C08B4 800D00B4 30001324 */  addiu      $s3, $zero, 0x30
    /* C08B8 800D00B8 1280023C */  lui        $v0, %hi(gHorizonExtraSkyPixmaps)
    /* C08BC 800D00BC 38035024 */  addiu      $s0, $v0, %lo(gHorizonExtraSkyPixmaps)
    /* C08C0 800D00C0 20001224 */  addiu      $s2, $zero, 0x20
  .L800D00C4:
    /* C08C4 800D00C4 21105402 */  addu       $v0, $s2, $s4
    /* C08C8 800D00C8 04005226 */  addiu      $s2, $s2, 0x4
    /* C08CC 800D00CC 01003126 */  addiu      $s1, $s1, 0x1
    /* C08D0 800D00D0 21280000 */  addu       $a1, $zero, $zero
    /* C08D4 800D00D4 0000448C */  lw         $a0, 0x0($v0)
    /* C08D8 800D00D8 D680030C */  jal        Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* C08DC 800D00DC 21300002 */   addu      $a2, $s0, $zero
    /* C08E0 800D00E0 21107402 */  addu       $v0, $s3, $s4
    /* C08E4 800D00E4 04007326 */  addiu      $s3, $s3, 0x4
    /* C08E8 800D00E8 000050AC */  sw         $s0, 0x0($v0)
    /* C08EC 800D00EC 0400222A */  slti       $v0, $s1, 0x4
    /* C08F0 800D00F0 F4FF4014 */  bnez       $v0, .L800D00C4
    /* C08F4 800D00F4 10001026 */   addiu     $s0, $s0, 0x10
    /* C08F8 800D00F8 2400BF8F */  lw         $ra, 0x24($sp)
    /* C08FC 800D00FC 2000B48F */  lw         $s4, 0x20($sp)
    /* C0900 800D0100 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C0904 800D0104 1800B28F */  lw         $s2, 0x18($sp)
    /* C0908 800D0108 1400B18F */  lw         $s1, 0x14($sp)
    /* C090C 800D010C 1000B08F */  lw         $s0, 0x10($sp)
    /* C0910 800D0110 0800E003 */  jr         $ra
    /* C0914 800D0114 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hrz_GetHorizonPixMap__FP12Draw_tPixMap
