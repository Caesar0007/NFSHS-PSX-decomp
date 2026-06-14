.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudList_LoadAudioFile__Fi, 0x54

glabel AudList_LoadAudioFile__Fi
    /* 6BD54 8007B554 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* 6BD58 8007B558 9000B0AF */  sw         $s0, 0x90($sp)
    /* 6BD5C 8007B55C 21808000 */  addu       $s0, $a0, $zero
    /* 6BD60 8007B560 1480043C */  lui        $a0, %hi(D_8013C72C)
    /* 6BD64 8007B564 9400BFAF */  sw         $ra, 0x94($sp)
    /* 6BD68 8007B568 C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* 6BD6C 8007B56C 2CC78424 */   addiu     $a0, $a0, %lo(D_8013C72C)
    /* 6BD70 8007B570 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6BD74 8007B574 0580053C */  lui        $a1, %hi(D_800557E8)
    /* 6BD78 8007B578 E857A524 */  addiu      $a1, $a1, %lo(D_800557E8)
    /* 6BD7C 8007B57C 21304000 */  addu       $a2, $v0, $zero
    /* 6BD80 8007B580 2F91030C */  jal        sprintf
    /* 6BD84 8007B584 21380002 */   addu      $a3, $s0, $zero
    /* 6BD88 8007B588 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6BD8C 8007B58C EA95030C */  jal        loadfileadrz
    /* 6BD90 8007B590 21280000 */   addu      $a1, $zero, $zero
    /* 6BD94 8007B594 9400BF8F */  lw         $ra, 0x94($sp)
    /* 6BD98 8007B598 9000B08F */  lw         $s0, 0x90($sp)
    /* 6BD9C 8007B59C E40182AF */  sw         $v0, %gp_rel(gGameAudioList)($gp)
    /* 6BDA0 8007B5A0 0800E003 */  jr         $ra
    /* 6BDA4 8007B5A4 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel AudList_LoadAudioFile__Fi
