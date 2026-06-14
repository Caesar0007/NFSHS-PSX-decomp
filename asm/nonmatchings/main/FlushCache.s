.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FlushCache, 0xC

glabel FlushCache
    /* E4BD4 800F43D4 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* E4BD8 800F43D8 08004001 */  jr         $t2
    /* E4BDC 800F43DC 44000924 */   addiu     $t1, $zero, 0x44
endlabel FlushCache
    /* E4BE0 800F43E0 00000000 */  nop
