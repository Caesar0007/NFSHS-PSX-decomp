.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_A_INTRO, 0x58

glabel SPCHNFS_C_A_INTRO
    /* 84764 80093F64 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84768 80093F68 4000BFAF */  sw         $ra, 0x40($sp)
    /* 8476C 80093F6C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84770 80093F70 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093F74:
    /* 84774 80093F74 000040AC */  sw         $zero, 0x0($v0)
    /* 84778 80093F78 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8477C 80093F7C FDFF6104 */  bgez       $v1, .L80093F74
    /* 84780 80093F80 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84784 80093F84 A5010224 */  addiu      $v0, $zero, 0x1A5
    /* 84788 80093F88 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8478C 80093F8C 0000828C */  lw         $v0, 0x0($a0)
    /* 84790 80093F90 1800A5AF */  sw         $a1, 0x18($sp)
    /* 84794 80093F94 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 84798 80093F98 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8479C 80093F9C 0000E28C */  lw         $v0, 0x0($a3)
    /* 847A0 80093FA0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 847A4 80093FA4 6E9C030C */  jal        SPCH_AddEvent
    /* 847A8 80093FA8 2000A2AF */   sw        $v0, 0x20($sp)
    /* 847AC 80093FAC 4000BF8F */  lw         $ra, 0x40($sp)
    /* 847B0 80093FB0 00000000 */  nop
    /* 847B4 80093FB4 0800E003 */  jr         $ra
    /* 847B8 80093FB8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_A_INTRO
