.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CV_InitColorVertices__Fv, 0x34

glabel CV_InitColorVertices__Fv
    /* D1D10 800E1510 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D1D14 800E1514 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D1D18 800E1518 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* D1D1C 800E151C 1000BFAF */  sw         $ra, 0x10($sp)
    /* D1D20 800E1520 3C00448C */  lw         $a0, 0x3C($v0)
    /* D1D24 800E1524 4800458C */  lw         $a1, 0x48($v0)
    /* D1D28 800E1528 5400468C */  lw         $a2, 0x54($v0)
    /* D1D2C 800E152C C284030C */  jal        CV_ColorTracks__Fiii
    /* D1D30 800E1530 0F008430 */   andi      $a0, $a0, 0xF
    /* D1D34 800E1534 1000BF8F */  lw         $ra, 0x10($sp)
    /* D1D38 800E1538 00000000 */  nop
    /* D1D3C 800E153C 0800E003 */  jr         $ra
    /* D1D40 800E1540 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CV_InitColorVertices__Fv
