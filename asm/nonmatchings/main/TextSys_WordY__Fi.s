.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_WordY__Fi, 0x20

glabel TextSys_WordY__Fi
    /* A9AB0 800B92B0 40100400 */  sll        $v0, $a0, 1
    /* A9AB4 800B92B4 21104400 */  addu       $v0, $v0, $a0
    /* A9AB8 800B92B8 0C0F838F */  lw         $v1, %gp_rel(wordFile)($gp)
    /* A9ABC 800B92BC 80100200 */  sll        $v0, $v0, 2
    /* A9AC0 800B92C0 21186200 */  addu       $v1, $v1, $v0
    /* A9AC4 800B92C4 06006284 */  lh         $v0, 0x6($v1)
    /* A9AC8 800B92C8 0800E003 */  jr         $ra
    /* A9ACC 800B92CC 00000000 */   nop
endlabel TextSys_WordY__Fi
