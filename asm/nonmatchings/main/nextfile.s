.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching nextfile, 0xC

glabel nextfile
    /* FA860 8010A060 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA864 8010A064 08004001 */  jr         $t2
    /* FA868 8010A068 43000924 */   addiu     $t1, $zero, 0x43
endlabel nextfile
    /* FA86C 8010A06C 00000000 */  nop
