.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_800F0C50, 0x98

glabel func_800F0C50
    /* E1450 800F0C50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1454 800F0C54 1000B0AF */  sw         $s0, 0x10($sp)
    /* E1458 800F0C58 21808000 */  addu       $s0, $a0, $zero
    /* E145C 800F0C5C 1400BFAF */  sw         $ra, 0x14($sp)
    /* E1460 800F0C60 00600440 */  mfc0       $a0, $12 /* handwritten instruction */
    /* E1464 800F0C64 00000000 */  nop
    /* E1468 800F0C68 FEFB0124 */  addiu      $at, $zero, -0x402
    /* E146C 800F0C6C 24408100 */  and        $t0, $a0, $at
    /* E1470 800F0C70 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* E1474 800F0C74 00000000 */  nop
    /* E1478 800F0C78 00000000 */  nop
    /* E147C 800F0C7C 00000000 */  nop
    /* E1480 800F0C80 0C00038E */  lw         $v1, 0xC($s0)
    /* E1484 800F0C84 01000524 */  addiu      $a1, $zero, 0x1
    /* E1488 800F0C88 02006514 */  bne        $v1, $a1, .L800F0C94
    /* E148C 800F0C8C 02000224 */   addiu     $v0, $zero, 0x2
    /* E1490 800F0C90 0C0002AE */  sw         $v0, 0xC($s0)
  .L800F0C94:
    /* E1494 800F0C94 00608440 */  mtc0       $a0, $12 /* handwritten instruction */
    /* E1498 800F0C98 0F006514 */  bne        $v1, $a1, .L800F0CD8
    /* E149C 800F0C9C 00000000 */   nop
    /* E14A0 800F0CA0 1000048E */  lw         $a0, 0x10($s0)
    /* E14A4 800F0CA4 00000000 */  nop
    /* E14A8 800F0CA8 0200822C */  sltiu      $v0, $a0, 0x2
    /* E14AC 800F0CAC 03004014 */  bnez       $v0, .L800F0CBC
    /* E14B0 800F0CB0 00000000 */   nop
    /* E14B4 800F0CB4 5095030C */  jal        purgememadr
    /* E14B8 800F0CB8 00000000 */   nop
  .L800F0CBC:
    /* E14BC 800F0CBC 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E14C0 800F0CC0 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E14C4 800F0CC4 00000292 */  lbu        $v0, 0x0($s0)
    /* E14C8 800F0CC8 21280002 */  addu       $a1, $s0, $zero
    /* E14CC 800F0CCC 180000AE */  sw         $zero, 0x18($s0)
    /* E14D0 800F0CD0 C7C2030C */  jal        func_800F0B1C
    /* E14D4 800F0CD4 000002AE */   sw        $v0, 0x0($s0)
  .L800F0CD8:
    /* E14D8 800F0CD8 1400BF8F */  lw         $ra, 0x14($sp)
    /* E14DC 800F0CDC 1000B08F */  lw         $s0, 0x10($sp)
    /* E14E0 800F0CE0 0800E003 */  jr         $ra
    /* E14E4 800F0CE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F0C50
