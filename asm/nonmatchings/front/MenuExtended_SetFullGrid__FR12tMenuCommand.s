.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetFullGrid__FR12tMenuCommand, 0x40

glabel MenuExtended_SetFullGrid__FR12tMenuCommand
    /* 1CBDC 8002C3DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1CBE0 8002C3E0 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CBE4 8002C3E4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1CBE8 8002C3E8 02000324 */  addiu      $v1, $zero, 0x2
    /* 1CBEC 8002C3EC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1CBF0 8002C3F0 460040A0 */  sb         $zero, 0x46($v0)
    /* 1CBF4 8002C3F4 040040A0 */  sb         $zero, 0x4($v0)
    /* 1CBF8 8002C3F8 1E0343A0 */  sb         $v1, 0x31E($v0)
    /* 1CBFC 8002C3FC 0580023C */  lui        $v0, %hi(screenMain)
    /* 1CC00 8002C400 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1CC04 8002C404 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1CC08 8002C408 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1CC0C 8002C40C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1CC10 8002C410 00000000 */  nop
    /* 1CC14 8002C414 0800E003 */  jr         $ra
    /* 1CC18 8002C418 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetFullGrid__FR12tMenuCommand
