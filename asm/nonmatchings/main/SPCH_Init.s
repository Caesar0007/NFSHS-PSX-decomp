.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_Init, 0x9C

glabel SPCH_Init
    /* DBF48 800EB748 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBF4C 800EB74C 1380023C */  lui        $v0, %hi(gSampleRequest)
    /* DBF50 800EB750 947044AC */  sw         $a0, %lo(gSampleRequest)($v0)
    /* DBF54 800EB754 2120A000 */  addu       $a0, $a1, $zero
    /* DBF58 800EB758 1580023C */  lui        $v0, %hi(gGameNum)
    /* DBF5C 800EB75C 288444AC */  sw         $a0, %lo(gGameNum)($v0)
    /* DBF60 800EB760 1580023C */  lui        $v0, %hi(gDataRate)
    /* DBF64 800EB764 348446AC */  sw         $a2, %lo(gDataRate)($v0)
    /* DBF68 800EB768 1380023C */  lui        $v0, %hi(gMemAlloc)
    /* DBF6C 800EB76C A87040AC */  sw         $zero, %lo(gMemAlloc)($v0)
    /* DBF70 800EB770 1380023C */  lui        $v0, %hi(gMemFree)
    /* DBF74 800EB774 AC7040AC */  sw         $zero, %lo(gMemFree)($v0)
    /* DBF78 800EB778 1380023C */  lui        $v0, %hi(gSentenceRuleTest)
    /* DBF7C 800EB77C 987040AC */  sw         $zero, %lo(gSentenceRuleTest)($v0)
    /* DBF80 800EB780 1380023C */  lui        $v0, %hi(gSentenceRuleSet)
    /* DBF84 800EB784 1000BFAF */  sw         $ra, 0x10($sp)
    /* DBF88 800EB788 B1AE030C */  jal        iSPCH_EACseedrandom
    /* DBF8C 800EB78C 9C7040AC */   sw        $zero, %lo(gSentenceRuleSet)($v0)
    /* DBF90 800EB790 9405040C */  jal        iSPCH_ClearChosen
    /* DBF94 800EB794 00000000 */   nop
    /* DBF98 800EB798 3D06040C */  jal        SPCH_SetPreLoadTicks
    /* DBF9C 800EB79C 21200000 */   addu      $a0, $zero, $zero
    /* DBFA0 800EB7A0 1580023C */  lui        $v0, %hi(gFilterSetting)
    /* DBFA4 800EB7A4 EF9B030C */  jal        iSPCH_InitEventDat
    /* DBFA8 800EB7A8 2C8440AC */   sw        $zero, %lo(gFilterSetting)($v0)
    /* DBFAC 800EB7AC 95AD030C */  jal        iSPCH_InitInGame
    /* DBFB0 800EB7B0 00000000 */   nop
    /* DBFB4 800EB7B4 78AC030C */  jal        iSPCH_InitBanks
    /* DBFB8 800EB7B8 00000000 */   nop
    /* DBFBC 800EB7BC 059C030C */  jal        iSPCH_InitEventQueue
    /* DBFC0 800EB7C0 00000000 */   nop
    /* DBFC4 800EB7C4 7801033C */  lui        $v1, (0x1789A34 >> 16)
    /* DBFC8 800EB7C8 349A6334 */  ori        $v1, $v1, (0x1789A34 & 0xFFFF)
    /* DBFCC 800EB7CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBFD0 800EB7D0 1380023C */  lui        $v0, %hi(gSPCH_Initialized)
    /* DBFD4 800EB7D4 B07043AC */  sw         $v1, %lo(gSPCH_Initialized)($v0)
    /* DBFD8 800EB7D8 01000224 */  addiu      $v0, $zero, 0x1
    /* DBFDC 800EB7DC 0800E003 */  jr         $ra
    /* DBFE0 800EB7E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SPCH_Init
