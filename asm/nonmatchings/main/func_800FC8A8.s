.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_800FC8A8, 0x10C

glabel func_800FC8A8
    /* ED0A8 800FC8A8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ED0AC 800FC8AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED0B0 800FC8B0 2180C000 */  addu       $s0, $a2, $zero
    /* ED0B4 800FC8B4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* ED0B8 800FC8B8 1800B2AF */  sw         $s2, 0x18($sp)
    /* ED0BC 800FC8BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* ED0C0 800FC8C0 5000128E */  lw         $s2, 0x50($s0)
    /* ED0C4 800FC8C4 00000000 */  nop
    /* ED0C8 800FC8C8 1000438E */  lw         $v1, 0x10($s2)
    /* ED0CC 800FC8CC 01000224 */  addiu      $v0, $zero, 0x1
    /* ED0D0 800FC8D0 08006214 */  bne        $v1, $v0, .L800FC8F4
    /* ED0D4 800FC8D4 00000000 */   nop
    /* ED0D8 800FC8D8 A800058E */  lw         $a1, 0xA8($s0)
    /* ED0DC 800FC8DC A000038E */  lw         $v1, 0xA0($s0)
    /* ED0E0 800FC8E0 5800428E */  lw         $v0, 0x58($s2)
    /* ED0E4 800FC8E4 21886500 */  addu       $s1, $v1, $a1
    /* ED0E8 800FC8E8 2A102202 */  slt        $v0, $s1, $v0
    /* ED0EC 800FC8EC 43F20308 */  j          .L800FC90C
    /* ED0F0 800FC8F0 01005138 */   xori      $s1, $v0, 0x1
  .L800FC8F4:
    /* ED0F4 800FC8F4 A400048E */  lw         $a0, 0xA4($s0)
    /* ED0F8 800FC8F8 ACB0030C */  jal        FILE_completeop
    /* ED0FC 800FC8FC 00000000 */   nop
    /* ED100 800FC900 A800038E */  lw         $v1, 0xA8($s0)
    /* ED104 800FC904 21284000 */  addu       $a1, $v0, $zero
    /* ED108 800FC908 2A884300 */  slt        $s1, $v0, $v1
  .L800FC90C:
    /* ED10C 800FC90C 21200002 */  addu       $a0, $s0, $zero
    /* ED110 800FC910 A000028E */  lw         $v0, 0xA0($s0)
    /* ED114 800FC914 4800038E */  lw         $v1, 0x48($s0)
    /* ED118 800FC918 21104500 */  addu       $v0, $v0, $a1
    /* ED11C 800FC91C 21186500 */  addu       $v1, $v1, $a1
    /* ED120 800FC920 A00002AE */  sw         $v0, 0xA0($s0)
    /* ED124 800FC924 8DF1030C */  jal        func_800FC634
    /* ED128 800FC928 480003AE */   sw        $v1, 0x48($s0)
    /* ED12C 800FC92C 21204000 */  addu       $a0, $v0, $zero
    /* ED130 800FC930 0400438E */  lw         $v1, 0x4($s2)
    /* ED134 800FC934 04000224 */  addiu      $v0, $zero, 0x4
    /* ED138 800FC938 10006210 */  beq        $v1, $v0, .L800FC97C
    /* ED13C 800FC93C 00000000 */   nop
    /* ED140 800FC940 03002016 */  bnez       $s1, .L800FC950
    /* ED144 800FC944 00000000 */   nop
    /* ED148 800FC948 11008010 */  beqz       $a0, .L800FC990
    /* ED14C 800FC94C 00000000 */   nop
  .L800FC950:
    /* ED150 800FC950 00600340 */  mfc0       $v1, $12 /* handwritten instruction */
    /* ED154 800FC954 00000000 */  nop
    /* ED158 800FC958 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ED15C 800FC95C 24406100 */  and        $t0, $v1, $at
    /* ED160 800FC960 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ED164 800FC964 00000000 */  nop
    /* ED168 800FC968 00000000 */  nop
    /* ED16C 800FC96C 00000000 */  nop
    /* ED170 800FC970 03000224 */  addiu      $v0, $zero, 0x3
    /* ED174 800FC974 040042AE */  sw         $v0, 0x4($s2)
    /* ED178 800FC978 00608340 */  mtc0       $v1, $12 /* handwritten instruction */
  .L800FC97C:
    /* ED17C 800FC97C 3000058E */  lw         $a1, 0x30($s0)
    /* ED180 800FC980 6DF2030C */  jal        func_800FC9B4
    /* ED184 800FC984 21200002 */   addu      $a0, $s0, $zero
    /* ED188 800FC988 67F20308 */  j          .L800FC99C
    /* ED18C 800FC98C 00000000 */   nop
  .L800FC990:
    /* ED190 800FC990 3000058E */  lw         $a1, 0x30($s0)
    /* ED194 800FC994 D1F2030C */  jal        func_800FCB44
    /* ED198 800FC998 21200002 */   addu      $a0, $s0, $zero
  .L800FC99C:
    /* ED19C 800FC99C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* ED1A0 800FC9A0 1800B28F */  lw         $s2, 0x18($sp)
    /* ED1A4 800FC9A4 1400B18F */  lw         $s1, 0x14($sp)
    /* ED1A8 800FC9A8 1000B08F */  lw         $s0, 0x10($sp)
    /* ED1AC 800FC9AC 0800E003 */  jr         $ra
    /* ED1B0 800FC9B0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800FC8A8
