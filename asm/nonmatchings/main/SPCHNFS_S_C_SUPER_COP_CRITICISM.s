.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_S_C_SUPER_COP_CRITICISM, 0x48

glabel SPCHNFS_S_C_SUPER_COP_CRITICISM
    /* 84510 80093D10 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84514 80093D14 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84518 80093D18 0B000324 */  addiu      $v1, $zero, 0xB
    /* 8451C 80093D1C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093D20:
    /* 84520 80093D20 000040AC */  sw         $zero, 0x0($v0)
    /* 84524 80093D24 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84528 80093D28 FDFF6104 */  bgez       $v1, .L80093D20
    /* 8452C 80093D2C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84530 80093D30 8F010224 */  addiu      $v0, $zero, 0x18F
    /* 84534 80093D34 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84538 80093D38 0000828C */  lw         $v0, 0x0($a0)
    /* 8453C 80093D3C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84540 80093D40 6E9C030C */  jal        SPCH_AddEvent
    /* 84544 80093D44 1400A2AF */   sw        $v0, 0x14($sp)
    /* 84548 80093D48 4000BF8F */  lw         $ra, 0x40($sp)
    /* 8454C 80093D4C 00000000 */  nop
    /* 84550 80093D50 0800E003 */  jr         $ra
    /* 84554 80093D54 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_S_C_SUPER_COP_CRITICISM
