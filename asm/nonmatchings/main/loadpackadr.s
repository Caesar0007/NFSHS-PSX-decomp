.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadpackadr, 0x20

glabel loadpackadr
    /* D655C 800E5D5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D6560 800E5D60 1000BFAF */  sw         $ra, 0x10($sp)
    /* D6564 800E5D64 1997030C */  jal        loadpackadrz
    /* D6568 800E5D68 00000000 */   nop
    /* D656C 800E5D6C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D6570 800E5D70 00000000 */  nop
    /* D6574 800E5D74 0800E003 */  jr         $ra
    /* D6578 800E5D78 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel loadpackadr
