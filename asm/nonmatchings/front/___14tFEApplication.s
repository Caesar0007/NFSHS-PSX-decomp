.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tFEApplication, 0x70

glabel ___14tFEApplication
    /* 39C4 800131C4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 39C8 800131C8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 39CC 800131CC 21888000 */  addu       $s1, $a0, $zero
    /* 39D0 800131D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 39D4 800131D4 2180A000 */  addu       $s0, $a1, $zero
    /* 39D8 800131D8 D0022426 */  addiu      $a0, $s1, 0x2D0
    /* 39DC 800131DC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 39E0 800131E0 1E98000C */  jal        ___7tScreen
    /* 39E4 800131E4 02000524 */   addiu     $a1, $zero, 0x2
    /* 39E8 800131E8 38022426 */  addiu      $a0, $s1, 0x238
    /* 39EC 800131EC 1E98000C */  jal        ___7tScreen
    /* 39F0 800131F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 39F4 800131F4 58012426 */  addiu      $a0, $s1, 0x158
    /* 39F8 800131F8 1E98000C */  jal        ___7tScreen
    /* 39FC 800131FC 02000524 */   addiu     $a1, $zero, 0x2
    /* 3A00 80013200 2C002426 */  addiu      $a0, $s1, 0x2C
    /* 3A04 80013204 1E98000C */  jal        ___7tScreen
    /* 3A08 80013208 02000524 */   addiu     $a1, $zero, 0x2
    /* 3A0C 8001320C 01001032 */  andi       $s0, $s0, 0x1
    /* 3A10 80013210 03000012 */  beqz       $s0, .L80013220
    /* 3A14 80013214 00000000 */   nop
    /* 3A18 80013218 6B8F020C */  jal        __builtin_delete
    /* 3A1C 8001321C 21202002 */   addu      $a0, $s1, $zero
  .L80013220:
    /* 3A20 80013220 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3A24 80013224 1400B18F */  lw         $s1, 0x14($sp)
    /* 3A28 80013228 1000B08F */  lw         $s0, 0x10($sp)
    /* 3A2C 8001322C 0800E003 */  jr         $ra
    /* 3A30 80013230 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___14tFEApplication
