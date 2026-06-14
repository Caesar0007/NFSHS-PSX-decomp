.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_UpdateCarTextureData__FPcP8Car_tObji, 0x4A8

glabel CarIO_UpdateCarTextureData__FPcP8Car_tObji
    /* AD6B0 800BCEB0 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* AD6B4 800BCEB4 6400BFAF */  sw         $ra, 0x64($sp)
    /* AD6B8 800BCEB8 6000BEAF */  sw         $fp, 0x60($sp)
    /* AD6BC 800BCEBC 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* AD6C0 800BCEC0 5800B6AF */  sw         $s6, 0x58($sp)
    /* AD6C4 800BCEC4 5400B5AF */  sw         $s5, 0x54($sp)
    /* AD6C8 800BCEC8 5000B4AF */  sw         $s4, 0x50($sp)
    /* AD6CC 800BCECC 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* AD6D0 800BCED0 4800B2AF */  sw         $s2, 0x48($sp)
    /* AD6D4 800BCED4 4400B1AF */  sw         $s1, 0x44($sp)
    /* AD6D8 800BCED8 4000B0AF */  sw         $s0, 0x40($sp)
    /* AD6DC 800BCEDC 6800A4AF */  sw         $a0, 0x68($sp)
    /* AD6E0 800BCEE0 6C00A5AF */  sw         $a1, 0x6C($sp)
    /* AD6E4 800BCEE4 4408A88C */  lw         $t0, 0x844($a1)
    /* AD6E8 800BCEE8 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AD6EC 800BCEEC 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AD6F0 800BCEF0 2C00A8AF */  sw         $t0, 0x2C($sp)
    /* AD6F4 800BCEF4 BC08A884 */  lh         $t0, 0x8BC($a1)
    /* AD6F8 800BCEF8 00000000 */  nop
    /* AD6FC 800BCEFC 2000A8AF */  sw         $t0, 0x20($sp)
    /* AD700 800BCF00 C408A884 */  lh         $t0, 0x8C4($a1)
    /* AD704 800BCF04 2180C000 */  addu       $s0, $a2, $zero
    /* AD708 800BCF08 2400A8AF */  sw         $t0, 0x24($sp)
    /* AD70C 800BCF0C C608A884 */  lh         $t0, 0x8C6($a1)
    /* AD710 800BCF10 08001E24 */  addiu      $fp, $zero, 0x8
    /* AD714 800BCF14 02004014 */  bnez       $v0, .L800BCF20
    /* AD718 800BCF18 2800A8AF */   sw        $t0, 0x28($sp)
    /* AD71C 800BCF1C 18001E24 */  addiu      $fp, $zero, 0x18
  .L800BCF20:
    /* AD720 800BCF20 6C00A88F */  lw         $t0, 0x6C($sp)
    /* AD724 800BCF24 00000000 */  nop
    /* AD728 800BCF28 8408028D */  lw         $v0, 0x884($t0)
    /* AD72C 800BCF2C 2C00A88F */  lw         $t0, 0x2C($sp)
    /* AD730 800BCF30 21B00000 */  addu       $s6, $zero, $zero
    /* AD734 800BCF34 1480013C */  lui        $at, %hi(Texture_palCopy)
    /* AD738 800BCF38 0CDB22AC */  sw         $v0, %lo(Texture_palCopy)($at)
    /* AD73C 800BCF3C 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* AD740 800BCF40 00A90800 */   sll       $s5, $t0, 4
    /* AD744 800BCF44 1280033C */  lui        $v1, %hi(CarIO_licensePlate)
    /* AD748 800BCF48 E0EA6324 */  addiu      $v1, $v1, %lo(CarIO_licensePlate)
    /* AD74C 800BCF4C 2000A88F */  lw         $t0, 0x20($sp)
    /* AD750 800BCF50 80801000 */  sll        $s0, $s0, 2
    /* AD754 800BCF54 3800B0AF */  sw         $s0, 0x38($sp)
    /* AD758 800BCF58 40100800 */  sll        $v0, $t0, 1
    /* AD75C 800BCF5C 21104800 */  addu       $v0, $v0, $t0
    /* AD760 800BCF60 80100200 */  sll        $v0, $v0, 2
    /* AD764 800BCF64 21904300 */  addu       $s2, $v0, $v1
    /* AD768 800BCF68 1280023C */  lui        $v0, %hi(D_8011E804)
    /* AD76C 800BCF6C 6C00A88F */  lw         $t0, 0x6C($sp)
    /* AD770 800BCF70 04E85724 */  addiu      $s7, $v0, %lo(D_8011E804)
  .L800BCF74:
    /* AD774 800BCF74 3300C22A */  slti       $v0, $s6, 0x33
    /* AD778 800BCF78 EB004010 */  beqz       $v0, .L800BD328
    /* AD77C 800BCF7C 3C00A8AF */   sw        $t0, 0x3C($sp)
    /* AD780 800BCF80 6800A48F */  lw         $a0, 0x68($sp)
    /* AD784 800BCF84 0400E58E */  lw         $a1, 0x4($s7)
    /* AD788 800BCF88 01000824 */  addiu      $t0, $zero, 0x1
    /* AD78C 800BCF8C 5CAC030C */  jal        locateshapez
    /* AD790 800BCF90 3400A8AF */   sw        $t0, 0x34($sp)
    /* AD794 800BCF94 0800E88E */  lw         $t0, 0x8($s7)
    /* AD798 800BCF98 21884000 */  addu       $s1, $v0, $zero
    /* AD79C 800BCF9C 09002016 */  bnez       $s1, .L800BCFC4
    /* AD7A0 800BCFA0 3000A8AF */   sw        $t0, 0x30($sp)
    /* AD7A4 800BCFA4 08000015 */  bnez       $t0, .L800BCFC8
    /* AD7A8 800BCFA8 14000224 */   addiu     $v0, $zero, 0x14
    /* AD7AC 800BCFAC 3400A0AF */  sw         $zero, 0x34($sp)
    /* AD7B0 800BCFB0 0000E58E */  lw         $a1, 0x0($s7)
    /* AD7B4 800BCFB4 6800A48F */  lw         $a0, 0x68($sp)
    /* AD7B8 800BCFB8 5CAC030C */  jal        locateshapez
    /* AD7BC 800BCFBC 00000000 */   nop
    /* AD7C0 800BCFC0 21884000 */  addu       $s1, $v0, $zero
  .L800BCFC4:
    /* AD7C4 800BCFC4 14000224 */  addiu      $v0, $zero, 0x14
  .L800BCFC8:
    /* AD7C8 800BCFC8 0200C216 */  bne        $s6, $v0, .L800BCFD4
    /* AD7CC 800BCFCC 00000000 */   nop
    /* AD7D0 800BCFD0 21F00000 */  addu       $fp, $zero, $zero
  .L800BCFD4:
    /* AD7D4 800BCFD4 5D002012 */  beqz       $s1, .L800BD14C
    /* AD7D8 800BCFD8 00000000 */   nop
    /* AD7DC 800BCFDC D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD7E0 800BCFE0 00000000 */  nop
    /* AD7E4 800BCFE4 2128A202 */  addu       $a1, $s5, $v0
    /* AD7E8 800BCFE8 0E00A294 */  lhu        $v0, 0xE($a1)
    /* AD7EC 800BCFEC 00000000 */  nop
    /* AD7F0 800BCFF0 80004230 */  andi       $v0, $v0, 0x80
    /* AD7F4 800BCFF4 C3004010 */  beqz       $v0, .L800BD304
    /* AD7F8 800BCFF8 21800000 */   addu      $s0, $zero, $zero
    /* AD7FC 800BCFFC 0200A394 */  lhu        $v1, 0x2($a1)
    /* AD800 800BD000 00000000 */  nop
    /* AD804 800BD004 3F006230 */  andi       $v0, $v1, 0x3F
    /* AD808 800BD008 00990200 */  sll        $s3, $v0, 4
    /* AD80C 800BD00C 0600C013 */  beqz       $fp, .L800BD028
    /* AD810 800BD010 82A10300 */   srl       $s4, $v1, 6
    /* AD814 800BD014 3C00A88F */  lw         $t0, 0x3C($sp)
    /* AD818 800BD018 00000000 */  nop
    /* AD81C 800BD01C 8A080285 */  lh         $v0, 0x88A($t0)
    /* AD820 800BD020 1480013C */  lui        $at, %hi(Texture_palNum)
    /* AD824 800BD024 10DB22AC */  sw         $v0, %lo(Texture_palNum)($at)
  .L800BD028:
    /* AD828 800BD028 2000A88F */  lw         $t0, 0x20($sp)
    /* AD82C 800BD02C 00000000 */  nop
    /* AD830 800BD030 16000229 */  slti       $v0, $t0, 0x16
    /* AD834 800BD034 28004010 */  beqz       $v0, .L800BD0D8
    /* AD838 800BD038 00000000 */   nop
    /* AD83C 800BD03C 00004286 */  lh         $v0, 0x0($s2)
    /* AD840 800BD040 00000000 */  nop
    /* AD844 800BD044 0F00C216 */  bne        $s6, $v0, .L800BD084
    /* AD848 800BD048 21200000 */   addu      $a0, $zero, $zero
    /* AD84C 800BD04C 01001024 */  addiu      $s0, $zero, 0x1
    /* AD850 800BD050 04004286 */  lh         $v0, 0x4($s2)
    /* AD854 800BD054 2800A88F */  lw         $t0, 0x28($sp)
    /* AD858 800BD058 02004786 */  lh         $a3, 0x2($s2)
    /* AD85C 800BD05C 21100201 */  addu       $v0, $t0, $v0
    /* AD860 800BD060 3800A88F */  lw         $t0, 0x38($sp)
    /* AD864 800BD064 1400B3AF */  sw         $s3, 0x14($sp)
    /* AD868 800BD068 1800B4AF */  sw         $s4, 0x18($sp)
    /* AD86C 800BD06C 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* AD870 800BD070 1000A2AF */  sw         $v0, 0x10($sp)
    /* AD874 800BD074 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* AD878 800BD078 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* AD87C 800BD07C 31F40208 */  j          .L800BD0C4
    /* AD880 800BD080 2130C003 */   addu      $a2, $fp, $zero
  .L800BD084:
    /* AD884 800BD084 06004286 */  lh         $v0, 0x6($s2)
    /* AD888 800BD088 00000000 */  nop
    /* AD88C 800BD08C 1200C216 */  bne        $s6, $v0, .L800BD0D8
    /* AD890 800BD090 2130C003 */   addu      $a2, $fp, $zero
    /* AD894 800BD094 01001024 */  addiu      $s0, $zero, 0x1
    /* AD898 800BD098 0A004286 */  lh         $v0, 0xA($s2)
    /* AD89C 800BD09C 2800A88F */  lw         $t0, 0x28($sp)
    /* AD8A0 800BD0A0 08004786 */  lh         $a3, 0x8($s2)
    /* AD8A4 800BD0A4 21100201 */  addu       $v0, $t0, $v0
    /* AD8A8 800BD0A8 3800A88F */  lw         $t0, 0x38($sp)
    /* AD8AC 800BD0AC 1400B3AF */  sw         $s3, 0x14($sp)
    /* AD8B0 800BD0B0 1800B4AF */  sw         $s4, 0x18($sp)
    /* AD8B4 800BD0B4 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* AD8B8 800BD0B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* AD8BC 800BD0BC 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* AD8C0 800BD0C0 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
  .L800BD0C4:
    /* AD8C4 800BD0C4 21100201 */  addu       $v0, $t0, $v0
    /* AD8C8 800BD0C8 2400A88F */  lw         $t0, 0x24($sp)
    /* AD8CC 800BD0CC 0000458C */  lw         $a1, 0x0($v0)
    /* AD8D0 800BD0D0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD8D4 800BD0D4 21380701 */   addu      $a3, $t0, $a3
  .L800BD0D8:
    /* AD8D8 800BD0D8 0E000016 */  bnez       $s0, .L800BD114
    /* AD8DC 800BD0DC 20000224 */   addiu     $v0, $zero, 0x20
    /* AD8E0 800BD0E0 21200000 */  addu       $a0, $zero, $zero
    /* AD8E4 800BD0E4 21282002 */  addu       $a1, $s1, $zero
    /* AD8E8 800BD0E8 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD8EC 800BD0EC 2400A78F */  lw         $a3, 0x24($sp)
    /* AD8F0 800BD0F0 2800A88F */  lw         $t0, 0x28($sp)
    /* AD8F4 800BD0F4 2130C003 */  addu       $a2, $fp, $zero
    /* AD8F8 800BD0F8 1400B3AF */  sw         $s3, 0x14($sp)
    /* AD8FC 800BD0FC 1800B4AF */  sw         $s4, 0x18($sp)
    /* AD900 800BD100 21105500 */  addu       $v0, $v0, $s5
    /* AD904 800BD104 1000A8AF */  sw         $t0, 0x10($sp)
    /* AD908 800BD108 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* AD90C 800BD10C 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* AD910 800BD110 20000224 */  addiu      $v0, $zero, 0x20
  .L800BD114:
    /* AD914 800BD114 0600C216 */  bne        $s6, $v0, .L800BD130
    /* AD918 800BD118 02000524 */   addiu     $a1, $zero, 0x2
    /* AD91C 800BD11C D011848F */  lw         $a0, %gp_rel(CarIO_carPixMap)($gp)
    /* AD920 800BD120 00000000 */  nop
    /* AD924 800BD124 21209500 */  addu       $a0, $a0, $s5
    /* AD928 800BD128 B4F9020C */  jal        ChangeTPage__FPUsi
    /* AD92C 800BD12C 06008424 */   addiu     $a0, $a0, 0x6
  .L800BD130:
    /* AD930 800BD130 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD934 800BD134 00000000 */  nop
    /* AD938 800BD138 2118A302 */  addu       $v1, $s5, $v1
    /* AD93C 800BD13C 0E006294 */  lhu        $v0, 0xE($v1)
    /* AD940 800BD140 00000000 */  nop
    /* AD944 800BD144 80004234 */  ori        $v0, $v0, 0x80
    /* AD948 800BD148 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BD14C:
    /* AD94C 800BD14C 3400A88F */  lw         $t0, 0x34($sp)
    /* AD950 800BD150 00000000 */  nop
    /* AD954 800BD154 6B000011 */  beqz       $t0, .L800BD304
    /* AD958 800BD158 00000000 */   nop
    /* AD95C 800BD15C 3000A88F */  lw         $t0, 0x30($sp)
    /* AD960 800BD160 2C00B08F */  lw         $s0, 0x2C($sp)
    /* AD964 800BD164 0F000011 */  beqz       $t0, .L800BD1A4
    /* AD968 800BD168 00000000 */   nop
    /* AD96C 800BD16C 0800C013 */  beqz       $fp, .L800BD190
    /* AD970 800BD170 FFFF1025 */   addiu     $s0, $t0, -0x1
    /* AD974 800BD174 6C00A88F */  lw         $t0, 0x6C($sp)
    /* AD978 800BD178 40101000 */  sll        $v0, $s0, 1
    /* AD97C 800BD17C 21100201 */  addu       $v0, $t0, $v0
    /* AD980 800BD180 8A084294 */  lhu        $v0, 0x88A($v0)
    /* AD984 800BD184 3C00A88F */  lw         $t0, 0x3C($sp)
    /* AD988 800BD188 00000000 */  nop
    /* AD98C 800BD18C 8A0802A5 */  sh         $v0, 0x88A($t0)
  .L800BD190:
    /* AD990 800BD190 6C00A88F */  lw         $t0, 0x6C($sp)
    /* AD994 800BD194 00000000 */  nop
    /* AD998 800BD198 4408028D */  lw         $v0, 0x844($t0)
    /* AD99C 800BD19C 00000000 */  nop
    /* AD9A0 800BD1A0 21800202 */  addu       $s0, $s0, $v0
  .L800BD1A4:
    /* AD9A4 800BD1A4 0000E58E */  lw         $a1, 0x0($s7)
    /* AD9A8 800BD1A8 6800A48F */  lw         $a0, 0x68($sp)
    /* AD9AC 800BD1AC 5CAC030C */  jal        locateshapez
    /* AD9B0 800BD1B0 00000000 */   nop
    /* AD9B4 800BD1B4 21884000 */  addu       $s1, $v0, $zero
    /* AD9B8 800BD1B8 52002012 */  beqz       $s1, .L800BD304
    /* AD9BC 800BD1BC 00111000 */   sll       $v0, $s0, 4
    /* AD9C0 800BD1C0 D011858F */  lw         $a1, %gp_rel(CarIO_carPixMap)($gp)
    /* AD9C4 800BD1C4 21800000 */  addu       $s0, $zero, $zero
    /* AD9C8 800BD1C8 21104500 */  addu       $v0, $v0, $a1
    /* AD9CC 800BD1CC 02004394 */  lhu        $v1, 0x2($v0)
    /* AD9D0 800BD1D0 2000A88F */  lw         $t0, 0x20($sp)
    /* AD9D4 800BD1D4 3F006230 */  andi       $v0, $v1, 0x3F
    /* AD9D8 800BD1D8 00990200 */  sll        $s3, $v0, 4
    /* AD9DC 800BD1DC 16000229 */  slti       $v0, $t0, 0x16
    /* AD9E0 800BD1E0 27004010 */  beqz       $v0, .L800BD280
    /* AD9E4 800BD1E4 82A10300 */   srl       $s4, $v1, 6
    /* AD9E8 800BD1E8 00004286 */  lh         $v0, 0x0($s2)
    /* AD9EC 800BD1EC 00000000 */  nop
    /* AD9F0 800BD1F0 0D00C216 */  bne        $s6, $v0, .L800BD228
    /* AD9F4 800BD1F4 21200000 */   addu      $a0, $zero, $zero
    /* AD9F8 800BD1F8 01001024 */  addiu      $s0, $zero, 0x1
    /* AD9FC 800BD1FC 02004786 */  lh         $a3, 0x2($s2)
    /* ADA00 800BD200 04004386 */  lh         $v1, 0x4($s2)
    /* ADA04 800BD204 2800A88F */  lw         $t0, 0x28($sp)
    /* ADA08 800BD208 2110B500 */  addu       $v0, $a1, $s5
    /* ADA0C 800BD20C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* ADA10 800BD210 21180301 */  addu       $v1, $t0, $v1
    /* ADA14 800BD214 3800A88F */  lw         $t0, 0x38($sp)
    /* ADA18 800BD218 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* ADA1C 800BD21C 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* ADA20 800BD220 98F40208 */  j          .L800BD260
    /* ADA24 800BD224 20000624 */   addiu     $a2, $zero, 0x20
  .L800BD228:
    /* ADA28 800BD228 06004286 */  lh         $v0, 0x6($s2)
    /* ADA2C 800BD22C 00000000 */  nop
    /* ADA30 800BD230 1300C216 */  bne        $s6, $v0, .L800BD280
    /* ADA34 800BD234 20000624 */   addiu     $a2, $zero, 0x20
    /* ADA38 800BD238 01001024 */  addiu      $s0, $zero, 0x1
    /* ADA3C 800BD23C 08004786 */  lh         $a3, 0x8($s2)
    /* ADA40 800BD240 0A004386 */  lh         $v1, 0xA($s2)
    /* ADA44 800BD244 2800A88F */  lw         $t0, 0x28($sp)
    /* ADA48 800BD248 2110B500 */  addu       $v0, $a1, $s5
    /* ADA4C 800BD24C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* ADA50 800BD250 21180301 */  addu       $v1, $t0, $v1
    /* ADA54 800BD254 3800A88F */  lw         $t0, 0x38($sp)
    /* ADA58 800BD258 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* ADA5C 800BD25C 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
  .L800BD260:
    /* ADA60 800BD260 1400B3AF */  sw         $s3, 0x14($sp)
    /* ADA64 800BD264 1800B4AF */  sw         $s4, 0x18($sp)
    /* ADA68 800BD268 1000A3AF */  sw         $v1, 0x10($sp)
    /* ADA6C 800BD26C 21100201 */  addu       $v0, $t0, $v0
    /* ADA70 800BD270 2400A88F */  lw         $t0, 0x24($sp)
    /* ADA74 800BD274 0000458C */  lw         $a1, 0x0($v0)
    /* ADA78 800BD278 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* ADA7C 800BD27C 21380701 */   addu      $a3, $t0, $a3
  .L800BD280:
    /* ADA80 800BD280 0E000016 */  bnez       $s0, .L800BD2BC
    /* ADA84 800BD284 20000224 */   addiu     $v0, $zero, 0x20
    /* ADA88 800BD288 21200000 */  addu       $a0, $zero, $zero
    /* ADA8C 800BD28C 21282002 */  addu       $a1, $s1, $zero
    /* ADA90 800BD290 D011828F */  lw         $v0, %gp_rel(CarIO_carPixMap)($gp)
    /* ADA94 800BD294 2400A78F */  lw         $a3, 0x24($sp)
    /* ADA98 800BD298 2800A88F */  lw         $t0, 0x28($sp)
    /* ADA9C 800BD29C 20000624 */  addiu      $a2, $zero, 0x20
    /* ADAA0 800BD2A0 1400B3AF */  sw         $s3, 0x14($sp)
    /* ADAA4 800BD2A4 1800B4AF */  sw         $s4, 0x18($sp)
    /* ADAA8 800BD2A8 21105500 */  addu       $v0, $v0, $s5
    /* ADAAC 800BD2AC 1000A8AF */  sw         $t0, 0x10($sp)
    /* ADAB0 800BD2B0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* ADAB4 800BD2B4 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* ADAB8 800BD2B8 20000224 */  addiu      $v0, $zero, 0x20
  .L800BD2BC:
    /* ADABC 800BD2BC 0600C216 */  bne        $s6, $v0, .L800BD2D8
    /* ADAC0 800BD2C0 02000524 */   addiu     $a1, $zero, 0x2
    /* ADAC4 800BD2C4 D011848F */  lw         $a0, %gp_rel(CarIO_carPixMap)($gp)
    /* ADAC8 800BD2C8 00000000 */  nop
    /* ADACC 800BD2CC 21209500 */  addu       $a0, $a0, $s5
    /* ADAD0 800BD2D0 B4F9020C */  jal        ChangeTPage__FPUsi
    /* ADAD4 800BD2D4 06008424 */   addiu     $a0, $a0, 0x6
  .L800BD2D8:
    /* ADAD8 800BD2D8 3000A88F */  lw         $t0, 0x30($sp)
    /* ADADC 800BD2DC 00000000 */  nop
    /* ADAE0 800BD2E0 08000015 */  bnez       $t0, .L800BD304
    /* ADAE4 800BD2E4 00000000 */   nop
    /* ADAE8 800BD2E8 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* ADAEC 800BD2EC 00000000 */  nop
    /* ADAF0 800BD2F0 2118A302 */  addu       $v1, $s5, $v1
    /* ADAF4 800BD2F4 0E006294 */  lhu        $v0, 0xE($v1)
    /* ADAF8 800BD2F8 00000000 */  nop
    /* ADAFC 800BD2FC 80004234 */  ori        $v0, $v0, 0x80
    /* ADB00 800BD300 0E0062A4 */  sh         $v0, 0xE($v1)
  .L800BD304:
    /* ADB04 800BD304 1000B526 */  addiu      $s5, $s5, 0x10
    /* ADB08 800BD308 2C00A88F */  lw         $t0, 0x2C($sp)
    /* ADB0C 800BD30C 0C00F726 */  addiu      $s7, $s7, 0xC
    /* ADB10 800BD310 01000825 */  addiu      $t0, $t0, 0x1
    /* ADB14 800BD314 2C00A8AF */  sw         $t0, 0x2C($sp)
    /* ADB18 800BD318 3C00A88F */  lw         $t0, 0x3C($sp)
    /* ADB1C 800BD31C 0100D626 */  addiu      $s6, $s6, 0x1
    /* ADB20 800BD320 DDF30208 */  j          .L800BCF74
    /* ADB24 800BD324 02000825 */   addiu     $t0, $t0, 0x2
  .L800BD328:
    /* ADB28 800BD328 6400BF8F */  lw         $ra, 0x64($sp)
    /* ADB2C 800BD32C 6000BE8F */  lw         $fp, 0x60($sp)
    /* ADB30 800BD330 5C00B78F */  lw         $s7, 0x5C($sp)
    /* ADB34 800BD334 5800B68F */  lw         $s6, 0x58($sp)
    /* ADB38 800BD338 5400B58F */  lw         $s5, 0x54($sp)
    /* ADB3C 800BD33C 5000B48F */  lw         $s4, 0x50($sp)
    /* ADB40 800BD340 4C00B38F */  lw         $s3, 0x4C($sp)
    /* ADB44 800BD344 4800B28F */  lw         $s2, 0x48($sp)
    /* ADB48 800BD348 4400B18F */  lw         $s1, 0x44($sp)
    /* ADB4C 800BD34C 4000B08F */  lw         $s0, 0x40($sp)
    /* ADB50 800BD350 0800E003 */  jr         $ra
    /* ADB54 800BD354 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel CarIO_UpdateCarTextureData__FPcP8Car_tObji
