.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_GetAINameFromPersonality__F14tPersonalities, 0x3C

glabel Stattool_GetAINameFromPersonality__F14tPersonalities
    /* 3B74C 8004AF4C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3B750 8004AF50 0F00822C */  sltiu      $v0, $a0, 0xF
    /* 3B754 8004AF54 06004010 */  beqz       $v0, .L8004AF70
    /* 3B758 8004AF58 1000BFAF */   sw        $ra, 0x10($sp)
    /* 3B75C 8004AF5C C0180400 */  sll        $v1, $a0, 3
    /* 3B760 8004AF60 1180023C */  lui        $v0, %hi(GameSetup_gPersonalityNames)
    /* 3B764 8004AF64 74314224 */  addiu      $v0, $v0, %lo(GameSetup_gPersonalityNames)
    /* 3B768 8004AF68 DE2B0108 */  j          .L8004AF78
    /* 3B76C 8004AF6C 21106200 */   addu      $v0, $v1, $v0
  .L8004AF70:
    /* 3B770 8004AF70 94E4020C */  jal        TextSys_Word__Fi
    /* 3B774 8004AF74 EE020424 */   addiu     $a0, $zero, 0x2EE
  .L8004AF78:
    /* 3B778 8004AF78 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3B77C 8004AF7C 00000000 */  nop
    /* 3B780 8004AF80 0800E003 */  jr         $ra
    /* 3B784 8004AF84 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Stattool_GetAINameFromPersonality__F14tPersonalities
