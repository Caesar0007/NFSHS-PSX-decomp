.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching toupper, 0xC

glabel toupper
    /* F987C 8010907C A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F9880 80109080 08004001 */  jr         $t2
    /* F9884 80109084 25000924 */   addiu     $t1, $zero, 0x25
endlabel toupper
    /* F9888 80109088 00000000 */  nop
