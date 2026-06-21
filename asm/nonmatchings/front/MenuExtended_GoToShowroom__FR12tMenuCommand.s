.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToShowroom__FR12tMenuCommand, 0x40

glabel MenuExtended_GoToShowroom__FR12tMenuCommand
    /* 1DA78 8002D278 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DA7C 8002D27C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1DA80 8002D280 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1DA84 8002D284 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DA88 8002D288 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1DA8C 8002D28C 000083AC */  sw         $v1, 0x0($a0)
    /* 1DA90 8002D290 6C234224 */  addiu      $v0, $v0, 0x236C
    /* 1DA94 8002D294 040082AC */  sw         $v0, 0x4($a0)
    /* 1DA98 8002D298 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1DA9C 8002D29C 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1DAA0 8002D2A0 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1DAA4 8002D2A4 05000524 */   addiu     $a1, $zero, 0x5
    /* 1DAA8 8002D2A8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1DAAC 8002D2AC 00000000 */  nop
    /* 1DAB0 8002D2B0 0800E003 */  jr         $ra
    /* 1DAB4 8002D2B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToShowroom__FR12tMenuCommand
