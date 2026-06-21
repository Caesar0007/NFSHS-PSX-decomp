.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _read_data_int, 0xD0

glabel _read_data_int
    /* F9324 80108B24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9328 80108B28 1000B0AF */  sw         $s0, 0x10($sp)
    /* F932C 80108B2C 1480103C */  lui        $s0, %hi(D_8013C290)
    /* F9330 80108B30 90C21026 */  addiu      $s0, $s0, %lo(D_8013C290)
    /* F9334 80108B34 1400BFAF */  sw         $ra, 0x14($sp)
    /* F9338 80108B38 1000028E */  lw         $v0, 0x10($s0)
    /* F933C 80108B3C 0800038E */  lw         $v1, 0x8($s0)
    /* F9340 80108B40 80100200 */  sll        $v0, $v0, 2
    /* F9344 80108B44 21186200 */  addu       $v1, $v1, $v0
    /* F9348 80108B48 080003AE */  sw         $v1, 0x8($s0)
    /* F934C 80108B4C 1400028E */  lw         $v0, 0x14($s0)
    /* F9350 80108B50 00000000 */  nop
    /* F9354 80108B54 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F9358 80108B58 140002AE */  sw         $v0, 0x14($s0)
    /* F935C 80108B5C 2000028E */  lw         $v0, 0x20($s0)
    /* F9360 80108B60 00000000 */  nop
    /* F9364 80108B64 01004224 */  addiu      $v0, $v0, 0x1
    /* F9368 80108B68 200002AE */  sw         $v0, 0x20($s0)
    /* F936C 80108B6C 1400028E */  lw         $v0, 0x14($s0)
    /* F9370 80108B70 00000000 */  nop
    /* F9374 80108B74 1B004014 */  bnez       $v0, .L80108BE4
    /* F9378 80108B78 00000000 */   nop
    /* F937C 80108B7C 2C00048E */  lw         $a0, 0x2C($s0)
    /* F9380 80108B80 28DE030C */  jal        CdReadyCallback
    /* F9384 80108B84 00000000 */   nop
    /* F9388 80108B88 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F938C 80108B8C D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F9390 80108B90 00000000 */  nop
    /* F9394 80108B94 01004230 */  andi       $v0, $v0, 0x1
    /* F9398 80108B98 04004010 */  beqz       $v0, .L80108BAC
    /* F939C 80108B9C 00000000 */   nop
    /* F93A0 80108BA0 3000048E */  lw         $a0, 0x30($s0)
    /* F93A4 80108BA4 2CDF030C */  jal        CdDataCallback
    /* F93A8 80108BA8 00000000 */   nop
  .L80108BAC:
    /* F93AC 80108BAC 1180043C */  lui        $a0, %hi(_read_sync)
    /* F93B0 80108BB0 23DE030C */  jal        CdSyncCallback
    /* F93B4 80108BB4 7C888424 */   addiu     $a0, $a0, %lo(_read_sync)
    /* F93B8 80108BB8 09000424 */  addiu      $a0, $zero, 0x9
    /* F93BC 80108BBC 7CDE030C */  jal        CdControlF
    /* F93C0 80108BC0 21280000 */   addu      $a1, $zero, $zero
    /* F93C4 80108BC4 1480033C */  lui        $v1, %hi(CD_cbread)
    /* F93C8 80108BC8 D0C2638C */  lw         $v1, %lo(CD_cbread)($v1)
    /* F93CC 80108BCC 01000224 */  addiu      $v0, $zero, 0x1
    /* F93D0 80108BD0 04006010 */  beqz       $v1, .L80108BE4
    /* F93D4 80108BD4 240002AE */   sw        $v0, 0x24($s0)
    /* F93D8 80108BD8 3400058E */  lw         $a1, 0x34($s0)
    /* F93DC 80108BDC 09F86000 */  jalr       $v1
    /* F93E0 80108BE0 02000424 */   addiu     $a0, $zero, 0x2
  .L80108BE4:
    /* F93E4 80108BE4 1400BF8F */  lw         $ra, 0x14($sp)
    /* F93E8 80108BE8 1000B08F */  lw         $s0, 0x10($sp)
    /* F93EC 80108BEC 0800E003 */  jr         $ra
    /* F93F0 80108BF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _read_data_int
