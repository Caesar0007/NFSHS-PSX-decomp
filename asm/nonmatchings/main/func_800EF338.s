.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EF338, 0x24

glabel func_800EF338
    /* DFB38 800EF338 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DFB3C 800EF33C 1000BFAF */  sw         $ra, 0x10($sp)
    /* DFB40 800EF340 2138C000 */  addu       $a3, $a2, $zero
    /* DFB44 800EF344 D7BC030C */  jal        func_800EF35C
    /* DFB48 800EF348 21300000 */   addu      $a2, $zero, $zero
    /* DFB4C 800EF34C 1000BF8F */  lw         $ra, 0x10($sp)
    /* DFB50 800EF350 1800BD27 */  addiu      $sp, $sp, 0x18
    /* DFB54 800EF354 0800E003 */  jr         $ra
    /* DFB58 800EF358 00000000 */   nop
endlabel func_800EF338
