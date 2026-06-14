.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReturnFromException, 0xC

glabel ReturnFromException
    /* F717C 8010697C B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F7180 80106980 08004001 */  jr         $t2
    /* F7184 80106984 17000924 */   addiu     $t1, $zero, 0x17
endlabel ReturnFromException
    /* F7188 80106988 00000000 */  nop
