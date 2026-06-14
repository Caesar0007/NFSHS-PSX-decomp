.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_GetEnginePatch__Fii, 0x38

glabel CopSpeak_GetEnginePatch__Fii
    /* 8AACC 8009A2CC 40200400 */  sll        $a0, $a0, 1
    /* 8AAD0 8009A2D0 0100A224 */  addiu      $v0, $a1, 0x1
    /* 8AAD4 8009A2D4 21208200 */  addu       $a0, $a0, $v0
    /* 8AAD8 8009A2D8 1180023C */  lui        $v0, %hi(D_80111EBC)
    /* 8AADC 8009A2DC BC1E438C */  lw         $v1, %lo(D_80111EBC)($v0)
    /* 8AAE0 8009A2E0 C0100400 */  sll        $v0, $a0, 3
    /* 8AAE4 8009A2E4 21104300 */  addu       $v0, $v0, $v1
    /* 8AAE8 8009A2E8 0400428C */  lw         $v0, 0x4($v0)
    /* 8AAEC 8009A2EC 00000000 */  nop
    /* 8AAF0 8009A2F0 02004014 */  bnez       $v0, .L8009A2FC
    /* 8AAF4 8009A2F4 00000000 */   nop
    /* 8AAF8 8009A2F8 4500A424 */  addiu      $a0, $a1, 0x45
  .L8009A2FC:
    /* 8AAFC 8009A2FC 0800E003 */  jr         $ra
    /* 8AB00 8009A300 21108000 */   addu      $v0, $a0, $zero
endlabel CopSpeak_GetEnginePatch__Fii
