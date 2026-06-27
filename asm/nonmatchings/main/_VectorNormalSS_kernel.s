.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching _VectorNormalSS_kernel, 0xC0

glabel _VectorNormalSS_kernel
    /* E233C 800F1B3C 00488848 */  mtc2       $t0, $9 /* handwritten instruction */
    /* E2340 800F1B40 00508948 */  mtc2       $t1, $10 /* handwritten instruction */
    /* E2344 800F1B44 00588A48 */  mtc2       $t2, $11 /* handwritten instruction */
    /* E2348 800F1B48 00000000 */  nop
    /* E234C 800F1B4C 2804A04A */  .word 0x4AA00428  /* sqr        0 */
    /* E2350 800F1B50 00C80B48 */  mfc2       $t3, $25 /* handwritten instruction */
    /* E2354 800F1B54 00D00C48 */  mfc2       $t4, $26 /* handwritten instruction */
    /* E2358 800F1B58 00D80D48 */  mfc2       $t5, $27 /* handwritten instruction */
    /* E235C 800F1B5C 20586C01 */  add        $t3, $t3, $t4 /* handwritten instruction */
    /* E2360 800F1B60 20106D01 */  add        $v0, $t3, $t5 /* handwritten instruction */
    /* E2364 800F1B64 00F08248 */  mtc2       $v0, $30 /* handwritten instruction */
    /* E2368 800F1B68 00000000 */  nop
    /* E236C 800F1B6C 00000000 */  nop
    /* E2370 800F1B70 00F80348 */  mfc2       $v1, $31 /* handwritten instruction */
    /* E2374 800F1B74 FEFF0124 */  addiu      $at, $zero, -0x2
    /* E2378 800F1B78 24186100 */  and        $v1, $v1, $at
    /* E237C 800F1B7C 1F000E24 */  addiu      $t6, $zero, 0x1F
    /* E2380 800F1B80 2270C301 */  sub        $t6, $t6, $v1 /* handwritten instruction */
    /* E2384 800F1B84 43700E00 */  sra        $t6, $t6, 1
    /* E2388 800F1B88 E8FF6B20 */  addi       $t3, $v1, -0x18 /* handwritten instruction */
    /* E238C 800F1B8C 03006005 */  bltz       $t3, .L800F1B9C
    /* E2390 800F1B90 00000000 */   nop
    /* E2394 800F1B94 04000010 */  b          .L800F1BA8
    /* E2398 800F1B98 04606201 */   sllv      $t4, $v0, $t3
  .L800F1B9C:
    /* E239C 800F1B9C 18000B24 */  addiu      $t3, $zero, 0x18
    /* E23A0 800F1BA0 22586301 */  sub        $t3, $t3, $v1 /* handwritten instruction */
    /* E23A4 800F1BA4 07606201 */  srav       $t4, $v0, $t3
  .L800F1BA8:
    /* E23A8 800F1BA8 C0FF8C21 */  addi       $t4, $t4, -0x40 /* handwritten instruction */
    /* E23AC 800F1BAC 40600C00 */  sll        $t4, $t4, 1
    /* E23B0 800F1BB0 13800D3C */  lui        $t5, %hi(D_8013485C)
    /* E23B4 800F1BB4 2168AC01 */  addu       $t5, $t5, $t4
    /* E23B8 800F1BB8 5C48AD85 */  lh         $t5, %lo(D_8013485C)($t5)
    /* E23BC 800F1BBC 00000000 */  nop
    /* E23C0 800F1BC0 00408D48 */  mtc2       $t5, $8 /* handwritten instruction */
    /* E23C4 800F1BC4 00488848 */  mtc2       $t0, $9 /* handwritten instruction */
    /* E23C8 800F1BC8 00508948 */  mtc2       $t1, $10 /* handwritten instruction */
    /* E23CC 800F1BCC 00588A48 */  mtc2       $t2, $11 /* handwritten instruction */
    /* E23D0 800F1BD0 00000000 */  nop
    /* E23D4 800F1BD4 00000000 */  nop
    /* E23D8 800F1BD8 3D00904B */  .word 0x4B90003D  /* gpf        0 */
    /* E23DC 800F1BDC 00C80848 */  mfc2       $t0, $25 /* handwritten instruction */
    /* E23E0 800F1BE0 00D00948 */  mfc2       $t1, $26 /* handwritten instruction */
    /* E23E4 800F1BE4 00D80A48 */  mfc2       $t2, $27 /* handwritten instruction */
    /* E23E8 800F1BE8 0740C801 */  srav       $t0, $t0, $t6
    /* E23EC 800F1BEC 0748C901 */  srav       $t1, $t1, $t6
    /* E23F0 800F1BF0 0750CA01 */  srav       $t2, $t2, $t6
    /* E23F4 800F1BF4 0800E003 */  jr         $ra
    /* E23F8 800F1BF8 00000000 */   nop
endlabel _VectorNormalSS_kernel
