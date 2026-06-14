.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_800FC478, 0x6C

glabel func_800FC478
    /* ECC78 800FC478 01000224 */  addiu      $v0, $zero, 0x1
    /* ECC7C 800FC47C 0400A2AC */  sw         $v0, 0x4($a1)
    /* ECC80 800FC480 0C00A0AC */  sw         $zero, 0xC($a1)
    /* ECC84 800FC484 00600340 */  mfc0       $v1, $12 /* handwritten instruction */
    /* ECC88 800FC488 00000000 */  nop
    /* ECC8C 800FC48C FEFB0124 */  addiu      $at, $zero, -0x402
    /* ECC90 800FC490 24406100 */  and        $t0, $v1, $at
    /* ECC94 800FC494 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ECC98 800FC498 00000000 */  nop
    /* ECC9C 800FC49C 00000000 */  nop
    /* ECCA0 800FC4A0 00000000 */  nop
    /* ECCA4 800FC4A4 5400828C */  lw         $v0, 0x54($a0)
    /* ECCA8 800FC4A8 00000000 */  nop
    /* ECCAC 800FC4AC 05004014 */  bnez       $v0, .L800FC4C4
    /* ECCB0 800FC4B0 00000000 */   nop
    /* ECCB4 800FC4B4 0800A0AC */  sw         $zero, 0x8($a1)
    /* ECCB8 800FC4B8 4C0085AC */  sw         $a1, 0x4C($a0)
    /* ECCBC 800FC4BC 35F10308 */  j          .L800FC4D4
    /* ECCC0 800FC4C0 500085AC */   sw        $a1, 0x50($a0)
  .L800FC4C4:
    /* ECCC4 800FC4C4 0800A2AC */  sw         $v0, 0x8($a1)
    /* ECCC8 800FC4C8 5400828C */  lw         $v0, 0x54($a0)
    /* ECCCC 800FC4CC 00000000 */  nop
    /* ECCD0 800FC4D0 0C0045AC */  sw         $a1, 0xC($v0)
  .L800FC4D4:
    /* ECCD4 800FC4D4 540085AC */  sw         $a1, 0x54($a0)
    /* ECCD8 800FC4D8 00608340 */  mtc0       $v1, $12 /* handwritten instruction */
    /* ECCDC 800FC4DC 0800E003 */  jr         $ra
    /* ECCE0 800FC4E0 00000000 */   nop
endlabel func_800FC478
