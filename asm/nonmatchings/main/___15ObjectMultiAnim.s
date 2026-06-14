.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15ObjectMultiAnim, 0xB4

glabel ___15ObjectMultiAnim
    /* 974F8 800A6CF8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 974FC 800A6CFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 97500 800A6D00 21888000 */  addu       $s1, $a0, $zero
    /* 97504 800A6D04 1800B2AF */  sw         $s2, 0x18($sp)
    /* 97508 800A6D08 2190A000 */  addu       $s2, $a1, $zero
    /* 9750C 800A6D0C 0580023C */  lui        $v0, %hi(_vt_15ObjectMultiAnim)
    /* 97510 800A6D10 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 97514 800A6D14 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97518 800A6D18 2800308E */  lw         $s0, 0x28($s1)
    /* 9751C 800A6D1C B8604224 */  addiu      $v0, $v0, %lo(_vt_15ObjectMultiAnim)
    /* 97520 800A6D20 09000012 */  beqz       $s0, .L800A6D48
    /* 97524 800A6D24 000022AE */   sw        $v0, 0x0($s1)
    /* 97528 800A6D28 1000048E */  lw         $a0, 0x10($s0)
    /* 9752C 800A6D2C 00000000 */  nop
    /* 97530 800A6D30 03008010 */  beqz       $a0, .L800A6D40
    /* 97534 800A6D34 00000000 */   nop
    /* 97538 800A6D38 738F020C */  jal        __builtin_vec_delete
    /* 9753C 800A6D3C 00000000 */   nop
  .L800A6D40:
    /* 97540 800A6D40 6B8F020C */  jal        __builtin_delete
    /* 97544 800A6D44 21200002 */   addu      $a0, $s0, $zero
  .L800A6D48:
    /* 97548 800A6D48 2C00238E */  lw         $v1, 0x2C($s1)
    /* 9754C 800A6D4C 00000000 */  nop
    /* 97550 800A6D50 08006010 */  beqz       $v1, .L800A6D74
    /* 97554 800A6D54 03000524 */   addiu     $a1, $zero, 0x3
    /* 97558 800A6D58 0000628C */  lw         $v0, 0x0($v1)
    /* 9755C 800A6D5C 00000000 */  nop
    /* 97560 800A6D60 08004484 */  lh         $a0, 0x8($v0)
    /* 97564 800A6D64 0C00428C */  lw         $v0, 0xC($v0)
    /* 97568 800A6D68 00000000 */  nop
    /* 9756C 800A6D6C 09F84000 */  jalr       $v0
    /* 97570 800A6D70 21206400 */   addu      $a0, $v1, $a0
  .L800A6D74:
    /* 97574 800A6D74 0580023C */  lui        $v0, %hi(D_800560E8)
    /* 97578 800A6D78 E8604224 */  addiu      $v0, $v0, %lo(D_800560E8)
    /* 9757C 800A6D7C 000022AE */  sw         $v0, 0x0($s1)
    /* 97580 800A6D80 01004232 */  andi       $v0, $s2, 0x1
    /* 97584 800A6D84 03004010 */  beqz       $v0, .L800A6D94
    /* 97588 800A6D88 00000000 */   nop
    /* 9758C 800A6D8C 6B8F020C */  jal        __builtin_delete
    /* 97590 800A6D90 21202002 */   addu      $a0, $s1, $zero
  .L800A6D94:
    /* 97594 800A6D94 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 97598 800A6D98 1800B28F */  lw         $s2, 0x18($sp)
    /* 9759C 800A6D9C 1400B18F */  lw         $s1, 0x14($sp)
    /* 975A0 800A6DA0 1000B08F */  lw         $s0, 0x10($sp)
    /* 975A4 800A6DA4 0800E003 */  jr         $ra
    /* 975A8 800A6DA8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___15ObjectMultiAnim
