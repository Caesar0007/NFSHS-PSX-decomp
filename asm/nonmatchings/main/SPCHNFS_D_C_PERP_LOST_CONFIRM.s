.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_PERP_LOST_CONFIRM, 0x4C

glabel SPCHNFS_D_C_PERP_LOST_CONFIRM
    /* 840F4 800938F4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 840F8 800938F8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 840FC 800938FC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84100 80093900 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093904:
    /* 84104 80093904 000040AC */  sw         $zero, 0x0($v0)
    /* 84108 80093908 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8410C 8009390C FDFF6104 */  bgez       $v1, .L80093904
    /* 84110 80093910 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84114 80093914 7B010224 */  addiu      $v0, $zero, 0x17B
    /* 84118 80093918 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8411C 8009391C 0000828C */  lw         $v0, 0x0($a0)
    /* 84120 80093920 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84124 80093924 1800A5AF */  sw         $a1, 0x18($sp)
    /* 84128 80093928 6E9C030C */  jal        SPCH_AddEvent
    /* 8412C 8009392C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 84130 80093930 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84134 80093934 00000000 */  nop
    /* 84138 80093938 0800E003 */  jr         $ra
    /* 8413C 8009393C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_PERP_LOST_CONFIRM
