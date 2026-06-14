.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching geti, 0x20

glabel geti
    /* E388C 800F308C 03008888 */  lwl        $t0, 0x3($a0)
    /* E3890 800F3090 00008898 */  lwr        $t0, 0x0($a0)
    /* E3894 800F3094 20000924 */  addiu      $t1, $zero, 0x20
    /* E3898 800F3098 C0280500 */  sll        $a1, $a1, 3
    /* E389C 800F309C 23282501 */  subu       $a1, $t1, $a1
    /* E38A0 800F30A0 0440A800 */  sllv       $t0, $t0, $a1
    /* E38A4 800F30A4 0800E003 */  jr         $ra
    /* E38A8 800F30A8 0610A800 */   srlv      $v0, $t0, $a1
endlabel geti
