.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_SingleColorOct__FP7DVECTORP7CVECTORiii, 0xD8

glabel Flare_SingleColorOct__FP7DVECTORP7CVECTORiii
    /* BF0B0 800CE8B0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* BF0B4 800CE8B4 3000B0AF */  sw         $s0, 0x30($sp)
    /* BF0B8 800CE8B8 2180A000 */  addu       $s0, $a1, $zero
    /* BF0BC 800CE8BC 21480000 */  addu       $t1, $zero, $zero
    /* BF0C0 800CE8C0 1000A827 */  addiu      $t0, $sp, 0x10
    /* BF0C4 800CE8C4 1280023C */  lui        $v0, %hi(Flare_gLensOct)
    /* BF0C8 800CE8C8 3400B1AF */  sw         $s1, 0x34($sp)
    /* BF0CC 800CE8CC 5000B18F */  lw         $s1, 0x50($sp)
    /* BF0D0 800CE8D0 A8014524 */  addiu      $a1, $v0, %lo(Flare_gLensOct)
    /* BF0D4 800CE8D4 3800BFAF */  sw         $ra, 0x38($sp)
  .L800CE8D8:
    /* BF0D8 800CE8D8 0000A284 */  lh         $v0, 0x0($a1)
    /* BF0DC 800CE8DC 00000000 */  nop
    /* BF0E0 800CE8E0 1800C200 */  mult       $a2, $v0
    /* BF0E4 800CE8E4 12180000 */  mflo       $v1
    /* BF0E8 800CE8E8 02006104 */  bgez       $v1, .L800CE8F4
    /* BF0EC 800CE8EC 00000000 */   nop
    /* BF0F0 800CE8F0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CE8F4:
    /* BF0F4 800CE8F4 00008294 */  lhu        $v0, 0x0($a0)
    /* BF0F8 800CE8F8 031A0300 */  sra        $v1, $v1, 8
    /* BF0FC 800CE8FC 21104300 */  addu       $v0, $v0, $v1
    /* BF100 800CE900 000002A5 */  sh         $v0, 0x0($t0)
    /* BF104 800CE904 0200A284 */  lh         $v0, 0x2($a1)
    /* BF108 800CE908 00000000 */  nop
    /* BF10C 800CE90C 1800E200 */  mult       $a3, $v0
    /* BF110 800CE910 12180000 */  mflo       $v1
    /* BF114 800CE914 02006104 */  bgez       $v1, .L800CE920
    /* BF118 800CE918 00000000 */   nop
    /* BF11C 800CE91C FF006324 */  addiu      $v1, $v1, 0xFF
  .L800CE920:
    /* BF120 800CE920 0800A524 */  addiu      $a1, $a1, 0x8
    /* BF124 800CE924 01002925 */  addiu      $t1, $t1, 0x1
    /* BF128 800CE928 02008294 */  lhu        $v0, 0x2($a0)
    /* BF12C 800CE92C 031A0300 */  sra        $v1, $v1, 8
    /* BF130 800CE930 21104300 */  addu       $v0, $v0, $v1
    /* BF134 800CE934 020002A5 */  sh         $v0, 0x2($t0)
    /* BF138 800CE938 08002229 */  slti       $v0, $t1, 0x8
    /* BF13C 800CE93C E6FF4014 */  bnez       $v0, .L800CE8D8
    /* BF140 800CE940 04000825 */   addiu     $t0, $t0, 0x4
    /* BF144 800CE944 1000A427 */  addiu      $a0, $sp, 0x10
    /* BF148 800CE948 21280002 */  addu       $a1, $s0, $zero
    /* BF14C 800CE94C 0839030C */  jal        Flare_Quad__FPlP7CVECTORi
    /* BF150 800CE950 21302002 */   addu      $a2, $s1, $zero
    /* BF154 800CE954 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF158 800CE958 21280002 */  addu       $a1, $s0, $zero
    /* BF15C 800CE95C 0839030C */  jal        Flare_Quad__FPlP7CVECTORi
    /* BF160 800CE960 21302002 */   addu      $a2, $s1, $zero
    /* BF164 800CE964 2000A427 */  addiu      $a0, $sp, 0x20
    /* BF168 800CE968 21280002 */  addu       $a1, $s0, $zero
    /* BF16C 800CE96C 0839030C */  jal        Flare_Quad__FPlP7CVECTORi
    /* BF170 800CE970 21302002 */   addu      $a2, $s1, $zero
    /* BF174 800CE974 3800BF8F */  lw         $ra, 0x38($sp)
    /* BF178 800CE978 3400B18F */  lw         $s1, 0x34($sp)
    /* BF17C 800CE97C 3000B08F */  lw         $s0, 0x30($sp)
    /* BF180 800CE980 0800E003 */  jr         $ra
    /* BF184 800CE984 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Flare_SingleColorOct__FP7DVECTORP7CVECTORiii
