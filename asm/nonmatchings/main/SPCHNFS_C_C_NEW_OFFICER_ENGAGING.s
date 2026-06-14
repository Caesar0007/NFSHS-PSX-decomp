.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_C_NEW_OFFICER_ENGAGING, 0x4C

glabel SPCHNFS_C_C_NEW_OFFICER_ENGAGING
    /* 83F48 80093748 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83F4C 8009374C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83F50 80093750 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83F54 80093754 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093758:
    /* 83F58 80093758 000040AC */  sw         $zero, 0x0($v0)
    /* 83F5C 8009375C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83F60 80093760 FDFF6104 */  bgez       $v1, .L80093758
    /* 83F64 80093764 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83F68 80093768 77010224 */  addiu      $v0, $zero, 0x177
    /* 83F6C 8009376C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83F70 80093770 0000828C */  lw         $v0, 0x0($a0)
    /* 83F74 80093774 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83F78 80093778 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83F7C 8009377C 6E9C030C */  jal        SPCH_AddEvent
    /* 83F80 80093780 1400A2AF */   sw        $v0, 0x14($sp)
    /* 83F84 80093784 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83F88 80093788 00000000 */  nop
    /* 83F8C 8009378C 0800E003 */  jr         $ra
    /* 83F90 80093790 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_C_NEW_OFFICER_ENGAGING
