.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_PERP_AIRBORN, 0x48

glabel SPCHNFS_C_D_IN_PURS_PERP_AIRBORN
    /* 847BC 80093FBC B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 847C0 80093FC0 4000BFAF */  sw         $ra, 0x40($sp)
    /* 847C4 80093FC4 0B000324 */  addiu      $v1, $zero, 0xB
    /* 847C8 80093FC8 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093FCC:
    /* 847CC 80093FCC 000040AC */  sw         $zero, 0x0($v0)
    /* 847D0 80093FD0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 847D4 80093FD4 FDFF6104 */  bgez       $v1, .L80093FCC
    /* 847D8 80093FD8 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 847DC 80093FDC A6010224 */  addiu      $v0, $zero, 0x1A6
    /* 847E0 80093FE0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 847E4 80093FE4 0000828C */  lw         $v0, 0x0($a0)
    /* 847E8 80093FE8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 847EC 80093FEC 6E9C030C */  jal        SPCH_AddEvent
    /* 847F0 80093FF0 1400A2AF */   sw        $v0, 0x14($sp)
    /* 847F4 80093FF4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 847F8 80093FF8 00000000 */  nop
    /* 847FC 80093FFC 0800E003 */  jr         $ra
    /* 84800 80094000 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_PERP_AIRBORN
