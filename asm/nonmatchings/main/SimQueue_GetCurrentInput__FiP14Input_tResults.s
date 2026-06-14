.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_GetCurrentInput__FiP14Input_tResults, 0x28

glabel SimQueue_GetCurrentInput__FiP14Input_tResults
    /* A7DA4 800B75A4 1480023C */  lui        $v0, %hi(D_8013DDC8)
    /* A7DA8 800B75A8 C8DD4224 */  addiu      $v0, $v0, %lo(D_8013DDC8)
    /* A7DAC 800B75AC 80200400 */  sll        $a0, $a0, 2
    /* A7DB0 800B75B0 21208200 */  addu       $a0, $a0, $v0
    /* A7DB4 800B75B4 03008388 */  lwl        $v1, 0x3($a0)
    /* A7DB8 800B75B8 00008398 */  lwr        $v1, 0x0($a0)
    /* A7DBC 800B75BC 00000000 */  nop
    /* A7DC0 800B75C0 0300A3A8 */  swl        $v1, 0x3($a1)
    /* A7DC4 800B75C4 0800E003 */  jr         $ra
    /* A7DC8 800B75C8 0000A3B8 */   swr       $v1, 0x0($a1)
endlabel SimQueue_GetCurrentInput__FiP14Input_tResults
