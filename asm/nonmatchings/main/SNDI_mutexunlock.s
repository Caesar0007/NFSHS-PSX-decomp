.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDI_mutexunlock, 0x8

glabel SNDI_mutexunlock
    /* F0A04 80100204 0800E003 */  jr         $ra
    /* F0A08 80100208 00000000 */   nop
endlabel SNDI_mutexunlock
