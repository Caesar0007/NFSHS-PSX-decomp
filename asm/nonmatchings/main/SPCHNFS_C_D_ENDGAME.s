.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_ENDGAME, 0x48

glabel SPCHNFS_C_D_ENDGAME
    /* 84AA0 800942A0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84AA4 800942A4 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84AA8 800942A8 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84AAC 800942AC 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800942B0:
    /* 84AB0 800942B0 000040AC */  sw         $zero, 0x0($v0)
    /* 84AB4 800942B4 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84AB8 800942B8 FDFF6104 */  bgez       $v1, .L800942B0
    /* 84ABC 800942BC FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84AC0 800942C0 B3010224 */  addiu      $v0, $zero, 0x1B3
    /* 84AC4 800942C4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84AC8 800942C8 0000828C */  lw         $v0, 0x0($a0)
    /* 84ACC 800942CC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84AD0 800942D0 6E9C030C */  jal        SPCH_AddEvent
    /* 84AD4 800942D4 1400A2AF */   sw        $v0, 0x14($sp)
    /* 84AD8 800942D8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84ADC 800942DC 00000000 */  nop
    /* 84AE0 800942E0 0800E003 */  jr         $ra
    /* 84AE4 800942E4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_ENDGAME
