.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY, 0x48

glabel SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY
    /* 83CF0 800934F0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83CF4 800934F4 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83CF8 800934F8 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83CFC 800934FC 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093500:
    /* 83D00 80093500 000040AC */  sw         $zero, 0x0($v0)
    /* 83D04 80093504 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83D08 80093508 FDFF6104 */  bgez       $v1, .L80093500
    /* 83D0C 8009350C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83D10 80093510 68010224 */  addiu      $v0, $zero, 0x168
    /* 83D14 80093514 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83D18 80093518 0000828C */  lw         $v0, 0x0($a0)
    /* 83D1C 8009351C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83D20 80093520 6E9C030C */  jal        SPCH_AddEvent
    /* 83D24 80093524 1400A2AF */   sw        $v0, 0x14($sp)
    /* 83D28 80093528 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83D2C 8009352C 00000000 */  nop
    /* 83D30 80093530 0800E003 */  jr         $ra
    /* 83D34 80093534 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY
