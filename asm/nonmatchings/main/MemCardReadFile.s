.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardReadFile, 0x118

glabel MemCardReadFile
    /* EBC48 800FB448 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EBC4C 800FB44C 2000B4AF */  sw         $s4, 0x20($sp)
    /* EBC50 800FB450 21A08000 */  addu       $s4, $a0, $zero
    /* EBC54 800FB454 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EBC58 800FB458 2198A000 */  addu       $s3, $a1, $zero
    /* EBC5C 800FB45C 2400B5AF */  sw         $s5, 0x24($sp)
    /* EBC60 800FB460 21A8C000 */  addu       $s5, $a2, $zero
    /* EBC64 800FB464 1800B2AF */  sw         $s2, 0x18($sp)
    /* EBC68 800FB468 2190E000 */  addu       $s2, $a3, $zero
    /* EBC6C 800FB46C 1400B1AF */  sw         $s1, 0x14($sp)
    /* EBC70 800FB470 1480113C */  lui        $s1, %hi(D_80147518)
    /* EBC74 800FB474 18753126 */  addiu      $s1, $s1, %lo(D_80147518)
    /* EBC78 800FB478 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* EBC7C 800FB47C 2800B6AF */  sw         $s6, 0x28($sp)
    /* EBC80 800FB480 1000B0AF */  sw         $s0, 0x10($sp)
    /* EBC84 800FB484 0000228E */  lw         $v0, 0x0($s1)
    /* EBC88 800FB488 4000B68F */  lw         $s6, 0x40($sp)
    /* EBC8C 800FB48C 04004018 */  blez       $v0, .L800FB4A0
    /* EBC90 800FB490 00000000 */   nop
    /* EBC94 800FB494 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EBC98 800FB498 4BED0308 */  j          .L800FB52C
    /* EBC9C 800FB49C C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
  .L800FB4A0:
    /* EBCA0 800FB4A0 1000228E */  lw         $v0, 0x10($s1)
    /* EBCA4 800FB4A4 00000000 */  nop
    /* EBCA8 800FB4A8 04004004 */  bltz       $v0, .L800FB4BC
    /* EBCAC 800FB4AC 7F00C232 */   andi      $v0, $s6, 0x7F
    /* EBCB0 800FB4B0 0580043C */  lui        $a0, %hi(D_80057418)
    /* EBCB4 800FB4B4 4BED0308 */  j          .L800FB52C
    /* EBCB8 800FB4B8 18748424 */   addiu     $a0, $a0, %lo(D_80057418)
  .L800FB4BC:
    /* EBCBC 800FB4BC 04004010 */  beqz       $v0, .L800FB4D0
    /* EBCC0 800FB4C0 7F004232 */   andi      $v0, $s2, 0x7F
    /* EBCC4 800FB4C4 0580043C */  lui        $a0, %hi(D_80057464)
    /* EBCC8 800FB4C8 4BED0308 */  j          .L800FB52C
    /* EBCCC 800FB4CC 64748424 */   addiu     $a0, $a0, %lo(D_80057464)
  .L800FB4D0:
    /* EBCD0 800FB4D0 14004014 */  bnez       $v0, .L800FB524
    /* EBCD4 800FB4D4 21208002 */   addu      $a0, $s4, $zero
    /* EBCD8 800FB4D8 20003026 */  addiu      $s0, $s1, 0x20
    /* EBCDC 800FB4DC 7DF0030C */  jal        func_800FC1F4
    /* EBCE0 800FB4E0 21280002 */   addu      $a1, $s0, $zero
    /* EBCE4 800FB4E4 21200002 */  addu       $a0, $s0, $zero
    /* EBCE8 800FB4E8 3A9E030C */  jal        strcat
    /* EBCEC 800FB4EC 21286002 */   addu      $a1, $s3, $zero
    /* EBCF0 800FB4F0 1080043C */  lui        $a0, %hi(func_800FB560)
    /* EBCF4 800FB4F4 60B58424 */  addiu      $a0, $a0, %lo(func_800FB560)
    /* EBCF8 800FB4F8 03000224 */  addiu      $v0, $zero, 0x3
    /* EBCFC 800FB4FC 000022AE */  sw         $v0, 0x0($s1)
    /* EBD00 800FB500 040020AE */  sw         $zero, 0x4($s1)
    /* EBD04 800FB504 080020AE */  sw         $zero, 0x8($s1)
    /* EBD08 800FB508 140032AE */  sw         $s2, 0x14($s1)
    /* EBD0C 800FB50C 1C0035AE */  sw         $s5, 0x1C($s1)
    /* EBD10 800FB510 180036AE */  sw         $s6, 0x18($s1)
    /* EBD14 800FB514 0427040C */  jal        UserFuncOpen
    /* EBD18 800FB518 0C0034AE */   sw        $s4, 0xC($s1)
    /* EBD1C 800FB51C 4EED0308 */  j          .L800FB538
    /* EBD20 800FB520 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB524:
    /* EBD24 800FB524 0580043C */  lui        $a0, %hi(D_80057490)
    /* EBD28 800FB528 90748424 */  addiu      $a0, $a0, %lo(D_80057490)
  .L800FB52C:
    /* EBD2C 800FB52C 2B0A040C */  jal        printf
    /* EBD30 800FB530 00000000 */   nop
    /* EBD34 800FB534 21100000 */  addu       $v0, $zero, $zero
  .L800FB538:
    /* EBD38 800FB538 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* EBD3C 800FB53C 2800B68F */  lw         $s6, 0x28($sp)
    /* EBD40 800FB540 2400B58F */  lw         $s5, 0x24($sp)
    /* EBD44 800FB544 2000B48F */  lw         $s4, 0x20($sp)
    /* EBD48 800FB548 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EBD4C 800FB54C 1800B28F */  lw         $s2, 0x18($sp)
    /* EBD50 800FB550 1400B18F */  lw         $s1, 0x14($sp)
    /* EBD54 800FB554 1000B08F */  lw         $s0, 0x10($sp)
    /* EBD58 800FB558 0800E003 */  jr         $ra
    /* EBD5C 800FB55C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel MemCardReadFile
