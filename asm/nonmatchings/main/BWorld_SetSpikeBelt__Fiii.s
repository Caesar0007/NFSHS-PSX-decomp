.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_SetSpikeBelt__Fiii, 0x34

glabel BWorld_SetSpikeBelt__Fiii
    /* 6E0C4 8007D8C4 01000224 */  addiu      $v0, $zero, 0x1
    /* 6E0C8 8007D8C8 480282AF */  sw         $v0, %gp_rel(gSpikeBelt)($gp)
    /* 6E0CC 8007D8CC 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 6E0D0 8007D8D0 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 6E0D4 8007D8D4 4C0284AF */  sw         $a0, %gp_rel(gSpikeBeltSlice)($gp)
    /* 6E0D8 8007D8D8 40210400 */  sll        $a0, $a0, 5
    /* 6E0DC 8007D8DC 21208200 */  addu       $a0, $a0, $v0
    /* 6E0E0 8007D8E0 1C008290 */  lbu        $v0, 0x1C($a0)
    /* 6E0E4 8007D8E4 600286AF */  sw         $a2, %gp_rel(gSpikeBeltWidth)($gp)
    /* 6E0E8 8007D8E8 540285AF */  sw         $a1, %gp_rel(gSpikeBeltX)($gp)
    /* 6E0EC 8007D8EC 500282AF */  sw         $v0, %gp_rel(gSpikeBeltChunk)($gp)
    /* 6E0F0 8007D8F0 0800E003 */  jr         $ra
    /* 6E0F4 8007D8F4 00000000 */   nop
endlabel BWorld_SetSpikeBelt__Fiii
