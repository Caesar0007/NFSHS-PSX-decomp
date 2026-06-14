.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPolyF3, 0x14

glabel SetPolyF3
    /* E3DF0 800F35F0 04000224 */  addiu      $v0, $zero, 0x4
    /* E3DF4 800F35F4 030082A0 */  sb         $v0, 0x3($a0)
    /* E3DF8 800F35F8 20000224 */  addiu      $v0, $zero, 0x20
    /* E3DFC 800F35FC 0800E003 */  jr         $ra
    /* E3E00 800F3600 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetPolyF3
    /* E3E04 800F3604 00000000 */  nop
    /* E3E08 800F3608 00000000 */  nop
    /* E3E0C 800F360C 00000000 */  nop
