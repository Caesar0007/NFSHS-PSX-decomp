.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching KillFile_OpenRead__Fv, 0x44

glabel KillFile_OpenRead__Fv
    /* AB550 800BAD50 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* AB554 800BAD54 1480043C */  lui        $a0, %hi(D_8013D4A4)
    /* AB558 800BAD58 9000BFAF */  sw         $ra, 0x90($sp)
    /* AB55C 800BAD5C C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* AB560 800BAD60 A4D48424 */   addiu     $a0, $a0, %lo(D_8013D4A4)
    /* AB564 800BAD64 1000A427 */  addiu      $a0, $sp, 0x10
    /* AB568 800BAD68 1480053C */  lui        $a1, %hi(D_8013D490)
    /* AB56C 800BAD6C 90D4A524 */  addiu      $a1, $a1, %lo(D_8013D490)
    /* AB570 800BAD70 2F91030C */  jal        sprintf
    /* AB574 800BAD74 21304000 */   addu      $a2, $v0, $zero
    /* AB578 800BAD78 1000A427 */  addiu      $a0, $sp, 0x10
    /* AB57C 800BAD7C EA95030C */  jal        loadfileadrz
    /* AB580 800BAD80 21280000 */   addu      $a1, $zero, $zero
    /* AB584 800BAD84 9000BF8F */  lw         $ra, 0x90($sp)
    /* AB588 800BAD88 00000000 */  nop
    /* AB58C 800BAD8C 0800E003 */  jr         $ra
    /* AB590 800BAD90 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel KillFile_OpenRead__Fv
