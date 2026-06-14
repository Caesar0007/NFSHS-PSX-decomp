.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_DeInit__Fv, 0x5C

glabel BWorld_DeInit__Fv
    /* 6F0B4 8007E8B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6F0B8 8007E8B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6F0BC 8007E8BC 9694020C */  jal        Object_KillStatus__Fv
    /* 6F0C0 8007E8C0 00000000 */   nop
    /* 6F0C4 8007E8C4 1DEB020C */  jal        Track_DeInit__Fv
    /* 6F0C8 8007E8C8 00000000 */   nop
    /* 6F0CC 8007E8CC 18F9010C */  jal        BWorld_DeInitContexts__Fv
    /* 6F0D0 8007E8D0 00000000 */   nop
    /* 6F0D4 8007E8D4 F797020C */  jal        Object_DeInitIMassObjectInfo__Fv
    /* 6F0D8 8007E8D8 00000000 */   nop
    /* 6F0DC 8007E8DC E4D7020C */  jal        Scene_DeInit__Fv
    /* 6F0E0 8007E8E0 00000000 */   nop
    /* 6F0E4 8007E8E4 8395020C */  jal        Object_DeInitCustomObjects__Fv
    /* 6F0E8 8007E8E8 00000000 */   nop
    /* 6F0EC 8007E8EC 0C0280AF */  sw         $zero, %gp_rel(SceneLoaded)($gp)
    /* 6F0F0 8007E8F0 4BED010C */  jal        AudList_PurgeAudio__Fv
    /* 6F0F4 8007E8F4 00000000 */   nop
    /* 6F0F8 8007E8F8 2CCF010C */  jal        Anim_DeInitSystem__Fv
    /* 6F0FC 8007E8FC 00000000 */   nop
    /* 6F100 8007E900 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6F104 8007E904 00000000 */  nop
    /* 6F108 8007E908 0800E003 */  jr         $ra
    /* 6F10C 8007E90C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorld_DeInit__Fv
