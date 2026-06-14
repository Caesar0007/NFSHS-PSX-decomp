.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_Deinit, 0x54

glabel SPCH_Deinit
    /* DBE00 800EB600 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBE04 800EB604 7801033C */  lui        $v1, (0x1789A34 >> 16)
    /* DBE08 800EB608 1380043C */  lui        $a0, %hi(gSPCH_Initialized)
    /* DBE0C 800EB60C B070828C */  lw         $v0, %lo(gSPCH_Initialized)($a0)
    /* DBE10 800EB610 349A6334 */  ori        $v1, $v1, (0x1789A34 & 0xFFFF)
    /* DBE14 800EB614 0B004314 */  bne        $v0, $v1, .L800EB644
    /* DBE18 800EB618 1000BFAF */   sw        $ra, 0x10($sp)
    /* DBE1C 800EB61C 1380023C */  lui        $v0, %hi(gSampleRequest)
    /* DBE20 800EB620 947040AC */  sw         $zero, %lo(gSampleRequest)($v0)
    /* DBE24 800EB624 1380023C */  lui        $v0, %hi(gSentenceRuleTest)
    /* DBE28 800EB628 987040AC */  sw         $zero, %lo(gSentenceRuleTest)($v0)
    /* DBE2C 800EB62C 1380023C */  lui        $v0, %hi(gSentenceRuleSet)
    /* DBE30 800EB630 B07080AC */  sw         $zero, %lo(gSPCH_Initialized)($a0)
    /* DBE34 800EB634 7DAC030C */  jal        iSPCH_DisposeBanks
    /* DBE38 800EB638 9C7040AC */   sw        $zero, %lo(gSentenceRuleSet)($v0)
    /* DBE3C 800EB63C EF9B030C */  jal        iSPCH_InitEventDat
    /* DBE40 800EB640 00000000 */   nop
  .L800EB644:
    /* DBE44 800EB644 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBE48 800EB648 00000000 */  nop
    /* DBE4C 800EB64C 0800E003 */  jr         $ra
    /* DBE50 800EB650 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SPCH_Deinit
