.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_LoadFont__FPciic, 0x1D4

glabel Font_LoadFont__FPciic
    /* BC0BC 800CB8BC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* BC0C0 800CB8C0 2400B3AF */  sw         $s3, 0x24($sp)
    /* BC0C4 800CB8C4 21988000 */  addu       $s3, $a0, $zero
    /* BC0C8 800CB8C8 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* BC0CC 800CB8CC 21A8A000 */  addu       $s5, $a1, $zero
    /* BC0D0 800CB8D0 3000B6AF */  sw         $s6, 0x30($sp)
    /* BC0D4 800CB8D4 21B0C000 */  addu       $s6, $a2, $zero
    /* BC0D8 800CB8D8 2800B4AF */  sw         $s4, 0x28($sp)
    /* BC0DC 800CB8DC 21A0E000 */  addu       $s4, $a3, $zero
    /* BC0E0 800CB8E0 3400BFAF */  sw         $ra, 0x34($sp)
    /* BC0E4 800CB8E4 2000B2AF */  sw         $s2, 0x20($sp)
    /* BC0E8 800CB8E8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* BC0EC 800CB8EC A5CB030C */  jal        setfont
    /* BC0F0 800CB8F0 1800B0AF */   sw        $s0, 0x18($sp)
    /* BC0F4 800CB8F4 1380023C */  lui        $v0, %hi(D_80135C28)
    /* BC0F8 800CB8F8 285C528C */  lw         $s2, %lo(D_80135C28)($v0)
    /* BC0FC 800CB8FC 00000000 */  nop
    /* BC100 800CB900 04004286 */  lh         $v0, 0x4($s2)
    /* BC104 800CB904 06004386 */  lh         $v1, 0x6($s2)
    /* BC108 800CB908 00000000 */  nop
    /* BC10C 800CB90C 18004300 */  mult       $v0, $v1
    /* BC110 800CB910 12100000 */  mflo       $v0
    /* BC114 800CB914 C21F0200 */  srl        $v1, $v0, 31
    /* BC118 800CB918 21104300 */  addu       $v0, $v0, $v1
    /* BC11C 800CB91C 43880200 */  sra        $s1, $v0, 1
    /* BC120 800CB920 0C00201A */  blez       $s1, .L800CB954
    /* BC124 800CB924 21800000 */   addu      $s0, $zero, $zero
    /* BC128 800CB928 21201202 */  addu       $a0, $s0, $s2
  .L800CB92C:
    /* BC12C 800CB92C 10008390 */  lbu        $v1, 0x10($a0)
    /* BC130 800CB930 01001026 */  addiu      $s0, $s0, 0x1
    /* BC134 800CB934 0F006230 */  andi       $v0, $v1, 0xF
    /* BC138 800CB938 00110200 */  sll        $v0, $v0, 4
    /* BC13C 800CB93C 02190300 */  srl        $v1, $v1, 4
    /* BC140 800CB940 25104300 */  or         $v0, $v0, $v1
    /* BC144 800CB944 100082A0 */  sb         $v0, 0x10($a0)
    /* BC148 800CB948 2A101102 */  slt        $v0, $s0, $s1
    /* BC14C 800CB94C F7FF4014 */  bnez       $v0, .L800CB92C
    /* BC150 800CB950 21201202 */   addu      $a0, $s0, $s2
  .L800CB954:
    /* BC154 800CB954 0813838F */  lw         $v1, %gp_rel(font_clutx)($gp)
    /* BC158 800CB958 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BC15C 800CB95C 08006214 */  bne        $v1, $v0, .L800CB980
    /* BC160 800CB960 21204002 */   addu      $a0, $s2, $zero
    /* BC164 800CB964 1480053C */  lui        $a1, %hi(font_clutx)
    /* BC168 800CB968 54D8A524 */  addiu      $a1, $a1, %lo(font_clutx)
    /* BC16C 800CB96C 1480063C */  lui        $a2, %hi(font_cluty)
    /* BC170 800CB970 58D8C624 */  addiu      $a2, $a2, %lo(font_cluty)
    /* BC174 800CB974 4E7E030C */  jal        Texture_GetClutId__FiPiT1
    /* BC178 800CB978 01000424 */   addiu     $a0, $zero, 0x1
    /* BC17C 800CB97C 21204002 */  addu       $a0, $s2, $zero
  .L800CB980:
    /* BC180 800CB980 2128A002 */  addu       $a1, $s5, $zero
    /* BC184 800CB984 2130C002 */  addu       $a2, $s6, $zero
    /* BC188 800CB988 0813878F */  lw         $a3, %gp_rel(font_clutx)($gp)
    /* BC18C 800CB98C 0C13828F */  lw         $v0, %gp_rel(font_cluty)($gp)
    /* BC190 800CB990 21800000 */  addu       $s0, $zero, $zero
    /* BC194 800CB994 E37E030C */  jal        Texture_Vramf__FP8shapetbliiii
    /* BC198 800CB998 1000A2AF */   sw        $v0, 0x10($sp)
    /* BC19C 800CB99C B8C1030C */  jal        waitdraw
    /* BC1A0 800CB9A0 00000000 */   nop
    /* BC1A4 800CB9A4 1280023C */  lui        $v0, %hi(shpfontclut)
    /* BC1A8 800CB9A8 B0FD4224 */  addiu      $v0, $v0, %lo(shpfontclut)
    /* BC1AC 800CB9AC 23105200 */  subu       $v0, $v0, $s2
    /* BC1B0 800CB9B0 00004392 */  lbu        $v1, 0x0($s2)
    /* BC1B4 800CB9B4 00120200 */  sll        $v0, $v0, 8
    /* BC1B8 800CB9B8 25186200 */  or         $v1, $v1, $v0
    /* BC1BC 800CB9BC 0C00201A */  blez       $s1, .L800CB9F0
    /* BC1C0 800CB9C0 000043AE */   sw        $v1, 0x0($s2)
    /* BC1C4 800CB9C4 21201202 */  addu       $a0, $s0, $s2
  .L800CB9C8:
    /* BC1C8 800CB9C8 10008390 */  lbu        $v1, 0x10($a0)
    /* BC1CC 800CB9CC 01001026 */  addiu      $s0, $s0, 0x1
    /* BC1D0 800CB9D0 0F006230 */  andi       $v0, $v1, 0xF
    /* BC1D4 800CB9D4 00110200 */  sll        $v0, $v0, 4
    /* BC1D8 800CB9D8 02190300 */  srl        $v1, $v1, 4
    /* BC1DC 800CB9DC 25104300 */  or         $v0, $v0, $v1
    /* BC1E0 800CB9E0 100082A0 */  sb         $v0, 0x10($a0)
    /* BC1E4 800CB9E4 2A101102 */  slt        $v0, $s0, $s1
    /* BC1E8 800CB9E8 F7FF4014 */  bnez       $v0, .L800CB9C8
    /* BC1EC 800CB9EC 21201202 */   addu      $a0, $s0, $s2
  .L800CB9F0:
    /* BC1F0 800CB9F0 21800000 */  addu       $s0, $zero, $zero
    /* BC1F4 800CB9F4 1280023C */  lui        $v0, %hi(colourRGB)
    /* BC1F8 800CB9F8 70FD5124 */  addiu      $s1, $v0, %lo(colourRGB)
  .L800CB9FC:
    /* BC1FC 800CB9FC 21200002 */  addu       $a0, $s0, $zero
    /* BC200 800CBA00 0000258E */  lw         $a1, 0x0($s1)
    /* BC204 800CBA04 21300000 */  addu       $a2, $zero, $zero
    /* BC208 800CBA08 FF008732 */  andi       $a3, $s4, 0xFF
    /* BC20C 800CBA0C 04003126 */  addiu      $s1, $s1, 0x4
    /* BC210 800CBA10 E22C030C */  jal        Font_ComputeColors__Fiiic
    /* BC214 800CBA14 01001026 */   addiu     $s0, $s0, 0x1
    /* BC218 800CBA18 1000022A */  slti       $v0, $s0, 0x10
    /* BC21C 800CBA1C F7FF4014 */  bnez       $v0, .L800CB9FC
    /* BC220 800CBA20 00000000 */   nop
    /* BC224 800CBA24 F62D030C */  jal        Font_ReSetBlitter__Fv
    /* BC228 800CBA28 00000000 */   nop
    /* BC22C 800CBA2C FB2D030C */  jal        Font_SwitchFont__FPc
    /* BC230 800CBA30 21206002 */   addu      $a0, $s3, $zero
    /* BC234 800CBA34 21206002 */  addu       $a0, $s3, $zero
    /* BC238 800CBA38 1380023C */  lui        $v0, %hi(D_80135C28)
    /* BC23C 800CBA3C 285C458C */  lw         $a1, %lo(D_80135C28)($v0)
    /* BC240 800CBA40 F0FF8224 */  addiu      $v0, $a0, -0x10
    /* BC244 800CBA44 54C6030C */  jal        resizememadr
    /* BC248 800CBA48 2328A200 */   subu      $a1, $a1, $v0
    /* BC24C 800CBA4C 8000043C */  lui        $a0, (0x808080 >> 16)
    /* BC250 800CBA50 912C030C */  jal        Font_TextTint__Fi
    /* BC254 800CBA54 80808434 */   ori       $a0, $a0, (0x808080 & 0xFFFF)
    /* BC258 800CBA58 832C030C */  jal        Font_TextColor__Fi
    /* BC25C 800CBA5C 02000424 */   addiu     $a0, $zero, 0x2
    /* BC260 800CBA60 06004286 */  lh         $v0, 0x6($s2)
    /* BC264 800CBA64 3400BF8F */  lw         $ra, 0x34($sp)
    /* BC268 800CBA68 2C00B58F */  lw         $s5, 0x2C($sp)
    /* BC26C 800CBA6C 2800B48F */  lw         $s4, 0x28($sp)
    /* BC270 800CBA70 2400B38F */  lw         $s3, 0x24($sp)
    /* BC274 800CBA74 2000B28F */  lw         $s2, 0x20($sp)
    /* BC278 800CBA78 1C00B18F */  lw         $s1, 0x1C($sp)
    /* BC27C 800CBA7C 1800B08F */  lw         $s0, 0x18($sp)
    /* BC280 800CBA80 2110C202 */  addu       $v0, $s6, $v0
    /* BC284 800CBA84 3000B68F */  lw         $s6, 0x30($sp)
    /* BC288 800CBA88 0800E003 */  jr         $ra
    /* BC28C 800CBA8C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Font_LoadFont__FPciic
