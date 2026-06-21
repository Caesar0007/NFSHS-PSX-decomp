.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __9tMenuItemUi, 0x30

glabel __9tMenuItemUi
    /* 14F34 80024734 21108000 */  addu       $v0, $a0, $zero
    /* 14F38 80024738 0180033C */  lui        $v1, %hi(_vt_9tMenuItem)
    /* 14F3C 8002473C 80126324 */  addiu      $v1, $v1, %lo(_vt_9tMenuItem)
    /* 14F40 80024740 180043AC */  sw         $v1, 0x18($v0)
    /* 14F44 80024744 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 14F48 80024748 040045AC */  sw         $a1, 0x4($v0)
    /* 14F4C 8002474C 000040AC */  sw         $zero, 0x0($v0)
    /* 14F50 80024750 080040A4 */  sh         $zero, 0x8($v0)
    /* 14F54 80024754 0C0043AC */  sw         $v1, 0xC($v0)
    /* 14F58 80024758 100040AC */  sw         $zero, 0x10($v0)
    /* 14F5C 8002475C 0800E003 */  jr         $ra
    /* 14F60 80024760 140040AC */   sw        $zero, 0x14($v0)
endlabel __9tMenuItemUi
