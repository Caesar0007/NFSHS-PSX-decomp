.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _read_issue, 0x1E8

glabel _read_issue
    /* F93F4 80108BF4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F93F8 80108BF8 2000B2AF */  sw         $s2, 0x20($sp)
    /* F93FC 80108BFC 21908000 */  addu       $s2, $a0, $zero
    /* F9400 80108C00 21200000 */  addu       $a0, $zero, $zero
    /* F9404 80108C04 2400BFAF */  sw         $ra, 0x24($sp)
    /* F9408 80108C08 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F940C 80108C0C 23DE030C */  jal        CdSyncCallback
    /* F9410 80108C10 1800B0AF */   sw        $s0, 0x18($sp)
    /* F9414 80108C14 28DE030C */  jal        CdReadyCallback
    /* F9418 80108C18 21200000 */   addu      $a0, $zero, $zero
    /* F941C 80108C1C 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F9420 80108C20 D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F9424 80108C24 00000000 */  nop
    /* F9428 80108C28 01004230 */  andi       $v0, $v0, 0x1
    /* F942C 80108C2C 03004010 */  beqz       $v0, .L80108C3C
    /* F9430 80108C30 00000000 */   nop
    /* F9434 80108C34 2CDF030C */  jal        CdDataCallback
    /* F9438 80108C38 21200000 */   addu      $a0, $zero, $zero
  .L80108C3C:
    /* F943C 80108C3C E0DD030C */  jal        CdStatus
    /* F9440 80108C40 00000000 */   nop
    /* F9444 80108C44 10004230 */  andi       $v0, $v0, 0x10
    /* F9448 80108C48 16004010 */  beqz       $v0, .L80108CA4
    /* F944C 80108C4C 00000000 */   nop
    /* F9450 80108C50 C7C8030C */  jal        VSync
    /* F9454 80108C54 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9458 80108C58 3F004230 */  andi       $v0, $v0, 0x3F
    /* F945C 80108C5C 05004014 */  bnez       $v0, .L80108C74
    /* F9460 80108C60 01000424 */   addiu     $a0, $zero, 0x1
    /* F9464 80108C64 0580043C */  lui        $a0, %hi(D_800578B0)
    /* F9468 80108C68 33A0030C */  jal        puts
    /* F946C 80108C6C B0788424 */   addiu     $a0, $a0, %lo(D_800578B0)
    /* F9470 80108C70 01000424 */  addiu      $a0, $zero, 0x1
  .L80108C74:
    /* F9474 80108C74 7CDE030C */  jal        CdControlF
    /* F9478 80108C78 21280000 */   addu      $a1, $zero, $zero
    /* F947C 80108C7C C7C8030C */  jal        VSync
    /* F9480 80108C80 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9484 80108C84 1480033C */  lui        $v1, %hi(D_8013C290)
    /* F9488 80108C88 90C26324 */  addiu      $v1, $v1, %lo(D_8013C290)
    /* F948C 80108C8C 1C0062AC */  sw         $v0, 0x1C($v1)
    /* F9490 80108C90 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F9494 80108C94 140062AC */  sw         $v0, 0x14($v1)
    /* F9498 80108C98 1400628C */  lw         $v0, 0x14($v1)
    /* F949C 80108C9C 71230408 */  j          .L80108DC4
    /* F94A0 80108CA0 00000000 */   nop
  .L80108CA4:
    /* F94A4 80108CA4 10004012 */  beqz       $s2, .L80108CE8
    /* F94A8 80108CA8 00000000 */   nop
    /* F94AC 80108CAC 0580043C */  lui        $a0, %hi(D_800578C8)
    /* F94B0 80108CB0 33A0030C */  jal        puts
    /* F94B4 80108CB4 C8788424 */   addiu     $a0, $a0, %lo(D_800578C8)
    /* F94B8 80108CB8 09000424 */  addiu      $a0, $zero, 0x9
    /* F94BC 80108CBC 21280000 */  addu       $a1, $zero, $zero
    /* F94C0 80108CC0 2DDE030C */  jal        CdControl
    /* F94C4 80108CC4 21300000 */   addu      $a2, $zero, $zero
    /* F94C8 80108CC8 E8DD030C */  jal        CdLastPos
    /* F94CC 80108CCC 00000000 */   nop
    /* F94D0 80108CD0 02000424 */  addiu      $a0, $zero, 0x2
    /* F94D4 80108CD4 21284000 */  addu       $a1, $v0, $zero
    /* F94D8 80108CD8 2DDE030C */  jal        CdControl
    /* F94DC 80108CDC 21300000 */   addu      $a2, $zero, $zero
    /* F94E0 80108CE0 13004010 */  beqz       $v0, .L80108D30
    /* F94E4 80108CE4 00000000 */   nop
  .L80108CE8:
    /* F94E8 80108CE8 06DE030C */  jal        CdFlush
    /* F94EC 80108CEC 00000000 */   nop
    /* F94F0 80108CF0 1480113C */  lui        $s1, %hi(D_8013C29C)
    /* F94F4 80108CF4 9CC23126 */  addiu      $s1, $s1, %lo(D_8013C29C)
    /* F94F8 80108CF8 0000308E */  lw         $s0, 0x0($s1)
    /* F94FC 80108CFC 00000000 */  nop
    /* F9500 80108D00 1000B0A3 */  sb         $s0, 0x10($sp)
    /* F9504 80108D04 E4DD030C */  jal        CdMode
    /* F9508 80108D08 FF001032 */   andi      $s0, $s0, 0xFF
    /* F950C 80108D0C 03000216 */  bne        $s0, $v0, .L80108D1C
    /* F9510 80108D10 0E000424 */   addiu     $a0, $zero, 0xE
    /* F9514 80108D14 0D004012 */  beqz       $s2, .L80108D4C
    /* F9518 80108D18 00000000 */   nop
  .L80108D1C:
    /* F951C 80108D1C 1000A527 */  addiu      $a1, $sp, 0x10
    /* F9520 80108D20 2DDE030C */  jal        CdControl
    /* F9524 80108D24 21300000 */   addu      $a2, $zero, $zero
    /* F9528 80108D28 08004014 */  bnez       $v0, .L80108D4C
    /* F952C 80108D2C 00000000 */   nop
  .L80108D30:
    /* F9530 80108D30 1480023C */  lui        $v0, %hi(D_8013C290)
    /* F9534 80108D34 90C24224 */  addiu      $v0, $v0, %lo(D_8013C290)
    /* F9538 80108D38 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* F953C 80108D3C 140043AC */  sw         $v1, 0x14($v0)
    /* F9540 80108D40 1400428C */  lw         $v0, 0x14($v0)
    /* F9544 80108D44 71230408 */  j          .L80108DC4
    /* F9548 80108D48 00000000 */   nop
  .L80108D4C:
    /* F954C 80108D4C E8DD030C */  jal        CdLastPos
    /* F9550 80108D50 00000000 */   nop
    /* F9554 80108D54 7EDF030C */  jal        CdPosToInt
    /* F9558 80108D58 21204000 */   addu      $a0, $v0, $zero
    /* F955C 80108D5C 1180043C */  lui        $a0, %hi(_read_int)
    /* F9560 80108D60 B0888424 */  addiu      $a0, $a0, %lo(_read_int)
    /* F9564 80108D64 1480103C */  lui        $s0, %hi(D_8013C290)
    /* F9568 80108D68 90C21026 */  addiu      $s0, $s0, %lo(D_8013C290)
    /* F956C 80108D6C 28DE030C */  jal        CdReadyCallback
    /* F9570 80108D70 200002AE */   sw        $v0, 0x20($s0)
    /* F9574 80108D74 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F9578 80108D78 D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F957C 80108D7C 00000000 */  nop
    /* F9580 80108D80 01004230 */  andi       $v0, $v0, 0x1
    /* F9584 80108D84 05004010 */  beqz       $v0, .L80108D9C
    /* F9588 80108D88 06000424 */   addiu     $a0, $zero, 0x6
    /* F958C 80108D8C 1180043C */  lui        $a0, %hi(_read_data_int)
    /* F9590 80108D90 2CDF030C */  jal        CdDataCallback
    /* F9594 80108D94 248B8424 */   addiu     $a0, $a0, %lo(_read_data_int)
    /* F9598 80108D98 06000424 */  addiu      $a0, $zero, 0x6
  .L80108D9C:
    /* F959C 80108D9C 0400028E */  lw         $v0, 0x4($s0)
    /* F95A0 80108DA0 21280000 */  addu       $a1, $zero, $zero
    /* F95A4 80108DA4 7CDE030C */  jal        CdControlF
    /* F95A8 80108DA8 080002AE */   sw        $v0, 0x8($s0)
    /* F95AC 80108DAC 0000028E */  lw         $v0, 0x0($s0)
    /* F95B0 80108DB0 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* F95B4 80108DB4 C7C8030C */  jal        VSync
    /* F95B8 80108DB8 140002AE */   sw        $v0, 0x14($s0)
    /* F95BC 80108DBC 180002AE */  sw         $v0, 0x18($s0)
    /* F95C0 80108DC0 1400028E */  lw         $v0, 0x14($s0)
  .L80108DC4:
    /* F95C4 80108DC4 2400BF8F */  lw         $ra, 0x24($sp)
    /* F95C8 80108DC8 2000B28F */  lw         $s2, 0x20($sp)
    /* F95CC 80108DCC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F95D0 80108DD0 1800B08F */  lw         $s0, 0x18($sp)
    /* F95D4 80108DD4 0800E003 */  jr         $ra
    /* F95D8 80108DD8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _read_issue
