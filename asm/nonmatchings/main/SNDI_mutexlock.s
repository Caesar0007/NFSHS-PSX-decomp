.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDI_mutexlock, 0x8

glabel SNDI_mutexlock
    /* F09FC 801001FC 0800E003 */  jr         $ra
    /* F0A00 80100200 00000000 */   nop
endlabel SNDI_mutexlock
