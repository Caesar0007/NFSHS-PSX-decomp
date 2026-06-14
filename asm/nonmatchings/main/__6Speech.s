.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __6Speech, 0x3A0

glabel __6Speech
    /* 85DF4 800955F4 F0FEBD27 */  addiu      $sp, $sp, -0x110
    /* 85DF8 800955F8 0001B2AF */  sw         $s2, 0x100($sp)
    /* 85DFC 800955FC 21908000 */  addu       $s2, $a0, $zero
    /* 85E00 80095600 21284002 */  addu       $a1, $s2, $zero
    /* 85E04 80095604 08000424 */  addiu      $a0, $zero, 0x8
    /* 85E08 80095608 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 85E0C 8009560C 21104402 */  addu       $v0, $s2, $a0
    /* 85E10 80095610 0C01BFAF */  sw         $ra, 0x10C($sp)
    /* 85E14 80095614 0801B4AF */  sw         $s4, 0x108($sp)
    /* 85E18 80095618 0401B3AF */  sw         $s3, 0x104($sp)
    /* 85E1C 8009561C FC00B1AF */  sw         $s1, 0xFC($sp)
    /* 85E20 80095620 F800B0AF */  sw         $s0, 0xF8($sp)
  .L80095624:
    /* 85E24 80095624 0000A3AC */  sw         $v1, 0x0($a1)
    /* 85E28 80095628 FCFF43AC */  sw         $v1, -0x4($v0)
    /* 85E2C 8009562C 000043AC */  sw         $v1, 0x0($v0)
    /* 85E30 80095630 0C004224 */  addiu      $v0, $v0, 0xC
    /* 85E34 80095634 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 85E38 80095638 FAFF8314 */  bne        $a0, $v1, .L80095624
    /* 85E3C 8009563C 0C00A524 */   addiu     $a1, $a1, 0xC
    /* 85E40 80095640 6C004526 */  addiu      $a1, $s2, 0x6C
    /* 85E44 80095644 08000424 */  addiu      $a0, $zero, 0x8
    /* 85E48 80095648 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 85E4C 8009564C 74004226 */  addiu      $v0, $s2, 0x74
  .L80095650:
    /* 85E50 80095650 0000A3AC */  sw         $v1, 0x0($a1)
    /* 85E54 80095654 FCFF43AC */  sw         $v1, -0x4($v0)
    /* 85E58 80095658 000043AC */  sw         $v1, 0x0($v0)
    /* 85E5C 8009565C 0C004224 */  addiu      $v0, $v0, 0xC
    /* 85E60 80095660 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 85E64 80095664 FAFF8314 */  bne        $a0, $v1, .L80095650
    /* 85E68 80095668 0C00A524 */   addiu     $a1, $a1, 0xC
    /* 85E6C 8009566C D8004526 */  addiu      $a1, $s2, 0xD8
    /* 85E70 80095670 2118A000 */  addu       $v1, $a1, $zero
    /* 85E74 80095674 0F000224 */  addiu      $v0, $zero, 0xF
    /* 85E78 80095678 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L8009567C:
    /* 85E7C 8009567C 080064AC */  sw         $a0, 0x8($v1)
    /* 85E80 80095680 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 85E84 80095684 FDFF4414 */  bne        $v0, $a0, .L8009567C
    /* 85E88 80095688 10006324 */   addiu     $v1, $v1, 0x10
    /* 85E8C 8009568C 0001A324 */  addiu      $v1, $a1, 0x100
    /* 85E90 80095690 0F000224 */  addiu      $v0, $zero, 0xF
    /* 85E94 80095694 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L80095698:
    /* 85E98 80095698 080064AC */  sw         $a0, 0x8($v1)
    /* 85E9C 8009569C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 85EA0 800956A0 FDFF4414 */  bne        $v0, $a0, .L80095698
    /* 85EA4 800956A4 10006324 */   addiu     $v1, $v1, 0x10
    /* 85EA8 800956A8 578F020C */  jal        __builtin_new
    /* 85EAC 800956AC 64000424 */   addiu     $a0, $zero, 0x64
    /* 85EB0 800956B0 21880000 */  addu       $s1, $zero, $zero
    /* 85EB4 800956B4 0580033C */  lui        $v1, %hi(_vt_Q26Speech7Speaker)
    /* 85EB8 800956B8 C45D6324 */  addiu      $v1, $v1, %lo(_vt_Q26Speech7Speaker)
    /* 85EBC 800956BC 21986000 */  addu       $s3, $v1, $zero
    /* 85EC0 800956C0 0580033C */  lui        $v1, %hi(_vt_Q26Speech13MobileSpeaker)
    /* 85EC4 800956C4 D45B7424 */  addiu      $s4, $v1, %lo(_vt_Q26Speech13MobileSpeaker)
    /* 85EC8 800956C8 21804002 */  addu       $s0, $s2, $zero
    /* 85ECC 800956CC 0580033C */  lui        $v1, %hi(_vt_Q26Speech15DispatchSpeaker)
    /* 85ED0 800956D0 CC5C6324 */  addiu      $v1, $v1, %lo(_vt_Q26Speech15DispatchSpeaker)
    /* 85ED4 800956D4 4C0053AC */  sw         $s3, 0x4C($v0)
    /* 85ED8 800956D8 480040AC */  sw         $zero, 0x48($v0)
    /* 85EDC 800956DC 4C0043AC */  sw         $v1, 0x4C($v0)
    /* 85EE0 800956E0 A00342AE */  sw         $v0, 0x3A0($s2)
  .L800956E4:
    /* 85EE4 800956E4 0400222A */  slti       $v0, $s1, 0x4
    /* 85EE8 800956E8 0B004010 */  beqz       $v0, .L80095718
    /* 85EEC 800956EC 21300000 */   addu      $a2, $zero, $zero
    /* 85EF0 800956F0 578F020C */  jal        __builtin_new
    /* 85EF4 800956F4 68000424 */   addiu     $a0, $zero, 0x68
    /* 85EF8 800956F8 4C0053AC */  sw         $s3, 0x4C($v0)
    /* 85EFC 800956FC 480040AC */  sw         $zero, 0x48($v0)
    /* 85F00 80095700 4C0054AC */  sw         $s4, 0x4C($v0)
    /* 85F04 80095704 600040AC */  sw         $zero, 0x60($v0)
    /* 85F08 80095708 900302AE */  sw         $v0, 0x390($s0)
    /* 85F0C 8009570C 04001026 */  addiu      $s0, $s0, 0x4
    /* 85F10 80095710 B9550208 */  j          .L800956E4
    /* 85F14 80095714 01003126 */   addiu     $s1, $s1, 0x1
  .L80095718:
    /* 85F18 80095718 2128C000 */  addu       $a1, $a2, $zero
    /* 85F1C 8009571C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 85F20 80095720 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 85F24 80095724 640340AE */  sw         $zero, 0x364($s2)
    /* 85F28 80095728 6C0340AE */  sw         $zero, 0x36C($s2)
    /* 85F2C 8009572C C403448C */  lw         $a0, 0x3C4($v0)
    /* 85F30 80095730 00000000 */  nop
    /* 85F34 80095734 15008018 */  blez       $a0, .L8009578C
    /* 85F38 80095738 2118C000 */   addu      $v1, $a2, $zero
    /* 85F3C 8009573C 01000A24 */  addiu      $t2, $zero, 0x1
    /* 85F40 80095740 02000924 */  addiu      $t1, $zero, 0x2
    /* 85F44 80095744 41000824 */  addiu      $t0, $zero, 0x41
    /* 85F48 80095748 21388000 */  addu       $a3, $a0, $zero
    /* 85F4C 8009574C 21204000 */  addu       $a0, $v0, $zero
  .L80095750:
    /* 85F50 80095750 D803828C */  lw         $v0, 0x3D8($a0)
    /* 85F54 80095754 00000000 */  nop
    /* 85F58 80095758 03004A10 */  beq        $v0, $t2, .L80095768
    /* 85F5C 8009575C 00000000 */   nop
    /* 85F60 80095760 03004914 */  bne        $v0, $t1, .L80095770
    /* 85F64 80095764 00000000 */   nop
  .L80095768:
    /* 85F68 80095768 DF550208 */  j          .L8009577C
    /* 85F6C 8009576C 01006324 */   addiu     $v1, $v1, 0x1
  .L80095770:
    /* 85F70 80095770 02004814 */  bne        $v0, $t0, .L8009577C
    /* 85F74 80095774 00000000 */   nop
    /* 85F78 80095778 0100C624 */  addiu      $a2, $a2, 0x1
  .L8009577C:
    /* 85F7C 8009577C 0100A524 */  addiu      $a1, $a1, 0x1
    /* 85F80 80095780 2A10A700 */  slt        $v0, $a1, $a3
    /* 85F84 80095784 F2FF4014 */  bnez       $v0, .L80095750
    /* 85F88 80095788 B4008424 */   addiu     $a0, $a0, 0xB4
  .L8009578C:
    /* 85F8C 8009578C 0500C014 */  bnez       $a2, .L800957A4
    /* 85F90 80095790 02006228 */   slti      $v0, $v1, 0x2
    /* 85F94 80095794 03004014 */  bnez       $v0, .L800957A4
    /* 85F98 80095798 01000224 */   addiu     $v0, $zero, 0x1
    /* 85F9C 8009579C EA550208 */  j          .L800957A8
    /* 85FA0 800957A0 880342AE */   sw        $v0, 0x388($s2)
  .L800957A4:
    /* 85FA4 800957A4 880340AE */  sw         $zero, 0x388($s2)
  .L800957A8:
    /* 85FA8 800957A8 88A0030C */  jal        gettick
    /* 85FAC 800957AC 21800000 */   addu      $s0, $zero, $zero
    /* 85FB0 800957B0 1180023C */  lui        $v0, %hi(D_801135B0)
    /* 85FB4 800957B4 B035428C */  lw         $v0, %lo(D_801135B0)($v0)
    /* 85FB8 800957B8 00000000 */  nop
    /* 85FBC 800957BC 0A004018 */  blez       $v0, .L800957E8
    /* 85FC0 800957C0 7C0342AE */   sw        $v0, 0x37C($s2)
    /* 85FC4 800957C4 1800B127 */  addiu      $s1, $sp, 0x18
  .L800957C8:
    /* 85FC8 800957C8 21202002 */  addu       $a0, $s1, $zero
    /* 85FCC 800957CC D550020C */  jal        SetCar__Q26Speech11CarBankNamei
    /* 85FD0 800957D0 21280002 */   addu      $a1, $s0, $zero
    /* 85FD4 800957D4 7C03428E */  lw         $v0, 0x37C($s2)
    /* 85FD8 800957D8 01001026 */  addiu      $s0, $s0, 0x1
    /* 85FDC 800957DC 2A100202 */  slt        $v0, $s0, $v0
    /* 85FE0 800957E0 F9FF4014 */  bnez       $v0, .L800957C8
    /* 85FE4 800957E4 0C003126 */   addiu     $s1, $s1, 0xC
  .L800957E8:
    /* 85FE8 800957E8 BE51020C */  jal        CountLocations__6Speech
    /* 85FEC 800957EC 21204002 */   addu      $a0, $s2, $zero
    /* 85FF0 800957F0 1180023C */  lui        $v0, %hi(D_801132BC)
    /* 85FF4 800957F4 700340AE */  sw         $zero, 0x370($s2)
    /* 85FF8 800957F8 BC32438C */  lw         $v1, %lo(D_801132BC)($v0)
    /* 85FFC 800957FC 02000224 */  addiu      $v0, $zero, 0x2
    /* 86000 80095800 0D006210 */  beq        $v1, $v0, .L80095838
    /* 86004 80095804 21880000 */   addu      $s1, $zero, $zero
    /* 86008 80095808 03006228 */  slti       $v0, $v1, 0x3
    /* 8600C 8009580C 05004010 */  beqz       $v0, .L80095824
    /* 86010 80095810 01000224 */   addiu     $v0, $zero, 0x1
    /* 86014 80095814 0B006210 */  beq        $v1, $v0, .L80095844
    /* 86018 80095818 1480023C */   lui       $v0, %hi(D_8013D078)
    /* 8601C 8009581C 16560208 */  j          .L80095858
    /* 86020 80095820 78D04724 */   addiu     $a3, $v0, %lo(D_8013D078)
  .L80095824:
    /* 86024 80095824 06000224 */  addiu      $v0, $zero, 0x6
    /* 86028 80095828 09006210 */  beq        $v1, $v0, .L80095850
    /* 8602C 8009582C 1480023C */   lui       $v0, %hi(D_8013D078)
    /* 86030 80095830 16560208 */  j          .L80095858
    /* 86034 80095834 78D04724 */   addiu     $a3, $v0, %lo(D_8013D078)
  .L80095838:
    /* 86038 80095838 1480023C */  lui        $v0, %hi(D_8013D06C)
    /* 8603C 8009583C 16560208 */  j          .L80095858
    /* 86040 80095840 6CD04724 */   addiu     $a3, $v0, %lo(D_8013D06C)
  .L80095844:
    /* 86044 80095844 1480023C */  lui        $v0, %hi(D_8013D070)
    /* 86048 80095848 16560208 */  j          .L80095858
    /* 8604C 8009584C 70D04724 */   addiu     $a3, $v0, %lo(D_8013D070)
  .L80095850:
    /* 86050 80095850 1480023C */  lui        $v0, %hi(D_8013D074)
    /* 86054 80095854 74D04724 */  addiu      $a3, $v0, %lo(D_8013D074)
  .L80095858:
    /* 86058 80095858 8800B327 */  addiu      $s3, $sp, 0x88
    /* 8605C 8009585C 21206002 */  addu       $a0, $s3, $zero
    /* 86060 80095860 0580053C */  lui        $a1, %hi(D_80055BB4)
    /* 86064 80095864 1180023C */  lui        $v0, %hi(D_801164DC)
    /* 86068 80095868 DC64468C */  lw         $a2, %lo(D_801164DC)($v0)
    /* 8606C 8009586C 2F91030C */  jal        sprintf
    /* 86070 80095870 B45BA524 */   addiu     $a1, $a1, %lo(D_80055BB4)
    /* 86074 80095874 21206002 */  addu       $a0, $s3, $zero
    /* 86078 80095878 9F96030C */  jal        loadbigfileheader
    /* 8607C 8009587C 10000524 */   addiu     $a1, $zero, 0x10
    /* 86080 80095880 21804000 */  addu       $s0, $v0, $zero
    /* 86084 80095884 F000A0AF */  sw         $zero, 0xF0($sp)
    /* 86088 80095888 09000012 */  beqz       $s0, .L800958B0
    /* 8608C 8009588C F400A0AF */   sw        $zero, 0xF4($sp)
    /* 86090 80095890 F400A227 */  addiu      $v0, $sp, 0xF4
    /* 86094 80095894 1000A2AF */  sw         $v0, 0x10($sp)
    /* 86098 80095898 21204002 */  addu       $a0, $s2, $zero
    /* 8609C 8009589C 21280002 */  addu       $a1, $s0, $zero
    /* 860A0 800958A0 1800A627 */  addiu      $a2, $sp, 0x18
    /* 860A4 800958A4 EA53020C */  jal        CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3
    /* 860A8 800958A8 F000A727 */   addiu     $a3, $sp, 0xF0
    /* 860AC 800958AC 21884000 */  addu       $s1, $v0, $zero
  .L800958B0:
    /* 860B0 800958B0 0800201A */  blez       $s1, .L800958D4
    /* 860B4 800958B4 0580043C */   lui       $a0, %hi(D_80055BC4)
    /* 860B8 800958B8 C45B8424 */  addiu      $a0, $a0, %lo(D_80055BC4)
    /* 860BC 800958BC 7003458E */  lw         $a1, 0x370($s2)
    /* 860C0 800958C0 21300000 */  addu       $a2, $zero, $zero
    /* 860C4 800958C4 80280500 */  sll        $a1, $a1, 2
    /* 860C8 800958C8 CF94030C */  jal        reservememadr
    /* 860CC 800958CC 2128B100 */   addu      $a1, $a1, $s1
    /* 860D0 800958D0 6C0342AE */  sw         $v0, 0x36C($s2)
  .L800958D4:
    /* 860D4 800958D4 6C03428E */  lw         $v0, 0x36C($s2)
    /* 860D8 800958D8 00000000 */  nop
    /* 860DC 800958DC 1E004010 */  beqz       $v0, .L80095958
    /* 860E0 800958E0 112B0424 */   addiu     $a0, $zero, 0x2B11
    /* 860E4 800958E4 10000524 */  addiu      $a1, $zero, 0x10
    /* 860E8 800958E8 9BAD030C */  jal        SPCH_GetSampleDataRate
    /* 860EC 800958EC 02000624 */   addiu     $a2, $zero, 0x2
    /* 860F0 800958F0 0980043C */  lui        $a0, %hi(Speech_HandleRequest__Fllll)
    /* 860F4 800958F4 34438424 */  addiu      $a0, $a0, %lo(Speech_HandleRequest__Fllll)
    /* 860F8 800958F8 3412053C */  lui        $a1, (0x12345678 >> 16)
    /* 860FC 800958FC 7856A534 */  ori        $a1, $a1, (0x12345678 & 0xFFFF)
    /* 86100 80095900 D2AD030C */  jal        SPCH_Init
    /* 86104 80095904 21304000 */   addu      $a2, $v0, $zero
    /* 86108 80095908 0980043C */  lui        $a0, %hi(Speech_AllocateRAM__FlPc)
    /* 8610C 8009590C E8428424 */  addiu      $a0, $a0, %lo(Speech_AllocateRAM__FlPc)
    /* 86110 80095910 0980053C */  lui        $a1, %hi(Speech_PurgeRAM__FPc)
    /* 86114 80095914 7003468E */  lw         $a2, 0x370($s2)
    /* 86118 80095918 BCAD030C */  jal        SPCH_InitBankMem
    /* 8611C 8009591C 1443A524 */   addiu     $a1, $a1, %lo(Speech_PurgeRAM__FPc)
    /* 86120 80095920 21206002 */  addu       $a0, $s3, $zero
    /* 86124 80095924 01000524 */  addiu      $a1, $zero, 0x1
    /* 86128 80095928 64000624 */  addiu      $a2, $zero, 0x64
    /* 8612C 8009592C 2AAA030C */  jal        FILE_opensync
    /* 86130 80095930 68034726 */   addiu     $a3, $s2, 0x368
    /* 86134 80095934 21204002 */  addu       $a0, $s2, $zero
    /* 86138 80095938 21280002 */  addu       $a1, $s0, $zero
    /* 8613C 8009593C 2B100200 */  sltu       $v0, $zero, $v0
    /* 86140 80095940 640342AE */  sw         $v0, 0x364($s2)
    /* 86144 80095944 F000A78F */  lw         $a3, 0xF0($sp)
    /* 86148 80095948 F400A28F */  lw         $v0, 0xF4($sp)
    /* 8614C 8009594C 1800A627 */  addiu      $a2, $sp, 0x18
    /* 86150 80095950 6F54020C */  jal        LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell
    /* 86154 80095954 1000A2AF */   sw        $v0, 0x10($sp)
  .L80095958:
    /* 86158 80095958 03000012 */  beqz       $s0, .L80095968
    /* 8615C 8009595C 00000000 */   nop
    /* 86160 80095960 5095030C */  jal        purgememadr
    /* 86164 80095964 21200002 */   addu      $a0, $s0, $zero
  .L80095968:
    /* 86168 80095968 88A0030C */  jal        gettick
    /* 8616C 8009596C 00000000 */   nop
    /* 86170 80095970 21104002 */  addu       $v0, $s2, $zero
    /* 86174 80095974 0C01BF8F */  lw         $ra, 0x10C($sp)
    /* 86178 80095978 0801B48F */  lw         $s4, 0x108($sp)
    /* 8617C 8009597C 0401B38F */  lw         $s3, 0x104($sp)
    /* 86180 80095980 0001B28F */  lw         $s2, 0x100($sp)
    /* 86184 80095984 FC00B18F */  lw         $s1, 0xFC($sp)
    /* 86188 80095988 F800B08F */  lw         $s0, 0xF8($sp)
    /* 8618C 8009598C 0800E003 */  jr         $ra
    /* 86190 80095990 1001BD27 */   addiu     $sp, $sp, 0x110
endlabel __6Speech
