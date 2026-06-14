.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitArtResources__Fv, 0x30

glabel InitArtResources__Fv
    /* A9BD8 800B93D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A9BDC 800B93DC 1280043C */  lui        $a0, %hi(gInitialArt)
    /* A9BE0 800B93E0 58E18424 */  addiu      $a0, $a0, %lo(gInitialArt)
    /* A9BE4 800B93E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* A9BE8 800B93E8 E6E4020C */  jal        AllocArtResource__FP18Track_tArtresourcei
    /* A9BEC 800B93EC 52030524 */   addiu     $a1, $zero, 0x352
    /* A9BF0 800B93F0 FEF8010C */  jal        BWAllocMem__Fl
    /* A9BF4 800B93F4 480D0424 */   addiu     $a0, $zero, 0xD48
    /* A9BF8 800B93F8 1000BF8F */  lw         $ra, 0x10($sp)
    /* A9BFC 800B93FC 840F82AF */  sw         $v0, %gp_rel(Track_materials)($gp)
    /* A9C00 800B9400 0800E003 */  jr         $ra
    /* A9C04 800B9404 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel InitArtResources__Fv
