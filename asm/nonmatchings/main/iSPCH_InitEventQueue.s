.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_InitEventQueue, 0x74

glabel iSPCH_InitEventQueue
    /* D7814 800E7014 21300000 */  addu       $a2, $zero, $zero
    /* D7818 800E7018 1580033C */  lui        $v1, %hi(gVoxEvents)
    /* D781C 800E701C 60806224 */  addiu      $v0, $v1, %lo(gVoxEvents)
    /* D7820 800E7020 21384000 */  addu       $a3, $v0, $zero
    /* D7824 800E7024 2120E000 */  addu       $a0, $a3, $zero
    /* D7828 800E7028 C0038824 */  addiu      $t0, $a0, 0x3C0
    /* D782C 800E702C 608060AC */  sw         $zero, %lo(gVoxEvents)($v1)
    /* D7830 800E7030 0400E0AC */  sw         $zero, 0x4($a3)
  .L800E7034:
    /* D7834 800E7034 21280000 */  addu       $a1, $zero, $zero
    /* D7838 800E7038 2118C000 */  addu       $v1, $a2, $zero
    /* D783C 800E703C 080080A4 */  sh         $zero, 0x8($a0)
    /* D7840 800E7040 0A0080A4 */  sh         $zero, 0xA($a0)
    /* D7844 800E7044 0C0080AC */  sw         $zero, 0xC($a0)
    /* D7848 800E7048 100080AC */  sw         $zero, 0x10($a0)
  .L800E704C:
    /* D784C 800E704C 21106700 */  addu       $v0, $v1, $a3
    /* D7850 800E7050 140040AC */  sw         $zero, 0x14($v0)
    /* D7854 800E7054 0100A524 */  addiu      $a1, $a1, 0x1
    /* D7858 800E7058 0C00A228 */  slti       $v0, $a1, 0xC
    /* D785C 800E705C FBFF4014 */  bnez       $v0, .L800E704C
    /* D7860 800E7060 04006324 */   addiu     $v1, $v1, 0x4
    /* D7864 800E7064 3C008424 */  addiu      $a0, $a0, 0x3C
    /* D7868 800E7068 2A108800 */  slt        $v0, $a0, $t0
    /* D786C 800E706C F1FF4014 */  bnez       $v0, .L800E7034
    /* D7870 800E7070 3C00C624 */   addiu     $a2, $a2, 0x3C
    /* D7874 800E7074 1580023C */  lui        $v0, %hi(gLastTick)
    /* D7878 800E7078 388440AC */  sw         $zero, %lo(gLastTick)($v0)
    /* D787C 800E707C 1580023C */  lui        $v0, %hi(gLastSubTick)
    /* D7880 800E7080 0800E003 */  jr         $ra
    /* D7884 800E7084 308440A4 */   sh        $zero, %lo(gLastSubTick)($v0)
endlabel iSPCH_InitEventQueue
