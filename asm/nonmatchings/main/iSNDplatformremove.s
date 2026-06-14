.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformremove, 0xF0

glabel iSNDplatformremove
    /* FC158 8010B958 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* FC15C 8010B95C 2400B1AF */  sw         $s1, 0x24($sp)
    /* FC160 8010B960 2188A000 */  addu       $s1, $a1, $zero
    /* FC164 8010B964 2000B0AF */  sw         $s0, 0x20($sp)
    /* FC168 8010B968 21800000 */  addu       $s0, $zero, $zero
    /* FC16C 8010B96C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* FC170 8010B970 FE001324 */  addiu      $s3, $zero, 0xFE
    /* FC174 8010B974 2800B2AF */  sw         $s2, 0x28($sp)
    /* FC178 8010B978 8A001224 */  addiu      $s2, $zero, 0x8A
    /* FC17C 8010B97C 3000BFAF */  sw         $ra, 0x30($sp)
    /* FC180 8010B980 3800A4AF */  sw         $a0, 0x38($sp)
    /* FC184 8010B984 3800A427 */  addiu      $a0, $sp, 0x38
  .L8010B988:
    /* FC188 8010B988 1000A527 */  addiu      $a1, $sp, 0x10
  .L8010B98C:
    /* FC18C 8010B98C 1400A627 */  addiu      $a2, $sp, 0x14
    /* FC190 8010B990 542F040C */  jal        iSNDgettag
    /* FC194 8010B994 1800A727 */   addiu     $a3, $sp, 0x18
    /* FC198 8010B998 0A004010 */  beqz       $v0, .L8010B9C4
    /* FC19C 8010B99C 00000000 */   nop
    /* FC1A0 8010B9A0 1000A28F */  lw         $v0, 0x10($sp)
    /* FC1A4 8010B9A4 00000000 */  nop
    /* FC1A8 8010B9A8 06005310 */  beq        $v0, $s3, .L8010B9C4
    /* FC1AC 8010B9AC 00000000 */   nop
    /* FC1B0 8010B9B0 F5FF5214 */  bne        $v0, $s2, .L8010B988
    /* FC1B4 8010B9B4 3800A427 */   addiu     $a0, $sp, 0x38
    /* FC1B8 8010B9B8 1800B08F */  lw         $s0, 0x18($sp)
    /* FC1BC 8010B9BC 632E0408 */  j          .L8010B98C
    /* FC1C0 8010B9C0 1000A527 */   addiu     $a1, $sp, 0x10
  .L8010B9C4:
    /* FC1C4 8010B9C4 0000238E */  lw         $v1, 0x0($s1)
    /* FC1C8 8010B9C8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* FC1CC 8010B9CC 0C006210 */  beq        $v1, $v0, .L8010BA00
    /* FC1D0 8010B9D0 21200000 */   addu      $a0, $zero, $zero
    /* FC1D4 8010B9D4 0000058E */  lw         $a1, 0x0($s0)
    /* FC1D8 8010B9D8 21304000 */  addu       $a2, $v0, $zero
    /* FC1DC 8010B9DC 21182002 */  addu       $v1, $s1, $zero
    /* FC1E0 8010B9E0 0000628C */  lw         $v0, 0x0($v1)
  .L8010B9E4:
    /* FC1E4 8010B9E4 00000000 */  nop
    /* FC1E8 8010B9E8 0F004510 */  beq        $v0, $a1, .L8010BA28
    /* FC1EC 8010B9EC 08006324 */   addiu     $v1, $v1, 0x8
    /* FC1F0 8010B9F0 0000628C */  lw         $v0, 0x0($v1)
    /* FC1F4 8010B9F4 00000000 */  nop
    /* FC1F8 8010B9F8 FAFF4614 */  bne        $v0, $a2, .L8010B9E4
    /* FC1FC 8010B9FC 01008424 */   addiu     $a0, $a0, 0x1
  .L8010BA00:
    /* FC200 8010BA00 C0100400 */  sll        $v0, $a0, 3
    /* FC204 8010BA04 0000038E */  lw         $v1, 0x0($s0)
    /* FC208 8010BA08 21105100 */  addu       $v0, $v0, $s1
    /* FC20C 8010BA0C 000043AC */  sw         $v1, 0x0($v0)
    /* FC210 8010BA10 0000048E */  lw         $a0, 0x0($s0)
    /* FC214 8010BA14 00000000 */  nop
    /* FC218 8010BA18 04008010 */  beqz       $a0, .L8010BA2C
    /* FC21C 8010BA1C 21100000 */   addu      $v0, $zero, $zero
    /* FC220 8010BA20 F229040C */  jal        iSNDpsxfree
    /* FC224 8010BA24 00000000 */   nop
  .L8010BA28:
    /* FC228 8010BA28 21100000 */  addu       $v0, $zero, $zero
  .L8010BA2C:
    /* FC22C 8010BA2C 3000BF8F */  lw         $ra, 0x30($sp)
    /* FC230 8010BA30 2C00B38F */  lw         $s3, 0x2C($sp)
    /* FC234 8010BA34 2800B28F */  lw         $s2, 0x28($sp)
    /* FC238 8010BA38 2400B18F */  lw         $s1, 0x24($sp)
    /* FC23C 8010BA3C 2000B08F */  lw         $s0, 0x20($sp)
    /* FC240 8010BA40 0800E003 */  jr         $ra
    /* FC244 8010BA44 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDplatformremove
