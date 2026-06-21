.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXDrawBrightEndLine__Fiiiiiiii, 0x40

glabel PSXDrawBrightEndLine__Fiiiiiiii
    /* 3C338 8004BB38 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3C33C 8004BB3C 4000A28F */  lw         $v0, 0x40($sp)
    /* 3C340 8004BB40 4400A38F */  lw         $v1, 0x44($sp)
    /* 3C344 8004BB44 4800A88F */  lw         $t0, 0x48($sp)
    /* 3C348 8004BB48 4C00A98F */  lw         $t1, 0x4C($sp)
    /* 3C34C 8004BB4C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3C350 8004BB50 2000A0AF */  sw         $zero, 0x20($sp)
    /* 3C354 8004BB54 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3C358 8004BB58 1400A3AF */  sw         $v1, 0x14($sp)
    /* 3C35C 8004BB5C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 3C360 8004BB60 DE2E010C */  jal        PSXTransDrawBrightEndLine__Fiiiiiiiii
    /* 3C364 8004BB64 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 3C368 8004BB68 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3C36C 8004BB6C 00000000 */  nop
    /* 3C370 8004BB70 0800E003 */  jr         $ra
    /* 3C374 8004BB74 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel PSXDrawBrightEndLine__Fiiiiiiii
