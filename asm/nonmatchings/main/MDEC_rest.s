.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MDEC_rest, 0xF0

glabel MDEC_rest
    /* E92F8 800F8AF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E92FC 800F8AFC 21288000 */  addu       $a1, $a0, $zero
    /* E9300 800F8B00 0600A010 */  beqz       $a1, .L800F8B1C
    /* E9304 800F8B04 1000BFAF */   sw        $ra, 0x10($sp)
    /* E9308 800F8B08 01000224 */  addiu      $v0, $zero, 0x1
    /* E930C 800F8B0C 1B00A210 */  beq        $a1, $v0, .L800F8B7C
    /* E9310 800F8B10 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E9314 800F8B14 F3E20308 */  j          .L800F8BCC
    /* E9318 800F8B18 00000000 */   nop
  .L800F8B1C:
    /* E931C 800F8B1C 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E9320 800F8B20 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E9324 800F8B24 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E9328 800F8B28 000062AC */  sw         $v0, 0x0($v1)
    /* E932C 800F8B2C 1380023C */  lui        $v0, %hi(D_80136C10)
    /* E9330 800F8B30 106C428C */  lw         $v0, %lo(D_80136C10)($v0)
    /* E9334 800F8B34 1380043C */  lui        $a0, %hi(D_80136AF8)
    /* E9338 800F8B38 F86A8424 */  addiu      $a0, $a0, %lo(D_80136AF8)
    /* E933C 800F8B3C 000040AC */  sw         $zero, 0x0($v0)
    /* E9340 800F8B40 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E9344 800F8B44 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E9348 800F8B48 20000524 */  addiu      $a1, $zero, 0x20
    /* E934C 800F8B4C 000040AC */  sw         $zero, 0x0($v0)
    /* E9350 800F8B50 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E9354 800F8B54 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E9358 800F8B58 0060023C */  lui        $v0, (0x60000000 >> 16)
    /* E935C 800F8B5C FAE2030C */  jal        _MDEC_in_dma
    /* E9360 800F8B60 000062AC */   sw        $v0, 0x0($v1)
    /* E9364 800F8B64 1380043C */  lui        $a0, %hi(D_80136B7C)
    /* E9368 800F8B68 7C6B8424 */  addiu      $a0, $a0, %lo(D_80136B7C)
    /* E936C 800F8B6C FAE2030C */  jal        _MDEC_in_dma
    /* E9370 800F8B70 20000524 */   addiu     $a1, $zero, 0x20
    /* E9374 800F8B74 F6E20308 */  j          .L800F8BD8
    /* E9378 800F8B78 00000000 */   nop
  .L800F8B7C:
    /* E937C 800F8B7C 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E9380 800F8B80 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E9384 800F8B84 00000000 */  nop
    /* E9388 800F8B88 000062AC */  sw         $v0, 0x0($v1)
    /* E938C 800F8B8C 1380023C */  lui        $v0, %hi(D_80136C10)
    /* E9390 800F8B90 106C428C */  lw         $v0, %lo(D_80136C10)($v0)
    /* E9394 800F8B94 00000000 */  nop
    /* E9398 800F8B98 000040AC */  sw         $zero, 0x0($v0)
    /* E939C 800F8B9C 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E93A0 800F8BA0 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E93A4 800F8BA4 00000000 */  nop
    /* E93A8 800F8BA8 000040AC */  sw         $zero, 0x0($v0)
    /* E93AC 800F8BAC 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E93B0 800F8BB0 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E93B4 800F8BB4 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E93B8 800F8BB8 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E93BC 800F8BBC 0000428C */  lw         $v0, 0x0($v0)
    /* E93C0 800F8BC0 0060023C */  lui        $v0, (0x60000000 >> 16)
    /* E93C4 800F8BC4 F6E20308 */  j          .L800F8BD8
    /* E93C8 800F8BC8 000062AC */   sw        $v0, 0x0($v1)
  .L800F8BCC:
    /* E93CC 800F8BCC 0580043C */  lui        $a0, %hi(D_80057130)
    /* E93D0 800F8BD0 2B0A040C */  jal        printf
    /* E93D4 800F8BD4 30718424 */   addiu     $a0, $a0, %lo(D_80057130)
  .L800F8BD8:
    /* E93D8 800F8BD8 1000BF8F */  lw         $ra, 0x10($sp)
    /* E93DC 800F8BDC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E93E0 800F8BE0 0800E003 */  jr         $ra
    /* E93E4 800F8BE4 00000000 */   nop
endlabel MDEC_rest
