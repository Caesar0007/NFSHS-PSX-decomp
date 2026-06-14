.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_TrafficCleanUp__Fv, 0x50

glabel AI_TrafficCleanUp__Fv
    /* 577A8 80066FA8 1480043C */  lui        $a0, %hi(triggerManagerTraffic)
    /* 577AC 80066FAC ECC5848C */  lw         $a0, %lo(triggerManagerTraffic)($a0)
    /* 577B0 80066FB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 577B4 80066FB4 05008010 */  beqz       $a0, .L80066FCC
    /* 577B8 80066FB8 1000BFAF */   sw        $ra, 0x10($sp)
    /* 577BC 80066FBC 6B8F020C */  jal        __builtin_delete
    /* 577C0 80066FC0 00000000 */   nop
    /* 577C4 80066FC4 1480013C */  lui        $at, %hi(triggerManagerTraffic)
    /* 577C8 80066FC8 ECC520AC */  sw         $zero, %lo(triggerManagerTraffic)($at)
  .L80066FCC:
    /* 577CC 80066FCC 3000848F */  lw         $a0, %gp_rel(AITraffic_rawTriggers)($gp)
    /* 577D0 80066FD0 00000000 */  nop
    /* 577D4 80066FD4 04008010 */  beqz       $a0, .L80066FE8
    /* 577D8 80066FD8 00000000 */   nop
    /* 577DC 80066FDC 5095030C */  jal        purgememadr
    /* 577E0 80066FE0 00000000 */   nop
    /* 577E4 80066FE4 300080AF */  sw         $zero, %gp_rel(AITraffic_rawTriggers)($gp)
  .L80066FE8:
    /* 577E8 80066FE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 577EC 80066FEC 00000000 */  nop
    /* 577F0 80066FF0 0800E003 */  jr         $ra
    /* 577F4 80066FF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_TrafficCleanUp__Fv
