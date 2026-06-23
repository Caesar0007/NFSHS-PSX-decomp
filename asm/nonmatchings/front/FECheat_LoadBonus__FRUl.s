.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_LoadBonus__FRUl, 0x78

glabel FECheat_LoadBonus__FRUl
    /* 13F58 80023758 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 13F5C 8002375C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 13F60 80023760 21800000 */  addu       $s0, $zero, $zero
    /* 13F64 80023764 1480023C */  lui        $v0, %hi(gFEBonus)
    /* 13F68 80023768 1400B1AF */  sw         $s1, 0x14($sp)
    /* 13F6C 8002376C 21884000 */  addu       $s1, $v0, $zero
    /* 13F70 80023770 1800B2AF */  sw         $s2, 0x18($sp)
    /* 13F74 80023774 01001224 */  addiu      $s2, $zero, 0x1
    /* 13F78 80023778 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 13F7C 8002377C 0000838C */  lw         $v1, 0x0($a0)
    /* 13F80 80023780 1480023C */  lui        $v0, %hi(gFECheats)
    /* 13F84 80023784 78D240AC */  sw         $zero, %lo(gFECheats)($v0)
    /* 13F88 80023788 7CD223AE */  sw         $v1, %lo(gFEBonus)($s1)
  .L8002378C:
    /* 13F8C 8002378C 7CD2228E */  lw         $v0, %lo(gFEBonus)($s1)
    /* 13F90 80023790 04181202 */  sllv       $v1, $s2, $s0
    /* 13F94 80023794 24104300 */  and        $v0, $v0, $v1
    /* 13F98 80023798 03004010 */  beqz       $v0, .L800237A8
    /* 13F9C 8002379C 00000000 */   nop
    /* 13FA0 800237A0 908C000C */  jal        FECheat_HandleActivation__F10tCheatCode
    /* 13FA4 800237A4 21200002 */   addu      $a0, $s0, $zero
  .L800237A8:
    /* 13FA8 800237A8 01001026 */  addiu      $s0, $s0, 0x1
    /* 13FAC 800237AC 1F00022A */  slti       $v0, $s0, 0x1F
    /* 13FB0 800237B0 F6FF4014 */  bnez       $v0, .L8002378C
    /* 13FB4 800237B4 00000000 */   nop
    /* 13FB8 800237B8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 13FBC 800237BC 1800B28F */  lw         $s2, 0x18($sp)
    /* 13FC0 800237C0 1400B18F */  lw         $s1, 0x14($sp)
    /* 13FC4 800237C4 1000B08F */  lw         $s0, 0x10($sp)
    /* 13FC8 800237C8 0800E003 */  jr         $ra
    /* 13FCC 800237CC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FECheat_LoadBonus__FRUl
