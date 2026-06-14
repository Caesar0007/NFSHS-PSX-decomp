.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_ReadInCarTextureData__FPcP8Car_tObjii, 0x7AC

glabel CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* ACF04 800BC704 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* ACF08 800BC708 6000B0AF */  sw         $s0, 0x60($sp)
    /* ACF0C 800BC70C 2180E000 */  addu       $s0, $a3, $zero
    /* ACF10 800BC710 08000824 */  addiu      $t0, $zero, 0x8
    /* ACF14 800BC714 8400BFAF */  sw         $ra, 0x84($sp)
    /* ACF18 800BC718 8000BEAF */  sw         $fp, 0x80($sp)
    /* ACF1C 800BC71C 7C00B7AF */  sw         $s7, 0x7C($sp)
    /* ACF20 800BC720 7800B6AF */  sw         $s6, 0x78($sp)
    /* ACF24 800BC724 7400B5AF */  sw         $s5, 0x74($sp)
    /* ACF28 800BC728 7000B4AF */  sw         $s4, 0x70($sp)
    /* ACF2C 800BC72C 6C00B3AF */  sw         $s3, 0x6C($sp)
    /* ACF30 800BC730 6800B2AF */  sw         $s2, 0x68($sp)
    /* ACF34 800BC734 6400B1AF */  sw         $s1, 0x64($sp)
    /* ACF38 800BC738 8800A4AF */  sw         $a0, 0x88($sp)
    /* ACF3C 800BC73C 8C00A5AF */  sw         $a1, 0x8C($sp)
    /* ACF40 800BC740 9000A6AF */  sw         $a2, 0x90($sp)
    /* ACF44 800BC744 4800A8AF */  sw         $t0, 0x48($sp)
    /* ACF48 800BC748 BC08A984 */  lh         $t1, 0x8BC($a1)
    /* ACF4C 800BC74C 0100C230 */  andi       $v0, $a2, 0x1
    /* ACF50 800BC750 4C004014 */  bnez       $v0, .L800BC884
    /* ACF54 800BC754 4000A9AF */   sw        $t1, 0x40($sp)
    /* ACF58 800BC758 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* ACF5C 800BC75C 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* ACF60 800BC760 00000000 */  nop
    /* ACF64 800BC764 30004014 */  bnez       $v0, .L800BC828
    /* ACF68 800BC768 1280023C */   lui       $v0, %hi(CarIO_carVRamSlotsMenu)
    /* ACF6C 800BC76C 1280023C */  lui        $v0, %hi(CarIO_carVRamSlots)
    /* ACF70 800BC770 F411848F */  lw         $a0, %gp_rel(CarIO_carVRamCount)($gp)
    /* ACF74 800BC774 68EA4224 */  addiu      $v0, $v0, %lo(CarIO_carVRamSlots)
    /* ACF78 800BC778 80180400 */  sll        $v1, $a0, 2
    /* ACF7C 800BC77C 21186200 */  addu       $v1, $v1, $v0
    /* ACF80 800BC780 00006294 */  lhu        $v0, 0x0($v1)
    /* ACF84 800BC784 00000000 */  nop
    /* ACF88 800BC788 C408A2A4 */  sh         $v0, 0x8C4($a1)
    /* ACF8C 800BC78C 00140200 */  sll        $v0, $v0, 16
    /* ACF90 800BC790 03B40200 */  sra        $s6, $v0, 16
    /* ACF94 800BC794 02006394 */  lhu        $v1, 0x2($v1)
    /* ACF98 800BC798 8C00A88F */  lw         $t0, 0x8C($sp)
    /* ACF9C 800BC79C 00140300 */  sll        $v0, $v1, 16
    /* ACFA0 800BC7A0 03BC0200 */  sra        $s7, $v0, 16
    /* ACFA4 800BC7A4 1C002229 */  slti       $v0, $t1, 0x1C
    /* ACFA8 800BC7A8 1B004010 */  beqz       $v0, .L800BC818
    /* ACFAC 800BC7AC C60803A5 */   sh        $v1, 0x8C6($t0)
    /* ACFB0 800BC7B0 C0080295 */  lhu        $v0, 0x8C0($t0)
    /* ACFB4 800BC7B4 00000000 */  nop
    /* ACFB8 800BC7B8 01004230 */  andi       $v0, $v0, 0x1
    /* ACFBC 800BC7BC 12004010 */  beqz       $v0, .L800BC808
    /* ACFC0 800BC7C0 5555023C */   lui       $v0, (0x55555556 >> 16)
    /* ACFC4 800BC7C4 56554234 */  ori        $v0, $v0, (0x55555556 & 0xFFFF)
    /* ACFC8 800BC7C8 18008200 */  mult       $a0, $v0
    /* ACFCC 800BC7CC C3170400 */  sra        $v0, $a0, 31
    /* ACFD0 800BC7D0 1280033C */  lui        $v1, %hi(CarIO_carVRamAdd)
    /* ACFD4 800BC7D4 C8EA6324 */  addiu      $v1, $v1, %lo(CarIO_carVRamAdd)
    /* ACFD8 800BC7D8 10400000 */  mfhi       $t0
    /* ACFDC 800BC7DC 23100201 */  subu       $v0, $t0, $v0
    /* ACFE0 800BC7E0 40100200 */  sll        $v0, $v0, 1
    /* ACFE4 800BC7E4 21104300 */  addu       $v0, $v0, $v1
    /* ACFE8 800BC7E8 00004384 */  lh         $v1, 0x0($v0)
    /* ACFEC 800BC7EC 00000000 */  nop
    /* ACFF0 800BC7F0 40100300 */  sll        $v0, $v1, 1
    /* ACFF4 800BC7F4 21104300 */  addu       $v0, $v0, $v1
    /* ACFF8 800BC7F8 21108200 */  addu       $v0, $a0, $v0
    /* ACFFC 800BC7FC F41182AF */  sw         $v0, %gp_rel(CarIO_carVRamCount)($gp)
    /* AD000 800BC800 25F20208 */  j          .L800BC894
    /* AD004 800BC804 00000000 */   nop
  .L800BC808:
    /* AD008 800BC808 03008224 */  addiu      $v0, $a0, 0x3
    /* AD00C 800BC80C F41182AF */  sw         $v0, %gp_rel(CarIO_carVRamCount)($gp)
    /* AD010 800BC810 25F20208 */  j          .L800BC894
    /* AD014 800BC814 00000000 */   nop
  .L800BC818:
    /* AD018 800BC818 01008224 */  addiu      $v0, $a0, 0x1
    /* AD01C 800BC81C F41182AF */  sw         $v0, %gp_rel(CarIO_carVRamCount)($gp)
    /* AD020 800BC820 25F20208 */  j          .L800BC894
    /* AD024 800BC824 00000000 */   nop
  .L800BC828:
    /* AD028 800BC828 B0EA4224 */  addiu      $v0, $v0, %lo(CarIO_carVRamSlotsMenu)
    /* AD02C 800BC82C F411858F */  lw         $a1, %gp_rel(CarIO_carVRamCount)($gp)
    /* AD030 800BC830 8C00A98F */  lw         $t1, 0x8C($sp)
    /* AD034 800BC834 80180500 */  sll        $v1, $a1, 2
    /* AD038 800BC838 21186200 */  addu       $v1, $v1, $v0
    /* AD03C 800BC83C 00006294 */  lhu        $v0, 0x0($v1)
    /* AD040 800BC840 00000000 */  nop
    /* AD044 800BC844 C40822A5 */  sh         $v0, 0x8C4($t1)
    /* AD048 800BC848 00140200 */  sll        $v0, $v0, 16
    /* AD04C 800BC84C 03B40200 */  sra        $s6, $v0, 16
    /* AD050 800BC850 02006494 */  lhu        $a0, 0x2($v1)
    /* AD054 800BC854 1280033C */  lui        $v1, %hi(CarIO_carVRamAdd)
    /* AD058 800BC858 C8EA6324 */  addiu      $v1, $v1, %lo(CarIO_carVRamAdd)
    /* AD05C 800BC85C 40100500 */  sll        $v0, $a1, 1
    /* AD060 800BC860 21104300 */  addu       $v0, $v0, $v1
    /* AD064 800BC864 C60824A5 */  sh         $a0, 0x8C6($t1)
    /* AD068 800BC868 00240400 */  sll        $a0, $a0, 16
    /* AD06C 800BC86C 00004284 */  lh         $v0, 0x0($v0)
    /* AD070 800BC870 00000000 */  nop
    /* AD074 800BC874 2128A200 */  addu       $a1, $a1, $v0
    /* AD078 800BC878 F41185AF */  sw         $a1, %gp_rel(CarIO_carVRamCount)($gp)
    /* AD07C 800BC87C 25F20208 */  j          .L800BC894
    /* AD080 800BC880 03BC0400 */   sra       $s7, $a0, 16
  .L800BC884:
    /* AD084 800BC884 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD088 800BC888 00000000 */  nop
    /* AD08C 800BC88C C4081685 */  lh         $s6, 0x8C4($t0)
    /* AD090 800BC890 C6081785 */  lh         $s7, 0x8C6($t0)
  .L800BC894:
    /* AD094 800BC894 9000A98F */  lw         $t1, 0x90($sp)
    /* AD098 800BC898 00000000 */  nop
    /* AD09C 800BC89C 10002231 */  andi       $v0, $t1, 0x10
    /* AD0A0 800BC8A0 06004014 */  bnez       $v0, .L800BC8BC
    /* AD0A4 800BC8A4 00000000 */   nop
    /* AD0A8 800BC8A8 F011828F */  lw         $v0, %gp_rel(CarIO_carPixMapCount)($gp)
    /* AD0AC 800BC8AC 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD0B0 800BC8B0 4400A2AF */  sw         $v0, 0x44($sp)
    /* AD0B4 800BC8B4 34F20208 */  j          .L800BC8D0
    /* AD0B8 800BC8B8 440802AD */   sw        $v0, 0x844($t0)
  .L800BC8BC:
    /* AD0BC 800BC8BC 8C00A98F */  lw         $t1, 0x8C($sp)
    /* AD0C0 800BC8C0 00000000 */  nop
    /* AD0C4 800BC8C4 4408298D */  lw         $t1, 0x844($t1)
    /* AD0C8 800BC8C8 00000000 */  nop
    /* AD0CC 800BC8CC 4400A9AF */  sw         $t1, 0x44($sp)
  .L800BC8D0:
    /* AD0D0 800BC8D0 9000A88F */  lw         $t0, 0x90($sp)
    /* AD0D4 800BC8D4 00000000 */  nop
    /* AD0D8 800BC8D8 08000231 */  andi       $v0, $t0, 0x8
    /* AD0DC 800BC8DC 1C004010 */  beqz       $v0, .L800BC950
    /* AD0E0 800BC8E0 00000000 */   nop
    /* AD0E4 800BC8E4 8C00A98F */  lw         $t1, 0x8C($sp)
    /* AD0E8 800BC8E8 00000000 */  nop
    /* AD0EC 800BC8EC C0082295 */  lhu        $v0, 0x8C0($t1)
    /* AD0F0 800BC8F0 00000000 */  nop
    /* AD0F4 800BC8F4 01004230 */  andi       $v0, $v0, 0x1
    /* AD0F8 800BC8F8 10004010 */  beqz       $v0, .L800BC93C
    /* AD0FC 800BC8FC 3F00C232 */   andi      $v0, $s6, 0x3F
    /* AD100 800BC900 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AD104 800BC904 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AD108 800BC908 00000000 */  nop
    /* AD10C 800BC90C 02004014 */  bnez       $v0, .L800BC918
    /* AD110 800BC910 00FEC326 */   addiu     $v1, $s6, -0x200
    /* AD114 800BC914 80FDC326 */  addiu      $v1, $s6, -0x280
  .L800BC918:
    /* AD118 800BC918 83190300 */  sra        $v1, $v1, 6
    /* AD11C 800BC91C 1280023C */  lui        $v0, %hi(CarIO_carVRamOffset)
    /* AD120 800BC920 D4EA4224 */  addiu      $v0, $v0, %lo(CarIO_carVRamOffset)
    /* AD124 800BC924 40180300 */  sll        $v1, $v1, 1
    /* AD128 800BC928 21186200 */  addu       $v1, $v1, $v0
    /* AD12C 800BC92C 00006284 */  lh         $v0, 0x0($v1)
    /* AD130 800BC930 00000000 */  nop
    /* AD134 800BC934 21B0C202 */  addu       $s6, $s6, $v0
    /* AD138 800BC938 3F00C232 */  andi       $v0, $s6, 0x3F
  .L800BC93C:
    /* AD13C 800BC93C 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD140 800BC940 80100200 */  sll        $v0, $v0, 2
    /* AD144 800BC944 C80802A5 */  sh         $v0, 0x8C8($t0)
    /* AD148 800BC948 FF00E232 */  andi       $v0, $s7, 0xFF
    /* AD14C 800BC94C CA0802A5 */  sh         $v0, 0x8CA($t0)
  .L800BC950:
    /* AD150 800BC950 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AD154 800BC954 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AD158 800BC958 00000000 */  nop
    /* AD15C 800BC95C 05004014 */  bnez       $v0, .L800BC974
    /* AD160 800BC960 21980000 */   addu      $s3, $zero, $zero
    /* AD164 800BC964 4800A98F */  lw         $t1, 0x48($sp)
    /* AD168 800BC968 00000000 */  nop
    /* AD16C 800BC96C 10002935 */  ori        $t1, $t1, 0x10
    /* AD170 800BC970 4800A9AF */  sw         $t1, 0x48($sp)
  .L800BC974:
    /* AD174 800BC974 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD178 800BC978 4400A98F */  lw         $t1, 0x44($sp)
    /* AD17C 800BC97C 8408028D */  lw         $v0, 0x884($t0)
    /* AD180 800BC980 1480013C */  lui        $at, %hi(Texture_palCopy)
    /* AD184 800BC984 0CDB22AC */  sw         $v0, %lo(Texture_palCopy)($at)
    /* AD188 800BC988 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* AD18C 800BC98C 00890900 */   sll       $s1, $t1, 4
    /* AD190 800BC990 80181000 */  sll        $v1, $s0, 2
    /* AD194 800BC994 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* AD198 800BC998 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* AD19C 800BC99C 21106200 */  addu       $v0, $v1, $v0
    /* AD1A0 800BC9A0 5000A2AF */  sw         $v0, 0x50($sp)
    /* AD1A4 800BC9A4 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* AD1A8 800BC9A8 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
    /* AD1AC 800BC9AC 21186200 */  addu       $v1, $v1, $v0
    /* AD1B0 800BC9B0 1280023C */  lui        $v0, %hi(D_8011E804)
    /* AD1B4 800BC9B4 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD1B8 800BC9B8 04E85E24 */  addiu      $fp, $v0, %lo(D_8011E804)
    /* AD1BC 800BC9BC 5400A3AF */  sw         $v1, 0x54($sp)
    /* AD1C0 800BC9C0 5800A8AF */  sw         $t0, 0x58($sp)
  .L800BC9C4:
    /* AD1C4 800BC9C4 3300622A */  slti       $v0, $s3, 0x33
    /* AD1C8 800BC9C8 25014010 */  beqz       $v0, .L800BCE60
    /* AD1CC 800BC9CC 00000000 */   nop
    /* AD1D0 800BC9D0 8800A48F */  lw         $a0, 0x88($sp)
    /* AD1D4 800BC9D4 0400C58F */  lw         $a1, 0x4($fp)
    /* AD1D8 800BC9D8 5CAC030C */  jal        locateshapez
    /* AD1DC 800BC9DC 01001424 */   addiu     $s4, $zero, 0x1
    /* AD1E0 800BC9E0 0800C98F */  lw         $t1, 0x8($fp)
    /* AD1E4 800BC9E4 21904000 */  addu       $s2, $v0, $zero
    /* AD1E8 800BC9E8 08004016 */  bnez       $s2, .L800BCA0C
    /* AD1EC 800BC9EC 4C00A9AF */   sw        $t1, 0x4C($sp)
    /* AD1F0 800BC9F0 07002015 */  bnez       $t1, .L800BCA10
    /* AD1F4 800BC9F4 14000224 */   addiu     $v0, $zero, 0x14
    /* AD1F8 800BC9F8 0000C58F */  lw         $a1, 0x0($fp)
    /* AD1FC 800BC9FC 8800A48F */  lw         $a0, 0x88($sp)
    /* AD200 800BCA00 5CAC030C */  jal        locateshapez
    /* AD204 800BCA04 21A00000 */   addu      $s4, $zero, $zero
    /* AD208 800BCA08 21904000 */  addu       $s2, $v0, $zero
  .L800BCA0C:
    /* AD20C 800BCA0C 14000224 */  addiu      $v0, $zero, 0x14
  .L800BCA10:
    /* AD210 800BCA10 02006216 */  bne        $s3, $v0, .L800BCA1C
    /* AD214 800BCA14 00000000 */   nop
    /* AD218 800BCA18 4800A0AF */  sw         $zero, 0x48($sp)
  .L800BCA1C:
    /* AD21C 800BCA1C 76004012 */  beqz       $s2, .L800BCBF8
    /* AD220 800BCA20 00000000 */   nop
    /* AD224 800BCA24 4800A88F */  lw         $t0, 0x48($sp)
    /* AD228 800BCA28 00000000 */  nop
    /* AD22C 800BCA2C 06000011 */  beqz       $t0, .L800BCA48
    /* AD230 800BCA30 21800000 */   addu      $s0, $zero, $zero
    /* AD234 800BCA34 1480023C */  lui        $v0, %hi(Texture_palNum)
    /* AD238 800BCA38 10DB4294 */  lhu        $v0, %lo(Texture_palNum)($v0)
    /* AD23C 800BCA3C 5800A98F */  lw         $t1, 0x58($sp)
    /* AD240 800BCA40 00000000 */  nop
    /* AD244 800BCA44 8A0822A5 */  sh         $v0, 0x88A($t1)
  .L800BCA48:
    /* AD248 800BCA48 4000A88F */  lw         $t0, 0x40($sp)
    /* AD24C 800BCA4C 00000000 */  nop
    /* AD250 800BCA50 16000229 */  slti       $v0, $t0, 0x16
    /* AD254 800BCA54 4B004010 */  beqz       $v0, .L800BCB84
    /* AD258 800BCA58 40100800 */   sll       $v0, $t0, 1
    /* AD25C 800BCA5C 21104800 */  addu       $v0, $v0, $t0
    /* AD260 800BCA60 80100200 */  sll        $v0, $v0, 2
    /* AD264 800BCA64 1280093C */  lui        $t1, %hi(CarIO_licensePlate)
    /* AD268 800BCA68 E0EA2925 */  addiu      $t1, $t1, %lo(CarIO_licensePlate)
    /* AD26C 800BCA6C 21184900 */  addu       $v1, $v0, $t1
    /* AD270 800BCA70 00006284 */  lh         $v0, 0x0($v1)
    /* AD274 800BCA74 00000000 */  nop
    /* AD278 800BCA78 1F006216 */  bne        $s3, $v0, .L800BCAF8
    /* AD27C 800BCA7C 2000A527 */   addiu     $a1, $sp, 0x20
    /* AD280 800BCA80 2400A627 */  addiu      $a2, $sp, 0x24
    /* AD284 800BCA84 9000A48F */  lw         $a0, 0x90($sp)
    /* AD288 800BCA88 8C00A78F */  lw         $a3, 0x8C($sp)
    /* AD28C 800BCA8C 02006284 */  lh         $v0, 0x2($v1)
    /* AD290 800BCA90 04006384 */  lh         $v1, 0x4($v1)
    /* AD294 800BCA94 2110C202 */  addu       $v0, $s6, $v0
    /* AD298 800BCA98 2118E302 */  addu       $v1, $s7, $v1
    /* AD29C 800BCA9C 2000A2AF */  sw         $v0, 0x20($sp)
    /* AD2A0 800BCAA0 2400A3AF */  sw         $v1, 0x24($sp)
    /* AD2A4 800BCAA4 9AF1020C */  jal        CarIO_LicenseCheck__FiPiT1P8Car_tObji
    /* AD2A8 800BCAA8 1000A0AF */   sw        $zero, 0x10($sp)
    /* AD2AC 800BCAAC 4800A68F */  lw         $a2, 0x48($sp)
    /* AD2B0 800BCAB0 2000A78F */  lw         $a3, 0x20($sp)
    /* AD2B4 800BCAB4 2400A58F */  lw         $a1, 0x24($sp)
    /* AD2B8 800BCAB8 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD2BC 800BCABC 5000A88F */  lw         $t0, 0x50($sp)
    /* AD2C0 800BCAC0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AD2C4 800BCAC4 1400A2AF */  sw         $v0, 0x14($sp)
    /* AD2C8 800BCAC8 1800A2AF */  sw         $v0, 0x18($sp)
    /* AD2CC 800BCACC 21187100 */  addu       $v1, $v1, $s1
    /* AD2D0 800BCAD0 1000A5AF */  sw         $a1, 0x10($sp)
    /* AD2D4 800BCAD4 1C00A3AF */  sw         $v1, 0x1C($sp)
    /* AD2D8 800BCAD8 0000058D */  lw         $a1, 0x0($t0)
    /* AD2DC 800BCADC C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD2E0 800BCAE0 21200000 */   addu      $a0, $zero, $zero
    /* AD2E4 800BCAE4 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD2E8 800BCAE8 01001024 */  addiu      $s0, $zero, 0x1
    /* AD2EC 800BCAEC 21102202 */  addu       $v0, $s1, $v0
    /* AD2F0 800BCAF0 E1F20208 */  j          .L800BCB84
    /* AD2F4 800BCAF4 0E0050A4 */   sh        $s0, 0xE($v0)
  .L800BCAF8:
    /* AD2F8 800BCAF8 06006284 */  lh         $v0, 0x6($v1)
    /* AD2FC 800BCAFC 00000000 */  nop
    /* AD300 800BCB00 20006216 */  bne        $s3, $v0, .L800BCB84
    /* AD304 800BCB04 2800A527 */   addiu     $a1, $sp, 0x28
    /* AD308 800BCB08 2C00A627 */  addiu      $a2, $sp, 0x2C
    /* AD30C 800BCB0C 9000A48F */  lw         $a0, 0x90($sp)
    /* AD310 800BCB10 8C00A78F */  lw         $a3, 0x8C($sp)
    /* AD314 800BCB14 08006284 */  lh         $v0, 0x8($v1)
    /* AD318 800BCB18 0A006384 */  lh         $v1, 0xA($v1)
    /* AD31C 800BCB1C 2110C202 */  addu       $v0, $s6, $v0
    /* AD320 800BCB20 2118E302 */  addu       $v1, $s7, $v1
    /* AD324 800BCB24 2800A2AF */  sw         $v0, 0x28($sp)
    /* AD328 800BCB28 01000224 */  addiu      $v0, $zero, 0x1
    /* AD32C 800BCB2C 2C00A3AF */  sw         $v1, 0x2C($sp)
    /* AD330 800BCB30 9AF1020C */  jal        CarIO_LicenseCheck__FiPiT1P8Car_tObji
    /* AD334 800BCB34 1000A2AF */   sw        $v0, 0x10($sp)
    /* AD338 800BCB38 4800A68F */  lw         $a2, 0x48($sp)
    /* AD33C 800BCB3C 2800A78F */  lw         $a3, 0x28($sp)
    /* AD340 800BCB40 2C00A58F */  lw         $a1, 0x2C($sp)
    /* AD344 800BCB44 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD348 800BCB48 5400A98F */  lw         $t1, 0x54($sp)
    /* AD34C 800BCB4C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AD350 800BCB50 1400A2AF */  sw         $v0, 0x14($sp)
    /* AD354 800BCB54 1800A2AF */  sw         $v0, 0x18($sp)
    /* AD358 800BCB58 21187100 */  addu       $v1, $v1, $s1
    /* AD35C 800BCB5C 1000A5AF */  sw         $a1, 0x10($sp)
    /* AD360 800BCB60 1C00A3AF */  sw         $v1, 0x1C($sp)
    /* AD364 800BCB64 0000258D */  lw         $a1, 0x0($t1)
    /* AD368 800BCB68 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD36C 800BCB6C 21200000 */   addu      $a0, $zero, $zero
    /* AD370 800BCB70 01001024 */  addiu      $s0, $zero, 0x1
    /* AD374 800BCB74 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD378 800BCB78 02000224 */  addiu      $v0, $zero, 0x2
    /* AD37C 800BCB7C 21182302 */  addu       $v1, $s1, $v1
    /* AD380 800BCB80 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BCB84:
    /* AD384 800BCB84 0E000016 */  bnez       $s0, .L800BCBC0
    /* AD388 800BCB88 20000224 */   addiu     $v0, $zero, 0x20
    /* AD38C 800BCB8C 21200000 */  addu       $a0, $zero, $zero
    /* AD390 800BCB90 21284002 */  addu       $a1, $s2, $zero
    /* AD394 800BCB94 2138C002 */  addu       $a3, $s6, $zero
    /* AD398 800BCB98 4800A68F */  lw         $a2, 0x48($sp)
    /* AD39C 800BCB9C D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD3A0 800BCBA0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AD3A4 800BCBA4 1000B7AF */  sw         $s7, 0x10($sp)
    /* AD3A8 800BCBA8 1400A2AF */  sw         $v0, 0x14($sp)
    /* AD3AC 800BCBAC 1800A2AF */  sw         $v0, 0x18($sp)
    /* AD3B0 800BCBB0 21187100 */  addu       $v1, $v1, $s1
    /* AD3B4 800BCBB4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD3B8 800BCBB8 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* AD3BC 800BCBBC 20000224 */  addiu      $v0, $zero, 0x20
  .L800BCBC0:
    /* AD3C0 800BCBC0 06006216 */  bne        $s3, $v0, .L800BCBDC
    /* AD3C4 800BCBC4 02000524 */   addiu     $a1, $zero, 0x2
    /* AD3C8 800BCBC8 D011848F */  lw         $a0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD3CC 800BCBCC 00000000 */  nop
    /* AD3D0 800BCBD0 21209100 */  addu       $a0, $a0, $s1
    /* AD3D4 800BCBD4 B4F9020C */  jal        ChangeTPage__FPUsi
    /* AD3D8 800BCBD8 06008424 */   addiu     $a0, $a0, 0x6
  .L800BCBDC:
    /* AD3DC 800BCBDC D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD3E0 800BCBE0 00000000 */  nop
    /* AD3E4 800BCBE4 21182302 */  addu       $v1, $s1, $v1
    /* AD3E8 800BCBE8 0E006294 */  lhu        $v0, 0xE($v1)
    /* AD3EC 800BCBEC 00000000 */  nop
    /* AD3F0 800BCBF0 80004234 */  ori        $v0, $v0, 0x80
    /* AD3F4 800BCBF4 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BCBF8:
    /* AD3F8 800BCBF8 8F008012 */  beqz       $s4, .L800BCE38
    /* AD3FC 800BCBFC 00000000 */   nop
    /* AD400 800BCC00 4C00A88F */  lw         $t0, 0x4C($sp)
    /* AD404 800BCC04 4400B08F */  lw         $s0, 0x44($sp)
    /* AD408 800BCC08 11000011 */  beqz       $t0, .L800BCC50
    /* AD40C 800BCC0C 00000000 */   nop
    /* AD410 800BCC10 4800A98F */  lw         $t1, 0x48($sp)
    /* AD414 800BCC14 00000000 */  nop
    /* AD418 800BCC18 08002011 */  beqz       $t1, .L800BCC3C
    /* AD41C 800BCC1C FFFF1025 */   addiu     $s0, $t0, -0x1
    /* AD420 800BCC20 40101000 */  sll        $v0, $s0, 1
    /* AD424 800BCC24 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD428 800BCC28 5800A98F */  lw         $t1, 0x58($sp)
    /* AD42C 800BCC2C 21100201 */  addu       $v0, $t0, $v0
    /* AD430 800BCC30 8A084294 */  lhu        $v0, 0x88A($v0)
    /* AD434 800BCC34 00000000 */  nop
    /* AD438 800BCC38 8A0822A5 */  sh         $v0, 0x88A($t1)
  .L800BCC3C:
    /* AD43C 800BCC3C 8C00A88F */  lw         $t0, 0x8C($sp)
    /* AD440 800BCC40 00000000 */  nop
    /* AD444 800BCC44 4408028D */  lw         $v0, 0x844($t0)
    /* AD448 800BCC48 00000000 */  nop
    /* AD44C 800BCC4C 21800202 */  addu       $s0, $s0, $v0
  .L800BCC50:
    /* AD450 800BCC50 0000C58F */  lw         $a1, 0x0($fp)
    /* AD454 800BCC54 8800A48F */  lw         $a0, 0x88($sp)
    /* AD458 800BCC58 5CAC030C */  jal        locateshapez
    /* AD45C 800BCC5C 00000000 */   nop
    /* AD460 800BCC60 21904000 */  addu       $s2, $v0, $zero
    /* AD464 800BCC64 74004012 */  beqz       $s2, .L800BCE38
    /* AD468 800BCC68 00111000 */   sll       $v0, $s0, 4
    /* AD46C 800BCC6C D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD470 800BCC70 21800000 */  addu       $s0, $zero, $zero
    /* AD474 800BCC74 21104300 */  addu       $v0, $v0, $v1
    /* AD478 800BCC78 02004394 */  lhu        $v1, 0x2($v0)
    /* AD47C 800BCC7C 4000A98F */  lw         $t1, 0x40($sp)
    /* AD480 800BCC80 3F006230 */  andi       $v0, $v1, 0x3F
    /* AD484 800BCC84 00A10200 */  sll        $s4, $v0, 4
    /* AD488 800BCC88 16002229 */  slti       $v0, $t1, 0x16
    /* AD48C 800BCC8C 4A004010 */  beqz       $v0, .L800BCDB8
    /* AD490 800BCC90 82A90300 */   srl       $s5, $v1, 6
    /* AD494 800BCC94 40100900 */  sll        $v0, $t1, 1
    /* AD498 800BCC98 21104900 */  addu       $v0, $v0, $t1
    /* AD49C 800BCC9C 80100200 */  sll        $v0, $v0, 2
    /* AD4A0 800BCCA0 1280083C */  lui        $t0, %hi(CarIO_licensePlate)
    /* AD4A4 800BCCA4 E0EA0825 */  addiu      $t0, $t0, %lo(CarIO_licensePlate)
    /* AD4A8 800BCCA8 21184800 */  addu       $v1, $v0, $t0
    /* AD4AC 800BCCAC 00006284 */  lh         $v0, 0x0($v1)
    /* AD4B0 800BCCB0 00000000 */  nop
    /* AD4B4 800BCCB4 1E006216 */  bne        $s3, $v0, .L800BCD30
    /* AD4B8 800BCCB8 3000A527 */   addiu     $a1, $sp, 0x30
    /* AD4BC 800BCCBC 3400A627 */  addiu      $a2, $sp, 0x34
    /* AD4C0 800BCCC0 9000A48F */  lw         $a0, 0x90($sp)
    /* AD4C4 800BCCC4 8C00A78F */  lw         $a3, 0x8C($sp)
    /* AD4C8 800BCCC8 02006284 */  lh         $v0, 0x2($v1)
    /* AD4CC 800BCCCC 04006384 */  lh         $v1, 0x4($v1)
    /* AD4D0 800BCCD0 2110C202 */  addu       $v0, $s6, $v0
    /* AD4D4 800BCCD4 2118E302 */  addu       $v1, $s7, $v1
    /* AD4D8 800BCCD8 3000A2AF */  sw         $v0, 0x30($sp)
    /* AD4DC 800BCCDC 3400A3AF */  sw         $v1, 0x34($sp)
    /* AD4E0 800BCCE0 9AF1020C */  jal        CarIO_LicenseCheck__FiPiT1P8Car_tObji
    /* AD4E4 800BCCE4 1000A0AF */   sw        $zero, 0x10($sp)
    /* AD4E8 800BCCE8 3000A78F */  lw         $a3, 0x30($sp)
    /* AD4EC 800BCCEC 3400A38F */  lw         $v1, 0x34($sp)
    /* AD4F0 800BCCF0 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD4F4 800BCCF4 5000A98F */  lw         $t1, 0x50($sp)
    /* AD4F8 800BCCF8 21200002 */  addu       $a0, $s0, $zero
    /* AD4FC 800BCCFC 1400B4AF */  sw         $s4, 0x14($sp)
    /* AD500 800BCD00 1800B5AF */  sw         $s5, 0x18($sp)
    /* AD504 800BCD04 21105100 */  addu       $v0, $v0, $s1
    /* AD508 800BCD08 1000A3AF */  sw         $v1, 0x10($sp)
    /* AD50C 800BCD0C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* AD510 800BCD10 0000258D */  lw         $a1, 0x0($t1)
    /* AD514 800BCD14 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD518 800BCD18 20000624 */   addiu     $a2, $zero, 0x20
    /* AD51C 800BCD1C D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD520 800BCD20 01001024 */  addiu      $s0, $zero, 0x1
    /* AD524 800BCD24 21102202 */  addu       $v0, $s1, $v0
    /* AD528 800BCD28 6EF30208 */  j          .L800BCDB8
    /* AD52C 800BCD2C 0E0050A4 */   sh        $s0, 0xE($v0)
  .L800BCD30:
    /* AD530 800BCD30 06006284 */  lh         $v0, 0x6($v1)
    /* AD534 800BCD34 00000000 */  nop
    /* AD538 800BCD38 1F006216 */  bne        $s3, $v0, .L800BCDB8
    /* AD53C 800BCD3C 3800A527 */   addiu     $a1, $sp, 0x38
    /* AD540 800BCD40 3C00A627 */  addiu      $a2, $sp, 0x3C
    /* AD544 800BCD44 9000A48F */  lw         $a0, 0x90($sp)
    /* AD548 800BCD48 8C00A78F */  lw         $a3, 0x8C($sp)
    /* AD54C 800BCD4C 08006284 */  lh         $v0, 0x8($v1)
    /* AD550 800BCD50 0A006384 */  lh         $v1, 0xA($v1)
    /* AD554 800BCD54 2110C202 */  addu       $v0, $s6, $v0
    /* AD558 800BCD58 2118E302 */  addu       $v1, $s7, $v1
    /* AD55C 800BCD5C 3800A2AF */  sw         $v0, 0x38($sp)
    /* AD560 800BCD60 01000224 */  addiu      $v0, $zero, 0x1
    /* AD564 800BCD64 3C00A3AF */  sw         $v1, 0x3C($sp)
    /* AD568 800BCD68 9AF1020C */  jal        CarIO_LicenseCheck__FiPiT1P8Car_tObji
    /* AD56C 800BCD6C 1000A2AF */   sw        $v0, 0x10($sp)
    /* AD570 800BCD70 3800A78F */  lw         $a3, 0x38($sp)
    /* AD574 800BCD74 3C00A38F */  lw         $v1, 0x3C($sp)
    /* AD578 800BCD78 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD57C 800BCD7C 5400A88F */  lw         $t0, 0x54($sp)
    /* AD580 800BCD80 21200000 */  addu       $a0, $zero, $zero
    /* AD584 800BCD84 1400B4AF */  sw         $s4, 0x14($sp)
    /* AD588 800BCD88 1800B5AF */  sw         $s5, 0x18($sp)
    /* AD58C 800BCD8C 21105100 */  addu       $v0, $v0, $s1
    /* AD590 800BCD90 1000A3AF */  sw         $v1, 0x10($sp)
    /* AD594 800BCD94 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* AD598 800BCD98 0000058D */  lw         $a1, 0x0($t0)
    /* AD59C 800BCD9C C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD5A0 800BCDA0 20000624 */   addiu     $a2, $zero, 0x20
    /* AD5A4 800BCDA4 01001024 */  addiu      $s0, $zero, 0x1
    /* AD5A8 800BCDA8 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD5AC 800BCDAC 02000224 */  addiu      $v0, $zero, 0x2
    /* AD5B0 800BCDB0 21182302 */  addu       $v1, $s1, $v1
    /* AD5B4 800BCDB4 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BCDB8:
    /* AD5B8 800BCDB8 0D000016 */  bnez       $s0, .L800BCDF0
    /* AD5BC 800BCDBC 20000224 */   addiu     $v0, $zero, 0x20
    /* AD5C0 800BCDC0 21200000 */  addu       $a0, $zero, $zero
    /* AD5C4 800BCDC4 21284002 */  addu       $a1, $s2, $zero
    /* AD5C8 800BCDC8 20000624 */  addiu      $a2, $zero, 0x20
    /* AD5CC 800BCDCC D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD5D0 800BCDD0 2138C002 */  addu       $a3, $s6, $zero
    /* AD5D4 800BCDD4 1000B7AF */  sw         $s7, 0x10($sp)
    /* AD5D8 800BCDD8 1400B4AF */  sw         $s4, 0x14($sp)
    /* AD5DC 800BCDDC 1800B5AF */  sw         $s5, 0x18($sp)
    /* AD5E0 800BCDE0 21105100 */  addu       $v0, $v0, $s1
    /* AD5E4 800BCDE4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD5E8 800BCDE8 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* AD5EC 800BCDEC 20000224 */  addiu      $v0, $zero, 0x20
  .L800BCDF0:
    /* AD5F0 800BCDF0 06006216 */  bne        $s3, $v0, .L800BCE0C
    /* AD5F4 800BCDF4 02000524 */   addiu     $a1, $zero, 0x2
    /* AD5F8 800BCDF8 D011848F */  lw         $a0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD5FC 800BCDFC 00000000 */  nop
    /* AD600 800BCE00 21209100 */  addu       $a0, $a0, $s1
    /* AD604 800BCE04 B4F9020C */  jal        ChangeTPage__FPUsi
    /* AD608 800BCE08 06008424 */   addiu     $a0, $a0, 0x6
  .L800BCE0C:
    /* AD60C 800BCE0C 4C00A98F */  lw         $t1, 0x4C($sp)
    /* AD610 800BCE10 00000000 */  nop
    /* AD614 800BCE14 08002015 */  bnez       $t1, .L800BCE38
    /* AD618 800BCE18 00000000 */   nop
    /* AD61C 800BCE1C D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD620 800BCE20 00000000 */  nop
    /* AD624 800BCE24 21182302 */  addu       $v1, $s1, $v1
    /* AD628 800BCE28 0E006294 */  lhu        $v0, 0xE($v1)
    /* AD62C 800BCE2C 00000000 */  nop
    /* AD630 800BCE30 80004234 */  ori        $v0, $v0, 0x80
    /* AD634 800BCE34 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BCE38:
    /* AD638 800BCE38 10003126 */  addiu      $s1, $s1, 0x10
    /* AD63C 800BCE3C 0C00DE27 */  addiu      $fp, $fp, 0xC
    /* AD640 800BCE40 01007326 */  addiu      $s3, $s3, 0x1
    /* AD644 800BCE44 4400A88F */  lw         $t0, 0x44($sp)
    /* AD648 800BCE48 5800A98F */  lw         $t1, 0x58($sp)
    /* AD64C 800BCE4C 01000825 */  addiu      $t0, $t0, 0x1
    /* AD650 800BCE50 02002925 */  addiu      $t1, $t1, 0x2
    /* AD654 800BCE54 4400A8AF */  sw         $t0, 0x44($sp)
    /* AD658 800BCE58 71F20208 */  j          .L800BC9C4
    /* AD65C 800BCE5C 5800A9AF */   sw        $t1, 0x58($sp)
  .L800BCE60:
    /* AD660 800BCE60 9000A88F */  lw         $t0, 0x90($sp)
    /* AD664 800BCE64 00000000 */  nop
    /* AD668 800BCE68 80000231 */  andi       $v0, $t0, 0x80
    /* AD66C 800BCE6C 04004010 */  beqz       $v0, .L800BCE80
    /* AD670 800BCE70 00000000 */   nop
    /* AD674 800BCE74 4400A98F */  lw         $t1, 0x44($sp)
    /* AD678 800BCE78 00000000 */  nop
    /* AD67C 800BCE7C F01189AF */  sw         $t1, %gp_rel(CarIO_carPixMapCount)($gp)
  .L800BCE80:
    /* AD680 800BCE80 8400BF8F */  lw         $ra, 0x84($sp)
    /* AD684 800BCE84 8000BE8F */  lw         $fp, 0x80($sp)
    /* AD688 800BCE88 7C00B78F */  lw         $s7, 0x7C($sp)
    /* AD68C 800BCE8C 7800B68F */  lw         $s6, 0x78($sp)
    /* AD690 800BCE90 7400B58F */  lw         $s5, 0x74($sp)
    /* AD694 800BCE94 7000B48F */  lw         $s4, 0x70($sp)
    /* AD698 800BCE98 6C00B38F */  lw         $s3, 0x6C($sp)
    /* AD69C 800BCE9C 6800B28F */  lw         $s2, 0x68($sp)
    /* AD6A0 800BCEA0 6400B18F */  lw         $s1, 0x64($sp)
    /* AD6A4 800BCEA4 6000B08F */  lw         $s0, 0x60($sp)
    /* AD6A8 800BCEA8 0800E003 */  jr         $ra
    /* AD6AC 800BCEAC 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel CarIO_ReadInCarTextureData__FPcP8Car_tObjii
