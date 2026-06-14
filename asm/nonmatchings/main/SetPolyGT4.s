.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPolyGT4, 0x14

glabel SetPolyGT4
    /* E3C90 800F3490 0C000224 */  addiu      $v0, $zero, 0xC
    /* E3C94 800F3494 030082A0 */  sb         $v0, 0x3($a0)
    /* E3C98 800F3498 3C000224 */  addiu      $v0, $zero, 0x3C
    /* E3C9C 800F349C 0800E003 */  jr         $ra
    /* E3CA0 800F34A0 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetPolyGT4
    /* E3CA4 800F34A4 00000000 */  nop
    /* E3CA8 800F34A8 00000000 */  nop
    /* E3CAC 800F34AC 00000000 */  nop
