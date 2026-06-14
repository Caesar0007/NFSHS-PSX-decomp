.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj, 0x110

glabel Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj
    /* 928E8 800A20E8 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 928EC 800A20EC 6400B1AF */  sw         $s1, 0x64($sp)
    /* 928F0 800A20F0 21888000 */  addu       $s1, $a0, $zero
    /* 928F4 800A20F4 6800BFAF */  sw         $ra, 0x68($sp)
    /* 928F8 800A20F8 6000B0AF */  sw         $s0, 0x60($sp)
    /* 928FC 800A20FC 91002292 */  lbu        $v0, 0x91($s1)
    /* 92900 800A2100 00000000 */  nop
    /* 92904 800A2104 37004010 */  beqz       $v0, .L800A21E4
    /* 92908 800A2108 00000000 */   nop
    /* 9290C 800A210C 1401228E */  lw         $v0, 0x114($s1)
    /* 92910 800A2110 00000000 */  nop
    /* 92914 800A2114 02004104 */  bgez       $v0, .L800A2120
    /* 92918 800A2118 00000000 */   nop
    /* 9291C 800A211C 3F004224 */  addiu      $v0, $v0, 0x3F
  .L800A2120:
    /* 92920 800A2120 83110200 */  sra        $v0, $v0, 6
    /* 92924 800A2124 4800A2AF */  sw         $v0, 0x48($sp)
    /* 92928 800A2128 1801228E */  lw         $v0, 0x118($s1)
    /* 9292C 800A212C 00000000 */  nop
    /* 92930 800A2130 02004104 */  bgez       $v0, .L800A213C
    /* 92934 800A2134 00000000 */   nop
    /* 92938 800A2138 3F004224 */  addiu      $v0, $v0, 0x3F
  .L800A213C:
    /* 9293C 800A213C 83110200 */  sra        $v0, $v0, 6
    /* 92940 800A2140 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* 92944 800A2144 1C01228E */  lw         $v0, 0x11C($s1)
    /* 92948 800A2148 00000000 */  nop
    /* 9294C 800A214C 02004104 */  bgez       $v0, .L800A2158
    /* 92950 800A2150 00000000 */   nop
    /* 92954 800A2154 3F004224 */  addiu      $v0, $v0, 0x3F
  .L800A2158:
    /* 92958 800A2158 83110200 */  sra        $v0, $v0, 6
    /* 9295C 800A215C 5000A2AF */  sw         $v0, 0x50($sp)
    /* 92960 800A2160 5800A227 */  addiu      $v0, $sp, 0x58
    /* 92964 800A2164 1000A2AF */  sw         $v0, 0x10($sp)
    /* 92968 800A2168 00100224 */  addiu      $v0, $zero, 0x1000
    /* 9296C 800A216C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 92970 800A2170 98002226 */  addiu      $v0, $s1, 0x98
    /* 92974 800A2174 1800A2AF */  sw         $v0, 0x18($sp)
    /* 92978 800A2178 4800A58F */  lw         $a1, 0x48($sp)
    /* 9297C 800A217C 4C00A68F */  lw         $a2, 0x4C($sp)
    /* 92980 800A2180 5000A78F */  lw         $a3, 0x50($sp)
    /* 92984 800A2184 D387020C */  jal        Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
    /* 92988 800A2188 2000A427 */   addiu     $a0, $sp, 0x20
    /* 9298C 800A218C 15004010 */  beqz       $v0, .L800A21E4
    /* 92990 800A2190 F0003026 */   addiu     $s0, $s1, 0xF0
    /* 92994 800A2194 21200002 */  addu       $a0, $s0, $zero
    /* 92998 800A2198 2000A527 */  addiu      $a1, $sp, 0x20
    /* 9299C 800A219C 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 929A0 800A21A0 21300002 */   addu      $a2, $s0, $zero
    /* 929A4 800A21A4 92002292 */  lbu        $v0, 0x92($s1)
    /* 929A8 800A21A8 00000000 */  nop
    /* 929AC 800A21AC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 929B0 800A21B0 920022A2 */  sb         $v0, 0x92($s1)
    /* 929B4 800A21B4 FF004230 */  andi       $v0, $v0, 0xFF
    /* 929B8 800A21B8 05004010 */  beqz       $v0, .L800A21D0
    /* 929BC 800A21BC 00000000 */   nop
    /* 929C0 800A21C0 5800A28F */  lw         $v0, 0x58($sp)
    /* 929C4 800A21C4 00000000 */  nop
    /* 929C8 800A21C8 06004010 */  beqz       $v0, .L800A21E4
    /* 929CC 800A21CC 00000000 */   nop
  .L800A21D0:
    /* 929D0 800A21D0 B9C0030C */  jal        reorthogonalize
    /* 929D4 800A21D4 21200002 */   addu      $a0, $s0, $zero
    /* 929D8 800A21D8 20000224 */  addiu      $v0, $zero, 0x20
    /* 929DC 800A21DC 920022A2 */  sb         $v0, 0x92($s1)
    /* 929E0 800A21E0 980020AE */  sw         $zero, 0x98($s1)
  .L800A21E4:
    /* 929E4 800A21E4 6800BF8F */  lw         $ra, 0x68($sp)
    /* 929E8 800A21E8 6400B18F */  lw         $s1, 0x64($sp)
    /* 929EC 800A21EC 6000B08F */  lw         $s0, 0x60($sp)
    /* 929F0 800A21F0 0800E003 */  jr         $ra
    /* 929F4 800A21F4 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj
