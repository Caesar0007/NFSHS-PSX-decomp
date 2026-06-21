.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8004E638, 0x40

glabel func_8004E638
    /* 3EE38 8004E638 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3EE3C 8004E63C 3000A28F */  lw         $v0, 0x30($sp)
    /* 3EE40 8004E640 3400A88F */  lw         $t0, 0x34($sp)
    /* 3EE44 8004E644 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3EE48 8004E648 0000438C */  lw         $v1, 0x0($v0)
    /* 3EE4C 8004E64C 00000000 */  nop
    /* 3EE50 8004E650 0C0043AC */  sw         $v1, 0xC($v0)
    /* 3EE54 8004E654 080043AC */  sw         $v1, 0x8($v0)
    /* 3EE58 8004E658 040043AC */  sw         $v1, 0x4($v0)
    /* 3EE5C 8004E65C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3EE60 8004E660 9938010C */  jal        func_8004E264
    /* 3EE64 8004E664 1400A8AF */   sw        $t0, 0x14($sp)
    /* 3EE68 8004E668 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3EE6C 8004E66C 00000000 */  nop
    /* 3EE70 8004E670 0800E003 */  jr         $ra
    /* 3EE74 8004E674 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_8004E638
