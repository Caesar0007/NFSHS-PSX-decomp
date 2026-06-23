.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToDealer__FR12tMenuCommand, 0x68

glabel MenuExtended_GoToDealer__FR12tMenuCommand
    /* 1D090 8002C890 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D094 8002C894 21308000 */  addu       $a2, $a0, $zero
    /* 1D098 8002C898 02000524 */  addiu      $a1, $zero, 0x2
    /* 1D09C 8002C89C 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1D0A0 8002C8A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D0A4 8002C8A4 0580103C */  lui        $s0, %hi(menuDefs)
    /* 1D0A8 8002C8A8 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1D0AC 8002C8AC 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 1D0B0 8002C8B0 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D0B4 8002C8B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1D0B8 8002C8B8 0000C3AC */  sw         $v1, 0x0($a2)
    /* 1D0BC 8002C8BC 481D4224 */  addiu      $v0, $v0, 0x1D48
    /* 1D0C0 8002C8C0 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1D0C4 8002C8C4 0400C2AC */   sw        $v0, 0x4($a2)
    /* 1D0C8 8002C8C8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D0CC 8002C8CC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D0D0 8002C8D0 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1D0D4 8002C8D4 641C8424 */   addiu     $a0, $a0, 0x1C64
    /* 1D0D8 8002C8D8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D0DC 8002C8DC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D0E0 8002C8E0 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1D0E4 8002C8E4 641C8424 */   addiu     $a0, $a0, 0x1C64
    /* 1D0E8 8002C8E8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1D0EC 8002C8EC 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D0F0 8002C8F0 0800E003 */  jr         $ra
    /* 1D0F4 8002C8F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToDealer__FR12tMenuCommand
