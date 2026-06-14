.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildNumbers__Fi, 0xBD8

glabel Hud_BuildNumbers__Fi
    /* C5670 800D4E70 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* C5674 800D4E74 4800BEAF */  sw         $fp, 0x48($sp)
    /* C5678 800D4E78 21F08000 */  addu       $fp, $a0, $zero
    /* C567C 800D4E7C 3000B2AF */  sw         $s2, 0x30($sp)
    /* C5680 800D4E80 2190C003 */  addu       $s2, $fp, $zero
    /* C5684 800D4E84 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* C5688 800D4E88 4400B7AF */  sw         $s7, 0x44($sp)
    /* C568C 800D4E8C 4000B6AF */  sw         $s6, 0x40($sp)
    /* C5690 800D4E90 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* C5694 800D4E94 3800B4AF */  sw         $s4, 0x38($sp)
    /* C5698 800D4E98 3400B3AF */  sw         $s3, 0x34($sp)
    /* C569C 800D4E9C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* C56A0 800D4EA0 0400C013 */  beqz       $fp, .L800D4EB4
    /* C56A4 800D4EA4 2800B0AF */   sw        $s0, 0x28($sp)
    /* C56A8 800D4EA8 C018958F */  lw         $s5, %gp_rel(D_8013DE0C)($gp)
    /* C56AC 800D4EAC AF530308 */  j          .L800D4EBC
    /* C56B0 800D4EB0 1480023C */   lui       $v0, %hi(D_8013E450)
  .L800D4EB4:
    /* C56B4 800D4EB4 BC18958F */  lw         $s5, %gp_rel(D_8013DE08)($gp)
    /* C56B8 800D4EB8 1480023C */  lui        $v0, %hi(D_8013E450)
  .L800D4EBC:
    /* C56BC 800D4EBC 02004012 */  beqz       $s2, .L800D4EC8
    /* C56C0 800D4EC0 50E45124 */   addiu     $s1, $v0, %lo(D_8013E450)
    /* C56C4 800D4EC4 A8003126 */  addiu      $s1, $s1, 0xA8
  .L800D4EC8:
    /* C56C8 800D4EC8 1480023C */  lui        $v0, %hi(D_8013E730)
    /* C56CC 800D4ECC 02004012 */  beqz       $s2, .L800D4ED8
    /* C56D0 800D4ED0 30E75024 */   addiu     $s0, $v0, %lo(D_8013E730)
    /* C56D4 800D4ED4 90001026 */  addiu      $s0, $s0, 0x90
  .L800D4ED8:
    /* C56D8 800D4ED8 02004012 */  beqz       $s2, .L800D4EE4
    /* C56DC 800D4EDC 21B00000 */   addu      $s6, $zero, $zero
    /* C56E0 800D4EE0 F1FF1624 */  addiu      $s6, $zero, -0xF
  .L800D4EE4:
    /* C56E4 800D4EE4 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C56E8 800D4EE8 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C56EC 800D4EEC 40181E00 */  sll        $v1, $fp, 1
    /* C56F0 800D4EF0 21187E00 */  addu       $v1, $v1, $fp
    /* C56F4 800D4EF4 00110300 */  sll        $v0, $v1, 4
    /* C56F8 800D4EF8 23104300 */  subu       $v0, $v0, $v1
    /* C56FC 800D4EFC 80100200 */  sll        $v0, $v0, 2
    /* C5700 800D4F00 21104400 */  addu       $v0, $v0, $a0
    /* C5704 800D4F04 5C04428C */  lw         $v0, 0x45C($v0)
    /* C5708 800D4F08 00000000 */  nop
    /* C570C 800D4F0C 61004010 */  beqz       $v0, .L800D5094
    /* C5710 800D4F10 1180043C */   lui       $a0, %hi(GameSetup_gData)
    /* C5714 800D4F14 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C5718 800D4F18 00000000 */  nop
    /* C571C 800D4F1C 5E004014 */  bnez       $v0, .L800D5098
    /* C5720 800D4F20 EC318424 */   addiu     $a0, $a0, %lo(GameSetup_gData)
    /* C5724 800D4F24 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C5728 800D4F28 30274424 */  addiu      $a0, $v0, %lo(DashHUD_gInfo)
    /* C572C 800D4F2C 3C00838C */  lw         $v1, 0x3C($a0)
    /* C5730 800D4F30 01000224 */  addiu      $v0, $zero, 0x1
    /* C5734 800D4F34 56006210 */  beq        $v1, $v0, .L800D5090
    /* C5738 800D4F38 14000624 */   addiu     $a2, $zero, 0x14
    /* C573C 800D4F3C FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* C5740 800D4F40 1180033C */  lui        $v1, %hi(HudPmx_gHudNumberUV)
    /* C5744 800D4F44 3800828C */  lw         $v0, 0x38($a0)
    /* C5748 800D4F48 700C6324 */  addiu      $v1, $v1, %lo(HudPmx_gHudNumberUV)
    /* C574C 800D4F4C 80100200 */  sll        $v0, $v0, 2
    /* C5750 800D4F50 21104300 */  addu       $v0, $v0, $v1
    /* C5754 800D4F54 0000428C */  lw         $v0, 0x0($v0)
    /* C5758 800D4F58 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* C575C 800D4F5C 9C01A2AE */  sw         $v0, 0x19C($s5)
    /* C5760 800D4F60 3C00828C */  lw         $v0, 0x3C($a0)
    /* C5764 800D4F64 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C5768 800D4F68 80100200 */  sll        $v0, $v0, 2
    /* C576C 800D4F6C 21104300 */  addu       $v0, $v0, $v1
    /* C5770 800D4F70 0000428C */  lw         $v0, 0x0($v0)
    /* C5774 800D4F74 9001A426 */  addiu      $a0, $s5, 0x190
    /* C5778 800D4F78 C401A2AE */  sw         $v0, 0x1C4($s5)
    /* C577C 800D4F7C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5780 800D4F80 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
  .L800D4F84:
    /* C5784 800D4F84 0100C624 */  addiu      $a2, $a2, 0x1
    /* C5788 800D4F88 0000838C */  lw         $v1, 0x0($a0)
    /* C578C 800D4F8C 0000A28C */  lw         $v0, 0x0($a1)
    /* C5790 800D4F90 24186800 */  and        $v1, $v1, $t0
    /* C5794 800D4F94 24104700 */  and        $v0, $v0, $a3
    /* C5798 800D4F98 25186200 */  or         $v1, $v1, $v0
    /* C579C 800D4F9C 000083AC */  sw         $v1, 0x0($a0)
    /* C57A0 800D4FA0 24188700 */  and        $v1, $a0, $a3
    /* C57A4 800D4FA4 0000A28C */  lw         $v0, 0x0($a1)
    /* C57A8 800D4FA8 00000000 */  nop
    /* C57AC 800D4FAC 24104800 */  and        $v0, $v0, $t0
    /* C57B0 800D4FB0 25104300 */  or         $v0, $v0, $v1
    /* C57B4 800D4FB4 0000A2AC */  sw         $v0, 0x0($a1)
    /* C57B8 800D4FB8 1700C228 */  slti       $v0, $a2, 0x17
    /* C57BC 800D4FBC F1FF4014 */  bnez       $v0, .L800D4F84
    /* C57C0 800D4FC0 14008424 */   addiu     $a0, $a0, 0x14
    /* C57C4 800D4FC4 06000624 */  addiu      $a2, $zero, 0x6
    /* C57C8 800D4FC8 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C57CC 800D4FCC 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C57D0 800D4FD0 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C57D4 800D4FD4 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C57D8 800D4FD8 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C57DC 800D4FDC 7800A426 */  addiu      $a0, $s5, 0x78
  .L800D4FE0:
    /* C57E0 800D4FE0 0100C624 */  addiu      $a2, $a2, 0x1
    /* C57E4 800D4FE4 0000838C */  lw         $v1, 0x0($a0)
    /* C57E8 800D4FE8 0000E28C */  lw         $v0, 0x0($a3)
    /* C57EC 800D4FEC 24186800 */  and        $v1, $v1, $t0
    /* C57F0 800D4FF0 24104500 */  and        $v0, $v0, $a1
    /* C57F4 800D4FF4 25186200 */  or         $v1, $v1, $v0
    /* C57F8 800D4FF8 000083AC */  sw         $v1, 0x0($a0)
    /* C57FC 800D4FFC 24188500 */  and        $v1, $a0, $a1
    /* C5800 800D5000 0000E28C */  lw         $v0, 0x0($a3)
    /* C5804 800D5004 00000000 */  nop
    /* C5808 800D5008 24104800 */  and        $v0, $v0, $t0
    /* C580C 800D500C 25104300 */  or         $v0, $v0, $v1
    /* C5810 800D5010 0000E2AC */  sw         $v0, 0x0($a3)
    /* C5814 800D5014 0800C228 */  slti       $v0, $a2, 0x8
    /* C5818 800D5018 F1FF4014 */  bnez       $v0, .L800D4FE0
    /* C581C 800D501C 14008424 */   addiu     $a0, $a0, 0x14
    /* C5820 800D5020 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* C5824 800D5024 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* C5828 800D5028 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C582C 800D502C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5830 800D5030 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5834 800D5034 2400038E */  lw         $v1, 0x24($s0)
    /* C5838 800D5038 0000A28C */  lw         $v0, 0x0($a1)
    /* C583C 800D503C 24186600 */  and        $v1, $v1, $a2
    /* C5840 800D5040 24104400 */  and        $v0, $v0, $a0
    /* C5844 800D5044 25186200 */  or         $v1, $v1, $v0
    /* C5848 800D5048 24000226 */  addiu      $v0, $s0, 0x24
    /* C584C 800D504C 240003AE */  sw         $v1, 0x24($s0)
    /* C5850 800D5050 0000A38C */  lw         $v1, 0x0($a1)
    /* C5854 800D5054 24104400 */  and        $v0, $v0, $a0
    /* C5858 800D5058 24186600 */  and        $v1, $v1, $a2
    /* C585C 800D505C 25186200 */  or         $v1, $v1, $v0
    /* C5860 800D5060 0000A3AC */  sw         $v1, 0x0($a1)
    /* C5864 800D5064 1800228E */  lw         $v0, 0x18($s1)
    /* C5868 800D5068 24186400 */  and        $v1, $v1, $a0
    /* C586C 800D506C 24104600 */  and        $v0, $v0, $a2
    /* C5870 800D5070 25104300 */  or         $v0, $v0, $v1
    /* C5874 800D5074 180022AE */  sw         $v0, 0x18($s1)
    /* C5878 800D5078 18002226 */  addiu      $v0, $s1, 0x18
    /* C587C 800D507C 0000A38C */  lw         $v1, 0x0($a1)
    /* C5880 800D5080 24104400 */  and        $v0, $v0, $a0
    /* C5884 800D5084 24186600 */  and        $v1, $v1, $a2
    /* C5888 800D5088 25186200 */  or         $v1, $v1, $v0
    /* C588C 800D508C 0000A3AC */  sw         $v1, 0x0($a1)
  .L800D5090:
    /* C5890 800D5090 1180043C */  lui        $a0, %hi(GameSetup_gData)
  .L800D5094:
    /* C5894 800D5094 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
  .L800D5098:
    /* C5898 800D5098 40181E00 */  sll        $v1, $fp, 1
    /* C589C 800D509C 21187E00 */  addu       $v1, $v1, $fp
    /* C58A0 800D50A0 00110300 */  sll        $v0, $v1, 4
    /* C58A4 800D50A4 23104300 */  subu       $v0, $v0, $v1
    /* C58A8 800D50A8 80100200 */  sll        $v0, $v0, 2
    /* C58AC 800D50AC 21104400 */  addu       $v0, $v0, $a0
    /* C58B0 800D50B0 5804428C */  lw         $v0, 0x458($v0)
    /* C58B4 800D50B4 00000000 */  nop
    /* C58B8 800D50B8 6A004010 */  beqz       $v0, .L800D5264
    /* C58BC 800D50BC 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C58C0 800D50C0 30274424 */  addiu      $a0, $v0, %lo(DashHUD_gInfo)
    /* C58C4 800D50C4 5C00858C */  lw         $a1, 0x5C($a0)
    /* C58C8 800D50C8 00000000 */  nop
    /* C58CC 800D50CC 6500A010 */  beqz       $a1, .L800D5264
    /* C58D0 800D50D0 FF950234 */   ori       $v0, $zero, 0x95FF
    /* C58D4 800D50D4 2A104500 */  slt        $v0, $v0, $a1
    /* C58D8 800D50D8 62004014 */  bnez       $v0, .L800D5264
    /* C58DC 800D50DC 00000000 */   nop
    /* C58E0 800D50E0 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C58E4 800D50E4 00000000 */  nop
    /* C58E8 800D50E8 5E004014 */  bnez       $v0, .L800D5264
    /* C58EC 800D50EC 00000000 */   nop
    /* C58F0 800D50F0 FC18828F */  lw         $v0, %gp_rel(D_8013DE48)($gp)
    /* C58F4 800D50F4 00000000 */  nop
    /* C58F8 800D50F8 5A004014 */  bnez       $v0, .L800D5264
    /* C58FC 800D50FC 01000224 */   addiu     $v0, $zero, 0x1
    /* C5900 800D5100 3C00838C */  lw         $v1, 0x3C($a0)
    /* C5904 800D5104 00000000 */  nop
    /* C5908 800D5108 56006210 */  beq        $v1, $v0, .L800D5264
    /* C590C 800D510C 00000000 */   nop
    /* C5910 800D5110 1400828C */  lw         $v0, 0x14($a0)
    /* C5914 800D5114 00000000 */  nop
    /* C5918 800D5118 06004010 */  beqz       $v0, .L800D5134
    /* C591C 800D511C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* C5920 800D5120 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C5924 800D5124 00000000 */  nop
    /* C5928 800D5128 10004230 */  andi       $v0, $v0, 0x10
    /* C592C 800D512C 03004014 */  bnez       $v0, .L800D513C
    /* C5930 800D5130 00000000 */   nop
  .L800D5134:
    /* C5934 800D5134 514F030C */  jal        Hud_BuildTimeString__FP4SPRTi
    /* C5938 800D5138 CC01A426 */   addiu     $a0, $s5, 0x1CC
  .L800D513C:
    /* C593C 800D513C 17000524 */  addiu      $a1, $zero, 0x17
    /* C5940 800D5140 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C5944 800D5144 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C5948 800D5148 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* C594C 800D514C FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* C5950 800D5150 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C5954 800D5154 CC01A426 */  addiu      $a0, $s5, 0x1CC
  .L800D5158:
    /* C5958 800D5158 0100A524 */  addiu      $a1, $a1, 0x1
    /* C595C 800D515C 0000838C */  lw         $v1, 0x0($a0)
    /* C5960 800D5160 0000E28C */  lw         $v0, 0x0($a3)
    /* C5964 800D5164 24186800 */  and        $v1, $v1, $t0
    /* C5968 800D5168 24104600 */  and        $v0, $v0, $a2
    /* C596C 800D516C 25186200 */  or         $v1, $v1, $v0
    /* C5970 800D5170 000083AC */  sw         $v1, 0x0($a0)
    /* C5974 800D5174 24188600 */  and        $v1, $a0, $a2
    /* C5978 800D5178 0000E28C */  lw         $v0, 0x0($a3)
    /* C597C 800D517C 00000000 */  nop
    /* C5980 800D5180 24104800 */  and        $v0, $v0, $t0
    /* C5984 800D5184 25104300 */  or         $v0, $v0, $v1
    /* C5988 800D5188 0000E2AC */  sw         $v0, 0x0($a3)
    /* C598C 800D518C 1E00A228 */  slti       $v0, $a1, 0x1E
    /* C5990 800D5190 F1FF4014 */  bnez       $v0, .L800D5158
    /* C5994 800D5194 14008424 */   addiu     $a0, $a0, 0x14
    /* C5998 800D5198 08000524 */  addiu      $a1, $zero, 0x8
    /* C599C 800D519C 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C59A0 800D51A0 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C59A4 800D51A4 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* C59A8 800D51A8 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* C59AC 800D51AC 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C59B0 800D51B0 A000A426 */  addiu      $a0, $s5, 0xA0
  .L800D51B4:
    /* C59B4 800D51B4 0100A524 */  addiu      $a1, $a1, 0x1
    /* C59B8 800D51B8 0000838C */  lw         $v1, 0x0($a0)
    /* C59BC 800D51BC 0000E28C */  lw         $v0, 0x0($a3)
    /* C59C0 800D51C0 24186800 */  and        $v1, $v1, $t0
    /* C59C4 800D51C4 24104600 */  and        $v0, $v0, $a2
    /* C59C8 800D51C8 25186200 */  or         $v1, $v1, $v0
    /* C59CC 800D51CC 000083AC */  sw         $v1, 0x0($a0)
    /* C59D0 800D51D0 24188600 */  and        $v1, $a0, $a2
    /* C59D4 800D51D4 0000E28C */  lw         $v0, 0x0($a3)
    /* C59D8 800D51D8 00000000 */  nop
    /* C59DC 800D51DC 24104800 */  and        $v0, $v0, $t0
    /* C59E0 800D51E0 25104300 */  or         $v0, $v0, $v1
    /* C59E4 800D51E4 0000E2AC */  sw         $v0, 0x0($a3)
    /* C59E8 800D51E8 0A00A228 */  slti       $v0, $a1, 0xA
    /* C59EC 800D51EC F1FF4014 */  bnez       $v0, .L800D51B4
    /* C59F0 800D51F0 14008424 */   addiu     $a0, $a0, 0x14
    /* C59F4 800D51F4 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* C59F8 800D51F8 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* C59FC 800D51FC 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C5A00 800D5200 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5A04 800D5204 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5A08 800D5208 6C00038E */  lw         $v1, 0x6C($s0)
    /* C5A0C 800D520C 0000A28C */  lw         $v0, 0x0($a1)
    /* C5A10 800D5210 24186600 */  and        $v1, $v1, $a2
    /* C5A14 800D5214 24104400 */  and        $v0, $v0, $a0
    /* C5A18 800D5218 25186200 */  or         $v1, $v1, $v0
    /* C5A1C 800D521C 6C000226 */  addiu      $v0, $s0, 0x6C
    /* C5A20 800D5220 6C0003AE */  sw         $v1, 0x6C($s0)
    /* C5A24 800D5224 0000A38C */  lw         $v1, 0x0($a1)
    /* C5A28 800D5228 24104400 */  and        $v0, $v0, $a0
    /* C5A2C 800D522C 24186600 */  and        $v1, $v1, $a2
    /* C5A30 800D5230 25186200 */  or         $v1, $v1, $v0
    /* C5A34 800D5234 0000A3AC */  sw         $v1, 0x0($a1)
    /* C5A38 800D5238 3000228E */  lw         $v0, 0x30($s1)
    /* C5A3C 800D523C 24186400 */  and        $v1, $v1, $a0
    /* C5A40 800D5240 24104600 */  and        $v0, $v0, $a2
    /* C5A44 800D5244 25104300 */  or         $v0, $v0, $v1
    /* C5A48 800D5248 300022AE */  sw         $v0, 0x30($s1)
    /* C5A4C 800D524C 30002226 */  addiu      $v0, $s1, 0x30
    /* C5A50 800D5250 0000A38C */  lw         $v1, 0x0($a1)
    /* C5A54 800D5254 24104400 */  and        $v0, $v0, $a0
    /* C5A58 800D5258 24186600 */  and        $v1, $v1, $a2
    /* C5A5C 800D525C 25186200 */  or         $v1, $v1, $v0
    /* C5A60 800D5260 0000A3AC */  sw         $v1, 0x0($a1)
  .L800D5264:
    /* C5A64 800D5264 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C5A68 800D5268 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C5A6C 800D526C 40181E00 */  sll        $v1, $fp, 1
    /* C5A70 800D5270 21187E00 */  addu       $v1, $v1, $fp
    /* C5A74 800D5274 00110300 */  sll        $v0, $v1, 4
    /* C5A78 800D5278 23104300 */  subu       $v0, $v0, $v1
    /* C5A7C 800D527C 80100200 */  sll        $v0, $v0, 2
    /* C5A80 800D5280 21104400 */  addu       $v0, $v0, $a0
    /* C5A84 800D5284 6004428C */  lw         $v0, 0x460($v0)
    /* C5A88 800D5288 00000000 */  nop
    /* C5A8C 800D528C 74004010 */  beqz       $v0, .L800D5460
    /* C5A90 800D5290 00000000 */   nop
    /* C5A94 800D5294 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C5A98 800D5298 00000000 */  nop
    /* C5A9C 800D529C 70004014 */  bnez       $v0, .L800D5460
    /* C5AA0 800D52A0 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C5AA4 800D52A4 30274A24 */  addiu      $t2, $v0, %lo(DashHUD_gInfo)
    /* C5AA8 800D52A8 5800428D */  lw         $v0, 0x58($t2)
    /* C5AAC 800D52AC 00000000 */  nop
    /* C5AB0 800D52B0 02004228 */  slti       $v0, $v0, 0x2
    /* C5AB4 800D52B4 6A004014 */  bnez       $v0, .L800D5460
    /* C5AB8 800D52B8 1180063C */   lui       $a2, %hi(HudPmx_gShapes)
    /* C5ABC 800D52BC 980CC624 */  addiu      $a2, $a2, %lo(HudPmx_gShapes)
    /* C5AC0 800D52C0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C5AC4 800D52C4 8003C594 */  lhu        $a1, 0x380($a2)
    /* C5AC8 800D52C8 5400438D */  lw         $v1, 0x54($t2)
    /* C5ACC 800D52CC FEFFA524 */  addiu      $a1, $a1, -0x2
    /* C5AD0 800D52D0 38004494 */  lhu        $a0, 0x38($v0)
    /* C5AD4 800D52D4 28004294 */  lhu        $v0, 0x28($v0)
    /* C5AD8 800D52D8 2C006324 */  addiu      $v1, $v1, 0x2C
    /* C5ADC 800D52DC 21208200 */  addu       $a0, $a0, $v0
    /* C5AE0 800D52E0 80100300 */  sll        $v0, $v1, 2
    /* C5AE4 800D52E4 21104300 */  addu       $v0, $v0, $v1
    /* C5AE8 800D52E8 80100200 */  sll        $v0, $v0, 2
    /* C5AEC 800D52EC 21104600 */  addu       $v0, $v0, $a2
    /* C5AF0 800D52F0 10004294 */  lhu        $v0, 0x10($v0)
    /* C5AF4 800D52F4 21208500 */  addu       $a0, $a0, $a1
    /* C5AF8 800D52F8 23208200 */  subu       $a0, $a0, $v0
    /* C5AFC 800D52FC EC02A4A6 */  sh         $a0, 0x2EC($s5)
    /* C5B00 800D5300 5400438D */  lw         $v1, 0x54($t2)
    /* C5B04 800D5304 00000000 */  nop
    /* C5B08 800D5308 80100300 */  sll        $v0, $v1, 2
    /* C5B0C 800D530C 21104300 */  addu       $v0, $v0, $v1
    /* C5B10 800D5310 80100200 */  sll        $v0, $v0, 2
    /* C5B14 800D5314 2110C200 */  addu       $v0, $a2, $v0
    /* C5B18 800D5318 7003428C */  lw         $v0, 0x370($v0)
    /* C5B1C 800D531C 00000000 */  nop
    /* C5B20 800D5320 F002A2AE */  sw         $v0, 0x2F0($s5)
    /* C5B24 800D5324 5400438D */  lw         $v1, 0x54($t2)
    /* C5B28 800D5328 25000724 */  addiu      $a3, $zero, 0x25
    /* C5B2C 800D532C 2C006324 */  addiu      $v1, $v1, 0x2C
    /* C5B30 800D5330 80100300 */  sll        $v0, $v1, 2
    /* C5B34 800D5334 21104300 */  addu       $v0, $v0, $v1
    /* C5B38 800D5338 80100200 */  sll        $v0, $v0, 2
    /* C5B3C 800D533C 21104600 */  addu       $v0, $v0, $a2
    /* C5B40 800D5340 10004294 */  lhu        $v0, 0x10($v0)
    /* C5B44 800D5344 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* C5B48 800D5348 F402A2A6 */  sh         $v0, 0x2F4($s5)
    /* C5B4C 800D534C 5800438D */  lw         $v1, 0x58($t2)
    /* C5B50 800D5350 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* C5B54 800D5354 80100300 */  sll        $v0, $v1, 2
    /* C5B58 800D5358 21104300 */  addu       $v0, $v0, $v1
    /* C5B5C 800D535C 80100200 */  sll        $v0, $v0, 2
    /* C5B60 800D5360 2110C200 */  addu       $v0, $a2, $v0
    /* C5B64 800D5364 2404428C */  lw         $v0, 0x424($v0)
    /* C5B68 800D5368 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C5B6C 800D536C 1803A2AE */  sw         $v0, 0x318($s5)
    /* C5B70 800D5370 5800438D */  lw         $v1, 0x58($t2)
    /* C5B74 800D5374 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5B78 800D5378 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5B7C 800D537C 35006324 */  addiu      $v1, $v1, 0x35
    /* C5B80 800D5380 80100300 */  sll        $v0, $v1, 2
    /* C5B84 800D5384 21104300 */  addu       $v0, $v0, $v1
    /* C5B88 800D5388 80100200 */  sll        $v0, $v0, 2
    /* C5B8C 800D538C 21104600 */  addu       $v0, $v0, $a2
    /* C5B90 800D5390 10004294 */  lhu        $v0, 0x10($v0)
    /* C5B94 800D5394 E402A426 */  addiu      $a0, $s5, 0x2E4
    /* C5B98 800D5398 1C03A2A6 */  sh         $v0, 0x31C($s5)
  .L800D539C:
    /* C5B9C 800D539C 0100E724 */  addiu      $a3, $a3, 0x1
    /* C5BA0 800D53A0 0000838C */  lw         $v1, 0x0($a0)
    /* C5BA4 800D53A4 0000A28C */  lw         $v0, 0x0($a1)
    /* C5BA8 800D53A8 24186900 */  and        $v1, $v1, $t1
    /* C5BAC 800D53AC 24104800 */  and        $v0, $v0, $t0
    /* C5BB0 800D53B0 25186200 */  or         $v1, $v1, $v0
    /* C5BB4 800D53B4 000083AC */  sw         $v1, 0x0($a0)
    /* C5BB8 800D53B8 24188800 */  and        $v1, $a0, $t0
    /* C5BBC 800D53BC 0000A28C */  lw         $v0, 0x0($a1)
    /* C5BC0 800D53C0 00000000 */  nop
    /* C5BC4 800D53C4 24104900 */  and        $v0, $v0, $t1
    /* C5BC8 800D53C8 25104300 */  or         $v0, $v0, $v1
    /* C5BCC 800D53CC 0000A2AC */  sw         $v0, 0x0($a1)
    /* C5BD0 800D53D0 2800E228 */  slti       $v0, $a3, 0x28
    /* C5BD4 800D53D4 F1FF4014 */  bnez       $v0, .L800D539C
    /* C5BD8 800D53D8 14008424 */   addiu     $a0, $a0, 0x14
    /* C5BDC 800D53DC 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C5BE0 800D53E0 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C5BE4 800D53E4 40180700 */  sll        $v1, $a3, 1
    /* C5BE8 800D53E8 21186700 */  addu       $v1, $v1, $a3
    /* C5BEC 800D53EC 00110300 */  sll        $v0, $v1, 4
    /* C5BF0 800D53F0 23104300 */  subu       $v0, $v0, $v1
    /* C5BF4 800D53F4 80100200 */  sll        $v0, $v0, 2
    /* C5BF8 800D53F8 21104400 */  addu       $v0, $v0, $a0
    /* C5BFC 800D53FC 5004428C */  lw         $v0, 0x450($v0)
    /* C5C00 800D5400 00000000 */  nop
    /* C5C04 800D5404 16004010 */  beqz       $v0, .L800D5460
    /* C5C08 800D5408 00000000 */   nop
    /* C5C0C 800D540C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5C10 800D5410 21200000 */   addu      $a0, $zero, $zero
    /* C5C14 800D5414 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* C5C18 800D5418 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* C5C1C 800D541C 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* C5C20 800D5420 01000424 */  addiu      $a0, $zero, 0x1
    /* C5C24 800D5424 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C5C28 800D5428 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C5C2C 800D542C 2003A38E */  lw         $v1, 0x320($s5)
    /* C5C30 800D5430 0000A28C */  lw         $v0, 0x0($a1)
    /* C5C34 800D5434 24186700 */  and        $v1, $v1, $a3
    /* C5C38 800D5438 24104600 */  and        $v0, $v0, $a2
    /* C5C3C 800D543C 25186200 */  or         $v1, $v1, $v0
    /* C5C40 800D5440 2003A226 */  addiu      $v0, $s5, 0x320
    /* C5C44 800D5444 2003A3AE */  sw         $v1, 0x320($s5)
    /* C5C48 800D5448 0000A38C */  lw         $v1, 0x0($a1)
    /* C5C4C 800D544C 24104600 */  and        $v0, $v0, $a2
    /* C5C50 800D5450 24186700 */  and        $v1, $v1, $a3
    /* C5C54 800D5454 25186200 */  or         $v1, $v1, $v0
    /* C5C58 800D5458 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5C5C 800D545C 0000A3AC */   sw        $v1, 0x0($a1)
  .L800D5460:
    /* C5C60 800D5460 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5C64 800D5464 21200000 */   addu      $a0, $zero, $zero
    /* C5C68 800D5468 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C5C6C 800D546C EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C5C70 800D5470 40181E00 */  sll        $v1, $fp, 1
    /* C5C74 800D5474 21187E00 */  addu       $v1, $v1, $fp
    /* C5C78 800D5478 00110300 */  sll        $v0, $v1, 4
    /* C5C7C 800D547C 23104300 */  subu       $v0, $v0, $v1
    /* C5C80 800D5480 80100200 */  sll        $v0, $v0, 2
    /* C5C84 800D5484 21104400 */  addu       $v0, $v0, $a0
    /* C5C88 800D5488 4C04428C */  lw         $v0, 0x44C($v0)
    /* C5C8C 800D548C 00000000 */  nop
    /* C5C90 800D5490 6B004010 */  beqz       $v0, .L800D5640
    /* C5C94 800D5494 1180023C */   lui       $v0, %hi(D_80112778)
    /* C5C98 800D5498 7827438C */  lw         $v1, %lo(D_80112778)($v0)
    /* C5C9C 800D549C 00000000 */  nop
    /* C5CA0 800D54A0 05006010 */  beqz       $v1, .L800D54B8
    /* C5CA4 800D54A4 01000224 */   addiu     $v0, $zero, 0x1
    /* C5CA8 800D54A8 10006210 */  beq        $v1, $v0, .L800D54EC
    /* C5CAC 800D54AC FF00073C */   lui       $a3, (0xFFFFFF >> 16)
    /* C5CB0 800D54B0 4D550308 */  j          .L800D5534
    /* C5CB4 800D54B4 1180053C */   lui       $a1, %hi(DashHUD_gInfo)
  .L800D54B8:
    /* C5CB8 800D54B8 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C5CBC 800D54BC FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5CC0 800D54C0 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C5CC4 800D54C4 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5CC8 800D54C8 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5CCC 800D54CC C003A38E */  lw         $v1, 0x3C0($s5)
    /* C5CD0 800D54D0 0000828C */  lw         $v0, 0x0($a0)
    /* C5CD4 800D54D4 24186600 */  and        $v1, $v1, $a2
    /* C5CD8 800D54D8 24104500 */  and        $v0, $v0, $a1
    /* C5CDC 800D54DC 25186200 */  or         $v1, $v1, $v0
    /* C5CE0 800D54E0 C003A226 */  addiu      $v0, $s5, 0x3C0
    /* C5CE4 800D54E4 47550308 */  j          .L800D551C
    /* C5CE8 800D54E8 C003A3AE */   sw        $v1, 0x3C0($s5)
  .L800D54EC:
    /* C5CEC 800D54EC FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C5CF0 800D54F0 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5CF4 800D54F4 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C5CF8 800D54F8 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5CFC 800D54FC 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5D00 800D5500 AC03A38E */  lw         $v1, 0x3AC($s5)
    /* C5D04 800D5504 0000828C */  lw         $v0, 0x0($a0)
    /* C5D08 800D5508 24186600 */  and        $v1, $v1, $a2
    /* C5D0C 800D550C 24104500 */  and        $v0, $v0, $a1
    /* C5D10 800D5510 25186200 */  or         $v1, $v1, $v0
    /* C5D14 800D5514 AC03A226 */  addiu      $v0, $s5, 0x3AC
    /* C5D18 800D5518 AC03A3AE */  sw         $v1, 0x3AC($s5)
  .L800D551C:
    /* C5D1C 800D551C 0000838C */  lw         $v1, 0x0($a0)
    /* C5D20 800D5520 24104500 */  and        $v0, $v0, $a1
    /* C5D24 800D5524 24186600 */  and        $v1, $v1, $a2
    /* C5D28 800D5528 25186200 */  or         $v1, $v1, $v0
    /* C5D2C 800D552C 68550308 */  j          .L800D55A0
    /* C5D30 800D5530 000083AC */   sw        $v1, 0x0($a0)
  .L800D5534:
    /* C5D34 800D5534 3027A524 */  addiu      $a1, $a1, %lo(DashHUD_gInfo)
    /* C5D38 800D5538 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* C5D3C 800D553C 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C5D40 800D5540 4800A28C */  lw         $v0, 0x48($a1)
    /* C5D44 800D5544 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C5D48 800D5548 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C5D4C 800D554C 80180200 */  sll        $v1, $v0, 2
    /* C5D50 800D5550 21186200 */  addu       $v1, $v1, $v0
    /* C5D54 800D5554 80180300 */  sll        $v1, $v1, 2
    /* C5D58 800D5558 21187500 */  addu       $v1, $v1, $s5
    /* C5D5C 800D555C 0C03648C */  lw         $a0, 0x30C($v1)
    /* C5D60 800D5560 0000C28C */  lw         $v0, 0x0($a2)
    /* C5D64 800D5564 24208800 */  and        $a0, $a0, $t0
    /* C5D68 800D5568 24104700 */  and        $v0, $v0, $a3
    /* C5D6C 800D556C 25208200 */  or         $a0, $a0, $v0
    /* C5D70 800D5570 0C0364AC */  sw         $a0, 0x30C($v1)
    /* C5D74 800D5574 0000C38C */  lw         $v1, 0x0($a2)
    /* C5D78 800D5578 4800A48C */  lw         $a0, 0x48($a1)
    /* C5D7C 800D557C 24186800 */  and        $v1, $v1, $t0
    /* C5D80 800D5580 80100400 */  sll        $v0, $a0, 2
    /* C5D84 800D5584 21104400 */  addu       $v0, $v0, $a0
    /* C5D88 800D5588 80100200 */  sll        $v0, $v0, 2
    /* C5D8C 800D558C 21105500 */  addu       $v0, $v0, $s5
    /* C5D90 800D5590 0C034224 */  addiu      $v0, $v0, 0x30C
    /* C5D94 800D5594 24104700 */  and        $v0, $v0, $a3
    /* C5D98 800D5598 25186200 */  or         $v1, $v1, $v0
    /* C5D9C 800D559C 0000C3AC */  sw         $v1, 0x0($a2)
  .L800D55A0:
    /* C5DA0 800D55A0 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* C5DA4 800D55A4 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* C5DA8 800D55A8 40181E00 */  sll        $v1, $fp, 1
    /* C5DAC 800D55AC 21187E00 */  addu       $v1, $v1, $fp
    /* C5DB0 800D55B0 00110300 */  sll        $v0, $v1, 4
    /* C5DB4 800D55B4 23104300 */  subu       $v0, $v0, $v1
    /* C5DB8 800D55B8 80100200 */  sll        $v0, $v0, 2
    /* C5DBC 800D55BC 21104400 */  addu       $v0, $v0, $a0
    /* C5DC0 800D55C0 4404428C */  lw         $v0, 0x444($v0)
    /* C5DC4 800D55C4 00000000 */  nop
    /* C5DC8 800D55C8 0D004014 */  bnez       $v0, .L800D5600
    /* C5DCC 800D55CC FF00053C */   lui       $a1, (0xFFFFFF >> 16)
    /* C5DD0 800D55D0 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5DD4 800D55D4 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C5DD8 800D55D8 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5DDC 800D55DC 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5DE0 800D55E0 E803A38E */  lw         $v1, 0x3E8($s5)
    /* C5DE4 800D55E4 0000828C */  lw         $v0, 0x0($a0)
    /* C5DE8 800D55E8 24186600 */  and        $v1, $v1, $a2
    /* C5DEC 800D55EC 24104500 */  and        $v0, $v0, $a1
    /* C5DF0 800D55F0 25186200 */  or         $v1, $v1, $v0
    /* C5DF4 800D55F4 E803A226 */  addiu      $v0, $s5, 0x3E8
    /* C5DF8 800D55F8 8B550308 */  j          .L800D562C
    /* C5DFC 800D55FC E803A3AE */   sw        $v1, 0x3E8($s5)
  .L800D5600:
    /* C5E00 800D5600 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C5E04 800D5604 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C5E08 800D5608 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C5E0C 800D560C 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C5E10 800D5610 D403A38E */  lw         $v1, 0x3D4($s5)
    /* C5E14 800D5614 0000828C */  lw         $v0, 0x0($a0)
    /* C5E18 800D5618 24186600 */  and        $v1, $v1, $a2
    /* C5E1C 800D561C 24104500 */  and        $v0, $v0, $a1
    /* C5E20 800D5620 25186200 */  or         $v1, $v1, $v0
    /* C5E24 800D5624 D403A226 */  addiu      $v0, $s5, 0x3D4
    /* C5E28 800D5628 D403A3AE */  sw         $v1, 0x3D4($s5)
  .L800D562C:
    /* C5E2C 800D562C 0000838C */  lw         $v1, 0x0($a0)
    /* C5E30 800D5630 24104500 */  and        $v0, $v0, $a1
    /* C5E34 800D5634 24186600 */  and        $v1, $v1, $a2
    /* C5E38 800D5638 25186200 */  or         $v1, $v1, $v0
    /* C5E3C 800D563C 000083AC */  sw         $v1, 0x0($a0)
  .L800D5640:
    /* C5E40 800D5640 5B47030C */  jal        Hud_GoTpage__Fi
    /* C5E44 800D5644 01000424 */   addiu     $a0, $zero, 0x1
    /* C5E48 800D5648 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C5E4C 800D564C EC314424 */  addiu      $a0, $v0, %lo(GameSetup_gData)
    /* C5E50 800D5650 40181200 */  sll        $v1, $s2, 1
    /* C5E54 800D5654 21187200 */  addu       $v1, $v1, $s2
    /* C5E58 800D5658 00110300 */  sll        $v0, $v1, 4
    /* C5E5C 800D565C 23104300 */  subu       $v0, $v0, $v1
    /* C5E60 800D5660 80100200 */  sll        $v0, $v0, 2
    /* C5E64 800D5664 21104400 */  addu       $v0, $v0, $a0
    /* C5E68 800D5668 4C04428C */  lw         $v0, 0x44C($v0)
    /* C5E6C 800D566C 00000000 */  nop
    /* C5E70 800D5670 CC004010 */  beqz       $v0, .L800D59A4
    /* C5E74 800D5674 40101E00 */   sll       $v0, $fp, 1
    /* C5E78 800D5678 21105E00 */  addu       $v0, $v0, $fp
    /* C5E7C 800D567C 00190200 */  sll        $v1, $v0, 4
    /* C5E80 800D5680 23186200 */  subu       $v1, $v1, $v0
    /* C5E84 800D5684 80180300 */  sll        $v1, $v1, 2
    /* C5E88 800D5688 21186400 */  addu       $v1, $v1, $a0
    /* C5E8C 800D568C 1180023C */  lui        $v0, %hi(D_8011277C)
    /* C5E90 800D5690 4804648C */  lw         $a0, 0x448($v1)
    /* C5E94 800D5694 7C27458C */  lw         $a1, %lo(D_8011277C)($v0)
    /* C5E98 800D5698 CA90030C */  jal        fixedmult
    /* C5E9C 800D569C 00000000 */   nop
    /* C5EA0 800D56A0 21A04000 */  addu       $s4, $v0, $zero
    /* C5EA4 800D56A4 03008106 */  bgez       $s4, .L800D56B4
    /* C5EA8 800D56A8 EB51103C */   lui       $s0, (0x51EB851F >> 16)
    /* C5EAC 800D56AC FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* C5EB0 800D56B0 21A08202 */  addu       $s4, $s4, $v0
  .L800D56B4:
    /* C5EB4 800D56B4 1F851036 */  ori        $s0, $s0, (0x51EB851F & 0xFFFF)
    /* C5EB8 800D56B8 66660F3C */  lui        $t7, (0x66666667 >> 16)
    /* C5EBC 800D56BC 6766EF35 */  ori        $t7, $t7, (0x66666667 & 0xFFFF)
    /* C5EC0 800D56C0 C800183C */  lui        $t8, (0xC8C8C8 >> 16)
    /* C5EC4 800D56C4 C8C81837 */  ori        $t8, $t8, (0xC8C8C8 & 0xFFFF)
    /* C5EC8 800D56C8 2400B8AF */  sw         $t8, 0x24($sp)
    /* C5ECC 800D56CC 5000183C */  lui        $t8, (0x505050 >> 16)
    /* C5ED0 800D56D0 50501837 */  ori        $t8, $t8, (0x505050 & 0xFFFF)
    /* C5ED4 800D56D4 801F033C */  lui        $v1, (0x1F800004 >> 16)
    /* C5ED8 800D56D8 04006334 */  ori        $v1, $v1, (0x1F800004 & 0xFFFF)
    /* C5EDC 800D56DC FF000B3C */  lui        $t3, (0xFFFFFF >> 16)
    /* C5EE0 800D56E0 FFFF6B35 */  ori        $t3, $t3, (0xFFFFFF & 0xFFFF)
    /* C5EE4 800D56E4 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C5EE8 800D56E8 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C5EEC 800D56EC 00FF0E3C */  lui        $t6, (0xFF000000 >> 16)
    /* C5EF0 800D56F0 034C1400 */  sra        $t1, $s4, 16
    /* C5EF4 800D56F4 2000B8AF */  sw         $t8, 0x20($sp)
    /* C5EF8 800D56F8 0000718C */  lw         $s1, 0x0($v1)
    /* C5EFC 800D56FC 18002F01 */  mult       $t1, $t7
    /* C5F00 800D5700 21202002 */  addu       $a0, $s1, $zero
    /* C5F04 800D5704 34002226 */  addiu      $v0, $s1, 0x34
    /* C5F08 800D5708 000062AC */  sw         $v0, 0x0($v1)
    /* C5F0C 800D570C 80030385 */  lh         $v1, 0x380($t0)
    /* C5F10 800D5710 94030C85 */  lh         $t4, 0x394($t0)
    /* C5F14 800D5714 0C040D85 */  lh         $t5, 0x40C($t0)
    /* C5F18 800D5718 70030825 */  addiu      $t0, $t0, 0x370
    /* C5F1C 800D571C B818878F */  lw         $a3, %gp_rel(D_8013DE04)($gp)
    /* C5F20 800D5720 801F0A3C */  lui        $t2, (0x1F800000 >> 16)
    /* C5F24 800D5724 00004A8D */  lw         $t2, (0x1F800000 & 0xFFFF)($t2)
    /* C5F28 800D5728 01007324 */  addiu      $s3, $v1, 0x1
    /* C5F2C 800D572C 21606C02 */  addu       $t4, $s3, $t4
    /* C5F30 800D5730 21686D02 */  addu       $t5, $s3, $t5
    /* C5F34 800D5734 0400E584 */  lh         $a1, 0x4($a3)
    /* C5F38 800D5738 3000E284 */  lh         $v0, 0x30($a3)
    /* C5F3C 800D573C 43B80D00 */  sra        $s7, $t5, 1
    /* C5F40 800D5740 2190A200 */  addu       $s2, $a1, $v0
    /* C5F44 800D5744 04004326 */  addiu      $v1, $s2, 0x4
    /* C5F48 800D5748 40101300 */  sll        $v0, $s3, 1
    /* C5F4C 800D574C 21904300 */  addu       $s2, $v0, $v1
    /* C5F50 800D5750 21304002 */  addu       $a2, $s2, $zero
    /* C5F54 800D5754 0000238E */  lw         $v1, 0x0($s1)
    /* C5F58 800D5758 0000428D */  lw         $v0, 0x0($t2)
    /* C5F5C 800D575C 3200E584 */  lh         $a1, 0x32($a3)
    /* C5F60 800D5760 24186E00 */  and        $v1, $v1, $t6
    /* C5F64 800D5764 24104B00 */  and        $v0, $v0, $t3
    /* C5F68 800D5768 25186200 */  or         $v1, $v1, $v0
    /* C5F6C 800D576C 0600E284 */  lh         $v0, 0x6($a3)
    /* C5F70 800D5770 24582B02 */  and        $t3, $s1, $t3
    /* C5F74 800D5774 000023AE */  sw         $v1, 0x0($s1)
    /* C5F78 800D5778 21104500 */  addu       $v0, $v0, $a1
    /* C5F7C 800D577C 21105600 */  addu       $v0, $v0, $s6
    /* C5F80 800D5780 1800A2AF */  sw         $v0, 0x18($sp)
    /* C5F84 800D5784 0000428D */  lw         $v0, 0x0($t2)
    /* C5F88 800D5788 1800A78F */  lw         $a3, 0x18($sp)
    /* C5F8C 800D578C 24104E00 */  and        $v0, $v0, $t6
    /* C5F90 800D5790 25104B00 */  or         $v0, $v0, $t3
    /* C5F94 800D5794 000042AD */  sw         $v0, 0x0($t2)
    /* C5F98 800D5798 C3571400 */  sra        $t2, $s4, 31
    /* C5F9C 800D579C 10780000 */  mfhi       $t7
    /* C5FA0 800D57A0 43A00C00 */  sra        $s4, $t4, 1
    /* C5FA4 800D57A4 2400B88F */  lw         $t8, 0x24($sp)
    /* C5FA8 800D57A8 18003001 */  mult       $t1, $s0
    /* C5FAC 800D57AC 1000B8AF */  sw         $t8, 0x10($sp)
    /* C5FB0 800D57B0 83180F00 */  sra        $v1, $t7, 2
    /* C5FB4 800D57B4 23186A00 */  subu       $v1, $v1, $t2
    /* C5FB8 800D57B8 80100300 */  sll        $v0, $v1, 2
    /* C5FBC 800D57BC 21104300 */  addu       $v0, $v0, $v1
    /* C5FC0 800D57C0 40100200 */  sll        $v0, $v0, 1
    /* C5FC4 800D57C4 23482201 */  subu       $t1, $t1, $v0
    /* C5FC8 800D57C8 80280900 */  sll        $a1, $t1, 2
    /* C5FCC 800D57CC 2128A900 */  addu       $a1, $a1, $t1
    /* C5FD0 800D57D0 80280500 */  sll        $a1, $a1, 2
    /* C5FD4 800D57D4 2128A800 */  addu       $a1, $a1, $t0
    /* C5FD8 800D57D8 10580000 */  mfhi       $t3
    /* C5FDC 800D57DC 43110B00 */  sra        $v0, $t3, 5
    /* C5FE0 800D57E0 23804A00 */  subu       $s0, $v0, $t2
    /* C5FE4 800D57E4 80101000 */  sll        $v0, $s0, 2
    /* C5FE8 800D57E8 21105000 */  addu       $v0, $v0, $s0
    /* C5FEC 800D57EC 40100200 */  sll        $v0, $v0, 1
    /* C5FF0 800D57F0 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C5FF4 800D57F4 23B06200 */   subu      $s6, $v1, $v0
    /* C5FF8 800D57F8 2000B88F */  lw         $t8, 0x20($sp)
    /* C5FFC 800D57FC 01000224 */  addiu      $v0, $zero, 0x1
    /* C6000 800D5800 280038AE */  sw         $t8, 0x28($s1)
    /* C6004 800D5804 1C0038AE */  sw         $t8, 0x1C($s1)
    /* C6008 800D5808 23C07402 */  subu       $t8, $s3, $s4
    /* C600C 800D580C 0300C216 */  bne        $s6, $v0, .L800D581C
    /* C6010 800D5810 1C00B8AF */   sw        $t8, 0x1C($sp)
    /* C6014 800D5814 0D560308 */  j          .L800D5834
    /* C6018 800D5818 23905402 */   subu      $s2, $s2, $s4
  .L800D581C:
    /* C601C 800D581C 07000224 */  addiu      $v0, $zero, 0x7
    /* C6020 800D5820 0300C216 */  bne        $s6, $v0, .L800D5830
    /* C6024 800D5824 00000000 */   nop
    /* C6028 800D5828 0D560308 */  j          .L800D5834
    /* C602C 800D582C 23905702 */   subu      $s2, $s2, $s7
  .L800D5830:
    /* C6030 800D5830 23905302 */  subu       $s2, $s2, $s3
  .L800D5834:
    /* C6034 800D5834 03000016 */  bnez       $s0, .L800D5844
    /* C6038 800D5838 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* C603C 800D583C 2600C012 */  beqz       $s6, .L800D58D8
    /* C6040 800D5840 01000224 */   addiu     $v0, $zero, 0x1
  .L800D5844:
    /* C6044 800D5844 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C6048 800D5848 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* C604C 800D584C FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* C6050 800D5850 80101600 */  sll        $v0, $s6, 2
    /* C6054 800D5854 21105600 */  addu       $v0, $v0, $s6
    /* C6058 800D5858 80100200 */  sll        $v0, $v0, 2
    /* C605C 800D585C 1180053C */  lui        $a1, %hi(D_80111008)
    /* C6060 800D5860 0810A524 */  addiu      $a1, $a1, %lo(D_80111008)
    /* C6064 800D5864 21284500 */  addu       $a1, $v0, $a1
    /* C6068 800D5868 21304002 */  addu       $a2, $s2, $zero
    /* C606C 800D586C 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* C6070 800D5870 0000718D */  lw         $s1, 0x0($t3)
    /* C6074 800D5874 1800A78F */  lw         $a3, 0x18($sp)
    /* C6078 800D5878 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C607C 800D587C 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C6080 800D5880 0000238E */  lw         $v1, 0x0($s1)
    /* C6084 800D5884 0000028D */  lw         $v0, 0x0($t0)
    /* C6088 800D5888 24186A00 */  and        $v1, $v1, $t2
    /* C608C 800D588C 24104900 */  and        $v0, $v0, $t1
    /* C6090 800D5890 25186200 */  or         $v1, $v1, $v0
    /* C6094 800D5894 000023AE */  sw         $v1, 0x0($s1)
    /* C6098 800D5898 34002326 */  addiu      $v1, $s1, 0x34
    /* C609C 800D589C 0000028D */  lw         $v0, 0x0($t0)
    /* C60A0 800D58A0 24482902 */  and        $t1, $s1, $t1
    /* C60A4 800D58A4 000063AD */  sw         $v1, 0x0($t3)
    /* C60A8 800D58A8 24104A00 */  and        $v0, $v0, $t2
    /* C60AC 800D58AC 25104900 */  or         $v0, $v0, $t1
    /* C60B0 800D58B0 000002AD */  sw         $v0, 0x0($t0)
    /* C60B4 800D58B4 2400B88F */  lw         $t8, 0x24($sp)
    /* C60B8 800D58B8 21202002 */  addu       $a0, $s1, $zero
    /* C60BC 800D58BC A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C60C0 800D58C0 1000B8AF */   sw        $t8, 0x10($sp)
    /* C60C4 800D58C4 2000B88F */  lw         $t8, 0x20($sp)
    /* C60C8 800D58C8 00000000 */  nop
    /* C60CC 800D58CC 280038AE */  sw         $t8, 0x28($s1)
    /* C60D0 800D58D0 1C0038AE */  sw         $t8, 0x1C($s1)
    /* C60D4 800D58D4 01000224 */  addiu      $v0, $zero, 0x1
  .L800D58D8:
    /* C60D8 800D58D8 0400C216 */  bne        $s6, $v0, .L800D58EC
    /* C60DC 800D58DC 1180023C */   lui       $v0, %hi(HudPmx_gShapes)
    /* C60E0 800D58E0 1C00B88F */  lw         $t8, 0x1C($sp)
    /* C60E4 800D58E4 00000000 */  nop
    /* C60E8 800D58E8 23905802 */  subu       $s2, $s2, $t8
  .L800D58EC:
    /* C60EC 800D58EC 980C4424 */  addiu      $a0, $v0, %lo(HudPmx_gShapes)
    /* C60F0 800D58F0 2C000326 */  addiu      $v1, $s0, 0x2C
    /* C60F4 800D58F4 80100300 */  sll        $v0, $v1, 2
    /* C60F8 800D58F8 21104300 */  addu       $v0, $v0, $v1
    /* C60FC 800D58FC 80100200 */  sll        $v0, $v0, 2
    /* C6100 800D5900 21104400 */  addu       $v0, $v0, $a0
    /* C6104 800D5904 10004384 */  lh         $v1, 0x10($v0)
    /* C6108 800D5908 FFFF4226 */  addiu      $v0, $s2, -0x1
    /* C610C 800D590C 25000012 */  beqz       $s0, .L800D59A4
    /* C6110 800D5910 23904300 */   subu      $s2, $v0, $v1
    /* C6114 800D5914 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C6118 800D5918 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C611C 800D591C FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* C6120 800D5920 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* C6124 800D5924 80281000 */  sll        $a1, $s0, 2
    /* C6128 800D5928 2128B000 */  addu       $a1, $a1, $s0
    /* C612C 800D592C 80280500 */  sll        $a1, $a1, 2
    /* C6130 800D5930 70038224 */  addiu      $v0, $a0, 0x370
    /* C6134 800D5934 2128A200 */  addu       $a1, $a1, $v0
    /* C6138 800D5938 21304002 */  addu       $a2, $s2, $zero
    /* C613C 800D593C 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* C6140 800D5940 0000718D */  lw         $s1, 0x0($t3)
    /* C6144 800D5944 1800A78F */  lw         $a3, 0x18($sp)
    /* C6148 800D5948 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C614C 800D594C 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C6150 800D5950 0000238E */  lw         $v1, 0x0($s1)
    /* C6154 800D5954 0000028D */  lw         $v0, 0x0($t0)
    /* C6158 800D5958 24186A00 */  and        $v1, $v1, $t2
    /* C615C 800D595C 24104900 */  and        $v0, $v0, $t1
    /* C6160 800D5960 25186200 */  or         $v1, $v1, $v0
    /* C6164 800D5964 000023AE */  sw         $v1, 0x0($s1)
    /* C6168 800D5968 34002326 */  addiu      $v1, $s1, 0x34
    /* C616C 800D596C 0000028D */  lw         $v0, 0x0($t0)
    /* C6170 800D5970 24482902 */  and        $t1, $s1, $t1
    /* C6174 800D5974 000063AD */  sw         $v1, 0x0($t3)
    /* C6178 800D5978 24104A00 */  and        $v0, $v0, $t2
    /* C617C 800D597C 25104900 */  or         $v0, $v0, $t1
    /* C6180 800D5980 000002AD */  sw         $v0, 0x0($t0)
    /* C6184 800D5984 2400B88F */  lw         $t8, 0x24($sp)
    /* C6188 800D5988 21202002 */  addu       $a0, $s1, $zero
    /* C618C 800D598C A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C6190 800D5990 1000B8AF */   sw        $t8, 0x10($sp)
    /* C6194 800D5994 2000B88F */  lw         $t8, 0x20($sp)
    /* C6198 800D5998 00000000 */  nop
    /* C619C 800D599C 280038AE */  sw         $t8, 0x28($s1)
    /* C61A0 800D59A0 1C0038AE */  sw         $t8, 0x1C($s1)
  .L800D59A4:
    /* C61A4 800D59A4 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C61A8 800D59A8 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* C61AC 800D59AC 80181E00 */  sll        $v1, $fp, 2
    /* C61B0 800D59B0 21186200 */  addu       $v1, $v1, $v0
    /* C61B4 800D59B4 2C00628C */  lw         $v0, 0x2C($v1)
    /* C61B8 800D59B8 00000000 */  nop
    /* C61BC 800D59BC 16004010 */  beqz       $v0, .L800D5A18
    /* C61C0 800D59C0 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* C61C4 800D59C4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C61C8 800D59C8 00000000 */  nop
    /* C61CC 800D59CC 43110200 */  sra        $v0, $v0, 5
    /* C61D0 800D59D0 01004230 */  andi       $v0, $v0, 0x1
    /* C61D4 800D59D4 10004010 */  beqz       $v0, .L800D5A18
    /* C61D8 800D59D8 FF00043C */   lui       $a0, (0xFFFFFF >> 16)
    /* C61DC 800D59DC FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* C61E0 800D59E0 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* C61E4 800D59E4 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C61E8 800D59E8 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C61EC 800D59EC 0000A38E */  lw         $v1, 0x0($s5)
    /* C61F0 800D59F0 0000A28C */  lw         $v0, 0x0($a1)
    /* C61F4 800D59F4 24186600 */  and        $v1, $v1, $a2
    /* C61F8 800D59F8 24104400 */  and        $v0, $v0, $a0
    /* C61FC 800D59FC 25186200 */  or         $v1, $v1, $v0
    /* C6200 800D5A00 0000A3AE */  sw         $v1, 0x0($s5)
    /* C6204 800D5A04 0000A28C */  lw         $v0, 0x0($a1)
    /* C6208 800D5A08 2420A402 */  and        $a0, $s5, $a0
    /* C620C 800D5A0C 24104600 */  and        $v0, $v0, $a2
    /* C6210 800D5A10 25104400 */  or         $v0, $v0, $a0
    /* C6214 800D5A14 0000A2AC */  sw         $v0, 0x0($a1)
  .L800D5A18:
    /* C6218 800D5A18 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* C621C 800D5A1C 4800BE8F */  lw         $fp, 0x48($sp)
    /* C6220 800D5A20 4400B78F */  lw         $s7, 0x44($sp)
    /* C6224 800D5A24 4000B68F */  lw         $s6, 0x40($sp)
    /* C6228 800D5A28 3C00B58F */  lw         $s5, 0x3C($sp)
    /* C622C 800D5A2C 3800B48F */  lw         $s4, 0x38($sp)
    /* C6230 800D5A30 3400B38F */  lw         $s3, 0x34($sp)
    /* C6234 800D5A34 3000B28F */  lw         $s2, 0x30($sp)
    /* C6238 800D5A38 2C00B18F */  lw         $s1, 0x2C($sp)
    /* C623C 800D5A3C 2800B08F */  lw         $s0, 0x28($sp)
    /* C6240 800D5A40 0800E003 */  jr         $ra
    /* C6244 800D5A44 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Hud_BuildNumbers__Fi
