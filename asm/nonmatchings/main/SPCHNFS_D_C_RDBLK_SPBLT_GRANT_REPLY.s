.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY, 0x54

glabel SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY
    /* 83D38 80093538 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83D3C 8009353C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83D40 80093540 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83D44 80093544 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093548:
    /* 83D48 80093548 000040AC */  sw         $zero, 0x0($v0)
    /* 83D4C 8009354C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83D50 80093550 FDFF6104 */  bgez       $v1, .L80093548
    /* 83D54 80093554 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83D58 80093558 69010224 */  addiu      $v0, $zero, 0x169
    /* 83D5C 8009355C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83D60 80093560 0000828C */  lw         $v0, 0x0($a0)
    /* 83D64 80093564 00000000 */  nop
    /* 83D68 80093568 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83D6C 8009356C 0000A28C */  lw         $v0, 0x0($a1)
    /* 83D70 80093570 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83D74 80093574 6E9C030C */  jal        SPCH_AddEvent
    /* 83D78 80093578 1800A2AF */   sw        $v0, 0x18($sp)
    /* 83D7C 8009357C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83D80 80093580 00000000 */  nop
    /* 83D84 80093584 0800E003 */  jr         $ra
    /* 83D88 80093588 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY
