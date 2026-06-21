.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu, 0x24

glabel TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 17024 80026824 80000224 */  addiu      $v0, $zero, 0x80
    /* 17028 80026828 5C0082A4 */  sh         $v0, 0x5C($a0)
    /* 1702C 8002682C 1480023C */  lui        $v0, %hi(ticks)
    /* 17030 80026830 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 17034 80026834 80000224 */  addiu      $v0, $zero, 0x80
    /* 17038 80026838 580082AC */  sw         $v0, 0x58($a0)
    /* 1703C 8002683C 540080AC */  sw         $zero, 0x54($a0)
    /* 17040 80026840 0800E003 */  jr         $ra
    /* 17044 80026844 500083AC */   sw        $v1, 0x50($a0)
endlabel TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
