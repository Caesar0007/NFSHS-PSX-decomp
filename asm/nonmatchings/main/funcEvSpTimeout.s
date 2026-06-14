.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching funcEvSpTimeout, 0x14

glabel funcEvSpTimeout
    /* F9D78 80109578 01000224 */  addiu      $v0, $zero, 0x1
    /* F9D7C 8010957C 1580013C */  lui        $at, %hi(D_80148A14)
    /* F9D80 80109580 148A22AC */  sw         $v0, %lo(D_80148A14)($at)
    /* F9D84 80109584 0800E003 */  jr         $ra
    /* F9D88 80109588 21100000 */   addu      $v0, $zero, $zero
endlabel funcEvSpTimeout
