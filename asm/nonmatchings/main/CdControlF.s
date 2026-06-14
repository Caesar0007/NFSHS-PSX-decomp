.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdControlF, 0x134

glabel CdControlF
    /* E81F0 800F79F0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* E81F4 800F79F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* E81F8 800F79F8 2188A000 */  addu       $s1, $a1, $zero
    /* E81FC 800F79FC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E8200 800F7A00 21988000 */  addu       $s3, $a0, $zero
    /* E8204 800F7A04 1000B0AF */  sw         $s0, 0x10($sp)
    /* E8208 800F7A08 03001024 */  addiu      $s0, $zero, 0x3
    /* E820C 800F7A0C 3000BEAF */  sw         $fp, 0x30($sp)
    /* E8210 800F7A10 01001E24 */  addiu      $fp, $zero, 0x1
    /* E8214 800F7A14 1800B2AF */  sw         $s2, 0x18($sp)
    /* E8218 800F7A18 FF007232 */  andi       $s2, $s3, 0xFF
    /* E821C 800F7A1C 1380033C */  lui        $v1, %hi(D_80136A18)
    /* E8220 800F7A20 186A6324 */  addiu      $v1, $v1, %lo(D_80136A18)
    /* E8224 800F7A24 2000B4AF */  sw         $s4, 0x20($sp)
    /* E8228 800F7A28 1480143C */  lui        $s4, %hi(CD_cbsync)
    /* E822C 800F7A2C 48BF948E */  lw         $s4, %lo(CD_cbsync)($s4)
    /* E8230 800F7A30 80101200 */  sll        $v0, $s2, 2
    /* E8234 800F7A34 2400B5AF */  sw         $s5, 0x24($sp)
    /* E8238 800F7A38 21A84300 */  addu       $s5, $v0, $v1
    /* E823C 800F7A3C 2800B6AF */  sw         $s6, 0x28($sp)
    /* E8240 800F7A40 21B00000 */  addu       $s6, $zero, $zero
    /* E8244 800F7A44 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* E8248 800F7A48 FFFF1724 */  addiu      $s7, $zero, -0x1
    /* E824C 800F7A4C 3400BFAF */  sw         $ra, 0x34($sp)
  .L800F7A50:
    /* E8250 800F7A50 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E8254 800F7A54 0B005E12 */  beq        $s2, $fp, .L800F7A84
    /* E8258 800F7A58 48BF20AC */   sw        $zero, %lo(CD_cbsync)($at)
    /* E825C 800F7A5C 1480023C */  lui        $v0, %hi(CD_status)
    /* E8260 800F7A60 54BF4290 */  lbu        $v0, %lo(CD_status)($v0)
    /* E8264 800F7A64 00000000 */  nop
    /* E8268 800F7A68 10004230 */  andi       $v0, $v0, 0x10
    /* E826C 800F7A6C 05004010 */  beqz       $v0, .L800F7A84
    /* E8270 800F7A70 01000424 */   addiu     $a0, $zero, 0x1
    /* E8274 800F7A74 21280000 */  addu       $a1, $zero, $zero
    /* E8278 800F7A78 21300000 */  addu       $a2, $zero, $zero
    /* E827C 800F7A7C C91E040C */  jal        CD_cw
    /* E8280 800F7A80 21380000 */   addu      $a3, $zero, $zero
  .L800F7A84:
    /* E8284 800F7A84 0B002012 */  beqz       $s1, .L800F7AB4
    /* E8288 800F7A88 00000000 */   nop
    /* E828C 800F7A8C 0000A28E */  lw         $v0, 0x0($s5)
    /* E8290 800F7A90 00000000 */  nop
    /* E8294 800F7A94 07004010 */  beqz       $v0, .L800F7AB4
    /* E8298 800F7A98 02000424 */   addiu     $a0, $zero, 0x2
    /* E829C 800F7A9C 21282002 */  addu       $a1, $s1, $zero
    /* E82A0 800F7AA0 21300000 */  addu       $a2, $zero, $zero
    /* E82A4 800F7AA4 C91E040C */  jal        CD_cw
    /* E82A8 800F7AA8 21380000 */   addu      $a3, $zero, $zero
    /* E82AC 800F7AAC 0A004014 */  bnez       $v0, .L800F7AD8
    /* E82B0 800F7AB0 00000000 */   nop
  .L800F7AB4:
    /* E82B4 800F7AB4 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E82B8 800F7AB8 48BF34AC */  sw         $s4, %lo(CD_cbsync)($at)
    /* E82BC 800F7ABC FF006432 */  andi       $a0, $s3, 0xFF
    /* E82C0 800F7AC0 21282002 */  addu       $a1, $s1, $zero
    /* E82C4 800F7AC4 21300000 */  addu       $a2, $zero, $zero
    /* E82C8 800F7AC8 C91E040C */  jal        CD_cw
    /* E82CC 800F7ACC 01000724 */   addiu     $a3, $zero, 0x1
    /* E82D0 800F7AD0 08004010 */  beqz       $v0, .L800F7AF4
    /* E82D4 800F7AD4 0100C226 */   addiu     $v0, $s6, 0x1
  .L800F7AD8:
    /* E82D8 800F7AD8 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E82DC 800F7ADC DCFF1716 */  bne        $s0, $s7, .L800F7A50
    /* E82E0 800F7AE0 00000000 */   nop
    /* E82E4 800F7AE4 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E82E8 800F7AE8 48BF34AC */  sw         $s4, %lo(CD_cbsync)($at)
    /* E82EC 800F7AEC FFFF1624 */  addiu      $s6, $zero, -0x1
    /* E82F0 800F7AF0 0100C226 */  addiu      $v0, $s6, 0x1
  .L800F7AF4:
    /* E82F4 800F7AF4 3400BF8F */  lw         $ra, 0x34($sp)
    /* E82F8 800F7AF8 3000BE8F */  lw         $fp, 0x30($sp)
    /* E82FC 800F7AFC 2C00B78F */  lw         $s7, 0x2C($sp)
    /* E8300 800F7B00 2800B68F */  lw         $s6, 0x28($sp)
    /* E8304 800F7B04 2400B58F */  lw         $s5, 0x24($sp)
    /* E8308 800F7B08 2000B48F */  lw         $s4, 0x20($sp)
    /* E830C 800F7B0C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E8310 800F7B10 1800B28F */  lw         $s2, 0x18($sp)
    /* E8314 800F7B14 1400B18F */  lw         $s1, 0x14($sp)
    /* E8318 800F7B18 1000B08F */  lw         $s0, 0x10($sp)
    /* E831C 800F7B1C 0800E003 */  jr         $ra
    /* E8320 800F7B20 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CdControlF
