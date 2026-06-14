.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __builtin_vec_delete, 0x20

glabel __builtin_vec_delete
    /* 945CC 800A3DCC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 945D0 800A3DD0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 945D4 800A3DD4 5095030C */  jal        purgememadr
    /* 945D8 800A3DD8 00000000 */   nop
    /* 945DC 800A3DDC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 945E0 800A3DE0 00000000 */  nop
    /* 945E4 800A3DE4 0800E003 */  jr         $ra
    /* 945E8 800A3DE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __builtin_vec_delete
