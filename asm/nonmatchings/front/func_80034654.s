.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80034654, 0x28

glabel func_80034654
    /* 24E54 80034654 0580023C */  lui        $v0, %hi(FEApp)
    /* 24E58 80034658 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 24E5C 8003465C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24E60 80034660 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24E64 80034664 CF4D000C */  jal        Redraw__14tFEApplication
    /* 24E68 80034668 00000000 */   nop
    /* 24E6C 8003466C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24E70 80034670 00000000 */  nop
    /* 24E74 80034674 0800E003 */  jr         $ra
    /* 24E78 80034678 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80034654
