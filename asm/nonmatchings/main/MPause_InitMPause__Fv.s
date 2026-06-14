.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_InitMPause__Fv, 0x38

glabel MPause_InitMPause__Fv
    /* 8F448 8009EC48 1180023C */  lui        $v0, %hi(D_801132CC)
    /* 8F44C 8009EC4C CC32448C */  lw         $a0, %lo(D_801132CC)($v0)
    /* 8F450 8009EC50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8F454 8009EC54 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8F458 8009EC58 77E4020C */  jal        TextSys_LoadInGame__Fi
    /* 8F45C 8009EC5C 00000000 */   nop
    /* 8F460 8009EC60 578F020C */  jal        __builtin_new
    /* 8F464 8009EC64 58030424 */   addiu     $a0, $zero, 0x358
    /* 8F468 8009EC68 B577020C */  jal        __14tPauseMenuDefs
    /* 8F46C 8009EC6C 21204000 */   addu      $a0, $v0, $zero
    /* 8F470 8009EC70 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8F474 8009EC74 1C0D82AF */  sw         $v0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F478 8009EC78 0800E003 */  jr         $ra
    /* 8F47C 8009EC7C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MPause_InitMPause__Fv
