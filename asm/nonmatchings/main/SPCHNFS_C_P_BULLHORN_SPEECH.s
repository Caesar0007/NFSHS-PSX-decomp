.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_P_BULLHORN_SPEECH, 0x48

glabel SPCHNFS_C_P_BULLHORN_SPEECH
    /* 84480 80093C80 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84484 80093C84 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84488 80093C88 0B000324 */  addiu      $v1, $zero, 0xB
    /* 8448C 80093C8C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093C90:
    /* 84490 80093C90 000040AC */  sw         $zero, 0x0($v0)
    /* 84494 80093C94 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84498 80093C98 FDFF6104 */  bgez       $v1, .L80093C90
    /* 8449C 80093C9C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 844A0 80093CA0 8D010224 */  addiu      $v0, $zero, 0x18D
    /* 844A4 80093CA4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 844A8 80093CA8 0000828C */  lw         $v0, 0x0($a0)
    /* 844AC 80093CAC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 844B0 80093CB0 6E9C030C */  jal        SPCH_AddEvent
    /* 844B4 80093CB4 1400A2AF */   sw        $v0, 0x14($sp)
    /* 844B8 80093CB8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 844BC 80093CBC 00000000 */  nop
    /* 844C0 80093CC0 0800E003 */  jr         $ra
    /* 844C4 80093CC4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_P_BULLHORN_SPEECH
