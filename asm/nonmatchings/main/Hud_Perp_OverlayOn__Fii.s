.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Perp_OverlayOn__Fii, 0x2C

glabel Hud_Perp_OverlayOn__Fii
    /* CA124 800D9924 80200400 */  sll        $a0, $a0, 2
    /* CA128 800D9928 1480023C */  lui        $v0, %hi(D_8013DE38)
    /* CA12C 800D992C 38DE4224 */  addiu      $v0, $v0, %lo(D_8013DE38)
    /* CA130 800D9930 21108200 */  addu       $v0, $a0, $v0
    /* CA134 800D9934 01000324 */  addiu      $v1, $zero, 0x1
    /* CA138 800D9938 000043AC */  sw         $v1, 0x0($v0)
    /* CA13C 800D993C 1480023C */  lui        $v0, %hi(D_8013DE40)
    /* CA140 800D9940 40DE4224 */  addiu      $v0, $v0, %lo(D_8013DE40)
    /* CA144 800D9944 21208200 */  addu       $a0, $a0, $v0
    /* CA148 800D9948 0800E003 */  jr         $ra
    /* CA14C 800D994C 000085AC */   sw        $a1, 0x0($a0)
endlabel Hud_Perp_OverlayOn__Fii
