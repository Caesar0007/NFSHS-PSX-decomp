.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo, 0x20

glabel SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
    /* 271A8 800369A8 1000A38F */  lw         $v1, 0x10($sp)
    /* 271AC 800369AC 1400A28F */  lw         $v0, 0x14($sp)
    /* 271B0 800369B0 2C0085A4 */  sh         $a1, 0x2C($a0)
    /* 271B4 800369B4 2E0086A4 */  sh         $a2, 0x2E($a0)
    /* 271B8 800369B8 300087A4 */  sh         $a3, 0x30($a0)
    /* 271BC 800369BC 280082AC */  sw         $v0, 0x28($a0)
    /* 271C0 800369C0 0800E003 */  jr         $ra
    /* 271C4 800369C4 320083A4 */   sh        $v1, 0x32($a0)
endlabel SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
