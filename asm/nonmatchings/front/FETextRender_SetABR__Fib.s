.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_SetABR__Fib, 0x24

glabel FETextRender_SetABR__Fib
    /* 121E8 800219E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 121EC 800219EC 0580023C */  lui        $v0, %hi(gSemiTransText)
    /* 121F0 800219F0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 121F4 800219F4 992C030C */  jal        Font_SetABR__Fi
    /* 121F8 800219F8 0C1645AC */   sw        $a1, %lo(gSemiTransText)($v0)
    /* 121FC 800219FC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 12200 80021A00 00000000 */  nop
    /* 12204 80021A04 0800E003 */  jr         $ra
    /* 12208 80021A08 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FETextRender_SetABR__Fib
    /* 1220C 80021A0C 00000000 */  nop
