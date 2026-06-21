.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer, 0x34

glabel AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer
    /* 2F510 8003ED10 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2F514 8003ED14 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F518 8003ED18 21808000 */  addu       $s0, $a0, $zero
    /* 2F51C 8003ED1C 0180053C */  lui        $a1, %hi(D_80011AE0)
    /* 2F520 8003ED20 803E0424 */  addiu      $a0, $zero, 0x3E80
    /* 2F524 8003ED24 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2F528 8003ED28 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 2F52C 8003ED2C E01AA524 */   addiu     $a1, $a1, %lo(D_80011AE0)
    /* 2F530 8003ED30 300002AE */  sw         $v0, 0x30($s0)
    /* 2F534 8003ED34 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2F538 8003ED38 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F53C 8003ED3C 0800E003 */  jr         $ra
    /* 2F540 8003ED40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer
