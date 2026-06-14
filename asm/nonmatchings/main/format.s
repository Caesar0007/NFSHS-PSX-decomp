.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching format, 0xC

glabel format
    /* FA880 8010A080 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA884 8010A084 08004001 */  jr         $t2
    /* FA888 8010A088 41000924 */   addiu     $t1, $zero, 0x41
endlabel format
    /* FA88C 8010A08C 00000000 */  nop
