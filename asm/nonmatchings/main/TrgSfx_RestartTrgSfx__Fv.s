.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_RestartTrgSfx__Fv, 0x28

glabel TrgSfx_RestartTrgSfx__Fv
    /* AC1D8 800BB9D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC1DC 800BB9DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* AC1E0 800BB9E0 80EE020C */  jal        TrgSfx_KillTrgSfx__Fv
    /* AC1E4 800BB9E4 00000000 */   nop
    /* AC1E8 800BB9E8 40EE020C */  jal        TrgSfx_InitTrgSfx__Fv
    /* AC1EC 800BB9EC 00000000 */   nop
    /* AC1F0 800BB9F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* AC1F4 800BB9F4 00000000 */  nop
    /* AC1F8 800BB9F8 0800E003 */  jr         $ra
    /* AC1FC 800BB9FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TrgSfx_RestartTrgSfx__Fv
