.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_KillMenuTexture__Fv, 0x30

glabel Texture_KillMenuTexture__Fv
    /* D1054 800E0854 E015848F */  lw         $a0, %gp_rel(gFreePal4)($gp)
    /* D1058 800E0858 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D105C 800E085C 1000BFAF */  sw         $ra, 0x10($sp)
    /* D1060 800E0860 5095030C */  jal        purgememadr
    /* D1064 800E0864 00000000 */   nop
    /* D1068 800E0868 E815848F */  lw         $a0, %gp_rel(gFreePal8)($gp)
    /* D106C 800E086C 5095030C */  jal        purgememadr
    /* D1070 800E0870 00000000 */   nop
    /* D1074 800E0874 1000BF8F */  lw         $ra, 0x10($sp)
    /* D1078 800E0878 00000000 */  nop
    /* D107C 800E087C 0800E003 */  jr         $ra
    /* D1080 800E0880 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_KillMenuTexture__Fv
