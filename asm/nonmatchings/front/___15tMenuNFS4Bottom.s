.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tMenuNFS4Bottom, 0x28

glabel ___15tMenuNFS4Bottom
    /* BFB0 8001B7B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BFB4 8001B7B4 0180023C */  lui        $v0, %hi(_vt_15tMenuNFS4Bottom)
    /* BFB8 8001B7B8 E0064224 */  addiu      $v0, $v0, %lo(_vt_15tMenuNFS4Bottom)
    /* BFBC 8001B7BC 1000BFAF */  sw         $ra, 0x10($sp)
    /* BFC0 8001B7C0 566C000C */  jal        ___9tMenuNFS4
    /* BFC4 8001B7C4 680082AC */   sw        $v0, 0x68($a0)
    /* BFC8 8001B7C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* BFCC 8001B7CC 00000000 */  nop
    /* BFD0 8001B7D0 0800E003 */  jr         $ra
    /* BFD4 8001B7D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15tMenuNFS4Bottom
