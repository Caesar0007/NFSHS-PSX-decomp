.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching firstfile2, 0xC

glabel firstfile2
    /* FD084 8010C884 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD088 8010C888 08004001 */  jr         $t2
    /* FD08C 8010C88C 42000924 */   addiu     $t1, $zero, 0x42
endlabel firstfile2
    /* FD090 8010C890 00000000 */  nop
