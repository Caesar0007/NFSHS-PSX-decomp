.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _bu_init, 0xC

glabel _bu_init
    /* FD054 8010C854 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* FD058 8010C858 08004001 */  jr         $t2
    /* FD05C 8010C85C 70000924 */   addiu     $t1, $zero, 0x70
endlabel _bu_init
    /* FD060 8010C860 00000000 */  nop
