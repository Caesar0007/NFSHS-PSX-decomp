.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp, 0x1C

glabel FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D6E0 8005CEE0 5800828C */  lw         $v0, 0x58($a0)
    /* 4D6E4 8005CEE4 00000000 */  nop
    /* 4D6E8 8005CEE8 02004514 */  bne        $v0, $a1, .L8005CEF4
    /* 4D6EC 8005CEEC 02000224 */   addiu     $v0, $zero, 0x2
    /* 4D6F0 8005CEF0 600082AC */  sw         $v0, 0x60($a0)
  .L8005CEF4:
    /* 4D6F4 8005CEF4 0800E003 */  jr         $ra
    /* 4D6F8 8005CEF8 00000000 */   nop
endlabel FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
