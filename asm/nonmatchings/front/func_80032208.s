.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80032208, 0x20

glabel func_80032208
    /* 22A08 80032208 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 22A0C 8003220C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 22A10 80032210 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22A14 80032214 00000000 */   nop
    /* 22A18 80032218 1000BF8F */  lw         $ra, 0x10($sp)
    /* 22A1C 8003221C 00000000 */  nop
    /* 22A20 80032220 0800E003 */  jr         $ra
    /* 22A24 80032224 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80032208
