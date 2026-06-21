.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FreeAsyncBuffer__20tScreenCarSelectDuel, 0x2C

glabel FreeAsyncBuffer__20tScreenCarSelectDuel
    /* 2D9BC 8003D1BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2D9C0 8003D1C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2D9C4 8003D1C4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2D9C8 8003D1C8 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 2D9CC 8003D1CC 21808000 */   addu      $s0, $a0, $zero
    /* 2D9D0 8003D1D0 300000AE */  sw         $zero, 0x30($s0)
    /* 2D9D4 8003D1D4 B00300AE */  sw         $zero, 0x3B0($s0)
    /* 2D9D8 8003D1D8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2D9DC 8003D1DC 1000B08F */  lw         $s0, 0x10($sp)
    /* 2D9E0 8003D1E0 0800E003 */  jr         $ra
    /* 2D9E4 8003D1E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FreeAsyncBuffer__20tScreenCarSelectDuel
