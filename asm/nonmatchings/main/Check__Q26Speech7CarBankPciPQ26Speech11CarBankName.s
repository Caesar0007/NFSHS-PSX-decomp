.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Check__Q26Speech7CarBankPciPQ26Speech11CarBankName, 0x108

glabel Check__Q26Speech7CarBankPciPQ26Speech11CarBankName
    /* 84C1C 8009441C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 84C20 80094420 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 84C24 80094424 21988000 */  addu       $s3, $a0, $zero
    /* 84C28 80094428 1800B2AF */  sw         $s2, 0x18($sp)
    /* 84C2C 8009442C 2190A000 */  addu       $s2, $a1, $zero
    /* 84C30 80094430 2000B4AF */  sw         $s4, 0x20($sp)
    /* 84C34 80094434 21A0C000 */  addu       $s4, $a2, $zero
    /* 84C38 80094438 1400B1AF */  sw         $s1, 0x14($sp)
    /* 84C3C 8009443C 2188E000 */  addu       $s1, $a3, $zero
    /* 84C40 80094440 1000B0AF */  sw         $s0, 0x10($sp)
    /* 84C44 80094444 21800000 */  addu       $s0, $zero, $zero
    /* 84C48 80094448 2400BFAF */  sw         $ra, 0x24($sp)
    /* 84C4C 8009444C 0000248E */  lw         $a0, 0x0($s1)
    /* 84C50 80094450 00000000 */  nop
    /* 84C54 80094454 08008010 */  beqz       $a0, .L80094478
    /* 84C58 80094458 21100002 */   addu      $v0, $s0, $zero
    /* 84C5C 8009445C DDA7030C */  jal        strlen
    /* 84C60 80094460 00000000 */   nop
    /* 84C64 80094464 21204002 */  addu       $a0, $s2, $zero
    /* 84C68 80094468 0000258E */  lw         $a1, 0x0($s1)
    /* 84C6C 8009446C 74AC030C */  jal        strncmp
    /* 84C70 80094470 21304000 */   addu      $a2, $v0, $zero
    /* 84C74 80094474 0100422C */  sltiu      $v0, $v0, 0x1
  .L80094478:
    /* 84C78 80094478 03004010 */  beqz       $v0, .L80094488
    /* 84C7C 8009447C 00000000 */   nop
    /* 84C80 80094480 000074AE */  sw         $s4, 0x0($s3)
    /* 84C84 80094484 01001024 */  addiu      $s0, $zero, 0x1
  .L80094488:
    /* 84C88 80094488 0400248E */  lw         $a0, 0x4($s1)
    /* 84C8C 8009448C 00000000 */  nop
    /* 84C90 80094490 08008010 */  beqz       $a0, .L800944B4
    /* 84C94 80094494 21100000 */   addu      $v0, $zero, $zero
    /* 84C98 80094498 DDA7030C */  jal        strlen
    /* 84C9C 8009449C 00000000 */   nop
    /* 84CA0 800944A0 21204002 */  addu       $a0, $s2, $zero
    /* 84CA4 800944A4 0400258E */  lw         $a1, 0x4($s1)
    /* 84CA8 800944A8 74AC030C */  jal        strncmp
    /* 84CAC 800944AC 21304000 */   addu      $a2, $v0, $zero
    /* 84CB0 800944B0 0100422C */  sltiu      $v0, $v0, 0x1
  .L800944B4:
    /* 84CB4 800944B4 03004010 */  beqz       $v0, .L800944C4
    /* 84CB8 800944B8 00000000 */   nop
    /* 84CBC 800944BC 040074AE */  sw         $s4, 0x4($s3)
    /* 84CC0 800944C0 01001024 */  addiu      $s0, $zero, 0x1
  .L800944C4:
    /* 84CC4 800944C4 0800248E */  lw         $a0, 0x8($s1)
    /* 84CC8 800944C8 00000000 */  nop
    /* 84CCC 800944CC 08008010 */  beqz       $a0, .L800944F0
    /* 84CD0 800944D0 21100000 */   addu      $v0, $zero, $zero
    /* 84CD4 800944D4 DDA7030C */  jal        strlen
    /* 84CD8 800944D8 00000000 */   nop
    /* 84CDC 800944DC 21204002 */  addu       $a0, $s2, $zero
    /* 84CE0 800944E0 0800258E */  lw         $a1, 0x8($s1)
    /* 84CE4 800944E4 74AC030C */  jal        strncmp
    /* 84CE8 800944E8 21304000 */   addu      $a2, $v0, $zero
    /* 84CEC 800944EC 0100422C */  sltiu      $v0, $v0, 0x1
  .L800944F0:
    /* 84CF0 800944F0 04004010 */  beqz       $v0, .L80094504
    /* 84CF4 800944F4 21100002 */   addu      $v0, $s0, $zero
    /* 84CF8 800944F8 080074AE */  sw         $s4, 0x8($s3)
    /* 84CFC 800944FC 01001024 */  addiu      $s0, $zero, 0x1
    /* 84D00 80094500 21100002 */  addu       $v0, $s0, $zero
  .L80094504:
    /* 84D04 80094504 2400BF8F */  lw         $ra, 0x24($sp)
    /* 84D08 80094508 2000B48F */  lw         $s4, 0x20($sp)
    /* 84D0C 8009450C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 84D10 80094510 1800B28F */  lw         $s2, 0x18($sp)
    /* 84D14 80094514 1400B18F */  lw         $s1, 0x14($sp)
    /* 84D18 80094518 1000B08F */  lw         $s0, 0x10($sp)
    /* 84D1C 8009451C 0800E003 */  jr         $ra
    /* 84D20 80094520 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Check__Q26Speech7CarBankPciPQ26Speech11CarBankName
