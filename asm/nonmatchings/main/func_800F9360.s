.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F9360, 0x20

glabel func_800F9360
    /* E9B60 800F9360 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E9B64 800F9364 1000BFAF */  sw         $ra, 0x10($sp)
    /* E9B68 800F9368 74AC030C */  jal        strncmp
    /* E9B6C 800F936C 0C000624 */   addiu     $a2, $zero, 0xC
    /* E9B70 800F9370 1000BF8F */  lw         $ra, 0x10($sp)
    /* E9B74 800F9374 0100422C */  sltiu      $v0, $v0, 0x1
    /* E9B78 800F9378 0800E003 */  jr         $ra
    /* E9B7C 800F937C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F9360
