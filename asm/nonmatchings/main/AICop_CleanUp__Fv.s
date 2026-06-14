.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AICop_CleanUp__Fv, 0x60

glabel AICop_CleanUp__Fv
    /* 572A8 80066AA8 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 572AC 80066AAC E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 572B0 80066AB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 572B4 80066AB4 05008010 */  beqz       $a0, .L80066ACC
    /* 572B8 80066AB8 1000BFAF */   sw        $ra, 0x10($sp)
    /* 572BC 80066ABC 6B8F020C */  jal        __builtin_delete
    /* 572C0 80066AC0 00000000 */   nop
    /* 572C4 80066AC4 1480013C */  lui        $at, %hi(triggerManagerCops)
    /* 572C8 80066AC8 E8C520AC */  sw         $zero, %lo(triggerManagerCops)($at)
  .L80066ACC:
    /* 572CC 80066ACC 2400848F */  lw         $a0, %gp_rel(AICop_rawTriggers)($gp)
    /* 572D0 80066AD0 00000000 */  nop
    /* 572D4 80066AD4 08008010 */  beqz       $a0, .L80066AF8
    /* 572D8 80066AD8 1180023C */   lui       $v0, %hi(D_80113200)
    /* 572DC 80066ADC 0032428C */  lw         $v0, %lo(D_80113200)($v0)
    /* 572E0 80066AE0 00000000 */  nop
    /* 572E4 80066AE4 04004010 */  beqz       $v0, .L80066AF8
    /* 572E8 80066AE8 00000000 */   nop
    /* 572EC 80066AEC 5095030C */  jal        purgememadr
    /* 572F0 80066AF0 00000000 */   nop
    /* 572F4 80066AF4 240080AF */  sw         $zero, %gp_rel(AICop_rawTriggers)($gp)
  .L80066AF8:
    /* 572F8 80066AF8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 572FC 80066AFC 00000000 */  nop
    /* 57300 80066B00 0800E003 */  jr         $ra
    /* 57304 80066B04 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AICop_CleanUp__Fv
