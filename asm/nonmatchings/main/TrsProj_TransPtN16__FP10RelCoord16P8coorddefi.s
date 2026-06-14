.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching TrsProj_TransPtN16__FP10RelCoord16P8coorddefi, 0x88

glabel TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
    /* D2458 800E1C58 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D245C 800E1C5C 2138A000 */  addu       $a3, $a1, $zero
    /* D2460 800E1C60 1D00C010 */  beqz       $a2, .L800E1CD8
    /* D2464 800E1C64 FFFFC324 */   addiu     $v1, $a2, -0x1
    /* D2468 800E1C68 0800A627 */  addiu      $a2, $sp, 0x8
    /* D246C 800E1C6C FFFF0824 */  addiu      $t0, $zero, -0x1
    /* D2470 800E1C70 0800A524 */  addiu      $a1, $a1, 0x8
  .L800E1C74:
    /* D2474 800E1C74 00008294 */  lhu        $v0, 0x0($a0)
    /* D2478 800E1C78 0200A0A7 */  sh         $zero, 0x2($sp)
    /* D247C 800E1C7C 0000A2A7 */  sh         $v0, 0x0($sp)
    /* D2480 800E1C80 02008294 */  lhu        $v0, 0x2($a0)
    /* D2484 800E1C84 00000000 */  nop
    /* D2488 800E1C88 0400A2A7 */  sh         $v0, 0x4($sp)
    /* D248C 800E1C8C 0000A0CB */  lwc2       $0, 0x0($sp)
    /* D2490 800E1C90 0400A1CB */  lwc2       $1, 0x4($sp)
    /* D2494 800E1C94 00000000 */  nop
    /* D2498 800E1C98 00000000 */  nop
    /* D249C 800E1C9C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D24A0 800E1CA0 0000D9E8 */  swc2       $25, 0x0($a2)
    /* D24A4 800E1CA4 0400DAE8 */  swc2       $26, 0x4($a2) /* handwritten instruction */
    /* D24A8 800E1CA8 0800DBE8 */  swc2       $27, 0x8($a2) /* handwritten instruction */
    /* D24AC 800E1CAC 0800A28F */  lw         $v0, 0x8($sp)
    /* D24B0 800E1CB0 04008424 */  addiu      $a0, $a0, 0x4
    /* D24B4 800E1CB4 0000E2AC */  sw         $v0, 0x0($a3)
    /* D24B8 800E1CB8 0C00A28F */  lw         $v0, 0xC($sp)
    /* D24BC 800E1CBC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* D24C0 800E1CC0 FCFFA2AC */  sw         $v0, -0x4($a1)
    /* D24C4 800E1CC4 1000A28F */  lw         $v0, 0x10($sp)
    /* D24C8 800E1CC8 0C00E724 */  addiu      $a3, $a3, 0xC
    /* D24CC 800E1CCC 0000A2AC */  sw         $v0, 0x0($a1)
    /* D24D0 800E1CD0 E8FF6814 */  bne        $v1, $t0, .L800E1C74
    /* D24D4 800E1CD4 0C00A524 */   addiu     $a1, $a1, 0xC
  .L800E1CD8:
    /* D24D8 800E1CD8 0800E003 */  jr         $ra
    /* D24DC 800E1CDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
