.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_MakeTrackDataPathName__FPc, 0x48

glabel Track_MakeTrackDataPathName__FPc
    /* A9B50 800B9350 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A9B54 800B9354 1800B0AF */  sw         $s0, 0x18($sp)
    /* A9B58 800B9358 1480103C */  lui        $s0, %hi(D_8013E340)
    /* A9B5C 800B935C 40E31026 */  addiu      $s0, $s0, %lo(D_8013E340)
    /* A9B60 800B9360 0580053C */  lui        $a1, %hi(D_80056644)
    /* A9B64 800B9364 1180023C */  lui        $v0, %hi(D_80116488)
    /* A9B68 800B9368 1000A4AF */  sw         $a0, 0x10($sp)
    /* A9B6C 800B936C 21200002 */  addu       $a0, $s0, $zero
    /* A9B70 800B9370 900F878F */  lw         $a3, %gp_rel(gtrackNumber)($gp)
    /* A9B74 800B9374 8864468C */  lw         $a2, %lo(D_80116488)($v0)
    /* A9B78 800B9378 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* A9B7C 800B937C 2F91030C */  jal        sprintf
    /* A9B80 800B9380 4466A524 */   addiu     $a1, $a1, %lo(D_80056644)
    /* A9B84 800B9384 21100002 */  addu       $v0, $s0, $zero
    /* A9B88 800B9388 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* A9B8C 800B938C 1800B08F */  lw         $s0, 0x18($sp)
    /* A9B90 800B9390 0800E003 */  jr         $ra
    /* A9B94 800B9394 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Track_MakeTrackDataPathName__FPc
