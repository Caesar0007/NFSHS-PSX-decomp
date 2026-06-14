.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching open, 0xC

glabel open
    /* FA570 80109D70 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA574 80109D74 08004001 */  jr         $t2
    /* FA578 80109D78 32000924 */   addiu     $t1, $zero, 0x32
endlabel open
    /* FA57C 80109D7C 00000000 */  nop
