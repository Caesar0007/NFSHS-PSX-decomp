.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_Init__FP5Group, 0x38

glabel BWorldSm_Init__FP5Group
    /* 6F110 8007E910 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6F114 8007E914 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6F118 8007E918 0000838C */  lw         $v1, 0x0($a0)
    /* 6F11C 8007E91C 04008224 */  addiu      $v0, $a0, 0x4
    /* 6F120 8007E920 740282AF */  sw         $v0, %gp_rel(BWorldSm_slices)($gp)
    /* 6F124 8007E924 05000224 */  addiu      $v0, $zero, 0x5
    /* 6F128 8007E928 880282AF */  sw         $v0, %gp_rel(gMaxFindQuadSliceIterations)($gp)
    /* 6F12C 8007E92C 7C0283AF */  sw         $v1, %gp_rel(gNumSlices)($gp)
    /* 6F130 8007E930 52FA010C */  jal        BWorldSm_Restart__Fv
    /* 6F134 8007E934 00000000 */   nop
    /* 6F138 8007E938 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6F13C 8007E93C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6F140 8007E940 0800E003 */  jr         $ra
    /* 6F144 8007E944 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorldSm_Init__FP5Group
