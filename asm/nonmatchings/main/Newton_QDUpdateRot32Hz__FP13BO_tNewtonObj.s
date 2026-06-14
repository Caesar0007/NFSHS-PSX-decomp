.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj, 0x120

glabel Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj
    /* 929F8 800A21F8 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 929FC 800A21FC 6400B1AF */  sw         $s1, 0x64($sp)
    /* 92A00 800A2200 21888000 */  addu       $s1, $a0, $zero
    /* 92A04 800A2204 6800BFAF */  sw         $ra, 0x68($sp)
    /* 92A08 800A2208 6000B0AF */  sw         $s0, 0x60($sp)
    /* 92A0C 800A220C 91002292 */  lbu        $v0, 0x91($s1)
    /* 92A10 800A2210 00000000 */  nop
    /* 92A14 800A2214 3B004010 */  beqz       $v0, .L800A2304
    /* 92A18 800A2218 00000000 */   nop
    /* 92A1C 800A221C 90002292 */  lbu        $v0, 0x90($s1)
    /* 92A20 800A2220 00000000 */  nop
    /* 92A24 800A2224 37004014 */  bnez       $v0, .L800A2304
    /* 92A28 800A2228 00000000 */   nop
    /* 92A2C 800A222C 1401228E */  lw         $v0, 0x114($s1)
    /* 92A30 800A2230 00000000 */  nop
    /* 92A34 800A2234 02004104 */  bgez       $v0, .L800A2240
    /* 92A38 800A2238 00000000 */   nop
    /* 92A3C 800A223C 0F004224 */  addiu      $v0, $v0, 0xF
  .L800A2240:
    /* 92A40 800A2240 03110200 */  sra        $v0, $v0, 4
    /* 92A44 800A2244 4800A2AF */  sw         $v0, 0x48($sp)
    /* 92A48 800A2248 1801228E */  lw         $v0, 0x118($s1)
    /* 92A4C 800A224C 00000000 */  nop
    /* 92A50 800A2250 02004104 */  bgez       $v0, .L800A225C
    /* 92A54 800A2254 00000000 */   nop
    /* 92A58 800A2258 0F004224 */  addiu      $v0, $v0, 0xF
  .L800A225C:
    /* 92A5C 800A225C 03110200 */  sra        $v0, $v0, 4
    /* 92A60 800A2260 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* 92A64 800A2264 1C01228E */  lw         $v0, 0x11C($s1)
    /* 92A68 800A2268 00000000 */  nop
    /* 92A6C 800A226C 02004104 */  bgez       $v0, .L800A2278
    /* 92A70 800A2270 00000000 */   nop
    /* 92A74 800A2274 0F004224 */  addiu      $v0, $v0, 0xF
  .L800A2278:
    /* 92A78 800A2278 03110200 */  sra        $v0, $v0, 4
    /* 92A7C 800A227C 5000A2AF */  sw         $v0, 0x50($sp)
    /* 92A80 800A2280 5800A227 */  addiu      $v0, $sp, 0x58
    /* 92A84 800A2284 1000A2AF */  sw         $v0, 0x10($sp)
    /* 92A88 800A2288 00200224 */  addiu      $v0, $zero, 0x2000
    /* 92A8C 800A228C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 92A90 800A2290 98002226 */  addiu      $v0, $s1, 0x98
    /* 92A94 800A2294 1800A2AF */  sw         $v0, 0x18($sp)
    /* 92A98 800A2298 4800A58F */  lw         $a1, 0x48($sp)
    /* 92A9C 800A229C 4C00A68F */  lw         $a2, 0x4C($sp)
    /* 92AA0 800A22A0 5000A78F */  lw         $a3, 0x50($sp)
    /* 92AA4 800A22A4 D387020C */  jal        Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
    /* 92AA8 800A22A8 2000A427 */   addiu     $a0, $sp, 0x20
    /* 92AAC 800A22AC 15004010 */  beqz       $v0, .L800A2304
    /* 92AB0 800A22B0 F0003026 */   addiu     $s0, $s1, 0xF0
    /* 92AB4 800A22B4 21200002 */  addu       $a0, $s0, $zero
    /* 92AB8 800A22B8 2000A527 */  addiu      $a1, $sp, 0x20
    /* 92ABC 800A22BC 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 92AC0 800A22C0 21300002 */   addu      $a2, $s0, $zero
    /* 92AC4 800A22C4 5800A28F */  lw         $v0, 0x58($sp)
    /* 92AC8 800A22C8 00000000 */  nop
    /* 92ACC 800A22CC 08004014 */  bnez       $v0, .L800A22F0
    /* 92AD0 800A22D0 00000000 */   nop
    /* 92AD4 800A22D4 92002292 */  lbu        $v0, 0x92($s1)
    /* 92AD8 800A22D8 00000000 */  nop
    /* 92ADC 800A22DC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 92AE0 800A22E0 920022A2 */  sb         $v0, 0x92($s1)
    /* 92AE4 800A22E4 FF004230 */  andi       $v0, $v0, 0xFF
    /* 92AE8 800A22E8 06004014 */  bnez       $v0, .L800A2304
    /* 92AEC 800A22EC 00000000 */   nop
  .L800A22F0:
    /* 92AF0 800A22F0 B9C0030C */  jal        reorthogonalize
    /* 92AF4 800A22F4 21200002 */   addu      $a0, $s0, $zero
    /* 92AF8 800A22F8 40000224 */  addiu      $v0, $zero, 0x40
    /* 92AFC 800A22FC 920022A2 */  sb         $v0, 0x92($s1)
    /* 92B00 800A2300 980020AE */  sw         $zero, 0x98($s1)
  .L800A2304:
    /* 92B04 800A2304 6800BF8F */  lw         $ra, 0x68($sp)
    /* 92B08 800A2308 6400B18F */  lw         $s1, 0x64($sp)
    /* 92B0C 800A230C 6000B08F */  lw         $s0, 0x60($sp)
    /* 92B10 800A2310 0800E003 */  jr         $ra
    /* 92B14 800A2314 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj
