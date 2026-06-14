.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_TrafficStartUp__Fv, 0x9C

glabel AI_TrafficStartUp__Fv
    /* 5770C 80066F0C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 57710 80066F10 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 57714 80066F14 7800B0AF */  sw         $s0, 0x78($sp)
    /* 57718 80066F18 EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* 5771C 80066F1C 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* 57720 80066F20 1800028E */  lw         $v0, 0x18($s0)
    /* 57724 80066F24 00000000 */  nop
    /* 57728 80066F28 1B004010 */  beqz       $v0, .L80066F98
    /* 5772C 80066F2C 00000000 */   nop
    /* 57730 80066F30 578F020C */  jal        __builtin_new
    /* 57734 80066F34 4C030424 */   addiu     $a0, $zero, 0x34C
    /* 57738 80066F38 1000A427 */  addiu      $a0, $sp, 0x10
    /* 5773C 80066F3C 0580053C */  lui        $a1, %hi(D_8005521C)
    /* 57740 80066F40 1180033C */  lui        $v1, %hi(D_801164B0)
    /* 57744 80066F44 B064668C */  lw         $a2, %lo(D_801164B0)($v1)
    /* 57748 80066F48 3C00078E */  lw         $a3, 0x3C($s0)
    /* 5774C 80066F4C 1480013C */  lui        $at, %hi(triggerManagerTraffic)
    /* 57750 80066F50 ECC522AC */  sw         $v0, %lo(triggerManagerTraffic)($at)
    /* 57754 80066F54 2F91030C */  jal        sprintf
    /* 57758 80066F58 1C52A524 */   addiu     $a1, $a1, %lo(D_8005521C)
    /* 5775C 80066F5C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 57760 80066F60 EA95030C */  jal        loadfileadrz
    /* 57764 80066F64 21280000 */   addu      $a1, $zero, $zero
    /* 57768 80066F68 300082AF */  sw         $v0, %gp_rel(AITraffic_rawTriggers)($gp)
    /* 5776C 80066F6C 05004010 */  beqz       $v0, .L80066F84
    /* 57770 80066F70 21284000 */   addu      $a1, $v0, $zero
    /* 57774 80066F74 1480043C */  lui        $a0, %hi(triggerManagerTraffic)
    /* 57778 80066F78 ECC5848C */  lw         $a0, %lo(triggerManagerTraffic)($a0)
    /* 5777C 80066F7C E49B0108 */  j          .L80066F90
    /* 57780 80066F80 00000000 */   nop
  .L80066F84:
    /* 57784 80066F84 1480043C */  lui        $a0, %hi(triggerManagerTraffic)
    /* 57788 80066F88 ECC5848C */  lw         $a0, %lo(triggerManagerTraffic)($a0)
    /* 5778C 80066F8C 21280000 */  addu       $a1, $zero, $zero
  .L80066F90:
    /* 57790 80066F90 1BCA010C */  jal        Init__24AITrigger_TriggerManagerPc
    /* 57794 80066F94 00000000 */   nop
  .L80066F98:
    /* 57798 80066F98 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* 5779C 80066F9C 7800B08F */  lw         $s0, 0x78($sp)
    /* 577A0 80066FA0 0800E003 */  jr         $ra
    /* 577A4 80066FA4 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel AI_TrafficStartUp__Fv
