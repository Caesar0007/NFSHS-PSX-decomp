.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_Word__Fi, 0x20

glabel TextSys_Word__Fi
    /* A9A50 800B9250 40100400 */  sll        $v0, $a0, 1
    /* A9A54 800B9254 21104400 */  addu       $v0, $v0, $a0
    /* A9A58 800B9258 0C0F838F */  lw         $v1, %gp_rel(wordFile)($gp)
    /* A9A5C 800B925C 80100200 */  sll        $v0, $v0, 2
    /* A9A60 800B9260 21106200 */  addu       $v0, $v1, $v0
    /* A9A64 800B9264 0800428C */  lw         $v0, 0x8($v0)
    /* A9A68 800B9268 0800E003 */  jr         $ra
    /* A9A6C 800B926C 21106200 */   addu      $v0, $v1, $v0
endlabel TextSys_Word__Fi
