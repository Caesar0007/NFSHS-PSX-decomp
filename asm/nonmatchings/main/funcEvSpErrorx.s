.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpErrorx, 0x14

glabel funcEvSpErrorx
    /* F9DB4 801095B4 01000224 */  addiu      $v0, $zero, 0x1
    /* F9DB8 801095B8 1580013C */  lui        $at, %hi(D_80148A20)
    /* F9DBC 801095BC 208A22AC */  sw         $v0, %lo(D_80148A20)($at)
    /* F9DC0 801095C0 0800E003 */  jr         $ra
    /* F9DC4 801095C4 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpErrorx
