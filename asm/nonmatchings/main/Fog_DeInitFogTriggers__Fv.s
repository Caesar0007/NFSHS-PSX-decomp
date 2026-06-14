.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_DeInitFogTriggers__Fv, 0x24

glabel Fog_DeInitFogTriggers__Fv
    /* D1910 800E1110 4016848F */  lw         $a0, %gp_rel(fogslicePos)($gp)
    /* D1914 800E1114 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D1918 800E1118 1000BFAF */  sw         $ra, 0x10($sp)
    /* D191C 800E111C 5095030C */  jal        purgememadr
    /* D1920 800E1120 00000000 */   nop
    /* D1924 800E1124 1000BF8F */  lw         $ra, 0x10($sp)
    /* D1928 800E1128 00000000 */  nop
    /* D192C 800E112C 0800E003 */  jr         $ra
    /* D1930 800E1130 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Fog_DeInitFogTriggers__Fv
