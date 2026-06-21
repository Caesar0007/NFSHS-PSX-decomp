.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetMatchValue, 0x14

glabel iSPCH_GetMatchValue
    /* F0F10 80100710 80280500 */  sll        $a1, $a1, 2
    /* F0F14 80100714 21208500 */  addu       $a0, $a0, $a1
    /* F0F18 80100718 0800828C */  lw         $v0, 0x8($a0)
    /* F0F1C 8010071C 0800E003 */  jr         $ra
    /* F0F20 80100720 00000000 */   nop
endlabel iSPCH_GetMatchValue
