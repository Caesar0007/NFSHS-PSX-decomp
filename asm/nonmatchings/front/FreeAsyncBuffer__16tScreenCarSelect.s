.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FreeAsyncBuffer__16tScreenCarSelect, 0x28

glabel FreeAsyncBuffer__16tScreenCarSelect
    /* 2C4A8 8003BCA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2C4AC 8003BCAC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2C4B0 8003BCB0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2C4B4 8003BCB4 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 2C4B8 8003BCB8 21808000 */   addu      $s0, $a0, $zero
    /* 2C4BC 8003BCBC 300000AE */  sw         $zero, 0x30($s0)
    /* 2C4C0 8003BCC0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2C4C4 8003BCC4 1000B08F */  lw         $s0, 0x10($sp)
    /* 2C4C8 8003BCC8 0800E003 */  jr         $ra
    /* 2C4CC 8003BCCC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FreeAsyncBuffer__16tScreenCarSelect
