.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RunFrontEnd__14tFEApplication, 0x28

glabel RunFrontEnd__14tFEApplication
    /* 5F38 80015738 0580023C */  lui        $v0, %hi(menuDefs)
    /* 5F3C 8001573C 581A458C */  lw         $a1, %lo(menuDefs)($v0)
    /* 5F40 80015740 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5F44 80015744 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5F48 80015748 A950000C */  jal        MainLoop__14tFEApplicationP5tMenu
    /* 5F4C 8001574C B000A524 */   addiu     $a1, $a1, 0xB0
    /* 5F50 80015750 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5F54 80015754 00000000 */  nop
    /* 5F58 80015758 0800E003 */  jr         $ra
    /* 5F5C 8001575C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel RunFrontEnd__14tFEApplication
