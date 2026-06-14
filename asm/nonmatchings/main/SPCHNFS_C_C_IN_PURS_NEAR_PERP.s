.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_C_IN_PURS_NEAR_PERP, 0x58

glabel SPCHNFS_C_C_IN_PURS_NEAR_PERP
    /* 83998 80093198 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 8399C 8009319C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 839A0 800931A0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 839A4 800931A4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800931A8:
    /* 839A8 800931A8 000040AC */  sw         $zero, 0x0($v0)
    /* 839AC 800931AC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 839B0 800931B0 FDFF6104 */  bgez       $v1, .L800931A8
    /* 839B4 800931B4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 839B8 800931B8 58010224 */  addiu      $v0, $zero, 0x158
    /* 839BC 800931BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 839C0 800931C0 0000828C */  lw         $v0, 0x0($a0)
    /* 839C4 800931C4 00000000 */  nop
    /* 839C8 800931C8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 839CC 800931CC 0000A28C */  lw         $v0, 0x0($a1)
    /* 839D0 800931D0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 839D4 800931D4 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 839D8 800931D8 6E9C030C */  jal        SPCH_AddEvent
    /* 839DC 800931DC 1800A2AF */   sw        $v0, 0x18($sp)
    /* 839E0 800931E0 4000BF8F */  lw         $ra, 0x40($sp)
    /* 839E4 800931E4 00000000 */  nop
    /* 839E8 800931E8 0800E003 */  jr         $ra
    /* 839EC 800931EC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_C_IN_PURS_NEAR_PERP
