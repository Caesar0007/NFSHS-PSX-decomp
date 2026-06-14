.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loaddirinfo, 0x19C

glabel loaddirinfo
    /* EA9A8 800FA1A8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EA9AC 800FA1AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* EA9B0 800FA1B0 2190A000 */  addu       $s2, $a1, $zero
    /* EA9B4 800FA1B4 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EA9B8 800FA1B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* EA9BC 800FA1BC C46C5124 */  addiu      $s1, $v0, %lo(Cdinfo)
    /* EA9C0 800FA1C0 2400BFAF */  sw         $ra, 0x24($sp)
    /* EA9C4 800FA1C4 2000B4AF */  sw         $s4, 0x20($sp)
    /* EA9C8 800FA1C8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EA9CC 800FA1CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* EA9D0 800FA1D0 1400348E */  lw         $s4, 0x14($s1)
    /* EA9D4 800FA1D4 2198C000 */  addu       $s3, $a2, $zero
    /* EA9D8 800FA1D8 55E8030C */  jal        readsectorB
    /* EA9DC 800FA1DC 140024AE */   sw        $a0, 0x14($s1)
    /* EA9E0 800FA1E0 00004390 */  lbu        $v1, 0x0($v0)
    /* EA9E4 800FA1E4 FFFF5226 */  addiu      $s2, $s2, -0x1
    /* EA9E8 800FA1E8 C1E80308 */  j          .L800FA304
    /* EA9EC 800FA1EC 21806200 */   addu      $s0, $v1, $v0
  .L800FA1F0:
    /* EA9F0 800FA1F0 00000292 */  lbu        $v0, 0x0($s0)
    /* EA9F4 800FA1F4 00000000 */  nop
    /* EA9F8 800FA1F8 0A004014 */  bnez       $v0, .L800FA224
    /* EA9FC 800FA1FC 00000000 */   nop
    /* EAA00 800FA200 46004012 */  beqz       $s2, .L800FA31C
    /* EAA04 800FA204 00000000 */   nop
    /* EAA08 800FA208 1400228E */  lw         $v0, 0x14($s1)
    /* EAA0C 800FA20C 00000000 */  nop
    /* EAA10 800FA210 01004224 */  addiu      $v0, $v0, 0x1
    /* EAA14 800FA214 55E8030C */  jal        readsectorB
    /* EAA18 800FA218 140022AE */   sw        $v0, 0x14($s1)
    /* EAA1C 800FA21C 21804000 */  addu       $s0, $v0, $zero
    /* EAA20 800FA220 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800FA224:
    /* EAA24 800FA224 19000292 */  lbu        $v0, 0x19($s0)
    /* EAA28 800FA228 00000000 */  nop
    /* EAA2C 800FA22C 02004230 */  andi       $v0, $v0, 0x2
    /* EAA30 800FA230 0B004010 */  beqz       $v0, .L800FA260
    /* EAA34 800FA234 21306002 */   addu      $a2, $s3, $zero
    /* EAA38 800FA238 0D00058A */  lwl        $a1, 0xD($s0)
    /* EAA3C 800FA23C 0A00059A */  lwr        $a1, 0xA($s0)
    /* EAA40 800FA240 0500048A */  lwl        $a0, 0x5($s0)
    /* EAA44 800FA244 0200049A */  lwr        $a0, 0x2($s0)
    /* EAA48 800FA248 6AE8030C */  jal        loaddirinfo
    /* EAA4C 800FA24C C22A0500 */   srl       $a1, $a1, 11
    /* EAA50 800FA250 55E8030C */  jal        readsectorB
    /* EAA54 800FA254 00000000 */   nop
    /* EAA58 800FA258 C1E80308 */  j          .L800FA304
    /* EAA5C 800FA25C 00000000 */   nop
  .L800FA260:
    /* EAA60 800FA260 21000526 */  addiu      $a1, $s0, 0x21
    /* EAA64 800FA264 0800228E */  lw         $v0, 0x8($s1)
    /* EAA68 800FA268 20000692 */  lbu        $a2, 0x20($s0)
    /* EAA6C 800FA26C 80200200 */  sll        $a0, $v0, 2
    /* EAA70 800FA270 21208200 */  addu       $a0, $a0, $v0
    /* EAA74 800FA274 80200400 */  sll        $a0, $a0, 2
    /* EAA78 800FA278 3800228E */  lw         $v0, 0x38($s1)
    /* EAA7C 800FA27C FEFFC624 */  addiu      $a2, $a2, -0x2
    /* EAA80 800FA280 B1AA030C */  jal        memcpy
    /* EAA84 800FA284 21208200 */   addu      $a0, $a0, $v0
    /* EAA88 800FA288 0800238E */  lw         $v1, 0x8($s1)
    /* EAA8C 800FA28C 3800248E */  lw         $a0, 0x38($s1)
    /* EAA90 800FA290 80100300 */  sll        $v0, $v1, 2
    /* EAA94 800FA294 21104300 */  addu       $v0, $v0, $v1
    /* EAA98 800FA298 80100200 */  sll        $v0, $v0, 2
    /* EAA9C 800FA29C 20000392 */  lbu        $v1, 0x20($s0)
    /* EAAA0 800FA2A0 21104400 */  addu       $v0, $v0, $a0
    /* EAAA4 800FA2A4 21186200 */  addu       $v1, $v1, $v0
    /* EAAA8 800FA2A8 FEFF60A0 */  sb         $zero, -0x2($v1)
    /* EAAAC 800FA2AC 0800238E */  lw         $v1, 0x8($s1)
    /* EAAB0 800FA2B0 0500048A */  lwl        $a0, 0x5($s0)
    /* EAAB4 800FA2B4 0200049A */  lwr        $a0, 0x2($s0)
    /* EAAB8 800FA2B8 80100300 */  sll        $v0, $v1, 2
    /* EAABC 800FA2BC 21104300 */  addu       $v0, $v0, $v1
    /* EAAC0 800FA2C0 3800238E */  lw         $v1, 0x38($s1)
    /* EAAC4 800FA2C4 80100200 */  sll        $v0, $v0, 2
    /* EAAC8 800FA2C8 21104300 */  addu       $v0, $v0, $v1
    /* EAACC 800FA2CC 0C0044AC */  sw         $a0, 0xC($v0)
    /* EAAD0 800FA2D0 0800238E */  lw         $v1, 0x8($s1)
    /* EAAD4 800FA2D4 0D00048A */  lwl        $a0, 0xD($s0)
    /* EAAD8 800FA2D8 0A00049A */  lwr        $a0, 0xA($s0)
    /* EAADC 800FA2DC 80100300 */  sll        $v0, $v1, 2
    /* EAAE0 800FA2E0 21104300 */  addu       $v0, $v0, $v1
    /* EAAE4 800FA2E4 3800238E */  lw         $v1, 0x38($s1)
    /* EAAE8 800FA2E8 80100200 */  sll        $v0, $v0, 2
    /* EAAEC 800FA2EC 21104300 */  addu       $v0, $v0, $v1
    /* EAAF0 800FA2F0 100044AC */  sw         $a0, 0x10($v0)
    /* EAAF4 800FA2F4 0800228E */  lw         $v0, 0x8($s1)
    /* EAAF8 800FA2F8 00000000 */  nop
    /* EAAFC 800FA2FC 01004224 */  addiu      $v0, $v0, 0x1
    /* EAB00 800FA300 080022AE */  sw         $v0, 0x8($s1)
  .L800FA304:
    /* EAB04 800FA304 00000392 */  lbu        $v1, 0x0($s0)
    /* EAB08 800FA308 0800228E */  lw         $v0, 0x8($s1)
    /* EAB0C 800FA30C 00000000 */  nop
    /* EAB10 800FA310 2A105300 */  slt        $v0, $v0, $s3
    /* EAB14 800FA314 B6FF4014 */  bnez       $v0, .L800FA1F0
    /* EAB18 800FA318 21800302 */   addu      $s0, $s0, $v1
  .L800FA31C:
    /* EAB1C 800FA31C 2400BF8F */  lw         $ra, 0x24($sp)
    /* EAB20 800FA320 1480023C */  lui        $v0, %hi(D_80146CD8)
    /* EAB24 800FA324 D86C54AC */  sw         $s4, %lo(D_80146CD8)($v0)
    /* EAB28 800FA328 2000B48F */  lw         $s4, 0x20($sp)
    /* EAB2C 800FA32C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EAB30 800FA330 1800B28F */  lw         $s2, 0x18($sp)
    /* EAB34 800FA334 1400B18F */  lw         $s1, 0x14($sp)
    /* EAB38 800FA338 1000B08F */  lw         $s0, 0x10($sp)
    /* EAB3C 800FA33C 0800E003 */  jr         $ra
    /* EAB40 800FA340 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loaddirinfo
