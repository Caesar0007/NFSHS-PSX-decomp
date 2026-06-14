.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__21tPListIteratorIndexed7tPlayer, 0x24

glabel Value__21tPListIteratorIndexed7tPlayer
    /* 97A1C 800A721C 0C00828C */  lw         $v0, 0xC($a0)
    /* 97A20 800A7220 00000000 */  nop
    /* 97A24 800A7224 00004290 */  lbu        $v0, 0x0($v0)
    /* 97A28 800A7228 0400838C */  lw         $v1, 0x4($a0)
    /* 97A2C 800A722C 80100200 */  sll        $v0, $v0, 2
    /* 97A30 800A7230 21104300 */  addu       $v0, $v0, $v1
    /* 97A34 800A7234 0000428C */  lw         $v0, 0x0($v0)
    /* 97A38 800A7238 0800E003 */  jr         $ra
    /* 97A3C 800A723C 00000000 */   nop
endlabel Value__21tPListIteratorIndexed7tPlayer
