.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu, 0x20

glabel TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 17004 80026804 1480023C */  lui        $v0, %hi(ticks)
    /* 17008 80026808 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 1700C 8002680C 01000224 */  addiu      $v0, $zero, 0x1
    /* 17010 80026810 5C0080A4 */  sh         $zero, 0x5C($a0)
    /* 17014 80026814 580080AC */  sw         $zero, 0x58($a0)
    /* 17018 80026818 540082AC */  sw         $v0, 0x54($a0)
    /* 1701C 8002681C 0800E003 */  jr         $ra
    /* 17020 80026820 500083AC */   sw        $v1, 0x50($a0)
endlabel TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
