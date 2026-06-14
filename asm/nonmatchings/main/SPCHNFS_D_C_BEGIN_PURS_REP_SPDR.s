.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_BEGIN_PURS_REP_SPDR, 0x68

glabel SPCHNFS_D_C_BEGIN_PURS_REP_SPDR
    /* 837FC 80092FFC B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83800 80093000 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83804 80093004 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83808 80093008 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009300C:
    /* 8380C 8009300C 000040AC */  sw         $zero, 0x0($v0)
    /* 83810 80093010 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83814 80093014 FDFF6104 */  bgez       $v1, .L8009300C
    /* 83818 80093018 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8381C 8009301C 54010224 */  addiu      $v0, $zero, 0x154
    /* 83820 80093020 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83824 80093024 0000828C */  lw         $v0, 0x0($a0)
    /* 83828 80093028 1800A5AF */  sw         $a1, 0x18($sp)
    /* 8382C 8009302C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83830 80093030 0000C28C */  lw         $v0, 0x0($a2)
    /* 83834 80093034 00000000 */  nop
    /* 83838 80093038 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 8383C 8009303C 5800A28F */  lw         $v0, 0x58($sp)
    /* 83840 80093040 2000A7AF */  sw         $a3, 0x20($sp)
    /* 83844 80093044 0000428C */  lw         $v0, 0x0($v0)
    /* 83848 80093048 1000A427 */  addiu      $a0, $sp, 0x10
    /* 8384C 8009304C 6E9C030C */  jal        SPCH_AddEvent
    /* 83850 80093050 2400A2AF */   sw        $v0, 0x24($sp)
    /* 83854 80093054 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83858 80093058 00000000 */  nop
    /* 8385C 8009305C 0800E003 */  jr         $ra
    /* 83860 80093060 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_BEGIN_PURS_REP_SPDR
