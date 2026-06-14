.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __floatsidf, 0x100

glabel __floatsidf
    /* DBFE4 800EB7E4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* DBFE8 800EB7E8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* DBFEC 800EB7EC 21980000 */  addu       $s3, $zero, $zero
    /* DBFF0 800EB7F0 2800B2AF */  sw         $s2, 0x28($sp)
    /* DBFF4 800EB7F4 1D041224 */  addiu      $s2, $zero, 0x41D
    /* DBFF8 800EB7F8 3000BFAF */  sw         $ra, 0x30($sp)
    /* DBFFC 800EB7FC 2400B1AF */  sw         $s1, 0x24($sp)
    /* DC000 800EB800 04008014 */  bnez       $a0, .L800EB814
    /* DC004 800EB804 2000B0AF */   sw        $s0, 0x20($sp)
    /* DC008 800EB808 21800000 */  addu       $s0, $zero, $zero
    /* DC00C 800EB80C 30AE0308 */  j          .L800EB8C0
    /* DC010 800EB810 21880000 */   addu      $s1, $zero, $zero
  .L800EB814:
    /* DC014 800EB814 03008104 */  bgez       $a0, .L800EB824
    /* DC018 800EB818 FF00023C */   lui       $v0, (0xFFFFFF >> 16)
    /* DC01C 800EB81C 0080133C */  lui        $s3, (0x80000000 >> 16)
    /* DC020 800EB820 23200400 */  negu       $a0, $a0
  .L800EB824:
    /* DC024 800EB824 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* DC028 800EB828 2A104400 */  slt        $v0, $v0, $a0
    /* DC02C 800EB82C 08004014 */  bnez       $v0, .L800EB850
    /* DC030 800EB830 FF3F023C */   lui       $v0, (0x3FFFFFFF >> 16)
    /* DC034 800EB834 FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* DC038 800EB838 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
  .L800EB83C:
    /* DC03C 800EB83C 00210400 */  sll        $a0, $a0, 4
    /* DC040 800EB840 2A106400 */  slt        $v0, $v1, $a0
    /* DC044 800EB844 FDFF4010 */  beqz       $v0, .L800EB83C
    /* DC048 800EB848 FCFF5226 */   addiu     $s2, $s2, -0x4
    /* DC04C 800EB84C FF3F023C */  lui        $v0, (0x3FFFFFFF >> 16)
  .L800EB850:
    /* DC050 800EB850 FFFF4234 */  ori        $v0, $v0, (0x3FFFFFFF & 0xFFFF)
    /* DC054 800EB854 2A104400 */  slt        $v0, $v0, $a0
    /* DC058 800EB858 08004014 */  bnez       $v0, .L800EB87C
    /* DC05C 800EB85C 0A000224 */   addiu     $v0, $zero, 0xA
    /* DC060 800EB860 FF3F033C */  lui        $v1, (0x3FFFFFFF >> 16)
    /* DC064 800EB864 FFFF6334 */  ori        $v1, $v1, (0x3FFFFFFF & 0xFFFF)
  .L800EB868:
    /* DC068 800EB868 40200400 */  sll        $a0, $a0, 1
    /* DC06C 800EB86C 2A106400 */  slt        $v0, $v1, $a0
    /* DC070 800EB870 FDFF4010 */  beqz       $v0, .L800EB868
    /* DC074 800EB874 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* DC078 800EB878 0A000224 */  addiu      $v0, $zero, 0xA
  .L800EB87C:
    /* DC07C 800EB87C 1C00A4AF */  sw         $a0, 0x1C($sp)
    /* DC080 800EB880 1800A427 */  addiu      $a0, $sp, 0x18
    /* DC084 800EB884 1800A0AF */  sw         $zero, 0x18($sp)
    /* DC088 800EB888 1000A2AF */  sw         $v0, 0x10($sp)
    /* DC08C 800EB88C 1800A68F */  lw         $a2, 0x18($sp)
    /* DC090 800EB890 1C00A78F */  lw         $a3, 0x1C($sp)
    /* DC094 800EB894 3A12040C */  jal        _dbl_shift_us
    /* DC098 800EB898 01000524 */   addiu     $a1, $zero, 0x1
    /* DC09C 800EB89C EFFF023C */  lui        $v0, (0xFFEFFFFF >> 16)
    /* DC0A0 800EB8A0 1C00A38F */  lw         $v1, 0x1C($sp)
    /* DC0A4 800EB8A4 FFFF4234 */  ori        $v0, $v0, (0xFFEFFFFF & 0xFFFF)
    /* DC0A8 800EB8A8 24186200 */  and        $v1, $v1, $v0
    /* DC0AC 800EB8AC 25887300 */  or         $s1, $v1, $s3
    /* DC0B0 800EB8B0 00151200 */  sll        $v0, $s2, 20
    /* DC0B4 800EB8B4 25882202 */  or         $s1, $s1, $v0
    /* DC0B8 800EB8B8 1800B08F */  lw         $s0, 0x18($sp)
    /* DC0BC 800EB8BC 1C00A3AF */  sw         $v1, 0x1C($sp)
  .L800EB8C0:
    /* DC0C0 800EB8C0 21100002 */  addu       $v0, $s0, $zero
    /* DC0C4 800EB8C4 21182002 */  addu       $v1, $s1, $zero
    /* DC0C8 800EB8C8 3000BF8F */  lw         $ra, 0x30($sp)
    /* DC0CC 800EB8CC 2C00B38F */  lw         $s3, 0x2C($sp)
    /* DC0D0 800EB8D0 2800B28F */  lw         $s2, 0x28($sp)
    /* DC0D4 800EB8D4 2400B18F */  lw         $s1, 0x24($sp)
    /* DC0D8 800EB8D8 2000B08F */  lw         $s0, 0x20($sp)
    /* DC0DC 800EB8DC 0800E003 */  jr         $ra
    /* DC0E0 800EB8E0 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel __floatsidf
