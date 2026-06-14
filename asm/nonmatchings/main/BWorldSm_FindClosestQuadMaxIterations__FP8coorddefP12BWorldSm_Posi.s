.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi, 0x20

glabel BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi
    /* 70490 8007FC90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 70494 8007FC94 1000BFAF */  sw         $ra, 0x10($sp)
    /* 70498 8007FC98 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 7049C 8007FC9C 01000624 */   addiu     $a2, $zero, 0x1
    /* 704A0 8007FCA0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 704A4 8007FCA4 00000000 */  nop
    /* 704A8 8007FCA8 0800E003 */  jr         $ra
    /* 704AC 8007FCAC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi
