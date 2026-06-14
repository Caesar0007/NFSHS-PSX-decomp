.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_Restart__Fv, 0x5C

glabel BWorld_Restart__Fv
    /* 6ED64 8007E564 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6ED68 8007E568 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6ED6C 8007E56C 9694020C */  jal        Object_KillStatus__Fv
    /* 6ED70 8007E570 00000000 */   nop
    /* 6ED74 8007E574 8C94020C */  jal        Object_InitStatus__Fv
    /* 6ED78 8007E578 00000000 */   nop
    /* 6ED7C 8007E57C 20F9010C */  jal        SetContext__Fi
    /* 6ED80 8007E580 21200000 */   addu      $a0, $zero, $zero
    /* 6ED84 8007E584 06F6010C */  jal        BWorld_InitSpikeBelt__Fv
    /* 6ED88 8007E588 00000000 */   nop
    /* 6ED8C 8007E58C A5CE010C */  jal        Anim_Restart__Fv
    /* 6ED90 8007E590 00000000 */   nop
    /* 6ED94 8007E594 0C0280AF */  sw         $zero, %gp_rel(SceneLoaded)($gp)
    /* 6ED98 8007E598 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* 6ED9C 8007E59C 00000000 */   nop
    /* 6EDA0 8007E5A0 1480013C */  lui        $at, %hi(Draw_gDoVSync)
    /* 6EDA4 8007E5A4 A8D720AC */  sw         $zero, %lo(Draw_gDoVSync)($at)
    /* 6EDA8 8007E5A8 52FA010C */  jal        BWorldSm_Restart__Fv
    /* 6EDAC 8007E5AC 00000000 */   nop
    /* 6EDB0 8007E5B0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6EDB4 8007E5B4 00000000 */  nop
    /* 6EDB8 8007E5B8 0800E003 */  jr         $ra
    /* 6EDBC 8007E5BC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorld_Restart__Fv
