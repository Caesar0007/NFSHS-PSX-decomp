.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __15tGlobalMenuDefs, 0x321C

glabel __15tGlobalMenuDefs
    /* 1EBB8 8002E3B8 80FDBD27 */  addiu      $sp, $sp, -0x280
    /* 1EBBC 8002E3BC 5B000524 */  addiu      $a1, $zero, 0x5B
    /* 1EBC0 8002E3C0 8002A4AF */  sw         $a0, 0x280($sp)
    /* 1EBC4 8002E3C4 58048824 */  addiu      $t0, $a0, 0x458
    /* 1EBC8 8002E3C8 21300001 */  addu       $a2, $t0, $zero
    /* 1EBCC 8002E3CC 0380073C */  lui        $a3, %hi(MenuExtended_SetOnePlayer__FR12tMenuCommand)
    /* 1EBD0 8002E3D0 E0C0E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetOnePlayer__FR12tMenuCommand)
    /* 1EBD4 8002E3D4 1E000224 */  addiu      $v0, $zero, 0x1E
    /* 1EBD8 8002E3D8 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EBDC 8002E3DC 7C02BFAF */  sw         $ra, 0x27C($sp)
    /* 1EBE0 8002E3E0 7802BEAF */  sw         $fp, 0x278($sp)
    /* 1EBE4 8002E3E4 7402B7AF */  sw         $s7, 0x274($sp)
    /* 1EBE8 8002E3E8 7002B6AF */  sw         $s6, 0x270($sp)
    /* 1EBEC 8002E3EC 6C02B5AF */  sw         $s5, 0x26C($sp)
    /* 1EBF0 8002E3F0 6802B4AF */  sw         $s4, 0x268($sp)
    /* 1EBF4 8002E3F4 6402B3AF */  sw         $s3, 0x264($sp)
    /* 1EBF8 8002E3F8 6002B2AF */  sw         $s2, 0x260($sp)
    /* 1EBFC 8002E3FC 5C02B1AF */  sw         $s1, 0x25C($sp)
    /* 1EC00 8002E400 5802B0AF */  sw         $s0, 0x258($sp)
    /* 1EC04 8002E404 4800A8AF */  sw         $t0, 0x48($sp)
    /* 1EC08 8002E408 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EC0C 8002E40C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EC10 8002E410 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1EC14 8002E414 5C000524 */  addiu      $a1, $zero, 0x5C
    /* 1EC18 8002E418 0380073C */  lui        $a3, %hi(MenuExtended_SetTwoPlayer__FR12tMenuCommand)
    /* 1EC1C 8002E41C 2CC1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetTwoPlayer__FR12tMenuCommand)
    /* 1EC20 8002E420 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EC24 8002E424 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EC28 8002E428 28000224 */  addiu      $v0, $zero, 0x28
    /* 1EC2C 8002E42C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EC30 8002E430 2C000825 */  addiu      $t0, $t0, 0x2C
    /* 1EC34 8002E434 21200001 */  addu       $a0, $t0, $zero
    /* 1EC38 8002E438 20092925 */  addiu      $t1, $t1, 0x920
    /* 1EC3C 8002E43C 21302001 */  addu       $a2, $t1, $zero
    /* 1EC40 8002E440 4C00A8AF */  sw         $t0, 0x4C($sp)
    /* 1EC44 8002E444 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EC48 8002E448 5000A9AF */  sw         $t1, 0x50($sp)
    /* 1EC4C 8002E44C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EC50 8002E450 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1EC54 8002E454 5E000524 */  addiu      $a1, $zero, 0x5E
    /* 1EC58 8002E458 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EC5C 8002E45C 21380000 */  addu       $a3, $zero, $zero
    /* 1EC60 8002E460 58003325 */  addiu      $s3, $t1, 0x58
    /* 1EC64 8002E464 21206002 */  addu       $a0, $s3, $zero
    /* 1EC68 8002E468 84012825 */  addiu      $t0, $t1, 0x184
    /* 1EC6C 8002E46C 21300001 */  addu       $a2, $t0, $zero
    /* 1EC70 8002E470 32000924 */  addiu      $t1, $zero, 0x32
    /* 1EC74 8002E474 5400A8AF */  sw         $t0, 0x54($sp)
    /* 1EC78 8002E478 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EC7C 8002E47C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1EC80 8002E480 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EC84 8002E484 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1EC88 8002E488 5D000524 */  addiu      $a1, $zero, 0x5D
    /* 1EC8C 8002E48C 21380000 */  addu       $a3, $zero, $zero
    /* 1EC90 8002E490 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 1EC94 8002E494 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EC98 8002E498 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EC9C 8002E49C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1ECA0 8002E4A0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1ECA4 8002E4A4 84003025 */  addiu      $s0, $t1, 0x84
    /* 1ECA8 8002E4A8 21200002 */  addu       $a0, $s0, $zero
    /* 1ECAC 8002E4AC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1ECB0 8002E4B0 F0242625 */   addiu     $a2, $t1, 0x24F0
    /* 1ECB4 8002E4B4 14100524 */  addiu      $a1, $zero, 0x1014
    /* 1ECB8 8002E4B8 0580083C */  lui        $t0, %hi(screenMain)
    /* 1ECBC 8002E4BC 21380000 */  addu       $a3, $zero, $zero
    /* 1ECC0 8002E4C0 8002A98F */  lw         $t1, 0x280($sp)
    /* 1ECC4 8002E4C4 581E068D */  lw         $a2, %lo(screenMain)($t0)
    /* 1ECC8 8002E4C8 B0002425 */  addiu      $a0, $t1, 0xB0
    /* 1ECCC 8002E4CC 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 1ECD0 8002E4D0 4C00A98F */  lw         $t1, 0x4C($sp)
    /* 1ECD4 8002E4D4 B4000224 */  addiu      $v0, $zero, 0xB4
    /* 1ECD8 8002E4D8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1ECDC 8002E4DC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1ECE0 8002E4E0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1ECE4 8002E4E4 2400B0AF */  sw         $s0, 0x24($sp)
    /* 1ECE8 8002E4E8 2800B3AF */  sw         $s3, 0x28($sp)
    /* 1ECEC 8002E4EC 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1ECF0 8002E4F0 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1ECF4 8002E4F4 2000A9AF */   sw        $t1, 0x20($sp)
    /* 1ECF8 8002E4F8 63000524 */  addiu      $a1, $zero, 0x63
    /* 1ECFC 8002E4FC 0380073C */  lui        $a3, %hi(MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand)
    /* 1ED00 8002E500 44E1E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand)
    /* 1ED04 8002E504 8002A88F */  lw         $t0, 0x280($sp)
    /* 1ED08 8002E508 8002A98F */  lw         $t1, 0x280($sp)
    /* 1ED0C 8002E50C 2C010825 */  addiu      $t0, $t0, 0x12C
    /* 1ED10 8002E510 21200001 */  addu       $a0, $t0, $zero
    /* 1ED14 8002E514 88333025 */  addiu      $s0, $t1, 0x3388
    /* 1ED18 8002E518 21300002 */  addu       $a2, $s0, $zero
    /* 1ED1C 8002E51C 5800A8AF */  sw         $t0, 0x58($sp)
    /* 1ED20 8002E520 32000824 */  addiu      $t0, $zero, 0x32
    /* 1ED24 8002E524 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1ED28 8002E528 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1ED2C 8002E52C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1ED30 8002E530 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1ED34 8002E534 69000524 */  addiu      $a1, $zero, 0x69
    /* 1ED38 8002E538 21300002 */  addu       $a2, $s0, $zero
    /* 1ED3C 8002E53C 0380073C */  lui        $a3, %hi(MenuExtended_GoToSETrophyRoom__FR12tMenuCommand)
    /* 1ED40 8002E540 50E1E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToSETrophyRoom__FR12tMenuCommand)
    /* 1ED44 8002E544 8002A88F */  lw         $t0, 0x280($sp)
    /* 1ED48 8002E548 32000924 */  addiu      $t1, $zero, 0x32
    /* 1ED4C 8002E54C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1ED50 8002E550 58011325 */  addiu      $s3, $t0, 0x158
    /* 1ED54 8002E554 21206002 */  addu       $a0, $s3, $zero
    /* 1ED58 8002E558 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1ED5C 8002E55C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1ED60 8002E560 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1ED64 8002E564 14100524 */  addiu      $a1, $zero, 0x1014
    /* 1ED68 8002E568 0580093C */  lui        $t1, %hi(screenMain)
    /* 1ED6C 8002E56C 21380000 */  addu       $a3, $zero, $zero
    /* 1ED70 8002E570 5400A48F */  lw         $a0, 0x54($sp)
    /* 1ED74 8002E574 581E268D */  lw         $a2, %lo(screenMain)($t1)
    /* 1ED78 8002E578 5800A88F */  lw         $t0, 0x58($sp)
    /* 1ED7C 8002E57C 5F000224 */  addiu      $v0, $zero, 0x5F
    /* 1ED80 8002E580 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1ED84 8002E584 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1ED88 8002E588 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1ED8C 8002E58C 2000B3AF */  sw         $s3, 0x20($sp)
    /* 1ED90 8002E590 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1ED94 8002E594 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1ED98 8002E598 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 1ED9C 8002E59C 00400524 */  addiu      $a1, $zero, 0x4000
    /* 1EDA0 8002E5A0 0580023C */  lui        $v0, %hi(screenTrophyInfo)
    /* 1EDA4 8002E5A4 21380000 */  addu       $a3, $zero, $zero
    /* 1EDA8 8002E5A8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EDAC 8002E5AC 8820468C */  lw         $a2, %lo(screenTrophyInfo)($v0)
    /* 1EDB0 8002E5B0 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 1EDB4 8002E5B4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1EDB8 8002E5B8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1EDBC 8002E5BC 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1EDC0 8002E5C0 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 1EDC4 8002E5C4 00022425 */   addiu     $a0, $t1, 0x200
    /* 1EDC8 8002E5C8 A1000524 */  addiu      $a1, $zero, 0xA1
    /* 1EDCC 8002E5CC 0380073C */  lui        $a3, %hi(MenuExtended_SetBeginner__FR12tMenuCommand)
    /* 1EDD0 8002E5D0 60E1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetBeginner__FR12tMenuCommand)
    /* 1EDD4 8002E5D4 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EDD8 8002E5D8 8C000224 */  addiu      $v0, $zero, 0x8C
    /* 1EDDC 8002E5DC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EDE0 8002E5E0 7C023325 */  addiu      $s3, $t1, 0x27C
    /* 1EDE4 8002E5E4 21206002 */  addu       $a0, $s3, $zero
    /* 1EDE8 8002E5E8 200D2825 */  addiu      $t0, $t1, 0xD20
    /* 1EDEC 8002E5EC 21300001 */  addu       $a2, $t0, $zero
    /* 1EDF0 8002E5F0 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EDF4 8002E5F4 5C00A8AF */  sw         $t0, 0x5C($sp)
    /* 1EDF8 8002E5F8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EDFC 8002E5FC 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1EE00 8002E600 A2000524 */  addiu      $a1, $zero, 0xA2
    /* 1EE04 8002E604 0380073C */  lui        $a3, %hi(MenuExtended_SetIntermediate__FR12tMenuCommand)
    /* 1EE08 8002E608 6CE1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetIntermediate__FR12tMenuCommand)
    /* 1EE0C 8002E60C 96000224 */  addiu      $v0, $zero, 0x96
    /* 1EE10 8002E610 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EE14 8002E614 5C00A68F */  lw         $a2, 0x5C($sp)
    /* 1EE18 8002E618 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EE1C 8002E61C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EE20 8002E620 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1EE24 8002E624 A8020825 */  addiu      $t0, $t0, 0x2A8
    /* 1EE28 8002E628 21200001 */  addu       $a0, $t0, $zero
    /* 1EE2C 8002E62C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EE30 8002E630 6000A8AF */   sw        $t0, 0x60($sp)
    /* 1EE34 8002E634 A3000524 */  addiu      $a1, $zero, 0xA3
    /* 1EE38 8002E638 0380073C */  lui        $a3, %hi(MenuExtended_SetExpert__FR12tMenuCommand)
    /* 1EE3C 8002E63C 7CE1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetExpert__FR12tMenuCommand)
    /* 1EE40 8002E640 A0000224 */  addiu      $v0, $zero, 0xA0
    /* 1EE44 8002E644 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EE48 8002E648 5C00A68F */  lw         $a2, 0x5C($sp)
    /* 1EE4C 8002E64C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EE50 8002E650 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EE54 8002E654 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1EE58 8002E658 D4021025 */  addiu      $s0, $t0, 0x2D4
    /* 1EE5C 8002E65C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EE60 8002E660 21200002 */   addu      $a0, $s0, $zero
    /* 1EE64 8002E664 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1EE68 8002E668 0580093C */  lui        $t1, %hi(screenMain)
    /* 1EE6C 8002E66C 21380000 */  addu       $a3, $zero, $zero
    /* 1EE70 8002E670 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EE74 8002E674 581E268D */  lw         $a2, %lo(screenMain)($t1)
    /* 1EE78 8002E678 B7000224 */  addiu      $v0, $zero, 0xB7
    /* 1EE7C 8002E67C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1EE80 8002E680 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1EE84 8002E684 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1EE88 8002E688 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1EE8C 8002E68C 2400B0AF */  sw         $s0, 0x24($sp)
    /* 1EE90 8002E690 2800A0AF */  sw         $zero, 0x28($sp)
    /* 1EE94 8002E694 00031E25 */  addiu      $fp, $t0, 0x300
    /* 1EE98 8002E698 6000A88F */  lw         $t0, 0x60($sp)
    /* 1EE9C 8002E69C 2120C003 */  addu       $a0, $fp, $zero
    /* 1EEA0 8002E6A0 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1EEA4 8002E6A4 2000A8AF */   sw        $t0, 0x20($sp)
    /* 1EEA8 8002E6A8 60000524 */  addiu      $a1, $zero, 0x60
    /* 1EEAC 8002E6AC 0380073C */  lui        $a3, %hi(MenuExtended_SetTestDrive__FR12tMenuCommand)
    /* 1EEB0 8002E6B0 7CC1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetTestDrive__FR12tMenuCommand)
    /* 1EEB4 8002E6B4 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EEB8 8002E6B8 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EEBC 8002E6BC 7C032925 */  addiu      $t1, $t1, 0x37C
    /* 1EEC0 8002E6C0 21202001 */  addu       $a0, $t1, $zero
    /* 1EEC4 8002E6C4 9C0D0825 */  addiu      $t0, $t0, 0xD9C
    /* 1EEC8 8002E6C8 21300001 */  addu       $a2, $t0, $zero
    /* 1EECC 8002E6CC 6400A9AF */  sw         $t1, 0x64($sp)
    /* 1EED0 8002E6D0 F0000924 */  addiu      $t1, $zero, 0xF0
    /* 1EED4 8002E6D4 6800A8AF */  sw         $t0, 0x68($sp)
    /* 1EED8 8002E6D8 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EEDC 8002E6DC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1EEE0 8002E6E0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EEE4 8002E6E4 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1EEE8 8002E6E8 72000524 */  addiu      $a1, $zero, 0x72
    /* 1EEEC 8002E6EC 0380073C */  lui        $a3, %hi(MenuExtended_SetSingleRace__FR12tMenuCommand)
    /* 1EEF0 8002E6F0 98C1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetSingleRace__FR12tMenuCommand)
    /* 1EEF4 8002E6F4 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EEF8 8002E6F8 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EEFC 8002E6FC A8032925 */  addiu      $t1, $t1, 0x3A8
    /* 1EF00 8002E700 21202001 */  addu       $a0, $t1, $zero
    /* 1EF04 8002E704 58050825 */  addiu      $t0, $t0, 0x558
    /* 1EF08 8002E708 21300001 */  addu       $a2, $t0, $zero
    /* 1EF0C 8002E70C 6C00A9AF */  sw         $t1, 0x6C($sp)
    /* 1EF10 8002E710 46000924 */  addiu      $t1, $zero, 0x46
    /* 1EF14 8002E714 7000A8AF */  sw         $t0, 0x70($sp)
    /* 1EF18 8002E718 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EF1C 8002E71C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1EF20 8002E720 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EF24 8002E724 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1EF28 8002E728 71000524 */  addiu      $a1, $zero, 0x71
    /* 1EF2C 8002E72C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EF30 8002E730 0380073C */  lui        $a3, %hi(MenuExtended_SetHotPursuit__FR12tMenuCommand)
    /* 1EF34 8002E734 50D3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetHotPursuit__FR12tMenuCommand)
    /* 1EF38 8002E738 D4033325 */  addiu      $s3, $t1, 0x3D4
    /* 1EF3C 8002E73C 21206002 */  addu       $a0, $s3, $zero
    /* 1EF40 8002E740 2C062825 */  addiu      $t0, $t1, 0x62C
    /* 1EF44 8002E744 21300001 */  addu       $a2, $t0, $zero
    /* 1EF48 8002E748 50000924 */  addiu      $t1, $zero, 0x50
    /* 1EF4C 8002E74C 7400A8AF */  sw         $t0, 0x74($sp)
    /* 1EF50 8002E750 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1EF54 8002E754 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1EF58 8002E758 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EF5C 8002E75C 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1EF60 8002E760 63000524 */  addiu      $a1, $zero, 0x63
    /* 1EF64 8002E764 0380073C */  lui        $a3, %hi(MenuExtended_SetTournament__FR12tMenuCommand)
    /* 1EF68 8002E768 D8C1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetTournament__FR12tMenuCommand)
    /* 1EF6C 8002E76C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1EF70 8002E770 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EF74 8002E774 5A000224 */  addiu      $v0, $zero, 0x5A
    /* 1EF78 8002E778 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1EF7C 8002E77C 00042925 */  addiu      $t1, $t1, 0x400
    /* 1EF80 8002E780 21202001 */  addu       $a0, $t1, $zero
    /* 1EF84 8002E784 10070825 */  addiu      $t0, $t0, 0x710
    /* 1EF88 8002E788 21300001 */  addu       $a2, $t0, $zero
    /* 1EF8C 8002E78C 7800A9AF */  sw         $t1, 0x78($sp)
    /* 1EF90 8002E790 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EF94 8002E794 7C00A8AF */  sw         $t0, 0x7C($sp)
    /* 1EF98 8002E798 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EF9C 8002E79C 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1EFA0 8002E7A0 69000524 */  addiu      $a1, $zero, 0x69
    /* 1EFA4 8002E7A4 0380073C */  lui        $a3, %hi(MenuExtended_SetSpecialEvent__FR12tMenuCommand)
    /* 1EFA8 8002E7A8 8002A88F */  lw         $t0, 0x280($sp)
    /* 1EFAC 8002E7AC 20C2E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetSpecialEvent__FR12tMenuCommand)
    /* 1EFB0 8002E7B0 2C041025 */  addiu      $s0, $t0, 0x42C
    /* 1EFB4 8002E7B4 21200002 */  addu       $a0, $s0, $zero
    /* 1EFB8 8002E7B8 F4070925 */  addiu      $t1, $t0, 0x7F4
    /* 1EFBC 8002E7BC 21302001 */  addu       $a2, $t1, $zero
    /* 1EFC0 8002E7C0 64000824 */  addiu      $t0, $zero, 0x64
    /* 1EFC4 8002E7C4 8000A9AF */  sw         $t1, 0x80($sp)
    /* 1EFC8 8002E7C8 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1EFCC 8002E7CC 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1EFD0 8002E7D0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1EFD4 8002E7D4 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1EFD8 8002E7D8 0580083C */  lui        $t0, %hi(screenMain)
    /* 1EFDC 8002E7DC 4800A48F */  lw         $a0, 0x48($sp)
    /* 1EFE0 8002E7E0 581E068D */  lw         $a2, %lo(screenMain)($t0)
    /* 1EFE4 8002E7E4 6400A88F */  lw         $t0, 0x64($sp)
    /* 1EFE8 8002E7E8 B5000924 */  addiu      $t1, $zero, 0xB5
    /* 1EFEC 8002E7EC 1800A9AF */  sw         $t1, 0x18($sp)
    /* 1EFF0 8002E7F0 6C00A98F */  lw         $t1, 0x6C($sp)
    /* 1EFF4 8002E7F4 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1EFF8 8002E7F8 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 1EFFC 8002E7FC 7800A88F */  lw         $t0, 0x78($sp)
    /* 1F000 8002E800 21380000 */  addu       $a3, $zero, $zero
    /* 1F004 8002E804 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F008 8002E808 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1F00C 8002E80C 2400B3AF */  sw         $s3, 0x24($sp)
    /* 1F010 8002E810 2C00B0AF */  sw         $s0, 0x2C($sp)
    /* 1F014 8002E814 3000A0AF */  sw         $zero, 0x30($sp)
    /* 1F018 8002E818 2000A9AF */  sw         $t1, 0x20($sp)
    /* 1F01C 8002E81C 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F020 8002E820 2800A8AF */   sw        $t0, 0x28($sp)
    /* 1F024 8002E824 6C000524 */  addiu      $a1, $zero, 0x6C
    /* 1F028 8002E828 0380073C */  lui        $a3, %hi(MenuExtended_SetSoloRace__FR12tMenuCommand)
    /* 1F02C 8002E82C 68C2E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetSoloRace__FR12tMenuCommand)
    /* 1F030 8002E830 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F034 8002E834 5C00A68F */  lw         $a2, 0x5C($sp)
    /* 1F038 8002E838 6E000824 */  addiu      $t0, $zero, 0x6E
    /* 1F03C 8002E83C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F040 8002E840 D4043325 */  addiu      $s3, $t1, 0x4D4
    /* 1F044 8002E844 21206002 */  addu       $a0, $s3, $zero
    /* 1F048 8002E848 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F04C 8002E84C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F050 8002E850 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F054 8002E854 6D000524 */  addiu      $a1, $zero, 0x6D
    /* 1F058 8002E858 2130C003 */  addu       $a2, $fp, $zero
    /* 1F05C 8002E85C 0380073C */  lui        $a3, %hi(MenuExtended_SetDuelRace__FR12tMenuCommand)
    /* 1F060 8002E860 9CC3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetDuelRace__FR12tMenuCommand)
    /* 1F064 8002E864 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F068 8002E868 78000924 */  addiu      $t1, $zero, 0x78
    /* 1F06C 8002E86C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F070 8002E870 00050825 */  addiu      $t0, $t0, 0x500
    /* 1F074 8002E874 21200001 */  addu       $a0, $t0, $zero
    /* 1F078 8002E878 8400A8AF */  sw         $t0, 0x84($sp)
    /* 1F07C 8002E87C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F080 8002E880 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F084 8002E884 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F088 8002E888 6F000524 */  addiu      $a1, $zero, 0x6F
    /* 1F08C 8002E88C 2130C003 */  addu       $a2, $fp, $zero
    /* 1F090 8002E890 0380073C */  lui        $a3, %hi(MenuExtended_SetFullGrid__FR12tMenuCommand)
    /* 1F094 8002E894 DCC3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetFullGrid__FR12tMenuCommand)
    /* 1F098 8002E898 82000224 */  addiu      $v0, $zero, 0x82
    /* 1F09C 8002E89C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F0A0 8002E8A0 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F0A4 8002E8A4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1F0A8 8002E8A8 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F0AC 8002E8AC 2C053025 */  addiu      $s0, $t1, 0x52C
    /* 1F0B0 8002E8B0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F0B4 8002E8B4 21200002 */   addu      $a0, $s0, $zero
    /* 1F0B8 8002E8B8 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1F0BC 8002E8BC 0580093C */  lui        $t1, %hi(screenMain)
    /* 1F0C0 8002E8C0 21380000 */  addu       $a3, $zero, $zero
    /* 1F0C4 8002E8C4 7000A48F */  lw         $a0, 0x70($sp)
    /* 1F0C8 8002E8C8 581E268D */  lw         $a2, %lo(screenMain)($t1)
    /* 1F0CC 8002E8CC 8400A98F */  lw         $t1, 0x84($sp)
    /* 1F0D0 8002E8D0 B6000824 */  addiu      $t0, $zero, 0xB6
    /* 1F0D4 8002E8D4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F0D8 8002E8D8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1F0DC 8002E8DC 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1F0E0 8002E8E0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1F0E4 8002E8E4 2400B0AF */  sw         $s0, 0x24($sp)
    /* 1F0E8 8002E8E8 2800A0AF */  sw         $zero, 0x28($sp)
    /* 1F0EC 8002E8EC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F0F0 8002E8F0 2000A9AF */   sw        $t1, 0x20($sp)
    /* 1F0F4 8002E8F4 6C000524 */  addiu      $a1, $zero, 0x6C
    /* 1F0F8 8002E8F8 2130C003 */  addu       $a2, $fp, $zero
    /* 1F0FC 8002E8FC 0380073C */  lui        $a3, %hi(MenuExtended_SetHPSoloRace__FR12tMenuCommand)
    /* 1F100 8002E900 F8D2E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetHPSoloRace__FR12tMenuCommand)
    /* 1F104 8002E904 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F108 8002E908 6E000924 */  addiu      $t1, $zero, 0x6E
    /* 1F10C 8002E90C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F110 8002E910 D4050825 */  addiu      $t0, $t0, 0x5D4
    /* 1F114 8002E914 21200001 */  addu       $a0, $t0, $zero
    /* 1F118 8002E918 8800A8AF */  sw         $t0, 0x88($sp)
    /* 1F11C 8002E91C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F120 8002E920 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F124 8002E924 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F128 8002E928 6D000524 */  addiu      $a1, $zero, 0x6D
    /* 1F12C 8002E92C 2130C003 */  addu       $a2, $fp, $zero
    /* 1F130 8002E930 0380073C */  lui        $a3, %hi(MenuExtended_SetHPDuelRace__FR12tMenuCommand)
    /* 1F134 8002E934 24D3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetHPDuelRace__FR12tMenuCommand)
    /* 1F138 8002E938 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F13C 8002E93C 78000824 */  addiu      $t0, $zero, 0x78
    /* 1F140 8002E940 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F144 8002E944 00063025 */  addiu      $s0, $t1, 0x600
    /* 1F148 8002E948 21200002 */  addu       $a0, $s0, $zero
    /* 1F14C 8002E94C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F150 8002E950 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F154 8002E954 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F158 8002E958 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1F15C 8002E95C 0580083C */  lui        $t0, %hi(screenMain)
    /* 1F160 8002E960 21380000 */  addu       $a3, $zero, $zero
    /* 1F164 8002E964 7400A48F */  lw         $a0, 0x74($sp)
    /* 1F168 8002E968 581E068D */  lw         $a2, %lo(screenMain)($t0)
    /* 1F16C 8002E96C 8800A88F */  lw         $t0, 0x88($sp)
    /* 1F170 8002E970 B6000924 */  addiu      $t1, $zero, 0xB6
    /* 1F174 8002E974 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F178 8002E978 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1F17C 8002E97C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 1F180 8002E980 2000B0AF */  sw         $s0, 0x20($sp)
    /* 1F184 8002E984 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1F188 8002E988 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F18C 8002E98C 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 1F190 8002E990 1180053C */  lui        $a1, %hi(D_80114720)
    /* 1F194 8002E994 2047A524 */  addiu      $a1, $a1, %lo(D_80114720)
    /* 1F198 8002E998 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F19C 8002E99C 1180063C */  lui        $a2, %hi(tournamentManager)
    /* 1F1A0 8002E9A0 D84AC624 */  addiu      $a2, $a2, %lo(tournamentManager)
    /* 1F1A4 8002E9A4 A8062925 */  addiu      $t1, $t1, 0x6A8
    /* 1F1A8 8002E9A8 21202001 */  addu       $a0, $t1, $zero
    /* 1F1AC 8002E9AC 67CF000C */  jal        __23tListIteratorTournamentPcP18tTournamentManager
    /* 1F1B0 8002E9B0 8C00A9AF */   sw        $t1, 0x8C($sp)
    /* 1F1B4 8002E9B4 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 1F1B8 8002E9B8 21300000 */  addu       $a2, $zero, $zero
    /* 1F1BC 8002E9BC 0380103C */  lui        $s0, %hi(MenuExtended_GoToTournTrackInfo__FR12tMenuCommand)
    /* 1F1C0 8002E9C0 40CF1026 */  addiu      $s0, $s0, %lo(MenuExtended_GoToTournTrackInfo__FR12tMenuCommand)
    /* 1F1C4 8002E9C4 21380002 */  addu       $a3, $s0, $zero
    /* 1F1C8 8002E9C8 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F1CC 8002E9CC 22000924 */  addiu      $t1, $zero, 0x22
    /* 1F1D0 8002E9D0 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F1D4 8002E9D4 BC060825 */  addiu      $t0, $t0, 0x6BC
    /* 1F1D8 8002E9D8 21200001 */  addu       $a0, $t0, $zero
    /* 1F1DC 8002E9DC 9000A8AF */  sw         $t0, 0x90($sp)
    /* 1F1E0 8002E9E0 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F1E4 8002E9E4 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F1E8 8002E9E8 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F1EC 8002E9EC 94000524 */  addiu      $a1, $zero, 0x94
    /* 1F1F0 8002E9F0 2C000724 */  addiu      $a3, $zero, 0x2C
    /* 1F1F4 8002E9F4 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F1F8 8002E9F8 8C00A68F */  lw         $a2, 0x8C($sp)
    /* 1F1FC 8002E9FC 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F200 8002EA00 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F204 8002EA04 E8063325 */  addiu      $s3, $t1, 0x6E8
    /* 1F208 8002EA08 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F20C 8002EA0C 21206002 */   addu      $a0, $s3, $zero
    /* 1F210 8002EA10 00100524 */  addiu      $a1, $zero, 0x1000
    /* 1F214 8002EA14 0580093C */  lui        $t1, %hi(screenTournSelect)
    /* 1F218 8002EA18 21380000 */  addu       $a3, $zero, $zero
    /* 1F21C 8002EA1C 7C00A48F */  lw         $a0, 0x7C($sp)
    /* 1F220 8002EA20 5C20268D */  lw         $a2, %lo(screenTournSelect)($t1)
    /* 1F224 8002EA24 9000A88F */  lw         $t0, 0x90($sp)
    /* 1F228 8002EA28 65000224 */  addiu      $v0, $zero, 0x65
    /* 1F22C 8002EA2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F230 8002EA30 1400B0AF */  sw         $s0, 0x14($sp)
    /* 1F234 8002EA34 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1F238 8002EA38 2000B3AF */  sw         $s3, 0x20($sp)
    /* 1F23C 8002EA3C 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1F240 8002EA40 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F244 8002EA44 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 1F248 8002EA48 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F24C 8002EA4C 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F250 8002EA50 01000525 */  addiu      $a1, $t0, 0x1
    /* 1F254 8002EA54 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F258 8002EA58 1180063C */  lui        $a2, %hi(tournamentManager)
    /* 1F25C 8002EA5C D84AC624 */  addiu      $a2, $a2, %lo(tournamentManager)
    /* 1F260 8002EA60 8C073325 */  addiu      $s3, $t1, 0x78C
    /* 1F264 8002EA64 67CF000C */  jal        __23tListIteratorTournamentPcP18tTournamentManager
    /* 1F268 8002EA68 21206002 */   addu      $a0, $s3, $zero
    /* 1F26C 8002EA6C 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 1F270 8002EA70 21300000 */  addu       $a2, $zero, $zero
    /* 1F274 8002EA74 0380103C */  lui        $s0, %hi(MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand)
    /* 1F278 8002EA78 A8D01026 */  addiu      $s0, $s0, %lo(MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand)
    /* 1F27C 8002EA7C 21380002 */  addu       $a3, $s0, $zero
    /* 1F280 8002EA80 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F284 8002EA84 22000824 */  addiu      $t0, $zero, 0x22
    /* 1F288 8002EA88 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F28C 8002EA8C A0072925 */  addiu      $t1, $t1, 0x7A0
    /* 1F290 8002EA90 21202001 */  addu       $a0, $t1, $zero
    /* 1F294 8002EA94 9400A9AF */  sw         $t1, 0x94($sp)
    /* 1F298 8002EA98 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F29C 8002EA9C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F2A0 8002EAA0 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F2A4 8002EAA4 69000524 */  addiu      $a1, $zero, 0x69
    /* 1F2A8 8002EAA8 21306002 */  addu       $a2, $s3, $zero
    /* 1F2AC 8002EAAC 36000724 */  addiu      $a3, $zero, 0x36
    /* 1F2B0 8002EAB0 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F2B4 8002EAB4 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F2B8 8002EAB8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F2BC 8002EABC CC070825 */  addiu      $t0, $t0, 0x7CC
    /* 1F2C0 8002EAC0 21200001 */  addu       $a0, $t0, $zero
    /* 1F2C4 8002EAC4 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F2C8 8002EAC8 9800A8AF */   sw        $t0, 0x98($sp)
    /* 1F2CC 8002EACC 00100524 */  addiu      $a1, $zero, 0x1000
    /* 1F2D0 8002EAD0 0580083C */  lui        $t0, %hi(screenTournSelect)
    /* 1F2D4 8002EAD4 8000A48F */  lw         $a0, 0x80($sp)
    /* 1F2D8 8002EAD8 5C20068D */  lw         $a2, %lo(screenTournSelect)($t0)
    /* 1F2DC 8002EADC 9400A88F */  lw         $t0, 0x94($sp)
    /* 1F2E0 8002EAE0 64000924 */  addiu      $t1, $zero, 0x64
    /* 1F2E4 8002EAE4 1800A9AF */  sw         $t1, 0x18($sp)
    /* 1F2E8 8002EAE8 9800A98F */  lw         $t1, 0x98($sp)
    /* 1F2EC 8002EAEC 21380000 */  addu       $a3, $zero, $zero
    /* 1F2F0 8002EAF0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F2F4 8002EAF4 1400B0AF */  sw         $s0, 0x14($sp)
    /* 1F2F8 8002EAF8 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1F2FC 8002EAFC 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 1F300 8002EB00 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F304 8002EB04 2000A9AF */   sw        $t1, 0x20($sp)
    /* 1F308 8002EB08 60000524 */  addiu      $a1, $zero, 0x60
    /* 1F30C 8002EB0C 0380073C */  lui        $a3, %hi(MenuExtended_SetTestDrive__FR12tMenuCommand)
    /* 1F310 8002EB10 7CC1E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetTestDrive__FR12tMenuCommand)
    /* 1F314 8002EB14 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F318 8002EB18 6800A68F */  lw         $a2, 0x68($sp)
    /* 1F31C 8002EB1C F0000924 */  addiu      $t1, $zero, 0xF0
    /* 1F320 8002EB20 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F324 8002EB24 70080825 */  addiu      $t0, $t0, 0x870
    /* 1F328 8002EB28 21200001 */  addu       $a0, $t0, $zero
    /* 1F32C 8002EB2C 9C00A8AF */  sw         $t0, 0x9C($sp)
    /* 1F330 8002EB30 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F334 8002EB34 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F338 8002EB38 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F33C 8002EB3C 72000524 */  addiu      $a1, $zero, 0x72
    /* 1F340 8002EB40 21300000 */  addu       $a2, $zero, $zero
    /* 1F344 8002EB44 0380073C */  lui        $a3, %hi(MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand)
    /* 1F348 8002EB48 88C2E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand)
    /* 1F34C 8002EB4C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F350 8002EB50 46000824 */  addiu      $t0, $zero, 0x46
    /* 1F354 8002EB54 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F358 8002EB58 9C082925 */  addiu      $t1, $t1, 0x89C
    /* 1F35C 8002EB5C 21202001 */  addu       $a0, $t1, $zero
    /* 1F360 8002EB60 A000A9AF */  sw         $t1, 0xA0($sp)
    /* 1F364 8002EB64 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F368 8002EB68 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F36C 8002EB6C 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F370 8002EB70 71000524 */  addiu      $a1, $zero, 0x71
    /* 1F374 8002EB74 2130C003 */  addu       $a2, $fp, $zero
    /* 1F378 8002EB78 0380073C */  lui        $a3, %hi(MenuExtended_SetHotPursuit__FR12tMenuCommand)
    /* 1F37C 8002EB7C 50D3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SetHotPursuit__FR12tMenuCommand)
    /* 1F380 8002EB80 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F384 8002EB84 50000924 */  addiu      $t1, $zero, 0x50
    /* 1F388 8002EB88 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F38C 8002EB8C C8081325 */  addiu      $s3, $t0, 0x8C8
    /* 1F390 8002EB90 21206002 */  addu       $a0, $s3, $zero
    /* 1F394 8002EB94 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F398 8002EB98 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F39C 8002EB9C 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F3A0 8002EBA0 6A000524 */  addiu      $a1, $zero, 0x6A
    /* 1F3A4 8002EBA4 0380073C */  lui        $a3, %hi(MenuExtended_SetPinkSlips__FR12tMenuCommand)
    /* 1F3A8 8002EBA8 B4DDE724 */  addiu      $a3, $a3, %lo(MenuExtended_SetPinkSlips__FR12tMenuCommand)
    /* 1F3AC 8002EBAC 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F3B0 8002EBB0 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F3B4 8002EBB4 AA001024 */  addiu      $s0, $zero, 0xAA
    /* 1F3B8 8002EBB8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1F3BC 8002EBBC F4082925 */  addiu      $t1, $t1, 0x8F4
    /* 1F3C0 8002EBC0 21202001 */  addu       $a0, $t1, $zero
    /* 1F3C4 8002EBC4 200A0825 */  addiu      $t0, $t0, 0xA20
    /* 1F3C8 8002EBC8 21300001 */  addu       $a2, $t0, $zero
    /* 1F3CC 8002EBCC A400A9AF */  sw         $t1, 0xA4($sp)
    /* 1F3D0 8002EBD0 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F3D4 8002EBD4 A800A8AF */  sw         $t0, 0xA8($sp)
    /* 1F3D8 8002EBD8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F3DC 8002EBDC 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F3E0 8002EBE0 0580083C */  lui        $t0, %hi(screenMain)
    /* 1F3E4 8002EBE4 5000A48F */  lw         $a0, 0x50($sp)
    /* 1F3E8 8002EBE8 581E068D */  lw         $a2, %lo(screenMain)($t0)
    /* 1F3EC 8002EBEC 9C00A88F */  lw         $t0, 0x9C($sp)
    /* 1F3F0 8002EBF0 B5000924 */  addiu      $t1, $zero, 0xB5
    /* 1F3F4 8002EBF4 1800A9AF */  sw         $t1, 0x18($sp)
    /* 1F3F8 8002EBF8 A000A98F */  lw         $t1, 0xA0($sp)
    /* 1F3FC 8002EBFC 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1F400 8002EC00 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 1F404 8002EC04 A400A88F */  lw         $t0, 0xA4($sp)
    /* 1F408 8002EC08 21380000 */  addu       $a3, $zero, $zero
    /* 1F40C 8002EC0C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F410 8002EC10 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1F414 8002EC14 2400B3AF */  sw         $s3, 0x24($sp)
    /* 1F418 8002EC18 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1F41C 8002EC1C 2000A9AF */  sw         $t1, 0x20($sp)
    /* 1F420 8002EC20 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F424 8002EC24 2800A8AF */   sw        $t0, 0x28($sp)
    /* 1F428 8002EC28 C0000524 */  addiu      $a1, $zero, 0xC0
    /* 1F42C 8002EC2C 0380073C */  lui        $a3, %hi(MenuExtended_GoToBestOfOne__FR12tMenuCommand)
    /* 1F430 8002EC30 84CBE724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToBestOfOne__FR12tMenuCommand)
    /* 1F434 8002EC34 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F438 8002EC38 5C00A68F */  lw         $a2, 0x5C($sp)
    /* 1F43C 8002EC3C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F440 8002EC40 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1F444 8002EC44 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F448 8002EC48 9C092925 */  addiu      $t1, $t1, 0x99C
    /* 1F44C 8002EC4C 21202001 */  addu       $a0, $t1, $zero
    /* 1F450 8002EC50 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F454 8002EC54 AC00A9AF */   sw        $t1, 0xAC($sp)
    /* 1F458 8002EC58 C1000524 */  addiu      $a1, $zero, 0xC1
    /* 1F45C 8002EC5C 0380073C */  lui        $a3, %hi(MenuExtended_GoToBestOfThree__FR12tMenuCommand)
    /* 1F460 8002EC60 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F464 8002EC64 E0CBE724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToBestOfThree__FR12tMenuCommand)
    /* 1F468 8002EC68 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1F46C 8002EC6C C8093325 */  addiu      $s3, $t1, 0x9C8
    /* 1F470 8002EC70 21206002 */  addu       $a0, $s3, $zero
    /* 1F474 8002EC74 900B2825 */  addiu      $t0, $t1, 0xB90
    /* 1F478 8002EC78 21300001 */  addu       $a2, $t0, $zero
    /* 1F47C 8002EC7C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F480 8002EC80 B000A8AF */  sw         $t0, 0xB0($sp)
    /* 1F484 8002EC84 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F488 8002EC88 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F48C 8002EC8C C2000524 */  addiu      $a1, $zero, 0xC2
    /* 1F490 8002EC90 0380073C */  lui        $a3, %hi(MenuExtended_GoToBestOfFive__FR12tMenuCommand)
    /* 1F494 8002EC94 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F498 8002EC98 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F49C 8002EC9C 3CCCE724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToBestOfFive__FR12tMenuCommand)
    /* 1F4A0 8002ECA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1F4A4 8002ECA4 F4090825 */  addiu      $t0, $t0, 0x9F4
    /* 1F4A8 8002ECA8 21200001 */  addu       $a0, $t0, $zero
    /* 1F4AC 8002ECAC 0C0C2925 */  addiu      $t1, $t1, 0xC0C
    /* 1F4B0 8002ECB0 21302001 */  addu       $a2, $t1, $zero
    /* 1F4B4 8002ECB4 B400A8AF */  sw         $t0, 0xB4($sp)
    /* 1F4B8 8002ECB8 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F4BC 8002ECBC B800A9AF */  sw         $t1, 0xB8($sp)
    /* 1F4C0 8002ECC0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F4C4 8002ECC4 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1F4C8 8002ECC8 00100524 */  addiu      $a1, $zero, 0x1000
    /* 1F4CC 8002ECCC 0580093C */  lui        $t1, %hi(screenMain)
    /* 1F4D0 8002ECD0 A800A48F */  lw         $a0, 0xA8($sp)
    /* 1F4D4 8002ECD4 581E268D */  lw         $a2, %lo(screenMain)($t1)
    /* 1F4D8 8002ECD8 AC00A98F */  lw         $t1, 0xAC($sp)
    /* 1F4DC 8002ECDC B6000824 */  addiu      $t0, $zero, 0xB6
    /* 1F4E0 8002ECE0 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1F4E4 8002ECE4 B400A88F */  lw         $t0, 0xB4($sp)
    /* 1F4E8 8002ECE8 21380000 */  addu       $a3, $zero, $zero
    /* 1F4EC 8002ECEC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F4F0 8002ECF0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1F4F4 8002ECF4 2000B3AF */  sw         $s3, 0x20($sp)
    /* 1F4F8 8002ECF8 2800A0AF */  sw         $zero, 0x28($sp)
    /* 1F4FC 8002ECFC 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 1F500 8002ED00 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F504 8002ED04 2400A8AF */   sw        $t0, 0x24($sp)
    /* 1F508 8002ED08 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 1F50C 8002ED0C 21300000 */  addu       $a2, $zero, $zero
    /* 1F510 8002ED10 0380073C */  lui        $a3, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F514 8002ED14 FCC4E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F518 8002ED18 24000224 */  addiu      $v0, $zero, 0x24
    /* 1F51C 8002ED1C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F520 8002ED20 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F524 8002ED24 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1F528 8002ED28 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F52C 8002ED2C 9C0A3E25 */  addiu      $fp, $t1, 0xA9C
    /* 1F530 8002ED30 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F534 8002ED34 2120C003 */   addu      $a0, $fp, $zero
    /* 1F538 8002ED38 C3000524 */  addiu      $a1, $zero, 0xC3
    /* 1F53C 8002ED3C 2E000724 */  addiu      $a3, $zero, 0x2E
    /* 1F540 8002ED40 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F544 8002ED44 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F548 8002ED48 C80A2925 */  addiu      $t1, $t1, 0xAC8
    /* 1F54C 8002ED4C 21202001 */  addu       $a0, $t1, $zero
    /* 1F550 8002ED50 880C1025 */  addiu      $s0, $t0, 0xC88
    /* 1F554 8002ED54 21300002 */  addu       $a2, $s0, $zero
    /* 1F558 8002ED58 BC00A9AF */  sw         $t1, 0xBC($sp)
    /* 1F55C 8002ED5C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F560 8002ED60 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F564 8002ED64 1000A9AF */   sw        $t1, 0x10($sp)
    /* 1F568 8002ED68 C4000524 */  addiu      $a1, $zero, 0xC4
    /* 1F56C 8002ED6C 21300002 */  addu       $a2, $s0, $zero
    /* 1F570 8002ED70 2E000724 */  addiu      $a3, $zero, 0x2E
    /* 1F574 8002ED74 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F578 8002ED78 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F57C 8002ED7C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F580 8002ED80 F00A0825 */  addiu      $t0, $t0, 0xAF0
    /* 1F584 8002ED84 21200001 */  addu       $a0, $t0, $zero
    /* 1F588 8002ED88 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F58C 8002ED8C C000A8AF */   sw        $t0, 0xC0($sp)
    /* 1F590 8002ED90 C5000524 */  addiu      $a1, $zero, 0xC5
    /* 1F594 8002ED94 21300002 */  addu       $a2, $s0, $zero
    /* 1F598 8002ED98 2E000724 */  addiu      $a3, $zero, 0x2E
    /* 1F59C 8002ED9C 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F5A0 8002EDA0 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F5A4 8002EDA4 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F5A8 8002EDA8 180B1325 */  addiu      $s3, $t0, 0xB18
    /* 1F5AC 8002EDAC 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F5B0 8002EDB0 21206002 */   addu      $a0, $s3, $zero
    /* 1F5B4 8002EDB4 C6000524 */  addiu      $a1, $zero, 0xC6
    /* 1F5B8 8002EDB8 21300002 */  addu       $a2, $s0, $zero
    /* 1F5BC 8002EDBC 2E000724 */  addiu      $a3, $zero, 0x2E
    /* 1F5C0 8002EDC0 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F5C4 8002EDC4 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F5C8 8002EDC8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F5CC 8002EDCC 400B1225 */  addiu      $s2, $t0, 0xB40
    /* 1F5D0 8002EDD0 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F5D4 8002EDD4 21204002 */   addu      $a0, $s2, $zero
    /* 1F5D8 8002EDD8 C7000524 */  addiu      $a1, $zero, 0xC7
    /* 1F5DC 8002EDDC 21300002 */  addu       $a2, $s0, $zero
    /* 1F5E0 8002EDE0 2E000724 */  addiu      $a3, $zero, 0x2E
    /* 1F5E4 8002EDE4 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F5E8 8002EDE8 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F5EC 8002EDEC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F5F0 8002EDF0 680B1425 */  addiu      $s4, $t0, 0xB68
    /* 1F5F4 8002EDF4 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F5F8 8002EDF8 21208002 */   addu      $a0, $s4, $zero
    /* 1F5FC 8002EDFC 00140524 */  addiu      $a1, $zero, 0x1400
    /* 1F600 8002EE00 21380000 */  addu       $a3, $zero, $zero
    /* 1F604 8002EE04 0580083C */  lui        $t0, %hi(screenPinkSlips)
    /* 1F608 8002EE08 B000A48F */  lw         $a0, 0xB0($sp)
    /* 1F60C 8002EE0C 641E068D */  lw         $a2, %lo(screenPinkSlips)($t0)
    /* 1F610 8002EE10 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F614 8002EE14 0380083C */  lui        $t0, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F618 8002EE18 FCC40825 */  addiu      $t0, $t0, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F61C 8002EE1C 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F620 8002EE20 C000A88F */  lw         $t0, 0xC0($sp)
    /* 1F624 8002EE24 940F2925 */  addiu      $t1, $t1, 0xF94
    /* 1F628 8002EE28 C400A9AF */  sw         $t1, 0xC4($sp)
    /* 1F62C 8002EE2C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F630 8002EE30 BC00A98F */  lw         $t1, 0xBC($sp)
    /* 1F634 8002EE34 BE000224 */  addiu      $v0, $zero, 0xBE
    /* 1F638 8002EE38 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1F63C 8002EE3C 1C00BEAF */  sw         $fp, 0x1C($sp)
    /* 1F640 8002EE40 2800B3AF */  sw         $s3, 0x28($sp)
    /* 1F644 8002EE44 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1F648 8002EE48 2400A8AF */  sw         $t0, 0x24($sp)
    /* 1F64C 8002EE4C 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F650 8002EE50 2000A9AF */   sw        $t1, 0x20($sp)
    /* 1F654 8002EE54 00140524 */  addiu      $a1, $zero, 0x1400
    /* 1F658 8002EE58 0580093C */  lui        $t1, %hi(screenPinkSlips)
    /* 1F65C 8002EE5C B800A48F */  lw         $a0, 0xB8($sp)
    /* 1F660 8002EE60 641E268D */  lw         $a2, %lo(screenPinkSlips)($t1)
    /* 1F664 8002EE64 C400A88F */  lw         $t0, 0xC4($sp)
    /* 1F668 8002EE68 0380093C */  lui        $t1, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F66C 8002EE6C FCC42925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F670 8002EE70 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1F674 8002EE74 C000A98F */  lw         $t1, 0xC0($sp)
    /* 1F678 8002EE78 21380000 */  addu       $a3, $zero, $zero
    /* 1F67C 8002EE7C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F680 8002EE80 BC00A88F */  lw         $t0, 0xBC($sp)
    /* 1F684 8002EE84 BF000224 */  addiu      $v0, $zero, 0xBF
    /* 1F688 8002EE88 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1F68C 8002EE8C 1C00BEAF */  sw         $fp, 0x1C($sp)
    /* 1F690 8002EE90 2800B3AF */  sw         $s3, 0x28($sp)
    /* 1F694 8002EE94 2C00B2AF */  sw         $s2, 0x2C($sp)
    /* 1F698 8002EE98 3000B4AF */  sw         $s4, 0x30($sp)
    /* 1F69C 8002EE9C 3400A0AF */  sw         $zero, 0x34($sp)
    /* 1F6A0 8002EEA0 2400A9AF */  sw         $t1, 0x24($sp)
    /* 1F6A4 8002EEA4 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F6A8 8002EEA8 2000A8AF */   sw        $t0, 0x20($sp)
    /* 1F6AC 8002EEAC 21200002 */  addu       $a0, $s0, $zero
    /* 1F6B0 8002EEB0 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F6B4 8002EEB4 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F6B8 8002EEB8 03FF0525 */  addiu      $a1, $t0, -0xFD
    /* 1F6BC 8002EEBC 1180063C */  lui        $a2, %hi(D_80114646)
    /* 1F6C0 8002EEC0 4646C624 */  addiu      $a2, $a2, %lo(D_80114646)
    /* 1F6C4 8002EEC4 1180073C */  lui        $a3, %hi(trackManager)
    /* 1F6C8 8002EEC8 5587000C */  jal        __18tListIteratorTrackPcT1P13tTrackManager
    /* 1F6CC 8002EECC 504AE724 */   addiu     $a3, $a3, %lo(trackManager)
    /* 1F6D0 8002EED0 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 1F6D4 8002EED4 21300000 */  addu       $a2, $zero, $zero
    /* 1F6D8 8002EED8 0380073C */  lui        $a3, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F6DC 8002EEDC FCC4E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F6E0 8002EEE0 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 1F6E4 8002EEE4 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F6E8 8002EEE8 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F6EC 8002EEEC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1F6F0 8002EEF0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F6F4 8002EEF4 A00C3E25 */  addiu      $fp, $t1, 0xCA0
    /* 1F6F8 8002EEF8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F6FC 8002EEFC 2120C003 */   addu      $a0, $fp, $zero
    /* 1F700 8002EF00 93000524 */  addiu      $a1, $zero, 0x93
    /* 1F704 8002EF04 21300002 */  addu       $a2, $s0, $zero
    /* 1F708 8002EF08 26000724 */  addiu      $a3, $zero, 0x26
    /* 1F70C 8002EF0C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F710 8002EF10 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1F714 8002EF14 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1F718 8002EF18 CC0C2925 */  addiu      $t1, $t1, 0xCCC
    /* 1F71C 8002EF1C 21202001 */  addu       $a0, $t1, $zero
    /* 1F720 8002EF20 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1F724 8002EF24 C800A9AF */   sw        $t1, 0xC8($sp)
    /* 1F728 8002EF28 D4000524 */  addiu      $a1, $zero, 0xD4
    /* 1F72C 8002EF2C 21380000 */  addu       $a3, $zero, $zero
    /* 1F730 8002EF30 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F734 8002EF34 3A000224 */  addiu      $v0, $zero, 0x3A
    /* 1F738 8002EF38 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1F73C 8002EF3C F40C3025 */  addiu      $s0, $t1, 0xCF4
    /* 1F740 8002EF40 21200002 */  addu       $a0, $s0, $zero
    /* 1F744 8002EF44 44102825 */  addiu      $t0, $t1, 0x1044
    /* 1F748 8002EF48 21300001 */  addu       $a2, $t0, $zero
    /* 1F74C 8002EF4C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1F750 8002EF50 CC00A8AF */  sw         $t0, 0xCC($sp)
    /* 1F754 8002EF54 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1F758 8002EF58 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1F75C 8002EF5C 00160524 */  addiu      $a1, $zero, 0x1600
    /* 1F760 8002EF60 0580083C */  lui        $t0, %hi(screenTrackSelect)
    /* 1F764 8002EF64 21380000 */  addu       $a3, $zero, $zero
    /* 1F768 8002EF68 5C00A48F */  lw         $a0, 0x5C($sp)
    /* 1F76C 8002EF6C B420068D */  lw         $a2, %lo(screenTrackSelect)($t0)
    /* 1F770 8002EF70 C400A98F */  lw         $t1, 0xC4($sp)
    /* 1F774 8002EF74 0380083C */  lui        $t0, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F778 8002EF78 FCC40825 */  addiu      $t0, $t0, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F77C 8002EF7C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1F780 8002EF80 C800A98F */  lw         $t1, 0xC8($sp)
    /* 1F784 8002EF84 C8001324 */  addiu      $s3, $zero, 0xC8
    /* 1F788 8002EF88 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1F78C 8002EF8C 1800B3AF */  sw         $s3, 0x18($sp)
    /* 1F790 8002EF90 1C00BEAF */  sw         $fp, 0x1C($sp)
    /* 1F794 8002EF94 2400B0AF */  sw         $s0, 0x24($sp)
    /* 1F798 8002EF98 2800A0AF */  sw         $zero, 0x28($sp)
    /* 1F79C 8002EF9C 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F7A0 8002EFA0 2000A9AF */   sw        $t1, 0x20($sp)
    /* 1F7A4 8002EFA4 00160524 */  addiu      $a1, $zero, 0x1600
    /* 1F7A8 8002EFA8 0580083C */  lui        $t0, %hi(screenTrackSelect)
    /* 1F7AC 8002EFAC 21380000 */  addu       $a3, $zero, $zero
    /* 1F7B0 8002EFB0 6800A48F */  lw         $a0, 0x68($sp)
    /* 1F7B4 8002EFB4 B420068D */  lw         $a2, %lo(screenTrackSelect)($t0)
    /* 1F7B8 8002EFB8 C800A88F */  lw         $t0, 0xC8($sp)
    /* 1F7BC 8002EFBC 0380093C */  lui        $t1, %hi(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F7C0 8002EFC0 FCC42925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToCarSelect__FR12tMenuCommand)
    /* 1F7C4 8002EFC4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1F7C8 8002EFC8 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1F7CC 8002EFCC 1800B3AF */  sw         $s3, 0x18($sp)
    /* 1F7D0 8002EFD0 1C00BEAF */  sw         $fp, 0x1C($sp)
    /* 1F7D4 8002EFD4 2400B0AF */  sw         $s0, 0x24($sp)
    /* 1F7D8 8002EFD8 2800A0AF */  sw         $zero, 0x28($sp)
    /* 1F7DC 8002EFDC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1F7E0 8002EFE0 2000A8AF */   sw        $t0, 0x20($sp)
    /* 1F7E4 8002EFE4 0580053C */  lui        $a1, %hi(SelectListNormal)
    /* 1F7E8 8002EFE8 7C19A524 */  addiu      $a1, $a1, %lo(SelectListNormal)
    /* 1F7EC 8002EFEC 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F7F0 8002EFF0 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F7F4 8002EFF4 0DFF0625 */  addiu      $a2, $t0, -0xF3
    /* 1F7F8 8002EFF8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F7FC 8002EFFC 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F800 8002F000 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F804 8002F004 180E2925 */  addiu      $t1, $t1, 0xE18
    /* 1F808 8002F008 21202001 */  addu       $a0, $t1, $zero
    /* 1F80C 8002F00C D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F810 8002F010 D000A9AF */   sw        $t1, 0xD0($sp)
    /* 1F814 8002F014 0580053C */  lui        $a1, %hi(SelectListTrackDirection)
    /* 1F818 8002F018 8C19A524 */  addiu      $a1, $a1, %lo(SelectListTrackDirection)
    /* 1F81C 8002F01C 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F820 8002F020 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F824 8002F024 12FF0625 */  addiu      $a2, $t0, -0xEE
    /* 1F828 8002F028 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F82C 8002F02C 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F830 8002F030 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F834 8002F034 2C0E2925 */  addiu      $t1, $t1, 0xE2C
    /* 1F838 8002F038 21202001 */  addu       $a0, $t1, $zero
    /* 1F83C 8002F03C D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F840 8002F040 D400A9AF */   sw        $t1, 0xD4($sp)
    /* 1F844 8002F044 0580103C */  lui        $s0, %hi(SelectListOffOn)
    /* 1F848 8002F048 74191026 */  addiu      $s0, $s0, %lo(SelectListOffOn)
    /* 1F84C 8002F04C 21280002 */  addu       $a1, $s0, $zero
    /* 1F850 8002F050 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F854 8002F054 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F858 8002F058 17FF0625 */  addiu      $a2, $t0, -0xE9
    /* 1F85C 8002F05C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F860 8002F060 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F864 8002F064 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F868 8002F068 400E2925 */  addiu      $t1, $t1, 0xE40
    /* 1F86C 8002F06C 21202001 */  addu       $a0, $t1, $zero
    /* 1F870 8002F070 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F874 8002F074 D800A9AF */   sw        $t1, 0xD8($sp)
    /* 1F878 8002F078 21280002 */  addu       $a1, $s0, $zero
    /* 1F87C 8002F07C 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F880 8002F080 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F884 8002F084 F6FE0625 */  addiu      $a2, $t0, -0x10A
    /* 1F888 8002F088 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F88C 8002F08C 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F890 8002F090 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F894 8002F094 540E3325 */  addiu      $s3, $t1, 0xE54
    /* 1F898 8002F098 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F89C 8002F09C 21206002 */   addu      $a0, $s3, $zero
    /* 1F8A0 8002F0A0 21280002 */  addu       $a1, $s0, $zero
    /* 1F8A4 8002F0A4 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F8A8 8002F0A8 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F8AC 8002F0AC FBFE0625 */  addiu      $a2, $t0, -0x105
    /* 1F8B0 8002F0B0 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F8B4 8002F0B4 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F8B8 8002F0B8 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F8BC 8002F0BC 680E2925 */  addiu      $t1, $t1, 0xE68
    /* 1F8C0 8002F0C0 21202001 */  addu       $a0, $t1, $zero
    /* 1F8C4 8002F0C4 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F8C8 8002F0C8 DC00A9AF */   sw        $t1, 0xDC($sp)
    /* 1F8CC 8002F0CC 21280002 */  addu       $a1, $s0, $zero
    /* 1F8D0 8002F0D0 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F8D4 8002F0D4 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F8D8 8002F0D8 1CFF0625 */  addiu      $a2, $t0, -0xE4
    /* 1F8DC 8002F0DC 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F8E0 8002F0E0 1180073C */  lui        $a3, %hi(D_80114646)
    /* 1F8E4 8002F0E4 4646E724 */  addiu      $a3, $a3, %lo(D_80114646)
    /* 1F8E8 8002F0E8 7C0E2925 */  addiu      $t1, $t1, 0xE7C
    /* 1F8EC 8002F0EC 21202001 */  addu       $a0, $t1, $zero
    /* 1F8F0 8002F0F0 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 1F8F4 8002F0F4 E000A9AF */   sw        $t1, 0xE0($sp)
    /* 1F8F8 8002F0F8 21280002 */  addu       $a1, $s0, $zero
    /* 1F8FC 8002F0FC 1180083C */  lui        $t0, %hi(D_80114720)
    /* 1F900 8002F100 20470825 */  addiu      $t0, $t0, %lo(D_80114720)
    /* 1F904 8002F104 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F908 8002F108 01FF0625 */  addiu      $a2, $t0, -0xFF
    /* 1F90C 8002F10C 900E2925 */  addiu      $t1, $t1, 0xE90
    /* 1F910 8002F110 21202001 */  addu       $a0, $t1, $zero
    /* 1F914 8002F114 748F000C */  jal        __13tListIteratorPsPc
    /* 1F918 8002F118 E400A9AF */   sw        $t1, 0xE4($sp)
    /* 1F91C 8002F11C CA000524 */  addiu      $a1, $zero, 0xCA
    /* 1F920 8002F120 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F924 8002F124 D000A68F */  lw         $a2, 0xD0($sp)
    /* 1F928 8002F128 A00E3625 */  addiu      $s6, $t1, 0xEA0
    /* 1F92C 8002F12C 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F930 8002F130 2120C002 */   addu      $a0, $s6, $zero
    /* 1F934 8002F134 CC000524 */  addiu      $a1, $zero, 0xCC
    /* 1F938 8002F138 0180103C */  lui        $s0, %hi(_vt_31tMenuItemOptionsLeftRightChoice)
    /* 1F93C 8002F13C 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F940 8002F140 D400A68F */  lw         $a2, 0xD4($sp)
    /* 1F944 8002F144 58081026 */  addiu      $s0, $s0, %lo(_vt_31tMenuItemOptionsLeftRightChoice)
    /* 1F948 8002F148 1800D0AE */  sw         $s0, 0x18($s6)
    /* 1F94C 8002F14C C00E1725 */  addiu      $s7, $t0, 0xEC0
    /* 1F950 8002F150 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F954 8002F154 2120E002 */   addu      $a0, $s7, $zero
    /* 1F958 8002F158 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F95C 8002F15C D800A68F */  lw         $a2, 0xD8($sp)
    /* 1F960 8002F160 CD000524 */  addiu      $a1, $zero, 0xCD
    /* 1F964 8002F164 1800F0AE */  sw         $s0, 0x18($s7)
    /* 1F968 8002F168 E00E3E25 */  addiu      $fp, $t1, 0xEE0
    /* 1F96C 8002F16C 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F970 8002F170 2120C003 */   addu      $a0, $fp, $zero
    /* 1F974 8002F174 CE000524 */  addiu      $a1, $zero, 0xCE
    /* 1F978 8002F178 21306002 */  addu       $a2, $s3, $zero
    /* 1F97C 8002F17C 0180103C */  lui        $s0, %hi(_vt_29tMenuItemOptionsTwoItemChoice)
    /* 1F980 8002F180 00081026 */  addiu      $s0, $s0, %lo(_vt_29tMenuItemOptionsTwoItemChoice)
    /* 1F984 8002F184 8002A88F */  lw         $t0, 0x280($sp)
    /* 1F988 8002F188 80001324 */  addiu      $s3, $zero, 0x80
    /* 1F98C 8002F18C 040F0825 */  addiu      $t0, $t0, 0xF04
    /* 1F990 8002F190 21200001 */  addu       $a0, $t0, $zero
    /* 1F994 8002F194 E800A8AF */  sw         $t0, 0xE8($sp)
    /* 1F998 8002F198 1800D0AF */  sw         $s0, 0x18($fp)
    /* 1F99C 8002F19C 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F9A0 8002F1A0 2000D3A7 */   sh        $s3, 0x20($fp)
    /* 1F9A4 8002F1A4 CF000524 */  addiu      $a1, $zero, 0xCF
    /* 1F9A8 8002F1A8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F9AC 8002F1AC DC00A68F */  lw         $a2, 0xDC($sp)
    /* 1F9B0 8002F1B0 E800A88F */  lw         $t0, 0xE8($sp)
    /* 1F9B4 8002F1B4 280F2925 */  addiu      $t1, $t1, 0xF28
    /* 1F9B8 8002F1B8 21202001 */  addu       $a0, $t1, $zero
    /* 1F9BC 8002F1BC EC00A9AF */  sw         $t1, 0xEC($sp)
    /* 1F9C0 8002F1C0 180010AD */  sw         $s0, 0x18($t0)
    /* 1F9C4 8002F1C4 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F9C8 8002F1C8 200013A5 */   sh        $s3, 0x20($t0)
    /* 1F9CC 8002F1CC D0000524 */  addiu      $a1, $zero, 0xD0
    /* 1F9D0 8002F1D0 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F9D4 8002F1D4 E000A68F */  lw         $a2, 0xE0($sp)
    /* 1F9D8 8002F1D8 EC00A88F */  lw         $t0, 0xEC($sp)
    /* 1F9DC 8002F1DC 4C0F2925 */  addiu      $t1, $t1, 0xF4C
    /* 1F9E0 8002F1E0 21202001 */  addu       $a0, $t1, $zero
    /* 1F9E4 8002F1E4 F000A9AF */  sw         $t1, 0xF0($sp)
    /* 1F9E8 8002F1E8 180010AD */  sw         $s0, 0x18($t0)
    /* 1F9EC 8002F1EC 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1F9F0 8002F1F0 200013A5 */   sh        $s3, 0x20($t0)
    /* 1F9F4 8002F1F4 D2000524 */  addiu      $a1, $zero, 0xD2
    /* 1F9F8 8002F1F8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1F9FC 8002F1FC E400A68F */  lw         $a2, 0xE4($sp)
    /* 1FA00 8002F200 F000A88F */  lw         $t0, 0xF0($sp)
    /* 1FA04 8002F204 700F2925 */  addiu      $t1, $t1, 0xF70
    /* 1FA08 8002F208 21202001 */  addu       $a0, $t1, $zero
    /* 1FA0C 8002F20C F400A9AF */  sw         $t1, 0xF4($sp)
    /* 1FA10 8002F210 180010AD */  sw         $s0, 0x18($t0)
    /* 1FA14 8002F214 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 1FA18 8002F218 200013A5 */   sh        $s3, 0x20($t0)
    /* 1FA1C 8002F21C C400A48F */  lw         $a0, 0xC4($sp)
    /* 1FA20 8002F220 F400A98F */  lw         $t1, 0xF4($sp)
    /* 1FA24 8002F224 00100524 */  addiu      $a1, $zero, 0x1000
    /* 1FA28 8002F228 180030AD */  sw         $s0, 0x18($t1)
    /* 1FA2C 8002F22C 200033A5 */  sh         $s3, 0x20($t1)
    /* 1FA30 8002F230 E800A98F */  lw         $t1, 0xE8($sp)
    /* 1FA34 8002F234 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 1FA38 8002F238 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 1FA3C 8002F23C EC00A88F */  lw         $t0, 0xEC($sp)
    /* 1FA40 8002F240 21300000 */  addu       $a2, $zero, $zero
    /* 1FA44 8002F244 2C00A9AF */  sw         $t1, 0x2C($sp)
    /* 1FA48 8002F248 F000A98F */  lw         $t1, 0xF0($sp)
    /* 1FA4C 8002F24C 2138C000 */  addu       $a3, $a2, $zero
    /* 1FA50 8002F250 3000A8AF */  sw         $t0, 0x30($sp)
    /* 1FA54 8002F254 F400A88F */  lw         $t0, 0xF4($sp)
    /* 1FA58 8002F258 B9000224 */  addiu      $v0, $zero, 0xB9
    /* 1FA5C 8002F25C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1FA60 8002F260 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1FA64 8002F264 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1FA68 8002F268 2000B6AF */  sw         $s6, 0x20($sp)
    /* 1FA6C 8002F26C 2400B7AF */  sw         $s7, 0x24($sp)
    /* 1FA70 8002F270 2800BEAF */  sw         $fp, 0x28($sp)
    /* 1FA74 8002F274 3C00A0AF */  sw         $zero, 0x3C($sp)
    /* 1FA78 8002F278 3400A9AF */  sw         $t1, 0x34($sp)
    /* 1FA7C 8002F27C 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 1FA80 8002F280 3800A8AF */   sw        $t0, 0x38($sp)
    /* 1FA84 8002F284 21280000 */  addu       $a1, $zero, $zero
    /* 1FA88 8002F288 2130A000 */  addu       $a2, $a1, $zero
    /* 1FA8C 8002F28C 2138A000 */  addu       $a3, $a1, $zero
    /* 1FA90 8002F290 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FA94 8002F294 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 1FA98 8002F298 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FA9C 8002F29C 18103025 */  addiu      $s0, $t1, 0x1018
    /* 1FAA0 8002F2A0 21200002 */  addu       $a0, $s0, $zero
    /* 1FAA4 8002F2A4 21480001 */  addu       $t1, $t0, $zero
    /* 1FAA8 8002F2A8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FAAC 8002F2AC 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1FAB0 8002F2B0 00100524 */  addiu      $a1, $zero, 0x1000
    /* 1FAB4 8002F2B4 21380000 */  addu       $a3, $zero, $zero
    /* 1FAB8 8002F2B8 0580023C */  lui        $v0, %hi(screenTrackRecords)
    /* 1FABC 8002F2BC D020468C */  lw         $a2, %lo(screenTrackRecords)($v0)
    /* 1FAC0 8002F2C0 0180023C */  lui        $v0, %hi(D_800114D8)
    /* 1FAC4 8002F2C4 CC00A48F */  lw         $a0, 0xCC($sp)
    /* 1FAC8 8002F2C8 D8144224 */  addiu      $v0, $v0, %lo(D_800114D8)
    /* 1FACC 8002F2CC 180002AE */  sw         $v0, 0x18($s0)
    /* 1FAD0 8002F2D0 D4000224 */  addiu      $v0, $zero, 0xD4
    /* 1FAD4 8002F2D4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1FAD8 8002F2D8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1FADC 8002F2DC 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FAE0 8002F2E0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1FAE4 8002F2E4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1FAE8 8002F2E8 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 1FAEC 8002F2EC 2000A8AF */  sw         $t0, 0x20($sp)
    /* 1FAF0 8002F2F0 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 1FAF4 8002F2F4 2400A0AF */   sw        $zero, 0x24($sp)
    /* 1FAF8 8002F2F8 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 1FAFC 8002F2FC 21300000 */  addu       $a2, $zero, $zero
    /* 1FB00 8002F300 0380073C */  lui        $a3, %hi(MenuExtended_GoToGarage__FR12tMenuCommand)
    /* 1FB04 8002F304 9CE0E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToGarage__FR12tMenuCommand)
    /* 1FB08 8002F308 21000224 */  addiu      $v0, $zero, 0x21
    /* 1FB0C 8002F30C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FB10 8002F310 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FB14 8002F314 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1FB18 8002F318 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1FB1C 8002F31C C4103025 */  addiu      $s0, $t1, 0x10C4
    /* 1FB20 8002F320 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FB24 8002F324 21200002 */   addu      $a0, $s0, $zero
    /* 1FB28 8002F328 04100524 */  addiu      $a1, $zero, 0x1004
    /* 1FB2C 8002F32C 0580023C */  lui        $v0, %hi(screenTrackInfo)
    /* 1FB30 8002F330 21380000 */  addu       $a3, $zero, $zero
    /* 1FB34 8002F334 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FB38 8002F338 CC20468C */  lw         $a2, %lo(screenTrackInfo)($v0)
    /* 1FB3C 8002F33C F9000224 */  addiu      $v0, $zero, 0xF9
    /* 1FB40 8002F340 1000A0AF */  sw         $zero, 0x10($sp)
    /* 1FB44 8002F344 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1FB48 8002F348 1800A2AF */  sw         $v0, 0x18($sp)
    /* 1FB4C 8002F34C 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* 1FB50 8002F350 2000A0AF */  sw         $zero, 0x20($sp)
    /* 1FB54 8002F354 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FB58 8002F358 F0102425 */   addiu     $a0, $t1, 0x10F0
    /* 1FB5C 8002F35C 1180053C */  lui        $a1, %hi(D_8011465C)
    /* 1FB60 8002F360 5C46A524 */  addiu      $a1, $a1, %lo(D_8011465C)
    /* 1FB64 8002F364 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FB68 8002F368 1180063C */  lui        $a2, %hi(carManager)
    /* 1FB6C 8002F36C 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 1FB70 8002F370 6C110825 */  addiu      $t0, $t0, 0x116C
    /* 1FB74 8002F374 21200001 */  addu       $a0, $t0, $zero
    /* 1FB78 8002F378 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 1FB7C 8002F37C F800A8AF */   sw        $t0, 0xF8($sp)
    /* 1FB80 8002F380 1180053C */  lui        $a1, %hi(D_80114660)
    /* 1FB84 8002F384 6046A524 */  addiu      $a1, $a1, %lo(D_80114660)
    /* 1FB88 8002F388 1180073C */  lui        $a3, %hi(D_8011465C)
    /* 1FB8C 8002F38C 5C46E724 */  addiu      $a3, $a3, %lo(D_8011465C)
    /* 1FB90 8002F390 0580083C */  lui        $t0, %hi(FEApp)
    /* 1FB94 8002F394 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FB98 8002F398 C014068D */  lw         $a2, %lo(FEApp)($t0)
    /* 1FB9C 8002F39C 1180083C */  lui        $t0, %hi(carManager)
    /* 1FBA0 8002F3A0 74420825 */  addiu      $t0, $t0, %lo(carManager)
    /* 1FBA4 8002F3A4 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1FBA8 8002F3A8 88112925 */  addiu      $t1, $t1, 0x1188
    /* 1FBAC 8002F3AC 21202001 */  addu       $a0, $t1, $zero
    /* 1FBB0 8002F3B0 FC00A9AF */  sw         $t1, 0xFC($sp)
    /* 1FBB4 8002F3B4 30000924 */  addiu      $t1, $zero, 0x30
    /* 1FBB8 8002F3B8 2C02C624 */  addiu      $a2, $a2, 0x22C
    /* 1FBBC 8002F3BC 2861000C */  jal        __21tListIteratorCarColorPcN21iP11tCarManager
    /* 1FBC0 8002F3C0 1000A9AF */   sw        $t1, 0x10($sp)
    /* 1FBC4 8002F3C4 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 1FBC8 8002F3C8 21300000 */  addu       $a2, $zero, $zero
    /* 1FBCC 8002F3CC 0380073C */  lui        $a3, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FBD0 8002F3D0 98CCE724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FBD4 8002F3D4 80000224 */  addiu      $v0, $zero, 0x80
    /* 1FBD8 8002F3D8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FBDC 8002F3DC 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FBE0 8002F3E0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1FBE4 8002F3E4 1400A8AF */  sw         $t0, 0x14($sp)
    /* 1FBE8 8002F3E8 A8112925 */  addiu      $t1, $t1, 0x11A8
    /* 1FBEC 8002F3EC 21202001 */  addu       $a0, $t1, $zero
    /* 1FBF0 8002F3F0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FBF4 8002F3F4 0001A9AF */   sw        $t1, 0x100($sp)
    /* 1FBF8 8002F3F8 92000524 */  addiu      $a1, $zero, 0x92
    /* 1FBFC 8002F3FC 1C000724 */  addiu      $a3, $zero, 0x1C
    /* 1FC00 8002F400 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FC04 8002F404 F800A68F */  lw         $a2, 0xF8($sp)
    /* 1FC08 8002F408 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FC0C 8002F40C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FC10 8002F410 D4112925 */  addiu      $t1, $t1, 0x11D4
    /* 1FC14 8002F414 21202001 */  addu       $a0, $t1, $zero
    /* 1FC18 8002F418 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FC1C 8002F41C 0401A9AF */   sw        $t1, 0x104($sp)
    /* 1FC20 8002F420 20010524 */  addiu      $a1, $zero, 0x120
    /* 1FC24 8002F424 26000724 */  addiu      $a3, $zero, 0x26
    /* 1FC28 8002F428 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FC2C 8002F42C FC00A68F */  lw         $a2, 0xFC($sp)
    /* 1FC30 8002F430 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FC34 8002F434 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FC38 8002F438 FC112925 */  addiu      $t1, $t1, 0x11FC
    /* 1FC3C 8002F43C 21202001 */  addu       $a0, $t1, $zero
    /* 1FC40 8002F440 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FC44 8002F444 0801A9AF */   sw        $t1, 0x108($sp)
    /* 1FC48 8002F448 12010524 */  addiu      $a1, $zero, 0x112
    /* 1FC4C 8002F44C 21300000 */  addu       $a2, $zero, $zero
    /* 1FC50 8002F450 0380073C */  lui        $a3, %hi(MenuExtended_GoToShowroom__FR12tMenuCommand)
    /* 1FC54 8002F454 78D2E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToShowroom__FR12tMenuCommand)
    /* 1FC58 8002F458 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FC5C 8002F45C 30000824 */  addiu      $t0, $zero, 0x30
    /* 1FC60 8002F460 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FC64 8002F464 24123025 */  addiu      $s0, $t1, 0x1224
    /* 1FC68 8002F468 21200002 */  addu       $a0, $s0, $zero
    /* 1FC6C 8002F46C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FC70 8002F470 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FC74 8002F474 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1FC78 8002F478 0580093C */  lui        $t1, %hi(screenCarSelect)
    /* 1FC7C 8002F47C 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FC80 8002F480 3C20268D */  lw         $a2, %lo(screenCarSelect)($t1)
    /* 1FC84 8002F484 0380093C */  lui        $t1, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FC88 8002F488 98CC2925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FC8C 8002F48C 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FC90 8002F490 0001A98F */  lw         $t1, 0x100($sp)
    /* 1FC94 8002F494 50120425 */  addiu      $a0, $t0, 0x1250
    /* 1FC98 8002F498 D8200825 */  addiu      $t0, $t0, 0x20D8
    /* 1FC9C 8002F49C 0C01A8AF */  sw         $t0, 0x10C($sp)
    /* 1FCA0 8002F4A0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FCA4 8002F4A4 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 1FCA8 8002F4A8 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1FCAC 8002F4AC 0401A88F */  lw         $t0, 0x104($sp)
    /* 1FCB0 8002F4B0 001A0524 */  addiu      $a1, $zero, 0x1A00
    /* 1FCB4 8002F4B4 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 1FCB8 8002F4B8 0801A98F */  lw         $t1, 0x108($sp)
    /* 1FCBC 8002F4BC 21380000 */  addu       $a3, $zero, $zero
    /* 1FCC0 8002F4C0 2800B0AF */  sw         $s0, 0x28($sp)
    /* 1FCC4 8002F4C4 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1FCC8 8002F4C8 2000A8AF */  sw         $t0, 0x20($sp)
    /* 1FCCC 8002F4CC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FCD0 8002F4D0 2400A9AF */   sw        $t1, 0x24($sp)
    /* 1FCD4 8002F4D4 1180053C */  lui        $a1, %hi(D_80114723)
    /* 1FCD8 8002F4D8 2347A524 */  addiu      $a1, $a1, %lo(D_80114723)
    /* 1FCDC 8002F4DC 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FCE0 8002F4E0 1180063C */  lui        $a2, %hi(carManager)
    /* 1FCE4 8002F4E4 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 1FCE8 8002F4E8 CC120825 */  addiu      $t0, $t0, 0x12CC
    /* 1FCEC 8002F4EC 21200001 */  addu       $a0, $t0, $zero
    /* 1FCF0 8002F4F0 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 1FCF4 8002F4F4 1001A8AF */   sw        $t0, 0x110($sp)
    /* 1FCF8 8002F4F8 92000524 */  addiu      $a1, $zero, 0x92
    /* 1FCFC 8002F4FC 1C000724 */  addiu      $a3, $zero, 0x1C
    /* 1FD00 8002F500 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FD04 8002F504 1001A68F */  lw         $a2, 0x110($sp)
    /* 1FD08 8002F508 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FD0C 8002F50C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FD10 8002F510 E8123E25 */  addiu      $fp, $t1, 0x12E8
    /* 1FD14 8002F514 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FD18 8002F518 2120C003 */   addu      $a0, $fp, $zero
    /* 1FD1C 8002F51C 74000524 */  addiu      $a1, $zero, 0x74
    /* 1FD20 8002F520 21380000 */  addu       $a3, $zero, $zero
    /* 1FD24 8002F524 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FD28 8002F528 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FD2C 8002F52C 3A000224 */  addiu      $v0, $zero, 0x3A
    /* 1FD30 8002F530 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1FD34 8002F534 10132925 */  addiu      $t1, $t1, 0x1310
    /* 1FD38 8002F538 21202001 */  addu       $a0, $t1, $zero
    /* 1FD3C 8002F53C E81B0825 */  addiu      $t0, $t0, 0x1BE8
    /* 1FD40 8002F540 21300001 */  addu       $a2, $t0, $zero
    /* 1FD44 8002F544 1401A9AF */  sw         $t1, 0x114($sp)
    /* 1FD48 8002F548 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FD4C 8002F54C 1801A8AF */  sw         $t0, 0x118($sp)
    /* 1FD50 8002F550 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FD54 8002F554 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1FD58 8002F558 91000524 */  addiu      $a1, $zero, 0x91
    /* 1FD5C 8002F55C 21300000 */  addu       $a2, $zero, $zero
    /* 1FD60 8002F560 0380073C */  lui        $a3, %hi(func_8002C960)
    /* 1FD64 8002F564 60C9E724 */  addiu      $a3, $a3, %lo(func_8002C960)
    /* 1FD68 8002F568 44000224 */  addiu      $v0, $zero, 0x44
    /* 1FD6C 8002F56C 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FD70 8002F570 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FD74 8002F574 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1FD78 8002F578 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FD7C 8002F57C 3C131025 */  addiu      $s0, $t0, 0x133C
    /* 1FD80 8002F580 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FD84 8002F584 21200002 */   addu      $a0, $s0, $zero
    /* 1FD88 8002F588 001A0524 */  addiu      $a1, $zero, 0x1A00
    /* 1FD8C 8002F58C 0580093C */  lui        $t1, %hi(screenCarSelect)
    /* 1FD90 8002F590 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FD94 8002F594 3C20268D */  lw         $a2, %lo(screenCarSelect)($t1)
    /* 1FD98 8002F598 0380093C */  lui        $t1, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FD9C 8002F59C 98CC2925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FDA0 8002F5A0 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FDA4 8002F5A4 1401A98F */  lw         $t1, 0x114($sp)
    /* 1FDA8 8002F5A8 68130425 */  addiu      $a0, $t0, 0x1368
    /* 1FDAC 8002F5AC 0C01A88F */  lw         $t0, 0x10C($sp)
    /* 1FDB0 8002F5B0 21380000 */  addu       $a3, $zero, $zero
    /* 1FDB4 8002F5B4 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FDB8 8002F5B8 0001A88F */  lw         $t0, 0x100($sp)
    /* 1FDBC 8002F5BC 8F001324 */  addiu      $s3, $zero, 0x8F
    /* 1FDC0 8002F5C0 1800B3AF */  sw         $s3, 0x18($sp)
    /* 1FDC4 8002F5C4 2000BEAF */  sw         $fp, 0x20($sp)
    /* 1FDC8 8002F5C8 2800B0AF */  sw         $s0, 0x28($sp)
    /* 1FDCC 8002F5CC 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1FDD0 8002F5D0 2400A9AF */  sw         $t1, 0x24($sp)
    /* 1FDD4 8002F5D4 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FDD8 8002F5D8 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 1FDDC 8002F5DC 001A0524 */  addiu      $a1, $zero, 0x1A00
    /* 1FDE0 8002F5E0 0580093C */  lui        $t1, %hi(screenCarSelect)
    /* 1FDE4 8002F5E4 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FDE8 8002F5E8 3C20268D */  lw         $a2, %lo(screenCarSelect)($t1)
    /* 1FDEC 8002F5EC E4130425 */  addiu      $a0, $t0, 0x13E4
    /* 1FDF0 8002F5F0 0C01A88F */  lw         $t0, 0x10C($sp)
    /* 1FDF4 8002F5F4 21380000 */  addu       $a3, $zero, $zero
    /* 1FDF8 8002F5F8 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FDFC 8002F5FC 0001A88F */  lw         $t0, 0x100($sp)
    /* 1FE00 8002F600 0380093C */  lui        $t1, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FE04 8002F604 98CC2925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FE08 8002F608 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FE0C 8002F60C 1800B3AF */  sw         $s3, 0x18($sp)
    /* 1FE10 8002F610 2000B0AF */  sw         $s0, 0x20($sp)
    /* 1FE14 8002F614 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1FE18 8002F618 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FE1C 8002F61C 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 1FE20 8002F620 1180083C */  lui        $t0, %hi(D_8011465C)
    /* 1FE24 8002F624 5C460825 */  addiu      $t0, $t0, %lo(D_8011465C)
    /* 1FE28 8002F628 C1020525 */  addiu      $a1, $t0, 0x2C1
    /* 1FE2C 8002F62C 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FE30 8002F630 1180063C */  lui        $a2, %hi(carManager)
    /* 1FE34 8002F634 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 1FE38 8002F638 60143325 */  addiu      $s3, $t1, 0x1460
    /* 1FE3C 8002F63C 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 1FE40 8002F640 21206002 */   addu      $a0, $s3, $zero
    /* 1FE44 8002F644 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 1FE48 8002F648 21300000 */  addu       $a2, $zero, $zero
    /* 1FE4C 8002F64C 0380073C */  lui        $a3, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FE50 8002F650 98CCE724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FE54 8002F654 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FE58 8002F658 2A000824 */  addiu      $t0, $zero, 0x2A
    /* 1FE5C 8002F65C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FE60 8002F660 7C142925 */  addiu      $t1, $t1, 0x147C
    /* 1FE64 8002F664 21202001 */  addu       $a0, $t1, $zero
    /* 1FE68 8002F668 1C01A9AF */  sw         $t1, 0x11C($sp)
    /* 1FE6C 8002F66C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FE70 8002F670 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FE74 8002F674 1400A9AF */   sw        $t1, 0x14($sp)
    /* 1FE78 8002F678 92000524 */  addiu      $a1, $zero, 0x92
    /* 1FE7C 8002F67C 0C000724 */  addiu      $a3, $zero, 0xC
    /* 1FE80 8002F680 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FE84 8002F684 F800A68F */  lw         $a2, 0xF8($sp)
    /* 1FE88 8002F688 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FE8C 8002F68C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1FE90 8002F690 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FE94 8002F694 A8140425 */   addiu     $a0, $t0, 0x14A8
    /* 1FE98 8002F698 20010524 */  addiu      $a1, $zero, 0x120
    /* 1FE9C 8002F69C 16000724 */  addiu      $a3, $zero, 0x16
    /* 1FEA0 8002F6A0 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FEA4 8002F6A4 FC00A68F */  lw         $a2, 0xFC($sp)
    /* 1FEA8 8002F6A8 0A000924 */  addiu      $t1, $zero, 0xA
    /* 1FEAC 8002F6AC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1FEB0 8002F6B0 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FEB4 8002F6B4 D0140425 */   addiu     $a0, $t0, 0x14D0
    /* 1FEB8 8002F6B8 78000524 */  addiu      $a1, $zero, 0x78
    /* 1FEBC 8002F6BC 0380073C */  lui        $a3, %hi(func_8002C890)
    /* 1FEC0 8002F6C0 90C8E724 */  addiu      $a3, $a3, %lo(func_8002C890)
    /* 1FEC4 8002F6C4 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FEC8 8002F6C8 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FECC 8002F6CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 1FED0 8002F6D0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 1FED4 8002F6D4 F8140825 */  addiu      $t0, $t0, 0x14F8
    /* 1FED8 8002F6D8 21200001 */  addu       $a0, $t0, $zero
    /* 1FEDC 8002F6DC 481D2925 */  addiu      $t1, $t1, 0x1D48
    /* 1FEE0 8002F6E0 21302001 */  addu       $a2, $t1, $zero
    /* 1FEE4 8002F6E4 2001A8AF */  sw         $t0, 0x120($sp)
    /* 1FEE8 8002F6E8 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FEEC 8002F6EC 2401A9AF */  sw         $t1, 0x124($sp)
    /* 1FEF0 8002F6F0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FEF4 8002F6F4 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1FEF8 8002F6F8 BC000524 */  addiu      $a1, $zero, 0xBC
    /* 1FEFC 8002F6FC 21306002 */  addu       $a2, $s3, $zero
    /* 1FF00 8002F700 20000724 */  addiu      $a3, $zero, 0x20
    /* 1FF04 8002F704 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FF08 8002F708 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FF0C 8002F70C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FF10 8002F710 24153025 */  addiu      $s0, $t1, 0x1524
    /* 1FF14 8002F714 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 1FF18 8002F718 21200002 */   addu      $a0, $s0, $zero
    /* 1FF1C 8002F71C 0580133C */  lui        $s3, %hi(screenCarSelectDuel)
    /* 1FF20 8002F720 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FF24 8002F724 4020668E */  lw         $a2, %lo(screenCarSelectDuel)($s3)
    /* 1FF28 8002F728 0C01A88F */  lw         $t0, 0x10C($sp)
    /* 1FF2C 8002F72C 4C152425 */  addiu      $a0, $t1, 0x154C
    /* 1FF30 8002F730 0380093C */  lui        $t1, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FF34 8002F734 98CC2925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FF38 8002F738 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FF3C 8002F73C 1C01A98F */  lw         $t1, 0x11C($sp)
    /* 1FF40 8002F740 00180524 */  addiu      $a1, $zero, 0x1800
    /* 1FF44 8002F744 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FF48 8002F748 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 1FF4C 8002F74C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1FF50 8002F750 2001A88F */  lw         $t0, 0x120($sp)
    /* 1FF54 8002F754 21380000 */  addu       $a3, $zero, $zero
    /* 1FF58 8002F758 2000BEAF */  sw         $fp, 0x20($sp)
    /* 1FF5C 8002F75C 2800B0AF */  sw         $s0, 0x28($sp)
    /* 1FF60 8002F760 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1FF64 8002F764 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 1FF68 8002F768 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FF6C 8002F76C 2400A8AF */   sw        $t0, 0x24($sp)
    /* 1FF70 8002F770 8002A98F */  lw         $t1, 0x280($sp)
    /* 1FF74 8002F774 0C01A88F */  lw         $t0, 0x10C($sp)
    /* 1FF78 8002F778 4020668E */  lw         $a2, %lo(screenCarSelectDuel)($s3)
    /* 1FF7C 8002F77C C8152425 */  addiu      $a0, $t1, 0x15C8
    /* 1FF80 8002F780 0380093C */  lui        $t1, %hi(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FF84 8002F784 98CC2925 */  addiu      $t1, $t1, %lo(MenuExtended_GoToRace__FR12tMenuCommand)
    /* 1FF88 8002F788 1400A9AF */  sw         $t1, 0x14($sp)
    /* 1FF8C 8002F78C 1C01A98F */  lw         $t1, 0x11C($sp)
    /* 1FF90 8002F790 1000A8AF */  sw         $t0, 0x10($sp)
    /* 1FF94 8002F794 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 1FF98 8002F798 1800A8AF */  sw         $t0, 0x18($sp)
    /* 1FF9C 8002F79C 0401A88F */  lw         $t0, 0x104($sp)
    /* 1FFA0 8002F7A0 00180524 */  addiu      $a1, $zero, 0x1800
    /* 1FFA4 8002F7A4 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 1FFA8 8002F7A8 0801A98F */  lw         $t1, 0x108($sp)
    /* 1FFAC 8002F7AC 21380000 */  addu       $a3, $zero, $zero
    /* 1FFB0 8002F7B0 2800B0AF */  sw         $s0, 0x28($sp)
    /* 1FFB4 8002F7B4 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 1FFB8 8002F7B8 2000A8AF */  sw         $t0, 0x20($sp)
    /* 1FFBC 8002F7BC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 1FFC0 8002F7C0 2400A9AF */   sw        $t1, 0x24($sp)
    /* 1FFC4 8002F7C4 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 1FFC8 8002F7C8 21300000 */  addu       $a2, $zero, $zero
    /* 1FFCC 8002F7CC 0380103C */  lui        $s0, %hi(MenuExtended_GoTo2PlayerRace__FR12tMenuCommand)
    /* 1FFD0 8002F7D0 F4CD1026 */  addiu      $s0, $s0, %lo(MenuExtended_GoTo2PlayerRace__FR12tMenuCommand)
    /* 1FFD4 8002F7D4 21380002 */  addu       $a3, $s0, $zero
    /* 1FFD8 8002F7D8 8002A88F */  lw         $t0, 0x280($sp)
    /* 1FFDC 8002F7DC 2A000924 */  addiu      $t1, $zero, 0x2A
    /* 1FFE0 8002F7E0 1000A9AF */  sw         $t1, 0x10($sp)
    /* 1FFE4 8002F7E4 44160825 */  addiu      $t0, $t0, 0x1644
    /* 1FFE8 8002F7E8 21200001 */  addu       $a0, $t0, $zero
    /* 1FFEC 8002F7EC 2801A8AF */  sw         $t0, 0x128($sp)
    /* 1FFF0 8002F7F0 0A000824 */  addiu      $t0, $zero, 0xA
    /* 1FFF4 8002F7F4 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 1FFF8 8002F7F8 1400A8AF */   sw        $t0, 0x14($sp)
    /* 1FFFC 8002F7FC 92000524 */  addiu      $a1, $zero, 0x92
    /* 20000 8002F800 0C000724 */  addiu      $a3, $zero, 0xC
    /* 20004 8002F804 8002A98F */  lw         $t1, 0x280($sp)
    /* 20008 8002F808 F800A68F */  lw         $a2, 0xF8($sp)
    /* 2000C 8002F80C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20010 8002F810 1000A8AF */  sw         $t0, 0x10($sp)
    /* 20014 8002F814 70162925 */  addiu      $t1, $t1, 0x1670
    /* 20018 8002F818 21202001 */  addu       $a0, $t1, $zero
    /* 2001C 8002F81C 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20020 8002F820 2C01A9AF */   sw        $t1, 0x12C($sp)
    /* 20024 8002F824 20010524 */  addiu      $a1, $zero, 0x120
    /* 20028 8002F828 16000724 */  addiu      $a3, $zero, 0x16
    /* 2002C 8002F82C 8002A98F */  lw         $t1, 0x280($sp)
    /* 20030 8002F830 FC00A68F */  lw         $a2, 0xFC($sp)
    /* 20034 8002F834 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20038 8002F838 1000A8AF */  sw         $t0, 0x10($sp)
    /* 2003C 8002F83C 98163325 */  addiu      $s3, $t1, 0x1698
    /* 20040 8002F840 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20044 8002F844 21206002 */   addu      $a0, $s3, $zero
    /* 20048 8002F848 08100524 */  addiu      $a1, $zero, 0x1008
    /* 2004C 8002F84C 0580083C */  lui        $t0, %hi(screenCarSelectTwoPlayer)
    /* 20050 8002F850 8002A98F */  lw         $t1, 0x280($sp)
    /* 20054 8002F854 4420068D */  lw         $a2, %lo(screenCarSelectTwoPlayer)($t0)
    /* 20058 8002F858 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 2005C 8002F85C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 20060 8002F860 2C01A88F */  lw         $t0, 0x12C($sp)
    /* 20064 8002F864 C0162425 */  addiu      $a0, $t1, 0x16C0
    /* 20068 8002F868 5C212925 */  addiu      $t1, $t1, 0x215C
    /* 2006C 8002F86C 3001A9AF */  sw         $t1, 0x130($sp)
    /* 20070 8002F870 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20074 8002F874 2801A98F */  lw         $t1, 0x128($sp)
    /* 20078 8002F878 21380000 */  addu       $a3, $zero, $zero
    /* 2007C 8002F87C 1400B0AF */  sw         $s0, 0x14($sp)
    /* 20080 8002F880 2400B3AF */  sw         $s3, 0x24($sp)
    /* 20084 8002F884 2800A0AF */  sw         $zero, 0x28($sp)
    /* 20088 8002F888 2000A8AF */  sw         $t0, 0x20($sp)
    /* 2008C 8002F88C 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20090 8002F890 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 20094 8002F894 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 20098 8002F898 21300000 */  addu       $a2, $zero, $zero
    /* 2009C 8002F89C 21380002 */  addu       $a3, $s0, $zero
    /* 200A0 8002F8A0 8002A98F */  lw         $t1, 0x280($sp)
    /* 200A4 8002F8A4 2A000824 */  addiu      $t0, $zero, 0x2A
    /* 200A8 8002F8A8 1000A8AF */  sw         $t0, 0x10($sp)
    /* 200AC 8002F8AC 3C172925 */  addiu      $t1, $t1, 0x173C
    /* 200B0 8002F8B0 21202001 */  addu       $a0, $t1, $zero
    /* 200B4 8002F8B4 3401A9AF */  sw         $t1, 0x134($sp)
    /* 200B8 8002F8B8 0A000924 */  addiu      $t1, $zero, 0xA
    /* 200BC 8002F8BC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 200C0 8002F8C0 1400A9AF */   sw        $t1, 0x14($sp)
    /* 200C4 8002F8C4 92000524 */  addiu      $a1, $zero, 0x92
    /* 200C8 8002F8C8 0C000724 */  addiu      $a3, $zero, 0xC
    /* 200CC 8002F8CC 8002A88F */  lw         $t0, 0x280($sp)
    /* 200D0 8002F8D0 F800A68F */  lw         $a2, 0xF8($sp)
    /* 200D4 8002F8D4 0A000924 */  addiu      $t1, $zero, 0xA
    /* 200D8 8002F8D8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 200DC 8002F8DC 68170825 */  addiu      $t0, $t0, 0x1768
    /* 200E0 8002F8E0 21200001 */  addu       $a0, $t0, $zero
    /* 200E4 8002F8E4 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 200E8 8002F8E8 3801A8AF */   sw        $t0, 0x138($sp)
    /* 200EC 8002F8EC 20010524 */  addiu      $a1, $zero, 0x120
    /* 200F0 8002F8F0 16000724 */  addiu      $a3, $zero, 0x16
    /* 200F4 8002F8F4 8002A88F */  lw         $t0, 0x280($sp)
    /* 200F8 8002F8F8 FC00A68F */  lw         $a2, 0xFC($sp)
    /* 200FC 8002F8FC 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20100 8002F900 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20104 8002F904 90171325 */  addiu      $s3, $t0, 0x1790
    /* 20108 8002F908 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 2010C 8002F90C 21206002 */   addu      $a0, $s3, $zero
    /* 20110 8002F910 08100524 */  addiu      $a1, $zero, 0x1008
    /* 20114 8002F914 0580093C */  lui        $t1, %hi(screenCarSelectPlayerTwo)
    /* 20118 8002F918 8002A88F */  lw         $t0, 0x280($sp)
    /* 2011C 8002F91C 4820268D */  lw         $a2, %lo(screenCarSelectPlayerTwo)($t1)
    /* 20120 8002F920 BA000924 */  addiu      $t1, $zero, 0xBA
    /* 20124 8002F924 1800A9AF */  sw         $t1, 0x18($sp)
    /* 20128 8002F928 3801A98F */  lw         $t1, 0x138($sp)
    /* 2012C 8002F92C B8170425 */  addiu      $a0, $t0, 0x17B8
    /* 20130 8002F930 E0210825 */  addiu      $t0, $t0, 0x21E0
    /* 20134 8002F934 3C01A8AF */  sw         $t0, 0x13C($sp)
    /* 20138 8002F938 1000A8AF */  sw         $t0, 0x10($sp)
    /* 2013C 8002F93C 3401A88F */  lw         $t0, 0x134($sp)
    /* 20140 8002F940 21380000 */  addu       $a3, $zero, $zero
    /* 20144 8002F944 1400B0AF */  sw         $s0, 0x14($sp)
    /* 20148 8002F948 2400B3AF */  sw         $s3, 0x24($sp)
    /* 2014C 8002F94C 2800A0AF */  sw         $zero, 0x28($sp)
    /* 20150 8002F950 2000A9AF */  sw         $t1, 0x20($sp)
    /* 20154 8002F954 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20158 8002F958 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 2015C 8002F95C BD000524 */  addiu      $a1, $zero, 0xBD
    /* 20160 8002F960 21300000 */  addu       $a2, $zero, $zero
    /* 20164 8002F964 21380002 */  addu       $a3, $s0, $zero
    /* 20168 8002F968 8002A88F */  lw         $t0, 0x280($sp)
    /* 2016C 8002F96C 2A000924 */  addiu      $t1, $zero, 0x2A
    /* 20170 8002F970 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20174 8002F974 34180425 */  addiu      $a0, $t0, 0x1834
    /* 20178 8002F978 0A000824 */  addiu      $t0, $zero, 0xA
    /* 2017C 8002F97C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20180 8002F980 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20184 8002F984 92000524 */  addiu      $a1, $zero, 0x92
    /* 20188 8002F988 0C000724 */  addiu      $a3, $zero, 0xC
    /* 2018C 8002F98C 8002A98F */  lw         $t1, 0x280($sp)
    /* 20190 8002F990 1001A68F */  lw         $a2, 0x110($sp)
    /* 20194 8002F994 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20198 8002F998 1000A8AF */  sw         $t0, 0x10($sp)
    /* 2019C 8002F99C 60183325 */  addiu      $s3, $t1, 0x1860
    /* 201A0 8002F9A0 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 201A4 8002F9A4 21206002 */   addu      $a0, $s3, $zero
    /* 201A8 8002F9A8 08100524 */  addiu      $a1, $zero, 0x1008
    /* 201AC 8002F9AC 0580083C */  lui        $t0, %hi(screenCarSelectTwoPlayer)
    /* 201B0 8002F9B0 8002A98F */  lw         $t1, 0x280($sp)
    /* 201B4 8002F9B4 4420068D */  lw         $a2, %lo(screenCarSelectTwoPlayer)($t0)
    /* 201B8 8002F9B8 88182425 */  addiu      $a0, $t1, 0x1888
    /* 201BC 8002F9BC 3001A98F */  lw         $t1, 0x130($sp)
    /* 201C0 8002F9C0 21380000 */  addu       $a3, $zero, $zero
    /* 201C4 8002F9C4 1000A9AF */  sw         $t1, 0x10($sp)
    /* 201C8 8002F9C8 2801A98F */  lw         $t1, 0x128($sp)
    /* 201CC 8002F9CC BA000824 */  addiu      $t0, $zero, 0xBA
    /* 201D0 8002F9D0 1400B0AF */  sw         $s0, 0x14($sp)
    /* 201D4 8002F9D4 1800A8AF */  sw         $t0, 0x18($sp)
    /* 201D8 8002F9D8 2000B3AF */  sw         $s3, 0x20($sp)
    /* 201DC 8002F9DC 2400A0AF */  sw         $zero, 0x24($sp)
    /* 201E0 8002F9E0 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 201E4 8002F9E4 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 201E8 8002F9E8 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 201EC 8002F9EC 21300000 */  addu       $a2, $zero, $zero
    /* 201F0 8002F9F0 21380002 */  addu       $a3, $s0, $zero
    /* 201F4 8002F9F4 8002A88F */  lw         $t0, 0x280($sp)
    /* 201F8 8002F9F8 2A000924 */  addiu      $t1, $zero, 0x2A
    /* 201FC 8002F9FC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20200 8002FA00 04190825 */  addiu      $t0, $t0, 0x1904
    /* 20204 8002FA04 21200001 */  addu       $a0, $t0, $zero
    /* 20208 8002FA08 4001A8AF */  sw         $t0, 0x140($sp)
    /* 2020C 8002FA0C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20210 8002FA10 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20214 8002FA14 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20218 8002FA18 92000524 */  addiu      $a1, $zero, 0x92
    /* 2021C 8002FA1C 0C000724 */  addiu      $a3, $zero, 0xC
    /* 20220 8002FA20 8002A98F */  lw         $t1, 0x280($sp)
    /* 20224 8002FA24 1001A68F */  lw         $a2, 0x110($sp)
    /* 20228 8002FA28 0A000824 */  addiu      $t0, $zero, 0xA
    /* 2022C 8002FA2C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 20230 8002FA30 30193325 */  addiu      $s3, $t1, 0x1930
    /* 20234 8002FA34 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20238 8002FA38 21206002 */   addu      $a0, $s3, $zero
    /* 2023C 8002FA3C 08100524 */  addiu      $a1, $zero, 0x1008
    /* 20240 8002FA40 0580083C */  lui        $t0, %hi(screenCarSelectPlayerTwo)
    /* 20244 8002FA44 8002A98F */  lw         $t1, 0x280($sp)
    /* 20248 8002FA48 4820068D */  lw         $a2, %lo(screenCarSelectPlayerTwo)($t0)
    /* 2024C 8002FA4C 58192425 */  addiu      $a0, $t1, 0x1958
    /* 20250 8002FA50 3C01A98F */  lw         $t1, 0x13C($sp)
    /* 20254 8002FA54 21380000 */  addu       $a3, $zero, $zero
    /* 20258 8002FA58 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2025C 8002FA5C 4001A98F */  lw         $t1, 0x140($sp)
    /* 20260 8002FA60 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 20264 8002FA64 1400B0AF */  sw         $s0, 0x14($sp)
    /* 20268 8002FA68 1800A8AF */  sw         $t0, 0x18($sp)
    /* 2026C 8002FA6C 2000B3AF */  sw         $s3, 0x20($sp)
    /* 20270 8002FA70 2400A0AF */  sw         $zero, 0x24($sp)
    /* 20274 8002FA74 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20278 8002FA78 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 2027C 8002FA7C 1180093C */  lui        $t1, %hi(D_8011465C)
    /* 20280 8002FA80 5C462925 */  addiu      $t1, $t1, %lo(D_8011465C)
    /* 20284 8002FA84 C9002525 */  addiu      $a1, $t1, 0xC9
    /* 20288 8002FA88 8002A88F */  lw         $t0, 0x280($sp)
    /* 2028C 8002FA8C 1180063C */  lui        $a2, %hi(carManager)
    /* 20290 8002FA90 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 20294 8002FA94 D4191325 */  addiu      $s3, $t0, 0x19D4
    /* 20298 8002FA98 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 2029C 8002FA9C 21206002 */   addu      $a0, $s3, $zero
    /* 202A0 8002FAA0 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 202A4 8002FAA4 21300000 */  addu       $a2, $zero, $zero
    /* 202A8 8002FAA8 21380002 */  addu       $a3, $s0, $zero
    /* 202AC 8002FAAC 8002A88F */  lw         $t0, 0x280($sp)
    /* 202B0 8002FAB0 2A000924 */  addiu      $t1, $zero, 0x2A
    /* 202B4 8002FAB4 1000A9AF */  sw         $t1, 0x10($sp)
    /* 202B8 8002FAB8 F0190825 */  addiu      $t0, $t0, 0x19F0
    /* 202BC 8002FABC 21200001 */  addu       $a0, $t0, $zero
    /* 202C0 8002FAC0 4401A8AF */  sw         $t0, 0x144($sp)
    /* 202C4 8002FAC4 0A000824 */  addiu      $t0, $zero, 0xA
    /* 202C8 8002FAC8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 202CC 8002FACC 1400A8AF */   sw        $t0, 0x14($sp)
    /* 202D0 8002FAD0 92000524 */  addiu      $a1, $zero, 0x92
    /* 202D4 8002FAD4 21306002 */  addu       $a2, $s3, $zero
    /* 202D8 8002FAD8 0C000724 */  addiu      $a3, $zero, 0xC
    /* 202DC 8002FADC 8002A98F */  lw         $t1, 0x280($sp)
    /* 202E0 8002FAE0 0A000824 */  addiu      $t0, $zero, 0xA
    /* 202E4 8002FAE4 1000A8AF */  sw         $t0, 0x10($sp)
    /* 202E8 8002FAE8 1C1A2925 */  addiu      $t1, $t1, 0x1A1C
    /* 202EC 8002FAEC 21202001 */  addu       $a0, $t1, $zero
    /* 202F0 8002FAF0 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 202F4 8002FAF4 4801A9AF */   sw        $t1, 0x148($sp)
    /* 202F8 8002FAF8 08100524 */  addiu      $a1, $zero, 0x1008
    /* 202FC 8002FAFC 0580083C */  lui        $t0, %hi(screenPinkSlipsCarSelectTwoPlayer)
    /* 20300 8002FB00 8002A98F */  lw         $t1, 0x280($sp)
    /* 20304 8002FB04 4C20068D */  lw         $a2, %lo(screenPinkSlipsCarSelectTwoPlayer)($t0)
    /* 20308 8002FB08 BA000824 */  addiu      $t0, $zero, 0xBA
    /* 2030C 8002FB0C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 20310 8002FB10 4801A88F */  lw         $t0, 0x148($sp)
    /* 20314 8002FB14 441A2425 */  addiu      $a0, $t1, 0x1A44
    /* 20318 8002FB18 64222925 */  addiu      $t1, $t1, 0x2264
    /* 2031C 8002FB1C 4C01A9AF */  sw         $t1, 0x14C($sp)
    /* 20320 8002FB20 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20324 8002FB24 4401A98F */  lw         $t1, 0x144($sp)
    /* 20328 8002FB28 21380000 */  addu       $a3, $zero, $zero
    /* 2032C 8002FB2C 1400B0AF */  sw         $s0, 0x14($sp)
    /* 20330 8002FB30 2400A0AF */  sw         $zero, 0x24($sp)
    /* 20334 8002FB34 2000A8AF */  sw         $t0, 0x20($sp)
    /* 20338 8002FB38 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 2033C 8002FB3C 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 20340 8002FB40 BD000524 */  addiu      $a1, $zero, 0xBD
    /* 20344 8002FB44 21300000 */  addu       $a2, $zero, $zero
    /* 20348 8002FB48 21380002 */  addu       $a3, $s0, $zero
    /* 2034C 8002FB4C 8002A98F */  lw         $t1, 0x280($sp)
    /* 20350 8002FB50 2A000824 */  addiu      $t0, $zero, 0x2A
    /* 20354 8002FB54 1000A8AF */  sw         $t0, 0x10($sp)
    /* 20358 8002FB58 C01A2925 */  addiu      $t1, $t1, 0x1AC0
    /* 2035C 8002FB5C 21202001 */  addu       $a0, $t1, $zero
    /* 20360 8002FB60 5001A9AF */  sw         $t1, 0x150($sp)
    /* 20364 8002FB64 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20368 8002FB68 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 2036C 8002FB6C 1400A9AF */   sw        $t1, 0x14($sp)
    /* 20370 8002FB70 92000524 */  addiu      $a1, $zero, 0x92
    /* 20374 8002FB74 21306002 */  addu       $a2, $s3, $zero
    /* 20378 8002FB78 0C000724 */  addiu      $a3, $zero, 0xC
    /* 2037C 8002FB7C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20380 8002FB80 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20384 8002FB84 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20388 8002FB88 EC1A0825 */  addiu      $t0, $t0, 0x1AEC
    /* 2038C 8002FB8C 21200001 */  addu       $a0, $t0, $zero
    /* 20390 8002FB90 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20394 8002FB94 5401A8AF */   sw        $t0, 0x154($sp)
    /* 20398 8002FB98 08100524 */  addiu      $a1, $zero, 0x1008
    /* 2039C 8002FB9C 0580093C */  lui        $t1, %hi(screenPinkSlipsCarSelectPlayerTwo)
    /* 203A0 8002FBA0 8002A88F */  lw         $t0, 0x280($sp)
    /* 203A4 8002FBA4 5020268D */  lw         $a2, %lo(screenPinkSlipsCarSelectPlayerTwo)($t1)
    /* 203A8 8002FBA8 BA000924 */  addiu      $t1, $zero, 0xBA
    /* 203AC 8002FBAC 1800A9AF */  sw         $t1, 0x18($sp)
    /* 203B0 8002FBB0 5401A98F */  lw         $t1, 0x154($sp)
    /* 203B4 8002FBB4 141B0425 */  addiu      $a0, $t0, 0x1B14
    /* 203B8 8002FBB8 E8220825 */  addiu      $t0, $t0, 0x22E8
    /* 203BC 8002FBBC 5801A8AF */  sw         $t0, 0x158($sp)
    /* 203C0 8002FBC0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 203C4 8002FBC4 5001A88F */  lw         $t0, 0x150($sp)
    /* 203C8 8002FBC8 21380000 */  addu       $a3, $zero, $zero
    /* 203CC 8002FBCC 1400B0AF */  sw         $s0, 0x14($sp)
    /* 203D0 8002FBD0 2400A0AF */  sw         $zero, 0x24($sp)
    /* 203D4 8002FBD4 2000A9AF */  sw         $t1, 0x20($sp)
    /* 203D8 8002FBD8 8F6D000C */  jal        __18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 203DC 8002FBDC 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 203E0 8002FBE0 78000524 */  addiu      $a1, $zero, 0x78
    /* 203E4 8002FBE4 0380073C */  lui        $a3, %hi(func_8002C890)
    /* 203E8 8002FBE8 90C8E724 */  addiu      $a3, $a3, %lo(func_8002C890)
    /* 203EC 8002FBEC 8002A88F */  lw         $t0, 0x280($sp)
    /* 203F0 8002FBF0 2401A68F */  lw         $a2, 0x124($sp)
    /* 203F4 8002FBF4 58000924 */  addiu      $t1, $zero, 0x58
    /* 203F8 8002FBF8 1000A9AF */  sw         $t1, 0x10($sp)
    /* 203FC 8002FBFC 901B1325 */  addiu      $s3, $t0, 0x1B90
    /* 20400 8002FC00 21206002 */  addu       $a0, $s3, $zero
    /* 20404 8002FC04 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20408 8002FC08 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 2040C 8002FC0C 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20410 8002FC10 79000524 */  addiu      $a1, $zero, 0x79
    /* 20414 8002FC14 0380073C */  lui        $a3, %hi(func_8002C8F8)
    /* 20418 8002FC18 F8C8E724 */  addiu      $a3, $a3, %lo(func_8002C8F8)
    /* 2041C 8002FC1C 8002A98F */  lw         $t1, 0x280($sp)
    /* 20420 8002FC20 4E000824 */  addiu      $t0, $zero, 0x4E
    /* 20424 8002FC24 1000A8AF */  sw         $t0, 0x10($sp)
    /* 20428 8002FC28 BC1B3025 */  addiu      $s0, $t1, 0x1BBC
    /* 2042C 8002FC2C 21200002 */  addu       $a0, $s0, $zero
    /* 20430 8002FC30 341E3E25 */  addiu      $fp, $t1, 0x1E34
    /* 20434 8002FC34 2130C003 */  addu       $a2, $fp, $zero
    /* 20438 8002FC38 0A000924 */  addiu      $t1, $zero, 0xA
    /* 2043C 8002FC3C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20440 8002FC40 1400A9AF */   sw        $t1, 0x14($sp)
    /* 20444 8002FC44 00120524 */  addiu      $a1, $zero, 0x1200
    /* 20448 8002FC48 0580083C */  lui        $t0, %hi(screenCarSelect)
    /* 2044C 8002FC4C 21380000 */  addu       $a3, $zero, $zero
    /* 20450 8002FC50 1801A48F */  lw         $a0, 0x118($sp)
    /* 20454 8002FC54 3C20068D */  lw         $a2, %lo(screenCarSelect)($t0)
    /* 20458 8002FC58 90000924 */  addiu      $t1, $zero, 0x90
    /* 2045C 8002FC5C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20460 8002FC60 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20464 8002FC64 1800A9AF */  sw         $t1, 0x18($sp)
    /* 20468 8002FC68 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 2046C 8002FC6C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 20470 8002FC70 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20474 8002FC74 2400A0AF */   sw        $zero, 0x24($sp)
    /* 20478 8002FC78 1180093C */  lui        $t1, %hi(D_8011465C)
    /* 2047C 8002FC7C 5C462925 */  addiu      $t1, $t1, %lo(D_8011465C)
    /* 20480 8002FC80 CC003025 */  addiu      $s0, $t1, 0xCC
    /* 20484 8002FC84 21280002 */  addu       $a1, $s0, $zero
    /* 20488 8002FC88 8002A88F */  lw         $t0, 0x280($sp)
    /* 2048C 8002FC8C 1180063C */  lui        $a2, %hi(carManager)
    /* 20490 8002FC90 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 20494 8002FC94 641C1325 */  addiu      $s3, $t0, 0x1C64
    /* 20498 8002FC98 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 2049C 8002FC9C 21206002 */   addu      $a0, $s3, $zero
    /* 204A0 8002FCA0 1180053C */  lui        $a1, %hi(D_80114660)
    /* 204A4 8002FCA4 6046A524 */  addiu      $a1, $a1, %lo(D_80114660)
    /* 204A8 8002FCA8 0580093C */  lui        $t1, %hi(FEApp)
    /* 204AC 8002FCAC 21380002 */  addu       $a3, $s0, $zero
    /* 204B0 8002FCB0 8002A88F */  lw         $t0, 0x280($sp)
    /* 204B4 8002FCB4 C014268D */  lw         $a2, %lo(FEApp)($t1)
    /* 204B8 8002FCB8 1180093C */  lui        $t1, %hi(carManager)
    /* 204BC 8002FCBC 74422925 */  addiu      $t1, $t1, %lo(carManager)
    /* 204C0 8002FCC0 1400A9AF */  sw         $t1, 0x14($sp)
    /* 204C4 8002FCC4 801C0825 */  addiu      $t0, $t0, 0x1C80
    /* 204C8 8002FCC8 21200001 */  addu       $a0, $t0, $zero
    /* 204CC 8002FCCC 5C01A8AF */  sw         $t0, 0x15C($sp)
    /* 204D0 8002FCD0 30000824 */  addiu      $t0, $zero, 0x30
    /* 204D4 8002FCD4 2C02C624 */  addiu      $a2, $a2, 0x22C
    /* 204D8 8002FCD8 2861000C */  jal        __21tListIteratorCarColorPcN21iP11tCarManager
    /* 204DC 8002FCDC 1000A8AF */   sw        $t0, 0x10($sp)
    /* 204E0 8002FCE0 92000524 */  addiu      $a1, $zero, 0x92
    /* 204E4 8002FCE4 21306002 */  addu       $a2, $s3, $zero
    /* 204E8 8002FCE8 1C000724 */  addiu      $a3, $zero, 0x1C
    /* 204EC 8002FCEC 8002A88F */  lw         $t0, 0x280($sp)
    /* 204F0 8002FCF0 0A000924 */  addiu      $t1, $zero, 0xA
    /* 204F4 8002FCF4 1000A9AF */  sw         $t1, 0x10($sp)
    /* 204F8 8002FCF8 A01C0825 */  addiu      $t0, $t0, 0x1CA0
    /* 204FC 8002FCFC 21200001 */  addu       $a0, $t0, $zero
    /* 20500 8002FD00 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20504 8002FD04 6001A8AF */   sw        $t0, 0x160($sp)
    /* 20508 8002FD08 20010524 */  addiu      $a1, $zero, 0x120
    /* 2050C 8002FD0C 26000724 */  addiu      $a3, $zero, 0x26
    /* 20510 8002FD10 8002A88F */  lw         $t0, 0x280($sp)
    /* 20514 8002FD14 5C01A68F */  lw         $a2, 0x15C($sp)
    /* 20518 8002FD18 0A000924 */  addiu      $t1, $zero, 0xA
    /* 2051C 8002FD1C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20520 8002FD20 C81C0825 */  addiu      $t0, $t0, 0x1CC8
    /* 20524 8002FD24 21200001 */  addu       $a0, $t0, $zero
    /* 20528 8002FD28 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 2052C 8002FD2C 6401A8AF */   sw        $t0, 0x164($sp)
    /* 20530 8002FD30 75000524 */  addiu      $a1, $zero, 0x75
    /* 20534 8002FD34 21300000 */  addu       $a2, $zero, $zero
    /* 20538 8002FD38 0380073C */  lui        $a3, %hi(MenuExtended_BuyCar__FR12tMenuCommand)
    /* 2053C 8002FD3C F8D4E724 */  addiu      $a3, $a3, %lo(MenuExtended_BuyCar__FR12tMenuCommand)
    /* 20540 8002FD40 8002A88F */  lw         $t0, 0x280($sp)
    /* 20544 8002FD44 58000924 */  addiu      $t1, $zero, 0x58
    /* 20548 8002FD48 1000A9AF */  sw         $t1, 0x10($sp)
    /* 2054C 8002FD4C F01C1325 */  addiu      $s3, $t0, 0x1CF0
    /* 20550 8002FD50 21206002 */  addu       $a0, $s3, $zero
    /* 20554 8002FD54 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20558 8002FD58 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 2055C 8002FD5C 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20560 8002FD60 12010524 */  addiu      $a1, $zero, 0x112
    /* 20564 8002FD64 21300000 */  addu       $a2, $zero, $zero
    /* 20568 8002FD68 0380073C */  lui        $a3, %hi(MenuExtended_GoToDealerShowroom__FR12tMenuCommand)
    /* 2056C 8002FD6C B8D2E724 */  addiu      $a3, $a3, %lo(MenuExtended_GoToDealerShowroom__FR12tMenuCommand)
    /* 20570 8002FD70 8002A98F */  lw         $t1, 0x280($sp)
    /* 20574 8002FD74 30000824 */  addiu      $t0, $zero, 0x30
    /* 20578 8002FD78 1000A8AF */  sw         $t0, 0x10($sp)
    /* 2057C 8002FD7C 1C1D3025 */  addiu      $s0, $t1, 0x1D1C
    /* 20580 8002FD80 21200002 */  addu       $a0, $s0, $zero
    /* 20584 8002FD84 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20588 8002FD88 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 2058C 8002FD8C 1400A9AF */   sw        $t1, 0x14($sp)
    /* 20590 8002FD90 40220524 */  addiu      $a1, $zero, 0x2240
    /* 20594 8002FD94 0580083C */  lui        $t0, %hi(screenCarSelect)
    /* 20598 8002FD98 2401A48F */  lw         $a0, 0x124($sp)
    /* 2059C 8002FD9C 3C20068D */  lw         $a2, %lo(screenCarSelect)($t0)
    /* 205A0 8002FDA0 6001A88F */  lw         $t0, 0x160($sp)
    /* 205A4 8002FDA4 90000924 */  addiu      $t1, $zero, 0x90
    /* 205A8 8002FDA8 1800A9AF */  sw         $t1, 0x18($sp)
    /* 205AC 8002FDAC 6401A98F */  lw         $t1, 0x164($sp)
    /* 205B0 8002FDB0 21380000 */  addu       $a3, $zero, $zero
    /* 205B4 8002FDB4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 205B8 8002FDB8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 205BC 8002FDBC 2400B3AF */  sw         $s3, 0x24($sp)
    /* 205C0 8002FDC0 2800B0AF */  sw         $s0, 0x28($sp)
    /* 205C4 8002FDC4 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 205C8 8002FDC8 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 205CC 8002FDCC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 205D0 8002FDD0 2000A9AF */   sw        $t1, 0x20($sp)
    /* 205D4 8002FDD4 1180093C */  lui        $t1, %hi(D_8011465C)
    /* 205D8 8002FDD8 5C462925 */  addiu      $t1, $t1, %lo(D_8011465C)
    /* 205DC 8002FDDC CD002525 */  addiu      $a1, $t1, 0xCD
    /* 205E0 8002FDE0 8002A88F */  lw         $t0, 0x280($sp)
    /* 205E4 8002FDE4 1180063C */  lui        $a2, %hi(carManager)
    /* 205E8 8002FDE8 7442C624 */  addiu      $a2, $a2, %lo(carManager)
    /* 205EC 8002FDEC C41D1025 */  addiu      $s0, $t0, 0x1DC4
    /* 205F0 8002FDF0 335E000C */  jal        __16tListIteratorCarPcP11tCarManager
    /* 205F4 8002FDF4 21200002 */   addu      $a0, $s0, $zero
    /* 205F8 8002FDF8 92000524 */  addiu      $a1, $zero, 0x92
    /* 205FC 8002FDFC 21300002 */  addu       $a2, $s0, $zero
    /* 20600 8002FE00 1C000724 */  addiu      $a3, $zero, 0x1C
    /* 20604 8002FE04 8002A88F */  lw         $t0, 0x280($sp)
    /* 20608 8002FE08 0A000924 */  addiu      $t1, $zero, 0xA
    /* 2060C 8002FE0C 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20610 8002FE10 E01D1325 */  addiu      $s3, $t0, 0x1DE0
    /* 20614 8002FE14 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 20618 8002FE18 21206002 */   addu      $a0, $s3, $zero
    /* 2061C 8002FE1C 77000524 */  addiu      $a1, $zero, 0x77
    /* 20620 8002FE20 21300000 */  addu       $a2, $zero, $zero
    /* 20624 8002FE24 0380073C */  lui        $a3, %hi(MenuExtended_SellCar__FR12tMenuCommand)
    /* 20628 8002FE28 A0D3E724 */  addiu      $a3, $a3, %lo(MenuExtended_SellCar__FR12tMenuCommand)
    /* 2062C 8002FE2C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20630 8002FE30 4E000924 */  addiu      $t1, $zero, 0x4E
    /* 20634 8002FE34 1000A9AF */  sw         $t1, 0x10($sp)
    /* 20638 8002FE38 081E1025 */  addiu      $s0, $t0, 0x1E08
    /* 2063C 8002FE3C 21200002 */  addu       $a0, $s0, $zero
    /* 20640 8002FE40 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20644 8002FE44 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20648 8002FE48 1400A8AF */   sw        $t0, 0x14($sp)
    /* 2064C 8002FE4C 2120C003 */  addu       $a0, $fp, $zero
    /* 20650 8002FE50 00220524 */  addiu      $a1, $zero, 0x2200
    /* 20654 8002FE54 0580093C */  lui        $t1, %hi(screenCarSelect)
    /* 20658 8002FE58 21380000 */  addu       $a3, $zero, $zero
    /* 2065C 8002FE5C 3C20268D */  lw         $a2, %lo(screenCarSelect)($t1)
    /* 20660 8002FE60 90000824 */  addiu      $t0, $zero, 0x90
    /* 20664 8002FE64 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20668 8002FE68 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2066C 8002FE6C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 20670 8002FE70 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 20674 8002FE74 2000B0AF */  sw         $s0, 0x20($sp)
    /* 20678 8002FE78 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 2067C 8002FE7C 2400A0AF */   sw        $zero, 0x24($sp)
    /* 20680 8002FE80 96000524 */  addiu      $a1, $zero, 0x96
    /* 20684 8002FE84 21300000 */  addu       $a2, $zero, $zero
    /* 20688 8002FE88 0380073C */  lui        $a3, %hi(MenuExtended_PurchaseUpgrade1__FR12tMenuCommand)
    /* 2068C 8002FE8C 8CD7E724 */  addiu      $a3, $a3, %lo(MenuExtended_PurchaseUpgrade1__FR12tMenuCommand)
    /* 20690 8002FE90 62000224 */  addiu      $v0, $zero, 0x62
    /* 20694 8002FE94 8002A98F */  lw         $t1, 0x280($sp)
    /* 20698 8002FE98 0A000824 */  addiu      $t0, $zero, 0xA
    /* 2069C 8002FE9C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 206A0 8002FEA0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 206A4 8002FEA4 B01E2925 */  addiu      $t1, $t1, 0x1EB0
    /* 206A8 8002FEA8 21202001 */  addu       $a0, $t1, $zero
    /* 206AC 8002FEAC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 206B0 8002FEB0 6801A9AF */   sw        $t1, 0x168($sp)
    /* 206B4 8002FEB4 97000524 */  addiu      $a1, $zero, 0x97
    /* 206B8 8002FEB8 21300000 */  addu       $a2, $zero, $zero
    /* 206BC 8002FEBC 0380073C */  lui        $a3, %hi(MenuExtended_PurchaseUpgrade2__FR12tMenuCommand)
    /* 206C0 8002FEC0 ACD7E724 */  addiu      $a3, $a3, %lo(MenuExtended_PurchaseUpgrade2__FR12tMenuCommand)
    /* 206C4 8002FEC4 6C000224 */  addiu      $v0, $zero, 0x6C
    /* 206C8 8002FEC8 8002A98F */  lw         $t1, 0x280($sp)
    /* 206CC 8002FECC 0A000824 */  addiu      $t0, $zero, 0xA
    /* 206D0 8002FED0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 206D4 8002FED4 1400A8AF */  sw         $t0, 0x14($sp)
    /* 206D8 8002FED8 DC1E3325 */  addiu      $s3, $t1, 0x1EDC
    /* 206DC 8002FEDC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 206E0 8002FEE0 21206002 */   addu      $a0, $s3, $zero
    /* 206E4 8002FEE4 98000524 */  addiu      $a1, $zero, 0x98
    /* 206E8 8002FEE8 21300000 */  addu       $a2, $zero, $zero
    /* 206EC 8002FEEC 0380073C */  lui        $a3, %hi(MenuExtended_PurchaseUpgrade3__FR12tMenuCommand)
    /* 206F0 8002FEF0 CCD7E724 */  addiu      $a3, $a3, %lo(MenuExtended_PurchaseUpgrade3__FR12tMenuCommand)
    /* 206F4 8002FEF4 76000224 */  addiu      $v0, $zero, 0x76
    /* 206F8 8002FEF8 8002A98F */  lw         $t1, 0x280($sp)
    /* 206FC 8002FEFC 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20700 8002FF00 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20704 8002FF04 1400A8AF */  sw         $t0, 0x14($sp)
    /* 20708 8002FF08 081F3025 */  addiu      $s0, $t1, 0x1F08
    /* 2070C 8002FF0C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20710 8002FF10 21200002 */   addu      $a0, $s0, $zero
    /* 20714 8002FF14 00220524 */  addiu      $a1, $zero, 0x2200
    /* 20718 8002FF18 0580083C */  lui        $t0, %hi(screenCarSelect)
    /* 2071C 8002FF1C 21380000 */  addu       $a3, $zero, $zero
    /* 20720 8002FF20 8002A98F */  lw         $t1, 0x280($sp)
    /* 20724 8002FF24 3C20068D */  lw         $a2, %lo(screenCarSelect)($t0)
    /* 20728 8002FF28 341F2425 */  addiu      $a0, $t1, 0x1F34
    /* 2072C 8002FF2C 6801A98F */  lw         $t1, 0x168($sp)
    /* 20730 8002FF30 91000224 */  addiu      $v0, $zero, 0x91
    /* 20734 8002FF34 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20738 8002FF38 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2073C 8002FF3C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 20740 8002FF40 2000B3AF */  sw         $s3, 0x20($sp)
    /* 20744 8002FF44 2400B0AF */  sw         $s0, 0x24($sp)
    /* 20748 8002FF48 2800A0AF */  sw         $zero, 0x28($sp)
    /* 2074C 8002FF4C 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20750 8002FF50 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 20754 8002FF54 0580053C */  lui        $a1, %hi(SelectListTransmission)
    /* 20758 8002FF58 9419A524 */  addiu      $a1, $a1, %lo(SelectListTransmission)
    /* 2075C 8002FF5C 0580093C */  lui        $t1, %hi(FEApp)
    /* 20760 8002FF60 1180063C */  lui        $a2, %hi(D_8011465C + 0x2)
    /* 20764 8002FF64 5E46C624 */  addiu      $a2, $a2, %lo(D_8011465C + 0x2)
    /* 20768 8002FF68 8002A88F */  lw         $t0, 0x280($sp)
    /* 2076C 8002FF6C C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20770 8002FF70 B01F0825 */  addiu      $t0, $t0, 0x1FB0
    /* 20774 8002FF74 21200001 */  addu       $a0, $t0, $zero
    /* 20778 8002FF78 2C02E724 */  addiu      $a3, $a3, 0x22C
    /* 2077C 8002FF7C D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20780 8002FF80 6C01A8AF */   sw        $t0, 0x16C($sp)
    /* 20784 8002FF84 0580053C */  lui        $a1, %hi(SelectListOffOn)
    /* 20788 8002FF88 7419A524 */  addiu      $a1, $a1, %lo(SelectListOffOn)
    /* 2078C 8002FF8C 0580093C */  lui        $t1, %hi(FEApp)
    /* 20790 8002FF90 8002A88F */  lw         $t0, 0x280($sp)
    /* 20794 8002FF94 C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20798 8002FF98 C41F1325 */  addiu      $s3, $t0, 0x1FC4
    /* 2079C 8002FF9C 21206002 */  addu       $a0, $s3, $zero
    /* 207A0 8002FFA0 1180083C */  lui        $t0, %hi(D_80114723)
    /* 207A4 8002FFA4 23470825 */  addiu      $t0, $t0, %lo(D_80114723)
    /* 207A8 8002FFA8 F1010625 */  addiu      $a2, $t0, 0x1F1
    /* 207AC 8002FFAC D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 207B0 8002FFB0 2C02E724 */   addiu     $a3, $a3, 0x22C
    /* 207B4 8002FFB4 0580053C */  lui        $a1, %hi(SelectListOffOn)
    /* 207B8 8002FFB8 7419A524 */  addiu      $a1, $a1, %lo(SelectListOffOn)
    /* 207BC 8002FFBC 1180083C */  lui        $t0, %hi(D_80114723)
    /* 207C0 8002FFC0 23470825 */  addiu      $t0, $t0, %lo(D_80114723)
    /* 207C4 8002FFC4 8002A98F */  lw         $t1, 0x280($sp)
    /* 207C8 8002FFC8 F3010625 */  addiu      $a2, $t0, 0x1F3
    /* 207CC 8002FFCC D81F2925 */  addiu      $t1, $t1, 0x1FD8
    /* 207D0 8002FFD0 21202001 */  addu       $a0, $t1, $zero
    /* 207D4 8002FFD4 748F000C */  jal        __13tListIteratorPsPc
    /* 207D8 8002FFD8 7001A9AF */   sw        $t1, 0x170($sp)
    /* 207DC 8002FFDC 0580053C */  lui        $a1, %hi(SelectListOpponentUpgrades)
    /* 207E0 8002FFE0 8419A524 */  addiu      $a1, $a1, %lo(SelectListOpponentUpgrades)
    /* 207E4 8002FFE4 1180083C */  lui        $t0, %hi(D_80114723)
    /* 207E8 8002FFE8 23470825 */  addiu      $t0, $t0, %lo(D_80114723)
    /* 207EC 8002FFEC 8002A98F */  lw         $t1, 0x280($sp)
    /* 207F0 8002FFF0 FFFE0625 */  addiu      $a2, $t0, -0x101
    /* 207F4 8002FFF4 E81F3125 */  addiu      $s1, $t1, 0x1FE8
    /* 207F8 8002FFF8 748F000C */  jal        __13tListIteratorPsPc
    /* 207FC 8002FFFC 21202002 */   addu      $a0, $s1, $zero
    /* 20800 80030000 0A010524 */  addiu      $a1, $zero, 0x10A
    /* 20804 80030004 8002A98F */  lw         $t1, 0x280($sp)
    /* 20808 80030008 6C01A68F */  lw         $a2, 0x16C($sp)
    /* 2080C 8003000C F81F2925 */  addiu      $t1, $t1, 0x1FF8
    /* 20810 80030010 21202001 */  addu       $a0, $t1, $zero
    /* 20814 80030014 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 20818 80030018 7401A9AF */   sw        $t1, 0x174($sp)
    /* 2081C 8003001C 0B010524 */  addiu      $a1, $zero, 0x10B
    /* 20820 80030020 21306002 */  addu       $a2, $s3, $zero
    /* 20824 80030024 0180103C */  lui        $s0, %hi(_vt_31tMenuItemOptionsLeftRightChoice)
    /* 20828 80030028 58081026 */  addiu      $s0, $s0, %lo(_vt_31tMenuItemOptionsLeftRightChoice)
    /* 2082C 8003002C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20830 80030030 7401A98F */  lw         $t1, 0x174($sp)
    /* 20834 80030034 18200825 */  addiu      $t0, $t0, 0x2018
    /* 20838 80030038 21200001 */  addu       $a0, $t0, $zero
    /* 2083C 8003003C 7801A8AF */  sw         $t0, 0x178($sp)
    /* 20840 80030040 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 20844 80030044 180030AD */   sw        $s0, 0x18($t1)
    /* 20848 80030048 11010524 */  addiu      $a1, $zero, 0x111
    /* 2084C 8003004C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20850 80030050 7001A68F */  lw         $a2, 0x170($sp)
    /* 20854 80030054 7801A98F */  lw         $t1, 0x178($sp)
    /* 20858 80030058 38200825 */  addiu      $t0, $t0, 0x2038
    /* 2085C 8003005C 21200001 */  addu       $a0, $t0, $zero
    /* 20860 80030060 7C01A8AF */  sw         $t0, 0x17C($sp)
    /* 20864 80030064 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 20868 80030068 180030AD */   sw        $s0, 0x18($t1)
    /* 2086C 8003006C 0A010524 */  addiu      $a1, $zero, 0x10A
    /* 20870 80030070 8002A88F */  lw         $t0, 0x280($sp)
    /* 20874 80030074 6C01A68F */  lw         $a2, 0x16C($sp)
    /* 20878 80030078 7C01A98F */  lw         $t1, 0x17C($sp)
    /* 2087C 8003007C 58201E25 */  addiu      $fp, $t0, 0x2058
    /* 20880 80030080 2120C003 */  addu       $a0, $fp, $zero
    /* 20884 80030084 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 20888 80030088 180030AD */   sw        $s0, 0x18($t1)
    /* 2088C 8003008C 0B010524 */  addiu      $a1, $zero, 0x10B
    /* 20890 80030090 8002A88F */  lw         $t0, 0x280($sp)
    /* 20894 80030094 21306002 */  addu       $a2, $s3, $zero
    /* 20898 80030098 78200825 */  addiu      $t0, $t0, 0x2078
    /* 2089C 8003009C 21200001 */  addu       $a0, $t0, $zero
    /* 208A0 800300A0 8001A8AF */  sw         $t0, 0x180($sp)
    /* 208A4 800300A4 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 208A8 800300A8 1800D0AF */   sw        $s0, 0x18($fp)
    /* 208AC 800300AC 11010524 */  addiu      $a1, $zero, 0x111
    /* 208B0 800300B0 8002A98F */  lw         $t1, 0x280($sp)
    /* 208B4 800300B4 7001A68F */  lw         $a2, 0x170($sp)
    /* 208B8 800300B8 8001A88F */  lw         $t0, 0x180($sp)
    /* 208BC 800300BC 98203325 */  addiu      $s3, $t1, 0x2098
    /* 208C0 800300C0 21206002 */  addu       $a0, $s3, $zero
    /* 208C4 800300C4 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 208C8 800300C8 180010AD */   sw        $s0, 0x18($t0)
    /* 208CC 800300CC 0E010524 */  addiu      $a1, $zero, 0x10E
    /* 208D0 800300D0 8002A98F */  lw         $t1, 0x280($sp)
    /* 208D4 800300D4 21302002 */  addu       $a2, $s1, $zero
    /* 208D8 800300D8 B8202925 */  addiu      $t1, $t1, 0x20B8
    /* 208DC 800300DC 21202001 */  addu       $a0, $t1, $zero
    /* 208E0 800300E0 8401A9AF */  sw         $t1, 0x184($sp)
    /* 208E4 800300E4 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* 208E8 800300E8 180070AE */   sw        $s0, 0x18($s3)
    /* 208EC 800300EC 0C01A48F */  lw         $a0, 0x10C($sp)
    /* 208F0 800300F0 8401A88F */  lw         $t0, 0x184($sp)
    /* 208F4 800300F4 00100524 */  addiu      $a1, $zero, 0x1000
    /* 208F8 800300F8 180010AD */  sw         $s0, 0x18($t0)
    /* 208FC 800300FC 7401A88F */  lw         $t0, 0x174($sp)
    /* 20900 80030100 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 20904 80030104 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 20908 80030108 7801A98F */  lw         $t1, 0x178($sp)
    /* 2090C 8003010C 21300000 */  addu       $a2, $zero, $zero
    /* 20910 80030110 2000A8AF */  sw         $t0, 0x20($sp)
    /* 20914 80030114 7C01A88F */  lw         $t0, 0x17C($sp)
    /* 20918 80030118 2138C000 */  addu       $a3, $a2, $zero
    /* 2091C 8003011C 2400A9AF */  sw         $t1, 0x24($sp)
    /* 20920 80030120 8401A98F */  lw         $t1, 0x184($sp)
    /* 20924 80030124 BB001024 */  addiu      $s0, $zero, 0xBB
    /* 20928 80030128 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2092C 8003012C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20930 80030130 1800B0AF */  sw         $s0, 0x18($sp)
    /* 20934 80030134 3000A0AF */  sw         $zero, 0x30($sp)
    /* 20938 80030138 2800A8AF */  sw         $t0, 0x28($sp)
    /* 2093C 8003013C 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 20940 80030140 2C00A9AF */   sw        $t1, 0x2C($sp)
    /* 20944 80030144 0580083C */  lui        $t0, %hi(screenCarSelectTwoPlayer)
    /* 20948 80030148 3001A48F */  lw         $a0, 0x130($sp)
    /* 2094C 8003014C 4420068D */  lw         $a2, %lo(screenCarSelectTwoPlayer)($t0)
    /* 20950 80030150 7401A98F */  lw         $t1, 0x174($sp)
    /* 20954 80030154 7801A88F */  lw         $t0, 0x178($sp)
    /* 20958 80030158 08100524 */  addiu      $a1, $zero, 0x1008
    /* 2095C 8003015C 2000A9AF */  sw         $t1, 0x20($sp)
    /* 20960 80030160 7C01A98F */  lw         $t1, 0x17C($sp)
    /* 20964 80030164 21380000 */  addu       $a3, $zero, $zero
    /* 20968 80030168 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2096C 8003016C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20970 80030170 1800B0AF */  sw         $s0, 0x18($sp)
    /* 20974 80030174 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 20978 80030178 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 2097C 8003017C 2400A8AF */  sw         $t0, 0x24($sp)
    /* 20980 80030180 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 20984 80030184 2800A9AF */   sw        $t1, 0x28($sp)
    /* 20988 80030188 08100524 */  addiu      $a1, $zero, 0x1008
    /* 2098C 8003018C 0580083C */  lui        $t0, %hi(screenCarSelectPlayerTwo)
    /* 20990 80030190 21380000 */  addu       $a3, $zero, $zero
    /* 20994 80030194 3C01A48F */  lw         $a0, 0x13C($sp)
    /* 20998 80030198 4820068D */  lw         $a2, %lo(screenCarSelectPlayerTwo)($t0)
    /* 2099C 8003019C 8001A88F */  lw         $t0, 0x180($sp)
    /* 209A0 800301A0 01000924 */  addiu      $t1, $zero, 0x1
    /* 209A4 800301A4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 209A8 800301A8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 209AC 800301AC 1800B0AF */  sw         $s0, 0x18($sp)
    /* 209B0 800301B0 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 209B4 800301B4 2000BEAF */  sw         $fp, 0x20($sp)
    /* 209B8 800301B8 2800B3AF */  sw         $s3, 0x28($sp)
    /* 209BC 800301BC 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 209C0 800301C0 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 209C4 800301C4 2400A8AF */   sw        $t0, 0x24($sp)
    /* 209C8 800301C8 0580093C */  lui        $t1, %hi(screenPinkSlipsCarSelectTwoPlayer)
    /* 209CC 800301CC 4C01A48F */  lw         $a0, 0x14C($sp)
    /* 209D0 800301D0 4C20268D */  lw         $a2, %lo(screenPinkSlipsCarSelectTwoPlayer)($t1)
    /* 209D4 800301D4 7401A88F */  lw         $t0, 0x174($sp)
    /* 209D8 800301D8 7801A98F */  lw         $t1, 0x178($sp)
    /* 209DC 800301DC 08100524 */  addiu      $a1, $zero, 0x1008
    /* 209E0 800301E0 2000A8AF */  sw         $t0, 0x20($sp)
    /* 209E4 800301E4 7C01A88F */  lw         $t0, 0x17C($sp)
    /* 209E8 800301E8 21380000 */  addu       $a3, $zero, $zero
    /* 209EC 800301EC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 209F0 800301F0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 209F4 800301F4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 209F8 800301F8 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 209FC 800301FC 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 20A00 80030200 2400A9AF */  sw         $t1, 0x24($sp)
    /* 20A04 80030204 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 20A08 80030208 2800A8AF */   sw        $t0, 0x28($sp)
    /* 20A0C 8003020C 08100524 */  addiu      $a1, $zero, 0x1008
    /* 20A10 80030210 0580093C */  lui        $t1, %hi(screenPinkSlipsCarSelectPlayerTwo)
    /* 20A14 80030214 21380000 */  addu       $a3, $zero, $zero
    /* 20A18 80030218 5801A48F */  lw         $a0, 0x158($sp)
    /* 20A1C 8003021C 5020268D */  lw         $a2, %lo(screenPinkSlipsCarSelectPlayerTwo)($t1)
    /* 20A20 80030220 8001A98F */  lw         $t1, 0x180($sp)
    /* 20A24 80030224 01000824 */  addiu      $t0, $zero, 0x1
    /* 20A28 80030228 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20A2C 8003022C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20A30 80030230 1800B0AF */  sw         $s0, 0x18($sp)
    /* 20A34 80030234 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 20A38 80030238 2000BEAF */  sw         $fp, 0x20($sp)
    /* 20A3C 8003023C 2800B3AF */  sw         $s3, 0x28($sp)
    /* 20A40 80030240 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 20A44 80030244 936E000C */  jal        __12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
    /* 20A48 80030248 2400A9AF */   sw        $t1, 0x24($sp)
    /* 20A4C 8003024C 00400524 */  addiu      $a1, $zero, 0x4000
    /* 20A50 80030250 21300000 */  addu       $a2, $zero, $zero
    /* 20A54 80030254 2138C000 */  addu       $a3, $a2, $zero
    /* 20A58 80030258 8002A88F */  lw         $t0, 0x280($sp)
    /* 20A5C 8003025C FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 20A60 80030260 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20A64 80030264 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20A68 80030268 1800A9AF */  sw         $t1, 0x18($sp)
    /* 20A6C 8003026C 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 20A70 80030270 6C230425 */   addiu     $a0, $t0, 0x236C
    /* 20A74 80030274 C5010524 */  addiu      $a1, $zero, 0x1C5
    /* 20A78 80030278 21380000 */  addu       $a3, $zero, $zero
    /* 20A7C 8003027C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20A80 80030280 8002A98F */  lw         $t1, 0x280($sp)
    /* 20A84 80030284 B4000224 */  addiu      $v0, $zero, 0xB4
    /* 20A88 80030288 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20A8C 8003028C E8230825 */  addiu      $t0, $t0, 0x23E8
    /* 20A90 80030290 21200001 */  addu       $a0, $t0, $zero
    /* 20A94 80030294 E0272925 */  addiu      $t1, $t1, 0x27E0
    /* 20A98 80030298 21302001 */  addu       $a2, $t1, $zero
    /* 20A9C 8003029C 8801A8AF */  sw         $t0, 0x188($sp)
    /* 20AA0 800302A0 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20AA4 800302A4 8C01A9AF */  sw         $t1, 0x18C($sp)
    /* 20AA8 800302A8 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20AAC 800302AC 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20AB0 800302B0 C6010524 */  addiu      $a1, $zero, 0x1C6
    /* 20AB4 800302B4 21380000 */  addu       $a3, $zero, $zero
    /* 20AB8 800302B8 8002A98F */  lw         $t1, 0x280($sp)
    /* 20ABC 800302BC 8002A88F */  lw         $t0, 0x280($sp)
    /* 20AC0 800302C0 BE000224 */  addiu      $v0, $zero, 0xBE
    /* 20AC4 800302C4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20AC8 800302C8 14242925 */  addiu      $t1, $t1, 0x2414
    /* 20ACC 800302CC 21202001 */  addu       $a0, $t1, $zero
    /* 20AD0 800302D0 682A0825 */  addiu      $t0, $t0, 0x2A68
    /* 20AD4 800302D4 21300001 */  addu       $a2, $t0, $zero
    /* 20AD8 800302D8 9001A9AF */  sw         $t1, 0x190($sp)
    /* 20ADC 800302DC 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20AE0 800302E0 9401A8AF */  sw         $t0, 0x194($sp)
    /* 20AE4 800302E4 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20AE8 800302E8 1400A9AF */   sw        $t1, 0x14($sp)
    /* 20AEC 800302EC C8010524 */  addiu      $a1, $zero, 0x1C8
    /* 20AF0 800302F0 21380000 */  addu       $a3, $zero, $zero
    /* 20AF4 800302F4 8002A88F */  lw         $t0, 0x280($sp)
    /* 20AF8 800302F8 8002A98F */  lw         $t1, 0x280($sp)
    /* 20AFC 800302FC C8000224 */  addiu      $v0, $zero, 0xC8
    /* 20B00 80030300 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20B04 80030304 40240825 */  addiu      $t0, $t0, 0x2440
    /* 20B08 80030308 21200001 */  addu       $a0, $t0, $zero
    /* 20B0C 8003030C 6C2B2925 */  addiu      $t1, $t1, 0x2B6C
    /* 20B10 80030310 21302001 */  addu       $a2, $t1, $zero
    /* 20B14 80030314 9801A8AF */  sw         $t0, 0x198($sp)
    /* 20B18 80030318 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20B1C 8003031C 9C01A9AF */  sw         $t1, 0x19C($sp)
    /* 20B20 80030320 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20B24 80030324 1400A8AF */   sw        $t0, 0x14($sp)
    /* 20B28 80030328 C9010524 */  addiu      $a1, $zero, 0x1C9
    /* 20B2C 8003032C 21380000 */  addu       $a3, $zero, $zero
    /* 20B30 80030330 D2000224 */  addiu      $v0, $zero, 0xD2
    /* 20B34 80030334 8002A98F */  lw         $t1, 0x280($sp)
    /* 20B38 80030338 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20B3C 8003033C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20B40 80030340 1400A8AF */  sw         $t0, 0x14($sp)
    /* 20B44 80030344 6C243325 */  addiu      $s3, $t1, 0x246C
    /* 20B48 80030348 21206002 */  addu       $a0, $s3, $zero
    /* 20B4C 8003034C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20B50 80030350 AC302625 */   addiu     $a2, $t1, 0x30AC
    /* 20B54 80030354 CA010524 */  addiu      $a1, $zero, 0x1CA
    /* 20B58 80030358 21300000 */  addu       $a2, $zero, $zero
    /* 20B5C 8003035C 0380073C */  lui        $a3, %hi(MenuExtended_EnterUserName__FR12tMenuCommand)
    /* 20B60 80030360 14D2E724 */  addiu      $a3, $a3, %lo(MenuExtended_EnterUserName__FR12tMenuCommand)
    /* 20B64 80030364 DC000224 */  addiu      $v0, $zero, 0xDC
    /* 20B68 80030368 8002A98F */  lw         $t1, 0x280($sp)
    /* 20B6C 8003036C 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20B70 80030370 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20B74 80030374 1400A8AF */  sw         $t0, 0x14($sp)
    /* 20B78 80030378 98242925 */  addiu      $t1, $t1, 0x2498
    /* 20B7C 8003037C 21202001 */  addu       $a0, $t1, $zero
    /* 20B80 80030380 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20B84 80030384 A001A9AF */   sw        $t1, 0x1A0($sp)
    /* 20B88 80030388 CC010524 */  addiu      $a1, $zero, 0x1CC
    /* 20B8C 8003038C 21380000 */  addu       $a3, $zero, $zero
    /* 20B90 80030390 E6000224 */  addiu      $v0, $zero, 0xE6
    /* 20B94 80030394 8002A98F */  lw         $t1, 0x280($sp)
    /* 20B98 80030398 0A000824 */  addiu      $t0, $zero, 0xA
    /* 20B9C 8003039C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20BA0 800303A0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 20BA4 800303A4 C4243025 */  addiu      $s0, $t1, 0x24C4
    /* 20BA8 800303A8 21200002 */  addu       $a0, $s0, $zero
    /* 20BAC 800303AC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 20BB0 800303B0 F0392625 */   addiu     $a2, $t1, 0x39F0
    /* 20BB4 800303B4 0580023C */  lui        $v0, %hi(screenMain)
    /* 20BB8 800303B8 8002A98F */  lw         $t1, 0x280($sp)
    /* 20BBC 800303BC 581E468C */  lw         $a2, %lo(screenMain)($v0)
    /* 20BC0 800303C0 8801A88F */  lw         $t0, 0x188($sp)
    /* 20BC4 800303C4 F0242425 */  addiu      $a0, $t1, 0x24F0
    /* 20BC8 800303C8 9001A98F */  lw         $t1, 0x190($sp)
    /* 20BCC 800303CC 14100524 */  addiu      $a1, $zero, 0x1014
    /* 20BD0 800303D0 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 20BD4 800303D4 9801A88F */  lw         $t0, 0x198($sp)
    /* 20BD8 800303D8 21380000 */  addu       $a3, $zero, $zero
    /* 20BDC 800303DC 2000A9AF */  sw         $t1, 0x20($sp)
    /* 20BE0 800303E0 A001A98F */  lw         $t1, 0x1A0($sp)
    /* 20BE4 800303E4 5D000224 */  addiu      $v0, $zero, 0x5D
    /* 20BE8 800303E8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20BEC 800303EC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20BF0 800303F0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 20BF4 800303F4 2800B3AF */  sw         $s3, 0x28($sp)
    /* 20BF8 800303F8 3000B0AF */  sw         $s0, 0x30($sp)
    /* 20BFC 800303FC 3400A0AF */  sw         $zero, 0x34($sp)
    /* 20C00 80030400 2400A8AF */  sw         $t0, 0x24($sp)
    /* 20C04 80030404 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20C08 80030408 2C00A9AF */   sw        $t1, 0x2C($sp)
    /* 20C0C 8003040C 21280000 */  addu       $a1, $zero, $zero
    /* 20C10 80030410 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 20C14 80030414 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20C18 80030418 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20C1C 8003041C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20C20 80030420 1E022725 */  addiu      $a3, $t1, 0x21E
    /* 20C24 80030424 6C251025 */  addiu      $s0, $t0, 0x256C
    /* 20C28 80030428 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 20C2C 8003042C 21200002 */   addu      $a0, $s0, $zero
    /* 20C30 80030430 21280000 */  addu       $a1, $zero, $zero
    /* 20C34 80030434 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 20C38 80030438 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20C3C 8003043C 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20C40 80030440 8002A88F */  lw         $t0, 0x280($sp)
    /* 20C44 80030444 1F022725 */  addiu      $a3, $t1, 0x21F
    /* 20C48 80030448 7C250825 */  addiu      $t0, $t0, 0x257C
    /* 20C4C 8003044C 21200001 */  addu       $a0, $t0, $zero
    /* 20C50 80030450 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 20C54 80030454 A401A8AF */   sw        $t0, 0x1A4($sp)
    /* 20C58 80030458 21280000 */  addu       $a1, $zero, $zero
    /* 20C5C 8003045C 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 20C60 80030460 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20C64 80030464 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20C68 80030468 8002A88F */  lw         $t0, 0x280($sp)
    /* 20C6C 8003046C 21022725 */  addiu      $a3, $t1, 0x221
    /* 20C70 80030470 8C251325 */  addiu      $s3, $t0, 0x258C
    /* 20C74 80030474 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 20C78 80030478 21206002 */   addu      $a0, $s3, $zero
    /* 20C7C 8003047C 21280000 */  addu       $a1, $zero, $zero
    /* 20C80 80030480 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 20C84 80030484 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20C88 80030488 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20C8C 8003048C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20C90 80030490 20022725 */  addiu      $a3, $t1, 0x220
    /* 20C94 80030494 9C250825 */  addiu      $t0, $t0, 0x259C
    /* 20C98 80030498 21200001 */  addu       $a0, $t0, $zero
    /* 20C9C 8003049C 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 20CA0 800304A0 A801A8AF */   sw        $t0, 0x1A8($sp)
    /* 20CA4 800304A4 21280000 */  addu       $a1, $zero, $zero
    /* 20CA8 800304A8 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 20CAC 800304AC 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20CB0 800304B0 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20CB4 800304B4 8002A88F */  lw         $t0, 0x280($sp)
    /* 20CB8 800304B8 22022725 */  addiu      $a3, $t1, 0x222
    /* 20CBC 800304BC AC250825 */  addiu      $t0, $t0, 0x25AC
    /* 20CC0 800304C0 21200001 */  addu       $a0, $t0, $zero
    /* 20CC4 800304C4 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 20CC8 800304C8 AC01A8AF */   sw        $t0, 0x1AC($sp)
    /* 20CCC 800304CC 0580053C */  lui        $a1, %hi(SelectListAudioMode)
    /* 20CD0 800304D0 D819A524 */  addiu      $a1, $a1, %lo(SelectListAudioMode)
    /* 20CD4 800304D4 1180093C */  lui        $t1, %hi(D_80114723)
    /* 20CD8 800304D8 23472925 */  addiu      $t1, $t1, %lo(D_80114723)
    /* 20CDC 800304DC 8002A88F */  lw         $t0, 0x280($sp)
    /* 20CE0 800304E0 23022625 */  addiu      $a2, $t1, 0x223
    /* 20CE4 800304E4 BC250825 */  addiu      $t0, $t0, 0x25BC
    /* 20CE8 800304E8 21200001 */  addu       $a0, $t0, $zero
    /* 20CEC 800304EC 748F000C */  jal        __13tListIteratorPsPc
    /* 20CF0 800304F0 B001A8AF */   sw        $t0, 0x1B0($sp)
    /* 20CF4 800304F4 D5010524 */  addiu      $a1, $zero, 0x1D5
    /* 20CF8 800304F8 21300002 */  addu       $a2, $s0, $zero
    /* 20CFC 800304FC 8002A88F */  lw         $t0, 0x280($sp)
    /* 20D00 80030500 21380000 */  addu       $a3, $zero, $zero
    /* 20D04 80030504 CC250825 */  addiu      $t0, $t0, 0x25CC
    /* 20D08 80030508 21200001 */  addu       $a0, $t0, $zero
    /* 20D0C 8003050C 3F79000C */  jal        __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* 20D10 80030510 B401A8AF */   sw        $t0, 0x1B4($sp)
    /* 20D14 80030514 D6010524 */  addiu      $a1, $zero, 0x1D6
    /* 20D18 80030518 01000724 */  addiu      $a3, $zero, 0x1
    /* 20D1C 8003051C 8002A98F */  lw         $t1, 0x280($sp)
    /* 20D20 80030520 A401A68F */  lw         $a2, 0x1A4($sp)
    /* 20D24 80030524 04262925 */  addiu      $t1, $t1, 0x2604
    /* 20D28 80030528 21202001 */  addu       $a0, $t1, $zero
    /* 20D2C 8003052C 3F79000C */  jal        __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* 20D30 80030530 B801A9AF */   sw        $t1, 0x1B8($sp)
    /* 20D34 80030534 D7010524 */  addiu      $a1, $zero, 0x1D7
    /* 20D38 80030538 21306002 */  addu       $a2, $s3, $zero
    /* 20D3C 8003053C 8002A88F */  lw         $t0, 0x280($sp)
    /* 20D40 80030540 02000724 */  addiu      $a3, $zero, 0x2
    /* 20D44 80030544 3C261E25 */  addiu      $fp, $t0, 0x263C
    /* 20D48 80030548 3F79000C */  jal        __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* 20D4C 8003054C 2120C003 */   addu      $a0, $fp, $zero
    /* 20D50 80030550 D8010524 */  addiu      $a1, $zero, 0x1D8
    /* 20D54 80030554 03000724 */  addiu      $a3, $zero, 0x3
    /* 20D58 80030558 8002A98F */  lw         $t1, 0x280($sp)
    /* 20D5C 8003055C A801A68F */  lw         $a2, 0x1A8($sp)
    /* 20D60 80030560 74262925 */  addiu      $t1, $t1, 0x2674
    /* 20D64 80030564 21202001 */  addu       $a0, $t1, $zero
    /* 20D68 80030568 3F79000C */  jal        __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* 20D6C 8003056C BC01A9AF */   sw        $t1, 0x1BC($sp)
    /* 20D70 80030570 D9010524 */  addiu      $a1, $zero, 0x1D9
    /* 20D74 80030574 04000724 */  addiu      $a3, $zero, 0x4
    /* 20D78 80030578 8002A88F */  lw         $t0, 0x280($sp)
    /* 20D7C 8003057C AC01A68F */  lw         $a2, 0x1AC($sp)
    /* 20D80 80030580 AC261325 */  addiu      $s3, $t0, 0x26AC
    /* 20D84 80030584 3F79000C */  jal        __29tMenuItemLeftRightAudioSliderUiP13tListIteratori
    /* 20D88 80030588 21206002 */   addu      $a0, $s3, $zero
    /* 20D8C 8003058C DA010524 */  addiu      $a1, $zero, 0x1DA
    /* 20D90 80030590 8002A98F */  lw         $t1, 0x280($sp)
    /* 20D94 80030594 B001A68F */  lw         $a2, 0x1B0($sp)
    /* 20D98 80030598 E4262925 */  addiu      $t1, $t1, 0x26E4
    /* 20D9C 8003059C 21202001 */  addu       $a0, $t1, $zero
    /* 20DA0 800305A0 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 20DA4 800305A4 C001A9AF */   sw        $t1, 0x1C0($sp)
    /* 20DA8 800305A8 DB010524 */  addiu      $a1, $zero, 0x1DB
    /* 20DAC 800305AC 5E010624 */  addiu      $a2, $zero, 0x15E
    /* 20DB0 800305B0 2B000724 */  addiu      $a3, $zero, 0x2B
    /* 20DB4 800305B4 9AFF0224 */  addiu      $v0, $zero, -0x66
    /* 20DB8 800305B8 8002A88F */  lw         $t0, 0x280($sp)
    /* 20DBC 800305BC C001A98F */  lw         $t1, 0x1C0($sp)
    /* 20DC0 800305C0 10271025 */  addiu      $s0, $t0, 0x2710
    /* 20DC4 800305C4 21200002 */  addu       $a0, $s0, $zero
    /* 20DC8 800305C8 0180083C */  lui        $t0, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 20DCC 800305CC 900D0825 */  addiu      $t0, $t0, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 20DD0 800305D0 180028AD */  sw         $t0, 0x18($t1)
    /* 20DD4 800305D4 0D000924 */  addiu      $t1, $zero, 0xD
    /* 20DD8 800305D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 20DDC 800305DC 1400A9AF */  sw         $t1, 0x14($sp)
    /* 20DE0 800305E0 5874000C */  jal        __20tMenuItemSlidingMenuUissssb
    /* 20DE4 800305E4 1800A0AF */   sw        $zero, 0x18($sp)
    /* 20DE8 800305E8 00100524 */  addiu      $a1, $zero, 0x1000
    /* 20DEC 800305EC 21300000 */  addu       $a2, $zero, $zero
    /* 20DF0 800305F0 2138C000 */  addu       $a3, $a2, $zero
    /* 20DF4 800305F4 0180023C */  lui        $v0, %hi(_vt_25tMenuItemSlidingActivated)
    /* 20DF8 800305F8 8002A88F */  lw         $t0, 0x280($sp)
    /* 20DFC 800305FC E80D4224 */  addiu      $v0, $v0, %lo(_vt_25tMenuItemSlidingActivated)
    /* 20E00 80030600 180002AE */  sw         $v0, 0x18($s0)
    /* 20E04 80030604 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20E08 80030608 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20E0C 8003060C 1800A0AF */  sw         $zero, 0x18($sp)
    /* 20E10 80030610 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 20E14 80030614 487A000C */  jal        __18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 20E18 80030618 58270425 */   addiu     $a0, $t0, 0x2758
    /* 20E1C 8003061C 10100524 */  addiu      $a1, $zero, 0x1010
    /* 20E20 80030620 0580023C */  lui        $v0, %hi(screenAudio)
    /* 20E24 80030624 8C01A48F */  lw         $a0, 0x18C($sp)
    /* 20E28 80030628 E828468C */  lw         $a2, %lo(screenAudio)($v0)
    /* 20E2C 8003062C B401A88F */  lw         $t0, 0x1B4($sp)
    /* 20E30 80030630 0A000924 */  addiu      $t1, $zero, 0xA
    /* 20E34 80030634 2000A9AF */  sw         $t1, 0x20($sp)
    /* 20E38 80030638 B801A98F */  lw         $t1, 0x1B8($sp)
    /* 20E3C 8003063C 21380000 */  addu       $a3, $zero, $zero
    /* 20E40 80030640 2400A8AF */  sw         $t0, 0x24($sp)
    /* 20E44 80030644 BC01A88F */  lw         $t0, 0x1BC($sp)
    /* 20E48 80030648 63020224 */  addiu      $v0, $zero, 0x263
    /* 20E4C 8003064C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 20E50 80030650 2800A9AF */  sw         $t1, 0x28($sp)
    /* 20E54 80030654 C001A98F */  lw         $t1, 0x1C0($sp)
    /* 20E58 80030658 26000224 */  addiu      $v0, $zero, 0x26
    /* 20E5C 8003065C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 20E60 80030660 1400A0AF */  sw         $zero, 0x14($sp)
    /* 20E64 80030664 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 20E68 80030668 2C00BEAF */  sw         $fp, 0x2C($sp)
    /* 20E6C 8003066C 3400B3AF */  sw         $s3, 0x34($sp)
    /* 20E70 80030670 3C00B0AF */  sw         $s0, 0x3C($sp)
    /* 20E74 80030674 4000A0AF */  sw         $zero, 0x40($sp)
    /* 20E78 80030678 3000A8AF */  sw         $t0, 0x30($sp)
    /* 20E7C 8003067C 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 20E80 80030680 3800A9AF */   sw        $t1, 0x38($sp)
    /* 20E84 80030684 0580053C */  lui        $a1, %hi(SelectListDisplaySpeed)
    /* 20E88 80030688 9C19A524 */  addiu      $a1, $a1, %lo(SelectListDisplaySpeed)
    /* 20E8C 8003068C 0580093C */  lui        $t1, %hi(FEApp)
    /* 20E90 80030690 1180063C */  lui        $a2, %hi(D_80114920)
    /* 20E94 80030694 2049C624 */  addiu      $a2, $a2, %lo(D_80114920)
    /* 20E98 80030698 8002A88F */  lw         $t0, 0x280($sp)
    /* 20E9C 8003069C C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20EA0 800306A0 60280825 */  addiu      $t0, $t0, 0x2860
    /* 20EA4 800306A4 21200001 */  addu       $a0, $t0, $zero
    /* 20EA8 800306A8 2D02E724 */  addiu      $a3, $a3, 0x22D
    /* 20EAC 800306AC D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20EB0 800306B0 C401A8AF */   sw        $t0, 0x1C4($sp)
    /* 20EB4 800306B4 0580053C */  lui        $a1, %hi(SelectListDisplayMap)
    /* 20EB8 800306B8 A819A524 */  addiu      $a1, $a1, %lo(SelectListDisplayMap)
    /* 20EBC 800306BC 0580093C */  lui        $t1, %hi(FEApp)
    /* 20EC0 800306C0 8002A88F */  lw         $t0, 0x280($sp)
    /* 20EC4 800306C4 C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20EC8 800306C8 74280825 */  addiu      $t0, $t0, 0x2874
    /* 20ECC 800306CC 21200001 */  addu       $a0, $t0, $zero
    /* 20ED0 800306D0 C801A8AF */  sw         $t0, 0x1C8($sp)
    /* 20ED4 800306D4 1180083C */  lui        $t0, %hi(D_8011465C + 0x2)
    /* 20ED8 800306D8 5E460825 */  addiu      $t0, $t0, %lo(D_8011465C + 0x2)
    /* 20EDC 800306DC C6020625 */  addiu      $a2, $t0, 0x2C6
    /* 20EE0 800306E0 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20EE4 800306E4 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 20EE8 800306E8 0580053C */  lui        $a1, %hi(SelectListDisplayOpponentID)
    /* 20EEC 800306EC B019A524 */  addiu      $a1, $a1, %lo(SelectListDisplayOpponentID)
    /* 20EF0 800306F0 0580083C */  lui        $t0, %hi(FEApp)
    /* 20EF4 800306F4 8002A98F */  lw         $t1, 0x280($sp)
    /* 20EF8 800306F8 C014078D */  lw         $a3, %lo(FEApp)($t0)
    /* 20EFC 800306FC 88283325 */  addiu      $s3, $t1, 0x2888
    /* 20F00 80030700 21206002 */  addu       $a0, $s3, $zero
    /* 20F04 80030704 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 20F08 80030708 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 20F0C 8003070C C8022625 */  addiu      $a2, $t1, 0x2C8
    /* 20F10 80030710 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20F14 80030714 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 20F18 80030718 0580053C */  lui        $a1, %hi(SelectListOffOn)
    /* 20F1C 8003071C 7419A524 */  addiu      $a1, $a1, %lo(SelectListOffOn)
    /* 20F20 80030720 0580093C */  lui        $t1, %hi(FEApp)
    /* 20F24 80030724 8002A88F */  lw         $t0, 0x280($sp)
    /* 20F28 80030728 C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20F2C 8003072C 9C280825 */  addiu      $t0, $t0, 0x289C
    /* 20F30 80030730 21200001 */  addu       $a0, $t0, $zero
    /* 20F34 80030734 CC01A8AF */  sw         $t0, 0x1CC($sp)
    /* 20F38 80030738 1180083C */  lui        $t0, %hi(D_8011465C + 0x2)
    /* 20F3C 8003073C 5E460825 */  addiu      $t0, $t0, %lo(D_8011465C + 0x2)
    /* 20F40 80030740 CA020625 */  addiu      $a2, $t0, 0x2CA
    /* 20F44 80030744 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20F48 80030748 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 20F4C 8003074C 0580053C */  lui        $a1, %hi(SelectListOffOn)
    /* 20F50 80030750 7419A524 */  addiu      $a1, $a1, %lo(SelectListOffOn)
    /* 20F54 80030754 0580083C */  lui        $t0, %hi(FEApp)
    /* 20F58 80030758 8002A98F */  lw         $t1, 0x280($sp)
    /* 20F5C 8003075C C014078D */  lw         $a3, %lo(FEApp)($t0)
    /* 20F60 80030760 B0283025 */  addiu      $s0, $t1, 0x28B0
    /* 20F64 80030764 21200002 */  addu       $a0, $s0, $zero
    /* 20F68 80030768 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 20F6C 8003076C 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 20F70 80030770 CC022625 */  addiu      $a2, $t1, 0x2CC
    /* 20F74 80030774 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20F78 80030778 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 20F7C 8003077C 0580053C */  lui        $a1, %hi(SelectListOffOn)
    /* 20F80 80030780 7419A524 */  addiu      $a1, $a1, %lo(SelectListOffOn)
    /* 20F84 80030784 0580093C */  lui        $t1, %hi(FEApp)
    /* 20F88 80030788 8002A88F */  lw         $t0, 0x280($sp)
    /* 20F8C 8003078C C014278D */  lw         $a3, %lo(FEApp)($t1)
    /* 20F90 80030790 C4280825 */  addiu      $t0, $t0, 0x28C4
    /* 20F94 80030794 21200001 */  addu       $a0, $t0, $zero
    /* 20F98 80030798 D001A8AF */  sw         $t0, 0x1D0($sp)
    /* 20F9C 8003079C 1180083C */  lui        $t0, %hi(D_8011465C + 0x2)
    /* 20FA0 800307A0 5E460825 */  addiu      $t0, $t0, %lo(D_8011465C + 0x2)
    /* 20FA4 800307A4 CE020625 */  addiu      $a2, $t0, 0x2CE
    /* 20FA8 800307A8 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 20FAC 800307AC 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 20FB0 800307B0 0580053C */  lui        $a1, %hi(SelectListSplitTime)
    /* 20FB4 800307B4 B819A524 */  addiu      $a1, $a1, %lo(SelectListSplitTime)
    /* 20FB8 800307B8 1180083C */  lui        $t0, %hi(D_8011465C + 0x2)
    /* 20FBC 800307BC 5E460825 */  addiu      $t0, $t0, %lo(D_8011465C + 0x2)
    /* 20FC0 800307C0 8002A98F */  lw         $t1, 0x280($sp)
    /* 20FC4 800307C4 38030625 */  addiu      $a2, $t0, 0x338
    /* 20FC8 800307C8 D8282925 */  addiu      $t1, $t1, 0x28D8
    /* 20FCC 800307CC 21202001 */  addu       $a0, $t1, $zero
    /* 20FD0 800307D0 748F000C */  jal        __13tListIteratorPsPc
    /* 20FD4 800307D4 D401A9AF */   sw        $t1, 0x1D4($sp)
    /* 20FD8 800307D8 0580053C */  lui        $a1, %hi(SelectListSplitDisplay)
    /* 20FDC 800307DC C019A524 */  addiu      $a1, $a1, %lo(SelectListSplitDisplay)
    /* 20FE0 800307E0 0580083C */  lui        $t0, %hi(FEApp)
    /* 20FE4 800307E4 8002A98F */  lw         $t1, 0x280($sp)
    /* 20FE8 800307E8 C014078D */  lw         $a3, %lo(FEApp)($t0)
    /* 20FEC 800307EC E8282925 */  addiu      $t1, $t1, 0x28E8
    /* 20FF0 800307F0 21202001 */  addu       $a0, $t1, $zero
    /* 20FF4 800307F4 D801A9AF */  sw         $t1, 0x1D8($sp)
    /* 20FF8 800307F8 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 20FFC 800307FC 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 21000 80030800 39032625 */  addiu      $a2, $t1, 0x339
    /* 21004 80030804 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 21008 80030808 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 2100C 8003080C DF010524 */  addiu      $a1, $zero, 0x1DF
    /* 21010 80030810 8002A88F */  lw         $t0, 0x280($sp)
    /* 21014 80030814 C401A68F */  lw         $a2, 0x1C4($sp)
    /* 21018 80030818 FC281525 */  addiu      $s5, $t0, 0x28FC
    /* 2101C 8003081C D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 21020 80030820 2120A002 */   addu      $a0, $s5, $zero
    /* 21024 80030824 E1010524 */  addiu      $a1, $zero, 0x1E1
    /* 21028 80030828 8002A98F */  lw         $t1, 0x280($sp)
    /* 2102C 8003082C C801A68F */  lw         $a2, 0x1C8($sp)
    /* 21030 80030830 0180083C */  lui        $t0, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21034 80030834 900D0825 */  addiu      $t0, $t0, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21038 80030838 1800A8AE */  sw         $t0, 0x18($s5)
    /* 2103C 8003083C 28293E25 */  addiu      $fp, $t1, 0x2928
    /* 21040 80030840 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 21044 80030844 2120C003 */   addu      $a0, $fp, $zero
    /* 21048 80030848 E2010524 */  addiu      $a1, $zero, 0x1E2
    /* 2104C 8003084C 21306002 */  addu       $a2, $s3, $zero
    /* 21050 80030850 8002A98F */  lw         $t1, 0x280($sp)
    /* 21054 80030854 0180083C */  lui        $t0, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21058 80030858 900D0825 */  addiu      $t0, $t0, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 2105C 8003085C 54292925 */  addiu      $t1, $t1, 0x2954
    /* 21060 80030860 21202001 */  addu       $a0, $t1, $zero
    /* 21064 80030864 DC01A9AF */  sw         $t1, 0x1DC($sp)
    /* 21068 80030868 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 2106C 8003086C 1800C8AF */   sw        $t0, 0x18($fp)
    /* 21070 80030870 E3010524 */  addiu      $a1, $zero, 0x1E3
    /* 21074 80030874 8002A98F */  lw         $t1, 0x280($sp)
    /* 21078 80030878 CC01A68F */  lw         $a2, 0x1CC($sp)
    /* 2107C 8003087C DC01A88F */  lw         $t0, 0x1DC($sp)
    /* 21080 80030880 80292925 */  addiu      $t1, $t1, 0x2980
    /* 21084 80030884 21202001 */  addu       $a0, $t1, $zero
    /* 21088 80030888 E001A9AF */  sw         $t1, 0x1E0($sp)
    /* 2108C 8003088C 0180093C */  lui        $t1, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21090 80030890 900D2925 */  addiu      $t1, $t1, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21094 80030894 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 21098 80030898 180009AD */   sw        $t1, 0x18($t0)
    /* 2109C 8003089C E6010524 */  addiu      $a1, $zero, 0x1E6
    /* 210A0 800308A0 21300002 */  addu       $a2, $s0, $zero
    /* 210A4 800308A4 0180103C */  lui        $s0, %hi(_vt_29tMenuItemOnOffLeftRightChoice)
    /* 210A8 800308A8 380D1026 */  addiu      $s0, $s0, %lo(_vt_29tMenuItemOnOffLeftRightChoice)
    /* 210AC 800308AC 8002A88F */  lw         $t0, 0x280($sp)
    /* 210B0 800308B0 E001A98F */  lw         $t1, 0x1E0($sp)
    /* 210B4 800308B4 B0290825 */  addiu      $t0, $t0, 0x29B0
    /* 210B8 800308B8 21200001 */  addu       $a0, $t0, $zero
    /* 210BC 800308BC E401A8AF */  sw         $t0, 0x1E4($sp)
    /* 210C0 800308C0 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 210C4 800308C4 180030AD */   sw        $s0, 0x18($t1)
    /* 210C8 800308C8 E7010524 */  addiu      $a1, $zero, 0x1E7
    /* 210CC 800308CC 8002A88F */  lw         $t0, 0x280($sp)
    /* 210D0 800308D0 D001A68F */  lw         $a2, 0x1D0($sp)
    /* 210D4 800308D4 E401A98F */  lw         $t1, 0x1E4($sp)
    /* 210D8 800308D8 E0291325 */  addiu      $s3, $t0, 0x29E0
    /* 210DC 800308DC 21206002 */  addu       $a0, $s3, $zero
    /* 210E0 800308E0 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 210E4 800308E4 180030AD */   sw        $s0, 0x18($t1)
    /* 210E8 800308E8 E4010524 */  addiu      $a1, $zero, 0x1E4
    /* 210EC 800308EC 8002A88F */  lw         $t0, 0x280($sp)
    /* 210F0 800308F0 D401A68F */  lw         $a2, 0x1D4($sp)
    /* 210F4 800308F4 102A0825 */  addiu      $t0, $t0, 0x2A10
    /* 210F8 800308F8 21200001 */  addu       $a0, $t0, $zero
    /* 210FC 800308FC E801A8AF */  sw         $t0, 0x1E8($sp)
    /* 21100 80030900 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 21104 80030904 180070AE */   sw        $s0, 0x18($s3)
    /* 21108 80030908 E5010524 */  addiu      $a1, $zero, 0x1E5
    /* 2110C 8003090C 8002A98F */  lw         $t1, 0x280($sp)
    /* 21110 80030910 D801A68F */  lw         $a2, 0x1D8($sp)
    /* 21114 80030914 E801A88F */  lw         $t0, 0x1E8($sp)
    /* 21118 80030918 3C2A3025 */  addiu      $s0, $t1, 0x2A3C
    /* 2111C 8003091C 21200002 */  addu       $a0, $s0, $zero
    /* 21120 80030920 0180093C */  lui        $t1, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21124 80030924 900D2925 */  addiu      $t1, $t1, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21128 80030928 D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 2112C 8003092C 180009AD */   sw        $t1, 0x18($t0)
    /* 21130 80030930 0580023C */  lui        $v0, %hi(screenDisplay)
    /* 21134 80030934 0180083C */  lui        $t0, %hi(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 21138 80030938 900D0825 */  addiu      $t0, $t0, %lo(_vt_31tMenuItemDisplayLeftRightChoice)
    /* 2113C 8003093C 9401A48F */  lw         $a0, 0x194($sp)
    /* 21140 80030940 D828468C */  lw         $a2, %lo(screenDisplay)($v0)
    /* 21144 80030944 01000924 */  addiu      $t1, $zero, 0x1
    /* 21148 80030948 180008AE */  sw         $t0, 0x18($s0)
    /* 2114C 8003094C 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21150 80030950 DC01A98F */  lw         $t1, 0x1DC($sp)
    /* 21154 80030954 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21158 80030958 2000A8AF */  sw         $t0, 0x20($sp)
    /* 2115C 8003095C E001A88F */  lw         $t0, 0x1E0($sp)
    /* 21160 80030960 20100524 */  addiu      $a1, $zero, 0x1020
    /* 21164 80030964 2C00A9AF */  sw         $t1, 0x2C($sp)
    /* 21168 80030968 E801A98F */  lw         $t1, 0x1E8($sp)
    /* 2116C 8003096C 21380000 */  addu       $a3, $zero, $zero
    /* 21170 80030970 3000A8AF */  sw         $t0, 0x30($sp)
    /* 21174 80030974 E401A88F */  lw         $t0, 0x1E4($sp)
    /* 21178 80030978 DD010224 */  addiu      $v0, $zero, 0x1DD
    /* 2117C 8003097C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21180 80030980 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21184 80030984 1800A2AF */  sw         $v0, 0x18($sp)
    /* 21188 80030988 2400B5AF */  sw         $s5, 0x24($sp)
    /* 2118C 8003098C 2800BEAF */  sw         $fp, 0x28($sp)
    /* 21190 80030990 3800B0AF */  sw         $s0, 0x38($sp)
    /* 21194 80030994 4000B3AF */  sw         $s3, 0x40($sp)
    /* 21198 80030998 4400A0AF */  sw         $zero, 0x44($sp)
    /* 2119C 8003099C 3400A9AF */  sw         $t1, 0x34($sp)
    /* 211A0 800309A0 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 211A4 800309A4 3C00A8AF */   sw        $t0, 0x3C($sp)
    /* 211A8 800309A8 0580053C */  lui        $a1, %hi(SelectListControllerConfig)
    /* 211AC 800309AC D019A524 */  addiu      $a1, $a1, %lo(SelectListControllerConfig)
    /* 211B0 800309B0 0580083C */  lui        $t0, %hi(FEApp)
    /* 211B4 800309B4 8002A98F */  lw         $t1, 0x280($sp)
    /* 211B8 800309B8 C014078D */  lw         $a3, %lo(FEApp)($t0)
    /* 211BC 800309BC E82A2925 */  addiu      $t1, $t1, 0x2AE8
    /* 211C0 800309C0 21202001 */  addu       $a0, $t1, $zero
    /* 211C4 800309C4 EC01A9AF */  sw         $t1, 0x1EC($sp)
    /* 211C8 800309C8 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 211CC 800309CC 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 211D0 800309D0 04032625 */  addiu      $a2, $t1, 0x304
    /* 211D4 800309D4 D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 211D8 800309D8 2D02E724 */   addiu     $a3, $a3, 0x22D
    /* 211DC 800309DC 09020524 */  addiu      $a1, $zero, 0x209
    /* 211E0 800309E0 8002A88F */  lw         $t0, 0x280($sp)
    /* 211E4 800309E4 EC01A68F */  lw         $a2, 0x1EC($sp)
    /* 211E8 800309E8 FC2A1025 */  addiu      $s0, $t0, 0x2AFC
    /* 211EC 800309EC D670000C */  jal        __22tMenuItemLeftRightFadeUiP13tListIterator
    /* 211F0 800309F0 21200002 */   addu      $a0, $s0, $zero
    /* 211F4 800309F4 0A020524 */  addiu      $a1, $zero, 0x20A
    /* 211F8 800309F8 AC000624 */  addiu      $a2, $zero, 0xAC
    /* 211FC 800309FC 48000724 */  addiu      $a3, $zero, 0x48
    /* 21200 80030A00 0180023C */  lui        $v0, %hi(_vt_34tMenuItemControllerLeftRightChoice)
    /* 21204 80030A04 8002A98F */  lw         $t1, 0x280($sp)
    /* 21208 80030A08 200C4224 */  addiu      $v0, $v0, %lo(_vt_34tMenuItemControllerLeftRightChoice)
    /* 2120C 80030A0C 282B2925 */  addiu      $t1, $t1, 0x2B28
    /* 21210 80030A10 21202001 */  addu       $a0, $t1, $zero
    /* 21214 80030A14 F001A9AF */  sw         $t1, 0x1F0($sp)
    /* 21218 80030A18 180002AE */  sw         $v0, 0x18($s0)
    /* 2121C 80030A1C 0D000824 */  addiu      $t0, $zero, 0xD
    /* 21220 80030A20 01000924 */  addiu      $t1, $zero, 0x1
    /* 21224 80030A24 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21228 80030A28 1400A8AF */  sw         $t0, 0x14($sp)
    /* 2122C 80030A2C 5874000C */  jal        __20tMenuItemSlidingMenuUissssb
    /* 21230 80030A30 1800A9AF */   sw        $t1, 0x18($sp)
    /* 21234 80030A34 20100524 */  addiu      $a1, $zero, 0x1020
    /* 21238 80030A38 0580023C */  lui        $v0, %hi(screenControllerConfig)
    /* 2123C 80030A3C 21380000 */  addu       $a3, $zero, $zero
    /* 21240 80030A40 D028468C */  lw         $a2, %lo(screenControllerConfig)($v0)
    /* 21244 80030A44 08020224 */  addiu      $v0, $zero, 0x208
    /* 21248 80030A48 9C01A48F */  lw         $a0, 0x19C($sp)
    /* 2124C 80030A4C F001A98F */  lw         $t1, 0x1F0($sp)
    /* 21250 80030A50 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21254 80030A54 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21258 80030A58 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2125C 80030A5C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 21260 80030A60 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 21264 80030A64 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21268 80030A68 2400B0AF */  sw         $s0, 0x24($sp)
    /* 2126C 80030A6C 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 21270 80030A70 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21274 80030A74 2800A9AF */   sw        $t1, 0x28($sp)
    /* 21278 80030A78 21280000 */  addu       $a1, $zero, $zero
    /* 2127C 80030A7C 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 21280 80030A80 0580093C */  lui        $t1, %hi(FEApp)
    /* 21284 80030A84 8002A88F */  lw         $t0, 0x280($sp)
    /* 21288 80030A88 C014228D */  lw         $v0, %lo(FEApp)($t1)
    /* 2128C 80030A8C EC2B1025 */  addiu      $s0, $t0, 0x2BEC
    /* 21290 80030A90 21200002 */  addu       $a0, $s0, $zero
    /* 21294 80030A94 1180083C */  lui        $t0, %hi(D_8011465C + 0x2)
    /* 21298 80030A98 5E460825 */  addiu      $t0, $t0, %lo(D_8011465C + 0x2)
    /* 2129C 80030A9C FB020725 */  addiu      $a3, $t0, 0x2FB
    /* 212A0 80030AA0 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 212A4 80030AA4 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 212A8 80030AA8 1000A2AF */   sw        $v0, 0x10($sp)
    /* 212AC 80030AAC 0E020524 */  addiu      $a1, $zero, 0x20E
    /* 212B0 80030AB0 8002A98F */  lw         $t1, 0x280($sp)
    /* 212B4 80030AB4 21300002 */  addu       $a2, $s0, $zero
    /* 212B8 80030AB8 002C2925 */  addiu      $t1, $t1, 0x2C00
    /* 212BC 80030ABC 21202001 */  addu       $a0, $t1, $zero
    /* 212C0 80030AC0 A27C000C */  jal        __25tInsideBoxLeftRightSliderUiP13tListIterator
    /* 212C4 80030AC4 F401A9AF */   sw        $t1, 0x1F4($sp)
    /* 212C8 80030AC8 21280000 */  addu       $a1, $zero, $zero
    /* 212CC 80030ACC 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 212D0 80030AD0 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 212D4 80030AD4 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 212D8 80030AD8 FD022725 */  addiu      $a3, $t1, 0x2FD
    /* 212DC 80030ADC 0180103C */  lui        $s0, %hi(_vt_35tInsideBoxControllerLeftRightSlider)
    /* 212E0 80030AE0 8002A88F */  lw         $t0, 0x280($sp)
    /* 212E4 80030AE4 F401A98F */  lw         $t1, 0x1F4($sp)
    /* 212E8 80030AE8 282C0825 */  addiu      $t0, $t0, 0x2C28
    /* 212EC 80030AEC 21200001 */  addu       $a0, $t0, $zero
    /* 212F0 80030AF0 F801A8AF */  sw         $t0, 0x1F8($sp)
    /* 212F4 80030AF4 0580083C */  lui        $t0, %hi(FEApp)
    /* 212F8 80030AF8 C014028D */  lw         $v0, %lo(FEApp)($t0)
    /* 212FC 80030AFC 100A1026 */  addiu      $s0, $s0, %lo(_vt_35tInsideBoxControllerLeftRightSlider)
    /* 21300 80030B00 180030AD */  sw         $s0, 0x18($t1)
    /* 21304 80030B04 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 21308 80030B08 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 2130C 80030B0C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 21310 80030B10 0F020524 */  addiu      $a1, $zero, 0x20F
    /* 21314 80030B14 8002A88F */  lw         $t0, 0x280($sp)
    /* 21318 80030B18 F801A68F */  lw         $a2, 0x1F8($sp)
    /* 2131C 80030B1C 3C2C0825 */  addiu      $t0, $t0, 0x2C3C
    /* 21320 80030B20 21200001 */  addu       $a0, $t0, $zero
    /* 21324 80030B24 A27C000C */  jal        __25tInsideBoxLeftRightSliderUiP13tListIterator
    /* 21328 80030B28 FC01A8AF */   sw        $t0, 0x1FC($sp)
    /* 2132C 80030B2C 21280000 */  addu       $a1, $zero, $zero
    /* 21330 80030B30 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 21334 80030B34 0580083C */  lui        $t0, %hi(FEApp)
    /* 21338 80030B38 8002A98F */  lw         $t1, 0x280($sp)
    /* 2133C 80030B3C C014028D */  lw         $v0, %lo(FEApp)($t0)
    /* 21340 80030B40 FC01A88F */  lw         $t0, 0x1FC($sp)
    /* 21344 80030B44 642C2925 */  addiu      $t1, $t1, 0x2C64
    /* 21348 80030B48 21202001 */  addu       $a0, $t1, $zero
    /* 2134C 80030B4C 0002A9AF */  sw         $t1, 0x200($sp)
    /* 21350 80030B50 1180093C */  lui        $t1, %hi(D_8011465C + 0x2)
    /* 21354 80030B54 5E462925 */  addiu      $t1, $t1, %lo(D_8011465C + 0x2)
    /* 21358 80030B58 F3022725 */  addiu      $a3, $t1, 0x2F3
    /* 2135C 80030B5C 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 21360 80030B60 180010AD */  sw         $s0, 0x18($t0)
    /* 21364 80030B64 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 21368 80030B68 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2136C 80030B6C 11020524 */  addiu      $a1, $zero, 0x211
    /* 21370 80030B70 21380000 */  addu       $a3, $zero, $zero
    /* 21374 80030B74 8002A98F */  lw         $t1, 0x280($sp)
    /* 21378 80030B78 0002A68F */  lw         $a2, 0x200($sp)
    /* 2137C 80030B7C 782C2925 */  addiu      $t1, $t1, 0x2C78
    /* 21380 80030B80 21202001 */  addu       $a0, $t1, $zero
    /* 21384 80030B84 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 21388 80030B88 0402A9AF */   sw        $t1, 0x204($sp)
    /* 2138C 80030B8C 21280000 */  addu       $a1, $zero, $zero
    /* 21390 80030B90 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 21394 80030B94 0580103C */  lui        $s0, %hi(FEApp)
    /* 21398 80030B98 1180093C */  lui        $t1, %hi(D_80114920)
    /* 2139C 80030B9C 20492925 */  addiu      $t1, $t1, %lo(D_80114920)
    /* 213A0 80030BA0 33002725 */  addiu      $a3, $t1, 0x33
    /* 213A4 80030BA4 8002A88F */  lw         $t0, 0x280($sp)
    /* 213A8 80030BA8 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 213AC 80030BAC A82C0825 */  addiu      $t0, $t0, 0x2CA8
    /* 213B0 80030BB0 21200001 */  addu       $a0, $t0, $zero
    /* 213B4 80030BB4 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 213B8 80030BB8 0802A8AF */  sw         $t0, 0x208($sp)
    /* 213BC 80030BBC 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 213C0 80030BC0 1000A2AF */   sw        $v0, 0x10($sp)
    /* 213C4 80030BC4 13020524 */  addiu      $a1, $zero, 0x213
    /* 213C8 80030BC8 01000724 */  addiu      $a3, $zero, 0x1
    /* 213CC 80030BCC 8002A88F */  lw         $t0, 0x280($sp)
    /* 213D0 80030BD0 0802A68F */  lw         $a2, 0x208($sp)
    /* 213D4 80030BD4 BC2C0825 */  addiu      $t0, $t0, 0x2CBC
    /* 213D8 80030BD8 21200001 */  addu       $a0, $t0, $zero
    /* 213DC 80030BDC 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 213E0 80030BE0 0C02A8AF */   sw        $t0, 0x20C($sp)
    /* 213E4 80030BE4 21280000 */  addu       $a1, $zero, $zero
    /* 213E8 80030BE8 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 213EC 80030BEC 1180083C */  lui        $t0, %hi(D_80114920)
    /* 213F0 80030BF0 20490825 */  addiu      $t0, $t0, %lo(D_80114920)
    /* 213F4 80030BF4 35000725 */  addiu      $a3, $t0, 0x35
    /* 213F8 80030BF8 8002A98F */  lw         $t1, 0x280($sp)
    /* 213FC 80030BFC C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 21400 80030C00 EC2C2925 */  addiu      $t1, $t1, 0x2CEC
    /* 21404 80030C04 21202001 */  addu       $a0, $t1, $zero
    /* 21408 80030C08 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 2140C 80030C0C 1002A9AF */  sw         $t1, 0x210($sp)
    /* 21410 80030C10 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 21414 80030C14 1000A2AF */   sw        $v0, 0x10($sp)
    /* 21418 80030C18 10020524 */  addiu      $a1, $zero, 0x210
    /* 2141C 80030C1C 02000724 */  addiu      $a3, $zero, 0x2
    /* 21420 80030C20 8002A98F */  lw         $t1, 0x280($sp)
    /* 21424 80030C24 1002A68F */  lw         $a2, 0x210($sp)
    /* 21428 80030C28 002D2925 */  addiu      $t1, $t1, 0x2D00
    /* 2142C 80030C2C 21202001 */  addu       $a0, $t1, $zero
    /* 21430 80030C30 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 21434 80030C34 1402A9AF */   sw        $t1, 0x214($sp)
    /* 21438 80030C38 21280000 */  addu       $a1, $zero, $zero
    /* 2143C 80030C3C 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 21440 80030C40 1180093C */  lui        $t1, %hi(D_80114920)
    /* 21444 80030C44 20492925 */  addiu      $t1, $t1, %lo(D_80114920)
    /* 21448 80030C48 37002725 */  addiu      $a3, $t1, 0x37
    /* 2144C 80030C4C 8002A88F */  lw         $t0, 0x280($sp)
    /* 21450 80030C50 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 21454 80030C54 302D0825 */  addiu      $t0, $t0, 0x2D30
    /* 21458 80030C58 21200001 */  addu       $a0, $t0, $zero
    /* 2145C 80030C5C 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 21460 80030C60 1802A8AF */  sw         $t0, 0x218($sp)
    /* 21464 80030C64 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 21468 80030C68 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2146C 80030C6C 12020524 */  addiu      $a1, $zero, 0x212
    /* 21470 80030C70 03000724 */  addiu      $a3, $zero, 0x3
    /* 21474 80030C74 8002A88F */  lw         $t0, 0x280($sp)
    /* 21478 80030C78 1802A68F */  lw         $a2, 0x218($sp)
    /* 2147C 80030C7C 442D1325 */  addiu      $s3, $t0, 0x2D44
    /* 21480 80030C80 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 21484 80030C84 21206002 */   addu      $a0, $s3, $zero
    /* 21488 80030C88 21280000 */  addu       $a1, $zero, $zero
    /* 2148C 80030C8C 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 21490 80030C90 1180083C */  lui        $t0, %hi(D_80114920)
    /* 21494 80030C94 20490825 */  addiu      $t0, $t0, %lo(D_80114920)
    /* 21498 80030C98 29000725 */  addiu      $a3, $t0, 0x29
    /* 2149C 80030C9C 8002A98F */  lw         $t1, 0x280($sp)
    /* 214A0 80030CA0 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 214A4 80030CA4 742D2925 */  addiu      $t1, $t1, 0x2D74
    /* 214A8 80030CA8 21202001 */  addu       $a0, $t1, $zero
    /* 214AC 80030CAC 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 214B0 80030CB0 1C02A9AF */  sw         $t1, 0x21C($sp)
    /* 214B4 80030CB4 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 214B8 80030CB8 1000A2AF */   sw        $v0, 0x10($sp)
    /* 214BC 80030CBC 14020524 */  addiu      $a1, $zero, 0x214
    /* 214C0 80030CC0 21380000 */  addu       $a3, $zero, $zero
    /* 214C4 80030CC4 8002A98F */  lw         $t1, 0x280($sp)
    /* 214C8 80030CC8 1C02A68F */  lw         $a2, 0x21C($sp)
    /* 214CC 80030CCC 882D2925 */  addiu      $t1, $t1, 0x2D88
    /* 214D0 80030CD0 21202001 */  addu       $a0, $t1, $zero
    /* 214D4 80030CD4 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 214D8 80030CD8 2002A9AF */   sw        $t1, 0x220($sp)
    /* 214DC 80030CDC 21280000 */  addu       $a1, $zero, $zero
    /* 214E0 80030CE0 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 214E4 80030CE4 1180093C */  lui        $t1, %hi(D_80114920)
    /* 214E8 80030CE8 20492925 */  addiu      $t1, $t1, %lo(D_80114920)
    /* 214EC 80030CEC 2B002725 */  addiu      $a3, $t1, 0x2B
    /* 214F0 80030CF0 8002A88F */  lw         $t0, 0x280($sp)
    /* 214F4 80030CF4 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 214F8 80030CF8 B82D0825 */  addiu      $t0, $t0, 0x2DB8
    /* 214FC 80030CFC 21200001 */  addu       $a0, $t0, $zero
    /* 21500 80030D00 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 21504 80030D04 2402A8AF */  sw         $t0, 0x224($sp)
    /* 21508 80030D08 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 2150C 80030D0C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 21510 80030D10 15020524 */  addiu      $a1, $zero, 0x215
    /* 21514 80030D14 01000724 */  addiu      $a3, $zero, 0x1
    /* 21518 80030D18 8002A88F */  lw         $t0, 0x280($sp)
    /* 2151C 80030D1C 2402A68F */  lw         $a2, 0x224($sp)
    /* 21520 80030D20 CC2D1E25 */  addiu      $fp, $t0, 0x2DCC
    /* 21524 80030D24 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 21528 80030D28 2120C003 */   addu      $a0, $fp, $zero
    /* 2152C 80030D2C 21280000 */  addu       $a1, $zero, $zero
    /* 21530 80030D30 FF000624 */  addiu      $a2, $zero, 0xFF
    /* 21534 80030D34 1180083C */  lui        $t0, %hi(D_80114920)
    /* 21538 80030D38 20490825 */  addiu      $t0, $t0, %lo(D_80114920)
    /* 2153C 80030D3C 2D000725 */  addiu      $a3, $t0, 0x2D
    /* 21540 80030D40 8002A98F */  lw         $t1, 0x280($sp)
    /* 21544 80030D44 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 21548 80030D48 FC2D2925 */  addiu      $t1, $t1, 0x2DFC
    /* 2154C 80030D4C 21202001 */  addu       $a0, $t1, $zero
    /* 21550 80030D50 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 21554 80030D54 2802A9AF */  sw         $t1, 0x228($sp)
    /* 21558 80030D58 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 2155C 80030D5C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 21560 80030D60 16020524 */  addiu      $a1, $zero, 0x216
    /* 21564 80030D64 02000724 */  addiu      $a3, $zero, 0x2
    /* 21568 80030D68 8002A98F */  lw         $t1, 0x280($sp)
    /* 2156C 80030D6C 2802A68F */  lw         $a2, 0x228($sp)
    /* 21570 80030D70 102E2925 */  addiu      $t1, $t1, 0x2E10
    /* 21574 80030D74 21202001 */  addu       $a0, $t1, $zero
    /* 21578 80030D78 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 2157C 80030D7C 2C02A9AF */   sw        $t1, 0x22C($sp)
    /* 21580 80030D80 21280000 */  addu       $a1, $zero, $zero
    /* 21584 80030D84 FF000624 */  addiu      $a2, $zero, 0xFF
    /* 21588 80030D88 1180093C */  lui        $t1, %hi(D_80114920)
    /* 2158C 80030D8C 20492925 */  addiu      $t1, $t1, %lo(D_80114920)
    /* 21590 80030D90 2F002725 */  addiu      $a3, $t1, 0x2F
    /* 21594 80030D94 8002A88F */  lw         $t0, 0x280($sp)
    /* 21598 80030D98 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 2159C 80030D9C 402E0825 */  addiu      $t0, $t0, 0x2E40
    /* 215A0 80030DA0 21200001 */  addu       $a0, $t0, $zero
    /* 215A4 80030DA4 2D024224 */  addiu      $v0, $v0, 0x22D
    /* 215A8 80030DA8 3002A8AF */  sw         $t0, 0x230($sp)
    /* 215AC 80030DAC 8991000C */  jal        __25tListIteratorRangeIndexedccPcT3
    /* 215B0 80030DB0 1000A2AF */   sw        $v0, 0x10($sp)
    /* 215B4 80030DB4 17020524 */  addiu      $a1, $zero, 0x217
    /* 215B8 80030DB8 03000724 */  addiu      $a3, $zero, 0x3
    /* 215BC 80030DBC 8002A88F */  lw         $t0, 0x280($sp)
    /* 215C0 80030DC0 3002A68F */  lw         $a2, 0x230($sp)
    /* 215C4 80030DC4 542E1025 */  addiu      $s0, $t0, 0x2E54
    /* 215C8 80030DC8 1D7D000C */  jal        __22tInsideBoxTwoWaySliderUiP13tListIteratori
    /* 215CC 80030DCC 21200002 */   addu      $a0, $s0, $zero
    /* 215D0 80030DD0 00100524 */  addiu      $a1, $zero, 0x1000
    /* 215D4 80030DD4 21300000 */  addu       $a2, $zero, $zero
    /* 215D8 80030DD8 8002A98F */  lw         $t1, 0x280($sp)
    /* 215DC 80030DDC F401A88F */  lw         $t0, 0x1F4($sp)
    /* 215E0 80030DE0 842E2425 */  addiu      $a0, $t1, 0x2E84
    /* 215E4 80030DE4 FC01A98F */  lw         $t1, 0x1FC($sp)
    /* 215E8 80030DE8 2138C000 */  addu       $a3, $a2, $zero
    /* 215EC 80030DEC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 215F0 80030DF0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 215F4 80030DF4 1800A0AF */  sw         $zero, 0x18($sp)
    /* 215F8 80030DF8 2400A0AF */  sw         $zero, 0x24($sp)
    /* 215FC 80030DFC 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 21600 80030E00 6473000C */  jal        __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 21604 80030E04 2000A9AF */   sw        $t1, 0x20($sp)
    /* 21608 80030E08 00100524 */  addiu      $a1, $zero, 0x1000
    /* 2160C 80030E0C 8002A88F */  lw         $t0, 0x280($sp)
    /* 21610 80030E10 0402A98F */  lw         $t1, 0x204($sp)
    /* 21614 80030E14 F82E0425 */  addiu      $a0, $t0, 0x2EF8
    /* 21618 80030E18 0C02A88F */  lw         $t0, 0x20C($sp)
    /* 2161C 80030E1C 21300000 */  addu       $a2, $zero, $zero
    /* 21620 80030E20 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21624 80030E24 1402A98F */  lw         $t1, 0x214($sp)
    /* 21628 80030E28 2138C000 */  addu       $a3, $a2, $zero
    /* 2162C 80030E2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21630 80030E30 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21634 80030E34 1800A0AF */  sw         $zero, 0x18($sp)
    /* 21638 80030E38 2800B3AF */  sw         $s3, 0x28($sp)
    /* 2163C 80030E3C 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 21640 80030E40 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21644 80030E44 6473000C */  jal        __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 21648 80030E48 2400A9AF */   sw        $t1, 0x24($sp)
    /* 2164C 80030E4C 00100524 */  addiu      $a1, $zero, 0x1000
    /* 21650 80030E50 8002A88F */  lw         $t0, 0x280($sp)
    /* 21654 80030E54 F401A98F */  lw         $t1, 0x1F4($sp)
    /* 21658 80030E58 6C2F0425 */  addiu      $a0, $t0, 0x2F6C
    /* 2165C 80030E5C FC01A88F */  lw         $t0, 0x1FC($sp)
    /* 21660 80030E60 21300000 */  addu       $a2, $zero, $zero
    /* 21664 80030E64 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21668 80030E68 0C02A98F */  lw         $t1, 0x20C($sp)
    /* 2166C 80030E6C 2138C000 */  addu       $a3, $a2, $zero
    /* 21670 80030E70 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21674 80030E74 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21678 80030E78 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2167C 80030E7C 2800B3AF */  sw         $s3, 0x28($sp)
    /* 21680 80030E80 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 21684 80030E84 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21688 80030E88 6473000C */  jal        __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 2168C 80030E8C 2400A9AF */   sw        $t1, 0x24($sp)
    /* 21690 80030E90 00100524 */  addiu      $a1, $zero, 0x1000
    /* 21694 80030E94 21300000 */  addu       $a2, $zero, $zero
    /* 21698 80030E98 8002A88F */  lw         $t0, 0x280($sp)
    /* 2169C 80030E9C 2002A98F */  lw         $t1, 0x220($sp)
    /* 216A0 80030EA0 E02F0425 */  addiu      $a0, $t0, 0x2FE0
    /* 216A4 80030EA4 2C02A88F */  lw         $t0, 0x22C($sp)
    /* 216A8 80030EA8 2138C000 */  addu       $a3, $a2, $zero
    /* 216AC 80030EAC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 216B0 80030EB0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 216B4 80030EB4 1800A0AF */  sw         $zero, 0x18($sp)
    /* 216B8 80030EB8 2000BEAF */  sw         $fp, 0x20($sp)
    /* 216BC 80030EBC 2800B0AF */  sw         $s0, 0x28($sp)
    /* 216C0 80030EC0 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 216C4 80030EC4 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 216C8 80030EC8 6473000C */  jal        __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 216CC 80030ECC 2400A8AF */   sw        $t0, 0x24($sp)
    /* 216D0 80030ED0 86020524 */  addiu      $a1, $zero, 0x286
    /* 216D4 80030ED4 21300000 */  addu       $a2, $zero, $zero
    /* 216D8 80030ED8 0380073C */  lui        $a3, %hi(MenuExtended_SaveGame__FR12tMenuCommand)
    /* 216DC 80030EDC 8002A98F */  lw         $t1, 0x280($sp)
    /* 216E0 80030EE0 ECD7E724 */  addiu      $a3, $a3, %lo(MenuExtended_SaveGame__FR12tMenuCommand)
    /* 216E4 80030EE4 54303E25 */  addiu      $fp, $t1, 0x3054
    /* 216E8 80030EE8 CA94000C */  jal        __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
    /* 216EC 80030EEC 2120C003 */   addu      $a0, $fp, $zero
    /* 216F0 80030EF0 87020524 */  addiu      $a1, $zero, 0x287
    /* 216F4 80030EF4 21300000 */  addu       $a2, $zero, $zero
    /* 216F8 80030EF8 0380073C */  lui        $a3, %hi(MenuExtended_LoadGame__FR12tMenuCommand)
    /* 216FC 80030EFC D0D8E724 */  addiu      $a3, $a3, %lo(MenuExtended_LoadGame__FR12tMenuCommand)
    /* 21700 80030F00 8002A88F */  lw         $t0, 0x280($sp)
    /* 21704 80030F04 0180093C */  lui        $t1, %hi(_vt_19tMemoryCardMenuItem)
    /* 21708 80030F08 680A2925 */  addiu      $t1, $t1, %lo(_vt_19tMemoryCardMenuItem)
    /* 2170C 80030F0C 1800C9AF */  sw         $t1, 0x18($fp)
    /* 21710 80030F10 80301025 */  addiu      $s0, $t0, 0x3080
    /* 21714 80030F14 CA94000C */  jal        __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
    /* 21718 80030F18 21200002 */   addu      $a0, $s0, $zero
    /* 2171C 80030F1C 20100524 */  addiu      $a1, $zero, 0x1020
    /* 21720 80030F20 0580093C */  lui        $t1, %hi(screenMemcard)
    /* 21724 80030F24 21380000 */  addu       $a3, $zero, $zero
    /* 21728 80030F28 8002A88F */  lw         $t0, 0x280($sp)
    /* 2172C 80030F2C F028268D */  lw         $a2, %lo(screenMemcard)($t1)
    /* 21730 80030F30 AC300825 */  addiu      $t0, $t0, 0x30AC
    /* 21734 80030F34 21200001 */  addu       $a0, $t0, $zero
    /* 21738 80030F38 3402A8AF */  sw         $t0, 0x234($sp)
    /* 2173C 80030F3C 0180083C */  lui        $t0, %hi(_vt_19tMemoryCardMenuItem)
    /* 21740 80030F40 680A0825 */  addiu      $t0, $t0, %lo(_vt_19tMemoryCardMenuItem)
    /* 21744 80030F44 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21748 80030F48 180008AE */  sw         $t0, 0x18($s0)
    /* 2174C 80030F4C 2E000824 */  addiu      $t0, $zero, 0x2E
    /* 21750 80030F50 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21754 80030F54 0A000924 */  addiu      $t1, $zero, 0xA
    /* 21758 80030F58 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2175C 80030F5C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21760 80030F60 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 21764 80030F64 2000A9AF */  sw         $t1, 0x20($sp)
    /* 21768 80030F68 2400B0AF */  sw         $s0, 0x24($sp)
    /* 2176C 80030F6C 2800BEAF */  sw         $fp, 0x28($sp)
    /* 21770 80030F70 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21774 80030F74 2C00A0AF */   sw        $zero, 0x2C($sp)
    /* 21778 80030F78 8002A88F */  lw         $t0, 0x280($sp)
    /* 2177C 80030F7C F8010524 */  addiu      $a1, $zero, 0x1F8
    /* 21780 80030F80 2C311025 */  addiu      $s0, $t0, 0x312C
    /* 21784 80030F84 0E7F000C */  jal        __17tUserNameMenuItemUi
    /* 21788 80030F88 21200002 */   addu      $a0, $s0, $zero
    /* 2178C 80030F8C 8002A98F */  lw         $t1, 0x280($sp)
    /* 21790 80030F90 F8010524 */  addiu      $a1, $zero, 0x1F8
    /* 21794 80030F94 B8312925 */  addiu      $t1, $t1, 0x31B8
    /* 21798 80030F98 21202001 */  addu       $a0, $t1, $zero
    /* 2179C 80030F9C 0E7F000C */  jal        __17tUserNameMenuItemUi
    /* 217A0 80030FA0 3802A9AF */   sw        $t1, 0x238($sp)
    /* 217A4 80030FA4 8002A88F */  lw         $t0, 0x280($sp)
    /* 217A8 80030FA8 F8010524 */  addiu      $a1, $zero, 0x1F8
    /* 217AC 80030FAC 44320825 */  addiu      $t0, $t0, 0x3244
    /* 217B0 80030FB0 21200001 */  addu       $a0, $t0, $zero
    /* 217B4 80030FB4 0E7F000C */  jal        __17tUserNameMenuItemUi
    /* 217B8 80030FB8 3C02A8AF */   sw        $t0, 0x23C($sp)
    /* 217BC 80030FBC 20110524 */  addiu      $a1, $zero, 0x1120
    /* 217C0 80030FC0 0580083C */  lui        $t0, %hi(screenUserName)
    /* 217C4 80030FC4 21380000 */  addu       $a3, $zero, $zero
    /* 217C8 80030FC8 8002A98F */  lw         $t1, 0x280($sp)
    /* 217CC 80030FCC B429068D */  lw         $a2, %lo(screenUserName)($t0)
    /* 217D0 80030FD0 20000824 */  addiu      $t0, $zero, 0x20
    /* 217D4 80030FD4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 217D8 80030FD8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 217DC 80030FDC 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 217E0 80030FE0 2400B0AF */  sw         $s0, 0x24($sp)
    /* 217E4 80030FE4 2800A0AF */  sw         $zero, 0x28($sp)
    /* 217E8 80030FE8 D0322925 */  addiu      $t1, $t1, 0x32D0
    /* 217EC 80030FEC 21202001 */  addu       $a0, $t1, $zero
    /* 217F0 80030FF0 4002A9AF */  sw         $t1, 0x240($sp)
    /* 217F4 80030FF4 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 217F8 80030FF8 1800A9AF */  sw         $t1, 0x18($sp)
    /* 217FC 80030FFC 0A000924 */  addiu      $t1, $zero, 0xA
    /* 21800 80031000 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21804 80031004 2000A9AF */   sw        $t1, 0x20($sp)
    /* 21808 80031008 0580133C */  lui        $s3, %hi(screenTrophyRoom)
    /* 2180C 8003100C 8002A88F */  lw         $t0, 0x280($sp)
    /* 21810 80031010 6020668E */  lw         $a2, %lo(screenTrophyRoom)($s3)
    /* 21814 80031014 50330825 */  addiu      $t0, $t0, 0x3350
    /* 21818 80031018 21200001 */  addu       $a0, $t0, $zero
    /* 2181C 8003101C D800C524 */  addiu      $a1, $a2, 0xD8
    /* 21820 80031020 CC00C624 */  addiu      $a2, $a2, 0xCC
    /* 21824 80031024 748F000C */  jal        __13tListIteratorPsPc
    /* 21828 80031028 4402A8AF */   sw        $t0, 0x244($sp)
    /* 2182C 8003102C 5E000524 */  addiu      $a1, $zero, 0x5E
    /* 21830 80031030 8002A98F */  lw         $t1, 0x280($sp)
    /* 21834 80031034 4402A68F */  lw         $a2, 0x244($sp)
    /* 21838 80031038 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 2183C 8003103C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21840 80031040 60333025 */  addiu      $s0, $t1, 0x3360
    /* 21844 80031044 0F6A000C */  jal        __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* 21848 80031048 21200002 */   addu      $a0, $s0, $zero
    /* 2184C 8003104C 10400524 */  addiu      $a1, $zero, 0x4010
    /* 21850 80031050 21380000 */  addu       $a3, $zero, $zero
    /* 21854 80031054 0180023C */  lui        $v0, %hi(D_80011530)
    /* 21858 80031058 8002A88F */  lw         $t0, 0x280($sp)
    /* 2185C 8003105C 6020668E */  lw         $a2, %lo(screenTrophyRoom)($s3)
    /* 21860 80031060 30154224 */  addiu      $v0, $v0, %lo(D_80011530)
    /* 21864 80031064 180002AE */  sw         $v0, 0x18($s0)
    /* 21868 80031068 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 2186C 8003106C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21870 80031070 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21874 80031074 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21878 80031078 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* 2187C 8003107C 2000A0AF */  sw         $zero, 0x20($sp)
    /* 21880 80031080 D26D000C */  jal        __15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 21884 80031084 88330425 */   addiu     $a0, $t0, 0x3388
    /* 21888 80031088 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 2188C 8003108C 21300000 */  addu       $a2, $zero, $zero
    /* 21890 80031090 0380073C */  lui        $a3, %hi(MenuExtended_PinkSlipsContinue__FR12tMenuCommand)
    /* 21894 80031094 4CE3E724 */  addiu      $a3, $a3, %lo(MenuExtended_PinkSlipsContinue__FR12tMenuCommand)
    /* 21898 80031098 8002A88F */  lw         $t0, 0x280($sp)
    /* 2189C 8003109C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 218A0 800310A0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 218A4 800310A4 1400A9AF */  sw         $t1, 0x14($sp)
    /* 218A8 800310A8 04340825 */  addiu      $t0, $t0, 0x3404
    /* 218AC 800310AC 21200001 */  addu       $a0, $t0, $zero
    /* 218B0 800310B0 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 218B4 800310B4 4802A8AF */   sw        $t0, 0x248($sp)
    /* 218B8 800310B8 9C000524 */  addiu      $a1, $zero, 0x9C
    /* 218BC 800310BC 21300000 */  addu       $a2, $zero, $zero
    /* 218C0 800310C0 0380073C */  lui        $a3, %hi(MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand)
    /* 218C4 800310C4 1CE2E724 */  addiu      $a3, $a3, %lo(MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand)
    /* 218C8 800310C8 8002A88F */  lw         $t0, 0x280($sp)
    /* 218CC 800310CC 0A000924 */  addiu      $t1, $zero, 0xA
    /* 218D0 800310D0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 218D4 800310D4 1400A9AF */  sw         $t1, 0x14($sp)
    /* 218D8 800310D8 30341025 */  addiu      $s0, $t0, 0x3430
    /* 218DC 800310DC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 218E0 800310E0 21200002 */   addu      $a0, $s0, $zero
    /* 218E4 800310E4 04100524 */  addiu      $a1, $zero, 0x1004
    /* 218E8 800310E8 0580023C */  lui        $v0, %hi(screenPinkSlipStandings)
    /* 218EC 800310EC 21380000 */  addu       $a3, $zero, $zero
    /* 218F0 800310F0 8002A88F */  lw         $t0, 0x280($sp)
    /* 218F4 800310F4 701E468C */  lw         $a2, %lo(screenPinkSlipStandings)($v0)
    /* 218F8 800310F8 4802A98F */  lw         $t1, 0x248($sp)
    /* 218FC 800310FC F4021324 */  addiu      $s3, $zero, 0x2F4
    /* 21900 80031100 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21904 80031104 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21908 80031108 1800B3AF */  sw         $s3, 0x18($sp)
    /* 2190C 8003110C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 21910 80031110 2400A0AF */  sw         $zero, 0x24($sp)
    /* 21914 80031114 5C340425 */  addiu      $a0, $t0, 0x345C
    /* 21918 80031118 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 2191C 8003111C 1C00A9AF */   sw        $t1, 0x1C($sp)
    /* 21920 80031120 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 21924 80031124 8002A88F */  lw         $t0, 0x280($sp)
    /* 21928 80031128 8002A98F */  lw         $t1, 0x280($sp)
    /* 2192C 8003112C 21380000 */  addu       $a3, $zero, $zero
    /* 21930 80031130 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21934 80031134 D8340825 */  addiu      $t0, $t0, 0x34D8
    /* 21938 80031138 21200001 */  addu       $a0, $t0, $zero
    /* 2193C 8003113C F0102625 */  addiu      $a2, $t1, 0x10F0
    /* 21940 80031140 4C02A8AF */  sw         $t0, 0x24C($sp)
    /* 21944 80031144 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21948 80031148 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 2194C 8003114C 1400A8AF */   sw        $t0, 0x14($sp)
    /* 21950 80031150 9B000524 */  addiu      $a1, $zero, 0x9B
    /* 21954 80031154 21300000 */  addu       $a2, $zero, $zero
    /* 21958 80031158 0380073C */  lui        $a3, %hi(MenuExtended_ExitTourney__FR12tMenuCommand)
    /* 2195C 8003115C 8CE1E724 */  addiu      $a3, $a3, %lo(MenuExtended_ExitTourney__FR12tMenuCommand)
    /* 21960 80031160 8002A98F */  lw         $t1, 0x280($sp)
    /* 21964 80031164 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21968 80031168 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2196C 8003116C 1400A8AF */  sw         $t0, 0x14($sp)
    /* 21970 80031170 04353025 */  addiu      $s0, $t1, 0x3504
    /* 21974 80031174 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 21978 80031178 21200002 */   addu      $a0, $s0, $zero
    /* 2197C 8003117C 04100524 */  addiu      $a1, $zero, 0x1004
    /* 21980 80031180 0580023C */  lui        $v0, %hi(screenTournamentStandings3item)
    /* 21984 80031184 8002A98F */  lw         $t1, 0x280($sp)
    /* 21988 80031188 6C1E468C */  lw         $a2, %lo(screenTournamentStandings3item)($v0)
    /* 2198C 8003118C 4C02A88F */  lw         $t0, 0x24C($sp)
    /* 21990 80031190 21380000 */  addu       $a3, $zero, $zero
    /* 21994 80031194 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21998 80031198 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2199C 8003119C 1800B3AF */  sw         $s3, 0x18($sp)
    /* 219A0 800311A0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 219A4 800311A4 2400A0AF */  sw         $zero, 0x24($sp)
    /* 219A8 800311A8 30352425 */  addiu      $a0, $t1, 0x3530
    /* 219AC 800311AC 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 219B0 800311B0 1C00A8AF */   sw        $t0, 0x1C($sp)
    /* 219B4 800311B4 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 219B8 800311B8 8002A98F */  lw         $t1, 0x280($sp)
    /* 219BC 800311BC 21380000 */  addu       $a3, $zero, $zero
    /* 219C0 800311C0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 219C4 800311C4 AC353025 */  addiu      $s0, $t1, 0x35AC
    /* 219C8 800311C8 21200002 */  addu       $a0, $s0, $zero
    /* 219CC 800311CC 54362825 */  addiu      $t0, $t1, 0x3654
    /* 219D0 800311D0 21300001 */  addu       $a2, $t0, $zero
    /* 219D4 800311D4 0A000924 */  addiu      $t1, $zero, 0xA
    /* 219D8 800311D8 5002A8AF */  sw         $t0, 0x250($sp)
    /* 219DC 800311DC 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 219E0 800311E0 1400A9AF */   sw        $t1, 0x14($sp)
    /* 219E4 800311E4 04100524 */  addiu      $a1, $zero, 0x1004
    /* 219E8 800311E8 0580023C */  lui        $v0, %hi(screenTournamentStandings)
    /* 219EC 800311EC 8002A88F */  lw         $t0, 0x280($sp)
    /* 219F0 800311F0 681E468C */  lw         $a2, %lo(screenTournamentStandings)($v0)
    /* 219F4 800311F4 21380000 */  addu       $a3, $zero, $zero
    /* 219F8 800311F8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 219FC 800311FC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21A00 80031200 1800B3AF */  sw         $s3, 0x18($sp)
    /* 21A04 80031204 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* 21A08 80031208 2000A0AF */  sw         $zero, 0x20($sp)
    /* 21A0C 8003120C 266C000C */  jal        __9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* 21A10 80031210 D8350425 */   addiu     $a0, $t0, 0x35D8
    /* 21A14 80031214 00800534 */  ori        $a1, $zero, 0x8000
    /* 21A18 80031218 0580023C */  lui        $v0, %hi(screenTournamentTrophy)
    /* 21A1C 8003121C 21380000 */  addu       $a3, $zero, $zero
    /* 21A20 80031220 4829468C */  lw         $a2, %lo(screenTournamentTrophy)($v0)
    /* 21A24 80031224 0380023C */  lui        $v0, %hi(MenuExtended_TierFinished__FR12tMenuCommand)
    /* 21A28 80031228 68D94224 */  addiu      $v0, $v0, %lo(MenuExtended_TierFinished__FR12tMenuCommand)
    /* 21A2C 8003122C 5002A48F */  lw         $a0, 0x250($sp)
    /* 21A30 80031230 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21A34 80031234 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21A38 80031238 1400A2AF */  sw         $v0, 0x14($sp)
    /* 21A3C 8003123C 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 21A40 80031240 1800A9AF */   sw        $t1, 0x18($sp)
    /* 21A44 80031244 40100524 */  addiu      $a1, $zero, 0x1040
    /* 21A48 80031248 0580093C */  lui        $t1, %hi(screenUserName)
    /* 21A4C 8003124C 21380000 */  addu       $a3, $zero, $zero
    /* 21A50 80031250 0380023C */  lui        $v0, %hi(MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand)
    /* 21A54 80031254 8002A88F */  lw         $t0, 0x280($sp)
    /* 21A58 80031258 B429268D */  lw         $a2, %lo(screenUserName)($t1)
    /* 21A5C 8003125C 20000924 */  addiu      $t1, $zero, 0x20
    /* 21A60 80031260 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21A64 80031264 3802A98F */  lw         $t1, 0x238($sp)
    /* 21A68 80031268 04DC4224 */  addiu      $v0, $v0, %lo(MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand)
    /* 21A6C 8003126C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21A70 80031270 1400A2AF */  sw         $v0, 0x14($sp)
    /* 21A74 80031274 2800A0AF */  sw         $zero, 0x28($sp)
    /* 21A78 80031278 D0360425 */  addiu      $a0, $t0, 0x36D0
    /* 21A7C 8003127C FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 21A80 80031280 1800A8AF */  sw         $t0, 0x18($sp)
    /* 21A84 80031284 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21A88 80031288 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21A8C 8003128C 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21A90 80031290 2400A9AF */   sw        $t1, 0x24($sp)
    /* 21A94 80031294 80100524 */  addiu      $a1, $zero, 0x1080
    /* 21A98 80031298 0580093C */  lui        $t1, %hi(screenUserName)
    /* 21A9C 8003129C 21380000 */  addu       $a3, $zero, $zero
    /* 21AA0 800312A0 0380023C */  lui        $v0, %hi(MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand)
    /* 21AA4 800312A4 8002A88F */  lw         $t0, 0x280($sp)
    /* 21AA8 800312A8 B429268D */  lw         $a2, %lo(screenUserName)($t1)
    /* 21AAC 800312AC 20000924 */  addiu      $t1, $zero, 0x20
    /* 21AB0 800312B0 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21AB4 800312B4 3C02A98F */  lw         $t1, 0x23C($sp)
    /* 21AB8 800312B8 14DD4224 */  addiu      $v0, $v0, %lo(MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand)
    /* 21ABC 800312BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21AC0 800312C0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 21AC4 800312C4 2800A0AF */  sw         $zero, 0x28($sp)
    /* 21AC8 800312C8 50370425 */  addiu      $a0, $t0, 0x3750
    /* 21ACC 800312CC FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 21AD0 800312D0 1800A8AF */  sw         $t0, 0x18($sp)
    /* 21AD4 800312D4 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21AD8 800312D8 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21ADC 800312DC 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21AE0 800312E0 2400A9AF */   sw        $t1, 0x24($sp)
    /* 21AE4 800312E4 5A000524 */  addiu      $a1, $zero, 0x5A
    /* 21AE8 800312E8 21300000 */  addu       $a2, $zero, $zero
    /* 21AEC 800312EC 0380073C */  lui        $a3, %hi(MenuExtended_PostGameMenu__FR12tMenuCommand)
    /* 21AF0 800312F0 04DBE724 */  addiu      $a3, $a3, %lo(MenuExtended_PostGameMenu__FR12tMenuCommand)
    /* 21AF4 800312F4 8002A88F */  lw         $t0, 0x280($sp)
    /* 21AF8 800312F8 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21AFC 800312FC 1000A9AF */  sw         $t1, 0x10($sp)
    /* 21B00 80031300 D0371025 */  addiu      $s0, $t0, 0x37D0
    /* 21B04 80031304 21200002 */  addu       $a0, $s0, $zero
    /* 21B08 80031308 21402001 */  addu       $t0, $t1, $zero
    /* 21B0C 8003130C 2B69000C */  jal        __27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
    /* 21B10 80031310 1400A8AF */   sw        $t0, 0x14($sp)
    /* 21B14 80031314 0200053C */  lui        $a1, (0x21004 >> 16)
    /* 21B18 80031318 0410A534 */  ori        $a1, $a1, (0x21004 & 0xFFFF)
    /* 21B1C 8003131C 21380000 */  addu       $a3, $zero, $zero
    /* 21B20 80031320 0580023C */  lui        $v0, %hi(screenTrackRecords)
    /* 21B24 80031324 D020468C */  lw         $a2, %lo(screenTrackRecords)($v0)
    /* 21B28 80031328 0180023C */  lui        $v0, %hi(D_800114D8)
    /* 21B2C 8003132C D8144224 */  addiu      $v0, $v0, %lo(D_800114D8)
    /* 21B30 80031330 180002AE */  sw         $v0, 0x18($s0)
    /* 21B34 80031334 D4000224 */  addiu      $v0, $zero, 0xD4
    /* 21B38 80031338 8002A98F */  lw         $t1, 0x280($sp)
    /* 21B3C 8003133C 01000824 */  addiu      $t0, $zero, 0x1
    /* 21B40 80031340 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21B44 80031344 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21B48 80031348 1800A2AF */  sw         $v0, 0x18($sp)
    /* 21B4C 8003134C 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 21B50 80031350 2400B0AF */  sw         $s0, 0x24($sp)
    /* 21B54 80031354 2800A0AF */  sw         $zero, 0x28($sp)
    /* 21B58 80031358 FC372425 */  addiu      $a0, $t1, 0x37FC
    /* 21B5C 8003135C 0A000924 */  addiu      $t1, $zero, 0xA
    /* 21B60 80031360 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21B64 80031364 2000A9AF */   sw        $t1, 0x20($sp)
    /* 21B68 80031368 00800534 */  ori        $a1, $zero, 0x8000
    /* 21B6C 8003136C 0580023C */  lui        $v0, %hi(screenPinkSlipCongrats)
    /* 21B70 80031370 21380000 */  addu       $a3, $zero, $zero
    /* 21B74 80031374 4429468C */  lw         $a2, %lo(screenPinkSlipCongrats)($v0)
    /* 21B78 80031378 0380023C */  lui        $v0, %hi(MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand)
    /* 21B7C 8003137C 74DE4224 */  addiu      $v0, $v0, %lo(MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand)
    /* 21B80 80031380 8002A88F */  lw         $t0, 0x280($sp)
    /* 21B84 80031384 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21B88 80031388 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21B8C 8003138C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 21B90 80031390 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21B94 80031394 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 21B98 80031398 7C380425 */   addiu     $a0, $t0, 0x387C
    /* 21B9C 8003139C 00800534 */  ori        $a1, $zero, 0x8000
    /* 21BA0 800313A0 0580023C */  lui        $v0, %hi(screenBeTheCopCongrats)
    /* 21BA4 800313A4 21380000 */  addu       $a3, $zero, $zero
    /* 21BA8 800313A8 0380103C */  lui        $s0, %hi(MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand)
    /* 21BAC 800313AC B0C41026 */  addiu      $s0, $s0, %lo(MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand)
    /* 21BB0 800313B0 8002A88F */  lw         $t0, 0x280($sp)
    /* 21BB4 800313B4 4C29468C */  lw         $a2, %lo(screenBeTheCopCongrats)($v0)
    /* 21BB8 800313B8 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21BBC 800313BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21BC0 800313C0 1400B0AF */  sw         $s0, 0x14($sp)
    /* 21BC4 800313C4 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21BC8 800313C8 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 21BCC 800313CC F8380425 */   addiu     $a0, $t0, 0x38F8
    /* 21BD0 800313D0 00800534 */  ori        $a1, $zero, 0x8000
    /* 21BD4 800313D4 0580023C */  lui        $v0, %hi(screenTournamentCongrats)
    /* 21BD8 800313D8 21380000 */  addu       $a3, $zero, $zero
    /* 21BDC 800313DC 8002A88F */  lw         $t0, 0x280($sp)
    /* 21BE0 800313E0 5029468C */  lw         $a2, %lo(screenTournamentCongrats)($v0)
    /* 21BE4 800313E4 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21BE8 800313E8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21BEC 800313EC 1400B0AF */  sw         $s0, 0x14($sp)
    /* 21BF0 800313F0 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21BF4 800313F4 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 21BF8 800313F8 74390425 */   addiu     $a0, $t0, 0x3974
    /* 21BFC 800313FC 10100524 */  addiu      $a1, $zero, 0x1010
    /* 21C00 80031400 0580023C */  lui        $v0, %hi(screenMain)
    /* 21C04 80031404 21380000 */  addu       $a3, $zero, $zero
    /* 21C08 80031408 8002A88F */  lw         $t0, 0x280($sp)
    /* 21C0C 8003140C 581E468C */  lw         $a2, %lo(screenMain)($v0)
    /* 21C10 80031410 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 21C14 80031414 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21C18 80031418 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21C1C 8003141C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 21C20 80031420 266E000C */  jal        __10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* 21C24 80031424 F0390425 */   addiu     $a0, $t0, 0x39F0
    /* 21C28 80031428 8A020524 */  addiu      $a1, $zero, 0x28A
    /* 21C2C 8003142C 21300000 */  addu       $a2, $zero, $zero
    /* 21C30 80031430 0380073C */  lui        $a3, %hi(MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand)
    /* 21C34 80031434 8002A88F */  lw         $t0, 0x280($sp)
    /* 21C38 80031438 94C4E724 */  addiu      $a3, $a3, %lo(MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand)
    /* 21C3C 8003143C 6C3A1025 */  addiu      $s0, $t0, 0x3A6C
    /* 21C40 80031440 CA94000C */  jal        __23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
    /* 21C44 80031444 21200002 */   addu      $a0, $s0, $zero
    /* 21C48 80031448 40100524 */  addiu      $a1, $zero, 0x1040
    /* 21C4C 8003144C 0580083C */  lui        $t0, %hi(screenMemcard)
    /* 21C50 80031450 21380000 */  addu       $a3, $zero, $zero
    /* 21C54 80031454 8002A98F */  lw         $t1, 0x280($sp)
    /* 21C58 80031458 F028068D */  lw         $a2, %lo(screenMemcard)($t0)
    /* 21C5C 8003145C 983A2425 */  addiu      $a0, $t1, 0x3A98
    /* 21C60 80031460 0180093C */  lui        $t1, %hi(_vt_19tMemoryCardMenuItem)
    /* 21C64 80031464 680A2925 */  addiu      $t1, $t1, %lo(_vt_19tMemoryCardMenuItem)
    /* 21C68 80031468 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 21C6C 8003146C 180009AE */  sw         $t1, 0x18($s0)
    /* 21C70 80031470 2E000924 */  addiu      $t1, $zero, 0x2E
    /* 21C74 80031474 1800A8AF */  sw         $t0, 0x18($sp)
    /* 21C78 80031478 0A000824 */  addiu      $t0, $zero, 0xA
    /* 21C7C 8003147C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 21C80 80031480 1400A0AF */  sw         $zero, 0x14($sp)
    /* 21C84 80031484 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 21C88 80031488 2000A8AF */  sw         $t0, 0x20($sp)
    /* 21C8C 8003148C 2400B0AF */  sw         $s0, 0x24($sp)
    /* 21C90 80031490 2800BEAF */  sw         $fp, 0x28($sp)
    /* 21C94 80031494 2D71000C */  jal        __12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
    /* 21C98 80031498 2C00A0AF */   sw        $zero, 0x2C($sp)
    /* 21C9C 8003149C 21280000 */  addu       $a1, $zero, $zero
    /* 21CA0 800314A0 2130A000 */  addu       $a2, $a1, $zero
    /* 21CA4 800314A4 78000724 */  addiu      $a3, $zero, 0x78
    /* 21CA8 800314A8 8002A98F */  lw         $t1, 0x280($sp)
    /* 21CAC 800314AC 05001024 */  addiu      $s0, $zero, 0x5
    /* 21CB0 800314B0 CC252425 */  addiu      $a0, $t1, 0x25CC
    /* 21CB4 800314B4 B8172225 */  addiu      $v0, $t1, 0x17B8
    /* 21CB8 800314B8 181722AD */  sw         $v0, 0x1718($t1)
    /* 21CBC 800314BC 58192225 */  addiu      $v0, $t1, 0x1958
    /* 21CC0 800314C0 E01822AD */  sw         $v0, 0x18E0($t1)
    /* 21CC4 800314C4 141B2225 */  addiu      $v0, $t1, 0x1B14
    /* 21CC8 800314C8 9C1A22AD */  sw         $v0, 0x1A9C($t1)
    /* 21CCC 800314CC C494000C */  jal        SetDimensions__24tMenuItemLeftRightSliderssss
    /* 21CD0 800314D0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 21CD4 800314D4 21280000 */  addu       $a1, $zero, $zero
    /* 21CD8 800314D8 2130A000 */  addu       $a2, $a1, $zero
    /* 21CDC 800314DC 8002A88F */  lw         $t0, 0x280($sp)
    /* 21CE0 800314E0 78000724 */  addiu      $a3, $zero, 0x78
    /* 21CE4 800314E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 21CE8 800314E8 C494000C */  jal        SetDimensions__24tMenuItemLeftRightSliderssss
    /* 21CEC 800314EC 04260425 */   addiu     $a0, $t0, 0x2604
    /* 21CF0 800314F0 21280000 */  addu       $a1, $zero, $zero
    /* 21CF4 800314F4 2130A000 */  addu       $a2, $a1, $zero
    /* 21CF8 800314F8 8002A98F */  lw         $t1, 0x280($sp)
    /* 21CFC 800314FC 78000724 */  addiu      $a3, $zero, 0x78
    /* 21D00 80031500 1000B0AF */  sw         $s0, 0x10($sp)
    /* 21D04 80031504 C494000C */  jal        SetDimensions__24tMenuItemLeftRightSliderssss
    /* 21D08 80031508 3C262425 */   addiu     $a0, $t1, 0x263C
    /* 21D0C 8003150C 21280000 */  addu       $a1, $zero, $zero
    /* 21D10 80031510 2130A000 */  addu       $a2, $a1, $zero
    /* 21D14 80031514 8002A88F */  lw         $t0, 0x280($sp)
    /* 21D18 80031518 78000724 */  addiu      $a3, $zero, 0x78
    /* 21D1C 8003151C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 21D20 80031520 C494000C */  jal        SetDimensions__24tMenuItemLeftRightSliderssss
    /* 21D24 80031524 74260425 */   addiu     $a0, $t0, 0x2674
    /* 21D28 80031528 21280000 */  addu       $a1, $zero, $zero
    /* 21D2C 8003152C 2130A000 */  addu       $a2, $a1, $zero
    /* 21D30 80031530 8002A98F */  lw         $t1, 0x280($sp)
    /* 21D34 80031534 78000724 */  addiu      $a3, $zero, 0x78
    /* 21D38 80031538 1000B0AF */  sw         $s0, 0x10($sp)
    /* 21D3C 8003153C C494000C */  jal        SetDimensions__24tMenuItemLeftRightSliderssss
    /* 21D40 80031540 AC262425 */   addiu     $a0, $t1, 0x26AC
    /* 21D44 80031544 02000424 */  addiu      $a0, $zero, 0x2
    /* 21D48 80031548 8002A28F */  lw         $v0, 0x280($sp)
    /* 21D4C 8003154C 20000824 */  addiu      $t0, $zero, 0x20
    /* 21D50 80031550 AC35438C */  lw         $v1, 0x35AC($v0)
    /* 21D54 80031554 01000924 */  addiu      $t1, $zero, 0x1
    /* 21D58 80031558 E41948AC */  sw         $t0, 0x19E4($v0)
    /* 21D5C 8003155C 21402001 */  addu       $t0, $t1, $zero
    /* 21D60 80031560 DC1244AC */  sw         $a0, 0x12DC($v0)
    /* 21D64 80031564 741C49AC */  sw         $t1, 0x1C74($v0)
    /* 21D68 80031568 D41D44AC */  sw         $a0, 0x1DD4($v0)
    /* 21D6C 8003156C 442840A4 */  sh         $zero, 0x2844($v0)
    /* 21D70 80031570 CC2A40A4 */  sh         $zero, 0x2ACC($v0)
    /* 21D74 80031574 D02B48A4 */  sh         $t0, 0x2BD0($v0)
    /* 21D78 80031578 40006334 */  ori        $v1, $v1, 0x40
    /* 21D7C 8003157C AC3543AC */  sw         $v1, 0x35AC($v0)
    /* 21D80 80031580 3402A98F */  lw         $t1, 0x234($sp)
    /* 21D84 80031584 00000000 */  nop
    /* 21D88 80031588 640020A5 */  sh         $zero, 0x64($t1)
    /* 21D8C 8003158C 4002A88F */  lw         $t0, 0x240($sp)
    /* 21D90 80031590 00000000 */  nop
    /* 21D94 80031594 640000A5 */  sh         $zero, 0x64($t0)
    /* 21D98 80031598 01000924 */  addiu      $t1, $zero, 0x1
    /* 21D9C 8003159C A81049A4 */  sh         $t1, 0x10A8($v0)
    /* 21DA0 800315A0 640240A4 */  sh         $zero, 0x264($v0)
    /* 21DA4 800315A4 7C02BF8F */  lw         $ra, 0x27C($sp)
    /* 21DA8 800315A8 7802BE8F */  lw         $fp, 0x278($sp)
    /* 21DAC 800315AC 7402B78F */  lw         $s7, 0x274($sp)
    /* 21DB0 800315B0 7002B68F */  lw         $s6, 0x270($sp)
    /* 21DB4 800315B4 6C02B58F */  lw         $s5, 0x26C($sp)
    /* 21DB8 800315B8 6802B48F */  lw         $s4, 0x268($sp)
    /* 21DBC 800315BC 6402B38F */  lw         $s3, 0x264($sp)
    /* 21DC0 800315C0 6002B28F */  lw         $s2, 0x260($sp)
    /* 21DC4 800315C4 5C02B18F */  lw         $s1, 0x25C($sp)
    /* 21DC8 800315C8 5802B08F */  lw         $s0, 0x258($sp)
    /* 21DCC 800315CC 0800E003 */  jr         $ra
    /* 21DD0 800315D0 8002BD27 */   addiu     $sp, $sp, 0x280
endlabel __15tGlobalMenuDefs
