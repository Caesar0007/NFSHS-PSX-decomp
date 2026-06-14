.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_REQUEST_EMS, 0x54

glabel SPCHNFS_C_D_REQUEST_EMS
    /* 837A8 80092FA8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 837AC 80092FAC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 837B0 80092FB0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 837B4 80092FB4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80092FB8:
    /* 837B8 80092FB8 000040AC */  sw         $zero, 0x0($v0)
    /* 837BC 80092FBC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 837C0 80092FC0 FDFF6104 */  bgez       $v1, .L80092FB8
    /* 837C4 80092FC4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 837C8 80092FC8 52010224 */  addiu      $v0, $zero, 0x152
    /* 837CC 80092FCC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 837D0 80092FD0 0000828C */  lw         $v0, 0x0($a0)
    /* 837D4 80092FD4 00000000 */  nop
    /* 837D8 80092FD8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 837DC 80092FDC 0000A28C */  lw         $v0, 0x0($a1)
    /* 837E0 80092FE0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 837E4 80092FE4 6E9C030C */  jal        SPCH_AddEvent
    /* 837E8 80092FE8 1800A2AF */   sw        $v0, 0x18($sp)
    /* 837EC 80092FEC 4000BF8F */  lw         $ra, 0x40($sp)
    /* 837F0 80092FF0 00000000 */  nop
    /* 837F4 80092FF4 0800E003 */  jr         $ra
    /* 837F8 80092FF8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_REQUEST_EMS
