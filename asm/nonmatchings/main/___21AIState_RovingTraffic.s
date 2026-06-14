.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___21AIState_RovingTraffic, 0x74

glabel ___21AIState_RovingTraffic
    /* 62EDC 800726DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62EE0 800726E0 21308000 */  addu       $a2, $a0, $zero
    /* 62EE4 800726E4 0580023C */  lui        $v0, %hi(_vt_21AIState_RovingTraffic)
    /* 62EE8 800726E8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62EEC 800726EC 0000C38C */  lw         $v1, 0x0($a2)
    /* 62EF0 800726F0 60554224 */  addiu      $v0, $v0, %lo(_vt_21AIState_RovingTraffic)
    /* 62EF4 800726F4 0400C2AC */  sw         $v0, 0x4($a2)
    /* 62EF8 800726F8 100760AC */  sw         $zero, 0x710($v1)
    /* 62EFC 800726FC 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 62F00 80072700 080760AC */  sw         $zero, 0x708($v1)
    /* 62F04 80072704 0000C28C */  lw         $v0, 0x0($a2)
    /* 62F08 80072708 00000000 */  nop
    /* 62F0C 8007270C 140740AC */  sw         $zero, 0x714($v0)
    /* 62F10 80072710 0000C48C */  lw         $a0, 0x0($a2)
    /* 62F14 80072714 0100A530 */  andi       $a1, $a1, 0x1
    /* 62F18 80072718 6002828C */  lw         $v0, 0x260($a0)
    /* 62F1C 8007271C FFF70324 */  addiu      $v1, $zero, -0x801
    /* 62F20 80072720 24104300 */  and        $v0, $v0, $v1
    /* 62F24 80072724 600282AC */  sw         $v0, 0x260($a0)
    /* 62F28 80072728 0580023C */  lui        $v0, %hi(D_80055640)
    /* 62F2C 8007272C 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62F30 80072730 0300A010 */  beqz       $a1, .L80072740
    /* 62F34 80072734 0400C2AC */   sw        $v0, 0x4($a2)
    /* 62F38 80072738 6B8F020C */  jal        __builtin_delete
    /* 62F3C 8007273C 2120C000 */   addu      $a0, $a2, $zero
  .L80072740:
    /* 62F40 80072740 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62F44 80072744 00000000 */  nop
    /* 62F48 80072748 0800E003 */  jr         $ra
    /* 62F4C 8007274C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___21AIState_RovingTraffic
