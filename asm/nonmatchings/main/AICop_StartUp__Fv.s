.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AICop_StartUp__Fv, 0xAC

glabel AICop_StartUp__Fv
    /* 571AC 800669AC 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 571B0 800669B0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 571B4 800669B4 7800B0AF */  sw         $s0, 0x78($sp)
    /* 571B8 800669B8 EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* 571BC 800669BC 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* 571C0 800669C0 1400028E */  lw         $v0, 0x14($s0)
    /* 571C4 800669C4 00000000 */  nop
    /* 571C8 800669C8 1B004010 */  beqz       $v0, .L80066A38
    /* 571CC 800669CC 00000000 */   nop
    /* 571D0 800669D0 578F020C */  jal        __builtin_new
    /* 571D4 800669D4 4C030424 */   addiu     $a0, $zero, 0x34C
    /* 571D8 800669D8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 571DC 800669DC 0580053C */  lui        $a1, %hi(D_80055200)
    /* 571E0 800669E0 1180033C */  lui        $v1, %hi(D_801164C0)
    /* 571E4 800669E4 C064668C */  lw         $a2, %lo(D_801164C0)($v1)
    /* 571E8 800669E8 3C00078E */  lw         $a3, 0x3C($s0)
    /* 571EC 800669EC 1480013C */  lui        $at, %hi(triggerManagerCops)
    /* 571F0 800669F0 E8C522AC */  sw         $v0, %lo(triggerManagerCops)($at)
    /* 571F4 800669F4 2F91030C */  jal        sprintf
    /* 571F8 800669F8 0052A524 */   addiu     $a1, $a1, %lo(D_80055200)
    /* 571FC 800669FC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 57200 80066A00 EA95030C */  jal        loadfileadrz
    /* 57204 80066A04 21280000 */   addu      $a1, $zero, $zero
    /* 57208 80066A08 240082AF */  sw         $v0, %gp_rel(AICop_rawTriggers)($gp)
    /* 5720C 80066A0C 05004010 */  beqz       $v0, .L80066A24
    /* 57210 80066A10 21284000 */   addu      $a1, $v0, $zero
    /* 57214 80066A14 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 57218 80066A18 E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 5721C 80066A1C 8C9A0108 */  j          .L80066A30
    /* 57220 80066A20 00000000 */   nop
  .L80066A24:
    /* 57224 80066A24 1480043C */  lui        $a0, %hi(triggerManagerCops)
    /* 57228 80066A28 E8C5848C */  lw         $a0, %lo(triggerManagerCops)($a0)
    /* 5722C 80066A2C 21280000 */  addu       $a1, $zero, $zero
  .L80066A30:
    /* 57230 80066A30 1BCA010C */  jal        Init__24AITrigger_TriggerManagerPc
    /* 57234 80066A34 00000000 */   nop
  .L80066A38:
    /* 57238 80066A38 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* 5723C 80066A3C 7800B08F */  lw         $s0, 0x78($sp)
    /* 57240 80066A40 1180023C */  lui        $v0, %hi(AICop_spikeBelt)
    /* 57244 80066A44 4CD540AC */  sw         $zero, %lo(AICop_spikeBelt)($v0)
    /* 57248 80066A48 2C0080AF */  sw         $zero, %gp_rel(AICop_numArrestedHumans)($gp)
    /* 5724C 80066A4C 280080AF */  sw         $zero, %gp_rel(AICop_gRoadBlockState)($gp)
    /* 57250 80066A50 0800E003 */  jr         $ra
    /* 57254 80066A54 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel AICop_StartUp__Fv
