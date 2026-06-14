.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpIOE, 0x14

glabel funcEvSpIOE
    /* F9D50 80109550 01000224 */  addiu      $v0, $zero, 0x1
    /* F9D54 80109554 1580013C */  lui        $at, %hi(D_80148A0C)
    /* F9D58 80109558 0C8A22AC */  sw         $v0, %lo(D_80148A0C)($at)
    /* F9D5C 8010955C 0800E003 */  jr         $ra
    /* F9D60 80109560 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpIOE
