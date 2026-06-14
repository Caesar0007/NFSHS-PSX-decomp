.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15AIState_Offroad, 0x74

glabel ___15AIState_Offroad
    /* 618AC 800710AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 618B0 800710B0 21308000 */  addu       $a2, $a0, $zero
    /* 618B4 800710B4 0580023C */  lui        $v0, %hi(_vt_15AIState_Offroad)
    /* 618B8 800710B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 618BC 800710BC 0000C38C */  lw         $v1, 0x0($a2)
    /* 618C0 800710C0 C0554224 */  addiu      $v0, $v0, %lo(_vt_15AIState_Offroad)
    /* 618C4 800710C4 0400C2AC */  sw         $v0, 0x4($a2)
    /* 618C8 800710C8 100760AC */  sw         $zero, 0x710($v1)
    /* 618CC 800710CC 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 618D0 800710D0 080760AC */  sw         $zero, 0x708($v1)
    /* 618D4 800710D4 0000C28C */  lw         $v0, 0x0($a2)
    /* 618D8 800710D8 00000000 */  nop
    /* 618DC 800710DC 140740AC */  sw         $zero, 0x714($v0)
    /* 618E0 800710E0 0000C48C */  lw         $a0, 0x0($a2)
    /* 618E4 800710E4 0100A530 */  andi       $a1, $a1, 0x1
    /* 618E8 800710E8 6002828C */  lw         $v0, 0x260($a0)
    /* 618EC 800710EC FFF70324 */  addiu      $v1, $zero, -0x801
    /* 618F0 800710F0 24104300 */  and        $v0, $v0, $v1
    /* 618F4 800710F4 600282AC */  sw         $v0, 0x260($a0)
    /* 618F8 800710F8 0580023C */  lui        $v0, %hi(D_80055640)
    /* 618FC 800710FC 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 61900 80071100 0300A010 */  beqz       $a1, .L80071110
    /* 61904 80071104 0400C2AC */   sw        $v0, 0x4($a2)
    /* 61908 80071108 6B8F020C */  jal        __builtin_delete
    /* 6190C 8007110C 2120C000 */   addu      $a0, $a2, $zero
  .L80071110:
    /* 61910 80071110 1000BF8F */  lw         $ra, 0x10($sp)
    /* 61914 80071114 00000000 */  nop
    /* 61918 80071118 0800E003 */  jr         $ra
    /* 6191C 8007111C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15AIState_Offroad
