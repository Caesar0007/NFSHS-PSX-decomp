.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWAllocMem__Fl, 0x30

glabel BWAllocMem__Fl
    /* 6EBF8 8007E3F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6EBFC 8007E3FC 1480053C */  lui        $a1, %hi(D_8013C764)
    /* 6EC00 8007E400 1402828F */  lw         $v0, %gp_rel(D_8013C760)($gp)
    /* 6EC04 8007E404 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6EC08 8007E408 21104400 */  addu       $v0, $v0, $a0
    /* 6EC0C 8007E40C 140282AF */  sw         $v0, %gp_rel(D_8013C760)($gp)
    /* 6EC10 8007E410 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 6EC14 8007E414 64C7A524 */   addiu     $a1, $a1, %lo(D_8013C764)
    /* 6EC18 8007E418 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6EC1C 8007E41C 00000000 */  nop
    /* 6EC20 8007E420 0800E003 */  jr         $ra
    /* 6EC24 8007E424 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWAllocMem__Fl
