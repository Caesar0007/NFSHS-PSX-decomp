.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_S_C_SUPER_COP_ARRIVAL, 0x48

glabel SPCHNFS_S_C_SUPER_COP_ARRIVAL
    /* 844C8 80093CC8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 844CC 80093CCC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 844D0 80093CD0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 844D4 80093CD4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093CD8:
    /* 844D8 80093CD8 000040AC */  sw         $zero, 0x0($v0)
    /* 844DC 80093CDC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 844E0 80093CE0 FDFF6104 */  bgez       $v1, .L80093CD8
    /* 844E4 80093CE4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 844E8 80093CE8 8E010224 */  addiu      $v0, $zero, 0x18E
    /* 844EC 80093CEC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 844F0 80093CF0 0000828C */  lw         $v0, 0x0($a0)
    /* 844F4 80093CF4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 844F8 80093CF8 6E9C030C */  jal        SPCH_AddEvent
    /* 844FC 80093CFC 1400A2AF */   sw        $v0, 0x14($sp)
    /* 84500 80093D00 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84504 80093D04 00000000 */  nop
    /* 84508 80093D08 0800E003 */  jr         $ra
    /* 8450C 80093D0C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_S_C_SUPER_COP_ARRIVAL
