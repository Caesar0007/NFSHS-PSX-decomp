.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi, 0x9C

glabel BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
    /* 70D70 80080570 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 70D74 80080574 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70D78 80080578 21808000 */  addu       $s0, $a0, $zero
    /* 70D7C 8008057C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 70D80 80080580 2188A000 */  addu       $s1, $a1, $zero
    /* 70D84 80080584 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 70D88 80080588 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 70D8C 8008058C 1800B2AF */   sw        $s2, 0x18($sp)
    /* 70D90 80080590 7800238E */  lw         $v1, 0x78($s1)
    /* 70D94 80080594 00000000 */  nop
    /* 70D98 80080598 15006010 */  beqz       $v1, .L800805F0
    /* 70D9C 8008059C 21904000 */   addu      $s2, $v0, $zero
    /* 70DA0 800805A0 2000238E */  lw         $v1, 0x20($s1)
    /* 70DA4 800805A4 0800248E */  lw         $a0, 0x8($s1)
    /* 70DA8 800805A8 0800028E */  lw         $v0, 0x8($s0)
    /* 70DAC 800805AC 1000258E */  lw         $a1, 0x10($s1)
    /* 70DB0 800805B0 23206400 */  subu       $a0, $v1, $a0
    /* 70DB4 800805B4 CA90030C */  jal        fixedmult
    /* 70DB8 800805B8 23284500 */   subu      $a1, $v0, $a1
    /* 70DBC 800805BC 0000068E */  lw         $a2, 0x0($s0)
    /* 70DC0 800805C0 21804000 */  addu       $s0, $v0, $zero
    /* 70DC4 800805C4 0800248E */  lw         $a0, 0x8($s1)
    /* 70DC8 800805C8 2800238E */  lw         $v1, 0x28($s1)
    /* 70DCC 800805CC 1000258E */  lw         $a1, 0x10($s1)
    /* 70DD0 800805D0 2320C400 */  subu       $a0, $a2, $a0
    /* 70DD4 800805D4 CA90030C */  jal        fixedmult
    /* 70DD8 800805D8 23286500 */   subu      $a1, $v1, $a1
    /* 70DDC 800805DC 23800202 */  subu       $s0, $s0, $v0
    /* 70DE0 800805E0 0200001A */  blez       $s0, .L800805EC
    /* 70DE4 800805E4 02000224 */   addiu     $v0, $zero, 0x2
    /* 70DE8 800805E8 01000224 */  addiu      $v0, $zero, 0x1
  .L800805EC:
    /* 70DEC 800805EC 5B0022A2 */  sb         $v0, 0x5B($s1)
  .L800805F0:
    /* 70DF0 800805F0 21104002 */  addu       $v0, $s2, $zero
    /* 70DF4 800805F4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 70DF8 800805F8 1800B28F */  lw         $s2, 0x18($sp)
    /* 70DFC 800805FC 1400B18F */  lw         $s1, 0x14($sp)
    /* 70E00 80080600 1000B08F */  lw         $s0, 0x10($sp)
    /* 70E04 80080604 0800E003 */  jr         $ra
    /* 70E08 80080608 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
