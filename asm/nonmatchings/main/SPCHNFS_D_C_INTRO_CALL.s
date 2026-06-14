.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_INTRO_CALL, 0x50

glabel SPCHNFS_D_C_INTRO_CALL
    /* 84714 80093F14 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84718 80093F18 4000BFAF */  sw         $ra, 0x40($sp)
    /* 8471C 80093F1C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84720 80093F20 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093F24:
    /* 84724 80093F24 000040AC */  sw         $zero, 0x0($v0)
    /* 84728 80093F28 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8472C 80093F2C FDFF6104 */  bgez       $v1, .L80093F24
    /* 84730 80093F30 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84734 80093F34 A3010224 */  addiu      $v0, $zero, 0x1A3
    /* 84738 80093F38 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8473C 80093F3C 1400A4AF */  sw         $a0, 0x14($sp)
    /* 84740 80093F40 1800A5AF */  sw         $a1, 0x18($sp)
    /* 84744 80093F44 0000C28C */  lw         $v0, 0x0($a2)
    /* 84748 80093F48 1000A427 */  addiu      $a0, $sp, 0x10
    /* 8474C 80093F4C 6E9C030C */  jal        SPCH_AddEvent
    /* 84750 80093F50 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 84754 80093F54 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84758 80093F58 00000000 */  nop
    /* 8475C 80093F5C 0800E003 */  jr         $ra
    /* 84760 80093F60 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_INTRO_CALL
