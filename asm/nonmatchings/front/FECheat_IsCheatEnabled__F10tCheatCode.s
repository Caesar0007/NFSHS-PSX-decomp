.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_IsCheatEnabled__F10tCheatCode, 0x2C

glabel FECheat_IsCheatEnabled__F10tCheatCode
    /* 13F1C 8002371C 1480023C */  lui        $v0, %hi(gFECheats)
    /* 13F20 80023720 1480033C */  lui        $v1, %hi(gFEBonus)
    /* 13F24 80023724 78D2428C */  lw         $v0, %lo(gFECheats)($v0)
    /* 13F28 80023728 7CD2638C */  lw         $v1, %lo(gFEBonus)($v1)
    /* 13F2C 8002372C 00000000 */  nop
    /* 13F30 80023730 25104300 */  or         $v0, $v0, $v1
    /* 13F34 80023734 01000324 */  addiu      $v1, $zero, 0x1
    /* 13F38 80023738 04188300 */  sllv       $v1, $v1, $a0
    /* 13F3C 8002373C 24104300 */  and        $v0, $v0, $v1
    /* 13F40 80023740 0800E003 */  jr         $ra
    /* 13F44 80023744 2B100200 */   sltu      $v0, $zero, $v0
endlabel FECheat_IsCheatEnabled__F10tCheatCode
