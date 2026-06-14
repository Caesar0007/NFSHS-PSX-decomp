.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Purge__Q26Speech13MobileSpeaker, 0x254

glabel Purge__Q26Speech13MobileSpeaker
    /* 89718 80098F18 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8971C 80098F1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 89720 80098F20 21888000 */  addu       $s1, $a0, $zero
    /* 89724 80098F24 1800BFAF */  sw         $ra, 0x18($sp)
    /* 89728 80098F28 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8972C 80098F2C 6000228E */  lw         $v0, 0x60($s1)
    /* 89730 80098F30 00000000 */  nop
    /* 89734 80098F34 88004010 */  beqz       $v0, .L80099158
    /* 89738 80098F38 00000000 */   nop
    /* 8973C 80098F3C 4C00228E */  lw         $v0, 0x4C($s1)
    /* 89740 80098F40 00000000 */  nop
    /* 89744 80098F44 C8004484 */  lh         $a0, 0xC8($v0)
    /* 89748 80098F48 CC00428C */  lw         $v0, 0xCC($v0)
    /* 8974C 80098F4C 00000000 */  nop
    /* 89750 80098F50 09F84000 */  jalr       $v0
    /* 89754 80098F54 21202402 */   addu      $a0, $s1, $a0
    /* 89758 80098F58 6002428C */  lw         $v0, 0x260($v0)
    /* 8975C 80098F5C 00000000 */  nop
    /* 89760 80098F60 00024230 */  andi       $v0, $v0, 0x200
    /* 89764 80098F64 5A004010 */  beqz       $v0, .L800990D0
    /* 89768 80098F68 00000000 */   nop
    /* 8976C 80098F6C 516A020C */  jal        CopSpeak_Flush__Fv
    /* 89770 80098F70 00000000 */   nop
    /* 89774 80098F74 1480043C */  lui        $a0, %hi(CopSpeak_gSpchHandle)
    /* 89778 80098F78 D0D0848C */  lw         $a0, %lo(CopSpeak_gSpchHandle)($a0)
    /* 8977C 80098F7C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 89780 80098F80 1F008210 */  beq        $a0, $v0, .L80099000
    /* 89784 80098F84 00000000 */   nop
    /* 89788 80098F88 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 8978C 80098F8C 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 89790 80098F90 00000000 */  nop
    /* 89794 80098F94 18004010 */  beqz       $v0, .L80098FF8
    /* 89798 80098F98 00000000 */   nop
    /* 8979C 80098F9C 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 897A0 80098FA0 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 897A4 80098FA4 2B91030C */  jal        SetSp
    /* 897A8 80098FA8 00000000 */   nop
    /* 897AC 80098FAC 1480043C */  lui        $a0, %hi(CopSpeak_gSpchHandle)
    /* 897B0 80098FB0 D0D0848C */  lw         $a0, %lo(CopSpeak_gSpchHandle)($a0)
    /* 897B4 80098FB4 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 897B8 80098FB8 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 897BC 80098FBC 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 897C0 80098FC0 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 897C4 80098FC4 A09F030C */  jal        SNDstop
    /* 897C8 80098FC8 00000000 */   nop
    /* 897CC 80098FCC 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 897D0 80098FD0 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 897D4 80098FD4 2B91030C */  jal        SetSp
    /* 897D8 80098FD8 00000000 */   nop
    /* 897DC 80098FDC 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 897E0 80098FE0 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 897E4 80098FE4 01000224 */  addiu      $v0, $zero, 0x1
    /* 897E8 80098FE8 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 897EC 80098FEC 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 897F0 80098FF0 00640208 */  j          .L80099000
    /* 897F4 80098FF4 00000000 */   nop
  .L80098FF8:
    /* 897F8 80098FF8 A09F030C */  jal        SNDstop
    /* 897FC 80098FFC 00000000 */   nop
  .L80099000:
    /* 89800 80099000 4C00228E */  lw         $v0, 0x4C($s1)
    /* 89804 80099004 21800000 */  addu       $s0, $zero, $zero
    /* 89808 80099008 D8004484 */  lh         $a0, 0xD8($v0)
    /* 8980C 8009900C DC00428C */  lw         $v0, 0xDC($v0)
    /* 89810 80099010 00000000 */  nop
    /* 89814 80099014 09F84000 */  jalr       $v0
    /* 89818 80099018 21202402 */   addu      $a0, $s1, $a0
    /* 8981C 8009901C 04004010 */  beqz       $v0, .L80099030
    /* 89820 80099020 00000000 */   nop
    /* 89824 80099024 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 89828 80099028 00000000 */   nop
    /* 8982C 8009902C 2B800200 */  sltu       $s0, $zero, $v0
  .L80099030:
    /* 89830 80099030 21000012 */  beqz       $s0, .L800990B8
    /* 89834 80099034 00000000 */   nop
    /* 89838 80099038 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 8983C 8009903C 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 89840 80099040 00000000 */  nop
    /* 89844 80099044 18004010 */  beqz       $v0, .L800990A8
    /* 89848 80099048 00000000 */   nop
    /* 8984C 8009904C 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 89850 80099050 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 89854 80099054 2B91030C */  jal        SetSp
    /* 89858 80099058 00000000 */   nop
    /* 8985C 8009905C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 89860 80099060 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 89864 80099064 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 89868 80099068 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 8986C 8009906C 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 89870 80099070 F4010424 */   addiu     $a0, $zero, 0x1F4
    /* 89874 80099074 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 89878 80099078 21200000 */   addu      $a0, $zero, $zero
    /* 8987C 8009907C 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 89880 80099080 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 89884 80099084 2B91030C */  jal        SetSp
    /* 89888 80099088 00000000 */   nop
    /* 8988C 8009908C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 89890 80099090 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 89894 80099094 01000224 */  addiu      $v0, $zero, 0x1
    /* 89898 80099098 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 8989C 8009909C 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 898A0 800990A0 2F640208 */  j          .L800990BC
    /* 898A4 800990A4 140020AE */   sw        $zero, 0x14($s1)
  .L800990A8:
    /* 898A8 800990A8 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 898AC 800990AC F4010424 */   addiu     $a0, $zero, 0x1F4
    /* 898B0 800990B0 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 898B4 800990B4 21200000 */   addu      $a0, $zero, $zero
  .L800990B8:
    /* 898B8 800990B8 140020AE */  sw         $zero, 0x14($s1)
  .L800990BC:
    /* 898BC 800990BC 2C0020AE */  sw         $zero, 0x2C($s1)
    /* 898C0 800990C0 280020AE */  sw         $zero, 0x28($s1)
    /* 898C4 800990C4 640020AE */  sw         $zero, 0x64($s1)
    /* 898C8 800990C8 56640208 */  j          .L80099158
    /* 898CC 800990CC 480020AE */   sw        $zero, 0x48($s1)
  .L800990D0:
    /* 898D0 800990D0 BC57020C */  jal        Dispatch__6Speech
    /* 898D4 800990D4 600020AE */   sw        $zero, 0x60($s1)
    /* 898D8 800990D8 4C00438C */  lw         $v1, 0x4C($v0)
    /* 898DC 800990DC 00000000 */  nop
    /* 898E0 800990E0 B0006484 */  lh         $a0, 0xB0($v1)
    /* 898E4 800990E4 B400638C */  lw         $v1, 0xB4($v1)
    /* 898E8 800990E8 00000000 */  nop
    /* 898EC 800990EC 09F86000 */  jalr       $v1
    /* 898F0 800990F0 21204400 */   addu      $a0, $v0, $a0
    /* 898F4 800990F4 0A005114 */  bne        $v0, $s1, .L80099120
    /* 898F8 800990F8 00000000 */   nop
    /* 898FC 800990FC BC57020C */  jal        Dispatch__6Speech
    /* 89900 80099100 00000000 */   nop
    /* 89904 80099104 4C00438C */  lw         $v1, 0x4C($v0)
    /* 89908 80099108 00000000 */  nop
    /* 8990C 8009910C B8006484 */  lh         $a0, 0xB8($v1)
    /* 89910 80099110 BC00638C */  lw         $v1, 0xBC($v1)
    /* 89914 80099114 00000000 */  nop
    /* 89918 80099118 09F86000 */  jalr       $v1
    /* 8991C 8009911C 21204400 */   addu      $a0, $v0, $a0
  .L80099120:
    /* 89920 80099120 BC57020C */  jal        Dispatch__6Speech
    /* 89924 80099124 00000000 */   nop
    /* 89928 80099128 21184000 */  addu       $v1, $v0, $zero
  .L8009912C:
    /* 8992C 8009912C 4800628C */  lw         $v0, 0x48($v1)
    /* 89930 80099130 00000000 */  nop
    /* 89934 80099134 05005110 */  beq        $v0, $s1, .L8009914C
    /* 89938 80099138 00000000 */   nop
    /* 8993C 8009913C 06004010 */  beqz       $v0, .L80099158
    /* 89940 80099140 21184000 */   addu      $v1, $v0, $zero
    /* 89944 80099144 4B640208 */  j          .L8009912C
    /* 89948 80099148 00000000 */   nop
  .L8009914C:
    /* 8994C 8009914C 4800228E */  lw         $v0, 0x48($s1)
    /* 89950 80099150 00000000 */  nop
    /* 89954 80099154 480062AC */  sw         $v0, 0x48($v1)
  .L80099158:
    /* 89958 80099158 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8995C 8009915C 1400B18F */  lw         $s1, 0x14($sp)
    /* 89960 80099160 1000B08F */  lw         $s0, 0x10($sp)
    /* 89964 80099164 0800E003 */  jr         $ra
    /* 89968 80099168 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Purge__Q26Speech13MobileSpeaker
