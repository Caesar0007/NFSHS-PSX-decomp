.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap, 0x440

glabel Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* D0718 800DFF18 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* D071C 800DFF1C 7400A28F */  lw         $v0, 0x74($sp)
    /* D0720 800DFF20 7800A38F */  lw         $v1, 0x78($sp)
    /* D0724 800DFF24 4000B2AF */  sw         $s2, 0x40($sp)
    /* D0728 800DFF28 7C00B28F */  lw         $s2, 0x7C($sp)
    /* D072C 800DFF2C 5400B7AF */  sw         $s7, 0x54($sp)
    /* D0730 800DFF30 21B8C000 */  addu       $s7, $a2, $zero
    /* D0734 800DFF34 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* D0738 800DFF38 2188E000 */  addu       $s1, $a3, $zero
    /* D073C 800DFF3C 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* D0740 800DFF40 5800BEAF */  sw         $fp, 0x58($sp)
    /* D0744 800DFF44 5000B6AF */  sw         $s6, 0x50($sp)
    /* D0748 800DFF48 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* D074C 800DFF4C 4800B4AF */  sw         $s4, 0x48($sp)
    /* D0750 800DFF50 4400B3AF */  sw         $s3, 0x44($sp)
    /* D0754 800DFF54 05008010 */  beqz       $a0, .L800DFF6C
    /* D0758 800DFF58 3800B0AF */   sw        $s0, 0x38($sp)
    /* D075C 800DFF5C 5CAC030C */  jal        locateshapez
    /* D0760 800DFF60 00000000 */   nop
    /* D0764 800DFF64 DC7F0308 */  j          .L800DFF70
    /* D0768 800DFF68 21804000 */   addu      $s0, $v0, $zero
  .L800DFF6C:
    /* D076C 800DFF6C 2180A000 */  addu       $s0, $a1, $zero
  .L800DFF70:
    /* D0770 800DFF70 ED000012 */  beqz       $s0, .L800E0328
    /* D0774 800DFF74 00000000 */   nop
    /* D0778 800DFF78 0C00028E */  lw         $v0, 0xC($s0)
    /* D077C 800DFF7C 00000392 */  lbu        $v1, 0x0($s0)
    /* D0780 800DFF80 00410200 */  sll        $t0, $v0, 4
    /* D0784 800DFF84 03450800 */  sra        $t0, $t0, 20
    /* D0788 800DFF88 03007430 */  andi       $s4, $v1, 0x3
    /* D078C 800DFF8C 00150200 */  sll        $v0, $v0, 20
    /* D0790 800DFF90 03150200 */  sra        $v0, $v0, 20
    /* D0794 800DFF94 2400A8AF */  sw         $t0, 0x24($sp)
    /* D0798 800DFF98 2000A2AF */  sw         $v0, 0x20($sp)
    /* D079C 800DFF9C 3000B4AF */  sw         $s4, 0x30($sp)
    /* D07A0 800DFFA0 04000886 */  lh         $t0, 0x4($s0)
    /* D07A4 800DFFA4 00000000 */  nop
    /* D07A8 800DFFA8 2800A8AF */  sw         $t0, 0x28($sp)
    /* D07AC 800DFFAC 06000886 */  lh         $t0, 0x6($s0)
    /* D07B0 800DFFB0 0800E232 */  andi       $v0, $s7, 0x8
    /* D07B4 800DFFB4 04004010 */  beqz       $v0, .L800DFFC8
    /* D07B8 800DFFB8 2C00A8AF */   sw        $t0, 0x2C($sp)
    /* D07BC 800DFFBC 02008012 */  beqz       $s4, .L800DFFC8
    /* D07C0 800DFFC0 00000000 */   nop
    /* D07C4 800DFFC4 21A00000 */  addu       $s4, $zero, $zero
  .L800DFFC8:
    /* D07C8 800DFFC8 0C00038E */  lw         $v1, 0xC($s0)
    /* D07CC 800DFFCC 00000000 */  nop
    /* D07D0 800DFFD0 00406230 */  andi       $v0, $v1, 0x4000
    /* D07D4 800DFFD4 2B100200 */  sltu       $v0, $zero, $v0
    /* D07D8 800DFFD8 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* D07DC 800DFFDC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D07E0 800DFFE0 07002216 */  bne        $s1, $v0, .L800E0000
    /* D07E4 800DFFE4 00150300 */   sll       $v0, $v1, 20
    /* D07E8 800DFFE8 21A80000 */  addu       $s5, $zero, $zero
    /* D07EC 800DFFEC A0001624 */  addiu      $s6, $zero, 0xA0
    /* D07F0 800DFFF0 01000224 */  addiu      $v0, $zero, 0x1
    /* D07F4 800DFFF4 040002A6 */  sh         $v0, 0x4($s0)
    /* D07F8 800DFFF8 06800308 */  j          .L800E0018
    /* D07FC 800DFFFC 060002A6 */   sh        $v0, 0x6($s0)
  .L800E0000:
    /* D0800 800E0000 03150200 */  sra        $v0, $v0, 20
    /* D0804 800E0004 21A85100 */  addu       $s5, $v0, $s1
    /* D0808 800E0008 00110300 */  sll        $v0, $v1, 4
    /* D080C 800E000C 7000A38F */  lw         $v1, 0x70($sp)
    /* D0810 800E0010 03150200 */  sra        $v0, $v0, 20
    /* D0814 800E0014 21B04300 */  addu       $s6, $v0, $v1
  .L800E0018:
    /* D0818 800E0018 04000886 */  lh         $t0, 0x4($s0)
    /* D081C 800E001C 0100E232 */  andi       $v0, $s7, 0x1
    /* D0820 800E0020 1800A8AF */  sw         $t0, 0x18($sp)
    /* D0824 800E0024 06001E86 */  lh         $fp, 0x6($s0)
    /* D0828 800E0028 04004014 */  bnez       $v0, .L800E003C
    /* D082C 800E002C 02000224 */   addiu     $v0, $zero, 0x2
    /* D0830 800E0030 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* D0834 800E0034 1800A8AF */  sw         $t0, 0x18($sp)
    /* D0838 800E0038 FFFFDE27 */  addiu      $fp, $fp, -0x1
  .L800E003C:
    /* D083C 800E003C 6D008212 */  beq        $s4, $v0, .L800E01F4
    /* D0840 800E0040 21200002 */   addu      $a0, $s0, $zero
    /* D0844 800E0044 0000028E */  lw         $v0, 0x0($s0)
    /* D0848 800E0048 00000000 */  nop
    /* D084C 800E004C 03120200 */  sra        $v0, $v0, 8
    /* D0850 800E0050 21880202 */  addu       $s1, $s0, $v0
    /* D0854 800E0054 04002886 */  lh         $t0, 0x4($s1)
    /* D0858 800E0058 03008016 */  bnez       $s4, .L800E0068
    /* D085C 800E005C 3400A8AF */   sw        $t0, 0x34($sp)
    /* D0860 800E0060 1B800308 */  j          .L800E006C
    /* D0864 800E0064 10000224 */   addiu     $v0, $zero, 0x10
  .L800E0068:
    /* D0868 800E0068 00010224 */  addiu      $v0, $zero, 0x100
  .L800E006C:
    /* D086C 800E006C 040022A6 */  sh         $v0, 0x4($s1)
    /* D0870 800E0070 4000E432 */  andi       $a0, $s7, 0x40
    /* D0874 800E0074 10003326 */  addiu      $s3, $s1, 0x10
    /* D0878 800E0078 21286002 */  addu       $a1, $s3, $zero
    /* D087C 800E007C 21304002 */  addu       $a2, $s2, $zero
    /* D0880 800E0080 A27D030C */  jal        Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
    /* D0884 800E0084 21388002 */   addu      $a3, $s4, $zero
    /* D0888 800E0088 48004014 */  bnez       $v0, .L800E01AC
    /* D088C 800E008C 2000E232 */   andi      $v0, $s7, 0x20
    /* D0890 800E0090 7400A38F */  lw         $v1, 0x74($sp)
    /* D0894 800E0094 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D0898 800E0098 07006214 */  bne        $v1, $v0, .L800E00B8
    /* D089C 800E009C FDFF0224 */   addiu     $v0, $zero, -0x3
    /* D08A0 800E00A0 21208002 */  addu       $a0, $s4, $zero
    /* D08A4 800E00A4 7400A527 */  addiu      $a1, $sp, 0x74
    /* D08A8 800E00A8 4E7E030C */  jal        Texture_GetClutId__FiPiT1
    /* D08AC 800E00AC 7800A627 */   addiu     $a2, $sp, 0x78
    /* D08B0 800E00B0 3D800308 */  j          .L800E00F4
    /* D08B4 800E00B4 0200E232 */   andi      $v0, $s7, 0x2
  .L800E00B8:
    /* D08B8 800E00B8 06006214 */  bne        $v1, $v0, .L800E00D4
    /* D08BC 800E00BC FEFF0224 */   addiu     $v0, $zero, -0x2
    /* D08C0 800E00C0 04002586 */  lh         $a1, 0x4($s1)
    /* D08C4 800E00C4 B082030C */  jal        TextureProcess_DepthColorCluts__FPci
    /* D08C8 800E00C8 21206002 */   addu      $a0, $s3, $zero
    /* D08CC 800E00CC 3C800308 */  j          .L800E00F0
    /* D08D0 800E00D0 0A0042A6 */   sh        $v0, 0xA($s2)
  .L800E00D4:
    /* D08D4 800E00D4 07006214 */  bne        $v1, $v0, .L800E00F4
    /* D08D8 800E00D8 0200E232 */   andi      $v0, $s7, 0x2
    /* D08DC 800E00DC A0000224 */  addiu      $v0, $zero, 0xA0
    /* D08E0 800E00E0 7800A2AF */  sw         $v0, 0x78($sp)
    /* D08E4 800E00E4 01000224 */  addiu      $v0, $zero, 0x1
    /* D08E8 800E00E8 7400A0AF */  sw         $zero, 0x74($sp)
    /* D08EC 800E00EC 040022A6 */  sh         $v0, 0x4($s1)
  .L800E00F0:
    /* D08F0 800E00F0 0200E232 */  andi       $v0, $s7, 0x2
  .L800E00F4:
    /* D08F4 800E00F4 07004010 */  beqz       $v0, .L800E0114
    /* D08F8 800E00F8 0800E232 */   andi      $v0, $s7, 0x8
    /* D08FC 800E00FC 04002586 */  lh         $a1, 0x4($s1)
    /* D0900 800E0100 2182030C */  jal        TextureProcess_TransColorCheck__FPci
    /* D0904 800E0104 10002426 */   addiu     $a0, $s1, 0x10
    /* D0908 800E0108 40100200 */  sll        $v0, $v0, 1
    /* D090C 800E010C 0E0042A6 */  sh         $v0, 0xE($s2)
    /* D0910 800E0110 0800E232 */  andi       $v0, $s7, 0x8
  .L800E0114:
    /* D0914 800E0114 14004010 */  beqz       $v0, .L800E0168
    /* D0918 800E0118 00000000 */   nop
    /* D091C 800E011C 3000A88F */  lw         $t0, 0x30($sp)
    /* D0920 800E0120 00000000 */  nop
    /* D0924 800E0124 10000011 */  beqz       $t0, .L800E0168
    /* D0928 800E0128 00000000 */   nop
    /* D092C 800E012C C015828F */  lw         $v0, %gp_rel(Texture_palCopy)($gp)
    /* D0930 800E0130 00000000 */  nop
    /* D0934 800E0134 07004010 */  beqz       $v0, .L800E0154
    /* D0938 800E0138 1000E232 */   andi      $v0, $s7, 0x10
    /* D093C 800E013C 7400A68F */  lw         $a2, 0x74($sp)
    /* D0940 800E0140 7800A78F */  lw         $a3, 0x78($sp)
    /* D0944 800E0144 3400A58F */  lw         $a1, 0x34($sp)
    /* D0948 800E0148 8F7E030C */  jal        Texture_CopyPalette__FPciii
    /* D094C 800E014C 10002426 */   addiu     $a0, $s1, 0x10
    /* D0950 800E0150 1000E232 */  andi       $v0, $s7, 0x10
  .L800E0154:
    /* D0954 800E0154 04004010 */  beqz       $v0, .L800E0168
    /* D0958 800E0158 10002426 */   addiu     $a0, $s1, 0x10
    /* D095C 800E015C 21288000 */  addu       $a1, $a0, $zero
    /* D0960 800E0160 817E030C */  jal        Texture_ColorCarPalette__FPcT0i
    /* D0964 800E0164 10000624 */   addiu     $a2, $zero, 0x10
  .L800E0168:
    /* D0968 800E0168 7400A48F */  lw         $a0, 0x74($sp)
    /* D096C 800E016C 00000000 */  nop
    /* D0970 800E0170 06008004 */  bltz       $a0, .L800E018C
    /* D0974 800E0174 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* D0978 800E0178 7800A58F */  lw         $a1, 0x78($sp)
    /* D097C 800E017C 14D1030C */  jal        GetClut
    /* D0980 800E0180 00000000 */   nop
    /* D0984 800E0184 64800308 */  j          .L800E0190
    /* D0988 800E0188 020042A6 */   sh        $v0, 0x2($s2)
  .L800E018C:
    /* D098C 800E018C 020042A6 */  sh         $v0, 0x2($s2)
  .L800E0190:
    /* D0990 800E0190 4000E232 */  andi       $v0, $s7, 0x40
    /* D0994 800E0194 04004010 */  beqz       $v0, .L800E01A8
    /* D0998 800E0198 10002426 */   addiu     $a0, $s1, 0x10
    /* D099C 800E019C 21284002 */  addu       $a1, $s2, $zero
    /* D09A0 800E01A0 EF7D030C */  jal        Texture_AddSharedPalette__FPcP12Draw_tPixMapi
    /* D09A4 800E01A4 21308002 */   addu      $a2, $s4, $zero
  .L800E01A8:
    /* D09A8 800E01A8 2000E232 */  andi       $v0, $s7, 0x20
  .L800E01AC:
    /* D09AC 800E01AC 07004010 */  beqz       $v0, .L800E01CC
    /* D09B0 800E01B0 21200002 */   addu      $a0, $s0, $zero
    /* D09B4 800E01B4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D09B8 800E01B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* D09BC 800E01BC 2128A002 */  addu       $a1, $s5, $zero
    /* D09C0 800E01C0 2130C002 */  addu       $a2, $s6, $zero
    /* D09C4 800E01C4 78800308 */  j          .L800E01E0
    /* D09C8 800E01C8 21384000 */   addu      $a3, $v0, $zero
  .L800E01CC:
    /* D09CC 800E01CC 2128A002 */  addu       $a1, $s5, $zero
    /* D09D0 800E01D0 7400A78F */  lw         $a3, 0x74($sp)
    /* D09D4 800E01D4 7800A28F */  lw         $v0, 0x78($sp)
    /* D09D8 800E01D8 2130C002 */  addu       $a2, $s6, $zero
    /* D09DC 800E01DC 1000A2AF */  sw         $v0, 0x10($sp)
  .L800E01E0:
    /* D09E0 800E01E0 4E7F030C */  jal        Texture_Vramcf__FP8shapetbliiii
    /* D09E4 800E01E4 00000000 */   nop
    /* D09E8 800E01E8 3400A897 */  lhu        $t0, 0x34($sp)
    /* D09EC 800E01EC 82800308 */  j          .L800E0208
    /* D09F0 800E01F0 040028A6 */   sh        $t0, 0x4($s1)
  .L800E01F4:
    /* D09F4 800E01F4 1000A0AF */  sw         $zero, 0x10($sp)
    /* D09F8 800E01F8 2128A002 */  addu       $a1, $s5, $zero
    /* D09FC 800E01FC 2130C002 */  addu       $a2, $s6, $zero
    /* D0A00 800E0200 4E7F030C */  jal        Texture_Vramcf__FP8shapetbliiii
    /* D0A04 800E0204 21380000 */   addu      $a3, $zero, $zero
  .L800E0208:
    /* D0A08 800E0208 A87F030C */  jal        Texture_GetTranslucencyMode__FP8shapetbl
    /* D0A0C 800E020C 21200002 */   addu      $a0, $s0, $zero
    /* D0A10 800E0210 21208002 */  addu       $a0, $s4, $zero
    /* D0A14 800E0214 21284000 */  addu       $a1, $v0, $zero
    /* D0A18 800E0218 2130A002 */  addu       $a2, $s5, $zero
    /* D0A1C 800E021C FFC6030C */  jal        GetTPage
    /* D0A20 800E0220 2138C002 */   addu      $a3, $s6, $zero
    /* D0A24 800E0224 060042A6 */  sh         $v0, 0x6($s2)
    /* D0A28 800E0228 0200A106 */  bgez       $s5, .L800E0234
    /* D0A2C 800E022C 2110A002 */   addu      $v0, $s5, $zero
    /* D0A30 800E0230 3F00A226 */  addiu      $v0, $s5, 0x3F
  .L800E0234:
    /* D0A34 800E0234 83210200 */  sra        $a0, $v0, 6
    /* D0A38 800E0238 80110400 */  sll        $v0, $a0, 6
    /* D0A3C 800E023C 2320A202 */  subu       $a0, $s5, $v0
    /* D0A40 800E0240 0200C106 */  bgez       $s6, .L800E024C
    /* D0A44 800E0244 2110C002 */   addu      $v0, $s6, $zero
    /* D0A48 800E0248 FF00C226 */  addiu      $v0, $s6, 0xFF
  .L800E024C:
    /* D0A4C 800E024C 032A0200 */  sra        $a1, $v0, 8
    /* D0A50 800E0250 00120500 */  sll        $v0, $a1, 8
    /* D0A54 800E0254 02008016 */  bnez       $s4, .L800E0260
    /* D0A58 800E0258 2328C202 */   subu      $a1, $s6, $v0
    /* D0A5C 800E025C 80200400 */  sll        $a0, $a0, 2
  .L800E0260:
    /* D0A60 800E0260 01000224 */  addiu      $v0, $zero, 0x1
    /* D0A64 800E0264 02008216 */  bne        $s4, $v0, .L800E0270
    /* D0A68 800E0268 00000000 */   nop
    /* D0A6C 800E026C 04204400 */  sllv       $a0, $a0, $v0
  .L800E0270:
    /* D0A70 800E0270 1C00A88F */  lw         $t0, 0x1C($sp)
    /* D0A74 800E0274 00000000 */  nop
    /* D0A78 800E0278 0D000011 */  beqz       $t0, .L800E02B0
    /* D0A7C 800E027C 2118BE00 */   addu      $v1, $a1, $fp
    /* D0A80 800E0280 000044A2 */  sb         $a0, 0x0($s2)
    /* D0A84 800E0284 010043A2 */  sb         $v1, 0x1($s2)
    /* D0A88 800E0288 040044A2 */  sb         $a0, 0x4($s2)
    /* D0A8C 800E028C 050045A2 */  sb         $a1, 0x5($s2)
    /* D0A90 800E0290 1800A88F */  lw         $t0, 0x18($sp)
    /* D0A94 800E0294 00000000 */  nop
    /* D0A98 800E0298 21108800 */  addu       $v0, $a0, $t0
    /* D0A9C 800E029C 080042A2 */  sb         $v0, 0x8($s2)
    /* D0AA0 800E02A0 090043A2 */  sb         $v1, 0x9($s2)
    /* D0AA4 800E02A4 0C0042A2 */  sb         $v0, 0xC($s2)
    /* D0AA8 800E02A8 B7800308 */  j          .L800E02DC
    /* D0AAC 800E02AC 0D0045A2 */   sb        $a1, 0xD($s2)
  .L800E02B0:
    /* D0AB0 800E02B0 000044A2 */  sb         $a0, 0x0($s2)
    /* D0AB4 800E02B4 010045A2 */  sb         $a1, 0x1($s2)
    /* D0AB8 800E02B8 1800A88F */  lw         $t0, 0x18($sp)
    /* D0ABC 800E02BC 2110BE00 */  addu       $v0, $a1, $fp
    /* D0AC0 800E02C0 21188800 */  addu       $v1, $a0, $t0
    /* D0AC4 800E02C4 040043A2 */  sb         $v1, 0x4($s2)
    /* D0AC8 800E02C8 050045A2 */  sb         $a1, 0x5($s2)
    /* D0ACC 800E02CC 080044A2 */  sb         $a0, 0x8($s2)
    /* D0AD0 800E02D0 090042A2 */  sb         $v0, 0x9($s2)
    /* D0AD4 800E02D4 0C0043A2 */  sb         $v1, 0xC($s2)
    /* D0AD8 800E02D8 0D0042A2 */  sb         $v0, 0xD($s2)
  .L800E02DC:
    /* D0ADC 800E02DC 00F0043C */  lui        $a0, (0xF000FFFF >> 16)
    /* D0AE0 800E02E0 FFFF8434 */  ori        $a0, $a0, (0xF000FFFF & 0xFFFF)
    /* D0AE4 800E02E4 2800A897 */  lhu        $t0, 0x28($sp)
    /* D0AE8 800E02E8 0C00038E */  lw         $v1, 0xC($s0)
    /* D0AEC 800E02EC 00F00224 */  addiu      $v0, $zero, -0x1000
    /* D0AF0 800E02F0 040008A6 */  sh         $t0, 0x4($s0)
    /* D0AF4 800E02F4 2C00A897 */  lhu        $t0, 0x2C($sp)
    /* D0AF8 800E02F8 00000000 */  nop
    /* D0AFC 800E02FC 060008A6 */  sh         $t0, 0x6($s0)
    /* D0B00 800E0300 2000A88F */  lw         $t0, 0x20($sp)
    /* D0B04 800E0304 24186200 */  and        $v1, $v1, $v0
    /* D0B08 800E0308 FF0F0231 */  andi       $v0, $t0, 0xFFF
    /* D0B0C 800E030C 25186200 */  or         $v1, $v1, $v0
    /* D0B10 800E0310 2400A88F */  lw         $t0, 0x24($sp)
    /* D0B14 800E0314 24186400 */  and        $v1, $v1, $a0
    /* D0B18 800E0318 FF0F0231 */  andi       $v0, $t0, 0xFFF
    /* D0B1C 800E031C 00140200 */  sll        $v0, $v0, 16
    /* D0B20 800E0320 25186200 */  or         $v1, $v1, $v0
    /* D0B24 800E0324 0C0003AE */  sw         $v1, 0xC($s0)
  .L800E0328:
    /* D0B28 800E0328 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* D0B2C 800E032C 5800BE8F */  lw         $fp, 0x58($sp)
    /* D0B30 800E0330 5400B78F */  lw         $s7, 0x54($sp)
    /* D0B34 800E0334 5000B68F */  lw         $s6, 0x50($sp)
    /* D0B38 800E0338 4C00B58F */  lw         $s5, 0x4C($sp)
    /* D0B3C 800E033C 4800B48F */  lw         $s4, 0x48($sp)
    /* D0B40 800E0340 4400B38F */  lw         $s3, 0x44($sp)
    /* D0B44 800E0344 4000B28F */  lw         $s2, 0x40($sp)
    /* D0B48 800E0348 3C00B18F */  lw         $s1, 0x3C($sp)
    /* D0B4C 800E034C 3800B08F */  lw         $s0, 0x38($sp)
    /* D0B50 800E0350 0800E003 */  jr         $ra
    /* D0B54 800E0354 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
