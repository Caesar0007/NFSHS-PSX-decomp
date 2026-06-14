.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDautovol, 0x11C

glabel SNDautovol
    /* D8AD0 800E82D0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D8AD4 800E82D4 1800B0AF */  sw         $s0, 0x18($sp)
    /* D8AD8 800E82D8 21808000 */  addu       $s0, $a0, $zero
    /* D8ADC 800E82DC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D8AE0 800E82E0 2188A000 */  addu       $s1, $a1, $zero
    /* D8AE4 800E82E4 1480023C */  lui        $v0, %hi(sndgs)
    /* D8AE8 800E82E8 2400B3AF */  sw         $s3, 0x24($sp)
    /* D8AEC 800E82EC 60785324 */  addiu      $s3, $v0, %lo(sndgs)
    /* D8AF0 800E82F0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* D8AF4 800E82F4 2800B4AF */  sw         $s4, 0x28($sp)
    /* D8AF8 800E82F8 2000B2AF */  sw         $s2, 0x20($sp)
    /* D8AFC 800E82FC 3C006282 */  lb         $v0, 0x3C($s3)
    /* D8B00 800E8300 00000000 */  nop
    /* D8B04 800E8304 03004014 */  bnez       $v0, .L800E8314
    /* D8B08 800E8308 21A0C000 */   addu      $s4, $a2, $zero
    /* D8B0C 800E830C F3A00308 */  j          .L800E83CC
    /* D8B10 800E8310 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E8314:
    /* D8B14 800E8314 4DA9030C */  jal        iSNDenteraudio
    /* D8B18 800E8318 00000000 */   nop
    /* D8B1C 800E831C 71FB030C */  jal        iSNDgetchan
    /* D8B20 800E8320 21200002 */   addu      $a0, $s0, $zero
    /* D8B24 800E8324 21904000 */  addu       $s2, $v0, $zero
    /* D8B28 800E8328 25004006 */  bltz       $s2, .L800E83C0
    /* D8B2C 800E832C 00000000 */   nop
    /* D8B30 800E8330 0200201E */  bgtz       $s1, .L800E833C
    /* D8B34 800E8334 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D8B38 800E8338 01001124 */  addiu      $s1, $zero, 0x1
  .L800E833C:
    /* D8B3C 800E833C 1000A2AF */  sw         $v0, 0x10($sp)
    /* D8B40 800E8340 00841400 */  sll        $s0, $s4, 16
  .L800E8344:
    /* D8B44 800E8344 21204002 */  addu       $a0, $s2, $zero
    /* D8B48 800E8348 D3FB030C */  jal        iSNDpatchkey
    /* D8B4C 800E834C 1000A527 */   addiu     $a1, $sp, 0x10
    /* D8B50 800E8350 1B004010 */  beqz       $v0, .L800E83C0
    /* D8B54 800E8354 00000000 */   nop
    /* D8B58 800E8358 1000A38F */  lw         $v1, 0x10($sp)
    /* D8B5C 800E835C 00000000 */  nop
    /* D8B60 800E8360 40100300 */  sll        $v0, $v1, 1
    /* D8B64 800E8364 21104300 */  addu       $v0, $v0, $v1
    /* D8B68 800E8368 C0100200 */  sll        $v0, $v0, 3
    /* D8B6C 800E836C 21104300 */  addu       $v0, $v0, $v1
    /* D8B70 800E8370 9400638E */  lw         $v1, 0x94($s3)
    /* D8B74 800E8374 80100200 */  sll        $v0, $v0, 2
    /* D8B78 800E8378 21186200 */  addu       $v1, $v1, $v0
    /* D8B7C 800E837C 1C00628C */  lw         $v0, 0x1C($v1)
    /* D8B80 800E8380 00000000 */  nop
    /* D8B84 800E8384 23100202 */  subu       $v0, $s0, $v0
    /* D8B88 800E8388 1A005100 */  div        $zero, $v0, $s1
    /* D8B8C 800E838C 02002016 */  bnez       $s1, .L800E8398
    /* D8B90 800E8390 00000000 */   nop
    /* D8B94 800E8394 0D000700 */  break      7
  .L800E8398:
    /* D8B98 800E8398 FFFF0124 */  addiu      $at, $zero, -0x1
    /* D8B9C 800E839C 04002116 */  bne        $s1, $at, .L800E83B0
    /* D8BA0 800E83A0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* D8BA4 800E83A4 02004114 */  bne        $v0, $at, .L800E83B0
    /* D8BA8 800E83A8 00000000 */   nop
    /* D8BAC 800E83AC 0D000600 */  break      6
  .L800E83B0:
    /* D8BB0 800E83B0 12100000 */  mflo       $v0
    /* D8BB4 800E83B4 180070AC */  sw         $s0, 0x18($v1)
    /* D8BB8 800E83B8 D1A00308 */  j          .L800E8344
    /* D8BBC 800E83BC 140062AC */   sw        $v0, 0x14($v1)
  .L800E83C0:
    /* D8BC0 800E83C0 5BA9030C */  jal        iSNDleaveaudio
    /* D8BC4 800E83C4 00000000 */   nop
    /* D8BC8 800E83C8 21104002 */  addu       $v0, $s2, $zero
  .L800E83CC:
    /* D8BCC 800E83CC 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* D8BD0 800E83D0 2800B48F */  lw         $s4, 0x28($sp)
    /* D8BD4 800E83D4 2400B38F */  lw         $s3, 0x24($sp)
    /* D8BD8 800E83D8 2000B28F */  lw         $s2, 0x20($sp)
    /* D8BDC 800E83DC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D8BE0 800E83E0 1800B08F */  lw         $s0, 0x18($sp)
    /* D8BE4 800E83E4 0800E003 */  jr         $ra
    /* D8BE8 800E83E8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SNDautovol
