.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MakeWayForMemoryCard__Fv, 0x24

glabel MakeWayForMemoryCard__Fv
    /* 24BF0 800343F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24BF4 800343F4 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 24BF8 800343F8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24BFC 800343FC 12AC030C */  jal        deltimer
    /* 24C00 80034400 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 24C04 80034404 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24C08 80034408 00000000 */  nop
    /* 24C0C 8003440C 0800E003 */  jr         $ra
    /* 24C10 80034410 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MakeWayForMemoryCard__Fv
