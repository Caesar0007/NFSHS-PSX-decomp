.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_P_ARRESTED, 0x54

glabel SPCHNFS_C_P_ARRESTED
    /* 842E8 80093AE8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 842EC 80093AEC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 842F0 80093AF0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 842F4 80093AF4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093AF8:
    /* 842F8 80093AF8 000040AC */  sw         $zero, 0x0($v0)
    /* 842FC 80093AFC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84300 80093B00 FDFF6104 */  bgez       $v1, .L80093AF8
    /* 84304 80093B04 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84308 80093B08 87010224 */  addiu      $v0, $zero, 0x187
    /* 8430C 80093B0C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84310 80093B10 0000828C */  lw         $v0, 0x0($a0)
    /* 84314 80093B14 00000000 */  nop
    /* 84318 80093B18 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8431C 80093B1C 0000A28C */  lw         $v0, 0x0($a1)
    /* 84320 80093B20 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84324 80093B24 6E9C030C */  jal        SPCH_AddEvent
    /* 84328 80093B28 1800A2AF */   sw        $v0, 0x18($sp)
    /* 8432C 80093B2C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84330 80093B30 00000000 */  nop
    /* 84334 80093B34 0800E003 */  jr         $ra
    /* 84338 80093B38 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_P_ARRESTED
