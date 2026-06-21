.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tGlobalMenuDefs, 0xBEC

glabel ___15tGlobalMenuDefs
    /* 21DD4 800315D4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 21DD8 800315D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 21DDC 800315DC 21888000 */  addu       $s1, $a0, $zero
    /* 21DE0 800315E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 21DE4 800315E4 2180A000 */  addu       $s0, $a1, $zero
    /* 21DE8 800315E8 983A2426 */  addiu      $a0, $s1, 0x3A98
    /* 21DEC 800315EC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 21DF0 800315F0 5171000C */  jal        ___12tOptionsMenu
    /* 21DF4 800315F4 02000524 */   addiu     $a1, $zero, 0x2
    /* 21DF8 800315F8 6C3A2426 */  addiu      $a0, $s1, 0x3A6C
    /* 21DFC 800315FC DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* 21E00 80031600 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E04 80031604 F0392426 */  addiu      $a0, $s1, 0x39F0
    /* 21E08 80031608 3F6E000C */  jal        ___10tMenuBlank
    /* 21E0C 8003160C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E10 80031610 74392426 */  addiu      $a0, $s1, 0x3974
    /* 21E14 80031614 3F6E000C */  jal        ___10tMenuBlank
    /* 21E18 80031618 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E1C 8003161C F8382426 */  addiu      $a0, $s1, 0x38F8
    /* 21E20 80031620 3F6E000C */  jal        ___10tMenuBlank
    /* 21E24 80031624 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E28 80031628 7C382426 */  addiu      $a0, $s1, 0x387C
    /* 21E2C 8003162C 3F6E000C */  jal        ___10tMenuBlank
    /* 21E30 80031630 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E34 80031634 FC372426 */  addiu      $a0, $s1, 0x37FC
    /* 21E38 80031638 5171000C */  jal        ___12tOptionsMenu
    /* 21E3C 8003163C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E40 80031640 D0372426 */  addiu      $a0, $s1, 0x37D0
    /* 21E44 80031644 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21E48 80031648 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E4C 8003164C 50372426 */  addiu      $a0, $s1, 0x3750
    /* 21E50 80031650 5171000C */  jal        ___12tOptionsMenu
    /* 21E54 80031654 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E58 80031658 D0362426 */  addiu      $a0, $s1, 0x36D0
    /* 21E5C 8003165C 5171000C */  jal        ___12tOptionsMenu
    /* 21E60 80031660 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E64 80031664 54362426 */  addiu      $a0, $s1, 0x3654
    /* 21E68 80031668 3F6E000C */  jal        ___10tMenuBlank
    /* 21E6C 8003166C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E70 80031670 D8352426 */  addiu      $a0, $s1, 0x35D8
    /* 21E74 80031674 566C000C */  jal        ___9tMenuNFS4
    /* 21E78 80031678 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E7C 8003167C AC352426 */  addiu      $a0, $s1, 0x35AC
    /* 21E80 80031680 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21E84 80031684 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E88 80031688 30352426 */  addiu      $a0, $s1, 0x3530
    /* 21E8C 8003168C 566C000C */  jal        ___9tMenuNFS4
    /* 21E90 80031690 02000524 */   addiu     $a1, $zero, 0x2
    /* 21E94 80031694 04352426 */  addiu      $a0, $s1, 0x3504
    /* 21E98 80031698 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21E9C 8003169C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EA0 800316A0 D8342426 */  addiu      $a0, $s1, 0x34D8
    /* 21EA4 800316A4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21EA8 800316A8 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EAC 800316AC 5C342426 */  addiu      $a0, $s1, 0x345C
    /* 21EB0 800316B0 566C000C */  jal        ___9tMenuNFS4
    /* 21EB4 800316B4 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EB8 800316B8 30342426 */  addiu      $a0, $s1, 0x3430
    /* 21EBC 800316BC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21EC0 800316C0 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EC4 800316C4 04342426 */  addiu      $a0, $s1, 0x3404
    /* 21EC8 800316C8 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 21ECC 800316CC 02000524 */   addiu     $a1, $zero, 0x2
    /* 21ED0 800316D0 88332426 */  addiu      $a0, $s1, 0x3388
    /* 21ED4 800316D4 EC6D000C */  jal        ___15tMenuNFS4Bottom
    /* 21ED8 800316D8 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EDC 800316DC 60332426 */  addiu      $a0, $s1, 0x3360
    /* 21EE0 800316E0 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 21EE4 800316E4 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EE8 800316E8 50332426 */  addiu      $a0, $s1, 0x3350
    /* 21EEC 800316EC 7D8F000C */  jal        ___13tListIterator
    /* 21EF0 800316F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 21EF4 800316F4 D0322426 */  addiu      $a0, $s1, 0x32D0
    /* 21EF8 800316F8 5171000C */  jal        ___12tOptionsMenu
    /* 21EFC 800316FC 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F00 80031700 44322426 */  addiu      $a0, $s1, 0x3244
    /* 21F04 80031704 D991000C */  jal        ___9tMenuItem
    /* 21F08 80031708 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F0C 8003170C B8312426 */  addiu      $a0, $s1, 0x31B8
    /* 21F10 80031710 D991000C */  jal        ___9tMenuItem
    /* 21F14 80031714 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F18 80031718 2C312426 */  addiu      $a0, $s1, 0x312C
    /* 21F1C 8003171C D991000C */  jal        ___9tMenuItem
    /* 21F20 80031720 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F24 80031724 AC302426 */  addiu      $a0, $s1, 0x30AC
    /* 21F28 80031728 5171000C */  jal        ___12tOptionsMenu
    /* 21F2C 8003172C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F30 80031730 80302426 */  addiu      $a0, $s1, 0x3080
    /* 21F34 80031734 DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* 21F38 80031738 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F3C 8003173C 54302426 */  addiu      $a0, $s1, 0x3054
    /* 21F40 80031740 DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* 21F44 80031744 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F48 80031748 E02F2426 */  addiu      $a0, $s1, 0x2FE0
    /* 21F4C 8003174C 8173000C */  jal        ___14tInsideBoxMenu
    /* 21F50 80031750 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F54 80031754 6C2F2426 */  addiu      $a0, $s1, 0x2F6C
    /* 21F58 80031758 8173000C */  jal        ___14tInsideBoxMenu
    /* 21F5C 8003175C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F60 80031760 F82E2426 */  addiu      $a0, $s1, 0x2EF8
    /* 21F64 80031764 8173000C */  jal        ___14tInsideBoxMenu
    /* 21F68 80031768 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F6C 8003176C 842E2426 */  addiu      $a0, $s1, 0x2E84
    /* 21F70 80031770 8173000C */  jal        ___14tInsideBoxMenu
    /* 21F74 80031774 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F78 80031778 542E2426 */  addiu      $a0, $s1, 0x2E54
    /* 21F7C 8003177C 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21F80 80031780 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F84 80031784 402E2426 */  addiu      $a0, $s1, 0x2E40
    /* 21F88 80031788 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 21F8C 8003178C 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F90 80031790 102E2426 */  addiu      $a0, $s1, 0x2E10
    /* 21F94 80031794 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21F98 80031798 02000524 */   addiu     $a1, $zero, 0x2
    /* 21F9C 8003179C FC2D2426 */  addiu      $a0, $s1, 0x2DFC
    /* 21FA0 800317A0 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 21FA4 800317A4 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FA8 800317A8 CC2D2426 */  addiu      $a0, $s1, 0x2DCC
    /* 21FAC 800317AC 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21FB0 800317B0 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FB4 800317B4 B82D2426 */  addiu      $a0, $s1, 0x2DB8
    /* 21FB8 800317B8 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 21FBC 800317BC 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FC0 800317C0 882D2426 */  addiu      $a0, $s1, 0x2D88
    /* 21FC4 800317C4 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21FC8 800317C8 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FCC 800317CC 742D2426 */  addiu      $a0, $s1, 0x2D74
    /* 21FD0 800317D0 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 21FD4 800317D4 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FD8 800317D8 442D2426 */  addiu      $a0, $s1, 0x2D44
    /* 21FDC 800317DC 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21FE0 800317E0 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FE4 800317E4 302D2426 */  addiu      $a0, $s1, 0x2D30
    /* 21FE8 800317E8 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 21FEC 800317EC 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FF0 800317F0 002D2426 */  addiu      $a0, $s1, 0x2D00
    /* 21FF4 800317F4 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 21FF8 800317F8 02000524 */   addiu     $a1, $zero, 0x2
    /* 21FFC 800317FC EC2C2426 */  addiu      $a0, $s1, 0x2CEC
    /* 22000 80031800 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 22004 80031804 02000524 */   addiu     $a1, $zero, 0x2
    /* 22008 80031808 BC2C2426 */  addiu      $a0, $s1, 0x2CBC
    /* 2200C 8003180C 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 22010 80031810 02000524 */   addiu     $a1, $zero, 0x2
    /* 22014 80031814 A82C2426 */  addiu      $a0, $s1, 0x2CA8
    /* 22018 80031818 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 2201C 8003181C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22020 80031820 782C2426 */  addiu      $a0, $s1, 0x2C78
    /* 22024 80031824 327D000C */  jal        ___22tInsideBoxTwoWaySlider
    /* 22028 80031828 02000524 */   addiu     $a1, $zero, 0x2
    /* 2202C 8003182C 642C2426 */  addiu      $a0, $s1, 0x2C64
    /* 22030 80031830 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 22034 80031834 02000524 */   addiu     $a1, $zero, 0x2
    /* 22038 80031838 3C2C2426 */  addiu      $a0, $s1, 0x2C3C
    /* 2203C 8003183C B27C000C */  jal        ___25tInsideBoxLeftRightSlider
    /* 22040 80031840 02000524 */   addiu     $a1, $zero, 0x2
    /* 22044 80031844 282C2426 */  addiu      $a0, $s1, 0x2C28
    /* 22048 80031848 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 2204C 8003184C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22050 80031850 002C2426 */  addiu      $a0, $s1, 0x2C00
    /* 22054 80031854 B27C000C */  jal        ___25tInsideBoxLeftRightSlider
    /* 22058 80031858 02000524 */   addiu     $a1, $zero, 0x2
    /* 2205C 8003185C EC2B2426 */  addiu      $a0, $s1, 0x2BEC
    /* 22060 80031860 9C91000C */  jal        ___25tListIteratorRangeIndexed
    /* 22064 80031864 02000524 */   addiu     $a1, $zero, 0x2
    /* 22068 80031868 6C2B2426 */  addiu      $a0, $s1, 0x2B6C
    /* 2206C 8003186C 5171000C */  jal        ___12tOptionsMenu
    /* 22070 80031870 02000524 */   addiu     $a1, $zero, 0x2
    /* 22074 80031874 282B2426 */  addiu      $a0, $s1, 0x2B28
    /* 22078 80031878 8274000C */  jal        ___20tMenuItemSlidingMenu
    /* 2207C 8003187C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22080 80031880 FC2A2426 */  addiu      $a0, $s1, 0x2AFC
    /* 22084 80031884 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22088 80031888 02000524 */   addiu     $a1, $zero, 0x2
    /* 2208C 8003188C E82A2426 */  addiu      $a0, $s1, 0x2AE8
    /* 22090 80031890 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22094 80031894 02000524 */   addiu     $a1, $zero, 0x2
    /* 22098 80031898 682A2426 */  addiu      $a0, $s1, 0x2A68
    /* 2209C 8003189C 5171000C */  jal        ___12tOptionsMenu
    /* 220A0 800318A0 02000524 */   addiu     $a1, $zero, 0x2
    /* 220A4 800318A4 3C2A2426 */  addiu      $a0, $s1, 0x2A3C
    /* 220A8 800318A8 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220AC 800318AC 02000524 */   addiu     $a1, $zero, 0x2
    /* 220B0 800318B0 102A2426 */  addiu      $a0, $s1, 0x2A10
    /* 220B4 800318B4 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220B8 800318B8 02000524 */   addiu     $a1, $zero, 0x2
    /* 220BC 800318BC E0292426 */  addiu      $a0, $s1, 0x29E0
    /* 220C0 800318C0 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220C4 800318C4 02000524 */   addiu     $a1, $zero, 0x2
    /* 220C8 800318C8 B0292426 */  addiu      $a0, $s1, 0x29B0
    /* 220CC 800318CC 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220D0 800318D0 02000524 */   addiu     $a1, $zero, 0x2
    /* 220D4 800318D4 80292426 */  addiu      $a0, $s1, 0x2980
    /* 220D8 800318D8 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220DC 800318DC 02000524 */   addiu     $a1, $zero, 0x2
    /* 220E0 800318E0 54292426 */  addiu      $a0, $s1, 0x2954
    /* 220E4 800318E4 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220E8 800318E8 02000524 */   addiu     $a1, $zero, 0x2
    /* 220EC 800318EC 28292426 */  addiu      $a0, $s1, 0x2928
    /* 220F0 800318F0 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 220F4 800318F4 02000524 */   addiu     $a1, $zero, 0x2
    /* 220F8 800318F8 FC282426 */  addiu      $a0, $s1, 0x28FC
    /* 220FC 800318FC 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22100 80031900 02000524 */   addiu     $a1, $zero, 0x2
    /* 22104 80031904 E8282426 */  addiu      $a0, $s1, 0x28E8
    /* 22108 80031908 E98F000C */  jal        ___20tListIteratorIndexed
    /* 2210C 8003190C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22110 80031910 D8282426 */  addiu      $a0, $s1, 0x28D8
    /* 22114 80031914 7D8F000C */  jal        ___13tListIterator
    /* 22118 80031918 02000524 */   addiu     $a1, $zero, 0x2
    /* 2211C 8003191C C4282426 */  addiu      $a0, $s1, 0x28C4
    /* 22120 80031920 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22124 80031924 02000524 */   addiu     $a1, $zero, 0x2
    /* 22128 80031928 B0282426 */  addiu      $a0, $s1, 0x28B0
    /* 2212C 8003192C E98F000C */  jal        ___20tListIteratorIndexed
    /* 22130 80031930 02000524 */   addiu     $a1, $zero, 0x2
    /* 22134 80031934 9C282426 */  addiu      $a0, $s1, 0x289C
    /* 22138 80031938 E98F000C */  jal        ___20tListIteratorIndexed
    /* 2213C 8003193C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22140 80031940 88282426 */  addiu      $a0, $s1, 0x2888
    /* 22144 80031944 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22148 80031948 02000524 */   addiu     $a1, $zero, 0x2
    /* 2214C 8003194C 74282426 */  addiu      $a0, $s1, 0x2874
    /* 22150 80031950 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22154 80031954 02000524 */   addiu     $a1, $zero, 0x2
    /* 22158 80031958 60282426 */  addiu      $a0, $s1, 0x2860
    /* 2215C 8003195C E98F000C */  jal        ___20tListIteratorIndexed
    /* 22160 80031960 02000524 */   addiu     $a1, $zero, 0x2
    /* 22164 80031964 E0272426 */  addiu      $a0, $s1, 0x27E0
    /* 22168 80031968 5171000C */  jal        ___12tOptionsMenu
    /* 2216C 8003196C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22170 80031970 58272426 */  addiu      $a0, $s1, 0x2758
    /* 22174 80031974 6C7A000C */  jal        ___18tInsideBoxSongMenu
    /* 22178 80031978 02000524 */   addiu     $a1, $zero, 0x2
    /* 2217C 8003197C 10272426 */  addiu      $a0, $s1, 0x2710
    /* 22180 80031980 8274000C */  jal        ___20tMenuItemSlidingMenu
    /* 22184 80031984 02000524 */   addiu     $a1, $zero, 0x2
    /* 22188 80031988 E4262426 */  addiu      $a0, $s1, 0x26E4
    /* 2218C 8003198C 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22190 80031990 02000524 */   addiu     $a1, $zero, 0x2
    /* 22194 80031994 AC262426 */  addiu      $a0, $s1, 0x26AC
    /* 22198 80031998 5279000C */  jal        ___29tMenuItemLeftRightAudioSlider
    /* 2219C 8003199C 02000524 */   addiu     $a1, $zero, 0x2
    /* 221A0 800319A0 74262426 */  addiu      $a0, $s1, 0x2674
    /* 221A4 800319A4 5279000C */  jal        ___29tMenuItemLeftRightAudioSlider
    /* 221A8 800319A8 02000524 */   addiu     $a1, $zero, 0x2
    /* 221AC 800319AC 3C262426 */  addiu      $a0, $s1, 0x263C
    /* 221B0 800319B0 5279000C */  jal        ___29tMenuItemLeftRightAudioSlider
    /* 221B4 800319B4 02000524 */   addiu     $a1, $zero, 0x2
    /* 221B8 800319B8 04262426 */  addiu      $a0, $s1, 0x2604
    /* 221BC 800319BC 5279000C */  jal        ___29tMenuItemLeftRightAudioSlider
    /* 221C0 800319C0 02000524 */   addiu     $a1, $zero, 0x2
    /* 221C4 800319C4 CC252426 */  addiu      $a0, $s1, 0x25CC
    /* 221C8 800319C8 5279000C */  jal        ___29tMenuItemLeftRightAudioSlider
    /* 221CC 800319CC 02000524 */   addiu     $a1, $zero, 0x2
    /* 221D0 800319D0 BC252426 */  addiu      $a0, $s1, 0x25BC
    /* 221D4 800319D4 7D8F000C */  jal        ___13tListIterator
    /* 221D8 800319D8 02000524 */   addiu     $a1, $zero, 0x2
    /* 221DC 800319DC AC252426 */  addiu      $a0, $s1, 0x25AC
    /* 221E0 800319E0 6491000C */  jal        ___18tListIteratorRange
    /* 221E4 800319E4 02000524 */   addiu     $a1, $zero, 0x2
    /* 221E8 800319E8 9C252426 */  addiu      $a0, $s1, 0x259C
    /* 221EC 800319EC 6491000C */  jal        ___18tListIteratorRange
    /* 221F0 800319F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 221F4 800319F4 8C252426 */  addiu      $a0, $s1, 0x258C
    /* 221F8 800319F8 6491000C */  jal        ___18tListIteratorRange
    /* 221FC 800319FC 02000524 */   addiu     $a1, $zero, 0x2
    /* 22200 80031A00 7C252426 */  addiu      $a0, $s1, 0x257C
    /* 22204 80031A04 6491000C */  jal        ___18tListIteratorRange
    /* 22208 80031A08 02000524 */   addiu     $a1, $zero, 0x2
    /* 2220C 80031A0C 6C252426 */  addiu      $a0, $s1, 0x256C
    /* 22210 80031A10 6491000C */  jal        ___18tListIteratorRange
    /* 22214 80031A14 02000524 */   addiu     $a1, $zero, 0x2
    /* 22218 80031A18 F0242426 */  addiu      $a0, $s1, 0x24F0
    /* 2221C 80031A1C 566C000C */  jal        ___9tMenuNFS4
    /* 22220 80031A20 02000524 */   addiu     $a1, $zero, 0x2
    /* 22224 80031A24 C4242426 */  addiu      $a0, $s1, 0x24C4
    /* 22228 80031A28 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2222C 80031A2C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22230 80031A30 98242426 */  addiu      $a0, $s1, 0x2498
    /* 22234 80031A34 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22238 80031A38 02000524 */   addiu     $a1, $zero, 0x2
    /* 2223C 80031A3C 6C242426 */  addiu      $a0, $s1, 0x246C
    /* 22240 80031A40 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22244 80031A44 02000524 */   addiu     $a1, $zero, 0x2
    /* 22248 80031A48 40242426 */  addiu      $a0, $s1, 0x2440
    /* 2224C 80031A4C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22250 80031A50 02000524 */   addiu     $a1, $zero, 0x2
    /* 22254 80031A54 14242426 */  addiu      $a0, $s1, 0x2414
    /* 22258 80031A58 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2225C 80031A5C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22260 80031A60 E8232426 */  addiu      $a0, $s1, 0x23E8
    /* 22264 80031A64 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22268 80031A68 02000524 */   addiu     $a1, $zero, 0x2
    /* 2226C 80031A6C 6C232426 */  addiu      $a0, $s1, 0x236C
    /* 22270 80031A70 3F6E000C */  jal        ___10tMenuBlank
    /* 22274 80031A74 02000524 */   addiu     $a1, $zero, 0x2
    /* 22278 80031A78 E8222426 */  addiu      $a0, $s1, 0x22E8
    /* 2227C 80031A7C B16E000C */  jal        ___12tMenuOptions
    /* 22280 80031A80 02000524 */   addiu     $a1, $zero, 0x2
    /* 22284 80031A84 64222426 */  addiu      $a0, $s1, 0x2264
    /* 22288 80031A88 B16E000C */  jal        ___12tMenuOptions
    /* 2228C 80031A8C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22290 80031A90 E0212426 */  addiu      $a0, $s1, 0x21E0
    /* 22294 80031A94 B16E000C */  jal        ___12tMenuOptions
    /* 22298 80031A98 02000524 */   addiu     $a1, $zero, 0x2
    /* 2229C 80031A9C 5C212426 */  addiu      $a0, $s1, 0x215C
    /* 222A0 80031AA0 B16E000C */  jal        ___12tMenuOptions
    /* 222A4 80031AA4 02000524 */   addiu     $a1, $zero, 0x2
    /* 222A8 80031AA8 D8202426 */  addiu      $a0, $s1, 0x20D8
    /* 222AC 80031AAC B16E000C */  jal        ___12tMenuOptions
    /* 222B0 80031AB0 02000524 */   addiu     $a1, $zero, 0x2
    /* 222B4 80031AB4 B8202426 */  addiu      $a0, $s1, 0x20B8
    /* 222B8 80031AB8 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222BC 80031ABC 02000524 */   addiu     $a1, $zero, 0x2
    /* 222C0 80031AC0 98202426 */  addiu      $a0, $s1, 0x2098
    /* 222C4 80031AC4 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222C8 80031AC8 02000524 */   addiu     $a1, $zero, 0x2
    /* 222CC 80031ACC 78202426 */  addiu      $a0, $s1, 0x2078
    /* 222D0 80031AD0 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222D4 80031AD4 02000524 */   addiu     $a1, $zero, 0x2
    /* 222D8 80031AD8 58202426 */  addiu      $a0, $s1, 0x2058
    /* 222DC 80031ADC 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222E0 80031AE0 02000524 */   addiu     $a1, $zero, 0x2
    /* 222E4 80031AE4 38202426 */  addiu      $a0, $s1, 0x2038
    /* 222E8 80031AE8 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222EC 80031AEC 02000524 */   addiu     $a1, $zero, 0x2
    /* 222F0 80031AF0 18202426 */  addiu      $a0, $s1, 0x2018
    /* 222F4 80031AF4 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 222F8 80031AF8 02000524 */   addiu     $a1, $zero, 0x2
    /* 222FC 80031AFC F81F2426 */  addiu      $a0, $s1, 0x1FF8
    /* 22300 80031B00 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22304 80031B04 02000524 */   addiu     $a1, $zero, 0x2
    /* 22308 80031B08 E81F2426 */  addiu      $a0, $s1, 0x1FE8
    /* 2230C 80031B0C 7D8F000C */  jal        ___13tListIterator
    /* 22310 80031B10 02000524 */   addiu     $a1, $zero, 0x2
    /* 22314 80031B14 D81F2426 */  addiu      $a0, $s1, 0x1FD8
    /* 22318 80031B18 7D8F000C */  jal        ___13tListIterator
    /* 2231C 80031B1C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22320 80031B20 C41F2426 */  addiu      $a0, $s1, 0x1FC4
    /* 22324 80031B24 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22328 80031B28 02000524 */   addiu     $a1, $zero, 0x2
    /* 2232C 80031B2C B01F2426 */  addiu      $a0, $s1, 0x1FB0
    /* 22330 80031B30 E98F000C */  jal        ___20tListIteratorIndexed
    /* 22334 80031B34 02000524 */   addiu     $a1, $zero, 0x2
    /* 22338 80031B38 341F2426 */  addiu      $a0, $s1, 0x1F34
    /* 2233C 80031B3C 566C000C */  jal        ___9tMenuNFS4
    /* 22340 80031B40 02000524 */   addiu     $a1, $zero, 0x2
    /* 22344 80031B44 081F2426 */  addiu      $a0, $s1, 0x1F08
    /* 22348 80031B48 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2234C 80031B4C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22350 80031B50 DC1E2426 */  addiu      $a0, $s1, 0x1EDC
    /* 22354 80031B54 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22358 80031B58 02000524 */   addiu     $a1, $zero, 0x2
    /* 2235C 80031B5C B01E2426 */  addiu      $a0, $s1, 0x1EB0
    /* 22360 80031B60 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22364 80031B64 02000524 */   addiu     $a1, $zero, 0x2
    /* 22368 80031B68 341E2426 */  addiu      $a0, $s1, 0x1E34
    /* 2236C 80031B6C 566C000C */  jal        ___9tMenuNFS4
    /* 22370 80031B70 02000524 */   addiu     $a1, $zero, 0x2
    /* 22374 80031B74 081E2426 */  addiu      $a0, $s1, 0x1E08
    /* 22378 80031B78 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2237C 80031B7C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22380 80031B80 E01D2426 */  addiu      $a0, $s1, 0x1DE0
    /* 22384 80031B84 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22388 80031B88 02000524 */   addiu     $a1, $zero, 0x2
    /* 2238C 80031B8C C41D2426 */  addiu      $a0, $s1, 0x1DC4
    /* 22390 80031B90 4A5E000C */  jal        ___16tListIteratorCar
    /* 22394 80031B94 02000524 */   addiu     $a1, $zero, 0x2
    /* 22398 80031B98 481D2426 */  addiu      $a0, $s1, 0x1D48
    /* 2239C 80031B9C 566C000C */  jal        ___9tMenuNFS4
    /* 223A0 80031BA0 02000524 */   addiu     $a1, $zero, 0x2
    /* 223A4 80031BA4 1C1D2426 */  addiu      $a0, $s1, 0x1D1C
    /* 223A8 80031BA8 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 223AC 80031BAC 02000524 */   addiu     $a1, $zero, 0x2
    /* 223B0 80031BB0 F01C2426 */  addiu      $a0, $s1, 0x1CF0
    /* 223B4 80031BB4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 223B8 80031BB8 02000524 */   addiu     $a1, $zero, 0x2
    /* 223BC 80031BBC C81C2426 */  addiu      $a0, $s1, 0x1CC8
    /* 223C0 80031BC0 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 223C4 80031BC4 02000524 */   addiu     $a1, $zero, 0x2
    /* 223C8 80031BC8 A01C2426 */  addiu      $a0, $s1, 0x1CA0
    /* 223CC 80031BCC 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 223D0 80031BD0 02000524 */   addiu     $a1, $zero, 0x2
    /* 223D4 80031BD4 801C2426 */  addiu      $a0, $s1, 0x1C80
    /* 223D8 80031BD8 4861000C */  jal        ___21tListIteratorCarColor
    /* 223DC 80031BDC 02000524 */   addiu     $a1, $zero, 0x2
    /* 223E0 80031BE0 641C2426 */  addiu      $a0, $s1, 0x1C64
    /* 223E4 80031BE4 4A5E000C */  jal        ___16tListIteratorCar
    /* 223E8 80031BE8 02000524 */   addiu     $a1, $zero, 0x2
    /* 223EC 80031BEC E81B2426 */  addiu      $a0, $s1, 0x1BE8
    /* 223F0 80031BF0 566C000C */  jal        ___9tMenuNFS4
    /* 223F4 80031BF4 02000524 */   addiu     $a1, $zero, 0x2
    /* 223F8 80031BF8 BC1B2426 */  addiu      $a0, $s1, 0x1BBC
    /* 223FC 80031BFC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22400 80031C00 02000524 */   addiu     $a1, $zero, 0x2
    /* 22404 80031C04 901B2426 */  addiu      $a0, $s1, 0x1B90
    /* 22408 80031C08 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2240C 80031C0C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22410 80031C10 141B2426 */  addiu      $a0, $s1, 0x1B14
    /* 22414 80031C14 AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 22418 80031C18 02000524 */   addiu     $a1, $zero, 0x2
    /* 2241C 80031C1C EC1A2426 */  addiu      $a0, $s1, 0x1AEC
    /* 22420 80031C20 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22424 80031C24 02000524 */   addiu     $a1, $zero, 0x2
    /* 22428 80031C28 C01A2426 */  addiu      $a0, $s1, 0x1AC0
    /* 2242C 80031C2C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22430 80031C30 02000524 */   addiu     $a1, $zero, 0x2
    /* 22434 80031C34 441A2426 */  addiu      $a0, $s1, 0x1A44
    /* 22438 80031C38 AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 2243C 80031C3C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22440 80031C40 1C1A2426 */  addiu      $a0, $s1, 0x1A1C
    /* 22444 80031C44 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22448 80031C48 02000524 */   addiu     $a1, $zero, 0x2
    /* 2244C 80031C4C F0192426 */  addiu      $a0, $s1, 0x19F0
    /* 22450 80031C50 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22454 80031C54 02000524 */   addiu     $a1, $zero, 0x2
    /* 22458 80031C58 D4192426 */  addiu      $a0, $s1, 0x19D4
    /* 2245C 80031C5C 4A5E000C */  jal        ___16tListIteratorCar
    /* 22460 80031C60 02000524 */   addiu     $a1, $zero, 0x2
    /* 22464 80031C64 58192426 */  addiu      $a0, $s1, 0x1958
    /* 22468 80031C68 AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 2246C 80031C6C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22470 80031C70 30192426 */  addiu      $a0, $s1, 0x1930
    /* 22474 80031C74 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22478 80031C78 02000524 */   addiu     $a1, $zero, 0x2
    /* 2247C 80031C7C 04192426 */  addiu      $a0, $s1, 0x1904
    /* 22480 80031C80 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22484 80031C84 02000524 */   addiu     $a1, $zero, 0x2
    /* 22488 80031C88 88182426 */  addiu      $a0, $s1, 0x1888
    /* 2248C 80031C8C AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 22490 80031C90 02000524 */   addiu     $a1, $zero, 0x2
    /* 22494 80031C94 60182426 */  addiu      $a0, $s1, 0x1860
    /* 22498 80031C98 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 2249C 80031C9C 02000524 */   addiu     $a1, $zero, 0x2
    /* 224A0 80031CA0 34182426 */  addiu      $a0, $s1, 0x1834
    /* 224A4 80031CA4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 224A8 80031CA8 02000524 */   addiu     $a1, $zero, 0x2
    /* 224AC 80031CAC B8172426 */  addiu      $a0, $s1, 0x17B8
    /* 224B0 80031CB0 AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 224B4 80031CB4 02000524 */   addiu     $a1, $zero, 0x2
    /* 224B8 80031CB8 90172426 */  addiu      $a0, $s1, 0x1790
    /* 224BC 80031CBC 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 224C0 80031CC0 02000524 */   addiu     $a1, $zero, 0x2
    /* 224C4 80031CC4 68172426 */  addiu      $a0, $s1, 0x1768
    /* 224C8 80031CC8 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 224CC 80031CCC 02000524 */   addiu     $a1, $zero, 0x2
    /* 224D0 80031CD0 3C172426 */  addiu      $a0, $s1, 0x173C
    /* 224D4 80031CD4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 224D8 80031CD8 02000524 */   addiu     $a1, $zero, 0x2
    /* 224DC 80031CDC C0162426 */  addiu      $a0, $s1, 0x16C0
    /* 224E0 80031CE0 AA6D000C */  jal        ___18tMenuNFS4TwoPlayer
    /* 224E4 80031CE4 02000524 */   addiu     $a1, $zero, 0x2
    /* 224E8 80031CE8 98162426 */  addiu      $a0, $s1, 0x1698
    /* 224EC 80031CEC 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 224F0 80031CF0 02000524 */   addiu     $a1, $zero, 0x2
    /* 224F4 80031CF4 70162426 */  addiu      $a0, $s1, 0x1670
    /* 224F8 80031CF8 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 224FC 80031CFC 02000524 */   addiu     $a1, $zero, 0x2
    /* 22500 80031D00 44162426 */  addiu      $a0, $s1, 0x1644
    /* 22504 80031D04 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22508 80031D08 02000524 */   addiu     $a1, $zero, 0x2
    /* 2250C 80031D0C C8152426 */  addiu      $a0, $s1, 0x15C8
    /* 22510 80031D10 566C000C */  jal        ___9tMenuNFS4
    /* 22514 80031D14 02000524 */   addiu     $a1, $zero, 0x2
    /* 22518 80031D18 4C152426 */  addiu      $a0, $s1, 0x154C
    /* 2251C 80031D1C 566C000C */  jal        ___9tMenuNFS4
    /* 22520 80031D20 02000524 */   addiu     $a1, $zero, 0x2
    /* 22524 80031D24 24152426 */  addiu      $a0, $s1, 0x1524
    /* 22528 80031D28 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 2252C 80031D2C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22530 80031D30 F8142426 */  addiu      $a0, $s1, 0x14F8
    /* 22534 80031D34 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22538 80031D38 02000524 */   addiu     $a1, $zero, 0x2
    /* 2253C 80031D3C D0142426 */  addiu      $a0, $s1, 0x14D0
    /* 22540 80031D40 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22544 80031D44 02000524 */   addiu     $a1, $zero, 0x2
    /* 22548 80031D48 A8142426 */  addiu      $a0, $s1, 0x14A8
    /* 2254C 80031D4C 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22550 80031D50 02000524 */   addiu     $a1, $zero, 0x2
    /* 22554 80031D54 7C142426 */  addiu      $a0, $s1, 0x147C
    /* 22558 80031D58 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2255C 80031D5C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22560 80031D60 60142426 */  addiu      $a0, $s1, 0x1460
    /* 22564 80031D64 4A5E000C */  jal        ___16tListIteratorCar
    /* 22568 80031D68 02000524 */   addiu     $a1, $zero, 0x2
    /* 2256C 80031D6C E4132426 */  addiu      $a0, $s1, 0x13E4
    /* 22570 80031D70 566C000C */  jal        ___9tMenuNFS4
    /* 22574 80031D74 02000524 */   addiu     $a1, $zero, 0x2
    /* 22578 80031D78 68132426 */  addiu      $a0, $s1, 0x1368
    /* 2257C 80031D7C 566C000C */  jal        ___9tMenuNFS4
    /* 22580 80031D80 02000524 */   addiu     $a1, $zero, 0x2
    /* 22584 80031D84 3C132426 */  addiu      $a0, $s1, 0x133C
    /* 22588 80031D88 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2258C 80031D8C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22590 80031D90 10132426 */  addiu      $a0, $s1, 0x1310
    /* 22594 80031D94 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22598 80031D98 02000524 */   addiu     $a1, $zero, 0x2
    /* 2259C 80031D9C E8122426 */  addiu      $a0, $s1, 0x12E8
    /* 225A0 80031DA0 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 225A4 80031DA4 02000524 */   addiu     $a1, $zero, 0x2
    /* 225A8 80031DA8 CC122426 */  addiu      $a0, $s1, 0x12CC
    /* 225AC 80031DAC 4A5E000C */  jal        ___16tListIteratorCar
    /* 225B0 80031DB0 02000524 */   addiu     $a1, $zero, 0x2
    /* 225B4 80031DB4 50122426 */  addiu      $a0, $s1, 0x1250
    /* 225B8 80031DB8 566C000C */  jal        ___9tMenuNFS4
    /* 225BC 80031DBC 02000524 */   addiu     $a1, $zero, 0x2
    /* 225C0 80031DC0 24122426 */  addiu      $a0, $s1, 0x1224
    /* 225C4 80031DC4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 225C8 80031DC8 02000524 */   addiu     $a1, $zero, 0x2
    /* 225CC 80031DCC FC112426 */  addiu      $a0, $s1, 0x11FC
    /* 225D0 80031DD0 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 225D4 80031DD4 02000524 */   addiu     $a1, $zero, 0x2
    /* 225D8 80031DD8 D4112426 */  addiu      $a0, $s1, 0x11D4
    /* 225DC 80031DDC 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 225E0 80031DE0 02000524 */   addiu     $a1, $zero, 0x2
    /* 225E4 80031DE4 A8112426 */  addiu      $a0, $s1, 0x11A8
    /* 225E8 80031DE8 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 225EC 80031DEC 02000524 */   addiu     $a1, $zero, 0x2
    /* 225F0 80031DF0 88112426 */  addiu      $a0, $s1, 0x1188
    /* 225F4 80031DF4 4861000C */  jal        ___21tListIteratorCarColor
    /* 225F8 80031DF8 02000524 */   addiu     $a1, $zero, 0x2
    /* 225FC 80031DFC 6C112426 */  addiu      $a0, $s1, 0x116C
    /* 22600 80031E00 4A5E000C */  jal        ___16tListIteratorCar
    /* 22604 80031E04 02000524 */   addiu     $a1, $zero, 0x2
    /* 22608 80031E08 F0102426 */  addiu      $a0, $s1, 0x10F0
    /* 2260C 80031E0C 566C000C */  jal        ___9tMenuNFS4
    /* 22610 80031E10 02000524 */   addiu     $a1, $zero, 0x2
    /* 22614 80031E14 C4102426 */  addiu      $a0, $s1, 0x10C4
    /* 22618 80031E18 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2261C 80031E1C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22620 80031E20 44102426 */  addiu      $a0, $s1, 0x1044
    /* 22624 80031E24 5171000C */  jal        ___12tOptionsMenu
    /* 22628 80031E28 02000524 */   addiu     $a1, $zero, 0x2
    /* 2262C 80031E2C 18102426 */  addiu      $a0, $s1, 0x1018
    /* 22630 80031E30 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22634 80031E34 02000524 */   addiu     $a1, $zero, 0x2
    /* 22638 80031E38 940F2426 */  addiu      $a0, $s1, 0xF94
    /* 2263C 80031E3C B16E000C */  jal        ___12tMenuOptions
    /* 22640 80031E40 02000524 */   addiu     $a1, $zero, 0x2
    /* 22644 80031E44 700F2426 */  addiu      $a0, $s1, 0xF70
    /* 22648 80031E48 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 2264C 80031E4C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22650 80031E50 4C0F2426 */  addiu      $a0, $s1, 0xF4C
    /* 22654 80031E54 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22658 80031E58 02000524 */   addiu     $a1, $zero, 0x2
    /* 2265C 80031E5C 280F2426 */  addiu      $a0, $s1, 0xF28
    /* 22660 80031E60 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22664 80031E64 02000524 */   addiu     $a1, $zero, 0x2
    /* 22668 80031E68 040F2426 */  addiu      $a0, $s1, 0xF04
    /* 2266C 80031E6C 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22670 80031E70 02000524 */   addiu     $a1, $zero, 0x2
    /* 22674 80031E74 E00E2426 */  addiu      $a0, $s1, 0xEE0
    /* 22678 80031E78 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 2267C 80031E7C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22680 80031E80 C00E2426 */  addiu      $a0, $s1, 0xEC0
    /* 22684 80031E84 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22688 80031E88 02000524 */   addiu     $a1, $zero, 0x2
    /* 2268C 80031E8C A00E2426 */  addiu      $a0, $s1, 0xEA0
    /* 22690 80031E90 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 22694 80031E94 02000524 */   addiu     $a1, $zero, 0x2
    /* 22698 80031E98 900E2426 */  addiu      $a0, $s1, 0xE90
    /* 2269C 80031E9C 7D8F000C */  jal        ___13tListIterator
    /* 226A0 80031EA0 02000524 */   addiu     $a1, $zero, 0x2
    /* 226A4 80031EA4 7C0E2426 */  addiu      $a0, $s1, 0xE7C
    /* 226A8 80031EA8 E98F000C */  jal        ___20tListIteratorIndexed
    /* 226AC 80031EAC 02000524 */   addiu     $a1, $zero, 0x2
    /* 226B0 80031EB0 680E2426 */  addiu      $a0, $s1, 0xE68
    /* 226B4 80031EB4 E98F000C */  jal        ___20tListIteratorIndexed
    /* 226B8 80031EB8 02000524 */   addiu     $a1, $zero, 0x2
    /* 226BC 80031EBC 540E2426 */  addiu      $a0, $s1, 0xE54
    /* 226C0 80031EC0 E98F000C */  jal        ___20tListIteratorIndexed
    /* 226C4 80031EC4 02000524 */   addiu     $a1, $zero, 0x2
    /* 226C8 80031EC8 400E2426 */  addiu      $a0, $s1, 0xE40
    /* 226CC 80031ECC E98F000C */  jal        ___20tListIteratorIndexed
    /* 226D0 80031ED0 02000524 */   addiu     $a1, $zero, 0x2
    /* 226D4 80031ED4 2C0E2426 */  addiu      $a0, $s1, 0xE2C
    /* 226D8 80031ED8 E98F000C */  jal        ___20tListIteratorIndexed
    /* 226DC 80031EDC 02000524 */   addiu     $a1, $zero, 0x2
    /* 226E0 80031EE0 180E2426 */  addiu      $a0, $s1, 0xE18
    /* 226E4 80031EE4 E98F000C */  jal        ___20tListIteratorIndexed
    /* 226E8 80031EE8 02000524 */   addiu     $a1, $zero, 0x2
    /* 226EC 80031EEC 9C0D2426 */  addiu      $a0, $s1, 0xD9C
    /* 226F0 80031EF0 566C000C */  jal        ___9tMenuNFS4
    /* 226F4 80031EF4 02000524 */   addiu     $a1, $zero, 0x2
    /* 226F8 80031EF8 200D2426 */  addiu      $a0, $s1, 0xD20
    /* 226FC 80031EFC 566C000C */  jal        ___9tMenuNFS4
    /* 22700 80031F00 02000524 */   addiu     $a1, $zero, 0x2
    /* 22704 80031F04 F40C2426 */  addiu      $a0, $s1, 0xCF4
    /* 22708 80031F08 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2270C 80031F0C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22710 80031F10 CC0C2426 */  addiu      $a0, $s1, 0xCCC
    /* 22714 80031F14 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22718 80031F18 02000524 */   addiu     $a1, $zero, 0x2
    /* 2271C 80031F1C A00C2426 */  addiu      $a0, $s1, 0xCA0
    /* 22720 80031F20 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22724 80031F24 02000524 */   addiu     $a1, $zero, 0x2
    /* 22728 80031F28 880C2426 */  addiu      $a0, $s1, 0xC88
    /* 2272C 80031F2C 6B87000C */  jal        ___18tListIteratorTrack
    /* 22730 80031F30 02000524 */   addiu     $a1, $zero, 0x2
    /* 22734 80031F34 0C0C2426 */  addiu      $a0, $s1, 0xC0C
    /* 22738 80031F38 566C000C */  jal        ___9tMenuNFS4
    /* 2273C 80031F3C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22740 80031F40 900B2426 */  addiu      $a0, $s1, 0xB90
    /* 22744 80031F44 566C000C */  jal        ___9tMenuNFS4
    /* 22748 80031F48 02000524 */   addiu     $a1, $zero, 0x2
    /* 2274C 80031F4C 680B2426 */  addiu      $a0, $s1, 0xB68
    /* 22750 80031F50 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22754 80031F54 02000524 */   addiu     $a1, $zero, 0x2
    /* 22758 80031F58 400B2426 */  addiu      $a0, $s1, 0xB40
    /* 2275C 80031F5C 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22760 80031F60 02000524 */   addiu     $a1, $zero, 0x2
    /* 22764 80031F64 180B2426 */  addiu      $a0, $s1, 0xB18
    /* 22768 80031F68 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 2276C 80031F6C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22770 80031F70 F00A2426 */  addiu      $a0, $s1, 0xAF0
    /* 22774 80031F74 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22778 80031F78 02000524 */   addiu     $a1, $zero, 0x2
    /* 2277C 80031F7C C80A2426 */  addiu      $a0, $s1, 0xAC8
    /* 22780 80031F80 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22784 80031F84 02000524 */   addiu     $a1, $zero, 0x2
    /* 22788 80031F88 9C0A2426 */  addiu      $a0, $s1, 0xA9C
    /* 2278C 80031F8C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22790 80031F90 02000524 */   addiu     $a1, $zero, 0x2
    /* 22794 80031F94 200A2426 */  addiu      $a0, $s1, 0xA20
    /* 22798 80031F98 566C000C */  jal        ___9tMenuNFS4
    /* 2279C 80031F9C 02000524 */   addiu     $a1, $zero, 0x2
    /* 227A0 80031FA0 F4092426 */  addiu      $a0, $s1, 0x9F4
    /* 227A4 80031FA4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227A8 80031FA8 02000524 */   addiu     $a1, $zero, 0x2
    /* 227AC 80031FAC C8092426 */  addiu      $a0, $s1, 0x9C8
    /* 227B0 80031FB0 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227B4 80031FB4 02000524 */   addiu     $a1, $zero, 0x2
    /* 227B8 80031FB8 9C092426 */  addiu      $a0, $s1, 0x99C
    /* 227BC 80031FBC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227C0 80031FC0 02000524 */   addiu     $a1, $zero, 0x2
    /* 227C4 80031FC4 20092426 */  addiu      $a0, $s1, 0x920
    /* 227C8 80031FC8 566C000C */  jal        ___9tMenuNFS4
    /* 227CC 80031FCC 02000524 */   addiu     $a1, $zero, 0x2
    /* 227D0 80031FD0 F4082426 */  addiu      $a0, $s1, 0x8F4
    /* 227D4 80031FD4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227D8 80031FD8 02000524 */   addiu     $a1, $zero, 0x2
    /* 227DC 80031FDC C8082426 */  addiu      $a0, $s1, 0x8C8
    /* 227E0 80031FE0 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227E4 80031FE4 02000524 */   addiu     $a1, $zero, 0x2
    /* 227E8 80031FE8 9C082426 */  addiu      $a0, $s1, 0x89C
    /* 227EC 80031FEC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227F0 80031FF0 02000524 */   addiu     $a1, $zero, 0x2
    /* 227F4 80031FF4 70082426 */  addiu      $a0, $s1, 0x870
    /* 227F8 80031FF8 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 227FC 80031FFC 02000524 */   addiu     $a1, $zero, 0x2
    /* 22800 80032000 F4072426 */  addiu      $a0, $s1, 0x7F4
    /* 22804 80032004 566C000C */  jal        ___9tMenuNFS4
    /* 22808 80032008 02000524 */   addiu     $a1, $zero, 0x2
    /* 2280C 8003200C CC072426 */  addiu      $a0, $s1, 0x7CC
    /* 22810 80032010 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22814 80032014 02000524 */   addiu     $a1, $zero, 0x2
    /* 22818 80032018 A0072426 */  addiu      $a0, $s1, 0x7A0
    /* 2281C 8003201C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22820 80032020 02000524 */   addiu     $a1, $zero, 0x2
    /* 22824 80032024 8C072426 */  addiu      $a0, $s1, 0x78C
    /* 22828 80032028 7BCF000C */  jal        ___23tListIteratorTournament
    /* 2282C 8003202C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22830 80032030 10072426 */  addiu      $a0, $s1, 0x710
    /* 22834 80032034 566C000C */  jal        ___9tMenuNFS4
    /* 22838 80032038 02000524 */   addiu     $a1, $zero, 0x2
    /* 2283C 8003203C E8062426 */  addiu      $a0, $s1, 0x6E8
    /* 22840 80032040 286A000C */  jal        ___28tMenuItemNFS4LeftRightChoice
    /* 22844 80032044 02000524 */   addiu     $a1, $zero, 0x2
    /* 22848 80032048 BC062426 */  addiu      $a0, $s1, 0x6BC
    /* 2284C 8003204C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22850 80032050 02000524 */   addiu     $a1, $zero, 0x2
    /* 22854 80032054 A8062426 */  addiu      $a0, $s1, 0x6A8
    /* 22858 80032058 7BCF000C */  jal        ___23tListIteratorTournament
    /* 2285C 8003205C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22860 80032060 2C062426 */  addiu      $a0, $s1, 0x62C
    /* 22864 80032064 566C000C */  jal        ___9tMenuNFS4
    /* 22868 80032068 02000524 */   addiu     $a1, $zero, 0x2
    /* 2286C 8003206C 00062426 */  addiu      $a0, $s1, 0x600
    /* 22870 80032070 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22874 80032074 02000524 */   addiu     $a1, $zero, 0x2
    /* 22878 80032078 D4052426 */  addiu      $a0, $s1, 0x5D4
    /* 2287C 8003207C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22880 80032080 02000524 */   addiu     $a1, $zero, 0x2
    /* 22884 80032084 58052426 */  addiu      $a0, $s1, 0x558
    /* 22888 80032088 566C000C */  jal        ___9tMenuNFS4
    /* 2288C 8003208C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22890 80032090 2C052426 */  addiu      $a0, $s1, 0x52C
    /* 22894 80032094 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22898 80032098 02000524 */   addiu     $a1, $zero, 0x2
    /* 2289C 8003209C 00052426 */  addiu      $a0, $s1, 0x500
    /* 228A0 800320A0 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228A4 800320A4 02000524 */   addiu     $a1, $zero, 0x2
    /* 228A8 800320A8 D4042426 */  addiu      $a0, $s1, 0x4D4
    /* 228AC 800320AC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228B0 800320B0 02000524 */   addiu     $a1, $zero, 0x2
    /* 228B4 800320B4 58042426 */  addiu      $a0, $s1, 0x458
    /* 228B8 800320B8 566C000C */  jal        ___9tMenuNFS4
    /* 228BC 800320BC 02000524 */   addiu     $a1, $zero, 0x2
    /* 228C0 800320C0 2C042426 */  addiu      $a0, $s1, 0x42C
    /* 228C4 800320C4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228C8 800320C8 02000524 */   addiu     $a1, $zero, 0x2
    /* 228CC 800320CC 00042426 */  addiu      $a0, $s1, 0x400
    /* 228D0 800320D0 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228D4 800320D4 02000524 */   addiu     $a1, $zero, 0x2
    /* 228D8 800320D8 D4032426 */  addiu      $a0, $s1, 0x3D4
    /* 228DC 800320DC 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228E0 800320E0 02000524 */   addiu     $a1, $zero, 0x2
    /* 228E4 800320E4 A8032426 */  addiu      $a0, $s1, 0x3A8
    /* 228E8 800320E8 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228EC 800320EC 02000524 */   addiu     $a1, $zero, 0x2
    /* 228F0 800320F0 7C032426 */  addiu      $a0, $s1, 0x37C
    /* 228F4 800320F4 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 228F8 800320F8 02000524 */   addiu     $a1, $zero, 0x2
    /* 228FC 800320FC 00032426 */  addiu      $a0, $s1, 0x300
    /* 22900 80032100 566C000C */  jal        ___9tMenuNFS4
    /* 22904 80032104 02000524 */   addiu     $a1, $zero, 0x2
    /* 22908 80032108 D4022426 */  addiu      $a0, $s1, 0x2D4
    /* 2290C 8003210C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22910 80032110 02000524 */   addiu     $a1, $zero, 0x2
    /* 22914 80032114 A8022426 */  addiu      $a0, $s1, 0x2A8
    /* 22918 80032118 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2291C 8003211C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22920 80032120 7C022426 */  addiu      $a0, $s1, 0x27C
    /* 22924 80032124 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22928 80032128 02000524 */   addiu     $a1, $zero, 0x2
    /* 2292C 8003212C 00022426 */  addiu      $a0, $s1, 0x200
    /* 22930 80032130 3F6E000C */  jal        ___10tMenuBlank
    /* 22934 80032134 02000524 */   addiu     $a1, $zero, 0x2
    /* 22938 80032138 84012426 */  addiu      $a0, $s1, 0x184
    /* 2293C 8003213C 566C000C */  jal        ___9tMenuNFS4
    /* 22940 80032140 02000524 */   addiu     $a1, $zero, 0x2
    /* 22944 80032144 58012426 */  addiu      $a0, $s1, 0x158
    /* 22948 80032148 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2294C 8003214C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22950 80032150 2C012426 */  addiu      $a0, $s1, 0x12C
    /* 22954 80032154 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22958 80032158 02000524 */   addiu     $a1, $zero, 0x2
    /* 2295C 8003215C B0002426 */  addiu      $a0, $s1, 0xB0
    /* 22960 80032160 566C000C */  jal        ___9tMenuNFS4
    /* 22964 80032164 02000524 */   addiu     $a1, $zero, 0x2
    /* 22968 80032168 84002426 */  addiu      $a0, $s1, 0x84
    /* 2296C 8003216C 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22970 80032170 02000524 */   addiu     $a1, $zero, 0x2
    /* 22974 80032174 58002426 */  addiu      $a0, $s1, 0x58
    /* 22978 80032178 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 2297C 8003217C 02000524 */   addiu     $a1, $zero, 0x2
    /* 22980 80032180 2C002426 */  addiu      $a0, $s1, 0x2C
    /* 22984 80032184 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22988 80032188 02000524 */   addiu     $a1, $zero, 0x2
    /* 2298C 8003218C 21202002 */  addu       $a0, $s1, $zero
    /* 22990 80032190 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 22994 80032194 02000524 */   addiu     $a1, $zero, 0x2
    /* 22998 80032198 01001032 */  andi       $s0, $s0, 0x1
    /* 2299C 8003219C 03000012 */  beqz       $s0, .L800321AC
    /* 229A0 800321A0 00000000 */   nop
    /* 229A4 800321A4 6B8F020C */  jal        __builtin_delete
    /* 229A8 800321A8 21202002 */   addu      $a0, $s1, $zero
  .L800321AC:
    /* 229AC 800321AC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 229B0 800321B0 1400B18F */  lw         $s1, 0x14($sp)
    /* 229B4 800321B4 1000B08F */  lw         $s0, 0x10($sp)
    /* 229B8 800321B8 0800E003 */  jr         $ra
    /* 229BC 800321BC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___15tGlobalMenuDefs
