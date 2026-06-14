.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD, 0x54

glabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD
    /* 845B8 80093DB8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 845BC 80093DBC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 845C0 80093DC0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 845C4 80093DC4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093DC8:
    /* 845C8 80093DC8 000040AC */  sw         $zero, 0x0($v0)
    /* 845CC 80093DCC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 845D0 80093DD0 FDFF6104 */  bgez       $v1, .L80093DC8
    /* 845D4 80093DD4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 845D8 80093DD8 9F010224 */  addiu      $v0, $zero, 0x19F
    /* 845DC 80093DDC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 845E0 80093DE0 0000828C */  lw         $v0, 0x0($a0)
    /* 845E4 80093DE4 1800A5AF */  sw         $a1, 0x18($sp)
    /* 845E8 80093DE8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 845EC 80093DEC 0000C28C */  lw         $v0, 0x0($a2)
    /* 845F0 80093DF0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 845F4 80093DF4 6E9C030C */  jal        SPCH_AddEvent
    /* 845F8 80093DF8 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 845FC 80093DFC 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84600 80093E00 00000000 */  nop
    /* 84604 80093E04 0800E003 */  jr         $ra
    /* 84608 80093E08 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD
