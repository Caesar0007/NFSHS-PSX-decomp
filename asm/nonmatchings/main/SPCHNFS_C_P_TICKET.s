.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_P_TICKET, 0x54

glabel SPCHNFS_C_P_TICKET
    /* 84390 80093B90 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84394 80093B94 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84398 80093B98 0B000324 */  addiu      $v1, $zero, 0xB
    /* 8439C 80093B9C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093BA0:
    /* 843A0 80093BA0 000040AC */  sw         $zero, 0x0($v0)
    /* 843A4 80093BA4 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 843A8 80093BA8 FDFF6104 */  bgez       $v1, .L80093BA0
    /* 843AC 80093BAC FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 843B0 80093BB0 89010224 */  addiu      $v0, $zero, 0x189
    /* 843B4 80093BB4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 843B8 80093BB8 0000828C */  lw         $v0, 0x0($a0)
    /* 843BC 80093BBC 00000000 */  nop
    /* 843C0 80093BC0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 843C4 80093BC4 0000A28C */  lw         $v0, 0x0($a1)
    /* 843C8 80093BC8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 843CC 80093BCC 6E9C030C */  jal        SPCH_AddEvent
    /* 843D0 80093BD0 1800A2AF */   sw        $v0, 0x18($sp)
    /* 843D4 80093BD4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 843D8 80093BD8 00000000 */  nop
    /* 843DC 80093BDC 0800E003 */  jr         $ra
    /* 843E0 80093BE0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_P_TICKET
