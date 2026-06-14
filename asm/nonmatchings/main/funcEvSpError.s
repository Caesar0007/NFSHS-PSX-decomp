.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpError, 0x14

glabel funcEvSpError
    /* F9D64 80109564 01000224 */  addiu      $v0, $zero, 0x1
    /* F9D68 80109568 1580013C */  lui        $at, %hi(D_80148A10)
    /* F9D6C 8010956C 108A22AC */  sw         $v0, %lo(D_80148A10)($at)
    /* F9D70 80109570 0800E003 */  jr         $ra
    /* F9D74 80109574 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpError
