.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCTout, 0x20

glabel DecDCTout
    /* E9278 800F8A78 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E927C 800F8A7C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E9280 800F8A80 1EE3030C */  jal        _MDEC_out_dma
    /* E9284 800F8A84 00000000 */   nop
    /* E9288 800F8A88 1000BF8F */  lw         $ra, 0x10($sp)
    /* E928C 800F8A8C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E9290 800F8A90 0800E003 */  jr         $ra
    /* E9294 800F8A94 00000000 */   nop
endlabel DecDCTout
