.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_DURING_FALSE_ARREST, 0x54

glabel SPCHNFS_C_D_DURING_FALSE_ARREST
    /* 8442C 80093C2C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84430 80093C30 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84434 80093C34 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84438 80093C38 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093C3C:
    /* 8443C 80093C3C 000040AC */  sw         $zero, 0x0($v0)
    /* 84440 80093C40 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84444 80093C44 FDFF6104 */  bgez       $v1, .L80093C3C
    /* 84448 80093C48 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8444C 80093C4C 8B010224 */  addiu      $v0, $zero, 0x18B
    /* 84450 80093C50 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84454 80093C54 0000828C */  lw         $v0, 0x0($a0)
    /* 84458 80093C58 00000000 */  nop
    /* 8445C 80093C5C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84460 80093C60 0000A28C */  lw         $v0, 0x0($a1)
    /* 84464 80093C64 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84468 80093C68 6E9C030C */  jal        SPCH_AddEvent
    /* 8446C 80093C6C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 84470 80093C70 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84474 80093C74 00000000 */  nop
    /* 84478 80093C78 0800E003 */  jr         $ra
    /* 8447C 80093C7C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_DURING_FALSE_ARREST
