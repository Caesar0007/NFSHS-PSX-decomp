.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80019F24, 0x20

glabel func_80019F24
    /* A724 80019F24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A728 80019F28 1000BFAF */  sw         $ra, 0x10($sp)
    /* A72C 80019F2C 1E98000C */  jal        ___7tScreen
    /* A730 80019F30 00000000 */   nop
    /* A734 80019F34 1000BF8F */  lw         $ra, 0x10($sp)
    /* A738 80019F38 00000000 */  nop
    /* A73C 80019F3C 0800E003 */  jr         $ra
    /* A740 80019F40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80019F24
