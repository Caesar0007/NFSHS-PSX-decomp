.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_KillRenderingData__Fv, 0x30

glabel DrawC_KillRenderingData__Fv
    /* AF148 800BE948 A412848F */  lw         $a0, %gp_rel(DrawC_gEnvMap)($gp)
    /* AF14C 800BE94C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AF150 800BE950 1000BFAF */  sw         $ra, 0x10($sp)
    /* AF154 800BE954 5095030C */  jal        purgememadr
    /* AF158 800BE958 00000000 */   nop
    /* AF15C 800BE95C A812848F */  lw         $a0, %gp_rel(DrawC_gShadow)($gp)
    /* AF160 800BE960 5095030C */  jal        purgememadr
    /* AF164 800BE964 00000000 */   nop
    /* AF168 800BE968 1000BF8F */  lw         $ra, 0x10($sp)
    /* AF16C 800BE96C 00000000 */  nop
    /* AF170 800BE970 0800E003 */  jr         $ra
    /* AF174 800BE974 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawC_KillRenderingData__Fv
