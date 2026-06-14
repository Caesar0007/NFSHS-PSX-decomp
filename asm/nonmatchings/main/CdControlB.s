.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdControlB, 0x14C

glabel CdControlB
    /* E8324 800F7B24 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* E8328 800F7B28 1400B1AF */  sw         $s1, 0x14($sp)
    /* E832C 800F7B2C 2188A000 */  addu       $s1, $a1, $zero
    /* E8330 800F7B30 1800B2AF */  sw         $s2, 0x18($sp)
    /* E8334 800F7B34 2190C000 */  addu       $s2, $a2, $zero
    /* E8338 800F7B38 2000B4AF */  sw         $s4, 0x20($sp)
    /* E833C 800F7B3C 21A08000 */  addu       $s4, $a0, $zero
    /* E8340 800F7B40 1000B0AF */  sw         $s0, 0x10($sp)
    /* E8344 800F7B44 03001024 */  addiu      $s0, $zero, 0x3
    /* E8348 800F7B48 3000BEAF */  sw         $fp, 0x30($sp)
    /* E834C 800F7B4C 01001E24 */  addiu      $fp, $zero, 0x1
    /* E8350 800F7B50 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E8354 800F7B54 FF009332 */  andi       $s3, $s4, 0xFF
    /* E8358 800F7B58 1380033C */  lui        $v1, %hi(D_80136A18)
    /* E835C 800F7B5C 186A6324 */  addiu      $v1, $v1, %lo(D_80136A18)
    /* E8360 800F7B60 2400B5AF */  sw         $s5, 0x24($sp)
    /* E8364 800F7B64 1480153C */  lui        $s5, %hi(CD_cbsync)
    /* E8368 800F7B68 48BFB58E */  lw         $s5, %lo(CD_cbsync)($s5)
    /* E836C 800F7B6C 80101300 */  sll        $v0, $s3, 2
    /* E8370 800F7B70 2800B6AF */  sw         $s6, 0x28($sp)
    /* E8374 800F7B74 21B04300 */  addu       $s6, $v0, $v1
    /* E8378 800F7B78 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* E837C 800F7B7C FFFF1724 */  addiu      $s7, $zero, -0x1
    /* E8380 800F7B80 3400BFAF */  sw         $ra, 0x34($sp)
  .L800F7B84:
    /* E8384 800F7B84 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E8388 800F7B88 0B007E12 */  beq        $s3, $fp, .L800F7BB8
    /* E838C 800F7B8C 48BF20AC */   sw        $zero, %lo(CD_cbsync)($at)
    /* E8390 800F7B90 1480023C */  lui        $v0, %hi(CD_status)
    /* E8394 800F7B94 54BF4290 */  lbu        $v0, %lo(CD_status)($v0)
    /* E8398 800F7B98 00000000 */  nop
    /* E839C 800F7B9C 10004230 */  andi       $v0, $v0, 0x10
    /* E83A0 800F7BA0 05004010 */  beqz       $v0, .L800F7BB8
    /* E83A4 800F7BA4 01000424 */   addiu     $a0, $zero, 0x1
    /* E83A8 800F7BA8 21280000 */  addu       $a1, $zero, $zero
    /* E83AC 800F7BAC 21300000 */  addu       $a2, $zero, $zero
    /* E83B0 800F7BB0 C91E040C */  jal        CD_cw
    /* E83B4 800F7BB4 21380000 */   addu      $a3, $zero, $zero
  .L800F7BB8:
    /* E83B8 800F7BB8 0B002012 */  beqz       $s1, .L800F7BE8
    /* E83BC 800F7BBC 00000000 */   nop
    /* E83C0 800F7BC0 0000C28E */  lw         $v0, 0x0($s6)
    /* E83C4 800F7BC4 00000000 */  nop
    /* E83C8 800F7BC8 07004010 */  beqz       $v0, .L800F7BE8
    /* E83CC 800F7BCC 02000424 */   addiu     $a0, $zero, 0x2
    /* E83D0 800F7BD0 21282002 */  addu       $a1, $s1, $zero
    /* E83D4 800F7BD4 21304002 */  addu       $a2, $s2, $zero
    /* E83D8 800F7BD8 C91E040C */  jal        CD_cw
    /* E83DC 800F7BDC 21380000 */   addu      $a3, $zero, $zero
    /* E83E0 800F7BE0 0A004014 */  bnez       $v0, .L800F7C0C
    /* E83E4 800F7BE4 00000000 */   nop
  .L800F7BE8:
    /* E83E8 800F7BE8 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E83EC 800F7BEC 48BF35AC */  sw         $s5, %lo(CD_cbsync)($at)
    /* E83F0 800F7BF0 FF008432 */  andi       $a0, $s4, 0xFF
    /* E83F4 800F7BF4 21282002 */  addu       $a1, $s1, $zero
    /* E83F8 800F7BF8 21304002 */  addu       $a2, $s2, $zero
    /* E83FC 800F7BFC C91E040C */  jal        CD_cw
    /* E8400 800F7C00 21380000 */   addu      $a3, $zero, $zero
    /* E8404 800F7C04 06004010 */  beqz       $v0, .L800F7C20
    /* E8408 800F7C08 21100000 */   addu      $v0, $zero, $zero
  .L800F7C0C:
    /* E840C 800F7C0C FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E8410 800F7C10 DCFF1716 */  bne        $s0, $s7, .L800F7B84
    /* E8414 800F7C14 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E8418 800F7C18 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E841C 800F7C1C 48BF35AC */  sw         $s5, %lo(CD_cbsync)($at)
  .L800F7C20:
    /* E8420 800F7C20 06004014 */  bnez       $v0, .L800F7C3C
    /* E8424 800F7C24 21200000 */   addu      $a0, $zero, $zero
    /* E8428 800F7C28 771D040C */  jal        CD_sync
    /* E842C 800F7C2C 21284002 */   addu      $a1, $s2, $zero
    /* E8430 800F7C30 02004238 */  xori       $v0, $v0, 0x2
    /* E8434 800F7C34 10DF0308 */  j          .L800F7C40
    /* E8438 800F7C38 0100422C */   sltiu     $v0, $v0, 0x1
  .L800F7C3C:
    /* E843C 800F7C3C 21100000 */  addu       $v0, $zero, $zero
  .L800F7C40:
    /* E8440 800F7C40 3400BF8F */  lw         $ra, 0x34($sp)
    /* E8444 800F7C44 3000BE8F */  lw         $fp, 0x30($sp)
    /* E8448 800F7C48 2C00B78F */  lw         $s7, 0x2C($sp)
    /* E844C 800F7C4C 2800B68F */  lw         $s6, 0x28($sp)
    /* E8450 800F7C50 2400B58F */  lw         $s5, 0x24($sp)
    /* E8454 800F7C54 2000B48F */  lw         $s4, 0x20($sp)
    /* E8458 800F7C58 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E845C 800F7C5C 1800B28F */  lw         $s2, 0x18($sp)
    /* E8460 800F7C60 1400B18F */  lw         $s1, 0x14($sp)
    /* E8464 800F7C64 1000B08F */  lw         $s0, 0x10($sp)
    /* E8468 800F7C68 0800E003 */  jr         $ra
    /* E846C 800F7C6C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CdControlB
