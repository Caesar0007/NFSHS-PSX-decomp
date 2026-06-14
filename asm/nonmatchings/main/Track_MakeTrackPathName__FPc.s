.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_MakeTrackPathName__FPc, 0x48

glabel Track_MakeTrackPathName__FPc
    /* A9B08 800B9308 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A9B0C 800B930C 1800B0AF */  sw         $s0, 0x18($sp)
    /* A9B10 800B9310 1480103C */  lui        $s0, %hi(D_8013E300)
    /* A9B14 800B9314 00E31026 */  addiu      $s0, $s0, %lo(D_8013E300)
    /* A9B18 800B9318 0580053C */  lui        $a1, %hi(D_80056644)
    /* A9B1C 800B931C 1180023C */  lui        $v0, %hi(D_80116480)
    /* A9B20 800B9320 1000A4AF */  sw         $a0, 0x10($sp)
    /* A9B24 800B9324 21200002 */  addu       $a0, $s0, $zero
    /* A9B28 800B9328 900F878F */  lw         $a3, %gp_rel(gtrackNumber)($gp)
    /* A9B2C 800B932C 8064468C */  lw         $a2, %lo(D_80116480)($v0)
    /* A9B30 800B9330 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* A9B34 800B9334 2F91030C */  jal        sprintf
    /* A9B38 800B9338 4466A524 */   addiu     $a1, $a1, %lo(D_80056644)
    /* A9B3C 800B933C 21100002 */  addu       $v0, $s0, $zero
    /* A9B40 800B9340 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* A9B44 800B9344 1800B08F */  lw         $s0, 0x18($sp)
    /* A9B48 800B9348 0800E003 */  jr         $ra
    /* A9B4C 800B934C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Track_MakeTrackPathName__FPc
