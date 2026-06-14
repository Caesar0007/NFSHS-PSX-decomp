.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPolyG4, 0x14

glabel SetPolyG4
    /* E3E30 800F3630 08000224 */  addiu      $v0, $zero, 0x8
    /* E3E34 800F3634 030082A0 */  sb         $v0, 0x3($a0)
    /* E3E38 800F3638 38000224 */  addiu      $v0, $zero, 0x38
    /* E3E3C 800F363C 0800E003 */  jr         $ra
    /* E3E40 800F3640 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetPolyG4
    /* E3E44 800F3644 00000000 */  nop
    /* E3E48 800F3648 00000000 */  nop
    /* E3E4C 800F364C 00000000 */  nop
