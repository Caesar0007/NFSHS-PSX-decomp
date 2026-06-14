.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo, 0x29C

glabel Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
    /* 98EC8 800A86C8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98ECC 800A86CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 98ED0 800A86D0 21908000 */  addu       $s2, $a0, $zero
    /* 98ED4 800A86D4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98ED8 800A86D8 2188A000 */  addu       $s1, $a1, $zero
    /* 98EDC 800A86DC 21202002 */  addu       $a0, $s1, $zero
    /* 98EE0 800A86E0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98EE4 800A86E4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98EE8 800A86E8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 98EEC 800A86EC 6404438E */  lw         $v1, 0x464($s2)
    /* 98EF0 800A86F0 21202002 */  addu       $a0, $s1, $zero
    /* 98EF4 800A86F4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98EF8 800A86F8 000062AC */   sw        $v0, 0x0($v1)
    /* 98EFC 800A86FC 6404438E */  lw         $v1, 0x464($s2)
    /* 98F00 800A8700 21202002 */  addu       $a0, $s1, $zero
    /* 98F04 800A8704 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98F08 800A8708 040062AC */   sw        $v0, 0x4($v1)
    /* 98F0C 800A870C 6404438E */  lw         $v1, 0x464($s2)
    /* 98F10 800A8710 21800000 */  addu       $s0, $zero, $zero
    /* 98F14 800A8714 080062AC */  sw         $v0, 0x8($v1)
  .L800A8718:
    /* 98F18 800A8718 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98F1C 800A871C 21202002 */   addu      $a0, $s1, $zero
    /* 98F20 800A8720 80181000 */  sll        $v1, $s0, 2
    /* 98F24 800A8724 6404448E */  lw         $a0, 0x464($s2)
    /* 98F28 800A8728 01001026 */  addiu      $s0, $s0, 0x1
    /* 98F2C 800A872C 21208300 */  addu       $a0, $a0, $v1
    /* 98F30 800A8730 0C0082AC */  sw         $v0, 0xC($a0)
    /* 98F34 800A8734 0800022A */  slti       $v0, $s0, 0x8
    /* 98F38 800A8738 F7FF4014 */  bnez       $v0, .L800A8718
    /* 98F3C 800A873C 00000000 */   nop
    /* 98F40 800A8740 21800000 */  addu       $s0, $zero, $zero
  .L800A8744:
    /* 98F44 800A8744 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98F48 800A8748 21202002 */   addu      $a0, $s1, $zero
    /* 98F4C 800A874C 80181000 */  sll        $v1, $s0, 2
    /* 98F50 800A8750 6404448E */  lw         $a0, 0x464($s2)
    /* 98F54 800A8754 01001026 */  addiu      $s0, $s0, 0x1
    /* 98F58 800A8758 21208300 */  addu       $a0, $a0, $v1
    /* 98F5C 800A875C 2C0082AC */  sw         $v0, 0x2C($a0)
    /* 98F60 800A8760 0800022A */  slti       $v0, $s0, 0x8
    /* 98F64 800A8764 F7FF4014 */  bnez       $v0, .L800A8744
    /* 98F68 800A8768 00000000 */   nop
    /* 98F6C 800A876C 21800000 */  addu       $s0, $zero, $zero
  .L800A8770:
    /* 98F70 800A8770 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98F74 800A8774 21202002 */   addu      $a0, $s1, $zero
    /* 98F78 800A8778 80181000 */  sll        $v1, $s0, 2
    /* 98F7C 800A877C 6404448E */  lw         $a0, 0x464($s2)
    /* 98F80 800A8780 01001026 */  addiu      $s0, $s0, 0x1
    /* 98F84 800A8784 21208300 */  addu       $a0, $a0, $v1
    /* 98F88 800A8788 4C0082AC */  sw         $v0, 0x4C($a0)
    /* 98F8C 800A878C 2900022A */  slti       $v0, $s0, 0x29
    /* 98F90 800A8790 F7FF4014 */  bnez       $v0, .L800A8770
    /* 98F94 800A8794 00000000 */   nop
    /* 98F98 800A8798 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98F9C 800A879C 21202002 */   addu      $a0, $s1, $zero
    /* 98FA0 800A87A0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FA4 800A87A4 21202002 */  addu       $a0, $s1, $zero
    /* 98FA8 800A87A8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FAC 800A87AC F00062AC */   sw        $v0, 0xF0($v1)
    /* 98FB0 800A87B0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FB4 800A87B4 21202002 */  addu       $a0, $s1, $zero
    /* 98FB8 800A87B8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FBC 800A87BC F40062AC */   sw        $v0, 0xF4($v1)
    /* 98FC0 800A87C0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FC4 800A87C4 21202002 */  addu       $a0, $s1, $zero
    /* 98FC8 800A87C8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FCC 800A87CC F80062AC */   sw        $v0, 0xF8($v1)
    /* 98FD0 800A87D0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FD4 800A87D4 21202002 */  addu       $a0, $s1, $zero
    /* 98FD8 800A87D8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FDC 800A87DC FC0062AC */   sw        $v0, 0xFC($v1)
    /* 98FE0 800A87E0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FE4 800A87E4 21202002 */  addu       $a0, $s1, $zero
    /* 98FE8 800A87E8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FEC 800A87EC 000162AC */   sw        $v0, 0x100($v1)
    /* 98FF0 800A87F0 6404438E */  lw         $v1, 0x464($s2)
    /* 98FF4 800A87F4 21202002 */  addu       $a0, $s1, $zero
    /* 98FF8 800A87F8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 98FFC 800A87FC 040162AC */   sw        $v0, 0x104($v1)
    /* 99000 800A8800 6404438E */  lw         $v1, 0x464($s2)
    /* 99004 800A8804 21202002 */  addu       $a0, $s1, $zero
    /* 99008 800A8808 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9900C 800A880C 080162AC */   sw        $v0, 0x108($v1)
    /* 99010 800A8810 6404438E */  lw         $v1, 0x464($s2)
    /* 99014 800A8814 21202002 */  addu       $a0, $s1, $zero
    /* 99018 800A8818 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9901C 800A881C 0C0162AC */   sw        $v0, 0x10C($v1)
    /* 99020 800A8820 6404438E */  lw         $v1, 0x464($s2)
    /* 99024 800A8824 21202002 */  addu       $a0, $s1, $zero
    /* 99028 800A8828 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9902C 800A882C 100162AC */   sw        $v0, 0x110($v1)
    /* 99030 800A8830 6404438E */  lw         $v1, 0x464($s2)
    /* 99034 800A8834 21202002 */  addu       $a0, $s1, $zero
    /* 99038 800A8838 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9903C 800A883C 140162AC */   sw        $v0, 0x114($v1)
    /* 99040 800A8840 6404438E */  lw         $v1, 0x464($s2)
    /* 99044 800A8844 21202002 */  addu       $a0, $s1, $zero
    /* 99048 800A8848 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9904C 800A884C 180162AC */   sw        $v0, 0x118($v1)
    /* 99050 800A8850 6404438E */  lw         $v1, 0x464($s2)
    /* 99054 800A8854 21202002 */  addu       $a0, $s1, $zero
    /* 99058 800A8858 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9905C 800A885C 1C0162AC */   sw        $v0, 0x11C($v1)
    /* 99060 800A8860 6404438E */  lw         $v1, 0x464($s2)
    /* 99064 800A8864 21202002 */  addu       $a0, $s1, $zero
    /* 99068 800A8868 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9906C 800A886C 200162AC */   sw        $v0, 0x120($v1)
    /* 99070 800A8870 6404438E */  lw         $v1, 0x464($s2)
    /* 99074 800A8874 21202002 */  addu       $a0, $s1, $zero
    /* 99078 800A8878 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9907C 800A887C 240162AC */   sw        $v0, 0x124($v1)
    /* 99080 800A8880 6404438E */  lw         $v1, 0x464($s2)
    /* 99084 800A8884 21202002 */  addu       $a0, $s1, $zero
    /* 99088 800A8888 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9908C 800A888C 280162AC */   sw        $v0, 0x128($v1)
    /* 99090 800A8890 6404438E */  lw         $v1, 0x464($s2)
    /* 99094 800A8894 21202002 */  addu       $a0, $s1, $zero
    /* 99098 800A8898 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9909C 800A889C 2C0162AC */   sw        $v0, 0x12C($v1)
    /* 990A0 800A88A0 6404438E */  lw         $v1, 0x464($s2)
    /* 990A4 800A88A4 21202002 */  addu       $a0, $s1, $zero
    /* 990A8 800A88A8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990AC 800A88AC 300162AC */   sw        $v0, 0x130($v1)
    /* 990B0 800A88B0 6404438E */  lw         $v1, 0x464($s2)
    /* 990B4 800A88B4 21202002 */  addu       $a0, $s1, $zero
    /* 990B8 800A88B8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990BC 800A88BC 340162AC */   sw        $v0, 0x134($v1)
    /* 990C0 800A88C0 6404438E */  lw         $v1, 0x464($s2)
    /* 990C4 800A88C4 21202002 */  addu       $a0, $s1, $zero
    /* 990C8 800A88C8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990CC 800A88CC 380162AC */   sw        $v0, 0x138($v1)
    /* 990D0 800A88D0 6404438E */  lw         $v1, 0x464($s2)
    /* 990D4 800A88D4 21202002 */  addu       $a0, $s1, $zero
    /* 990D8 800A88D8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990DC 800A88DC 3C0162AC */   sw        $v0, 0x13C($v1)
    /* 990E0 800A88E0 6404438E */  lw         $v1, 0x464($s2)
    /* 990E4 800A88E4 21202002 */  addu       $a0, $s1, $zero
    /* 990E8 800A88E8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990EC 800A88EC 400162AC */   sw        $v0, 0x140($v1)
    /* 990F0 800A88F0 6404438E */  lw         $v1, 0x464($s2)
    /* 990F4 800A88F4 21202002 */  addu       $a0, $s1, $zero
    /* 990F8 800A88F8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 990FC 800A88FC 440162AC */   sw        $v0, 0x144($v1)
    /* 99100 800A8900 6404438E */  lw         $v1, 0x464($s2)
    /* 99104 800A8904 21202002 */  addu       $a0, $s1, $zero
    /* 99108 800A8908 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9910C 800A890C 480162AC */   sw        $v0, 0x148($v1)
    /* 99110 800A8910 6404438E */  lw         $v1, 0x464($s2)
    /* 99114 800A8914 21202002 */  addu       $a0, $s1, $zero
    /* 99118 800A8918 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9911C 800A891C 4C0162AC */   sw        $v0, 0x14C($v1)
    /* 99120 800A8920 6404438E */  lw         $v1, 0x464($s2)
    /* 99124 800A8924 21202002 */  addu       $a0, $s1, $zero
    /* 99128 800A8928 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9912C 800A892C 500162AC */   sw        $v0, 0x150($v1)
    /* 99130 800A8930 6404438E */  lw         $v1, 0x464($s2)
    /* 99134 800A8934 21202002 */  addu       $a0, $s1, $zero
    /* 99138 800A8938 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 9913C 800A893C 540162AC */   sw        $v0, 0x154($v1)
    /* 99140 800A8940 6404438E */  lw         $v1, 0x464($s2)
    /* 99144 800A8944 00000000 */  nop
    /* 99148 800A8948 580162AC */  sw         $v0, 0x158($v1)
    /* 9914C 800A894C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 99150 800A8950 1800B28F */  lw         $s2, 0x18($sp)
    /* 99154 800A8954 1400B18F */  lw         $s1, 0x14($sp)
    /* 99158 800A8958 1000B08F */  lw         $s0, 0x10($sp)
    /* 9915C 800A895C 0800E003 */  jr         $ra
    /* 99160 800A8960 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
