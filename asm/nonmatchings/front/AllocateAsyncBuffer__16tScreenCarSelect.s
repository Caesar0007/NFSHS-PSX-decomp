.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AllocateAsyncBuffer__16tScreenCarSelect, 0x34

glabel AllocateAsyncBuffer__16tScreenCarSelect
    /* 2C474 8003BC74 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2C478 8003BC78 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2C47C 8003BC7C 21808000 */  addu       $s0, $a0, $zero
    /* 2C480 8003BC80 0180053C */  lui        $a1, %hi(D_80011AE0)
    /* 2C484 8003BC84 409C0434 */  ori        $a0, $zero, 0x9C40
    /* 2C488 8003BC88 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2C48C 8003BC8C 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 2C490 8003BC90 E01AA524 */   addiu     $a1, $a1, %lo(D_80011AE0)
    /* 2C494 8003BC94 300002AE */  sw         $v0, 0x30($s0)
    /* 2C498 8003BC98 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2C49C 8003BC9C 1000B08F */  lw         $s0, 0x10($sp)
    /* 2C4A0 8003BCA0 0800E003 */  jr         $ra
    /* 2C4A4 8003BCA4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AllocateAsyncBuffer__16tScreenCarSelect
