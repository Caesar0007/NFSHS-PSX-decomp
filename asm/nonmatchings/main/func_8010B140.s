.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010B140, 0x18

glabel func_8010B140
    /* FB940 8010B140 06008290 */  lbu        $v0, 0x6($a0)
    /* FB944 8010B144 00000000 */  nop
    /* FB948 8010B148 40100200 */  sll        $v0, $v0, 1
    /* FB94C 8010B14C 0C004224 */  addiu      $v0, $v0, 0xC
    /* FB950 8010B150 0800E003 */  jr         $ra
    /* FB954 8010B154 21108200 */   addu      $v0, $a0, $v0
endlabel func_8010B140
