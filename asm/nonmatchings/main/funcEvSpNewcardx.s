.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpNewcardx, 0x14

glabel funcEvSpNewcardx
    /* F9DDC 801095DC 01000224 */  addiu      $v0, $zero, 0x1
    /* F9DE0 801095E0 1580013C */  lui        $at, %hi(D_80148A28)
    /* F9DE4 801095E4 288A22AC */  sw         $v0, %lo(D_80148A28)($at)
    /* F9DE8 801095E8 0800E003 */  jr         $ra
    /* F9DEC 801095EC 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpNewcardx
