.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_ReverbOff__Fv, 0x28

glabel AudioCmn_ReverbOff__Fv
    /* 6A6CC 80079ECC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A6D0 80079ED0 21200000 */  addu       $a0, $zero, $zero
    /* 6A6D4 80079ED4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A6D8 80079ED8 749B030C */  jal        SNDfxmasterlevel
    /* 6A6DC 80079EDC 21288000 */   addu      $a1, $a0, $zero
    /* 6A6E0 80079EE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A6E4 80079EE4 2D0180A3 */  sb         $zero, %gp_rel(fReverbLevel)($gp)
    /* 6A6E8 80079EE8 2C0180A3 */  sb         $zero, %gp_rel(fReverbOn)($gp)
    /* 6A6EC 80079EEC 0800E003 */  jr         $ra
    /* 6A6F0 80079EF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_ReverbOff__Fv
