.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_RDBLK_CONFIRMED, 0x54

glabel SPCHNFS_D_C_RDBLK_CONFIRMED
    /* 83D8C 8009358C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83D90 80093590 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83D94 80093594 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83D98 80093598 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009359C:
    /* 83D9C 8009359C 000040AC */  sw         $zero, 0x0($v0)
    /* 83DA0 800935A0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83DA4 800935A4 FDFF6104 */  bgez       $v1, .L8009359C
    /* 83DA8 800935A8 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83DAC 800935AC 6A010224 */  addiu      $v0, $zero, 0x16A
    /* 83DB0 800935B0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83DB4 800935B4 0000828C */  lw         $v0, 0x0($a0)
    /* 83DB8 800935B8 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83DBC 800935BC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83DC0 800935C0 0000C28C */  lw         $v0, 0x0($a2)
    /* 83DC4 800935C4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83DC8 800935C8 6E9C030C */  jal        SPCH_AddEvent
    /* 83DCC 800935CC 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 83DD0 800935D0 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83DD4 800935D4 00000000 */  nop
    /* 83DD8 800935D8 0800E003 */  jr         $ra
    /* 83DDC 800935DC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_RDBLK_CONFIRMED
