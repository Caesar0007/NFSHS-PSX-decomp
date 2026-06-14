.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SysEnqIntRP, 0xC

glabel SysEnqIntRP
    /* FC7D8 8010BFD8 C0000A24 */  addiu      $t2, $zero, 0xC0
    /* FC7DC 8010BFDC 08004001 */  jr         $t2
    /* FC7E0 8010BFE0 02000924 */   addiu     $t1, $zero, 0x2
endlabel SysEnqIntRP
    /* FC7E4 8010BFE4 00000000 */  nop
