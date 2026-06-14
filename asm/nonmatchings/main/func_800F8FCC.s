.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F8FCC, 0x20

glabel func_800F8FCC
    /* E97CC 800F8FCC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E97D0 800F8FD0 1000BFAF */  sw         $ra, 0x10($sp)
    /* E97D4 800F8FD4 9EDF030C */  jal        StCdInterrupt
    /* E97D8 800F8FD8 00000000 */   nop
    /* E97DC 800F8FDC 1000BF8F */  lw         $ra, 0x10($sp)
    /* E97E0 800F8FE0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E97E4 800F8FE4 0800E003 */  jr         $ra
    /* E97E8 800F8FE8 00000000 */   nop
endlabel func_800F8FCC
    /* E97EC 800F8FEC 00000000 */  nop
    /* E97F0 800F8FF0 00000000 */  nop
    /* E97F4 800F8FF4 00000000 */  nop
