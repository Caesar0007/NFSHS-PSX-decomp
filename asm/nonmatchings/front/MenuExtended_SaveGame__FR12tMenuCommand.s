.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SaveGame__FR12tMenuCommand, 0x50

glabel MenuExtended_SaveGame__FR12tMenuCommand
    /* 1DFEC 8002D7EC 0580023C */  lui        $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 1DFF0 8002D7F0 7C1A428C */  lw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 1DFF4 8002D7F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DFF8 8002D7F8 0C004014 */  bnez       $v0, .L8002D82C
    /* 1DFFC 8002D7FC 1000BFAF */   sw        $ra, 0x10($sp)
    /* 1E000 8002D800 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1E004 8002D804 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E008 8002D808 00000000 */  nop
    /* 1E00C 8002D80C 5430428C */  lw         $v0, 0x3054($v0)
    /* 1E010 8002D810 00000000 */  nop
    /* 1E014 8002D814 01004238 */  xori       $v0, $v0, 0x1
    /* 1E018 8002D818 01004230 */  andi       $v0, $v0, 0x1
    /* 1E01C 8002D81C 03004010 */  beqz       $v0, .L8002D82C
    /* 1E020 8002D820 00000000 */   nop
    /* 1E024 8002D824 68B2000C */  jal        GenericMenuSaveGame__Fi
    /* 1E028 8002D828 21200000 */   addu      $a0, $zero, $zero
  .L8002D82C:
    /* 1E02C 8002D82C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1E030 8002D830 00000000 */  nop
    /* 1E034 8002D834 0800E003 */  jr         $ra
    /* 1E038 8002D838 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SaveGame__FR12tMenuCommand
