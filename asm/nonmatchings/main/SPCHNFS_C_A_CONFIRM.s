.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_A_CONFIRM, 0x54

glabel SPCHNFS_C_A_CONFIRM
    /* 83754 80092F54 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83758 80092F58 4000BFAF */  sw         $ra, 0x40($sp)
    /* 8375C 80092F5C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83760 80092F60 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80092F64:
    /* 83764 80092F64 000040AC */  sw         $zero, 0x0($v0)
    /* 83768 80092F68 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8376C 80092F6C FDFF6104 */  bgez       $v1, .L80092F64
    /* 83770 80092F70 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83774 80092F74 51010224 */  addiu      $v0, $zero, 0x151
    /* 83778 80092F78 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8377C 80092F7C 0000828C */  lw         $v0, 0x0($a0)
    /* 83780 80092F80 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83784 80092F84 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83788 80092F88 0000C28C */  lw         $v0, 0x0($a2)
    /* 8378C 80092F8C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83790 80092F90 6E9C030C */  jal        SPCH_AddEvent
    /* 83794 80092F94 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 83798 80092F98 4000BF8F */  lw         $ra, 0x40($sp)
    /* 8379C 80092F9C 00000000 */  nop
    /* 837A0 80092FA0 0800E003 */  jr         $ra
    /* 837A4 80092FA4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_A_CONFIRM
