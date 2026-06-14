.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_PERP_LOST, 0x88

glabel SPCHNFS_C_D_PERP_LOST
    /* 8406C 8009386C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84070 80093870 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84074 80093874 0B000824 */  addiu      $t0, $zero, 0xB
    /* 84078 80093878 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009387C:
    /* 8407C 8009387C 000040AC */  sw         $zero, 0x0($v0)
    /* 84080 80093880 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 84084 80093884 FDFF0105 */  bgez       $t0, .L8009387C
    /* 84088 80093888 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8408C 8009388C 7A010224 */  addiu      $v0, $zero, 0x17A
    /* 84090 80093890 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84094 80093894 0000828C */  lw         $v0, 0x0($a0)
    /* 84098 80093898 00000000 */  nop
    /* 8409C 8009389C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 840A0 800938A0 0000A28C */  lw         $v0, 0x0($a1)
    /* 840A4 800938A4 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 840A8 800938A8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 840AC 800938AC 5800A28F */  lw         $v0, 0x58($sp)
    /* 840B0 800938B0 0000E38C */  lw         $v1, 0x0($a3)
    /* 840B4 800938B4 2400A2AF */  sw         $v0, 0x24($sp)
    /* 840B8 800938B8 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 840BC 800938BC 2000A3AF */  sw         $v1, 0x20($sp)
    /* 840C0 800938C0 0000428C */  lw         $v0, 0x0($v0)
    /* 840C4 800938C4 00000000 */  nop
    /* 840C8 800938C8 2800A2AF */  sw         $v0, 0x28($sp)
    /* 840CC 800938CC 6000A28F */  lw         $v0, 0x60($sp)
    /* 840D0 800938D0 00000000 */  nop
    /* 840D4 800938D4 0000428C */  lw         $v0, 0x0($v0)
    /* 840D8 800938D8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 840DC 800938DC 6E9C030C */  jal        SPCH_AddEvent
    /* 840E0 800938E0 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* 840E4 800938E4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 840E8 800938E8 00000000 */  nop
    /* 840EC 800938EC 0800E003 */  jr         $ra
    /* 840F0 800938F0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_PERP_LOST
