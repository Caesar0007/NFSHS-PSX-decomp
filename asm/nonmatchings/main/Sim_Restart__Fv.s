.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_Restart__Fv, 0xCC

glabel Sim_Restart__Fv
    /* A6E88 800B6688 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6E8C 800B668C 01000224 */  addiu      $v0, $zero, 0x1
    /* A6E90 800B6690 E40E82AF */  sw         $v0, %gp_rel(quitType)($gp)
    /* A6E94 800B6694 1280023C */  lui        $v0, %hi(simVar)
    /* A6E98 800B6698 C4E04224 */  addiu      $v0, $v0, %lo(simVar)
    /* A6E9C 800B669C 1000B0AF */  sw         $s0, 0x10($sp)
    /* A6EA0 800B66A0 1280103C */  lui        $s0, %hi(simGlobal)
    /* A6EA4 800B66A4 1400BFAF */  sw         $ra, 0x14($sp)
    /* A6EA8 800B66A8 040040AC */  sw         $zero, 0x4($v0)
    /* A6EAC 800B66AC 080040AC */  sw         $zero, 0x8($v0)
    /* A6EB0 800B66B0 100040AC */  sw         $zero, 0x10($v0)
    /* A6EB4 800B66B4 140040AC */  sw         $zero, 0x14($v0)
    /* A6EB8 800B66B8 180040AC */  sw         $zero, 0x18($v0)
    /* A6EBC 800B66BC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A6EC0 800B66C0 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A6EC4 800B66C4 ACE000AE */  sw         $zero, %lo(simGlobal)($s0)
    /* A6EC8 800B66C8 5800448C */  lw         $a0, 0x58($v0)
    /* A6ECC 800B66CC ACE01026 */  addiu      $s0, $s0, %lo(simGlobal)
    /* A6ED0 800B66D0 1480013C */  lui        $at, %hi(countdown)
    /* A6ED4 800B66D4 3CC620A0 */  sb         $zero, %lo(countdown)($at)
    /* A6ED8 800B66D8 040000AE */  sw         $zero, 0x4($s0)
    /* A6EDC 800B66DC F46C020C */  jal        FastRandom_StartUp__FUi
    /* A6EE0 800B66E0 B40140AC */   sw        $zero, 0x1B4($v0)
    /* A6EE4 800B66E4 969A010C */  jal        AICop_Restart__Fv
    /* A6EE8 800B66E8 00000000 */   nop
    /* A6EEC 800B66EC 3F9B010C */  jal        AIInit_Reset1__Fv
    /* A6EF0 800B66F0 00000000 */   nop
    /* A6EF4 800B66F4 B2B7020C */  jal        R3DCar_Restart__Fv
    /* A6EF8 800B66F8 00000000 */   nop
    /* A6EFC 800B66FC 4F6C010C */  jal        AIHigh_Restart1__Fv
    /* A6F00 800B6700 00000000 */   nop
    /* A6F04 800B6704 3329020C */  jal        Cars_Restart__Fv
    /* A6F08 800B6708 00000000 */   nop
    /* A6F0C 800B670C 576C010C */  jal        AIHigh_Restart2__Fv
    /* A6F10 800B6710 00000000 */   nop
    /* A6F14 800B6714 429B010C */  jal        AIInit_Reset2__Fv
    /* A6F18 800B6718 00000000 */   nop
    /* A6F1C 800B671C FC65030C */  jal        Hud_Reset__Fv
    /* A6F20 800B6720 00000000 */   nop
    /* A6F24 800B6724 EBCD020C */  jal        Render_RestartTrackRender__Fv
    /* A6F28 800B6728 00000000 */   nop
    /* A6F2C 800B672C C6DC020C */  jal        SimQueue_Reset__Fv
    /* A6F30 800B6730 00000000 */   nop
    /* A6F34 800B6734 1480023C */  lui        $v0, %hi(Input_gTime)
    /* A6F38 800B6738 20D2428C */  lw         $v0, %lo(Input_gTime)($v0)
    /* A6F3C 800B673C 00000000 */  nop
    /* A6F40 800B6740 080002AE */  sw         $v0, 0x8($s0)
    /* A6F44 800B6744 1400BF8F */  lw         $ra, 0x14($sp)
    /* A6F48 800B6748 1000B08F */  lw         $s0, 0x10($sp)
    /* A6F4C 800B674C 0800E003 */  jr         $ra
    /* A6F50 800B6750 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sim_Restart__Fv
