.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_WordX__Fi, 0x20

glabel TextSys_WordX__Fi
    /* A9A90 800B9290 40100400 */  sll        $v0, $a0, 1
    /* A9A94 800B9294 21104400 */  addu       $v0, $v0, $a0
    /* A9A98 800B9298 0C0F838F */  lw         $v1, %gp_rel(wordFile)($gp)
    /* A9A9C 800B929C 80100200 */  sll        $v0, $v0, 2
    /* A9AA0 800B92A0 21186200 */  addu       $v1, $v1, $v0
    /* A9AA4 800B92A4 04006284 */  lh         $v0, 0x4($v1)
    /* A9AA8 800B92A8 0800E003 */  jr         $ra
    /* A9AAC 800B92AC 00000000 */   nop
endlabel TextSys_WordX__Fi
