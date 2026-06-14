.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iFILE_delbigclosecallback, 0x2C

glabel iFILE_delbigclosecallback
    /* DD180 800EC980 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DD184 800EC984 1000B0AF */  sw         $s0, 0x10($sp)
    /* DD188 800EC988 1400BFAF */  sw         $ra, 0x14($sp)
    /* DD18C 800EC98C ACB0030C */  jal        FILE_completeop
    /* DD190 800EC990 2180C000 */   addu      $s0, $a2, $zero
    /* DD194 800EC994 E6B2030C */  jal        func_800ECB98
    /* DD198 800EC998 21200002 */   addu      $a0, $s0, $zero
    /* DD19C 800EC99C 1400BF8F */  lw         $ra, 0x14($sp)
    /* DD1A0 800EC9A0 1000B08F */  lw         $s0, 0x10($sp)
    /* DD1A4 800EC9A4 0800E003 */  jr         $ra
    /* DD1A8 800EC9A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iFILE_delbigclosecallback
