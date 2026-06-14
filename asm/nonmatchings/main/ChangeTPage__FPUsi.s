.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ChangeTPage__FPUsi, 0x18

glabel ChangeTPage__FPUsi
    /* AEED0 800BE6D0 00008294 */  lhu        $v0, 0x0($a0)
    /* AEED4 800BE6D4 40290500 */  sll        $a1, $a1, 5
    /* AEED8 800BE6D8 9FFF4230 */  andi       $v0, $v0, 0xFF9F
    /* AEEDC 800BE6DC 25104500 */  or         $v0, $v0, $a1
    /* AEEE0 800BE6E0 0800E003 */  jr         $ra
    /* AEEE4 800BE6E4 000082A4 */   sh        $v0, 0x0($a0)
endlabel ChangeTPage__FPUsi
