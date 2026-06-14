.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDI_mutexalloc, 0x8

glabel SNDI_mutexalloc
    /* F09EC 801001EC 0800E003 */  jr         $ra
    /* F09F0 801001F0 00000000 */   nop
endlabel SNDI_mutexalloc
