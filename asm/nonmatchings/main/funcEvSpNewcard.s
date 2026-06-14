.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpNewcard, 0x14

glabel funcEvSpNewcard
    /* F9D8C 8010958C 01000224 */  addiu      $v0, $zero, 0x1
    /* F9D90 80109590 1580013C */  lui        $at, %hi(D_80148A18)
    /* F9D94 80109594 188A22AC */  sw         $v0, %lo(D_80148A18)($at)
    /* F9D98 80109598 0800E003 */  jr         $ra
    /* F9D9C 8010959C 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpNewcard
