.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __builtin_delete, 0x20

glabel __builtin_delete
    /* 945AC 800A3DAC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 945B0 800A3DB0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 945B4 800A3DB4 5095030C */  jal        purgememadr
    /* 945B8 800A3DB8 00000000 */   nop
    /* 945BC 800A3DBC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 945C0 800A3DC0 00000000 */  nop
    /* 945C4 800A3DC4 0800E003 */  jr         $ra
    /* 945C8 800A3DC8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __builtin_delete
