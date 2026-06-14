.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005B468, 0x20

glabel func_8005B468
    /* 4BC68 8005B468 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4BC6C 8005B46C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4BC70 8005B470 F16C010C */  jal        ___11AIHigh_Base
    /* 4BC74 8005B474 00000000 */   nop
    /* 4BC78 8005B478 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4BC7C 8005B47C 00000000 */  nop
    /* 4BC80 8005B480 0800E003 */  jr         $ra
    /* 4BC84 8005B484 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8005B468
