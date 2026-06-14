.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS, 0x74

glabel SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS
    /* 83B20 80093320 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83B24 80093324 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83B28 80093328 0B000824 */  addiu      $t0, $zero, 0xB
    /* 83B2C 8009332C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093330:
    /* 83B30 80093330 000040AC */  sw         $zero, 0x0($v0)
    /* 83B34 80093334 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 83B38 80093338 FDFF0105 */  bgez       $t0, .L80093330
    /* 83B3C 8009333C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83B40 80093340 5E010224 */  addiu      $v0, $zero, 0x15E
    /* 83B44 80093344 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83B48 80093348 0000828C */  lw         $v0, 0x0($a0)
    /* 83B4C 8009334C 00000000 */  nop
    /* 83B50 80093350 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83B54 80093354 0000A28C */  lw         $v0, 0x0($a1)
    /* 83B58 80093358 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83B5C 8009335C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83B60 80093360 5800A28F */  lw         $v0, 0x58($sp)
    /* 83B64 80093364 0000E38C */  lw         $v1, 0x0($a3)
    /* 83B68 80093368 2400A2AF */  sw         $v0, 0x24($sp)
    /* 83B6C 8009336C 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 83B70 80093370 2000A3AF */  sw         $v1, 0x20($sp)
    /* 83B74 80093374 0000428C */  lw         $v0, 0x0($v0)
    /* 83B78 80093378 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83B7C 8009337C 6E9C030C */  jal        SPCH_AddEvent
    /* 83B80 80093380 2800A2AF */   sw        $v0, 0x28($sp)
    /* 83B84 80093384 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83B88 80093388 00000000 */  nop
    /* 83B8C 8009338C 0800E003 */  jr         $ra
    /* 83B90 80093390 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS
