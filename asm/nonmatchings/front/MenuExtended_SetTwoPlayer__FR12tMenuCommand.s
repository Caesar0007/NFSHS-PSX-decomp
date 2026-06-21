.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetTwoPlayer__FR12tMenuCommand, 0x50

glabel MenuExtended_SetTwoPlayer__FR12tMenuCommand
    /* 1C92C 8002C12C 1480023C */  lui        $v0, %hi(D_8013E8C0)
    /* 1C930 8002C130 C0E84290 */  lbu        $v0, %lo(D_8013E8C0)($v0)
    /* 1C934 8002C134 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C938 8002C138 03004010 */  beqz       $v0, .L8002C148
    /* 1C93C 8002C13C 1000BFAF */   sw        $ra, 0x10($sp)
    /* 1C940 8002C140 5BB00008 */  j          .L8002C16C
    /* 1C944 8002C144 000080AC */   sw        $zero, 0x0($a0)
  .L8002C148:
    /* 1C948 8002C148 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C94C 8002C14C 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1C950 8002C150 01000324 */  addiu      $v1, $zero, 0x1
    /* 1C954 8002C154 030043A0 */  sb         $v1, 0x3($v0)
    /* 1C958 8002C158 1E0340A0 */  sb         $zero, 0x31E($v0)
    /* 1C95C 8002C15C 0580023C */  lui        $v0, %hi(screenMain)
    /* 1C960 8002C160 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1C964 8002C164 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1C968 8002C168 FFFF0524 */   addiu     $a1, $zero, -0x1
  .L8002C16C:
    /* 1C96C 8002C16C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1C970 8002C170 00000000 */  nop
    /* 1C974 8002C174 0800E003 */  jr         $ra
    /* 1C978 8002C178 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetTwoPlayer__FR12tMenuCommand
