.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartUp1__14AIDataRecord_t, 0x6C

glabel StartUp1__14AIDataRecord_t
    /* 5D73C 8006CF3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D740 8006CF40 17000324 */  addiu      $v1, $zero, 0x17
    /* 5D744 8006CF44 1480023C */  lui        $v0, %hi(D_8013DF64)
    /* 5D748 8006CF48 64DF4224 */  addiu      $v0, $v0, %lo(D_8013DF64)
    /* 5D74C 8006CF4C 5C004224 */  addiu      $v0, $v0, 0x5C
    /* 5D750 8006CF50 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5D754 8006CF54 5C0080AF */  sw         $zero, %gp_rel(AIDataRecord_WhichRecord)($gp)
    /* 5D758 8006CF58 600080AF */  sw         $zero, %gp_rel(AIDataRecord_RecordMethod)($gp)
  .L8006CF5C:
    /* 5D75C 8006CF5C 000040AC */  sw         $zero, 0x0($v0)
    /* 5D760 8006CF60 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 5D764 8006CF64 FDFF6104 */  bgez       $v1, .L8006CF5C
    /* 5D768 8006CF68 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 5D76C 8006CF6C 578F020C */  jal        __builtin_new
    /* 5D770 8006CF70 58000424 */   addiu     $a0, $zero, 0x58
    /* 5D774 8006CF74 21204000 */  addu       $a0, $v0, $zero
    /* 5D778 8006CF78 9EB4010C */  jal        __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
    /* 5D77C 8006CF7C 05000524 */   addiu     $a1, $zero, 0x5
    /* 5D780 8006CF80 540082AF */  sw         $v0, %gp_rel(AIDataRecord_BestLine)($gp)
    /* 5D784 8006CF84 578F020C */  jal        __builtin_new
    /* 5D788 8006CF88 58000424 */   addiu     $a0, $zero, 0x58
    /* 5D78C 8006CF8C 21204000 */  addu       $a0, $v0, $zero
    /* 5D790 8006CF90 C3B4010C */  jal        __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
    /* 5D794 8006CF94 06000524 */   addiu     $a1, $zero, 0x6
    /* 5D798 8006CF98 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5D79C 8006CF9C 580082AF */  sw         $v0, %gp_rel(AIDataRecord_TrackCurve)($gp)
    /* 5D7A0 8006CFA0 0800E003 */  jr         $ra
    /* 5D7A4 8006CFA4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel StartUp1__14AIDataRecord_t
