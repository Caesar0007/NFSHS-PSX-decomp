.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__20tScreenCarSelectDuel, 0x678

glabel DrawBackground__20tScreenCarSelectDuel
    /* 2DFF0 8003D7F0 E8FEBD27 */  addiu      $sp, $sp, -0x118
    /* 2DFF4 8003D7F4 0C01B1AF */  sw         $s1, 0x10C($sp)
    /* 2DFF8 8003D7F8 21888000 */  addu       $s1, $a0, $zero
    /* 2DFFC 8003D7FC 1480023C */  lui        $v0, %hi(Draw_gPlayer1View)
    /* 2E000 8003D800 CCD3448C */  lw         $a0, %lo(Draw_gPlayer1View)($v0)
    /* 2E004 8003D804 1480023C */  lui        $v0, %hi(gFlip)
    /* 2E008 8003D808 B4D7458C */  lw         $a1, %lo(gFlip)($v0)
    /* 2E00C 8003D80C 1401BFAF */  sw         $ra, 0x114($sp)
    /* 2E010 8003D810 1001B2AF */  sw         $s2, 0x110($sp)
    /* 2E014 8003D814 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* 2E018 8003D818 0801B0AF */   sw        $s0, 0x108($sp)
    /* 2E01C 8003D81C 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* 2E020 8003D820 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* 2E024 8003D824 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* 2E028 8003D828 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* 2E02C 8003D82C 0001A527 */  addiu      $a1, $sp, 0x100
    /* 2E030 8003D830 07000324 */  addiu      $v1, $zero, 0x7
    /* 2E034 8003D834 0000248D */  lw         $a0, 0x0($t1)
    /* 2E038 8003D838 21904000 */  addu       $s2, $v0, $zero
    /* 2E03C 8003D83C 1C0123A6 */  sh         $v1, 0x11C($s1)
    /* 2E040 8003D840 0001A0A7 */  sh         $zero, 0x100($sp)
    /* 2E044 8003D844 02004396 */  lhu        $v1, 0x2($s2)
    /* 2E048 8003D848 00020224 */  addiu      $v0, $zero, 0x200
    /* 2E04C 8003D84C 0401A2A7 */  sh         $v0, 0x104($sp)
    /* 2E050 8003D850 1480023C */  lui        $v0, %hi(screenheight)
    /* 2E054 8003D854 8CDC4294 */  lhu        $v0, %lo(screenheight)($v0)
    /* 2E058 8003D858 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* 2E05C 8003D85C 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* 2E060 8003D860 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* 2E064 8003D864 0201A3A7 */  sh         $v1, 0x102($sp)
    /* 2E068 8003D868 0601A2A7 */  sh         $v0, 0x106($sp)
    /* 2E06C 8003D86C 0000838C */  lw         $v1, 0x0($a0)
    /* 2E070 8003D870 0000C28C */  lw         $v0, 0x0($a2)
    /* 2E074 8003D874 24186800 */  and        $v1, $v1, $t0
    /* 2E078 8003D878 24104700 */  and        $v0, $v0, $a3
    /* 2E07C 8003D87C 25186200 */  or         $v1, $v1, $v0
    /* 2E080 8003D880 000083AC */  sw         $v1, 0x0($a0)
    /* 2E084 8003D884 0000C28C */  lw         $v0, 0x0($a2)
    /* 2E088 8003D888 0C008324 */  addiu      $v1, $a0, 0xC
    /* 2E08C 8003D88C 000023AD */  sw         $v1, 0x0($t1)
    /* 2E090 8003D890 24188700 */  and        $v1, $a0, $a3
    /* 2E094 8003D894 24104800 */  and        $v0, $v0, $t0
    /* 2E098 8003D898 25104300 */  or         $v0, $v0, $v1
    /* 2E09C 8003D89C C5B8030C */  jal        SetDrawArea
    /* 2E0A0 8003D8A0 0000C2AC */   sw        $v0, 0x0($a2)
    /* 2E0A4 8003D8A4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 2E0A8 8003D8A8 22010224 */  addiu      $v0, $zero, 0x122
    /* 2E0AC 8003D8AC 2800A2A7 */  sh         $v0, 0x28($sp)
    /* 2E0B0 8003D8B0 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 2E0B4 8003D8B4 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* 2E0B8 8003D8B8 0C000224 */  addiu      $v0, $zero, 0xC
    /* 2E0BC 8003D8BC 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* 2E0C0 8003D8C0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2E0C4 8003D8C4 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2E0C8 8003D8C8 82000224 */  addiu      $v0, $zero, 0x82
    /* 2E0CC 8003D8CC 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* 2E0D0 8003D8D0 5F5E000C */  jal        TextValue__16tListIteratorCar7tPlayer
    /* 2E0D4 8003D8D4 60148424 */   addiu     $a0, $a0, 0x1460
    /* 2E0D8 8003D8D8 00140200 */  sll        $v0, $v0, 16
    /* 2E0DC 8003D8DC 03240200 */  sra        $a0, $v0, 16
    /* 2E0E0 8003D8E0 2800A527 */  addiu      $a1, $sp, 0x28
    /* 2E0E4 8003D8E4 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 2E0E8 8003D8E8 21300000 */   addu      $a2, $zero, $zero
    /* 2E0EC 8003D8EC 1180043C */  lui        $a0, %hi(carManager)
    /* 2E0F0 8003D8F0 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2E0F4 8003D8F4 1180023C */  lui        $v0, %hi(D_8011491D)
    /* 2E0F8 8003D8F8 3000B027 */  addiu      $s0, $sp, 0x30
    /* 2E0FC 8003D8FC 1D494590 */  lbu        $a1, %lo(D_8011491D)($v0)
    /* 2E100 8003D900 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2E104 8003D904 21300002 */   addu      $a2, $s0, $zero
    /* 2E108 8003D908 3400A293 */  lbu        $v0, 0x34($sp)
    /* 2E10C 8003D90C 21202002 */  addu       $a0, $s1, $zero
    /* 2E110 8003D910 21100202 */  addu       $v0, $s0, $v0
    /* 2E114 8003D914 AF004290 */  lbu        $v0, 0xAF($v0)
    /* 2E118 8003D918 21280002 */  addu       $a1, $s0, $zero
    /* 2E11C 8003D91C DBF5000C */  jal        UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
    /* 2E120 8003D920 F500A2A3 */   sb        $v0, 0xF5($sp)
    /* 2E124 8003D924 21202002 */  addu       $a0, $s1, $zero
    /* 2E128 8003D928 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2E12C 8003D92C A8032526 */   addiu     $a1, $s1, 0x3A8
    /* 2E130 8003D930 AC03228E */  lw         $v0, 0x3AC($s1)
    /* 2E134 8003D934 00000000 */  nop
    /* 2E138 8003D938 11004010 */  beqz       $v0, .L8003D980
    /* 2E13C 8003D93C 21200000 */   addu      $a0, $zero, $zero
    /* 2E140 8003D940 50032386 */  lh         $v1, 0x350($s1)
    /* 2E144 8003D944 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2E148 8003D948 0D006210 */  beq        $v1, $v0, .L8003D980
    /* 2E14C 8003D94C 0580023C */   lui       $v0, %hi(D_80052A6C)
    /* 2E150 8003D950 6C2A428C */  lw         $v0, %lo(D_80052A6C)($v0)
    /* 2E154 8003D954 00000000 */  nop
    /* 2E158 8003D958 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E15C 8003D95C 00000000 */  nop
    /* 2E160 8003D960 07004014 */  bnez       $v0, .L8003D980
    /* 2E164 8003D964 1480023C */   lui       $v0, %hi(ticks)
    /* 2E168 8003D968 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2E16C 8003D96C 8003238E */  lw         $v1, 0x380($s1)
    /* 2E170 8003D970 00000000 */  nop
    /* 2E174 8003D974 23104300 */  subu       $v0, $v0, $v1
    /* 2E178 8003D978 81004228 */  slti       $v0, $v0, 0x81
    /* 2E17C 8003D97C 01004438 */  xori       $a0, $v0, 0x1
  .L8003D980:
    /* 2E180 8003D980 13008010 */  beqz       $a0, .L8003D9D0
    /* 2E184 8003D984 21202002 */   addu      $a0, $s1, $zero
    /* 2E188 8003D988 A8032526 */  addiu      $a1, $s1, 0x3A8
    /* 2E18C 8003D98C 21300000 */  addu       $a2, $zero, $zero
    /* 2E190 8003D990 41000724 */  addiu      $a3, $zero, 0x41
    /* 2E194 8003D994 05000224 */  addiu      $v0, $zero, 0x5
    /* 2E198 8003D998 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2E19C 8003D99C 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 2E1A0 8003D9A0 1400A0AF */   sw        $zero, 0x14($sp)
    /* 2E1A4 8003D9A4 3C032426 */  addiu      $a0, $s1, 0x33C
    /* 2E1A8 8003D9A8 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2E1AC 8003D9AC A40320AE */   sw        $zero, 0x3A4($s1)
    /* 2E1B0 8003D9B0 76032386 */  lh         $v1, 0x376($s1)
    /* 2E1B4 8003D9B4 7A032286 */  lh         $v0, 0x37A($s1)
    /* 2E1B8 8003D9B8 00000000 */  nop
    /* 2E1BC 8003D9BC 04006214 */  bne        $v1, $v0, .L8003D9D0
    /* 2E1C0 8003D9C0 21202002 */   addu      $a0, $s1, $zero
    /* 2E1C4 8003D9C4 80000524 */  addiu      $a1, $zero, 0x80
    /* 2E1C8 8003D9C8 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E1CC 8003D9CC 01000624 */   addiu     $a2, $zero, 0x1
  .L8003D9D0:
    /* 2E1D0 8003D9D0 9C03228E */  lw         $v0, 0x39C($s1)
    /* 2E1D4 8003D9D4 00000000 */  nop
    /* 2E1D8 8003D9D8 03004224 */  addiu      $v0, $v0, 0x3
    /* 2E1DC 8003D9DC 9C0322AE */  sw         $v0, 0x39C($s1)
    /* 2E1E0 8003D9E0 0580023C */  lui        $v0, %hi(D_80052A6C)
    /* 2E1E4 8003D9E4 6C2A428C */  lw         $v0, %lo(D_80052A6C)($v0)
    /* 2E1E8 8003D9E8 F400A0A3 */  sb         $zero, 0xF4($sp)
    /* 2E1EC 8003D9EC D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E1F0 8003D9F0 00000000 */  nop
    /* 2E1F4 8003D9F4 10004010 */  beqz       $v0, .L8003DA38
    /* 2E1F8 8003D9F8 1480103C */   lui       $s0, %hi(ticks)
    /* 2E1FC 8003D9FC ACDC028E */  lw         $v0, %lo(ticks)($s0)
    /* 2E200 8003DA00 8003238E */  lw         $v1, 0x380($s1)
    /* 2E204 8003DA04 00000000 */  nop
    /* 2E208 8003DA08 23104300 */  subu       $v0, $v0, $v1
    /* 2E20C 8003DA0C 81004228 */  slti       $v0, $v0, 0x81
    /* 2E210 8003DA10 09004014 */  bnez       $v0, .L8003DA38
    /* 2E214 8003DA14 21202002 */   addu      $a0, $s1, $zero
    /* 2E218 8003DA18 21280000 */  addu       $a1, $zero, $zero
    /* 2E21C 8003DA1C 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E220 8003DA20 01000624 */   addiu     $a2, $zero, 0x1
    /* 2E224 8003DA24 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2E228 8003DA28 3C032426 */   addiu     $a0, $s1, 0x33C
    /* 2E22C 8003DA2C ACDC028E */  lw         $v0, %lo(ticks)($s0)
    /* 2E230 8003DA30 00000000 */  nop
    /* 2E234 8003DA34 800322AE */  sw         $v0, 0x380($s1)
  .L8003DA38:
    /* 2E238 8003DA38 21202002 */  addu       $a0, $s1, $zero
    /* 2E23C 8003DA3C 2EF1000C */  jal        UpdateBrightness__16tScreenCarSelects
    /* 2E240 8003DA40 01000524 */   addiu     $a1, $zero, 0x1
    /* 2E244 8003DA44 3000A427 */  addiu      $a0, $sp, 0x30
    /* 2E248 8003DA48 16010524 */  addiu      $a1, $zero, 0x116
    /* 2E24C 8003DA4C D93F073C */  lui        $a3, (0x3FD9999A >> 16)
    /* 2E250 8003DA50 9A99E734 */  ori        $a3, $a3, (0x3FD9999A & 0xFFFF)
    /* 2E254 8003DA54 1EC1033C */  lui        $v1, (0xC11E6666 >> 16)
    /* 2E258 8003DA58 66666334 */  ori        $v1, $v1, (0xC11E6666 & 0xFFFF)
    /* 2E25C 8003DA5C 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2E260 8003DA60 601240AC */  sw         $zero, %lo(_front_data_org)($v0)
    /* 2E264 8003DA64 1000A3AF */  sw         $v1, 0x10($sp)
    /* 2E268 8003DA68 76032292 */  lbu        $v0, 0x376($s1)
    /* 2E26C 8003DA6C B8000624 */  addiu      $a2, $zero, 0xB8
    /* 2E270 8003DA70 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2E274 8003DA74 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2E278 8003DA78 9C03238E */  lw         $v1, 0x39C($s1)
    /* 2E27C 8003DA7C 01000224 */  addiu      $v0, $zero, 0x1
    /* 2E280 8003DA80 2000A2AF */  sw         $v0, 0x20($sp)
    /* 2E284 8003DA84 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2E288 8003DA88 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* 2E28C 8003DA8C 0580023C */  lui        $v0, %hi(D_80052A6C)
    /* 2E290 8003DA90 6C2A428C */  lw         $v0, %lo(D_80052A6C)($v0)
    /* 2E294 8003DA94 00000000 */  nop
    /* 2E298 8003DA98 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E29C 8003DA9C 00000000 */  nop
    /* 2E2A0 8003DAA0 14004014 */  bnez       $v0, .L8003DAF4
    /* 2E2A4 8003DAA4 00000000 */   nop
    /* 2E2A8 8003DAA8 76032386 */  lh         $v1, 0x376($s1)
    /* 2E2AC 8003DAAC 7A032286 */  lh         $v0, 0x37A($s1)
    /* 2E2B0 8003DAB0 00000000 */  nop
    /* 2E2B4 8003DAB4 0F006214 */  bne        $v1, $v0, .L8003DAF4
    /* 2E2B8 8003DAB8 00000000 */   nop
    /* 2E2BC 8003DABC 0D006014 */  bnez       $v1, .L8003DAF4
    /* 2E2C0 8003DAC0 1480023C */   lui       $v0, %hi(ticks)
    /* 2E2C4 8003DAC4 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2E2C8 8003DAC8 8003238E */  lw         $v1, 0x380($s1)
    /* 2E2CC 8003DACC 00000000 */  nop
    /* 2E2D0 8003DAD0 23104300 */  subu       $v0, $v0, $v1
    /* 2E2D4 8003DAD4 81004228 */  slti       $v0, $v0, 0x81
    /* 2E2D8 8003DAD8 06004014 */  bnez       $v0, .L8003DAF4
    /* 2E2DC 8003DADC 80000524 */   addiu     $a1, $zero, 0x80
    /* 2E2E0 8003DAE0 21202002 */  addu       $a0, $s1, $zero
    /* 2E2E4 8003DAE4 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E2E8 8003DAE8 01000624 */   addiu     $a2, $zero, 0x1
    /* 2E2EC 8003DAEC BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2E2F0 8003DAF0 3C032426 */   addiu     $a0, $s1, 0x33C
  .L8003DAF4:
    /* 2E2F4 8003DAF4 6000228E */  lw         $v0, 0x60($s1)
    /* 2E2F8 8003DAF8 69000524 */  addiu      $a1, $zero, 0x69
    /* 2E2FC 8003DAFC 80004484 */  lh         $a0, 0x80($v0)
    /* 2E300 8003DB00 8400428C */  lw         $v0, 0x84($v0)
    /* 2E304 8003DB04 00000000 */  nop
    /* 2E308 8003DB08 09F84000 */  jalr       $v0
    /* 2E30C 8003DB0C 21202402 */   addu      $a0, $s1, $a0
    /* 2E310 8003DB10 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* 2E314 8003DB14 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* 2E318 8003DB18 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* 2E31C 8003DB1C FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* 2E320 8003DB20 0001A527 */  addiu      $a1, $sp, 0x100
    /* 2E324 8003DB24 00020224 */  addiu      $v0, $zero, 0x200
    /* 2E328 8003DB28 0000248D */  lw         $a0, 0x0($t1)
    /* 2E32C 8003DB2C 1480103C */  lui        $s0, %hi(screenheight)
    /* 2E330 8003DB30 0001A0A7 */  sh         $zero, 0x100($sp)
    /* 2E334 8003DB34 02004396 */  lhu        $v1, 0x2($s2)
    /* 2E338 8003DB38 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* 2E33C 8003DB3C 0401A2A7 */  sh         $v0, 0x104($sp)
    /* 2E340 8003DB40 8CDC0296 */  lhu        $v0, %lo(screenheight)($s0)
    /* 2E344 8003DB44 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* 2E348 8003DB48 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* 2E34C 8003DB4C 80006324 */  addiu      $v1, $v1, 0x80
    /* 2E350 8003DB50 80FF4224 */  addiu      $v0, $v0, -0x80
    /* 2E354 8003DB54 0201A3A7 */  sh         $v1, 0x102($sp)
    /* 2E358 8003DB58 0601A2A7 */  sh         $v0, 0x106($sp)
    /* 2E35C 8003DB5C 0000838C */  lw         $v1, 0x0($a0)
    /* 2E360 8003DB60 0000C28C */  lw         $v0, 0x0($a2)
    /* 2E364 8003DB64 24186800 */  and        $v1, $v1, $t0
    /* 2E368 8003DB68 24104700 */  and        $v0, $v0, $a3
    /* 2E36C 8003DB6C 25186200 */  or         $v1, $v1, $v0
    /* 2E370 8003DB70 000083AC */  sw         $v1, 0x0($a0)
    /* 2E374 8003DB74 0000C28C */  lw         $v0, 0x0($a2)
    /* 2E378 8003DB78 0C008324 */  addiu      $v1, $a0, 0xC
    /* 2E37C 8003DB7C 000023AD */  sw         $v1, 0x0($t1)
    /* 2E380 8003DB80 24188700 */  and        $v1, $a0, $a3
    /* 2E384 8003DB84 24104800 */  and        $v0, $v0, $t0
    /* 2E388 8003DB88 25104300 */  or         $v0, $v0, $v1
    /* 2E38C 8003DB8C C5B8030C */  jal        SetDrawArea
    /* 2E390 8003DB90 0000C2AC */   sw        $v0, 0x0($a2)
    /* 2E394 8003DB94 21200000 */  addu       $a0, $zero, $zero
    /* 2E398 8003DB98 21288000 */  addu       $a1, $a0, $zero
    /* 2E39C 8003DB9C 8CDC068E */  lw         $a2, %lo(screenheight)($s0)
    /* 2E3A0 8003DBA0 00020724 */  addiu      $a3, $zero, 0x200
    /* 2E3A4 8003DBA4 C2170600 */  srl        $v0, $a2, 31
    /* 2E3A8 8003DBA8 2130C200 */  addu       $a2, $a2, $v0
    /* 2E3AC 8003DBAC 43300600 */  sra        $a2, $a2, 1
    /* 2E3B0 8003DBB0 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 2E3B4 8003DBB4 1000A6AF */   sw        $a2, 0x10($sp)
    /* 2E3B8 8003DBB8 6000228E */  lw         $v0, 0x60($s1)
    /* 2E3BC 8003DBBC 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2E3C0 8003DBC0 68004484 */  lh         $a0, 0x68($v0)
    /* 2E3C4 8003DBC4 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2E3C8 8003DBC8 00000000 */  nop
    /* 2E3CC 8003DBCC 09F84000 */  jalr       $v0
    /* 2E3D0 8003DBD0 21202402 */   addu      $a0, $s1, $a0
    /* 2E3D4 8003DBD4 21904000 */  addu       $s2, $v0, $zero
    /* 2E3D8 8003DBD8 17004012 */  beqz       $s2, .L8003DC38
    /* 2E3DC 8003DBDC 1180023C */   lui       $v0, %hi(D_8011472A)
    /* 2E3E0 8003DBE0 2A474390 */  lbu        $v1, %lo(D_8011472A)($v0)
    /* 2E3E4 8003DBE4 19000224 */  addiu      $v0, $zero, 0x19
    /* 2E3E8 8003DBE8 06006014 */  bnez       $v1, .L8003DC04
    /* 2E3EC 8003DBEC 2A00A2A7 */   sh        $v0, 0x2A($sp)
    /* 2E3F0 8003DBF0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2E3F4 8003DBF4 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2E3F8 8003DBF8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 2E3FC 8003DBFC 05F70008 */  j          .L8003DC14
    /* 2E400 8003DC00 6C118424 */   addiu     $a0, $a0, 0x116C
  .L8003DC04:
    /* 2E404 8003DC04 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2E408 8003DC08 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2E40C 8003DC0C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 2E410 8003DC10 CC128424 */  addiu      $a0, $a0, 0x12CC
  .L8003DC14:
    /* 2E414 8003DC14 5F5E000C */  jal        TextValue__16tListIteratorCar7tPlayer
    /* 2E418 8003DC18 00000000 */   nop
    /* 2E41C 8003DC1C 00140200 */  sll        $v0, $v0, 16
    /* 2E420 8003DC20 03240200 */  sra        $a0, $v0, 16
    /* 2E424 8003DC24 2800A527 */  addiu      $a1, $sp, 0x28
    /* 2E428 8003DC28 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 2E42C 8003DC2C 21300000 */   addu      $a2, $zero, $zero
    /* 2E430 8003DC30 10F70008 */  j          .L8003DC40
    /* 2E434 8003DC34 00000000 */   nop
  .L8003DC38:
    /* 2E438 8003DC38 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2E43C 8003DC3C 3000A2A3 */  sb         $v0, 0x30($sp)
  .L8003DC40:
    /* 2E440 8003DC40 6000228E */  lw         $v0, 0x60($s1)
    /* 2E444 8003DC44 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2E448 8003DC48 60004484 */  lh         $a0, 0x60($v0)
    /* 2E44C 8003DC4C 6400428C */  lw         $v0, 0x64($v0)
    /* 2E450 8003DC50 00000000 */  nop
    /* 2E454 8003DC54 09F84000 */  jalr       $v0
    /* 2E458 8003DC58 21202402 */   addu      $a0, $s1, $a0
    /* 2E45C 8003DC5C 0580023C */  lui        $v0, %hi(gCarObj)
    /* 2E460 8003DC60 682A428C */  lw         $v0, %lo(gCarObj)($v0)
    /* 2E464 8003DC64 00000000 */  nop
    /* 2E468 8003DC68 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E46C 8003DC6C 00000000 */  nop
    /* 2E470 8003DC70 10004010 */  beqz       $v0, .L8003DCB4
    /* 2E474 8003DC74 1480103C */   lui       $s0, %hi(ticks)
    /* 2E478 8003DC78 ACDC028E */  lw         $v0, %lo(ticks)($s0)
    /* 2E47C 8003DC7C 7C03238E */  lw         $v1, 0x37C($s1)
    /* 2E480 8003DC80 00000000 */  nop
    /* 2E484 8003DC84 23104300 */  subu       $v0, $v0, $v1
    /* 2E488 8003DC88 81004228 */  slti       $v0, $v0, 0x81
    /* 2E48C 8003DC8C 09004014 */  bnez       $v0, .L8003DCB4
    /* 2E490 8003DC90 21202002 */   addu      $a0, $s1, $zero
    /* 2E494 8003DC94 21280000 */  addu       $a1, $zero, $zero
    /* 2E498 8003DC98 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E49C 8003DC9C 2130A000 */   addu      $a2, $a1, $zero
    /* 2E4A0 8003DCA0 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2E4A4 8003DCA4 04032426 */   addiu     $a0, $s1, 0x304
    /* 2E4A8 8003DCA8 ACDC028E */  lw         $v0, %lo(ticks)($s0)
    /* 2E4AC 8003DCAC 00000000 */  nop
    /* 2E4B0 8003DCB0 7C0322AE */  sw         $v0, 0x37C($s1)
  .L8003DCB4:
    /* 2E4B4 8003DCB4 21202002 */  addu       $a0, $s1, $zero
    /* 2E4B8 8003DCB8 2EF1000C */  jal        UpdateBrightness__16tScreenCarSelects
    /* 2E4BC 8003DCBC 21280000 */   addu      $a1, $zero, $zero
    /* 2E4C0 8003DCC0 3000A427 */  addiu      $a0, $sp, 0x30
    /* 2E4C4 8003DCC4 D93F073C */  lui        $a3, (0x3FD9999A >> 16)
    /* 2E4C8 8003DCC8 9A99E734 */  ori        $a3, $a3, (0x3FD9999A & 0xFFFF)
    /* 2E4CC 8003DCCC 1EC1033C */  lui        $v1, (0xC11E6666 >> 16)
    /* 2E4D0 8003DCD0 66666334 */  ori        $v1, $v1, (0xC11E6666 & 0xFFFF)
    /* 2E4D4 8003DCD4 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2E4D8 8003DCD8 601240AC */  sw         $zero, %lo(_front_data_org)($v0)
    /* 2E4DC 8003DCDC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 2E4E0 8003DCE0 74032292 */  lbu        $v0, 0x374($s1)
    /* 2E4E4 8003DCE4 16010524 */  addiu      $a1, $zero, 0x116
    /* 2E4E8 8003DCE8 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2E4EC 8003DCEC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2E4F0 8003DCF0 9C03228E */  lw         $v0, 0x39C($s1)
    /* 2E4F4 8003DCF4 4F000624 */  addiu      $a2, $zero, 0x4F
    /* 2E4F8 8003DCF8 2000A0AF */  sw         $zero, 0x20($sp)
    /* 2E4FC 8003DCFC 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2E500 8003DD00 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 2E504 8003DD04 0580023C */  lui        $v0, %hi(gCarObj)
    /* 2E508 8003DD08 682A428C */  lw         $v0, %lo(gCarObj)($v0)
    /* 2E50C 8003DD0C 00000000 */  nop
    /* 2E510 8003DD10 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E514 8003DD14 00000000 */  nop
    /* 2E518 8003DD18 19004014 */  bnez       $v0, .L8003DD80
    /* 2E51C 8003DD1C 00000000 */   nop
    /* 2E520 8003DD20 74032386 */  lh         $v1, 0x374($s1)
    /* 2E524 8003DD24 78032286 */  lh         $v0, 0x378($s1)
    /* 2E528 8003DD28 00000000 */  nop
    /* 2E52C 8003DD2C 14006214 */  bne        $v1, $v0, .L8003DD80
    /* 2E530 8003DD30 00000000 */   nop
    /* 2E534 8003DD34 12006014 */  bnez       $v1, .L8003DD80
    /* 2E538 8003DD38 1480023C */   lui       $v0, %hi(ticks)
    /* 2E53C 8003DD3C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2E540 8003DD40 7C03238E */  lw         $v1, 0x37C($s1)
    /* 2E544 8003DD44 00000000 */  nop
    /* 2E548 8003DD48 23104300 */  subu       $v0, $v0, $v1
    /* 2E54C 8003DD4C 81004228 */  slti       $v0, $v0, 0x81
    /* 2E550 8003DD50 0B004014 */  bnez       $v0, .L8003DD80
    /* 2E554 8003DD54 00000000 */   nop
    /* 2E558 8003DD58 3700A293 */  lbu        $v0, 0x37($sp)
    /* 2E55C 8003DD5C 00000000 */  nop
    /* 2E560 8003DD60 02004010 */  beqz       $v0, .L8003DD6C
    /* 2E564 8003DD64 20000524 */   addiu     $a1, $zero, 0x20
    /* 2E568 8003DD68 80000524 */  addiu      $a1, $zero, 0x80
  .L8003DD6C:
    /* 2E56C 8003DD6C 21202002 */  addu       $a0, $s1, $zero
    /* 2E570 8003DD70 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E574 8003DD74 21300000 */   addu      $a2, $zero, $zero
    /* 2E578 8003DD78 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2E57C 8003DD7C 04032426 */   addiu     $a0, $s1, 0x304
  .L8003DD80:
    /* 2E580 8003DD80 2C004012 */  beqz       $s2, .L8003DE34
    /* 2E584 8003DD84 00000000 */   nop
    /* 2E588 8003DD88 21202002 */  addu       $a0, $s1, $zero
    /* 2E58C 8003DD8C 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2E590 8003DD90 28002526 */   addiu     $a1, $s1, 0x28
    /* 2E594 8003DD94 2C00228E */  lw         $v0, 0x2C($s1)
    /* 2E598 8003DD98 00000000 */  nop
    /* 2E59C 8003DD9C 11004010 */  beqz       $v0, .L8003DDE4
    /* 2E5A0 8003DDA0 21200000 */   addu      $a0, $zero, $zero
    /* 2E5A4 8003DDA4 18032386 */  lh         $v1, 0x318($s1)
    /* 2E5A8 8003DDA8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2E5AC 8003DDAC 0D006210 */  beq        $v1, $v0, .L8003DDE4
    /* 2E5B0 8003DDB0 0580023C */   lui       $v0, %hi(gCarObj)
    /* 2E5B4 8003DDB4 682A428C */  lw         $v0, %lo(gCarObj)($v0)
    /* 2E5B8 8003DDB8 00000000 */  nop
    /* 2E5BC 8003DDBC D808428C */  lw         $v0, 0x8D8($v0)
    /* 2E5C0 8003DDC0 00000000 */  nop
    /* 2E5C4 8003DDC4 07004014 */  bnez       $v0, .L8003DDE4
    /* 2E5C8 8003DDC8 1480023C */   lui       $v0, %hi(ticks)
    /* 2E5CC 8003DDCC ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2E5D0 8003DDD0 7C03238E */  lw         $v1, 0x37C($s1)
    /* 2E5D4 8003DDD4 00000000 */  nop
    /* 2E5D8 8003DDD8 23104300 */  subu       $v0, $v0, $v1
    /* 2E5DC 8003DDDC 81004228 */  slti       $v0, $v0, 0x81
    /* 2E5E0 8003DDE0 01004438 */  xori       $a0, $v0, 0x1
  .L8003DDE4:
    /* 2E5E4 8003DDE4 13008010 */  beqz       $a0, .L8003DE34
    /* 2E5E8 8003DDE8 00000000 */   nop
    /* 2E5EC 8003DDEC 21202002 */  addu       $a0, $s1, $zero
    /* 2E5F0 8003DDF0 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 2E5F4 8003DDF4 05000524 */   addiu     $a1, $zero, 0x5
    /* 2E5F8 8003DDF8 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2E5FC 8003DDFC 04032426 */   addiu     $a0, $s1, 0x304
    /* 2E600 8003DE00 78032386 */  lh         $v1, 0x378($s1)
    /* 2E604 8003DE04 74032286 */  lh         $v0, 0x374($s1)
    /* 2E608 8003DE08 00000000 */  nop
    /* 2E60C 8003DE0C 09006214 */  bne        $v1, $v0, .L8003DE34
    /* 2E610 8003DE10 00000000 */   nop
    /* 2E614 8003DE14 3700A293 */  lbu        $v0, 0x37($sp)
    /* 2E618 8003DE18 00000000 */  nop
    /* 2E61C 8003DE1C 02004010 */  beqz       $v0, .L8003DE28
    /* 2E620 8003DE20 20000524 */   addiu     $a1, $zero, 0x20
    /* 2E624 8003DE24 80000524 */  addiu      $a1, $zero, 0x80
  .L8003DE28:
    /* 2E628 8003DE28 21202002 */  addu       $a0, $s1, $zero
    /* 2E62C 8003DE2C 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2E630 8003DE30 21300000 */   addu      $a2, $zero, $zero
  .L8003DE34:
    /* 2E634 8003DE34 6000228E */  lw         $v0, 0x60($s1)
    /* 2E638 8003DE38 21280000 */  addu       $a1, $zero, $zero
    /* 2E63C 8003DE3C 50004484 */  lh         $a0, 0x50($v0)
    /* 2E640 8003DE40 5400428C */  lw         $v0, 0x54($v0)
    /* 2E644 8003DE44 00000000 */  nop
    /* 2E648 8003DE48 09F84000 */  jalr       $v0
    /* 2E64C 8003DE4C 21202402 */   addu      $a0, $s1, $a0
    /* 2E650 8003DE50 1401BF8F */  lw         $ra, 0x114($sp)
    /* 2E654 8003DE54 1001B28F */  lw         $s2, 0x110($sp)
    /* 2E658 8003DE58 0C01B18F */  lw         $s1, 0x10C($sp)
    /* 2E65C 8003DE5C 0801B08F */  lw         $s0, 0x108($sp)
    /* 2E660 8003DE60 0800E003 */  jr         $ra
    /* 2E664 8003DE64 1801BD27 */   addiu     $sp, $sp, 0x118
endlabel DrawBackground__20tScreenCarSelectDuel
