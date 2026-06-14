.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_EndPauseMenu__Fv, 0x3C

glabel MPause_EndPauseMenu__Fv
    /* 8F6B0 8009EEB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8F6B4 8009EEB4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8F6B8 8009EEB8 1480043C */  lui        $a0, %hi(Device_gPausePortIndex)
    /* 8F6BC 8009EEBC 94D78490 */  lbu        $a0, %lo(Device_gPausePortIndex)($a0)
    /* 8F6C0 8009EEC0 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 8F6C4 8009EEC4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8F6C8 8009EEC8 80180400 */  sll        $v1, $a0, 2
    /* 8F6CC 8009EECC 21186200 */  addu       $v1, $v1, $v0
    /* 8F6D0 8009EED0 6000658C */  lw         $a1, 0x60($v1)
    /* 8F6D4 8009EED4 3371030C */  jal        InGame_ResetPSXController__Fii
    /* 8F6D8 8009EED8 00000000 */   nop
    /* 8F6DC 8009EEDC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8F6E0 8009EEE0 00000000 */  nop
    /* 8F6E4 8009EEE4 0800E003 */  jr         $ra
    /* 8F6E8 8009EEE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MPause_EndPauseMenu__Fv
