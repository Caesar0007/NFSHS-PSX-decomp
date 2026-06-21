.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetSingleRace__FR12tMenuCommand, 0x40

glabel MenuExtended_SetSingleRace__FR12tMenuCommand
    /* 1C998 8002C198 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C99C 8002C19C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C9A0 8002C1A0 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1C9A4 8002C1A4 01000324 */  addiu      $v1, $zero, 0x1
    /* 1C9A8 8002C1A8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1C9AC 8002C1AC 2A0143A0 */  sb         $v1, 0x12A($v0)
    /* 1C9B0 8002C1B0 460040A0 */  sb         $zero, 0x46($v0)
    /* 1C9B4 8002C1B4 040040A0 */  sb         $zero, 0x4($v0)
    /* 1C9B8 8002C1B8 0580023C */  lui        $v0, %hi(screenMain)
    /* 1C9BC 8002C1BC 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1C9C0 8002C1C0 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1C9C4 8002C1C4 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1C9C8 8002C1C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1C9CC 8002C1CC 00000000 */  nop
    /* 1C9D0 8002C1D0 0800E003 */  jr         $ra
    /* 1C9D4 8002C1D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetSingleRace__FR12tMenuCommand
