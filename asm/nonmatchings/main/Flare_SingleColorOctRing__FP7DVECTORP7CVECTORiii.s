.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii, 0x1BC

glabel Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii
    /* BF188 800CE988 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* BF18C 800CE98C 5800B0AF */  sw         $s0, 0x58($sp)
    /* BF190 800CE990 2180A000 */  addu       $s0, $a1, $zero
    /* BF194 800CE994 FBFFCD24 */  addiu      $t5, $a2, -0x5
    /* BF198 800CE998 FBFFEC24 */  addiu      $t4, $a3, -0x5
    /* BF19C 800CE99C 21280000 */  addu       $a1, $zero, $zero
    /* BF1A0 800CE9A0 1000AB27 */  addiu      $t3, $sp, 0x10
    /* BF1A4 800CE9A4 1280023C */  lui        $v0, %hi(Flare_gOct)
    /* BF1A8 800CE9A8 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* BF1AC 800CE9AC 7800B18F */  lw         $s1, 0x78($sp)
    /* BF1B0 800CE9B0 68FE4E24 */  addiu      $t6, $v0, %lo(Flare_gOct)
    /* BF1B4 800CE9B4 6000BFAF */  sw         $ra, 0x60($sp)
    /* BF1B8 800CE9B8 40480500 */  sll        $t1, $a1, 1
  .L800CE9BC:
    /* BF1BC 800CE9BC 0200A104 */  bgez       $a1, .L800CE9C8
    /* BF1C0 800CE9C0 2110A000 */   addu      $v0, $a1, $zero
    /* BF1C4 800CE9C4 0700A224 */  addiu      $v0, $a1, 0x7
  .L800CE9C8:
    /* BF1C8 800CE9C8 C3100200 */  sra        $v0, $v0, 3
    /* BF1CC 800CE9CC C0100200 */  sll        $v0, $v0, 3
    /* BF1D0 800CE9D0 2310A200 */  subu       $v0, $a1, $v0
    /* BF1D4 800CE9D4 FF004230 */  andi       $v0, $v0, 0xFF
    /* BF1D8 800CE9D8 C0100200 */  sll        $v0, $v0, 3
    /* BF1DC 800CE9DC 21404E00 */  addu       $t0, $v0, $t6
    /* BF1E0 800CE9E0 00000285 */  lh         $v0, 0x0($t0)
    /* BF1E4 800CE9E4 00000000 */  nop
    /* BF1E8 800CE9E8 1800C200 */  mult       $a2, $v0
    /* BF1EC 800CE9EC FF002A31 */  andi       $t2, $t1, 0xFF
    /* BF1F0 800CE9F0 80100A00 */  sll        $v0, $t2, 2
    /* BF1F4 800CE9F4 12180000 */  mflo       $v1
    /* BF1F8 800CE9F8 02006104 */  bgez       $v1, .L800CEA04
    /* BF1FC 800CE9FC 21486201 */   addu      $t1, $t3, $v0
    /* BF200 800CEA00 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CEA04:
    /* BF204 800CEA04 00008294 */  lhu        $v0, 0x0($a0)
    /* BF208 800CEA08 031A0300 */  sra        $v1, $v1, 8
    /* BF20C 800CEA0C 21104300 */  addu       $v0, $v0, $v1
    /* BF210 800CEA10 000022A5 */  sh         $v0, 0x0($t1)
    /* BF214 800CEA14 02000285 */  lh         $v0, 0x2($t0)
    /* BF218 800CEA18 00000000 */  nop
    /* BF21C 800CEA1C 1800E200 */  mult       $a3, $v0
    /* BF220 800CEA20 12180000 */  mflo       $v1
    /* BF224 800CEA24 02006104 */  bgez       $v1, .L800CEA30
    /* BF228 800CEA28 00000000 */   nop
    /* BF22C 800CEA2C FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CEA30:
    /* BF230 800CEA30 02008294 */  lhu        $v0, 0x2($a0)
    /* BF234 800CEA34 031A0300 */  sra        $v1, $v1, 8
    /* BF238 800CEA38 21104300 */  addu       $v0, $v0, $v1
    /* BF23C 800CEA3C 020022A5 */  sh         $v0, 0x2($t1)
    /* BF240 800CEA40 00000285 */  lh         $v0, 0x0($t0)
    /* BF244 800CEA44 00000000 */  nop
    /* BF248 800CEA48 1800A201 */  mult       $t5, $v0
    /* BF24C 800CEA4C 01004225 */  addiu      $v0, $t2, 0x1
    /* BF250 800CEA50 80100200 */  sll        $v0, $v0, 2
    /* BF254 800CEA54 12180000 */  mflo       $v1
    /* BF258 800CEA58 02006104 */  bgez       $v1, .L800CEA64
    /* BF25C 800CEA5C 21486201 */   addu      $t1, $t3, $v0
    /* BF260 800CEA60 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CEA64:
    /* BF264 800CEA64 00008294 */  lhu        $v0, 0x0($a0)
    /* BF268 800CEA68 031A0300 */  sra        $v1, $v1, 8
    /* BF26C 800CEA6C 21104300 */  addu       $v0, $v0, $v1
    /* BF270 800CEA70 000022A5 */  sh         $v0, 0x0($t1)
    /* BF274 800CEA74 02000285 */  lh         $v0, 0x2($t0)
    /* BF278 800CEA78 00000000 */  nop
    /* BF27C 800CEA7C 18008201 */  mult       $t4, $v0
    /* BF280 800CEA80 12180000 */  mflo       $v1
    /* BF284 800CEA84 02006104 */  bgez       $v1, .L800CEA90
    /* BF288 800CEA88 00000000 */   nop
    /* BF28C 800CEA8C FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CEA90:
    /* BF290 800CEA90 0100A524 */  addiu      $a1, $a1, 0x1
    /* BF294 800CEA94 02008294 */  lhu        $v0, 0x2($a0)
    /* BF298 800CEA98 031A0300 */  sra        $v1, $v1, 8
    /* BF29C 800CEA9C 21104300 */  addu       $v0, $v0, $v1
    /* BF2A0 800CEAA0 020022A5 */  sh         $v0, 0x2($t1)
    /* BF2A4 800CEAA4 0900A228 */  slti       $v0, $a1, 0x9
    /* BF2A8 800CEAA8 C4FF4014 */  bnez       $v0, .L800CE9BC
    /* BF2AC 800CEAAC 40480500 */   sll       $t1, $a1, 1
    /* BF2B0 800CEAB0 1000A427 */  addiu      $a0, $sp, 0x10
    /* BF2B4 800CEAB4 21280002 */  addu       $a1, $s0, $zero
    /* BF2B8 800CEAB8 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF2BC 800CEABC 21302002 */   addu      $a2, $s1, $zero
    /* BF2C0 800CEAC0 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF2C4 800CEAC4 21280002 */  addu       $a1, $s0, $zero
    /* BF2C8 800CEAC8 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF2CC 800CEACC 21302002 */   addu      $a2, $s1, $zero
    /* BF2D0 800CEAD0 2000A427 */  addiu      $a0, $sp, 0x20
    /* BF2D4 800CEAD4 21280002 */  addu       $a1, $s0, $zero
    /* BF2D8 800CEAD8 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF2DC 800CEADC 21302002 */   addu      $a2, $s1, $zero
    /* BF2E0 800CEAE0 2800A427 */  addiu      $a0, $sp, 0x28
    /* BF2E4 800CEAE4 21280002 */  addu       $a1, $s0, $zero
    /* BF2E8 800CEAE8 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF2EC 800CEAEC 21302002 */   addu      $a2, $s1, $zero
    /* BF2F0 800CEAF0 3000A427 */  addiu      $a0, $sp, 0x30
    /* BF2F4 800CEAF4 21280002 */  addu       $a1, $s0, $zero
    /* BF2F8 800CEAF8 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF2FC 800CEAFC 21302002 */   addu      $a2, $s1, $zero
    /* BF300 800CEB00 3800A427 */  addiu      $a0, $sp, 0x38
    /* BF304 800CEB04 21280002 */  addu       $a1, $s0, $zero
    /* BF308 800CEB08 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF30C 800CEB0C 21302002 */   addu      $a2, $s1, $zero
    /* BF310 800CEB10 4000A427 */  addiu      $a0, $sp, 0x40
    /* BF314 800CEB14 21280002 */  addu       $a1, $s0, $zero
    /* BF318 800CEB18 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF31C 800CEB1C 21302002 */   addu      $a2, $s1, $zero
    /* BF320 800CEB20 4800A427 */  addiu      $a0, $sp, 0x48
    /* BF324 800CEB24 21280002 */  addu       $a1, $s0, $zero
    /* BF328 800CEB28 5A39030C */  jal        Flare_QuadRing__FPlP7CVECTORi
    /* BF32C 800CEB2C 21302002 */   addu      $a2, $s1, $zero
    /* BF330 800CEB30 6000BF8F */  lw         $ra, 0x60($sp)
    /* BF334 800CEB34 5C00B18F */  lw         $s1, 0x5C($sp)
    /* BF338 800CEB38 5800B08F */  lw         $s0, 0x58($sp)
    /* BF33C 800CEB3C 0800E003 */  jr         $ra
    /* BF340 800CEB40 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii
