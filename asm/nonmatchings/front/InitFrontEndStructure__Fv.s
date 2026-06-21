.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitFrontEndStructure__Fv, 0x2F8

glabel InitFrontEndStructure__Fv
    /* 17E48 80027648 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 17E4C 8002764C 2400B3AF */  sw         $s3, 0x24($sp)
    /* 17E50 80027650 21980000 */  addu       $s3, $zero, $zero
    /* 17E54 80027654 1180033C */  lui        $v1, %hi(frontEnd)
    /* 17E58 80027658 00466224 */  addiu      $v0, $v1, %lo(frontEnd)
    /* 17E5C 8002765C 21204000 */  addu       $a0, $v0, $zero
    /* 17E60 80027660 01000224 */  addiu      $v0, $zero, 0x1
    /* 17E64 80027664 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 17E68 80027668 3800BEAF */  sw         $fp, 0x38($sp)
    /* 17E6C 8002766C 3400B7AF */  sw         $s7, 0x34($sp)
    /* 17E70 80027670 3000B6AF */  sw         $s6, 0x30($sp)
    /* 17E74 80027674 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 17E78 80027678 2800B4AF */  sw         $s4, 0x28($sp)
    /* 17E7C 8002767C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 17E80 80027680 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 17E84 80027684 1800B0AF */  sw         $s0, 0x18($sp)
    /* 17E88 80027688 004660A4 */  sh         $zero, %lo(frontEnd)($v1)
    /* 17E8C 8002768C 070082A0 */  sb         $v0, 0x7($a0)
    /* 17E90 80027690 14000224 */  addiu      $v0, $zero, 0x14
    /* 17E94 80027694 020080A0 */  sb         $zero, 0x2($a0)
    /* 17E98 80027698 540080A4 */  sh         $zero, 0x54($a0)
    /* 17E9C 8002769C 560080A4 */  sh         $zero, 0x56($a0)
    /* 17EA0 800276A0 580080A4 */  sh         $zero, 0x58($a0)
    /* 17EA4 800276A4 030080A0 */  sb         $zero, 0x3($a0)
    /* 17EA8 800276A8 040080A0 */  sb         $zero, 0x4($a0)
    /* 17EAC 800276AC 060080A0 */  sb         $zero, 0x6($a0)
    /* 17EB0 800276B0 940382A0 */  sb         $v0, 0x394($a0)
    /* 17EB4 800276B4 21106402 */  addu       $v0, $s3, $a0
  .L800276B8:
    /* 17EB8 800276B8 01007326 */  addiu      $s3, $s3, 0x1
    /* 17EBC 800276BC 230040A0 */  sb         $zero, 0x23($v0)
    /* 17EC0 800276C0 2D0040A0 */  sb         $zero, 0x2D($v0)
    /* 17EC4 800276C4 370040A0 */  sb         $zero, 0x37($v0)
    /* 17EC8 800276C8 320040A0 */  sb         $zero, 0x32($v0)
    /* 17ECC 800276CC 160040A0 */  sb         $zero, 0x16($v0)
    /* 17ED0 800276D0 1B0040A0 */  sb         $zero, 0x1B($v0)
    /* 17ED4 800276D4 3C0040A0 */  sb         $zero, 0x3C($v0)
    /* 17ED8 800276D8 410040A0 */  sb         $zero, 0x41($v0)
    /* 17EDC 800276DC 970340A0 */  sb         $zero, 0x397($v0)
    /* 17EE0 800276E0 5C0040A0 */  sb         $zero, 0x5C($v0)
    /* 17EE4 800276E4 0500622A */  slti       $v0, $s3, 0x5
    /* 17EE8 800276E8 F3FF4014 */  bnez       $v0, .L800276B8
    /* 17EEC 800276EC 21106402 */   addu      $v0, $s3, $a0
    /* 17EF0 800276F0 21980000 */  addu       $s3, $zero, $zero
    /* 17EF4 800276F4 01001624 */  addiu      $s6, $zero, 0x1
    /* 17EF8 800276F8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 17EFC 800276FC 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 17F00 80027700 21A84000 */  addu       $s5, $v0, $zero
    /* 17F04 80027704 21B8A002 */  addu       $s7, $s5, $zero
    /* 17F08 80027708 2188E002 */  addu       $s1, $s7, $zero
    /* 17F0C 8002770C 21F06002 */  addu       $fp, $s3, $zero
    /* 17F10 80027710 2190E002 */  addu       $s2, $s7, $zero
    /* 17F14 80027714 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17F18 80027718 2300A492 */  lbu        $a0, 0x23($s5)
    /* 17F1C 8002771C 2180C002 */  addu       $s0, $s6, $zero
    /* 17F20 80027720 2100A0A2 */  sb         $zero, 0x21($s5)
    /* 17F24 80027724 2200A0A2 */  sb         $zero, 0x22($s5)
    /* 17F28 80027728 2801A0A2 */  sb         $zero, 0x128($s5)
    /* 17F2C 8002772C 2901A0A2 */  sb         $zero, 0x129($s5)
    /* 17F30 80027730 1603B0A2 */  sb         $s0, 0x316($s5)
    /* 17F34 80027734 982B010C */  jal        Stattool_ReturnRecordLapTime__Fs
    /* 17F38 80027738 2C00A0A2 */   sb        $zero, 0x2C($s5)
    /* 17F3C 8002773C 2800A2AE */  sw         $v0, 0x28($s5)
    /* 17F40 80027740 0900B0A2 */  sb         $s0, 0x9($s5)
    /* 17F44 80027744 0A00B0A2 */  sb         $s0, 0xA($s5)
    /* 17F48 80027748 9603B0A2 */  sb         $s0, 0x396($s5)
    /* 17F4C 8002774C 2001A0A2 */  sb         $zero, 0x120($s5)
    /* 17F50 80027750 2101A0A2 */  sb         $zero, 0x121($s5)
    /* 17F54 80027754 2201A0A2 */  sb         $zero, 0x122($s5)
    /* 17F58 80027758 2701A0A2 */  sb         $zero, 0x127($s5)
    /* 17F5C 8002775C 2B01A0A2 */  sb         $zero, 0x12B($s5)
    /* 17F60 80027760 2C01A0A2 */  sb         $zero, 0x12C($s5)
    /* 17F64 80027764 1F03A0A2 */  sb         $zero, 0x31F($s5)
  .L80027768:
    /* 17F68 80027768 21800000 */  addu       $s0, $zero, $zero
    /* 17F6C 8002776C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 17F70 80027770 480456AE */  sw         $s6, 0x448($s2)
    /* 17F74 80027774 140320A2 */  sb         $zero, 0x314($s1)
    /* 17F78 80027778 5E0036A2 */  sb         $s6, 0x5E($s1)
    /* 17F7C 8002777C 200320A2 */  sb         $zero, 0x320($s1)
    /* 17F80 80027780 220336A2 */  sb         $s6, 0x322($s1)
    /* 17F84 80027784 240336A2 */  sb         $s6, 0x324($s1)
    /* 17F88 80027788 260336A2 */  sb         $s6, 0x326($s1)
    /* 17F8C 8002778C 280336A2 */  sb         $s6, 0x328($s1)
    /* 17F90 80027790 2A0336A2 */  sb         $s6, 0x32A($s1)
    /* 17F94 80027794 2C0336A2 */  sb         $s6, 0x32C($s1)
    /* 17F98 80027798 2E0320A2 */  sb         $zero, 0x32E($s1)
    /* 17F9C 8002779C 480020A2 */  sb         $zero, 0x48($s1)
    /* 17FA0 800277A0 4C0040AE */  sw         $zero, 0x4C($s2)
    /* 17FA4 800277A4 5A00A2A6 */  sh         $v0, 0x5A($s5)
    /* 17FA8 800277A8 03000224 */  addiu      $v0, $zero, 0x3
    /* 17FAC 800277AC 310342A2 */  sb         $v0, 0x331($s2)
    /* 17FB0 800277B0 06000224 */  addiu      $v0, $zero, 0x6
    /* 17FB4 800277B4 320342A2 */  sb         $v0, 0x332($s2)
    /* 17FB8 800277B8 07000224 */  addiu      $v0, $zero, 0x7
    /* 17FBC 800277BC 330342A2 */  sb         $v0, 0x333($s2)
    /* 17FC0 800277C0 C0101300 */  sll        $v0, $s3, 3
    /* 17FC4 800277C4 21105500 */  addu       $v0, $v0, $s5
    /* 17FC8 800277C8 300340A2 */  sb         $zero, 0x330($s2)
    /* 17FCC 800277CC 640340A0 */  sb         $zero, 0x364($v0)
    /* 17FD0 800277D0 21101E02 */  addu       $v0, $s0, $fp
  .L800277D4:
    /* 17FD4 800277D4 21105500 */  addu       $v0, $v0, $s5
    /* 17FD8 800277D8 380340A0 */  sb         $zero, 0x338($v0)
    /* 17FDC 800277DC 01001026 */  addiu      $s0, $s0, 0x1
    /* 17FE0 800277E0 0400022A */  slti       $v0, $s0, 0x4
    /* 17FE4 800277E4 FBFF4014 */  bnez       $v0, .L800277D4
    /* 17FE8 800277E8 21101E02 */   addu      $v0, $s0, $fp
    /* 17FEC 800277EC 1000B48F */  lw         $s4, 0x10($sp)
    /* 17FF0 800277F0 21800000 */  addu       $s0, $zero, $zero
    /* 17FF4 800277F4 170336A2 */  sb         $s6, 0x317($s1)
    /* 17FF8 800277F8 190336A2 */  sb         $s6, 0x319($s1)
    /* 17FFC 800277FC 1B0336A2 */  sb         $s6, 0x31B($s1)
    /* 18000 80027800 1180063C */  lui        $a2, %hi(carManager)
  .L80027804:
    /* 18004 80027804 7442C424 */  addiu      $a0, $a2, %lo(carManager)
    /* 18008 80027808 002C1000 */  sll        $a1, $s0, 16
    /* 1800C 8002780C 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 18010 80027810 032C0500 */   sra       $a1, $a1, 16
    /* 18014 80027814 21181402 */  addu       $v1, $s0, $s4
    /* 18018 80027818 01001026 */  addiu      $s0, $s0, 0x1
    /* 1801C 8002781C 04004290 */  lbu        $v0, 0x4($v0)
    /* 18020 80027820 21187500 */  addu       $v1, $v1, $s5
    /* 18024 80027824 600062A0 */  sb         $v0, 0x60($v1)
    /* 18028 80027828 3000022A */  slti       $v0, $s0, 0x30
    /* 1802C 8002782C F5FF4014 */  bnez       $v0, .L80027804
    /* 18030 80027830 1180063C */   lui       $a2, %hi(carManager)
    /* 18034 80027834 21206002 */  addu       $a0, $s3, $zero
    /* 18038 80027838 41000224 */  addiu      $v0, $zero, 0x41
    /* 1803C 8002783C 55001424 */  addiu      $s4, $zero, 0x55
    /* 18040 80027840 5E03E2A6 */  sh         $v0, 0x35E($s7)
    /* 18044 80027844 620320A2 */  sb         $zero, 0x362($s1)
    /* 18048 80027848 990336A2 */  sb         $s6, 0x399($s1)
    /* 1804C 8002784C 590334A2 */  sb         $s4, 0x359($s1)
    /* 18050 80027850 549C000C */  jal        Front_ResetPSXAnalogs__Fi
    /* 18054 80027854 5B0334A2 */   sb        $s4, 0x35B($s1)
    /* 18058 80027858 21206002 */  addu       $a0, $s3, $zero
    /* 1805C 8002785C 399C000C */  jal        Front_ResetPSXController__Fii
    /* 18060 80027860 21280000 */   addu      $a1, $zero, $zero
    /* 18064 80027864 01003126 */  addiu      $s1, $s1, 0x1
    /* 18068 80027868 0200F726 */  addiu      $s7, $s7, 0x2
    /* 1806C 8002786C 0400DE27 */  addiu      $fp, $fp, 0x4
    /* 18070 80027870 04005226 */  addiu      $s2, $s2, 0x4
    /* 18074 80027874 01007326 */  addiu      $s3, $s3, 0x1
    /* 18078 80027878 1000A68F */  lw         $a2, 0x10($sp)
    /* 1807C 8002787C 0200622A */  slti       $v0, $s3, 0x2
    /* 18080 80027880 3000C624 */  addiu      $a2, $a2, 0x30
    /* 18084 80027884 B8FF4014 */  bnez       $v0, .L80027768
    /* 18088 80027888 1000A6AF */   sw        $a2, 0x10($sp)
    /* 1808C 8002788C 21200000 */  addu       $a0, $zero, $zero
    /* 18090 80027890 1180103C */  lui        $s0, %hi(frontEnd)
    /* 18094 80027894 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 18098 80027898 279C000C */  jal        Front_ResetSettingsMenu__Fi
    /* 1809C 8002789C 950300A2 */   sb        $zero, 0x395($s0)
    /* 180A0 800278A0 279C000C */  jal        Front_ResetSettingsMenu__Fi
    /* 180A4 800278A4 01000424 */   addiu     $a0, $zero, 0x1
    /* 180A8 800278A8 1180043C */  lui        $a0, %hi(CreditManager)
    /* 180AC 800278AC 5C4D8424 */  addiu      $a0, $a0, %lo(CreditManager)
    /* 180B0 800278B0 01000224 */  addiu      $v0, $zero, 0x1
    /* 180B4 800278B4 1E0302A2 */  sb         $v0, 0x31E($s0)
    /* 180B8 800278B8 02000224 */  addiu      $v0, $zero, 0x2
    /* 180BC 800278BC 460302A2 */  sb         $v0, 0x346($s0)
    /* 180C0 800278C0 1480023C */  lui        $v0, %hi(gMasterMusicLevel)
    /* 180C4 800278C4 55000324 */  addiu      $v1, $zero, 0x55
    /* 180C8 800278C8 1D0300A2 */  sb         $zero, 0x31D($s0)
    /* 180CC 800278CC 400300A2 */  sb         $zero, 0x340($s0)
    /* 180D0 800278D0 410314A2 */  sb         $s4, 0x341($s0)
    /* 180D4 800278D4 420314A2 */  sb         $s4, 0x342($s0)
    /* 180D8 800278D8 430314A2 */  sb         $s4, 0x343($s0)
    /* 180DC 800278DC 440314A2 */  sb         $s4, 0x344($s0)
    /* 180E0 800278E0 450314A2 */  sb         $s4, 0x345($s0)
    /* 180E4 800278E4 470300A2 */  sb         $zero, 0x347($s0)
    /* 180E8 800278E8 50C643AC */  sw         $v1, %lo(gMasterMusicLevel)($v0)
    /* 180EC 800278EC 1480023C */  lui        $v0, %hi(gMasterSFXLevel)
    /* 180F0 800278F0 54C643AC */  sw         $v1, %lo(gMasterSFXLevel)($v0)
    /* 180F4 800278F4 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 180F8 800278F8 5CC643AC */  sw         $v1, %lo(gMasterFENarrationLevel)($v0)
    /* 180FC 800278FC 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 18100 80027900 60C643AC */  sw         $v1, %lo(gMasterAmbientLevel)($v0)
    /* 18104 80027904 480300A2 */  sb         $zero, 0x348($s0)
    /* 18108 80027908 BAD6000C */  jal        Setup__14tCreditManager
    /* 1810C 8002790C 440400AE */   sw        $zero, 0x444($s0)
    /* 18110 80027910 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 18114 80027914 3800BE8F */  lw         $fp, 0x38($sp)
    /* 18118 80027918 3400B78F */  lw         $s7, 0x34($sp)
    /* 1811C 8002791C 3000B68F */  lw         $s6, 0x30($sp)
    /* 18120 80027920 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 18124 80027924 2800B48F */  lw         $s4, 0x28($sp)
    /* 18128 80027928 2400B38F */  lw         $s3, 0x24($sp)
    /* 1812C 8002792C 2000B28F */  lw         $s2, 0x20($sp)
    /* 18130 80027930 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 18134 80027934 1800B08F */  lw         $s0, 0x18($sp)
    /* 18138 80027938 0800E003 */  jr         $ra
    /* 1813C 8002793C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel InitFrontEndStructure__Fv
