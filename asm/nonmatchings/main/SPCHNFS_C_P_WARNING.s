.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_P_WARNING, 0x54

glabel SPCHNFS_C_P_WARNING
    /* 8433C 80093B3C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84340 80093B40 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84344 80093B44 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84348 80093B48 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093B4C:
    /* 8434C 80093B4C 000040AC */  sw         $zero, 0x0($v0)
    /* 84350 80093B50 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84354 80093B54 FDFF6104 */  bgez       $v1, .L80093B4C
    /* 84358 80093B58 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8435C 80093B5C 88010224 */  addiu      $v0, $zero, 0x188
    /* 84360 80093B60 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84364 80093B64 0000828C */  lw         $v0, 0x0($a0)
    /* 84368 80093B68 00000000 */  nop
    /* 8436C 80093B6C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84370 80093B70 0000A28C */  lw         $v0, 0x0($a1)
    /* 84374 80093B74 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84378 80093B78 6E9C030C */  jal        SPCH_AddEvent
    /* 8437C 80093B7C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 84380 80093B80 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84384 80093B84 00000000 */  nop
    /* 84388 80093B88 0800E003 */  jr         $ra
    /* 8438C 80093B8C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_P_WARNING
