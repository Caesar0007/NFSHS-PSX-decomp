.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___6Speech, 0xB4

glabel ___6Speech
    /* 86330 80095B30 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 86334 80095B34 1800B2AF */  sw         $s2, 0x18($sp)
    /* 86338 80095B38 21908000 */  addu       $s2, $a0, $zero
    /* 8633C 80095B3C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 86340 80095B40 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 86344 80095B44 1400B1AF */  sw         $s1, 0x14($sp)
    /* 86348 80095B48 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8634C 80095B4C 6C03428E */  lw         $v0, 0x36C($s2)
    /* 86350 80095B50 00000000 */  nop
    /* 86354 80095B54 06004010 */  beqz       $v0, .L80095B70
    /* 86358 80095B58 2198A000 */   addu      $s3, $a1, $zero
    /* 8635C 80095B5C 80AD030C */  jal        SPCH_Deinit
    /* 86360 80095B60 00000000 */   nop
    /* 86364 80095B64 6C03448E */  lw         $a0, 0x36C($s2)
    /* 86368 80095B68 5095030C */  jal        purgememadr
    /* 8636C 80095B6C 00000000 */   nop
  .L80095B70:
    /* 86370 80095B70 6403428E */  lw         $v0, 0x364($s2)
    /* 86374 80095B74 00000000 */  nop
    /* 86378 80095B78 04004010 */  beqz       $v0, .L80095B8C
    /* 8637C 80095B7C 00000000 */   nop
    /* 86380 80095B80 6803448E */  lw         $a0, 0x368($s2)
    /* 86384 80095B84 54AA030C */  jal        FILE_closesync
    /* 86388 80095B88 64000524 */   addiu     $a1, $zero, 0x64
  .L80095B8C:
    /* 8638C 80095B8C A003448E */  lw         $a0, 0x3A0($s2)
    /* 86390 80095B90 6B8F020C */  jal        __builtin_delete
    /* 86394 80095B94 21880000 */   addu      $s1, $zero, $zero
    /* 86398 80095B98 21804002 */  addu       $s0, $s2, $zero
  .L80095B9C:
    /* 8639C 80095B9C 9003048E */  lw         $a0, 0x390($s0)
    /* 863A0 80095BA0 04001026 */  addiu      $s0, $s0, 0x4
    /* 863A4 80095BA4 6B8F020C */  jal        __builtin_delete
    /* 863A8 80095BA8 01003126 */   addiu     $s1, $s1, 0x1
    /* 863AC 80095BAC 0400222A */  slti       $v0, $s1, 0x4
    /* 863B0 80095BB0 FAFF4014 */  bnez       $v0, .L80095B9C
    /* 863B4 80095BB4 01006232 */   andi      $v0, $s3, 0x1
    /* 863B8 80095BB8 03004010 */  beqz       $v0, .L80095BC8
    /* 863BC 80095BBC 00000000 */   nop
    /* 863C0 80095BC0 6B8F020C */  jal        __builtin_delete
    /* 863C4 80095BC4 21204002 */   addu      $a0, $s2, $zero
  .L80095BC8:
    /* 863C8 80095BC8 2000BF8F */  lw         $ra, 0x20($sp)
    /* 863CC 80095BCC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 863D0 80095BD0 1800B28F */  lw         $s2, 0x18($sp)
    /* 863D4 80095BD4 1400B18F */  lw         $s1, 0x14($sp)
    /* 863D8 80095BD8 1000B08F */  lw         $s0, 0x10($sp)
    /* 863DC 80095BDC 0800E003 */  jr         $ra
    /* 863E0 80095BE0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ___6Speech
