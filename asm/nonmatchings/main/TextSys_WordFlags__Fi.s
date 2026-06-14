.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_WordFlags__Fi, 0x20

glabel TextSys_WordFlags__Fi
    /* A9A70 800B9270 40100400 */  sll        $v0, $a0, 1
    /* A9A74 800B9274 21104400 */  addu       $v0, $v0, $a0
    /* A9A78 800B9278 0C0F838F */  lw         $v1, %gp_rel(wordFile)($gp)
    /* A9A7C 800B927C 80100200 */  sll        $v0, $v0, 2
    /* A9A80 800B9280 21186200 */  addu       $v1, $v1, $v0
    /* A9A84 800B9284 03006290 */  lbu        $v0, 0x3($v1)
    /* A9A88 800B9288 0800E003 */  jr         $ra
    /* A9A8C 800B928C 00000000 */   nop
endlabel TextSys_WordFlags__Fi
