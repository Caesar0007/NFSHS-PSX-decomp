.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransformVector, 0xE4

glabel TransformVector
    /* 2B0F0 8003A8F0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 2B0F4 8003A8F4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 2B0F8 8003A8F8 21A08000 */  addu       $s4, $a0, $zero
    /* 2B0FC 8003A8FC 2400B5AF */  sw         $s5, 0x24($sp)
    /* 2B100 8003A900 21A8A000 */  addu       $s5, $a1, $zero
    /* 2B104 8003A904 2800B6AF */  sw         $s6, 0x28($sp)
    /* 2B108 8003A908 21B0C000 */  addu       $s6, $a2, $zero
    /* 2B10C 8003A90C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 2B110 8003A910 21980000 */  addu       $s3, $zero, $zero
    /* 2B114 8003A914 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 2B118 8003A918 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2B11C 8003A91C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2B120 8003A920 1000B0AF */  sw         $s0, 0x10($sp)
  .L8003A924:
    /* 2B124 8003A924 00141300 */  sll        $v0, $s3, 16
    /* 2B128 8003A928 83130200 */  sra        $v0, $v0, 14
    /* 2B12C 8003A92C 21185600 */  addu       $v1, $v0, $s6
    /* 2B130 8003A930 000060AC */  sw         $zero, 0x0($v1)
    /* 2B134 8003A934 21800000 */  addu       $s0, $zero, $zero
    /* 2B138 8003A938 21904000 */  addu       $s2, $v0, $zero
    /* 2B13C 8003A93C 21886000 */  addu       $s1, $v1, $zero
  .L8003A940:
    /* 2B140 8003A940 00141000 */  sll        $v0, $s0, 16
    /* 2B144 8003A944 03140200 */  sra        $v0, $v0, 16
    /* 2B148 8003A948 80180200 */  sll        $v1, $v0, 2
    /* 2B14C 8003A94C 21187400 */  addu       $v1, $v1, $s4
    /* 2B150 8003A950 00110200 */  sll        $v0, $v0, 4
    /* 2B154 8003A954 21105500 */  addu       $v0, $v0, $s5
    /* 2B158 8003A958 21104202 */  addu       $v0, $s2, $v0
    /* 2B15C 8003A95C 0000648C */  lw         $a0, 0x0($v1)
    /* 2B160 8003A960 0000458C */  lw         $a1, 0x0($v0)
    /* 2B164 8003A964 CA90030C */  jal        fixedmult
    /* 2B168 8003A968 00000000 */   nop
    /* 2B16C 8003A96C 01000326 */  addiu      $v1, $s0, 0x1
    /* 2B170 8003A970 21806000 */  addu       $s0, $v1, $zero
    /* 2B174 8003A974 001C0300 */  sll        $v1, $v1, 16
    /* 2B178 8003A978 031C0300 */  sra        $v1, $v1, 16
    /* 2B17C 8003A97C 0000248E */  lw         $a0, 0x0($s1)
    /* 2B180 8003A980 04006328 */  slti       $v1, $v1, 0x4
    /* 2B184 8003A984 21208200 */  addu       $a0, $a0, $v0
    /* 2B188 8003A988 EDFF6014 */  bnez       $v1, .L8003A940
    /* 2B18C 8003A98C 000024AE */   sw        $a0, 0x0($s1)
    /* 2B190 8003A990 01006226 */  addiu      $v0, $s3, 0x1
    /* 2B194 8003A994 21984000 */  addu       $s3, $v0, $zero
    /* 2B198 8003A998 00140200 */  sll        $v0, $v0, 16
    /* 2B19C 8003A99C 03140200 */  sra        $v0, $v0, 16
    /* 2B1A0 8003A9A0 04004228 */  slti       $v0, $v0, 0x4
    /* 2B1A4 8003A9A4 DFFF4014 */  bnez       $v0, .L8003A924
    /* 2B1A8 8003A9A8 00000000 */   nop
    /* 2B1AC 8003A9AC 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 2B1B0 8003A9B0 2800B68F */  lw         $s6, 0x28($sp)
    /* 2B1B4 8003A9B4 2400B58F */  lw         $s5, 0x24($sp)
    /* 2B1B8 8003A9B8 2000B48F */  lw         $s4, 0x20($sp)
    /* 2B1BC 8003A9BC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 2B1C0 8003A9C0 1800B28F */  lw         $s2, 0x18($sp)
    /* 2B1C4 8003A9C4 1400B18F */  lw         $s1, 0x14($sp)
    /* 2B1C8 8003A9C8 1000B08F */  lw         $s0, 0x10($sp)
    /* 2B1CC 8003A9CC 0800E003 */  jr         $ra
    /* 2B1D0 8003A9D0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel TransformVector
