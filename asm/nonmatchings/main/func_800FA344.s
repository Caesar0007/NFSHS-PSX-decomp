.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FA344, 0x20

glabel func_800FA344
    /* EAB44 800FA344 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EAB48 800FA348 1000BFAF */  sw         $ra, 0x10($sp)
    /* EAB4C 800FA34C 74AC030C */  jal        strncmp
    /* EAB50 800FA350 0C000624 */   addiu     $a2, $zero, 0xC
    /* EAB54 800FA354 1000BF8F */  lw         $ra, 0x10($sp)
    /* EAB58 800FA358 00000000 */  nop
    /* EAB5C 800FA35C 0800E003 */  jr         $ra
    /* EAB60 800FA360 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800FA344
