.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_getopts, 0xBC

glabel SNDSYS_getopts
    /* E2558 800F1D58 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E255C 800F1D5C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E2560 800F1D60 21888000 */  addu       $s1, $a0, $zero
    /* E2564 800F1D64 1000B0AF */  sw         $s0, 0x10($sp)
    /* E2568 800F1D68 1380103C */  lui        $s0, %hi(D_80134A68)
    /* E256C 800F1D6C 684A028E */  lw         $v0, %lo(D_80134A68)($s0)
    /* E2570 800F1D70 21280000 */  addu       $a1, $zero, $zero
    /* E2574 800F1D74 06004014 */  bnez       $v0, .L800F1D90
    /* E2578 800F1D78 1800BFAF */   sw        $ra, 0x18($sp)
    /* E257C 800F1D7C 6AFD030C */  jal        iSNDplatformoutputcaps
    /* E2580 800F1D80 00000000 */   nop
    /* E2584 800F1D84 21284000 */  addu       $a1, $v0, $zero
    /* E2588 800F1D88 01000224 */  addiu      $v0, $zero, 0x1
    /* E258C 800F1D8C 684A02AE */  sw         $v0, %lo(D_80134A68)($s0)
  .L800F1D90:
    /* E2590 800F1D90 1480023C */  lui        $v0, %hi(sndgs)
    /* E2594 800F1D94 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* E2598 800F1D98 0C006294 */  lhu        $v0, 0xC($v1)
    /* E259C 800F1D9C 00000000 */  nop
    /* E25A0 800F1DA0 02004014 */  bnez       $v0, .L800F1DAC
    /* E25A4 800F1DA4 10000224 */   addiu     $v0, $zero, 0x10
    /* E25A8 800F1DA8 0C0062A4 */  sh         $v0, 0xC($v1)
  .L800F1DAC:
    /* E25AC 800F1DAC 21202002 */  addu       $a0, $s1, $zero
    /* E25B0 800F1DB0 21106000 */  addu       $v0, $v1, $zero
    /* E25B4 800F1DB4 30004324 */  addiu      $v1, $v0, 0x30
  .L800F1DB8:
    /* E25B8 800F1DB8 0000468C */  lw         $a2, 0x0($v0)
    /* E25BC 800F1DBC 0400478C */  lw         $a3, 0x4($v0)
    /* E25C0 800F1DC0 0800488C */  lw         $t0, 0x8($v0)
    /* E25C4 800F1DC4 0C00498C */  lw         $t1, 0xC($v0)
    /* E25C8 800F1DC8 000086AC */  sw         $a2, 0x0($a0)
    /* E25CC 800F1DCC 040087AC */  sw         $a3, 0x4($a0)
    /* E25D0 800F1DD0 080088AC */  sw         $t0, 0x8($a0)
    /* E25D4 800F1DD4 0C0089AC */  sw         $t1, 0xC($a0)
    /* E25D8 800F1DD8 10004224 */  addiu      $v0, $v0, 0x10
    /* E25DC 800F1DDC F6FF4314 */  bne        $v0, $v1, .L800F1DB8
    /* E25E0 800F1DE0 10008424 */   addiu     $a0, $a0, 0x10
    /* E25E4 800F1DE4 0000468C */  lw         $a2, 0x0($v0)
    /* E25E8 800F1DE8 0400478C */  lw         $a3, 0x4($v0)
    /* E25EC 800F1DEC 0800488C */  lw         $t0, 0x8($v0)
    /* E25F0 800F1DF0 000086AC */  sw         $a2, 0x0($a0)
    /* E25F4 800F1DF4 040087AC */  sw         $a3, 0x4($a0)
    /* E25F8 800F1DF8 080088AC */  sw         $t0, 0x8($a0)
    /* E25FC 800F1DFC 1800BF8F */  lw         $ra, 0x18($sp)
    /* E2600 800F1E00 1400B18F */  lw         $s1, 0x14($sp)
    /* E2604 800F1E04 1000B08F */  lw         $s0, 0x10($sp)
    /* E2608 800F1E08 2110A000 */  addu       $v0, $a1, $zero
    /* E260C 800F1E0C 0800E003 */  jr         $ra
    /* E2610 800F1E10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSYS_getopts
