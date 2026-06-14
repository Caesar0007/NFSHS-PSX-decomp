.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_LightningAddFork__FScScSc, 0x218

glabel Hrz_LightningAddFork__FScScSc
    /* C09B0 800D01B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C09B4 800D01B4 2000B4AF */  sw         $s4, 0x20($sp)
    /* C09B8 800D01B8 21A08000 */  addu       $s4, $a0, $zero
    /* C09BC 800D01BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* C09C0 800D01C0 2190A000 */  addu       $s2, $a1, $zero
    /* C09C4 800D01C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* C09C8 800D01C8 2180C000 */  addu       $s0, $a2, $zero
    /* C09CC 800D01CC 00360600 */  sll        $a2, $a2, 24
    /* C09D0 800D01D0 03160600 */  sra        $v0, $a2, 24
    /* C09D4 800D01D4 2400BFAF */  sw         $ra, 0x24($sp)
    /* C09D8 800D01D8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C09DC 800D01DC 03004014 */  bnez       $v0, .L800D01EC
    /* C09E0 800D01E0 1400B1AF */   sw        $s1, 0x14($sp)
    /* C09E4 800D01E4 88400308 */  j          .L800D0220
    /* C09E8 800D01E8 03000524 */   addiu     $a1, $zero, 0x3
  .L800D01EC:
    /* C09EC 800D01EC 03004228 */  slti       $v0, $v0, 0x3
    /* C09F0 800D01F0 0B004010 */  beqz       $v0, .L800D0220
    /* C09F4 800D01F4 02000524 */   addiu     $a1, $zero, 0x2
    /* C09F8 800D01F8 EA9D030C */  jal        random
    /* C09FC 800D01FC 00000000 */   nop
    /* C0A00 800D0200 AAAA033C */  lui        $v1, (0xAAAAAAAB >> 16)
    /* C0A04 800D0204 ABAA6334 */  ori        $v1, $v1, (0xAAAAAAAB & 0xFFFF)
    /* C0A08 800D0208 19004300 */  multu      $v0, $v1
    /* C0A0C 800D020C 10380000 */  mfhi       $a3
    /* C0A10 800D0210 42200700 */  srl        $a0, $a3, 1
    /* C0A14 800D0214 40180400 */  sll        $v1, $a0, 1
    /* C0A18 800D0218 21186400 */  addu       $v1, $v1, $a0
    /* C0A1C 800D021C 23284300 */  subu       $a1, $v0, $v1
  .L800D0220:
    /* C0A20 800D0220 1280043C */  lui        $a0, %hi(gHrz_Lightning)
    /* C0A24 800D0224 BC088424 */  addiu      $a0, $a0, %lo(gHrz_Lightning)
    /* C0A28 800D0228 64008390 */  lbu        $v1, 0x64($a0)
    /* C0A2C 800D022C 01001324 */  addiu      $s3, $zero, 0x1
    /* C0A30 800D0230 01006224 */  addiu      $v0, $v1, 0x1
    /* C0A34 800D0234 640082A0 */  sb         $v0, 0x64($a0)
    /* C0A38 800D0238 40100300 */  sll        $v0, $v1, 1
    /* C0A3C 800D023C 21104300 */  addu       $v0, $v0, $v1
    /* C0A40 800D0240 40100200 */  sll        $v0, $v0, 1
    /* C0A44 800D0244 21884400 */  addu       $s1, $v0, $a0
    /* C0A48 800D0248 001E1200 */  sll        $v1, $s2, 24
    /* C0A4C 800D024C 031E0300 */  sra        $v1, $v1, 24
    /* C0A50 800D0250 00110300 */  sll        $v0, $v1, 4
    /* C0A54 800D0254 23104300 */  subu       $v0, $v0, $v1
    /* C0A58 800D0258 001E1000 */  sll        $v1, $s0, 24
    /* C0A5C 800D025C 031E0300 */  sra        $v1, $v1, 24
    /* C0A60 800D0260 000022A6 */  sh         $v0, 0x0($s1)
    /* C0A64 800D0264 00110300 */  sll        $v0, $v1, 4
    /* C0A68 800D0268 23104300 */  subu       $v0, $v0, $v1
    /* C0A6C 800D026C FF00A330 */  andi       $v1, $a1, 0xFF
    /* C0A70 800D0270 1D007310 */  beq        $v1, $s3, .L800D02E8
    /* C0A74 800D0274 020022A6 */   sh        $v0, 0x2($s1)
    /* C0A78 800D0278 02006228 */  slti       $v0, $v1, 0x2
    /* C0A7C 800D027C 05004010 */  beqz       $v0, .L800D0294
    /* C0A80 800D0280 00000000 */   nop
    /* C0A84 800D0284 0B006010 */  beqz       $v1, .L800D02B4
    /* C0A88 800D0288 00261400 */   sll       $a0, $s4, 24
    /* C0A8C 800D028C E4400308 */  j          .L800D0390
    /* C0A90 800D0290 00161400 */   sll       $v0, $s4, 24
  .L800D0294:
    /* C0A94 800D0294 02000224 */  addiu      $v0, $zero, 0x2
    /* C0A98 800D0298 24006210 */  beq        $v1, $v0, .L800D032C
    /* C0A9C 800D029C 00000000 */   nop
    /* C0AA0 800D02A0 03000224 */  addiu      $v0, $zero, 0x3
    /* C0AA4 800D02A4 26006210 */  beq        $v1, $v0, .L800D0340
    /* C0AA8 800D02A8 00161400 */   sll       $v0, $s4, 24
    /* C0AAC 800D02AC E4400308 */  j          .L800D0390
    /* C0AB0 800D02B0 00000000 */   nop
  .L800D02B4:
    /* C0AB4 800D02B4 03260400 */  sra        $a0, $a0, 24
    /* C0AB8 800D02B8 21285402 */  addu       $a1, $s2, $s4
    /* C0ABC 800D02BC 002E0500 */  sll        $a1, $a1, 24
    /* C0AC0 800D02C0 032E0500 */  sra        $a1, $a1, 24
    /* C0AC4 800D02C4 01000626 */  addiu      $a2, $s0, 0x1
    /* C0AC8 800D02C8 00360600 */  sll        $a2, $a2, 24
    /* C0ACC 800D02CC 6C40030C */  jal        Hrz_LightningAddFork__FScScSc
    /* C0AD0 800D02D0 03360600 */   sra       $a2, $a2, 24
    /* C0AD4 800D02D4 EA9D030C */  jal        random
    /* C0AD8 800D02D8 00000000 */   nop
    /* C0ADC 800D02DC 01004230 */  andi       $v0, $v0, 0x1
    /* C0AE0 800D02E0 E2400308 */  j          .L800D0388
    /* C0AE4 800D02E4 02004224 */   addiu     $v0, $v0, 0x2
  .L800D02E8:
    /* C0AE8 800D02E8 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* C0AEC 800D02EC 21284402 */  addu       $a1, $s2, $a0
    /* C0AF0 800D02F0 002E0500 */  sll        $a1, $a1, 24
    /* C0AF4 800D02F4 032E0500 */  sra        $a1, $a1, 24
    /* C0AF8 800D02F8 01001026 */  addiu      $s0, $s0, 0x1
    /* C0AFC 800D02FC 00861000 */  sll        $s0, $s0, 24
    /* C0B00 800D0300 03861000 */  sra        $s0, $s0, 24
    /* C0B04 800D0304 6C40030C */  jal        Hrz_LightningAddFork__FScScSc
    /* C0B08 800D0308 21300002 */   addu      $a2, $s0, $zero
    /* C0B0C 800D030C 01000424 */  addiu      $a0, $zero, 0x1
    /* C0B10 800D0310 21284402 */  addu       $a1, $s2, $a0
    /* C0B14 800D0314 002E0500 */  sll        $a1, $a1, 24
    /* C0B18 800D0318 032E0500 */  sra        $a1, $a1, 24
    /* C0B1C 800D031C 6C40030C */  jal        Hrz_LightningAddFork__FScScSc
    /* C0B20 800D0320 21300002 */   addu      $a2, $s0, $zero
    /* C0B24 800D0324 E2400308 */  j          .L800D0388
    /* C0B28 800D0328 06000224 */   addiu     $v0, $zero, 0x6
  .L800D032C:
    /* C0B2C 800D032C EA9D030C */  jal        random
    /* C0B30 800D0330 00000000 */   nop
    /* C0B34 800D0334 01004230 */  andi       $v0, $v0, 0x1
    /* C0B38 800D0338 E2400308 */  j          .L800D0388
    /* C0B3C 800D033C 04004224 */   addiu     $v0, $v0, 0x4
  .L800D0340:
    /* C0B40 800D0340 EA9D030C */  jal        random
    /* C0B44 800D0344 00000000 */   nop
    /* C0B48 800D0348 01004230 */  andi       $v0, $v0, 0x1
    /* C0B4C 800D034C 40100200 */  sll        $v0, $v0, 1
    /* C0B50 800D0350 23106202 */  subu       $v0, $s3, $v0
    /* C0B54 800D0354 21A04000 */  addu       $s4, $v0, $zero
    /* C0B58 800D0358 00260200 */  sll        $a0, $v0, 24
    /* C0B5C 800D035C 03260400 */  sra        $a0, $a0, 24
    /* C0B60 800D0360 21104202 */  addu       $v0, $s2, $v0
    /* C0B64 800D0364 00160200 */  sll        $v0, $v0, 24
    /* C0B68 800D0368 032E0200 */  sra        $a1, $v0, 24
    /* C0B6C 800D036C 01000626 */  addiu      $a2, $s0, 0x1
    /* C0B70 800D0370 00360600 */  sll        $a2, $a2, 24
    /* C0B74 800D0374 6C40030C */  jal        Hrz_LightningAddFork__FScScSc
    /* C0B78 800D0378 03360600 */   sra       $a2, $a2, 24
    /* C0B7C 800D037C EA9D030C */  jal        random
    /* C0B80 800D0380 00000000 */   nop
    /* C0B84 800D0384 01004230 */  andi       $v0, $v0, 0x1
  .L800D0388:
    /* C0B88 800D0388 040022A2 */  sb         $v0, 0x4($s1)
    /* C0B8C 800D038C 00161400 */  sll        $v0, $s4, 24
  .L800D0390:
    /* C0B90 800D0390 05004104 */  bgez       $v0, .L800D03A8
    /* C0B94 800D0394 00000000 */   nop
    /* C0B98 800D0398 04002292 */  lbu        $v0, 0x4($s1)
    /* C0B9C 800D039C 00000000 */  nop
    /* C0BA0 800D03A0 08004224 */  addiu      $v0, $v0, 0x8
    /* C0BA4 800D03A4 040022A2 */  sb         $v0, 0x4($s1)
  .L800D03A8:
    /* C0BA8 800D03A8 2400BF8F */  lw         $ra, 0x24($sp)
    /* C0BAC 800D03AC 2000B48F */  lw         $s4, 0x20($sp)
    /* C0BB0 800D03B0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C0BB4 800D03B4 1800B28F */  lw         $s2, 0x18($sp)
    /* C0BB8 800D03B8 1400B18F */  lw         $s1, 0x14($sp)
    /* C0BBC 800D03BC 1000B08F */  lw         $s0, 0x10($sp)
    /* C0BC0 800D03C0 0800E003 */  jr         $ra
    /* C0BC4 800D03C4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hrz_LightningAddFork__FScScSc
