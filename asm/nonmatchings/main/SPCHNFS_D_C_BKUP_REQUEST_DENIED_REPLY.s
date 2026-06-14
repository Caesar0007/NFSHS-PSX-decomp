.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY, 0x40

glabel SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY
    /* 83F08 80093708 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83F0C 8009370C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83F10 80093710 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83F14 80093714 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093718:
    /* 83F18 80093718 000040AC */  sw         $zero, 0x0($v0)
    /* 83F1C 8009371C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83F20 80093720 FDFF6104 */  bgez       $v1, .L80093718
    /* 83F24 80093724 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83F28 80093728 74010224 */  addiu      $v0, $zero, 0x174
    /* 83F2C 8009372C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83F30 80093730 6E9C030C */  jal        SPCH_AddEvent
    /* 83F34 80093734 1000A2AF */   sw        $v0, 0x10($sp)
    /* 83F38 80093738 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83F3C 8009373C 00000000 */  nop
    /* 83F40 80093740 0800E003 */  jr         $ra
    /* 83F44 80093744 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY
