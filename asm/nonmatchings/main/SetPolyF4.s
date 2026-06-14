.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPolyF4, 0x14

glabel SetPolyF4
    /* E3E10 800F3610 05000224 */  addiu      $v0, $zero, 0x5
    /* E3E14 800F3614 030082A0 */  sb         $v0, 0x3($a0)
    /* E3E18 800F3618 28000224 */  addiu      $v0, $zero, 0x28
    /* E3E1C 800F361C 0800E003 */  jr         $ra
    /* E3E20 800F3620 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetPolyF4
    /* E3E24 800F3624 00000000 */  nop
    /* E3E28 800F3628 00000000 */  nop
    /* E3E2C 800F362C 00000000 */  nop
