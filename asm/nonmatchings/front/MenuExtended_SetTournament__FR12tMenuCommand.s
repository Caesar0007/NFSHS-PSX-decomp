.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetTournament__FR12tMenuCommand, 0x48

glabel MenuExtended_SetTournament__FR12tMenuCommand
    /* 1C9D8 8002C1D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C9DC 8002C1DC 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C9E0 8002C1E0 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1C9E4 8002C1E4 01000324 */  addiu      $v1, $zero, 0x1
    /* 1C9E8 8002C1E8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1C9EC 8002C1EC 2A0143A0 */  sb         $v1, 0x12A($v0)
    /* 1C9F0 8002C1F0 02000324 */  addiu      $v1, $zero, 0x2
    /* 1C9F4 8002C1F4 460040A0 */  sb         $zero, 0x46($v0)
    /* 1C9F8 8002C1F8 220140A0 */  sb         $zero, 0x122($v0)
    /* 1C9FC 8002C1FC 040043A0 */  sb         $v1, 0x4($v0)
    /* 1CA00 8002C200 0580023C */  lui        $v0, %hi(screenMain)
    /* 1CA04 8002C204 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1CA08 8002C208 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1CA0C 8002C20C FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1CA10 8002C210 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1CA14 8002C214 00000000 */  nop
    /* 1CA18 8002C218 0800E003 */  jr         $ra
    /* 1CA1C 8002C21C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetTournament__FR12tMenuCommand
