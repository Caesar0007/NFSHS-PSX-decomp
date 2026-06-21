.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetDuelRace__FR12tMenuCommand, 0x40

glabel MenuExtended_SetDuelRace__FR12tMenuCommand
    /* 1CB9C 8002C39C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1CBA0 8002C3A0 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CBA4 8002C3A4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1CBA8 8002C3A8 01000324 */  addiu      $v1, $zero, 0x1
    /* 1CBAC 8002C3AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1CBB0 8002C3B0 460040A0 */  sb         $zero, 0x46($v0)
    /* 1CBB4 8002C3B4 040040A0 */  sb         $zero, 0x4($v0)
    /* 1CBB8 8002C3B8 1E0343A0 */  sb         $v1, 0x31E($v0)
    /* 1CBBC 8002C3BC 0580023C */  lui        $v0, %hi(screenMain)
    /* 1CBC0 8002C3C0 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1CBC4 8002C3C4 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1CBC8 8002C3C8 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1CBCC 8002C3CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1CBD0 8002C3D0 00000000 */  nop
    /* 1CBD4 8002C3D4 0800E003 */  jr         $ra
    /* 1CBD8 8002C3D8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetDuelRace__FR12tMenuCommand
