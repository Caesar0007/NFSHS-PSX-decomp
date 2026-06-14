.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_W_D_SPBLT_PLC, 0x78

glabel SPCHNFS_W_D_SPBLT_PLC
    /* 8496C 8009416C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84970 80094170 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84974 80094174 0B000824 */  addiu      $t0, $zero, 0xB
    /* 84978 80094178 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009417C:
    /* 8497C 8009417C 000040AC */  sw         $zero, 0x0($v0)
    /* 84980 80094180 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 84984 80094184 FDFF0105 */  bgez       $t0, .L8009417C
    /* 84988 80094188 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8498C 8009418C AC010224 */  addiu      $v0, $zero, 0x1AC
    /* 84990 80094190 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84994 80094194 0000828C */  lw         $v0, 0x0($a0)
    /* 84998 80094198 00000000 */  nop
    /* 8499C 8009419C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 849A0 800941A0 0000A28C */  lw         $v0, 0x0($a1)
    /* 849A4 800941A4 00000000 */  nop
    /* 849A8 800941A8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 849AC 800941AC 5800A28F */  lw         $v0, 0x58($sp)
    /* 849B0 800941B0 0000C38C */  lw         $v1, 0x0($a2)
    /* 849B4 800941B4 2400A2AF */  sw         $v0, 0x24($sp)
    /* 849B8 800941B8 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 849BC 800941BC 2000A7AF */  sw         $a3, 0x20($sp)
    /* 849C0 800941C0 1C00A3AF */  sw         $v1, 0x1C($sp)
    /* 849C4 800941C4 0000428C */  lw         $v0, 0x0($v0)
    /* 849C8 800941C8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 849CC 800941CC 6E9C030C */  jal        SPCH_AddEvent
    /* 849D0 800941D0 2800A2AF */   sw        $v0, 0x28($sp)
    /* 849D4 800941D4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 849D8 800941D8 00000000 */  nop
    /* 849DC 800941DC 0800E003 */  jr         $ra
    /* 849E0 800941E0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_W_D_SPBLT_PLC
