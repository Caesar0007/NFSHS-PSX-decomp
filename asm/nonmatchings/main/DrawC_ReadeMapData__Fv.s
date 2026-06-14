.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_ReadeMapData__Fv, 0x20

glabel DrawC_ReadeMapData__Fv
    /* AF0F8 800BE8F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AF0FC 800BE8FC 1000BFAF */  sw         $ra, 0x10($sp)
    /* AF100 800BE900 6CB9020C */  jal        R3DCcar_ReadeMapData__Fv
    /* AF104 800BE904 00000000 */   nop
    /* AF108 800BE908 1000BF8F */  lw         $ra, 0x10($sp)
    /* AF10C 800BE90C 00000000 */  nop
    /* AF110 800BE910 0800E003 */  jr         $ra
    /* AF114 800BE914 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawC_ReadeMapData__Fv
