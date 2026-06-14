.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AICop_Restart__Fv, 0x50

glabel AICop_Restart__Fv
    /* 57258 80066A58 2400858F */  lw         $a1, %gp_rel(AICop_rawTriggers)($gp)
    /* 5725C 80066A5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57260 80066A60 0A00A010 */  beqz       $a1, .L80066A8C
    /* 57264 80066A64 1000BFAF */   sw        $ra, 0x10($sp)
    /* 57268 80066A68 1180023C */  lui        $v0, %hi(D_80113200)
    /* 5726C 80066A6C 0032428C */  lw         $v0, %lo(D_80113200)($v0)
    /* 57270 80066A70 00000000 */  nop
    /* 57274 80066A74 05004010 */  beqz       $v0, .L80066A8C
    /* 57278 80066A78 00000000 */   nop
    /* 5727C 80066A7C 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 57280 80066A80 E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 57284 80066A84 1BCA010C */  jal        Init__24AITrigger_TriggerManagerPc
    /* 57288 80066A88 00000000 */   nop
  .L80066A8C:
    /* 5728C 80066A8C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 57290 80066A90 1180023C */  lui        $v0, %hi(AICop_spikeBelt)
    /* 57294 80066A94 4CD540AC */  sw         $zero, %lo(AICop_spikeBelt)($v0)
    /* 57298 80066A98 2C0080AF */  sw         $zero, %gp_rel(AICop_numArrestedHumans)($gp)
    /* 5729C 80066A9C 280080AF */  sw         $zero, %gp_rel(AICop_gRoadBlockState)($gp)
    /* 572A0 80066AA0 0800E003 */  jr         $ra
    /* 572A4 80066AA4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AICop_Restart__Fv
