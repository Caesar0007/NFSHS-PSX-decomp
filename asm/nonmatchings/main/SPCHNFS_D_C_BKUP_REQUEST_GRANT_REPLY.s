.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY, 0x5C

glabel SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY
    /* 83EAC 800936AC B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83EB0 800936B0 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83EB4 800936B4 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83EB8 800936B8 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800936BC:
    /* 83EBC 800936BC 000040AC */  sw         $zero, 0x0($v0)
    /* 83EC0 800936C0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83EC4 800936C4 FDFF6104 */  bgez       $v1, .L800936BC
    /* 83EC8 800936C8 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83ECC 800936CC 72010224 */  addiu      $v0, $zero, 0x172
    /* 83ED0 800936D0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83ED4 800936D4 0000828C */  lw         $v0, 0x0($a0)
    /* 83ED8 800936D8 00000000 */  nop
    /* 83EDC 800936DC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83EE0 800936E0 0000A28C */  lw         $v0, 0x0($a1)
    /* 83EE4 800936E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83EE8 800936E8 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83EEC 800936EC 2000A7AF */  sw         $a3, 0x20($sp)
    /* 83EF0 800936F0 6E9C030C */  jal        SPCH_AddEvent
    /* 83EF4 800936F4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 83EF8 800936F8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83EFC 800936FC 00000000 */  nop
    /* 83F00 80093700 0800E003 */  jr         $ra
    /* 83F04 80093704 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY
