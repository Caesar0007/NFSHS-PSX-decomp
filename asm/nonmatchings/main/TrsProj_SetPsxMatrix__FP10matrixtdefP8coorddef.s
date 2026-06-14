.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef, 0xF0

glabel TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
    /* D225C 800E1A5C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D2260 800E1A60 2130A000 */  addu       $a2, $a1, $zero
    /* D2264 800E1A64 3000BFAF */  sw         $ra, 0x30($sp)
    /* D2268 800E1A68 0000828C */  lw         $v0, 0x0($a0)
    /* D226C 800E1A6C 0C00838C */  lw         $v1, 0xC($a0)
    /* D2270 800E1A70 1800858C */  lw         $a1, 0x18($a0)
    /* D2274 800E1A74 03110200 */  sra        $v0, $v0, 4
    /* D2278 800E1A78 03190300 */  sra        $v1, $v1, 4
    /* D227C 800E1A7C 03290500 */  sra        $a1, $a1, 4
    /* D2280 800E1A80 1000A2A7 */  sh         $v0, 0x10($sp)
    /* D2284 800E1A84 1200A3A7 */  sh         $v1, 0x12($sp)
    /* D2288 800E1A88 1400A5A7 */  sh         $a1, 0x14($sp)
    /* D228C 800E1A8C 0400828C */  lw         $v0, 0x4($a0)
    /* D2290 800E1A90 1000838C */  lw         $v1, 0x10($a0)
    /* D2294 800E1A94 1C00858C */  lw         $a1, 0x1C($a0)
    /* D2298 800E1A98 03110200 */  sra        $v0, $v0, 4
    /* D229C 800E1A9C 03190300 */  sra        $v1, $v1, 4
    /* D22A0 800E1AA0 03290500 */  sra        $a1, $a1, 4
    /* D22A4 800E1AA4 1600A2A7 */  sh         $v0, 0x16($sp)
    /* D22A8 800E1AA8 1800A3A7 */  sh         $v1, 0x18($sp)
    /* D22AC 800E1AAC 1A00A5A7 */  sh         $a1, 0x1A($sp)
    /* D22B0 800E1AB0 0800828C */  lw         $v0, 0x8($a0)
    /* D22B4 800E1AB4 1400838C */  lw         $v1, 0x14($a0)
    /* D22B8 800E1AB8 2000848C */  lw         $a0, 0x20($a0)
    /* D22BC 800E1ABC 03110200 */  sra        $v0, $v0, 4
    /* D22C0 800E1AC0 03190300 */  sra        $v1, $v1, 4
    /* D22C4 800E1AC4 03210400 */  sra        $a0, $a0, 4
    /* D22C8 800E1AC8 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* D22CC 800E1ACC 1000A227 */  addiu      $v0, $sp, 0x10
    /* D22D0 800E1AD0 1E00A3A7 */  sh         $v1, 0x1E($sp)
    /* D22D4 800E1AD4 2000A4A7 */  sh         $a0, 0x20($sp)
    /* D22D8 800E1AD8 00004C8C */  lw         $t4, 0x0($v0)
    /* D22DC 800E1ADC 04004D8C */  lw         $t5, 0x4($v0)
    /* D22E0 800E1AE0 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* D22E4 800E1AE4 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* D22E8 800E1AE8 08004C8C */  lw         $t4, 0x8($v0)
    /* D22EC 800E1AEC 0C004D8C */  lw         $t5, 0xC($v0)
    /* D22F0 800E1AF0 10004E8C */  lw         $t6, 0x10($v0)
    /* D22F4 800E1AF4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* D22F8 800E1AF8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* D22FC 800E1AFC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* D2300 800E1B00 0500C010 */  beqz       $a2, .L800E1B18
    /* D2304 800E1B04 00000000 */   nop
    /* D2308 800E1B08 D386030C */  jal        TrsProj_SetPsxTrans__FP8coorddef
    /* D230C 800E1B0C 2120C000 */   addu      $a0, $a2, $zero
    /* D2310 800E1B10 CF860308 */  j          .L800E1B3C
    /* D2314 800E1B14 00000000 */   nop
  .L800E1B18:
    /* D2318 800E1B18 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* D231C 800E1B1C 2800A0AF */  sw         $zero, 0x28($sp)
    /* D2320 800E1B20 2400A0AF */  sw         $zero, 0x24($sp)
    /* D2324 800E1B24 14004C8C */  lw         $t4, 0x14($v0)
    /* D2328 800E1B28 18004D8C */  lw         $t5, 0x18($v0)
    /* D232C 800E1B2C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* D2330 800E1B30 1C004E8C */  lw         $t6, 0x1C($v0)
    /* D2334 800E1B34 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* D2338 800E1B38 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800E1B3C:
    /* D233C 800E1B3C 3000BF8F */  lw         $ra, 0x30($sp)
    /* D2340 800E1B40 00000000 */  nop
    /* D2344 800E1B44 0800E003 */  jr         $ra
    /* D2348 800E1B48 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
