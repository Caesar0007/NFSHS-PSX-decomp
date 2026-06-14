.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY, 0x94

glabel SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY
    /* 83864 80093064 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83868 80093068 4000BFAF */  sw         $ra, 0x40($sp)
    /* 8386C 8009306C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83870 80093070 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093074:
    /* 83874 80093074 000040AC */  sw         $zero, 0x0($v0)
    /* 83878 80093078 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8387C 8009307C FDFF6104 */  bgez       $v1, .L80093074
    /* 83880 80093080 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83884 80093084 55010224 */  addiu      $v0, $zero, 0x155
    /* 83888 80093088 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8388C 8009308C 0000828C */  lw         $v0, 0x0($a0)
    /* 83890 80093090 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83894 80093094 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83898 80093098 0000C28C */  lw         $v0, 0x0($a2)
    /* 8389C 8009309C 00000000 */  nop
    /* 838A0 800930A0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 838A4 800930A4 5800A28F */  lw         $v0, 0x58($sp)
    /* 838A8 800930A8 2000A7AF */  sw         $a3, 0x20($sp)
    /* 838AC 800930AC 0000428C */  lw         $v0, 0x0($v0)
    /* 838B0 800930B0 00000000 */  nop
    /* 838B4 800930B4 2400A2AF */  sw         $v0, 0x24($sp)
    /* 838B8 800930B8 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 838BC 800930BC 00000000 */  nop
    /* 838C0 800930C0 0000438C */  lw         $v1, 0x0($v0)
    /* 838C4 800930C4 6000A28F */  lw         $v0, 0x60($sp)
    /* 838C8 800930C8 00000000 */  nop
    /* 838CC 800930CC 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 838D0 800930D0 6400A28F */  lw         $v0, 0x64($sp)
    /* 838D4 800930D4 2800A3AF */  sw         $v1, 0x28($sp)
    /* 838D8 800930D8 0000428C */  lw         $v0, 0x0($v0)
    /* 838DC 800930DC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 838E0 800930E0 6E9C030C */  jal        SPCH_AddEvent
    /* 838E4 800930E4 3000A2AF */   sw        $v0, 0x30($sp)
    /* 838E8 800930E8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 838EC 800930EC 00000000 */  nop
    /* 838F0 800930F0 0800E003 */  jr         $ra
    /* 838F4 800930F4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY
