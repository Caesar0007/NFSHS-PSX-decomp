.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching printf, 0xC

glabel printf
    /* F30AC 801028AC A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F30B0 801028B0 08004001 */  jr         $t2
    /* F30B4 801028B4 3F000924 */   addiu     $t1, $zero, 0x3F
endlabel printf
    /* F30B8 801028B8 00000000 */  nop
