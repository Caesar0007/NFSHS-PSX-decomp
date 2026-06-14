.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Speech_PurgeRAM__FPc, 0x20

glabel Speech_PurgeRAM__FPc
    /* 84B14 80094314 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 84B18 80094318 1000BFAF */  sw         $ra, 0x10($sp)
    /* 84B1C 8009431C 5095030C */  jal        purgememadr
    /* 84B20 80094320 00000000 */   nop
    /* 84B24 80094324 1000BF8F */  lw         $ra, 0x10($sp)
    /* 84B28 80094328 00000000 */  nop
    /* 84B2C 8009432C 0800E003 */  jr         $ra
    /* 84B30 80094330 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Speech_PurgeRAM__FPc
