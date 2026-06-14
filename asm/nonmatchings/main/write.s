.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching write, 0xC

glabel write
    /* FA5B0 80109DB0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FA5B4 80109DB4 08004001 */  jr         $t2
    /* FA5B8 80109DB8 35000924 */   addiu     $t1, $zero, 0x35
endlabel write
    /* FA5BC 80109DBC 00000000 */  nop
