.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC, 0x8C

glabel SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC
    /* 8460C 80093E0C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84610 80093E10 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84614 80093E14 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84618 80093E18 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093E1C:
    /* 8461C 80093E1C 000040AC */  sw         $zero, 0x0($v0)
    /* 84620 80093E20 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84624 80093E24 FDFF6104 */  bgez       $v1, .L80093E1C
    /* 84628 80093E28 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8462C 80093E2C A0010224 */  addiu      $v0, $zero, 0x1A0
    /* 84630 80093E30 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84634 80093E34 0000828C */  lw         $v0, 0x0($a0)
    /* 84638 80093E38 00000000 */  nop
    /* 8463C 80093E3C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84640 80093E40 0000A28C */  lw         $v0, 0x0($a1)
    /* 84644 80093E44 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 84648 80093E48 1800A2AF */  sw         $v0, 0x18($sp)
    /* 8464C 80093E4C 0000E28C */  lw         $v0, 0x0($a3)
    /* 84650 80093E50 00000000 */  nop
    /* 84654 80093E54 2000A2AF */  sw         $v0, 0x20($sp)
    /* 84658 80093E58 5800A28F */  lw         $v0, 0x58($sp)
    /* 8465C 80093E5C 00000000 */  nop
    /* 84660 80093E60 0000438C */  lw         $v1, 0x0($v0)
    /* 84664 80093E64 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 84668 80093E68 00000000 */  nop
    /* 8466C 80093E6C 2800A2AF */  sw         $v0, 0x28($sp)
    /* 84670 80093E70 6000A28F */  lw         $v0, 0x60($sp)
    /* 84674 80093E74 2400A3AF */  sw         $v1, 0x24($sp)
    /* 84678 80093E78 0000428C */  lw         $v0, 0x0($v0)
    /* 8467C 80093E7C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84680 80093E80 6E9C030C */  jal        SPCH_AddEvent
    /* 84684 80093E84 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* 84688 80093E88 4000BF8F */  lw         $ra, 0x40($sp)
    /* 8468C 80093E8C 00000000 */  nop
    /* 84690 80093E90 0800E003 */  jr         $ra
    /* 84694 80093E94 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC
