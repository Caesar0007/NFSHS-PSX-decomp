.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIState_Cruise, 0x34

glabel ___14AIState_Cruise
    /* 62E5C 8007265C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62E60 80072660 0580023C */  lui        $v0, %hi(D_80055640)
    /* 62E64 80072664 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62E68 80072668 0100A530 */  andi       $a1, $a1, 0x1
    /* 62E6C 8007266C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62E70 80072670 0300A010 */  beqz       $a1, .L80072680
    /* 62E74 80072674 040082AC */   sw        $v0, 0x4($a0)
    /* 62E78 80072678 6B8F020C */  jal        __builtin_delete
    /* 62E7C 8007267C 00000000 */   nop
  .L80072680:
    /* 62E80 80072680 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62E84 80072684 00000000 */  nop
    /* 62E88 80072688 0800E003 */  jr         $ra
    /* 62E8C 8007268C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14AIState_Cruise
