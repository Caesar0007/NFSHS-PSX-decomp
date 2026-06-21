.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand, 0x4C

glabel MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand
    /* 1CCB0 8002C4B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1CCB4 8002C4B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1CCB8 8002C4B8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1CCBC 8002C4BC 07B1000C */  jal        AskTheUserToSaveTheGame__Fv
    /* 1CCC0 8002C4C0 21808000 */   addu      $s0, $a0, $zero
    /* 1CCC4 8002C4C4 07004010 */  beqz       $v0, .L8002C4E4
    /* 1CCC8 8002C4C8 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CCCC 8002C4CC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CCD0 8002C4D0 02000324 */  addiu      $v1, $zero, 0x2
    /* 1CCD4 8002C4D4 000003AE */  sw         $v1, 0x0($s0)
    /* 1CCD8 8002C4D8 983A4224 */  addiu      $v0, $v0, 0x3A98
    /* 1CCDC 8002C4DC 3BB10008 */  j          .L8002C4EC
    /* 1CCE0 8002C4E0 040002AE */   sw        $v0, 0x4($s0)
  .L8002C4E4:
    /* 1CCE4 8002C4E4 25B1000C */  jal        MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
    /* 1CCE8 8002C4E8 21200002 */   addu      $a0, $s0, $zero
  .L8002C4EC:
    /* 1CCEC 8002C4EC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1CCF0 8002C4F0 1000B08F */  lw         $s0, 0x10($sp)
    /* 1CCF4 8002C4F4 0800E003 */  jr         $ra
    /* 1CCF8 8002C4F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand
