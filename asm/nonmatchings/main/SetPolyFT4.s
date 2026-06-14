.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPolyFT4, 0x14

glabel SetPolyFT4
    /* E3E50 800F3650 09000224 */  addiu      $v0, $zero, 0x9
    /* E3E54 800F3654 030082A0 */  sb         $v0, 0x3($a0)
    /* E3E58 800F3658 2C000224 */  addiu      $v0, $zero, 0x2C
    /* E3E5C 800F365C 0800E003 */  jr         $ra
    /* E3E60 800F3660 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetPolyFT4
    /* E3E64 800F3664 00000000 */  nop
    /* E3E68 800F3668 00000000 */  nop
    /* E3E6C 800F366C 00000000 */  nop
