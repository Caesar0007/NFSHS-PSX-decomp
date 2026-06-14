.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDI_mutexfree, 0x8

glabel SNDI_mutexfree
    /* F09F4 801001F4 0800E003 */  jr         $ra
    /* F09F8 801001F8 00000000 */   nop
endlabel SNDI_mutexfree
