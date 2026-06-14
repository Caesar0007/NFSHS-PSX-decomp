.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Weather_TransformVertex__FP10matrixtdefiP7SVECTOR, 0xC4

glabel Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
    /* D3110 800E2910 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D3114 800E2914 2400B1AF */  sw         $s1, 0x24($sp)
    /* D3118 800E2918 2188A000 */  addu       $s1, $a1, $zero
    /* D311C 800E291C 2000B0AF */  sw         $s0, 0x20($sp)
    /* D3120 800E2920 2800BFAF */  sw         $ra, 0x28($sp)
    /* D3124 800E2924 7487030C */  jal        Weather_SetMatrix__FP10matrixtdef
    /* D3128 800E2928 2180C000 */   addu      $s0, $a2, $zero
    /* D312C 800E292C 000000CA */  lwc2       $0, 0x0($s0)
    /* D3130 800E2930 040001CA */  lwc2       $1, 0x4($s0)
    /* D3134 800E2934 00000000 */  nop
    /* D3138 800E2938 00000000 */  nop
    /* D313C 800E293C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D3140 800E2940 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D3144 800E2944 1000A227 */  addiu      $v0, $sp, 0x10
    /* D3148 800E2948 000059E8 */  swc2       $25, 0x0($v0)
    /* D314C 800E294C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* D3150 800E2950 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* D3154 800E2954 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* D3158 800E2958 21304000 */  addu       $a2, $v0, $zero
  .L800E295C:
    /* D315C 800E295C FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D3160 800E2960 11002712 */  beq        $s1, $a3, .L800E29A8
    /* D3164 800E2964 08000526 */   addiu     $a1, $s0, 0x8
    /* D3168 800E2968 0000A0C8 */  lwc2       $0, 0x0($a1)
    /* D316C 800E296C 0400A1C8 */  lwc2       $1, 0x4($a1)
    /* D3170 800E2970 00000000 */  nop
    /* D3174 800E2974 00000000 */  nop
    /* D3178 800E2978 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D317C 800E297C 1000A28F */  lw         $v0, 0x10($sp)
    /* D3180 800E2980 1400A38F */  lw         $v1, 0x14($sp)
    /* D3184 800E2984 1800A48F */  lw         $a0, 0x18($sp)
    /* D3188 800E2988 000002A6 */  sh         $v0, 0x0($s0)
    /* D318C 800E298C 020003A6 */  sh         $v1, 0x2($s0)
    /* D3190 800E2990 040004A6 */  sh         $a0, 0x4($s0)
    /* D3194 800E2994 0000D9E8 */  swc2       $25, 0x0($a2)
    /* D3198 800E2998 0400DAE8 */  swc2       $26, 0x4($a2) /* handwritten instruction */
    /* D319C 800E299C 0800DBE8 */  swc2       $27, 0x8($a2) /* handwritten instruction */
    /* D31A0 800E29A0 578A0308 */  j          .L800E295C
    /* D31A4 800E29A4 2180A000 */   addu      $s0, $a1, $zero
  .L800E29A8:
    /* D31A8 800E29A8 1000A28F */  lw         $v0, 0x10($sp)
    /* D31AC 800E29AC 1400A38F */  lw         $v1, 0x14($sp)
    /* D31B0 800E29B0 1800A48F */  lw         $a0, 0x18($sp)
    /* D31B4 800E29B4 000002A6 */  sh         $v0, 0x0($s0)
    /* D31B8 800E29B8 020003A6 */  sh         $v1, 0x2($s0)
    /* D31BC 800E29BC 040004A6 */  sh         $a0, 0x4($s0)
    /* D31C0 800E29C0 2800BF8F */  lw         $ra, 0x28($sp)
    /* D31C4 800E29C4 2400B18F */  lw         $s1, 0x24($sp)
    /* D31C8 800E29C8 2000B08F */  lw         $s0, 0x20($sp)
    /* D31CC 800E29CC 0800E003 */  jr         $ra
    /* D31D0 800E29D0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
