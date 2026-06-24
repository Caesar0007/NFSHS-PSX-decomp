.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetOffset8, 0x18

glabel iSPCH_GetOffset8
    /* F0F48 80100748 2128A600 */  addu       $a1, $a1, $a2
    /* F0F4C 8010074C 0000A290 */  lbu        $v0, 0x0($a1)
    /* F0F50 80100750 00000000 */  nop
    /* F0F54 80100754 80100200 */  sll        $v0, $v0, 2
    /* F0F58 80100758 0800E003 */  jr         $ra
    /* F0F5C 8010075C 21108200 */   addu      $v0, $a0, $v0
endlabel iSPCH_GetOffset8
