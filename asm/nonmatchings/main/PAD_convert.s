.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PAD_convert, 0x14

glabel PAD_convert
    /* D49FC 800E41FC 02008294 */  lhu        $v0, 0x2($a0)
    /* D4A00 800E4200 00000000 */  nop
    /* D4A04 800E4204 27100200 */  nor        $v0, $zero, $v0
    /* D4A08 800E4208 0800E003 */  jr         $ra
    /* D4A0C 800E420C FFFF4230 */   andi      $v0, $v0, 0xFFFF
endlabel PAD_convert
