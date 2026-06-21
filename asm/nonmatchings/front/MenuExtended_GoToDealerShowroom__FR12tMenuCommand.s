.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToDealerShowroom__FR12tMenuCommand, 0x40

glabel MenuExtended_GoToDealerShowroom__FR12tMenuCommand
    /* 1DAB8 8002D2B8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DABC 8002D2BC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1DAC0 8002D2C0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1DAC4 8002D2C4 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DAC8 8002D2C8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1DACC 8002D2CC 000083AC */  sw         $v1, 0x0($a0)
    /* 1DAD0 8002D2D0 6C234224 */  addiu      $v0, $v0, 0x236C
    /* 1DAD4 8002D2D4 040082AC */  sw         $v0, 0x4($a0)
    /* 1DAD8 8002D2D8 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1DADC 8002D2DC 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1DAE0 8002D2E0 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1DAE4 8002D2E4 06000524 */   addiu     $a1, $zero, 0x6
    /* 1DAE8 8002D2E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1DAEC 8002D2EC 00000000 */  nop
    /* 1DAF0 8002D2F0 0800E003 */  jr         $ra
    /* 1DAF4 8002D2F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToDealerShowroom__FR12tMenuCommand
