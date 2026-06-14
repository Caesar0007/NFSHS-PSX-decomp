.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14tPauseMenuDefs, 0x360

glabel __14tPauseMenuDefs
    /* 8E6D4 8009DED4 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 8E6D8 8009DED8 3000B0AF */  sw         $s0, 0x30($sp)
    /* 8E6DC 8009DEDC 21808000 */  addu       $s0, $a0, $zero
    /* 8E6E0 8009DEE0 21280000 */  addu       $a1, $zero, $zero
    /* 8E6E4 8009DEE4 5400BFAF */  sw         $ra, 0x54($sp)
    /* 8E6E8 8009DEE8 5000BEAF */  sw         $fp, 0x50($sp)
    /* 8E6EC 8009DEEC 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* 8E6F0 8009DEF0 4800B6AF */  sw         $s6, 0x48($sp)
    /* 8E6F4 8009DEF4 4400B5AF */  sw         $s5, 0x44($sp)
    /* 8E6F8 8009DEF8 4000B4AF */  sw         $s4, 0x40($sp)
    /* 8E6FC 8009DEFC 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 8E700 8009DF00 3800B2AF */  sw         $s2, 0x38($sp)
    /* 8E704 8009DF04 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E708 8009DF08 3400B1AF */   sw        $s1, 0x34($sp)
    /* 8E70C 8009DF0C 0C001526 */  addiu      $s5, $s0, 0xC
    /* 8E710 8009DF10 2120A002 */  addu       $a0, $s5, $zero
    /* 8E714 8009DF14 01000524 */  addiu      $a1, $zero, 0x1
    /* 8E718 8009DF18 AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E71C 8009DF1C 2130A000 */   addu      $a2, $a1, $zero
    /* 8E720 8009DF20 1C001426 */  addiu      $s4, $s0, 0x1C
    /* 8E724 8009DF24 21208002 */  addu       $a0, $s4, $zero
    /* 8E728 8009DF28 02000524 */  addiu      $a1, $zero, 0x2
    /* 8E72C 8009DF2C AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E730 8009DF30 2130A000 */   addu      $a2, $a1, $zero
    /* 8E734 8009DF34 2C001326 */  addiu      $s3, $s0, 0x2C
    /* 8E738 8009DF38 21206002 */  addu       $a0, $s3, $zero
    /* 8E73C 8009DF3C 03000524 */  addiu      $a1, $zero, 0x3
    /* 8E740 8009DF40 E8001626 */  addiu      $s6, $s0, 0xE8
    /* 8E744 8009DF44 2130C002 */  addu       $a2, $s6, $zero
    /* 8E748 8009DF48 5D9F020C */  jal        __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
    /* 8E74C 8009DF4C 21380000 */   addu      $a3, $zero, $zero
    /* 8E750 8009DF50 40001226 */  addiu      $s2, $s0, 0x40
    /* 8E754 8009DF54 21204002 */  addu       $a0, $s2, $zero
    /* 8E758 8009DF58 04000524 */  addiu      $a1, $zero, 0x4
    /* 8E75C 8009DF5C AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E760 8009DF60 2130A000 */   addu      $a2, $a1, $zero
    /* 8E764 8009DF64 50001126 */  addiu      $s1, $s0, 0x50
    /* 8E768 8009DF68 21202002 */  addu       $a0, $s1, $zero
    /* 8E76C 8009DF6C 05000524 */  addiu      $a1, $zero, 0x5
    /* 8E770 8009DF70 AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E774 8009DF74 2130A000 */   addu      $a2, $a1, $zero
    /* 8E778 8009DF78 60000426 */  addiu      $a0, $s0, 0x60
    /* 8E77C 8009DF7C 21280002 */  addu       $a1, $s0, $zero
    /* 8E780 8009DF80 2130A002 */  addu       $a2, $s5, $zero
    /* 8E784 8009DF84 21388002 */  addu       $a3, $s4, $zero
    /* 8E788 8009DF88 1000B3AF */  sw         $s3, 0x10($sp)
    /* 8E78C 8009DF8C 1400B2AF */  sw         $s2, 0x14($sp)
    /* 8E790 8009DF90 1800B1AF */  sw         $s1, 0x18($sp)
    /* 8E794 8009DF94 F29F020C */  jal        __6tPMenuP10tPMenuIteme
    /* 8E798 8009DF98 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* 8E79C 8009DF9C B4001326 */  addiu      $s3, $s0, 0xB4
    /* 8E7A0 8009DFA0 21206002 */  addu       $a0, $s3, $zero
    /* 8E7A4 8009DFA4 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E7A8 8009DFA8 06000524 */   addiu     $a1, $zero, 0x6
    /* 8E7AC 8009DFAC C0001226 */  addiu      $s2, $s0, 0xC0
    /* 8E7B0 8009DFB0 21204002 */  addu       $a0, $s2, $zero
    /* 8E7B4 8009DFB4 07000524 */  addiu      $a1, $zero, 0x7
    /* 8E7B8 8009DFB8 C8010326 */  addiu      $v1, $s0, 0x1C8
    /* 8E7BC 8009DFBC 21306000 */  addu       $a2, $v1, $zero
    /* 8E7C0 8009DFC0 21380000 */  addu       $a3, $zero, $zero
    /* 8E7C4 8009DFC4 5D9F020C */  jal        __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
    /* 8E7C8 8009DFC8 2800A3AF */   sw        $v1, 0x28($sp)
    /* 8E7CC 8009DFCC D4001126 */  addiu      $s1, $s0, 0xD4
    /* 8E7D0 8009DFD0 21202002 */  addu       $a0, $s1, $zero
    /* 8E7D4 8009DFD4 08000524 */  addiu      $a1, $zero, 0x8
    /* 8E7D8 8009DFD8 78020326 */  addiu      $v1, $s0, 0x278
    /* 8E7DC 8009DFDC 21306000 */  addu       $a2, $v1, $zero
    /* 8E7E0 8009DFE0 21380000 */  addu       $a3, $zero, $zero
    /* 8E7E4 8009DFE4 5D9F020C */  jal        __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
    /* 8E7E8 8009DFE8 2C00A3AF */   sw        $v1, 0x2C($sp)
    /* 8E7EC 8009DFEC 2120C002 */  addu       $a0, $s6, $zero
    /* 8E7F0 8009DFF0 21286002 */  addu       $a1, $s3, $zero
    /* 8E7F4 8009DFF4 21304002 */  addu       $a2, $s2, $zero
    /* 8E7F8 8009DFF8 21382002 */  addu       $a3, $s1, $zero
    /* 8E7FC 8009DFFC F29F020C */  jal        __6tPMenuP10tPMenuIteme
    /* 8E800 8009E000 1000A0AF */   sw        $zero, 0x10($sp)
    /* 8E804 8009E004 3C011E26 */  addiu      $fp, $s0, 0x13C
    /* 8E808 8009E008 2120C003 */  addu       $a0, $fp, $zero
    /* 8E80C 8009E00C 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E810 8009E010 0A000524 */   addiu     $a1, $zero, 0xA
    /* 8E814 8009E014 48011126 */  addiu      $s1, $s0, 0x148
    /* 8E818 8009E018 21202002 */  addu       $a0, $s1, $zero
    /* 8E81C 8009E01C 1480053C */  lui        $a1, %hi(InGameSelectListAudioMode)
    /* 8E820 8009E020 44D2A524 */  addiu      $a1, $a1, %lo(InGameSelectListAudioMode)
    /* 8E824 8009E024 1180133C */  lui        $s3, %hi(D_801132D8)
    /* 8E828 8009E028 D8327326 */  addiu      $s3, $s3, %lo(D_801132D8)
    /* 8E82C 8009E02C FC9B020C */  jal        __14tPListIteratorPsPi
    /* 8E830 8009E030 21306002 */   addu      $a2, $s3, $zero
    /* 8E834 8009E034 54011726 */  addiu      $s7, $s0, 0x154
    /* 8E838 8009E038 2120E002 */  addu       $a0, $s7, $zero
    /* 8E83C 8009E03C 0B000524 */  addiu      $a1, $zero, 0xB
    /* 8E840 8009E040 569D020C */  jal        __25tPMenuItemLeftRightChoiceUiP14tPListIterator
    /* 8E844 8009E044 21302002 */   addu      $a2, $s1, $zero
    /* 8E848 8009E048 64011626 */  addiu      $s6, $s0, 0x164
    /* 8E84C 8009E04C 2120C002 */  addu       $a0, $s6, $zero
    /* 8E850 8009E050 0C000524 */  addiu      $a1, $zero, 0xC
    /* 8E854 8009E054 1480063C */  lui        $a2, %hi(gMasterMusicLevel)
    /* 8E858 8009E058 50C6C624 */  addiu      $a2, $a2, %lo(gMasterMusicLevel)
    /* 8E85C 8009E05C 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 8E860 8009E060 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 8E864 8009E064 78011526 */  addiu      $s5, $s0, 0x178
    /* 8E868 8009E068 2120A002 */  addu       $a0, $s5, $zero
    /* 8E86C 8009E06C 0D000524 */  addiu      $a1, $zero, 0xD
    /* 8E870 8009E070 1480063C */  lui        $a2, %hi(gMasterSFXLevel)
    /* 8E874 8009E074 54C6C624 */  addiu      $a2, $a2, %lo(gMasterSFXLevel)
    /* 8E878 8009E078 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 8E87C 8009E07C 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 8E880 8009E080 8C011426 */  addiu      $s4, $s0, 0x18C
    /* 8E884 8009E084 21208002 */  addu       $a0, $s4, $zero
    /* 8E888 8009E088 0E000524 */  addiu      $a1, $zero, 0xE
    /* 8E88C 8009E08C 1480063C */  lui        $a2, %hi(gMasterFENarrationLevel)
    /* 8E890 8009E090 5CC6C624 */  addiu      $a2, $a2, %lo(gMasterFENarrationLevel)
    /* 8E894 8009E094 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 8E898 8009E098 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 8E89C 8009E09C A0011226 */  addiu      $s2, $s0, 0x1A0
    /* 8E8A0 8009E0A0 21204002 */  addu       $a0, $s2, $zero
    /* 8E8A4 8009E0A4 0F000524 */  addiu      $a1, $zero, 0xF
    /* 8E8A8 8009E0A8 1480063C */  lui        $a2, %hi(gMasterEngineLevel)
    /* 8E8AC 8009E0AC 58C6C624 */  addiu      $a2, $a2, %lo(gMasterEngineLevel)
    /* 8E8B0 8009E0B0 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 8E8B4 8009E0B4 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 8E8B8 8009E0B8 B4011126 */  addiu      $s1, $s0, 0x1B4
    /* 8E8BC 8009E0BC 21202002 */  addu       $a0, $s1, $zero
    /* 8E8C0 8009E0C0 10000524 */  addiu      $a1, $zero, 0x10
    /* 8E8C4 8009E0C4 1480063C */  lui        $a2, %hi(gMasterAmbientLevel)
    /* 8E8C8 8009E0C8 60C6C624 */  addiu      $a2, $a2, %lo(gMasterAmbientLevel)
    /* 8E8CC 8009E0CC 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 8E8D0 8009E0D0 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 8E8D4 8009E0D4 2128C003 */  addu       $a1, $fp, $zero
    /* 8E8D8 8009E0D8 2130E002 */  addu       $a2, $s7, $zero
    /* 8E8DC 8009E0DC 2800A48F */  lw         $a0, 0x28($sp)
    /* 8E8E0 8009E0E0 2138C002 */  addu       $a3, $s6, $zero
    /* 8E8E4 8009E0E4 1000B5AF */  sw         $s5, 0x10($sp)
    /* 8E8E8 8009E0E8 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8E8EC 8009E0EC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8E8F0 8009E0F0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 8E8F4 8009E0F4 F29F020C */  jal        __6tPMenuP10tPMenuIteme
    /* 8E8F8 8009E0F8 2000A0AF */   sw        $zero, 0x20($sp)
    /* 8E8FC 8009E0FC 1C021126 */  addiu      $s1, $s0, 0x21C
    /* 8E900 8009E100 21202002 */  addu       $a0, $s1, $zero
    /* 8E904 8009E104 1480053C */  lui        $a1, %hi(SelectListConfig)
    /* 8E908 8009E108 4CD2A524 */  addiu      $a1, $a1, %lo(SelectListConfig)
    /* 8E90C 8009E10C 1480073C */  lui        $a3, %hi(Device_gPausePortIndex)
    /* 8E910 8009E110 94D7E724 */  addiu      $a3, $a3, %lo(Device_gPausePortIndex)
    /* 8E914 8009E114 6C9C020C */  jal        __21tPListIteratorIndexedPsPiPc
    /* 8E918 8009E118 74FF6626 */   addiu     $a2, $s3, -0x8C
    /* 8E91C 8009E11C 2C021626 */  addiu      $s6, $s0, 0x22C
    /* 8E920 8009E120 2120C002 */  addu       $a0, $s6, $zero
    /* 8E924 8009E124 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E928 8009E128 14000524 */   addiu     $a1, $zero, 0x14
    /* 8E92C 8009E12C 38021526 */  addiu      $s5, $s0, 0x238
    /* 8E930 8009E130 2120A002 */  addu       $a0, $s5, $zero
    /* 8E934 8009E134 15000524 */  addiu      $a1, $zero, 0x15
    /* 8E938 8009E138 569D020C */  jal        __25tPMenuItemLeftRightChoiceUiP14tPListIterator
    /* 8E93C 8009E13C 21302002 */   addu      $a2, $s1, $zero
    /* 8E940 8009E140 48021426 */  addiu      $s4, $s0, 0x248
    /* 8E944 8009E144 21208002 */  addu       $a0, $s4, $zero
    /* 8E948 8009E148 1B000524 */  addiu      $a1, $zero, 0x1B
    /* 8E94C 8009E14C BCFF6626 */  addiu      $a2, $s3, -0x44
    /* 8E950 8009E150 7F000724 */  addiu      $a3, $zero, 0x7F
    /* 8E954 8009E154 1480113C */  lui        $s1, %hi(Device_gPausePortIndex)
    /* 8E958 8009E158 94D73126 */  addiu      $s1, $s1, %lo(Device_gPausePortIndex)
    /* 8E95C 8009E15C 1B9F020C */  jal        __32tPMenuItemLeftRightSliderIndexedUiPicPc
    /* 8E960 8009E160 1000B1AF */   sw        $s1, 0x10($sp)
    /* 8E964 8009E164 60021226 */  addiu      $s2, $s0, 0x260
    /* 8E968 8009E168 21204002 */  addu       $a0, $s2, $zero
    /* 8E96C 8009E16C 1C000524 */  addiu      $a1, $zero, 0x1C
    /* 8E970 8009E170 C4FF6626 */  addiu      $a2, $s3, -0x3C
    /* 8E974 8009E174 7F000724 */  addiu      $a3, $zero, 0x7F
    /* 8E978 8009E178 1B9F020C */  jal        __32tPMenuItemLeftRightSliderIndexedUiPicPc
    /* 8E97C 8009E17C 1000B1AF */   sw        $s1, 0x10($sp)
    /* 8E980 8009E180 2128C002 */  addu       $a1, $s6, $zero
    /* 8E984 8009E184 2130A002 */  addu       $a2, $s5, $zero
    /* 8E988 8009E188 2C00A48F */  lw         $a0, 0x2C($sp)
    /* 8E98C 8009E18C 21388002 */  addu       $a3, $s4, $zero
    /* 8E990 8009E190 1000B2AF */  sw         $s2, 0x10($sp)
    /* 8E994 8009E194 F29F020C */  jal        __6tPMenuP10tPMenuIteme
    /* 8E998 8009E198 1400A0AF */   sw        $zero, 0x14($sp)
    /* 8E99C 8009E19C CC021426 */  addiu      $s4, $s0, 0x2CC
    /* 8E9A0 8009E1A0 21208002 */  addu       $a0, $s4, $zero
    /* 8E9A4 8009E1A4 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E9A8 8009E1A8 04000524 */   addiu     $a1, $zero, 0x4
    /* 8E9AC 8009E1AC D8021326 */  addiu      $s3, $s0, 0x2D8
    /* 8E9B0 8009E1B0 21206002 */  addu       $a0, $s3, $zero
    /* 8E9B4 8009E1B4 149D020C */  jal        __28tPMenuItemNonInteractiveTextUi
    /* 8E9B8 8009E1B8 24000524 */   addiu     $a1, $zero, 0x24
    /* 8E9BC 8009E1BC E4021226 */  addiu      $s2, $s0, 0x2E4
    /* 8E9C0 8009E1C0 21204002 */  addu       $a0, $s2, $zero
    /* 8E9C4 8009E1C4 26000524 */  addiu      $a1, $zero, 0x26
    /* 8E9C8 8009E1C8 AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E9CC 8009E1CC 07000624 */   addiu     $a2, $zero, 0x7
    /* 8E9D0 8009E1D0 F4021126 */  addiu      $s1, $s0, 0x2F4
    /* 8E9D4 8009E1D4 21202002 */  addu       $a0, $s1, $zero
    /* 8E9D8 8009E1D8 25000524 */  addiu      $a1, $zero, 0x25
    /* 8E9DC 8009E1DC AC9F020C */  jal        __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 8E9E0 8009E1E0 07000624 */   addiu     $a2, $zero, 0x7
    /* 8E9E4 8009E1E4 04030426 */  addiu      $a0, $s0, 0x304
    /* 8E9E8 8009E1E8 21288002 */  addu       $a1, $s4, $zero
    /* 8E9EC 8009E1EC 21306002 */  addu       $a2, $s3, $zero
    /* 8E9F0 8009E1F0 21384002 */  addu       $a3, $s2, $zero
    /* 8E9F4 8009E1F4 1000B1AF */  sw         $s1, 0x10($sp)
    /* 8E9F8 8009E1F8 F29F020C */  jal        __6tPMenuP10tPMenuIteme
    /* 8E9FC 8009E1FC 1400A0AF */   sw        $zero, 0x14($sp)
    /* 8EA00 8009E200 21100002 */  addu       $v0, $s0, $zero
    /* 8EA04 8009E204 5400BF8F */  lw         $ra, 0x54($sp)
    /* 8EA08 8009E208 5000BE8F */  lw         $fp, 0x50($sp)
    /* 8EA0C 8009E20C 4C00B78F */  lw         $s7, 0x4C($sp)
    /* 8EA10 8009E210 4800B68F */  lw         $s6, 0x48($sp)
    /* 8EA14 8009E214 4400B58F */  lw         $s5, 0x44($sp)
    /* 8EA18 8009E218 4000B48F */  lw         $s4, 0x40($sp)
    /* 8EA1C 8009E21C 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 8EA20 8009E220 3800B28F */  lw         $s2, 0x38($sp)
    /* 8EA24 8009E224 3400B18F */  lw         $s1, 0x34($sp)
    /* 8EA28 8009E228 3000B08F */  lw         $s0, 0x30($sp)
    /* 8EA2C 8009E22C 0800E003 */  jr         $ra
    /* 8EA30 8009E230 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel __14tPauseMenuDefs
