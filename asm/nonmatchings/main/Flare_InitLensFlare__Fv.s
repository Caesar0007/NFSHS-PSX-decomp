.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_InitLensFlare__Fv, 0x28

glabel Flare_InitLensFlare__Fv
    /* BF344 800CEB44 1280033C */  lui        $v1, %hi(gFlare_LensFlare)
    /* BF348 800CEB48 78026324 */  addiu      $v1, $v1, %lo(gFlare_LensFlare)
    /* BF34C 800CEB4C 50000224 */  addiu      $v0, $zero, 0x50
    /* BF350 800CEB50 740062AC */  sw         $v0, 0x74($v1)
    /* BF354 800CEB54 1280023C */  lui        $v0, %hi(Flare_SunFlarePieces)
    /* BF358 800CEB58 E8014224 */  addiu      $v0, $v0, %lo(Flare_SunFlarePieces)
    /* BF35C 800CEB5C 780062AC */  sw         $v0, 0x78($v1)
    /* BF360 800CEB60 7D0060A0 */  sb         $zero, 0x7D($v1)
    /* BF364 800CEB64 0800E003 */  jr         $ra
    /* BF368 800CEB68 7C0060A0 */   sb        $zero, 0x7C($v1)
endlabel Flare_InitLensFlare__Fv
