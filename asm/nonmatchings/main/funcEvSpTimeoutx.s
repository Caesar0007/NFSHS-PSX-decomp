.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpTimeoutx, 0x14

glabel funcEvSpTimeoutx
    /* F9DC8 801095C8 01000224 */  addiu      $v0, $zero, 0x1
    /* F9DCC 801095CC 1580013C */  lui        $at, %hi(D_80148A24)
    /* F9DD0 801095D0 248A22AC */  sw         $v0, %lo(D_80148A24)($at)
    /* F9DD4 801095D4 0800E003 */  jr         $ra
    /* F9DD8 801095D8 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpTimeoutx
