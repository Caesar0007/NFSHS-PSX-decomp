.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_NightHeadlight__FP8Car_tObj, 0x1AC

glabel DrawC_NightHeadlight__FP8Car_tObj
    /* AF178 800BE978 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* AF17C 800BE97C 21288000 */  addu       $a1, $a0, $zero
    /* AF180 800BE980 1180033C */  lui        $v1, %hi(D_80116F80)
    /* AF184 800BE984 1180023C */  lui        $v0, %hi(Cars_gList)
    /* AF188 800BE988 806F638C */  lw         $v1, %lo(D_80116F80)($v1)
    /* AF18C 800BE98C DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* AF190 800BE990 7800BFAF */  sw         $ra, 0x78($sp)
    /* AF194 800BE994 7400B1AF */  sw         $s1, 0x74($sp)
    /* AF198 800BE998 7000B0AF */  sw         $s0, 0x70($sp)
    /* AF19C 800BE99C 80200300 */  sll        $a0, $v1, 2
    /* AF1A0 800BE9A0 21108200 */  addu       $v0, $a0, $v0
    /* AF1A4 800BE9A4 0000438C */  lw         $v1, 0x0($v0)
    /* AF1A8 800BE9A8 8008A224 */  addiu      $v0, $a1, 0x880
    /* AF1AC 800BE9AC 6800A2AF */  sw         $v0, 0x68($sp)
    /* AF1B0 800BE9B0 47046290 */  lbu        $v0, 0x447($v1)
    /* AF1B4 800BE9B4 00000000 */  nop
    /* AF1B8 800BE9B8 06004230 */  andi       $v0, $v0, 0x6
    /* AF1BC 800BE9BC 30004010 */  beqz       $v0, .L800BEA80
    /* AF1C0 800BE9C0 A000A624 */   addiu     $a2, $a1, 0xA0
    /* AF1C4 800BE9C4 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* AF1C8 800BE9C8 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* AF1CC 800BE9CC 21188300 */  addu       $v1, $a0, $v1
    /* AF1D0 800BE9D0 0000628C */  lw         $v0, 0x0($v1)
    /* AF1D4 800BE9D4 1180113C */  lui        $s1, %hi(gNightMat)
    /* AF1D8 800BE9D8 A000448C */  lw         $a0, 0xA0($v0)
    /* AF1DC 800BE9DC A000A28C */  lw         $v0, 0xA0($a1)
    /* AF1E0 800BE9E0 64EE3126 */  addiu      $s1, $s1, %lo(gNightMat)
    /* AF1E4 800BE9E4 23104400 */  subu       $v0, $v0, $a0
    /* AF1E8 800BE9E8 4800A2AF */  sw         $v0, 0x48($sp)
    /* AF1EC 800BE9EC 0000628C */  lw         $v0, 0x0($v1)
    /* AF1F0 800BE9F0 5800B027 */  addiu      $s0, $sp, 0x58
    /* AF1F4 800BE9F4 A400458C */  lw         $a1, 0xA4($v0)
    /* AF1F8 800BE9F8 0400C28C */  lw         $v0, 0x4($a2)
    /* AF1FC 800BE9FC 4800A427 */  addiu      $a0, $sp, 0x48
    /* AF200 800BEA00 23104500 */  subu       $v0, $v0, $a1
    /* AF204 800BEA04 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* AF208 800BEA08 0000628C */  lw         $v0, 0x0($v1)
    /* AF20C 800BEA0C 21282002 */  addu       $a1, $s1, $zero
    /* AF210 800BEA10 A800438C */  lw         $v1, 0xA8($v0)
    /* AF214 800BEA14 0800C28C */  lw         $v0, 0x8($a2)
    /* AF218 800BEA18 21300002 */  addu       $a2, $s0, $zero
    /* AF21C 800BEA1C 23104300 */  subu       $v0, $v0, $v1
    /* AF220 800BEA20 B6AB030C */  jal        transform
    /* AF224 800BEA24 5000A2AF */   sw        $v0, 0x50($sp)
    /* AF228 800BEA28 21200002 */  addu       $a0, $s0, $zero
    /* AF22C 800BEA2C 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* AF230 800BEA30 1000A527 */   addiu     $a1, $sp, 0x10
    /* AF234 800BEA34 21202002 */  addu       $a0, $s1, $zero
    /* AF238 800BEA38 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* AF23C 800BEA3C 1000A527 */   addiu     $a1, $sp, 0x10
    /* AF240 800BEA40 4000A227 */  addiu      $v0, $sp, 0x40
    /* AF244 800BEA44 4400A0A7 */  sh         $zero, 0x44($sp)
    /* AF248 800BEA48 4200A0A7 */  sh         $zero, 0x42($sp)
    /* AF24C 800BEA4C 4000A0A7 */  sh         $zero, 0x40($sp)
    /* AF250 800BEA50 000040C8 */  lwc2       $0, 0x0($v0)
    /* AF254 800BEA54 040041C8 */  lwc2       $1, 0x4($v0)
    /* AF258 800BEA58 00000000 */  nop
    /* AF25C 800BEA5C 00000000 */  nop
    /* AF260 800BEA60 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* AF264 800BEA64 3000A427 */  addiu      $a0, $sp, 0x30
    /* AF268 800BEA68 000099E8 */  swc2       $25, 0x0($a0)
    /* AF26C 800BEA6C 04009AE8 */  swc2       $26, 0x4($a0) /* handwritten instruction */
    /* AF270 800BEA70 08009BE8 */  swc2       $27, 0x8($a0) /* handwritten instruction */
    /* AF274 800BEA74 6800A58F */  lw         $a1, 0x68($sp)
    /* AF278 800BEA78 6E70030C */  jal        Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
    /* AF27C 800BEA7C 00000000 */   nop
  .L800BEA80:
    /* AF280 800BEA80 1480023C */  lui        $v0, %hi(Night_gDrawLightning)
    /* AF284 800BEA84 E0D94290 */  lbu        $v0, %lo(Night_gDrawLightning)($v0)
    /* AF288 800BEA88 00000000 */  nop
    /* AF28C 800BEA8C 20004010 */  beqz       $v0, .L800BEB10
    /* AF290 800BEA90 6800A627 */   addiu     $a2, $sp, 0x68
    /* AF294 800BEA94 1480023C */  lui        $v0, %hi(Night_gWeatherColor)
    /* AF298 800BEA98 88DA4224 */  addiu      $v0, $v0, %lo(Night_gWeatherColor)
    /* AF29C 800BEA9C 1480033C */  lui        $v1, %hi(Night_gLightningType)
    /* AF2A0 800BEAA0 44DA638C */  lw         $v1, %lo(Night_gLightningType)($v1)
    /* AF2A4 800BEAA4 6800A493 */  lbu        $a0, 0x68($sp)
    /* AF2A8 800BEAA8 80180300 */  sll        $v1, $v1, 2
    /* AF2AC 800BEAAC 21186200 */  addu       $v1, $v1, $v0
    /* AF2B0 800BEAB0 00006290 */  lbu        $v0, 0x0($v1)
    /* AF2B4 800BEAB4 0100C590 */  lbu        $a1, 0x1($a2)
    /* AF2B8 800BEAB8 21208200 */  addu       $a0, $a0, $v0
    /* AF2BC 800BEABC 21488000 */  addu       $t1, $a0, $zero
    /* AF2C0 800BEAC0 01006290 */  lbu        $v0, 0x1($v1)
    /* AF2C4 800BEAC4 00018428 */  slti       $a0, $a0, 0x100
    /* AF2C8 800BEAC8 2138A200 */  addu       $a3, $a1, $v0
    /* AF2CC 800BEACC 0200C590 */  lbu        $a1, 0x2($a2)
    /* AF2D0 800BEAD0 02006290 */  lbu        $v0, 0x2($v1)
    /* AF2D4 800BEAD4 2140E000 */  addu       $t0, $a3, $zero
    /* AF2D8 800BEAD8 2128A200 */  addu       $a1, $a1, $v0
    /* AF2DC 800BEADC 02008014 */  bnez       $a0, .L800BEAE8
    /* AF2E0 800BEAE0 2118A000 */   addu      $v1, $a1, $zero
    /* AF2E4 800BEAE4 FF000924 */  addiu      $t1, $zero, 0xFF
  .L800BEAE8:
    /* AF2E8 800BEAE8 0001E228 */  slti       $v0, $a3, 0x100
    /* AF2EC 800BEAEC 02004014 */  bnez       $v0, .L800BEAF8
    /* AF2F0 800BEAF0 0001A228 */   slti      $v0, $a1, 0x100
    /* AF2F4 800BEAF4 FF000824 */  addiu      $t0, $zero, 0xFF
  .L800BEAF8:
    /* AF2F8 800BEAF8 02004014 */  bnez       $v0, .L800BEB04
    /* AF2FC 800BEAFC 00000000 */   nop
    /* AF300 800BEB00 FF000324 */  addiu      $v1, $zero, 0xFF
  .L800BEB04:
    /* AF304 800BEB04 6800A9A3 */  sb         $t1, 0x68($sp)
    /* AF308 800BEB08 0100C8A0 */  sb         $t0, 0x1($a2)
    /* AF30C 800BEB0C 0200C3A0 */  sb         $v1, 0x2($a2)
  .L800BEB10:
    /* AF310 800BEB10 7800BF8F */  lw         $ra, 0x78($sp)
    /* AF314 800BEB14 7400B18F */  lw         $s1, 0x74($sp)
    /* AF318 800BEB18 7000B08F */  lw         $s0, 0x70($sp)
    /* AF31C 800BEB1C 0800E003 */  jr         $ra
    /* AF320 800BEB20 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel DrawC_NightHeadlight__FP8Car_tObj
