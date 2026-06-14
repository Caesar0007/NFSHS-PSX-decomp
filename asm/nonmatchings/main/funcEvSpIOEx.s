.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpIOEx, 0x14

glabel funcEvSpIOEx
    /* F9DA0 801095A0 01000224 */  addiu      $v0, $zero, 0x1
    /* F9DA4 801095A4 1580013C */  lui        $at, %hi(D_80148A1C)
    /* F9DA8 801095A8 1C8A22AC */  sw         $v0, %lo(D_80148A1C)($at)
    /* F9DAC 801095AC 0800E003 */  jr         $ra
    /* F9DB0 801095B0 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpIOEx
