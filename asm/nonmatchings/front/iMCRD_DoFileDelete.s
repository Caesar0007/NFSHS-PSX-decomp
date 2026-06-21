.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_DoFileDelete, 0x94

glabel iMCRD_DoFileDelete
    /* 405EC 8004FDEC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 405F0 8004FDF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 405F4 8004FDF4 21908000 */  addu       $s2, $a0, $zero
    /* 405F8 8004FDF8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 405FC 8004FDFC 11001124 */  addiu      $s1, $zero, 0x11
    /* 40600 8004FE00 0580053C */  lui        $a1, %hi(D_80052FC8)
    /* 40604 8004FE04 C82FA524 */  addiu      $a1, $a1, %lo(D_80052FC8)
    /* 40608 8004FE08 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4060C 8004FE0C A0FDB024 */  addiu      $s0, $a1, -0x260
    /* 40610 8004FE10 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 40614 8004FE14 3C00048E */  lw         $a0, 0x3C($s0)
    /* 40618 8004FE18 88EF030C */  jal        MemCardDeleteFile
    /* 4061C 8004FE1C 0400A524 */   addiu     $a1, $a1, 0x4
    /* 40620 8004FE20 21184000 */  addu       $v1, $v0, $zero
    /* 40624 8004FE24 05006010 */  beqz       $v1, .L8004FE3C
    /* 40628 8004FE28 05000224 */   addiu     $v0, $zero, 0x5
    /* 4062C 8004FE2C 06006210 */  beq        $v1, $v0, .L8004FE48
    /* 40630 8004FE30 21102002 */   addu      $v0, $s1, $zero
    /* 40634 8004FE34 9A3F0108 */  j          .L8004FE68
    /* 40638 8004FE38 00000000 */   nop
  .L8004FE3C:
    /* 4063C 8004FE3C 01000224 */  addiu      $v0, $zero, 0x1
    /* 40640 8004FE40 993F0108 */  j          .L8004FE64
    /* 40644 8004FE44 300002AE */   sw        $v0, 0x30($s0)
  .L8004FE48:
    /* 40648 8004FE48 9140010C */  jal        MCRD_getcard
    /* 4064C 8004FE4C 21204002 */   addu      $a0, $s2, $zero
    /* 40650 8004FE50 12001124 */  addiu      $s1, $zero, 0x12
    /* 40654 8004FE54 13000324 */  addiu      $v1, $zero, 0x13
    /* 40658 8004FE58 040043AC */  sw         $v1, 0x4($v0)
    /* 4065C 8004FE5C 01000224 */  addiu      $v0, $zero, 0x1
    /* 40660 8004FE60 340002AE */  sw         $v0, 0x34($s0)
  .L8004FE64:
    /* 40664 8004FE64 21102002 */  addu       $v0, $s1, $zero
  .L8004FE68:
    /* 40668 8004FE68 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4066C 8004FE6C 1800B28F */  lw         $s2, 0x18($sp)
    /* 40670 8004FE70 1400B18F */  lw         $s1, 0x14($sp)
    /* 40674 8004FE74 1000B08F */  lw         $s0, 0x10($sp)
    /* 40678 8004FE78 0800E003 */  jr         $ra
    /* 4067C 8004FE7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iMCRD_DoFileDelete
