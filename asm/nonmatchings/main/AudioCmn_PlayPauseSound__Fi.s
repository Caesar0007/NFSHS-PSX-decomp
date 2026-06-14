.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayPauseSound__Fi, 0x38

glabel AudioCmn_PlayPauseSound__Fi
    /* 69EE4 800796E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 69EE8 800796E8 40000224 */  addiu      $v0, $zero, 0x40
    /* 69EEC 800796EC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 69EF0 800796F0 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 69EF4 800796F4 21288000 */  addu       $a1, $a0, $zero
    /* 69EF8 800796F8 21300000 */  addu       $a2, $zero, $zero
    /* 69EFC 800796FC CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 69F00 80079700 1800BFAF */  sw         $ra, 0x18($sp)
    /* 69F04 80079704 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 69F08 80079708 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 69F0C 8007970C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 69F10 80079710 8C0182AF */  sw         $v0, %gp_rel(AudioCmn_gCursorSndHandle)($gp)
    /* 69F14 80079714 0800E003 */  jr         $ra
    /* 69F18 80079718 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_PlayPauseSound__Fi
