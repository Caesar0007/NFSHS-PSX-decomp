.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10tPMenuItemUi, 0x1C

glabel __10tPMenuItemUi
    /* 97BE8 800A73E8 21108000 */  addu       $v0, $a0, $zero
    /* 97BEC 800A73EC 0580033C */  lui        $v1, %hi(_vt_10tPMenuItem)
    /* 97BF0 800A73F0 CC626324 */  addiu      $v1, $v1, %lo(_vt_10tPMenuItem)
    /* 97BF4 800A73F4 080043AC */  sw         $v1, 0x8($v0)
    /* 97BF8 800A73F8 040045AC */  sw         $a1, 0x4($v0)
    /* 97BFC 800A73FC 0800E003 */  jr         $ra
    /* 97C00 800A7400 000040AC */   sw        $zero, 0x0($v0)
endlabel __10tPMenuItemUi
