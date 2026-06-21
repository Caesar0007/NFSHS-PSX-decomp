.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetSpecialEvent__FR12tMenuCommand, 0x48

glabel MenuExtended_SetSpecialEvent__FR12tMenuCommand
    /* 1CA20 8002C220 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1CA24 8002C224 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CA28 8002C228 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1CA2C 8002C22C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1CA30 8002C230 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1CA34 8002C234 2A0143A0 */  sb         $v1, 0x12A($v0)
    /* 1CA38 8002C238 220143A0 */  sb         $v1, 0x122($v0)
    /* 1CA3C 8002C23C 02000324 */  addiu      $v1, $zero, 0x2
    /* 1CA40 8002C240 460040A0 */  sb         $zero, 0x46($v0)
    /* 1CA44 8002C244 040043A0 */  sb         $v1, 0x4($v0)
    /* 1CA48 8002C248 0580023C */  lui        $v0, %hi(screenMain)
    /* 1CA4C 8002C24C 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1CA50 8002C250 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1CA54 8002C254 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1CA58 8002C258 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1CA5C 8002C25C 00000000 */  nop
    /* 1CA60 8002C260 0800E003 */  jr         $ra
    /* 1CA64 8002C264 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetSpecialEvent__FR12tMenuCommand
