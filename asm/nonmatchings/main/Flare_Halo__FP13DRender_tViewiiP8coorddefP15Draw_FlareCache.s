.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache, 0x28

glabel Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache
    /* BE69C 800CDE9C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BE6A0 800CDEA0 3000A28F */  lw         $v0, 0x30($sp)
    /* BE6A4 800CDEA4 1800BFAF */  sw         $ra, 0x18($sp)
    /* BE6A8 800CDEA8 1000A0AF */  sw         $zero, 0x10($sp)
    /* BE6AC 800CDEAC 4C35030C */  jal        Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
    /* BE6B0 800CDEB0 1400A2AF */   sw        $v0, 0x14($sp)
    /* BE6B4 800CDEB4 1800BF8F */  lw         $ra, 0x18($sp)
    /* BE6B8 800CDEB8 00000000 */  nop
    /* BE6BC 800CDEBC 0800E003 */  jr         $ra
    /* BE6C0 800CDEC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache
