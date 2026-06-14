.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildNumbers0__Fi, 0x84C

glabel Hud_BuildNumbers0__Fi
    /* C4E24 800D4624 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C4E28 800D4628 1400B1AF */  sw         $s1, 0x14($sp)
    /* C4E2C 800D462C 21888000 */  addu       $s1, $a0, $zero
    /* C4E30 800D4630 21182002 */  addu       $v1, $s1, $zero
    /* C4E34 800D4634 3000BFAF */  sw         $ra, 0x30($sp)
    /* C4E38 800D4638 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* C4E3C 800D463C 2800B6AF */  sw         $s6, 0x28($sp)
    /* C4E40 800D4640 2400B5AF */  sw         $s5, 0x24($sp)
    /* C4E44 800D4644 2000B4AF */  sw         $s4, 0x20($sp)
    /* C4E48 800D4648 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C4E4C 800D464C 1800B2AF */  sw         $s2, 0x18($sp)
    /* C4E50 800D4650 04002012 */  beqz       $s1, .L800D4664
    /* C4E54 800D4654 1000B0AF */   sw        $s0, 0x10($sp)
    /* C4E58 800D4658 C018938F */  lw         $s3, %gp_rel(D_8013DE0C)($gp)
    /* C4E5C 800D465C 9B510308 */  j          .L800D466C
    /* C4E60 800D4660 1480023C */   lui       $v0, %hi(D_8013E450)
  .L800D4664:
    /* C4E64 800D4664 BC18938F */  lw         $s3, %gp_rel(D_8013DE08)($gp)
    /* C4E68 800D4668 1480023C */  lui        $v0, %hi(D_8013E450)
  .L800D466C:
    /* C4E6C 800D466C 02006010 */  beqz       $v1, .L800D4678
    /* C4E70 800D4670 50E45624 */   addiu     $s6, $v0, %lo(D_8013E450)
    /* C4E74 800D4674 A800D626 */  addiu      $s6, $s6, 0xA8
  .L800D4678:
    /* C4E78 800D4678 1480023C */  lui        $v0, %hi(D_8013E730)
    /* C4E7C 800D467C 02006010 */  beqz       $v1, .L800D4688
    /* C4E80 800D4680 30E75524 */   addiu     $s5, $v0, %lo(D_8013E730)
    /* C4E84 800D4684 9000B526 */  addiu      $s5, $s5, 0x90
  .L800D4688:
    /* C4E88 800D4688 02006010 */  beqz       $v1, .L800D4694
    /* C4E8C 800D468C 21800000 */   addu      $s0, $zero, $zero
    /* C4E90 800D4690 F1FF1024 */  addiu      $s0, $zero, -0xF
  .L800D4694:
    /* C4E94 800D4694 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C4E98 800D4698 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C4E9C 800D469C 40181100 */  sll        $v1, $s1, 1
    /* C4EA0 800D46A0 21187100 */  addu       $v1, $v1, $s1
    /* C4EA4 800D46A4 00110300 */  sll        $v0, $v1, 4
    /* C4EA8 800D46A8 23104300 */  subu       $v0, $v0, $v1
    /* C4EAC 800D46AC 80100200 */  sll        $v0, $v0, 2
    /* C4EB0 800D46B0 21104400 */  addu       $v0, $v0, $a0
    /* C4EB4 800D46B4 5804428C */  lw         $v0, 0x458($v0)
    /* C4EB8 800D46B8 00000000 */  nop
    /* C4EBC 800D46BC 65004010 */  beqz       $v0, .L800D4854
    /* C4EC0 800D46C0 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C4EC4 800D46C4 30274524 */  addiu      $a1, $v0, %lo(DashHUD_gInfo)
    /* C4EC8 800D46C8 1400A28C */  lw         $v0, 0x14($a1)
    /* C4ECC 800D46CC 00000000 */  nop
    /* C4ED0 800D46D0 06004010 */  beqz       $v0, .L800D46EC
    /* C4ED4 800D46D4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* C4ED8 800D46D8 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C4EDC 800D46DC 00000000 */  nop
    /* C4EE0 800D46E0 10004230 */  andi       $v0, $v0, 0x10
    /* C4EE4 800D46E4 0B004014 */  bnez       $v0, .L800D4714
    /* C4EE8 800D46E8 00000000 */   nop
  .L800D46EC:
    /* C4EEC 800D46EC F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C4EF0 800D46F0 00000000 */  nop
    /* C4EF4 800D46F4 04004010 */  beqz       $v0, .L800D4708
    /* C4EF8 800D46F8 F0006426 */   addiu     $a0, $s3, 0xF0
    /* C4EFC 800D46FC E813858F */  lw         $a1, %gp_rel(BTC_Countdown)($gp)
    /* C4F00 800D4700 C3510308 */  j          .L800D470C
    /* C4F04 800D4704 00000000 */   nop
  .L800D4708:
    /* C4F08 800D4708 3400A58C */  lw         $a1, 0x34($a1)
  .L800D470C:
    /* C4F0C 800D470C 864E030C */  jal        Hud_BuildETimeString__FP4SPRTi
    /* C4F10 800D4710 00000000 */   nop
  .L800D4714:
    /* C4F14 800D4714 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C4F18 800D4718 00000000 */  nop
    /* C4F1C 800D471C 02004010 */  beqz       $v0, .L800D4728
    /* C4F20 800D4720 08000324 */   addiu     $v1, $zero, 0x8
    /* C4F24 800D4724 05000324 */  addiu      $v1, $zero, 0x5
  .L800D4728:
    /* C4F28 800D4728 0C000524 */  addiu      $a1, $zero, 0xC
    /* C4F2C 800D472C 21406500 */  addu       $t0, $v1, $a1
    /* C4F30 800D4730 2A10A800 */  slt        $v0, $a1, $t0
    /* C4F34 800D4734 16004010 */  beqz       $v0, .L800D4790
    /* C4F38 800D4738 FF00063C */   lui       $a2, (0xFFFFFF >> 16)
    /* C4F3C 800D473C 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C4F40 800D4740 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C4F44 800D4744 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* C4F48 800D4748 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C4F4C 800D474C F0006426 */  addiu      $a0, $s3, 0xF0
  .L800D4750:
    /* C4F50 800D4750 0100A524 */  addiu      $a1, $a1, 0x1
    /* C4F54 800D4754 0000838C */  lw         $v1, 0x0($a0)
    /* C4F58 800D4758 0000E28C */  lw         $v0, 0x0($a3)
    /* C4F5C 800D475C 24186900 */  and        $v1, $v1, $t1
    /* C4F60 800D4760 24104600 */  and        $v0, $v0, $a2
    /* C4F64 800D4764 25186200 */  or         $v1, $v1, $v0
    /* C4F68 800D4768 000083AC */  sw         $v1, 0x0($a0)
    /* C4F6C 800D476C 24188600 */  and        $v1, $a0, $a2
    /* C4F70 800D4770 0000E28C */  lw         $v0, 0x0($a3)
    /* C4F74 800D4774 00000000 */  nop
    /* C4F78 800D4778 24104900 */  and        $v0, $v0, $t1
    /* C4F7C 800D477C 25104300 */  or         $v0, $v0, $v1
    /* C4F80 800D4780 0000E2AC */  sw         $v0, 0x0($a3)
    /* C4F84 800D4784 2A10A800 */  slt        $v0, $a1, $t0
    /* C4F88 800D4788 F1FF4014 */  bnez       $v0, .L800D4750
    /* C4F8C 800D478C 14008424 */   addiu     $a0, $a0, 0x14
  .L800D4790:
    /* C4F90 800D4790 04000524 */  addiu      $a1, $zero, 0x4
    /* C4F94 800D4794 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C4F98 800D4798 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C4F9C 800D479C FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* C4FA0 800D47A0 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* C4FA4 800D47A4 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C4FA8 800D47A8 50006426 */  addiu      $a0, $s3, 0x50
  .L800D47AC:
    /* C4FAC 800D47AC 0100A524 */  addiu      $a1, $a1, 0x1
    /* C4FB0 800D47B0 0000838C */  lw         $v1, 0x0($a0)
    /* C4FB4 800D47B4 0000E28C */  lw         $v0, 0x0($a3)
    /* C4FB8 800D47B8 24186800 */  and        $v1, $v1, $t0
    /* C4FBC 800D47BC 24104600 */  and        $v0, $v0, $a2
    /* C4FC0 800D47C0 25186200 */  or         $v1, $v1, $v0
    /* C4FC4 800D47C4 000083AC */  sw         $v1, 0x0($a0)
    /* C4FC8 800D47C8 24188600 */  and        $v1, $a0, $a2
    /* C4FCC 800D47CC 0000E28C */  lw         $v0, 0x0($a3)
    /* C4FD0 800D47D0 00000000 */  nop
    /* C4FD4 800D47D4 24104800 */  and        $v0, $v0, $t0
    /* C4FD8 800D47D8 25104300 */  or         $v0, $v0, $v1
    /* C4FDC 800D47DC 0000E2AC */  sw         $v0, 0x0($a3)
    /* C4FE0 800D47E0 0600A228 */  slti       $v0, $a1, 0x6
    /* C4FE4 800D47E4 F1FF4014 */  bnez       $v0, .L800D47AC
    /* C4FE8 800D47E8 14008424 */   addiu     $a0, $a0, 0x14
    /* C4FEC 800D47EC FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* C4FF0 800D47F0 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* C4FF4 800D47F4 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C4FF8 800D47F8 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C4FFC 800D47FC 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5000 800D4800 0000A38E */  lw         $v1, 0x0($s5)
    /* C5004 800D4804 0000A28C */  lw         $v0, 0x0($a1)
    /* C5008 800D4808 24186600 */  and        $v1, $v1, $a2
    /* C500C 800D480C 24104400 */  and        $v0, $v0, $a0
    /* C5010 800D4810 25186200 */  or         $v1, $v1, $v0
    /* C5014 800D4814 0000A3AE */  sw         $v1, 0x0($s5)
    /* C5018 800D4818 0000A28C */  lw         $v0, 0x0($a1)
    /* C501C 800D481C 2418A402 */  and        $v1, $s5, $a0
    /* C5020 800D4820 24104600 */  and        $v0, $v0, $a2
    /* C5024 800D4824 25104300 */  or         $v0, $v0, $v1
    /* C5028 800D4828 0000A2AC */  sw         $v0, 0x0($a1)
    /* C502C 800D482C 0000C38E */  lw         $v1, 0x0($s6)
    /* C5030 800D4830 24104400 */  and        $v0, $v0, $a0
    /* C5034 800D4834 24186600 */  and        $v1, $v1, $a2
    /* C5038 800D4838 25186200 */  or         $v1, $v1, $v0
    /* C503C 800D483C 0000C3AE */  sw         $v1, 0x0($s6)
    /* C5040 800D4840 0000A28C */  lw         $v0, 0x0($a1)
    /* C5044 800D4844 2420C402 */  and        $a0, $s6, $a0
    /* C5048 800D4848 24104600 */  and        $v0, $v0, $a2
    /* C504C 800D484C 25104400 */  or         $v0, $v0, $a0
    /* C5050 800D4850 0000A2AC */  sw         $v0, 0x0($a1)
  .L800D4854:
    /* C5054 800D4854 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C5058 800D4858 00000000 */  nop
    /* C505C 800D485C 26004014 */  bnez       $v0, .L800D48F8
    /* C5060 800D4860 00000000 */   nop
    /* C5064 800D4864 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C5068 800D4868 00000000 */  nop
    /* C506C 800D486C 16004384 */  lh         $v1, 0x16($v0)
    /* C5070 800D4870 26004284 */  lh         $v0, 0x26($v0)
    /* C5074 800D4874 21187000 */  addu       $v1, $v1, $s0
    /* C5078 800D4878 21186200 */  addu       $v1, $v1, $v0
    /* C507C 800D487C 0A006224 */  addiu      $v0, $v1, 0xA
    /* C5080 800D4880 07006424 */  addiu      $a0, $v1, 0x7
    /* C5084 800D4884 D20063A6 */  sh         $v1, 0xD2($s3)
    /* C5088 800D4888 5200A3A6 */  sh         $v1, 0x52($s5)
    /* C508C 800D488C 5A00A3A6 */  sh         $v1, 0x5A($s5)
    /* C5090 800D4890 6200A2A6 */  sh         $v0, 0x62($s5)
    /* C5094 800D4894 6A00A2A6 */  sh         $v0, 0x6A($s5)
    /* C5098 800D4898 E60063A6 */  sh         $v1, 0xE6($s3)
    /* C509C 800D489C 01006324 */  addiu      $v1, $v1, 0x1
    /* C50A0 800D48A0 5200C4A6 */  sh         $a0, 0x52($s6)
    /* C50A4 800D48A4 5600C4A6 */  sh         $a0, 0x56($s6)
    /* C50A8 800D48A8 80201100 */  sll        $a0, $s1, 2
    /* C50AC 800D48AC 5A00C2A6 */  sh         $v0, 0x5A($s6)
    /* C50B0 800D48B0 5E00C2A6 */  sh         $v0, 0x5E($s6)
    /* C50B4 800D48B4 1480023C */  lui        $v0, %hi(D_8013DE18)
    /* C50B8 800D48B8 18DE4224 */  addiu      $v0, $v0, %lo(D_8013DE18)
    /* C50BC 800D48BC 21108200 */  addu       $v0, $a0, $v0
    /* C50C0 800D48C0 620263A6 */  sh         $v1, 0x262($s3)
    /* C50C4 800D48C4 00004294 */  lhu        $v0, 0x0($v0)
    /* C50C8 800D48C8 8A0263A6 */  sh         $v1, 0x28A($s3)
    /* C50CC 800D48CC 9E0263A6 */  sh         $v1, 0x29E($s3)
    /* C50D0 800D48D0 21104300 */  addu       $v0, $v0, $v1
    /* C50D4 800D48D4 760262A6 */  sh         $v0, 0x276($s3)
    /* C50D8 800D48D8 1480023C */  lui        $v0, %hi(D_8013DE20)
    /* C50DC 800D48DC 20DE4224 */  addiu      $v0, $v0, %lo(D_8013DE20)
    /* C50E0 800D48E0 21208200 */  addu       $a0, $a0, $v0
    /* C50E4 800D48E4 00008294 */  lhu        $v0, 0x0($a0)
    /* C50E8 800D48E8 C60263A6 */  sh         $v1, 0x2C6($s3)
    /* C50EC 800D48EC DA0263A6 */  sh         $v1, 0x2DA($s3)
    /* C50F0 800D48F0 21104300 */  addu       $v0, $v0, $v1
    /* C50F4 800D48F4 B20262A6 */  sh         $v0, 0x2B2($s3)
  .L800D48F8:
    /* C50F8 800D48F8 DC18858F */  lw         $a1, %gp_rel(D_8013DE28)($gp)
    /* C50FC 800D48FC 00000000 */  nop
    /* C5100 800D4900 5F00A010 */  beqz       $a1, .L800D4A80
    /* C5104 800D4904 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* C5108 800D4908 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C510C 800D490C 00000000 */  nop
    /* C5110 800D4910 5A004010 */  beqz       $v0, .L800D4A7C
    /* C5114 800D4914 1180043C */   lui       $a0, %hi(GameSetup_gData)
    /* C5118 800D4918 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C511C 800D491C 40181100 */  sll        $v1, $s1, 1
    /* C5120 800D4920 21187100 */  addu       $v1, $v1, $s1
    /* C5124 800D4924 00110300 */  sll        $v0, $v1, 4
    /* C5128 800D4928 23104300 */  subu       $v0, $v0, $v1
    /* C512C 800D492C 80100200 */  sll        $v0, $v0, 2
    /* C5130 800D4930 21104400 */  addu       $v0, $v0, $a0
    /* C5134 800D4934 5804428C */  lw         $v0, 0x458($v0)
    /* C5138 800D4938 00000000 */  nop
    /* C513C 800D493C 41014010 */  beqz       $v0, .L800D4E44
    /* C5140 800D4940 1180023C */   lui       $v0, %hi(D_801115D0)
    /* C5144 800D4944 D015428C */  lw         $v0, %lo(D_801115D0)($v0)
    /* C5148 800D4948 58027126 */  addiu      $s1, $s3, 0x258
    /* C514C 800D494C 0200A104 */  bgez       $a1, .L800D4958
    /* C5150 800D4950 D40062AE */   sw        $v0, 0xD4($s3)
    /* C5154 800D4954 21280000 */  addu       $a1, $zero, $zero
  .L800D4958:
    /* C5158 800D4958 514F030C */  jal        Hud_BuildTimeString__FP4SPRTi
    /* C515C 800D495C 21202002 */   addu      $a0, $s1, $zero
    /* C5160 800D4960 1E001024 */  addiu      $s0, $zero, 0x1E
    /* C5164 800D4964 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C5168 800D4968 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C516C 800D496C FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C5170 800D4970 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5174 800D4974 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* C5178 800D4978 21202002 */  addu       $a0, $s1, $zero
  .L800D497C:
    /* C517C 800D497C 01001026 */  addiu      $s0, $s0, 0x1
    /* C5180 800D4980 0000838C */  lw         $v1, 0x0($a0)
    /* C5184 800D4984 0000C28C */  lw         $v0, 0x0($a2)
    /* C5188 800D4988 24186700 */  and        $v1, $v1, $a3
    /* C518C 800D498C 24104500 */  and        $v0, $v0, $a1
    /* C5190 800D4990 25186200 */  or         $v1, $v1, $v0
    /* C5194 800D4994 000083AC */  sw         $v1, 0x0($a0)
    /* C5198 800D4998 24188500 */  and        $v1, $a0, $a1
    /* C519C 800D499C 0000C28C */  lw         $v0, 0x0($a2)
    /* C51A0 800D49A0 00000000 */  nop
    /* C51A4 800D49A4 24104700 */  and        $v0, $v0, $a3
    /* C51A8 800D49A8 25104300 */  or         $v0, $v0, $v1
    /* C51AC 800D49AC 0000C2AC */  sw         $v0, 0x0($a2)
    /* C51B0 800D49B0 2200022A */  slti       $v0, $s0, 0x22
    /* C51B4 800D49B4 F1FF4014 */  bnez       $v0, .L800D497C
    /* C51B8 800D49B8 14008424 */   addiu     $a0, $a0, 0x14
    /* C51BC 800D49BC 0A001024 */  addiu      $s0, $zero, 0xA
    /* C51C0 800D49C0 FF00123C */  lui        $s2, (0xFFFFFF >> 16)
    /* C51C4 800D49C4 FFFF5236 */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* C51C8 800D49C8 00FF143C */  lui        $s4, (0xFF000000 >> 16)
    /* C51CC 800D49CC C8006226 */  addiu      $v0, $s3, 0xC8
    /* C51D0 800D49D0 24B85200 */  and        $s7, $v0, $s2
    /* C51D4 800D49D4 21884000 */  addu       $s1, $v0, $zero
    /* C51D8 800D49D8 0A000224 */  addiu      $v0, $zero, 0xA
  .L800D49DC:
    /* C51DC 800D49DC 13000216 */  bne        $s0, $v0, .L800D4A2C
    /* C51E0 800D49E0 00000000 */   nop
    /* C51E4 800D49E4 5B47030C */  jal        Hud_GoTpage__Fi
    /* C51E8 800D49E8 21200000 */   addu      $a0, $zero, $zero
    /* C51EC 800D49EC 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C51F0 800D49F0 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C51F4 800D49F4 C800638E */  lw         $v1, 0xC8($s3)
    /* C51F8 800D49F8 0000A28C */  lw         $v0, 0x0($a1)
    /* C51FC 800D49FC 24187400 */  and        $v1, $v1, $s4
    /* C5200 800D4A00 24105200 */  and        $v0, $v0, $s2
    /* C5204 800D4A04 25186200 */  or         $v1, $v1, $v0
    /* C5208 800D4A08 C80063AE */  sw         $v1, 0xC8($s3)
    /* C520C 800D4A0C 0000A28C */  lw         $v0, 0x0($a1)
    /* C5210 800D4A10 01000424 */  addiu      $a0, $zero, 0x1
    /* C5214 800D4A14 24105400 */  and        $v0, $v0, $s4
    /* C5218 800D4A18 25105700 */  or         $v0, $v0, $s7
    /* C521C 800D4A1C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5220 800D4A20 0000A2AC */   sw        $v0, 0x0($a1)
    /* C5224 800D4A24 99520308 */  j          .L800D4A64
    /* C5228 800D4A28 14003126 */   addiu     $s1, $s1, 0x14
  .L800D4A2C:
    /* C522C 800D4A2C 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5230 800D4A30 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5234 800D4A34 0000238E */  lw         $v1, 0x0($s1)
    /* C5238 800D4A38 0000828C */  lw         $v0, 0x0($a0)
    /* C523C 800D4A3C 24187400 */  and        $v1, $v1, $s4
    /* C5240 800D4A40 24105200 */  and        $v0, $v0, $s2
    /* C5244 800D4A44 25186200 */  or         $v1, $v1, $v0
    /* C5248 800D4A48 000023AE */  sw         $v1, 0x0($s1)
    /* C524C 800D4A4C 0000828C */  lw         $v0, 0x0($a0)
    /* C5250 800D4A50 24183202 */  and        $v1, $s1, $s2
    /* C5254 800D4A54 24105400 */  and        $v0, $v0, $s4
    /* C5258 800D4A58 25104300 */  or         $v0, $v0, $v1
    /* C525C 800D4A5C 000082AC */  sw         $v0, 0x0($a0)
    /* C5260 800D4A60 14003126 */  addiu      $s1, $s1, 0x14
  .L800D4A64:
    /* C5264 800D4A64 01001026 */  addiu      $s0, $s0, 0x1
    /* C5268 800D4A68 0C00022A */  slti       $v0, $s0, 0xC
    /* C526C 800D4A6C DBFF4014 */  bnez       $v0, .L800D49DC
    /* C5270 800D4A70 0A000224 */   addiu     $v0, $zero, 0xA
    /* C5274 800D4A74 76530308 */  j          .L800D4DD8
    /* C5278 800D4A78 FF00043C */   lui       $a0, (0xFFFFFF >> 16)
  .L800D4A7C:
    /* C527C 800D4A7C 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L800D4A80:
    /* C5280 800D4A80 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* C5284 800D4A84 BC00628C */  lw         $v0, 0xBC($v1)
    /* C5288 800D4A88 00000000 */  nop
    /* C528C 800D4A8C ED004010 */  beqz       $v0, .L800D4E44
    /* C5290 800D4A90 80801100 */   sll       $s0, $s1, 2
    /* C5294 800D4A94 21100302 */  addu       $v0, $s0, $v1
    /* C5298 800D4A98 C000428C */  lw         $v0, 0xC0($v0)
    /* C529C 800D4A9C 00000000 */  nop
    /* C52A0 800D4AA0 74004014 */  bnez       $v0, .L800D4C74
    /* C52A4 800D4AA4 58026426 */   addiu     $a0, $s3, 0x258
    /* C52A8 800D4AA8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* C52AC 800D4AAC 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* C52B0 800D4AB0 21100202 */  addu       $v0, $s0, $v0
    /* C52B4 800D4AB4 0000438C */  lw         $v1, 0x0($v0)
    /* C52B8 800D4AB8 00000000 */  nop
    /* C52BC 800D4ABC 9C03628C */  lw         $v0, 0x39C($v1)
    /* C52C0 800D4AC0 00000000 */  nop
    /* C52C4 800D4AC4 DF004018 */  blez       $v0, .L800D4E44
    /* C52C8 800D4AC8 FFFF023C */   lui       $v0, (0xFFFF6A00 >> 16)
    /* C52CC 800D4ACC 9403638C */  lw         $v1, 0x394($v1)
    /* C52D0 800D4AD0 006A4234 */  ori        $v0, $v0, (0xFFFF6A00 & 0xFFFF)
    /* C52D4 800D4AD4 2A104300 */  slt        $v0, $v0, $v1
    /* C52D8 800D4AD8 DA004010 */  beqz       $v0, .L800D4E44
    /* C52DC 800D4ADC FF950234 */   ori       $v0, $zero, 0x95FF
    /* C52E0 800D4AE0 2A104300 */  slt        $v0, $v0, $v1
    /* C52E4 800D4AE4 D7004014 */  bnez       $v0, .L800D4E44
    /* C52E8 800D4AE8 00000000 */   nop
    /* C52EC 800D4AEC F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C52F0 800D4AF0 00000000 */  nop
    /* C52F4 800D4AF4 D3004014 */  bnez       $v0, .L800D4E44
    /* C52F8 800D4AF8 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C52FC 800D4AFC 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* C5300 800D4B00 21100202 */  addu       $v0, $s0, $v0
    /* C5304 800D4B04 2C00428C */  lw         $v0, 0x2C($v0)
    /* C5308 800D4B08 00000000 */  nop
    /* C530C 800D4B0C CD004014 */  bnez       $v0, .L800D4E44
    /* C5310 800D4B10 00000000 */   nop
    /* C5314 800D4B14 05006104 */  bgez       $v1, .L800D4B2C
    /* C5318 800D4B18 1180023C */   lui       $v0, %hi(D_801115D0)
    /* C531C 800D4B1C 1180023C */  lui        $v0, %hi(D_801115E4)
    /* C5320 800D4B20 E415428C */  lw         $v0, %lo(D_801115E4)($v0)
    /* C5324 800D4B24 CE520308 */  j          .L800D4B38
    /* C5328 800D4B28 D40062AE */   sw        $v0, 0xD4($s3)
  .L800D4B2C:
    /* C532C 800D4B2C D015428C */  lw         $v0, %lo(D_801115D0)($v0)
    /* C5330 800D4B30 00000000 */  nop
    /* C5334 800D4B34 D40062AE */  sw         $v0, 0xD4($s3)
  .L800D4B38:
    /* C5338 800D4B38 58027026 */  addiu      $s0, $s3, 0x258
    /* C533C 800D4B3C 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* C5340 800D4B40 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* C5344 800D4B44 80101100 */  sll        $v0, $s1, 2
    /* C5348 800D4B48 21104300 */  addu       $v0, $v0, $v1
    /* C534C 800D4B4C 0000428C */  lw         $v0, 0x0($v0)
    /* C5350 800D4B50 21200002 */  addu       $a0, $s0, $zero
    /* C5354 800D4B54 9403458C */  lw         $a1, 0x394($v0)
    /* C5358 800D4B58 514F030C */  jal        Hud_BuildTimeString__FP4SPRTi
    /* C535C 800D4B5C 1E001124 */   addiu     $s1, $zero, 0x1E
    /* C5360 800D4B60 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C5364 800D4B64 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5368 800D4B68 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C536C 800D4B6C 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5370 800D4B70 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
  .L800D4B74:
    /* C5374 800D4B74 01003126 */  addiu      $s1, $s1, 0x1
    /* C5378 800D4B78 0000038E */  lw         $v1, 0x0($s0)
    /* C537C 800D4B7C 0000828C */  lw         $v0, 0x0($a0)
    /* C5380 800D4B80 24186600 */  and        $v1, $v1, $a2
    /* C5384 800D4B84 24104500 */  and        $v0, $v0, $a1
    /* C5388 800D4B88 25186200 */  or         $v1, $v1, $v0
    /* C538C 800D4B8C 000003AE */  sw         $v1, 0x0($s0)
    /* C5390 800D4B90 24180502 */  and        $v1, $s0, $a1
    /* C5394 800D4B94 0000828C */  lw         $v0, 0x0($a0)
    /* C5398 800D4B98 00000000 */  nop
    /* C539C 800D4B9C 24104600 */  and        $v0, $v0, $a2
    /* C53A0 800D4BA0 25104300 */  or         $v0, $v0, $v1
    /* C53A4 800D4BA4 000082AC */  sw         $v0, 0x0($a0)
    /* C53A8 800D4BA8 2500222A */  slti       $v0, $s1, 0x25
    /* C53AC 800D4BAC F1FF4014 */  bnez       $v0, .L800D4B74
    /* C53B0 800D4BB0 14001026 */   addiu     $s0, $s0, 0x14
    /* C53B4 800D4BB4 0A001124 */  addiu      $s1, $zero, 0xA
    /* C53B8 800D4BB8 FF00123C */  lui        $s2, (0xFFFFFF >> 16)
    /* C53BC 800D4BBC FFFF5236 */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* C53C0 800D4BC0 00FF143C */  lui        $s4, (0xFF000000 >> 16)
    /* C53C4 800D4BC4 C8006226 */  addiu      $v0, $s3, 0xC8
    /* C53C8 800D4BC8 24B85200 */  and        $s7, $v0, $s2
    /* C53CC 800D4BCC 21804000 */  addu       $s0, $v0, $zero
    /* C53D0 800D4BD0 0A000224 */  addiu      $v0, $zero, 0xA
  .L800D4BD4:
    /* C53D4 800D4BD4 13002216 */  bne        $s1, $v0, .L800D4C24
    /* C53D8 800D4BD8 00000000 */   nop
    /* C53DC 800D4BDC 5B47030C */  jal        Hud_GoTpage__Fi
    /* C53E0 800D4BE0 21200000 */   addu      $a0, $zero, $zero
    /* C53E4 800D4BE4 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C53E8 800D4BE8 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C53EC 800D4BEC C800638E */  lw         $v1, 0xC8($s3)
    /* C53F0 800D4BF0 0000A28C */  lw         $v0, 0x0($a1)
    /* C53F4 800D4BF4 24187400 */  and        $v1, $v1, $s4
    /* C53F8 800D4BF8 24105200 */  and        $v0, $v0, $s2
    /* C53FC 800D4BFC 25186200 */  or         $v1, $v1, $v0
    /* C5400 800D4C00 C80063AE */  sw         $v1, 0xC8($s3)
    /* C5404 800D4C04 0000A28C */  lw         $v0, 0x0($a1)
    /* C5408 800D4C08 01000424 */  addiu      $a0, $zero, 0x1
    /* C540C 800D4C0C 24105400 */  and        $v0, $v0, $s4
    /* C5410 800D4C10 25105700 */  or         $v0, $v0, $s7
    /* C5414 800D4C14 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5418 800D4C18 0000A2AC */   sw        $v0, 0x0($a1)
    /* C541C 800D4C1C 17530308 */  j          .L800D4C5C
    /* C5420 800D4C20 14001026 */   addiu     $s0, $s0, 0x14
  .L800D4C24:
    /* C5424 800D4C24 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5428 800D4C28 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C542C 800D4C2C 0000038E */  lw         $v1, 0x0($s0)
    /* C5430 800D4C30 0000828C */  lw         $v0, 0x0($a0)
    /* C5434 800D4C34 24187400 */  and        $v1, $v1, $s4
    /* C5438 800D4C38 24105200 */  and        $v0, $v0, $s2
    /* C543C 800D4C3C 25186200 */  or         $v1, $v1, $v0
    /* C5440 800D4C40 000003AE */  sw         $v1, 0x0($s0)
    /* C5444 800D4C44 0000828C */  lw         $v0, 0x0($a0)
    /* C5448 800D4C48 24181202 */  and        $v1, $s0, $s2
    /* C544C 800D4C4C 24105400 */  and        $v0, $v0, $s4
    /* C5450 800D4C50 25104300 */  or         $v0, $v0, $v1
    /* C5454 800D4C54 000082AC */  sw         $v0, 0x0($a0)
    /* C5458 800D4C58 14001026 */  addiu      $s0, $s0, 0x14
  .L800D4C5C:
    /* C545C 800D4C5C 01003126 */  addiu      $s1, $s1, 0x1
    /* C5460 800D4C60 0C00222A */  slti       $v0, $s1, 0xC
    /* C5464 800D4C64 DBFF4014 */  bnez       $v0, .L800D4BD4
    /* C5468 800D4C68 0A000224 */   addiu     $v0, $zero, 0xA
    /* C546C 800D4C6C 76530308 */  j          .L800D4DD8
    /* C5470 800D4C70 FF00043C */   lui       $a0, (0xFFFFFF >> 16)
  .L800D4C74:
    /* C5474 800D4C74 E94E030C */  jal        Hud_BuildDistanceString__FP4SPRTi
    /* C5478 800D4C78 21282002 */   addu      $a1, $s1, $zero
    /* C547C 800D4C7C 71004010 */  beqz       $v0, .L800D4E44
    /* C5480 800D4C80 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* C5484 800D4C84 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* C5488 800D4C88 21100202 */  addu       $v0, $s0, $v0
    /* C548C 800D4C8C 0000428C */  lw         $v0, 0x0($v0)
    /* C5490 800D4C90 00000000 */  nop
    /* C5494 800D4C94 9803428C */  lw         $v0, 0x398($v0)
    /* C5498 800D4C98 00000000 */  nop
    /* C549C 800D4C9C 05004104 */  bgez       $v0, .L800D4CB4
    /* C54A0 800D4CA0 1180023C */   lui       $v0, %hi(D_801115D0)
    /* C54A4 800D4CA4 1180023C */  lui        $v0, %hi(D_801115E4)
    /* C54A8 800D4CA8 E415428C */  lw         $v0, %lo(D_801115E4)($v0)
    /* C54AC 800D4CAC 30530308 */  j          .L800D4CC0
    /* C54B0 800D4CB0 D40062AE */   sw        $v0, 0xD4($s3)
  .L800D4CB4:
    /* C54B4 800D4CB4 D015428C */  lw         $v0, %lo(D_801115D0)($v0)
    /* C54B8 800D4CB8 00000000 */  nop
    /* C54BC 800D4CBC D40062AE */  sw         $v0, 0xD4($s3)
  .L800D4CC0:
    /* C54C0 800D4CC0 1E001024 */  addiu      $s0, $zero, 0x1E
    /* C54C4 800D4CC4 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C54C8 800D4CC8 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C54CC 800D4CCC FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C54D0 800D4CD0 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C54D4 800D4CD4 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* C54D8 800D4CD8 58026426 */  addiu      $a0, $s3, 0x258
  .L800D4CDC:
    /* C54DC 800D4CDC 01001026 */  addiu      $s0, $s0, 0x1
    /* C54E0 800D4CE0 0000838C */  lw         $v1, 0x0($a0)
    /* C54E4 800D4CE4 0000C28C */  lw         $v0, 0x0($a2)
    /* C54E8 800D4CE8 24186700 */  and        $v1, $v1, $a3
    /* C54EC 800D4CEC 24104500 */  and        $v0, $v0, $a1
    /* C54F0 800D4CF0 25186200 */  or         $v1, $v1, $v0
    /* C54F4 800D4CF4 000083AC */  sw         $v1, 0x0($a0)
    /* C54F8 800D4CF8 24188500 */  and        $v1, $a0, $a1
    /* C54FC 800D4CFC 0000C28C */  lw         $v0, 0x0($a2)
    /* C5500 800D4D00 00000000 */  nop
    /* C5504 800D4D04 24104700 */  and        $v0, $v0, $a3
    /* C5508 800D4D08 25104300 */  or         $v0, $v0, $v1
    /* C550C 800D4D0C 0000C2AC */  sw         $v0, 0x0($a2)
    /* C5510 800D4D10 2300022A */  slti       $v0, $s0, 0x23
    /* C5514 800D4D14 F1FF4014 */  bnez       $v0, .L800D4CDC
    /* C5518 800D4D18 14008424 */   addiu     $a0, $a0, 0x14
    /* C551C 800D4D1C 0A001024 */  addiu      $s0, $zero, 0xA
    /* C5520 800D4D20 FF00123C */  lui        $s2, (0xFFFFFF >> 16)
    /* C5524 800D4D24 FFFF5236 */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* C5528 800D4D28 00FF143C */  lui        $s4, (0xFF000000 >> 16)
    /* C552C 800D4D2C C8006226 */  addiu      $v0, $s3, 0xC8
    /* C5530 800D4D30 24B85200 */  and        $s7, $v0, $s2
    /* C5534 800D4D34 21884000 */  addu       $s1, $v0, $zero
    /* C5538 800D4D38 0A000224 */  addiu      $v0, $zero, 0xA
  .L800D4D3C:
    /* C553C 800D4D3C 13000216 */  bne        $s0, $v0, .L800D4D8C
    /* C5540 800D4D40 00000000 */   nop
    /* C5544 800D4D44 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5548 800D4D48 21200000 */   addu      $a0, $zero, $zero
    /* C554C 800D4D4C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5550 800D4D50 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5554 800D4D54 C800638E */  lw         $v1, 0xC8($s3)
    /* C5558 800D4D58 0000A28C */  lw         $v0, 0x0($a1)
    /* C555C 800D4D5C 24187400 */  and        $v1, $v1, $s4
    /* C5560 800D4D60 24105200 */  and        $v0, $v0, $s2
    /* C5564 800D4D64 25186200 */  or         $v1, $v1, $v0
    /* C5568 800D4D68 C80063AE */  sw         $v1, 0xC8($s3)
    /* C556C 800D4D6C 0000A28C */  lw         $v0, 0x0($a1)
    /* C5570 800D4D70 01000424 */  addiu      $a0, $zero, 0x1
    /* C5574 800D4D74 24105400 */  and        $v0, $v0, $s4
    /* C5578 800D4D78 25105700 */  or         $v0, $v0, $s7
    /* C557C 800D4D7C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5580 800D4D80 0000A2AC */   sw        $v0, 0x0($a1)
    /* C5584 800D4D84 71530308 */  j          .L800D4DC4
    /* C5588 800D4D88 14003126 */   addiu     $s1, $s1, 0x14
  .L800D4D8C:
    /* C558C 800D4D8C 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5590 800D4D90 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5594 800D4D94 0000238E */  lw         $v1, 0x0($s1)
    /* C5598 800D4D98 0000828C */  lw         $v0, 0x0($a0)
    /* C559C 800D4D9C 24187400 */  and        $v1, $v1, $s4
    /* C55A0 800D4DA0 24105200 */  and        $v0, $v0, $s2
    /* C55A4 800D4DA4 25186200 */  or         $v1, $v1, $v0
    /* C55A8 800D4DA8 000023AE */  sw         $v1, 0x0($s1)
    /* C55AC 800D4DAC 0000828C */  lw         $v0, 0x0($a0)
    /* C55B0 800D4DB0 24183202 */  and        $v1, $s1, $s2
    /* C55B4 800D4DB4 24105400 */  and        $v0, $v0, $s4
    /* C55B8 800D4DB8 25104300 */  or         $v0, $v0, $v1
    /* C55BC 800D4DBC 000082AC */  sw         $v0, 0x0($a0)
    /* C55C0 800D4DC0 14003126 */  addiu      $s1, $s1, 0x14
  .L800D4DC4:
    /* C55C4 800D4DC4 01001026 */  addiu      $s0, $s0, 0x1
    /* C55C8 800D4DC8 0C00022A */  slti       $v0, $s0, 0xC
    /* C55CC 800D4DCC DBFF4014 */  bnez       $v0, .L800D4D3C
    /* C55D0 800D4DD0 0A000224 */   addiu     $v0, $zero, 0xA
    /* C55D4 800D4DD4 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
  .L800D4DD8:
    /* C55D8 800D4DD8 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* C55DC 800D4DDC 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C55E0 800D4DE0 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C55E4 800D4DE4 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C55E8 800D4DE8 4800A38E */  lw         $v1, 0x48($s5)
    /* C55EC 800D4DEC 0000A28C */  lw         $v0, 0x0($a1)
    /* C55F0 800D4DF0 24186600 */  and        $v1, $v1, $a2
    /* C55F4 800D4DF4 24104400 */  and        $v0, $v0, $a0
    /* C55F8 800D4DF8 25186200 */  or         $v1, $v1, $v0
    /* C55FC 800D4DFC 4800A226 */  addiu      $v0, $s5, 0x48
    /* C5600 800D4E00 4800A3AE */  sw         $v1, 0x48($s5)
    /* C5604 800D4E04 0000A38C */  lw         $v1, 0x0($a1)
    /* C5608 800D4E08 24104400 */  and        $v0, $v0, $a0
    /* C560C 800D4E0C 24186600 */  and        $v1, $v1, $a2
    /* C5610 800D4E10 25186200 */  or         $v1, $v1, $v0
    /* C5614 800D4E14 0000A3AC */  sw         $v1, 0x0($a1)
    /* C5618 800D4E18 4800C28E */  lw         $v0, 0x48($s6)
    /* C561C 800D4E1C 24186400 */  and        $v1, $v1, $a0
    /* C5620 800D4E20 24104600 */  and        $v0, $v0, $a2
    /* C5624 800D4E24 25104300 */  or         $v0, $v0, $v1
    /* C5628 800D4E28 4800C2AE */  sw         $v0, 0x48($s6)
    /* C562C 800D4E2C 4800C226 */  addiu      $v0, $s6, 0x48
    /* C5630 800D4E30 0000A38C */  lw         $v1, 0x0($a1)
    /* C5634 800D4E34 24104400 */  and        $v0, $v0, $a0
    /* C5638 800D4E38 24186600 */  and        $v1, $v1, $a2
    /* C563C 800D4E3C 25186200 */  or         $v1, $v1, $v0
    /* C5640 800D4E40 0000A3AC */  sw         $v1, 0x0($a1)
  .L800D4E44:
    /* C5644 800D4E44 3000BF8F */  lw         $ra, 0x30($sp)
    /* C5648 800D4E48 2C00B78F */  lw         $s7, 0x2C($sp)
    /* C564C 800D4E4C 2800B68F */  lw         $s6, 0x28($sp)
    /* C5650 800D4E50 2400B58F */  lw         $s5, 0x24($sp)
    /* C5654 800D4E54 2000B48F */  lw         $s4, 0x20($sp)
    /* C5658 800D4E58 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C565C 800D4E5C 1800B28F */  lw         $s2, 0x18($sp)
    /* C5660 800D4E60 1400B18F */  lw         $s1, 0x14($sp)
    /* C5664 800D4E64 1000B08F */  lw         $s0, 0x10($sp)
    /* C5668 800D4E68 0800E003 */  jr         $ra
    /* C566C 800D4E6C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Hud_BuildNumbers0__Fi
