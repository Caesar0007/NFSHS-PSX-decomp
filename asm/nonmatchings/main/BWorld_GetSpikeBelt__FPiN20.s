.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_GetSpikeBelt__FPiN20, 0x48

glabel BWorld_GetSpikeBelt__FPiN20
    /* 6E0F8 8007D8F8 4802838F */  lw         $v1, %gp_rel(gSpikeBelt)($gp)
    /* 6E0FC 8007D8FC 01000224 */  addiu      $v0, $zero, 0x1
    /* 6E100 8007D900 05006210 */  beq        $v1, $v0, .L8007D918
    /* 6E104 8007D904 21100000 */   addu      $v0, $zero, $zero
    /* 6E108 8007D908 0000C0AC */  sw         $zero, 0x0($a2)
    /* 6E10C 8007D90C 0000A0AC */  sw         $zero, 0x0($a1)
    /* 6E110 8007D910 0800E003 */  jr         $ra
    /* 6E114 8007D914 000080AC */   sw        $zero, 0x0($a0)
  .L8007D918:
    /* 6E118 8007D918 4C02828F */  lw         $v0, %gp_rel(gSpikeBeltSlice)($gp)
    /* 6E11C 8007D91C 00000000 */  nop
    /* 6E120 8007D920 000082AC */  sw         $v0, 0x0($a0)
    /* 6E124 8007D924 5402828F */  lw         $v0, %gp_rel(gSpikeBeltX)($gp)
    /* 6E128 8007D928 00000000 */  nop
    /* 6E12C 8007D92C 0000A2AC */  sw         $v0, 0x0($a1)
    /* 6E130 8007D930 6002838F */  lw         $v1, %gp_rel(gSpikeBeltWidth)($gp)
    /* 6E134 8007D934 01000224 */  addiu      $v0, $zero, 0x1
    /* 6E138 8007D938 0800E003 */  jr         $ra
    /* 6E13C 8007D93C 0000C3AC */   sw        $v1, 0x0($a2)
endlabel BWorld_GetSpikeBelt__FPiN20
