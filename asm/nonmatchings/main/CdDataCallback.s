.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdDataCallback, 0x24

glabel CdDataCallback
    /* E84B0 800F7CB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E84B4 800F7CB4 1000BFAF */  sw         $ra, 0x10($sp)
    /* E84B8 800F7CB8 21288000 */  addu       $a1, $a0, $zero
    /* E84BC 800F7CBC 2BCA030C */  jal        DMACallback
    /* E84C0 800F7CC0 03000424 */   addiu     $a0, $zero, 0x3
    /* E84C4 800F7CC4 1000BF8F */  lw         $ra, 0x10($sp)
    /* E84C8 800F7CC8 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E84CC 800F7CCC 0800E003 */  jr         $ra
    /* E84D0 800F7CD0 00000000 */   nop
endlabel CdDataCallback
