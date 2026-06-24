.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12AIState_None, 0x34

glabel ___12AIState_None
    /* 4BC90 8005B490 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4BC94 8005B494 0580023C */  lui        $v0, %hi(D_80054E3C)
    /* 4BC98 8005B498 3C4E4224 */  addiu      $v0, $v0, %lo(D_80054E3C)
    /* 4BC9C 8005B49C 0100A530 */  andi       $a1, $a1, 0x1
    /* 4BCA0 8005B4A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4BCA4 8005B4A4 0300A010 */  beqz       $a1, .L8005B4B4
    /* 4BCA8 8005B4A8 040082AC */   sw        $v0, 0x4($a0)
    /* 4BCAC 8005B4AC 6B8F020C */  jal        __builtin_delete
    /* 4BCB0 8005B4B0 00000000 */   nop
  .L8005B4B4:
    /* 4BCB4 8005B4B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4BCB8 8005B4B8 00000000 */  nop
    /* 4BCBC 8005B4BC 0800E003 */  jr         $ra
    /* 4BCC0 8005B4C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12AIState_None
