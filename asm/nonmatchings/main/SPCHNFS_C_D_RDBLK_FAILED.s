.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_RDBLK_FAILED, 0x58

glabel SPCHNFS_C_D_RDBLK_FAILED
    /* 83DE0 800935E0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83DE4 800935E4 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83DE8 800935E8 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83DEC 800935EC 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800935F0:
    /* 83DF0 800935F0 000040AC */  sw         $zero, 0x0($v0)
    /* 83DF4 800935F4 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83DF8 800935F8 FDFF6104 */  bgez       $v1, .L800935F0
    /* 83DFC 800935FC FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83E00 80093600 6D010224 */  addiu      $v0, $zero, 0x16D
    /* 83E04 80093604 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83E08 80093608 0000828C */  lw         $v0, 0x0($a0)
    /* 83E0C 8009360C 00000000 */  nop
    /* 83E10 80093610 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83E14 80093614 0000A28C */  lw         $v0, 0x0($a1)
    /* 83E18 80093618 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83E1C 8009361C 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83E20 80093620 6E9C030C */  jal        SPCH_AddEvent
    /* 83E24 80093624 1800A2AF */   sw        $v0, 0x18($sp)
    /* 83E28 80093628 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83E2C 8009362C 00000000 */  nop
    /* 83E30 80093630 0800E003 */  jr         $ra
    /* 83E34 80093634 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_RDBLK_FAILED
