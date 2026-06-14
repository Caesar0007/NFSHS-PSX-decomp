.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SysDeqIntRP, 0xC

glabel SysDeqIntRP
    /* FC7C8 8010BFC8 C0000A24 */  addiu      $t2, $zero, 0xC0
    /* FC7CC 8010BFCC 08004001 */  jr         $t2
    /* FC7D0 8010BFD0 03000924 */   addiu     $t1, $zero, 0x3
endlabel SysDeqIntRP
    /* FC7D4 8010BFD4 00000000 */  nop
