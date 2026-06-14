.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC, 0x60

glabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC
    /* 84558 80093D58 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 8455C 80093D5C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84560 80093D60 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84564 80093D64 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093D68:
    /* 84568 80093D68 000040AC */  sw         $zero, 0x0($v0)
    /* 8456C 80093D6C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84570 80093D70 FDFF6104 */  bgez       $v1, .L80093D68
    /* 84574 80093D74 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84578 80093D78 9E010224 */  addiu      $v0, $zero, 0x19E
    /* 8457C 80093D7C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84580 80093D80 0000828C */  lw         $v0, 0x0($a0)
    /* 84584 80093D84 00000000 */  nop
    /* 84588 80093D88 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8458C 80093D8C 0000A28C */  lw         $v0, 0x0($a1)
    /* 84590 80093D90 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 84594 80093D94 1800A2AF */  sw         $v0, 0x18($sp)
    /* 84598 80093D98 0000E28C */  lw         $v0, 0x0($a3)
    /* 8459C 80093D9C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 845A0 80093DA0 6E9C030C */  jal        SPCH_AddEvent
    /* 845A4 80093DA4 2000A2AF */   sw        $v0, 0x20($sp)
    /* 845A8 80093DA8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 845AC 80093DAC 00000000 */  nop
    /* 845B0 80093DB0 0800E003 */  jr         $ra
    /* 845B4 80093DB4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC
